using Dispatch_System;
using DocumentFormat.OpenXml.Office2010.Excel;
using Microsoft.Extensions.Logging;
using MySql.Data.MySqlClient;
using Newtonsoft.Json;
using Oracle.ManagedDataAccess.Client;
using Org.BouncyCastle.Utilities.Encoders;
using System;
using System.Collections.Concurrent;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Net;
using System.Net.Sockets;
using System.Text;
using System.Text.RegularExpressions;
using System.Threading;

namespace VendorQRGeneration.Infra.Services
{
	public class SocketBackgroundTask
	{
		private string regexPattern { get; set; }

		private CancellationTokenSource _cancellationTokenSource;
		private Task _backgroundTask;
		//private long _sequenceNumber;
		private bool _isRunning;
		private bool _isStopSignal;
		private bool _isStopSignal_FromMachine;
		private string _errorMessage;
		private (string QRCode, string result, long Ticks) _receivedData_Prev;

		private readonly SharedDataService _sharedDataService;
		private Socket listenerSocket;
		private readonly Socket printerSocket;
		private readonly byte[] _buffer = new byte[1024];

		private Socket clientSocket = null;


		private int MDA_QR_Scan_Delay_Sec = 1;
		private int cnt_error = 0;
		private Int64 PLANT_ID { get; set; }


		private MDA_Dtls mda { get; set; }


		private string iffco_url { get; set; }


		public SocketBackgroundTask(SharedDataService sharedDataService)
		{
			PLANT_ID = Common.Get_Session_Int(SessionKey.PLANT_ID);

			_sharedDataService = sharedDataService;
			printerSocket = new Socket(AddressFamily.InterNetwork, SocketType.Stream, ProtocolType.Tcp);

			iffco_url = AppHttpContextAccessor.IFFCO_Domain.TrimEnd('/');

			regexPattern = Regex.Escape(iffco_url) + @"[^\s]+";
		}

		public void IsRunning_Stop(bool value) { _isRunning = value; try { clientSocket = null; _backgroundTask = null; } catch { } }
		public bool IsRunning() => _isRunning && (clientSocket != null && IsConnected(clientSocket) && (_backgroundTask != null && !_backgroundTask.IsCompleted));
		public string ErrorMessage() => _errorMessage;
		public void SetMDA(MDA_Dtls _mda) => mda = _mda;
		public MDA_Dtls GetMDA() => mda;

		public async Task SendToPrinter(string V1, string V2, string V3)
		{
			Write_Log($"Printer : Data to Send => V1 : {V1}, V2 : {V2}, V3 : {V3} ");

			IPAddress listenIP;
			int listenPort;

			string listenIPString = Convert.ToString(AppHttpContextAccessor.AppConfiguration.GetSection("Printer_IP").Value ?? "");
			string listenPortString = Convert.ToString(AppHttpContextAccessor.AppConfiguration.GetSection("Printer_Port").Value ?? "");

			if (Regex.IsMatch((listenIPString ?? ""), @"^((25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.){3}(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)$")
				&& IPAddress.TryParse(listenIPString, out listenIP) && int.TryParse(listenPortString, out listenPort) && listenPort > 0 && listenPort <= 65535)
			{
				try
				{
					Write_Log(System.Environment.NewLine);

					// Connect to the server
					using var client = new TcpClient();
					await client.ConnectAsync(listenIP, listenPort);

					Write_Log("Printer : Connected to the server.");
					Write_Log($"Printer : Listening on Address {listenIP.ToString()}:{listenPort}..." + System.Environment.NewLine);

					// Get the network stream for writing data to the server
					using NetworkStream stream = client.GetStream();

					// Format the data to be sent
					string dataToSend = "\x02" + "041C1E1Q0R1" + "\x17" + "D" + $"{V1}" + "\x0A" + $"{V2}" + "\x0A" + $"{V3}??" + "\x0D";

					Write_Log($"Printer : Data to Send => {dataToSend} | " + (mda != null ? " MDA Id : " + mda.Mda_Id + " Gate In/Out Id : " + mda.GateInOut_Id + " | " : ""));

					// Convert the string data to bytes
					byte[] buffer = Encoding.UTF8.GetBytes(dataToSend);

					// Send the data to the server
					await stream.WriteAsync(buffer, 0, buffer.Length);

					Write_Log("Printer : Data sent to the server.");

					// Disconnect from the server
					client.Close();

				}
				catch (Exception ex)
				{
					Write_Log($"Printer : Error => {JsonConvert.SerializeObject(ex)}");

					throw ex;
				}
			}
		}

		public async Task StartWork()
		{
			cnt_error = 0;

			if (mda.Required_Shipper <= mda.Loaded_Shipper)
			{
				//_sharedDataService.AddOrUpdate(Interlocked.Increment(ref _sequenceNumber), "", "COMPLETED", 0, (long)mda.Required_Shipper, (long)mda.Loaded_Shipper, (long)mda.Carton_Qty);
				_sharedDataService.AddOrUpdate("", "COMPLETED", 0, (long)mda.Required_Shipper, (long)mda.Loaded_Shipper, (long)mda.Carton_Qty);

				return;
			}

			_receivedData_Prev = new("123", "", DateTime.Now.Ticks);

			Write_Log($"MC Start Request");

			MDA_QR_Scan_Delay_Sec = Convert.ToInt32(AppHttpContextAccessor.AppConfiguration.GetSection("MDA_QR_Scan_Delay_Sec").Value ?? "1");

			IsRunning_Stop(false);
			_isStopSignal = false;

			IPAddress listenIP;
			int listenPort;

			string listenIPString = Convert.ToString(AppHttpContextAccessor.AppConfiguration.GetSection("Listen_IP").Value ?? "");
			string listenPortString = Convert.ToString(AppHttpContextAccessor.AppConfiguration.GetSection("Listen_Port").Value ?? "");

			if (Regex.IsMatch((listenIPString ?? ""), @"^((25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.){3}(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)$")
				&& IPAddress.TryParse(listenIPString, out listenIP) && int.TryParse(listenPortString, out listenPort) && listenPort > 0 && listenPort <= 65535)
			{
				//if (!_isRunning)
				try
				{
					if (listenerSocket == null)
						listenerSocket = new Socket(AddressFamily.InterNetwork, SocketType.Stream, ProtocolType.Tcp);

					listenerSocket.Bind(new IPEndPoint(listenIP, listenPort));
					listenerSocket.Listen(10);

					Write_Log($"Listen is listening on Address {listenIP.ToString()}:{listenPort}..." + System.Environment.NewLine);
				}
				catch (Exception ex)
				{
					Write_Log($"Listener Socket Error: {JsonConvert.SerializeObject(ex)}");
					return;
				}

				try
				{
					clientSocket = clientSocket != null && IsConnected(clientSocket) ? clientSocket : listenerSocket.Accept();

					Write_Log("Connected to sender : " + clientSocket.RemoteEndPoint);
					Write_Log($"Checking for data");

				}
				catch (Exception ex)
				{
					Write_Log($"Client Socket Error: {JsonConvert.SerializeObject(ex)}");
					return;
				}

				if (clientSocket != null && IsConnected(clientSocket))
				{
					clientSocket.Send(Encoding.ASCII.GetBytes("STOP"));
					Thread.Sleep(1000);
					clientSocket.Send(Encoding.ASCII.GetBytes("START"));
				}

				//_sequenceNumber = (_sharedDataService.GetScanData() != null && _sharedDataService.GetScanData().Count() > 0 ? _sharedDataService.GetScanData().Max(x => x.Key) : 0);

				LogService.LogInsert("Load MDA " + AppHttpContextAccessor.Loading_Bay, "Start Loading | " + (mda != null ? " MDA Id : " + mda.Mda_Id + " Gate In/Out Id : " + mda.GateInOut_Id : ""));

				// Create a cancellation token source
				_cancellationTokenSource = new CancellationTokenSource();

				// Start a background task
				if (clientSocket != null && IsConnected(clientSocket) && (_backgroundTask == null || _backgroundTask.IsCompleted))
					_backgroundTask = Task.Run(BackgroundTaskAsync, _cancellationTokenSource.Token);

			}
			else
			{
				Write_Log($"Invalid Data => Listen_IP : {listenIPString} Listen_Port : {listenPortString}");
				LogService.LogInsert("Load MDA " + AppHttpContextAccessor.Loading_Bay, $"Invalid Data => Listen_IP : {listenIPString} Listen_Port : {listenPortString} | " + (mda != null ? " MDA Id : " + mda.Mda_Id + " Gate In/Out Id : " + mda.GateInOut_Id + " | " : ""));
			}

		}

		public void StopWork()
		{
			cnt_error = 0;

			_isStopSignal = true;

			if (clientSocket != null && IsConnected(clientSocket) && (_backgroundTask != null && !_backgroundTask.IsCompleted))
				clientSocket.Send(Encoding.ASCII.GetBytes("STOP"));
			//try { clientSocket.Send(Encoding.ASCII.GetBytes("STOP")); } catch { }
			else if (clientSocket == null || !IsConnected(clientSocket) || _backgroundTask == null || _backgroundTask.IsCompleted)
				_isRunning = false;
		}

		private async Task BackgroundTaskAsync()
		{
			while (!_cancellationTokenSource.Token.IsCancellationRequested)
			{
				try
				{
					if (clientSocket == null || !IsConnected(clientSocket))
					{
						_isRunning = false;
						return;
					}

					var received = await clientSocket.ReceiveAsync(_buffer, SocketFlags.None);

					var receivedData = Encoding.UTF8.GetString(_buffer, 0, received);

					Write_Log($"Socket server received message Before Split : \"{receivedData}\"");

					receivedData = receivedData.Replace(" ", "").Trim();

					if (receivedData.ToUpper() != "<#>") receivedData = receivedData.Replace("<#>", "");

					if (!string.IsNullOrEmpty(receivedData) && Regex.Match(receivedData, regexPattern).Success)
					{
						receivedData = receivedData.Replace("<#>", "");

						receivedData = Regex.Match(receivedData, regexPattern).Value;

						receivedData = receivedData.Substring(receivedData.IndexOf(iffco_url));

						var strQR = receivedData.Replace(iffco_url, "");

						StringBuilder sb = new StringBuilder(strQR);

						if (strQR.IndexOf("/") > -1)
						{
							sb[strQR.IndexOf("/")] = '(';
							strQR = sb.ToString();
						}
						if (strQR.IndexOf("/") > -1)
						{
							sb[strQR.IndexOf("/")] = ')';
							strQR = sb.ToString();
						}
						if (strQR.IndexOf("/") > -1)
						{
							sb[strQR.IndexOf("/")] = '(';
							strQR = sb.ToString();
						}
						if (strQR.IndexOf("/") > -1)
						{
							sb[strQR.IndexOf("/")] = ')';
							strQR = sb.ToString();
						}

						receivedData = sb.ToString();
						receivedData = Regex.Replace(receivedData, @"[^\w:/\(/\)\.\-]", "");

						receivedData = receivedData.Replace("MCIDEL", "");
						receivedData = receivedData.Replace("MCSTART", "");
						receivedData = receivedData.Replace("MCSTOP", "");
					}
					else if (!string.IsNullOrEmpty(receivedData) && !Regex.Match(receivedData, regexPattern).Success
						&& receivedData.ToUpper() != "<#>" && receivedData.ToUpper() != "<@>"
							&& !receivedData.ToUpper().Contains("MCSTART") && !receivedData.ToUpper().Contains("MCSTOP")
							&& !receivedData.ToUpper().Contains("MCIDEL")
							)
					{
						Write_Log($"Socket server received message After Split : \"{receivedData}\"");

						receivedData = "0000000000";
					}

					Write_Log($"Socket server received message After Split : \"{receivedData}\"");

					if (!_isRunning && !_isStopSignal && !string.IsNullOrEmpty(receivedData)
					&& (receivedData.ToUpper().Contains("MCSTART") || receivedData.ToUpper().Contains("MCIDEL")
					|| receivedData.Trim().Length > 0) && !receivedData.ToUpper().Contains("MCSTOP"))
						_isRunning = true;

					if (_isRunning && _isStopSignal && !string.IsNullOrEmpty(receivedData)
						&& receivedData.ToUpper().Contains("MCSTOP"))
					{
						try
						{
							Write_Log($"MC Stop Request");

							try { clientSocket.Shutdown(SocketShutdown.Both); } catch { }
							try { clientSocket.Close(); } catch { }
							try { clientSocket.Dispose(); } catch { }

							// Close the socket when the background task is stopped
							try { listenerSocket.Shutdown(SocketShutdown.Both); } catch { }
							try { listenerSocket.Close(); } catch { }
							try { listenerSocket.Dispose(); } catch { }

							clientSocket = null;
							listenerSocket = null;
						}
						catch { }

						_isRunning = false;
						_isStopSignal = false;

						//_sharedDataService.AddOrUpdate(Interlocked.Increment(ref _sequenceNumber), receivedData, "STOP", 0, (long)mda.Required_Shipper, (long)mda.Loaded_Shipper, (long)mda.Carton_Qty);
						_sharedDataService.AddOrUpdate(receivedData, "STOP", 0, (long)mda.Required_Shipper, (long)mda.Loaded_Shipper, (long)mda.Carton_Qty);

						LogService.LogInsert("Load MDA " + AppHttpContextAccessor.Loading_Bay, "Stop Loading | " + (mda != null ? " MDA Id : " + mda.Mda_Id + " Gate In/Out Id : " + mda.GateInOut_Id : ""));

						_cancellationTokenSource?.Cancel();
					}
					else if (_isRunning && _isStopSignal && !string.IsNullOrEmpty(receivedData) && !receivedData.ToUpper().Contains("MCSTOP"))
						continue;

					if (_isRunning && !_isStopSignal && !string.IsNullOrEmpty(receivedData) && !receivedData.ToUpper().Contains("MCIDEL")
						&& !receivedData.ToUpper().Contains("MCSTOP") && !receivedData.ToUpper().Contains("MCSTART")
					)
					{
						//if (!string.IsNullOrEmpty(_receivedData_Prev.QRCode)
						//    && _receivedData_Prev.QRCode == receivedData
						//    && (_receivedData_Prev.Ticks - DateTime.Now.Ticks) < 100000000)
						//{
						//    //clientSocket.Send(Encoding.ASCII.GetBytes("NOK"));
						//    continue;
						//}

						Write_Log($"Prev Data : {_receivedData_Prev.QRCode} {_receivedData_Prev.result} {Environment.NewLine} " +
							$"| Current Data : {receivedData} {Environment.NewLine}" +
							$"Prev Data Difference in seconds : {(DateTime.Now - (new DateTime(_receivedData_Prev.Ticks))).TotalSeconds}");

						if (receivedData.ToUpper().Trim() == "<#>" || (_receivedData_Prev.QRCode == receivedData
							&& (_receivedData_Prev.QRCode != "0000000000" && _receivedData_Prev.result != "")
							&& (DateTime.Now - (new DateTime(_receivedData_Prev.Ticks))).TotalSeconds <= 6))
						{
							Write_Log($"Skip record => Prev Data : {_receivedData_Prev.QRCode} {_receivedData_Prev.result} {Environment.NewLine} " +
								$"| Current Data : {receivedData} {Environment.NewLine}" +
								$"Prev Data Difference in seconds : {(DateTime.Now - (new DateTime(_receivedData_Prev.Ticks))).TotalSeconds} ");
							continue;
						}

						if (receivedData.ToUpper().Trim() == "<@>"
							&& (_receivedData_Prev.QRCode == " 00000000000" && _receivedData_Prev.result != ""))
						{
							Write_Log($"Skip record => Prev Data : {_receivedData_Prev.QRCode} {_receivedData_Prev.result} {Environment.NewLine} " +
								$"| Current Data : {receivedData} {Environment.NewLine}" +
								$"Prev Data Difference in seconds : {(DateTime.Now - (new DateTime(_receivedData_Prev.Ticks))).TotalSeconds} ");
							continue;
						}

						var sendResponse = true;

						if (receivedData.ToUpper().Trim() == "<@>")
						{
							sendResponse = false;
							receivedData = " 00000000000";
						}

						_receivedData_Prev = new(receivedData, "", DateTime.Now.Ticks);

						var (IsSuccess, response, Id) = (false, "NOK", 0M);

						if (!receivedData.ToUpper().Contains("MCIDEL") && !receivedData.ToUpper().Contains("MCSTOP")
							&& !receivedData.ToUpper().Contains("MCSTART") && receivedData.ToUpper().Length > 0)
						{
							receivedData = receivedData.Trim();

							if (PLANT_ID <= 0) PLANT_ID = AppHttpContextAccessor.PlantId;

							List<MySqlParameter> oParams = new List<MySqlParameter>();

							oParams.Add(new MySqlParameter("P_LOADING_BAY", MySqlDbType.VarString) { Value = AppHttpContextAccessor.Loading_Bay });
							oParams.Add(new MySqlParameter("P_QR_CODE", MySqlDbType.VarString) { Value = receivedData });
							oParams.Add(new MySqlParameter("P_GATE_SYS_ID", MySqlDbType.Int64) { Value = mda.GateInOut_Id });
							oParams.Add(new MySqlParameter("P_MDA_SYS_ID", MySqlDbType.Int64) { Value = mda.Mda_Id });
							oParams.Add(new MySqlParameter("P_MDA_DTL_SYS_ID", MySqlDbType.Int64) { Value = mda.Id });
							oParams.Add(new MySqlParameter("P_PROD_SYS_ID", MySqlDbType.Int64) { Value = mda.Prod_Sys_Id });
							oParams.Add(new MySqlParameter("P_IS_MANUAL_SCAN", MySqlDbType.Int64) { Value = 0 });
							oParams.Add(new MySqlParameter("P_PLANT_ID", MySqlDbType.Int64) { Value = PLANT_ID });

							(IsSuccess, response, Id) = DataContext.ExecuteStoredProcedure_SQL("PC_SHIPPER_QRCODE_CHECK", oParams, true);
						}

						Write_Log($"Response | {(mda != null ? " MDA Id : " + mda.Mda_Id + " Gate In/Out Id : " + mda.GateInOut_Id : "")} : {response} ");

						if (!string.IsNullOrEmpty(receivedData)
							&& !receivedData.ToUpper().Contains("MCIDEL")
							&& !receivedData.ToUpper().Contains("MCSTOP")
							&& !receivedData.ToUpper().Contains("MCSTART")
							&& receivedData.ToUpper().Length > 0)
						{
							receivedData = receivedData.Trim();

							if (response.Contains("#"))
							{
								if (sendResponse == true)
								{
									clientSocket.Send(Encoding.ASCII.GetBytes(response.Split("#")[0].ToString()));
									Write_Log($"Send to PLC : \"{response.Split("#")[0].ToString()}\"");
									Thread.Sleep(100);
									clientSocket.Send(Encoding.ASCII.GetBytes(" "));
								}

								_receivedData_Prev.result = response.Split("#")[0].ToString();

								mda.Required_Shipper = Convert.ToInt64(response.Split("#")[1]);
								mda.Loaded_Shipper = Convert.ToInt64(response.Split("#")[2]);
								mda.Carton_Qty = Convert.ToInt64(response.Split("#")[3]);

								//_sharedDataService.AddOrUpdate(Interlocked.Increment(ref _sequenceNumber), receivedData, response.Split("#")[0].ToString(), (long)Id, (long)mda.Required_Shipper, (long)mda.Loaded_Shipper, (long)mda.Carton_Qty);
								_sharedDataService.AddOrUpdate(receivedData, response.Split("#")[0].ToString(), (long)Id, (long)mda.Required_Shipper, (long)mda.Loaded_Shipper, (long)mda.Carton_Qty);

								if (mda.Required_Shipper <= mda.Loaded_Shipper)
								{
									//_sharedDataService.AddOrUpdate(Interlocked.Increment(ref _sequenceNumber), receivedData, "COMPLETED", (long)Id, (long)mda.Required_Shipper, (long)mda.Loaded_Shipper, (long)mda.Carton_Qty);
									_sharedDataService.AddOrUpdate(receivedData, "COMPLETED", (long)Id, (long)mda.Required_Shipper, (long)mda.Loaded_Shipper, (long)mda.Carton_Qty);

									LogService.LogInsert("Load MDA " + AppHttpContextAccessor.Loading_Bay, "MDA Completed | " + (mda != null ? " MDA Id : " + mda.Mda_Id + " Gate In/Out Id : " + mda.GateInOut_Id : ""));
								}
							}
							else
							{
								if (clientSocket != null && IsConnected(clientSocket))
								{
									_receivedData_Prev.result = "NOK";

									if (sendResponse == true)
									{
										clientSocket.Send(Encoding.ASCII.GetBytes("NOK"));
										Thread.Sleep(100);
										clientSocket.Send(Encoding.ASCII.GetBytes(" "));
										Write_Log($"Send to PLC (Procedure Error) : \"NOK\"");
									}

									mda.Carton_Qty = (long)mda.Carton_Qty + 1;

									//_sharedDataService.AddOrUpdate(Interlocked.Increment(ref _sequenceNumber), receivedData, "NOK", (long)0, (long)mda.Required_Shipper, (long)mda.Loaded_Shipper, (long)mda.Carton_Qty);
									_sharedDataService.AddOrUpdate(receivedData, "NOK", (long)0, (long)mda.Required_Shipper, (long)mda.Loaded_Shipper, (long)mda.Carton_Qty);
								}
							}
						}
						//else
						//{
						//	if (clientSocket != null && IsConnected(clientSocket))
						//	{
						//		if (sendResponse == true)
						//			clientSocket.Send(Encoding.ASCII.GetBytes("NOK"));

						//		mda.Carton_Qty = (long)mda.Carton_Qty + 1;

						//		_sharedDataService.AddOrUpdate(Interlocked.Increment(ref _sequenceNumber), "##########", "NOK", (long)0, (long)mda.Required_Shipper, (long)mda.Loaded_Shipper, (long)mda.Carton_Qty);
						//	}
						//}
					}

					receivedData = "";

					Thread.Sleep(MDA_QR_Scan_Delay_Sec * 1000);

					try { _cancellationTokenSource.Token.ThrowIfCancellationRequested(); }
					catch (Exception) { }
				}
				catch (Exception ex)
				{
					cnt_error += 1;

					//if (clientSocket != null && IsConnected(clientSocket))
					//{
					//	clientSocket.Send(Encoding.ASCII.GetBytes("NOK"));

					//	mda.Carton_Qty = (long)mda.Carton_Qty + 1;

					//	_sharedDataService.AddOrUpdate(Interlocked.Increment(ref _sequenceNumber), "##########", "NOK", (long)0, (long)mda.Required_Shipper, (long)mda.Loaded_Shipper, (long)mda.Carton_Qty);
					//}

					if (cnt_error > 10)
					{
						cnt_error = 0;

						_isStopSignal = true;

						_errorMessage = $"{JsonConvert.SerializeObject(ex)}";
					}

					Write_Log("Load MDA " + AppHttpContextAccessor.Loading_Bay + " " + (mda != null ? " MDA Id : " + mda.Mda_Id + " Gate In/Out Id : " + mda.GateInOut_Id + " | " : "")
						+ $"Error BTA : {JsonConvert.SerializeObject(ex)}");

					LogService.LogInsert("Load MDA " + AppHttpContextAccessor.Loading_Bay, (mda != null ? " MDA Id : " + mda.Mda_Id + " Gate In/Out Id : " + mda.GateInOut_Id + " | " : "")
						+ $"Error BTA : {JsonConvert.SerializeObject(ex)}");

					continue;
				}

			}

		}

		private static bool IsConnected(Socket socket)
		{
			try
			{
				return !(socket.Poll(1, SelectMode.SelectRead) && socket.Available == 0);
			}
			catch (SocketException) { return false; }
		}


		private void Write_Log(string text)
		{
			try
			{
				if (!string.IsNullOrEmpty(text))
				{
					string filePath = Convert.ToString(AppHttpContextAccessor.AppConfiguration.GetSection("MDA_QR_Scan_Log_File_Path").Value ?? "C:\\Z_Project_Dispatch_System\\Logs\\<YYYYMMDD>\\MDA_QR_Scan_<HH>.txt");

					//filePath = filePath.Replace("#", DateTime.Now.ToString("yyyyMMdd_HH"));

					filePath = filePath.Replace("<YYYYMMDD>", DateTime.Now.ToString("yyyyMMdd"));
					filePath = filePath.Replace("<HH>", DateTime.Now.ToString("HH"));

					if (!System.IO.Directory.Exists(Path.GetDirectoryName(filePath)))
						System.IO.Directory.CreateDirectory(Path.GetDirectoryName(filePath));

					if (!System.IO.File.Exists(filePath))
						System.IO.File.Create(filePath).Dispose();

					using (StreamWriter sw = System.IO.File.AppendText(filePath))
						sw.WriteLine(DateTime.Now.ToString("dd/MM/yyyy hh:mm:ss tt") + " || " + text + System.Environment.NewLine);

					Console.WriteLine(DateTime.Now.ToString("dd/MM/yyyy hh:mm:ss tt") + " || " + text + System.Environment.NewLine);
				}
			}
			catch (Exception ex) { }
		}
	}

	public class SharedDataService
	{
		private readonly ConcurrentDictionary<long, (string qr_code, string flag, Int64 id, Int64 requiredShipper, Int64 loaddedShipper, Int64 rejectShipper)>
			_sharedData = new ConcurrentDictionary<long, (string qr_code, string flag, Int64 id, Int64 requiredShipper, Int64 loaddedShipper, Int64 rejectShipper)>();

		private long _lastKey = 0; // Tracks the last used key

		// Public read-only property for the last used key
		public long LastKey => _lastKey;

		// Method to increment the last key
		public long IncrementLastKey()
		{
			return System.Threading.Interlocked.Increment(ref _lastKey); // Safely increment key
		}

		public long AddOrUpdate(string value, string flag, Int64 id, Int64 requiredShipper, Int64 loaddedShipper, Int64 rejectShipper)
		{
			long newKey = IncrementLastKey(); // Use the new method to get the key

			// Use TryAdd to add the new entry with the new unique key
			_sharedData.TryAdd(newKey, (value, flag, id, requiredShipper, loaddedShipper, rejectShipper));

			return newKey; // Return the new key
		}

		public void AddOrUpdate(List<(string value, string flag, Int64 id, Int64 requiredShipper, Int64 loaddedShipper, Int64 rejectShipper)> values)
		{
			foreach (var item in values)
			{
				long newKey = IncrementLastKey(); // Use the new method to get the key

				// Use TryAdd to add the new entry with the new unique key
				_sharedData.TryAdd(newKey, (item.value, item.flag, item.id, item.requiredShipper, item.loaddedShipper, item.rejectShipper));
			}
		}

		public (string qr_code, string flag, Int64 id, Int64 requiredShipper, Int64 loaddedShipper, Int64 rejectShipper) GetValue(long key)
		{
			_sharedData.TryGetValue(key, out var value);
			return value;
		}

		public ConcurrentDictionary<long, (string qr_code, string flag, Int64 id, Int64 requiredShipper, Int64 loaddedShipper, Int64 rejectShipper)> GetScanData() => _sharedData;

		public void ClearScanData() { _sharedData.Clear(); _lastKey = 0; }

		public void RemoveByKey(long key) { _sharedData.Remove(key, out var _); }
		public void UpdateByKey(long key, (string qr_code, string flag, Int64 id, Int64 requiredShipper, Int64 loaddedShipper, Int64 rejectShipper) newValue)
		{
			if (_sharedData.ContainsKey(key))
				_sharedData[key] = newValue;
		}
	}


	//public class SharedDataService
	//{
	//	private ConcurrentDictionary<long, (string qr_code, string flag, Int64 id, Int64 requiredShipper, Int64 loaddedShipper, Int64 rejectShipper)>
	//		_sharedData = new ConcurrentDictionary<long, (string qr_code, string flag, Int64 id, Int64 requiredShipper, Int64 loaddedShipper, Int64 rejectShipper)>();

	//	public void AddOrUpdate(long key, string value, string flag, Int64 id, Int64 requiredShipper, Int64 loaddedShipper, Int64 rejectShipper)
	//	{
	//		if (_sharedData.ContainsKey(key))
	//		{
	//			_sharedData[key] = (value, flag, id, requiredShipper, loaddedShipper, rejectShipper);
	//		}
	//		else
	//		{
	//			_sharedData.TryAdd(key, (value, flag, id, requiredShipper, loaddedShipper, rejectShipper));
	//		}
	//	}

	//	public void AddOrUpdate(List<(long key, string value, string flag, Int64 id, Int64 requiredShipper, Int64 loaddedShipper, Int64 rejectShipper)> values)
	//	{
	//		foreach (var item in values)
	//			if (_sharedData.ContainsKey(item.key))
	//			{
	//				_sharedData[item.key] = (item.value, item.flag, item.id, item.requiredShipper, item.loaddedShipper, item.rejectShipper);
	//			}
	//			else
	//			{
	//				_sharedData.TryAdd(item.key, (item.value, item.flag, item.id, item.requiredShipper, item.loaddedShipper, item.rejectShipper));
	//			}
	//	}

	//	public (string qr_code, string flag, Int64 id, Int64 requiredShipper, Int64 loaddedShipper, Int64 rejectShipper) GetValue(long key)
	//	{
	//		_sharedData.TryGetValue(key, out var value);
	//		return value;
	//	}

	//	public ConcurrentDictionary<long, (string qr_code, string flag, Int64 id, Int64 requiredShipper, Int64 loaddedShipper, Int64 rejectShipper)> GetScanData() => _sharedData;

	//	public void ClearScanData() { _sharedData = new ConcurrentDictionary<long, (string qr_code, string flag, Int64 id, Int64 requiredShipper, Int64 loaddedShipper, Int64 rejectShipper)>(); }
	//}
}
