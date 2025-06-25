using Dispatch_System;
using DocumentFormat.OpenXml.Bibliography;
using DocumentFormat.OpenXml.Office2010.Excel;
using DocumentFormat.OpenXml.Presentation;
using iTextSharp.testutils;
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
		private CancellationTokenSource _cancellationTokenSource;
		private Task _backgroundTask;
		private long _sequenceNumber;
		private bool _isRunning;
		private bool _isStopSignal;
		private string _errorMessage;
		private (string QRCode, string State, DateTime DT) _receivedData_Prev;

		private readonly SharedDataService _sharedDataService;
		private readonly Socket listenerSocket;
		private readonly Socket printerSocket;
		private readonly byte[] _buffer = new byte[1024];

		private Socket clientSocket = null;


		private int MDA_QR_Scan_Delay_Sec = 1;
		private int cnt_error = 0;
		private Int64 PLANT_ID { get; set; }


		private MDA_Dtls mda { get; set; }
		private string filePath { get; set; }
		private bool MDA_QR_Scan_Log_IsActive { get; set; }


		private bool MDA_QR_Scan_Response_Demo { get; set; }
		private string iffco_url { get; set; }


		public SocketBackgroundTask(SharedDataService sharedDataService)
		{
			PLANT_ID = Common.Get_Session_Int(SessionKey.PLANT_ID);

			_sharedDataService = sharedDataService;
			listenerSocket = new Socket(AddressFamily.InterNetwork, SocketType.Stream, ProtocolType.Tcp);
			printerSocket = new Socket(AddressFamily.InterNetwork, SocketType.Stream, ProtocolType.Tcp);

			try { MDA_QR_Scan_Log_IsActive = Convert.ToBoolean(AppHttpContextAccessor.AppConfiguration.GetSection("MDA_QR_Scan_Log_IsActive").Value); }
			catch { MDA_QR_Scan_Log_IsActive = false; }

			try { MDA_QR_Scan_Response_Demo = Convert.ToBoolean(AppHttpContextAccessor.AppConfiguration.GetSection("MDA_QR_Scan_Response_Demo").Value); }
			catch { MDA_QR_Scan_Response_Demo = false; }

			try { MDA_QR_Scan_Delay_Sec = Convert.ToInt32(AppHttpContextAccessor.AppConfiguration.GetSection("MDA_QR_Scan_Delay_Sec").Value ?? "1"); }
			catch { MDA_QR_Scan_Delay_Sec = 2; }

			try { filePath = Convert.ToString(AppHttpContextAccessor.AppConfiguration.GetSection("MDA_QR_Scan_Log_File_Path").Value ?? "MDA_QR_Scan_#.txt"); }
			catch { filePath = "C:\\Z_Project_Dispatch_System\\Logs\\<YYYYMMDD>\\MDA_QR_Scan_<HH>.txt"; }


			iffco_url = AppHttpContextAccessor.IFFCO_Domain.TrimEnd('/');

		}

		public bool IsRunning() => _isRunning && (clientSocket != null && IsConnected(clientSocket) && (_backgroundTask != null && !_backgroundTask.IsCompleted));
		public string ErrorMessage() => _errorMessage;
		public void SetMDA(MDA_Dtls _mda) => mda = _mda;
		public MDA_Dtls GetMDA() => mda;

		public async Task SendToPrinter(string V1, string V2, string V3)
		{
			IPAddress listenIP;
			int listenPort;

			string listenIPString = Convert.ToString(AppHttpContextAccessor.AppConfiguration.GetSection("Printer_IP").Value ?? "");
			string listenPortString = Convert.ToString(AppHttpContextAccessor.AppConfiguration.GetSection("Printer_Port").Value ?? "");

			if (Regex.IsMatch((listenIPString ?? ""), @"^((25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.){3}(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)$")
				&& IPAddress.TryParse(listenIPString, out listenIP) && int.TryParse(listenPortString, out listenPort) && listenPort > 0 && listenPort <= 65535)
			{
				try
				{
					// Connect to the server
					using var client = new TcpClient();
					await client.ConnectAsync(listenIP, listenPort);

					Console.WriteLine("Connected to the server.");

					// Get the network stream for writing data to the server
					using NetworkStream stream = client.GetStream();

					// Format the data to be sent
					string dataToSend = "\x02" + "041C1E1Q0R1" + "\x17" + "D" + $"{V1}" + "\x0A" + $"{V2}" + "\x0A" + $"{V3}??" + "\x0D";

					LogService.LogInsert("Load MDA " + AppHttpContextAccessor.Loading_Bay, "Send To Printer | " + (mda != null ? " MDA Id : " + mda.Mda_Id + " Gate In/Out Id : " + mda.GateInOut_Id + " | " : "") + dataToSend);

					// Convert the string data to bytes
					byte[] buffer = Encoding.UTF8.GetBytes(dataToSend);

					// Send the data to the server
					await stream.WriteAsync(buffer, 0, buffer.Length);

					Console.WriteLine("Data sent to the server.");

					// Disconnect from the server
					client.Close();

					Console.WriteLine($"listen is listening on Address {listenIP.ToString()}:{listenPort}...");
				}
				catch (Exception ex)
				{
					Console.WriteLine($"Error: {JsonConvert.SerializeObject(ex)}");

					LogService.LogInsert("Load MDA " + AppHttpContextAccessor.Loading_Bay, "Send To Printer | " + (mda != null ? " MDA Id : " + mda.Mda_Id + " Gate In/Out Id : " + mda.GateInOut_Id + " | " : "") + $"Error: {JsonConvert.SerializeObject(ex)}");

					throw ex;
				}
			}


		}

		public async Task StartWork()
		{
			try { MDA_QR_Scan_Log_IsActive = Convert.ToBoolean(AppHttpContextAccessor.AppConfiguration.GetSection("MDA_QR_Scan_Log_IsActive").Value); }
			catch { MDA_QR_Scan_Log_IsActive = false; }

			try { MDA_QR_Scan_Response_Demo = Convert.ToBoolean(AppHttpContextAccessor.AppConfiguration.GetSection("MDA_QR_Scan_Response_Demo").Value); }
			catch { MDA_QR_Scan_Response_Demo = false; }

			try { MDA_QR_Scan_Delay_Sec = Convert.ToInt32(AppHttpContextAccessor.AppConfiguration.GetSection("MDA_QR_Scan_Delay_Sec").Value ?? "1"); }
			catch { MDA_QR_Scan_Delay_Sec = 2; }

			try { filePath = Convert.ToString(AppHttpContextAccessor.AppConfiguration.GetSection("MDA_QR_Scan_Log_File_Path").Value ?? "MDA_QR_Scan_<HH>.txt"); }
			catch { filePath = "C:\\Z_Project_Dispatch_System\\Logs\\<YYYYMMDD>\\MDA_QR_Scan_<HH>.txt"; }

			cnt_error = 0;

			if (mda.Required_Shipper <= mda.Loaded_Shipper)
			{
				_sharedDataService.AddOrUpdate(Interlocked.Increment(ref _sequenceNumber), "", "COMPLETED", 0, (long)mda.Required_Shipper, (long)mda.Loaded_Shipper, (long)mda.Carton_Qty);

				return;
			}

			_receivedData_Prev = new("123", "", DateTime.Now);

			Write_Log($"MC Start Request");

			_isStopSignal = false;

			IPAddress listenIP;
			int listenPort;

			string listenIPString = Convert.ToString(AppHttpContextAccessor.AppConfiguration.GetSection("Listen_IP").Value ?? "");
			string listenPortString = Convert.ToString(AppHttpContextAccessor.AppConfiguration.GetSection("Listen_Port").Value ?? "");

			if (Regex.IsMatch((listenIPString ?? ""), @"^((25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.){3}(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)$")
				&& IPAddress.TryParse(listenIPString, out listenIP) && int.TryParse(listenPortString, out listenPort) && listenPort > 0 && listenPort <= 65535)
			{
				if (!_isRunning)
					try
					{
						listenerSocket.Bind(new IPEndPoint(listenIP, listenPort));
						listenerSocket.Listen(10);

						Write_Log($"Listen is listening on Address {listenIP.ToString()}:{listenPort}...");
					}
					catch (Exception ex)
					{
						Write_Log($"Error: {JsonConvert.SerializeObject(ex)}");

						Thread.Sleep(1000);
					}

				try
				{
					clientSocket = clientSocket != null && IsConnected(clientSocket) ? clientSocket : listenerSocket.Accept();

					Write_Log("Connected to sender : " + clientSocket.RemoteEndPoint);
					Write_Log($"Checking for data");

				}
				catch (Exception e) { return; }

				if (clientSocket != null && IsConnected(clientSocket))
				{
					clientSocket.Send(Encoding.ASCII.GetBytes("STOP"));

					clientSocket.Send(Encoding.ASCII.GetBytes("START"));
				}

				_sequenceNumber = (_sharedDataService.GetScanData() != null && _sharedDataService.GetScanData().Count() > 0 ? _sharedDataService.GetScanData().Max(x => x.Key) : 0);

				LogService.LogInsert("Load MDA " + AppHttpContextAccessor.Loading_Bay, "Start Loading | " + (mda != null ? " MDA Id : " + mda.Mda_Id + " Gate In/Out Id : " + mda.GateInOut_Id : ""));

				// Create a cancellation token source
				_cancellationTokenSource = new CancellationTokenSource();

				// Start a background task
				if (clientSocket != null && (_backgroundTask == null || _backgroundTask.IsCompleted))
					_backgroundTask = Task.Run(BackgroundTaskAsync, _cancellationTokenSource.Token);

				Thread.Sleep(Convert.ToInt32(AppHttpContextAccessor.AppConfiguration.GetSection("MDA_QR_Scan_Delay_Sec").Value ?? "1") * 2 * 1000);

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

						Write_Log($"Socket server disconnected.");

						return;
					}

					var received = await clientSocket.ReceiveAsync(_buffer, SocketFlags.None);

					var receivedData = Encoding.UTF8.GetString(_buffer, 0, received);

					Write_Log($"<$>Socket server received message Before Split : \"{receivedData}\"");

					receivedData = Regex.Replace(receivedData, @"[\s\0]+", "");

					if (!string.IsNullOrEmpty(receivedData) && receivedData.Length > 58 && receivedData.Contains(iffco_url))
					{
						string pattern = receivedData.Substring(0, 5);

						int firstIndex = receivedData.IndexOf(pattern);
						int secondIndex = receivedData.IndexOf(pattern, firstIndex + 1);

						if (secondIndex != -1) receivedData = receivedData.Substring(0, secondIndex);
					}

					if (!string.IsNullOrEmpty(receivedData) && receivedData.Contains(iffco_url.Substring(0, 5)))
						receivedData = receivedData.Trim().Replace(" ", "").Substring(receivedData.IndexOf(iffco_url.Substring(0, 5)));

					// By VK
					if (receivedData.ToUpper().StartsWith(iffco_url.ToUpper().Substring(0, 10)) && !receivedData.ToUpper().Contains(iffco_url.ToUpper()))
					{
						Write_Log($"ReceivedData : {receivedData} | Response : continue");
						Thread.Sleep(500);
						continue;
					}

					if (!string.IsNullOrEmpty(receivedData) && receivedData.Contains(iffco_url))
					{
						receivedData = receivedData.Substring(receivedData.IndexOf(iffco_url));

						var strQR = receivedData.Replace(iffco_url, "");

						StringBuilder sb = new StringBuilder(strQR);

						bool toggle = true;
						int index;

						while ((index = sb.ToString().IndexOf("/")) > -1)
						{
							sb[index] = toggle ? '(' : ')';
							toggle = !toggle;
						}

						receivedData = sb.ToString();
						receivedData = Regex.Replace(receivedData, @"[^\w:/\(/\)\.\-]", "");

						receivedData = receivedData.Replace("MCIDEL", "");
						receivedData = receivedData.Replace("MCSTART", "");
						receivedData = receivedData.Replace("MCSTOP", "");

					}

					Write_Log($"Socket server received message After Split : \"{receivedData}\"");

					if (!_isRunning && !_isStopSignal && !string.IsNullOrEmpty(receivedData)
						&& (receivedData.Trim().ToUpper().Replace(" ", "").Contains("MCSTART")
						|| receivedData.Trim().ToUpper().Replace(" ", "").Contains("MCIDEL")
						|| receivedData.Trim().ToUpper().Replace(" ", "").Contains("(")
						|| receivedData.Trim().Length > 0))
						_isRunning = true;

					if (_isRunning && _isStopSignal && !string.IsNullOrEmpty(receivedData)
						&& receivedData.Trim().ToUpper().Replace(" ", "").Contains("MCSTOP"))
					{
						try
						{
							Write_Log($"MC Stop Request");

							// Close the socket when the background task is stopped
							listenerSocket.Shutdown(SocketShutdown.Both);
							listenerSocket.Close();
							clientSocket = null;
						}
						catch { }

						_isRunning = false;
						_isStopSignal = false;
						_sharedDataService.AddOrUpdate(Interlocked.Increment(ref _sequenceNumber), receivedData, "STOP", 0, (long)mda.Required_Shipper, (long)mda.Loaded_Shipper, (long)mda.Carton_Qty);

						LogService.LogInsert("Load MDA " + AppHttpContextAccessor.Loading_Bay, "Stop Loading | " + (mda != null ? " MDA Id : " + mda.Mda_Id + " Gate In/Out Id : " + mda.GateInOut_Id : ""));

						_cancellationTokenSource?.Cancel();
					}
					else if (_isRunning && _isStopSignal && !string.IsNullOrEmpty(receivedData)
						&& !receivedData.Trim().ToUpper().Replace(" ", "").Contains("MCSTOP"))
					{
						Write_Log($"Stop Signal");

						continue;
					}

					if (_isRunning && !_isStopSignal && !string.IsNullOrEmpty(receivedData)
						&& !receivedData.Trim().ToUpper().Replace(" ", "").Contains("MCIDEL")
						&& !receivedData.Trim().ToUpper().Replace(" ", "").Contains("MCSTOP")
						&& !receivedData.Trim().ToUpper().Replace(" ", "").Contains("MCSTART")
					)
					{
						if (!string.IsNullOrEmpty(_receivedData_Prev.QRCode)
							&& receivedData == _receivedData_Prev.QRCode
							&& (DateTime.Now - _receivedData_Prev.DT).TotalSeconds < 10)
						{
							//clientSocket.Send(Encoding.ASCII.GetBytes("$"));

							if (_receivedData_Prev.State == "NOK") clientSocket.Send(Encoding.ASCII.GetBytes(_receivedData_Prev.State));
							//else clientSocket.Send(Encoding.ASCII.GetBytes("$"));

							Write_Log($"ReceivedData : {receivedData} before 10 sec | Response : continue");

							receivedData = "";

							//if (!_sharedDataService.GetScanData().Any(x => x.Value.qr_code == receivedData))
							//	Write_Log($"ReceivedData : {receivedData} before 10 sec | Response : {receivedData} not in list.");

							Thread.Sleep(500);
							continue;
						}

						var (IsSuccess, response, Id) = (false, "NOK", 0M);

						if (!string.IsNullOrEmpty(receivedData)
							&& receivedData.Trim().ToUpper().Replace(" ", "").Contains("<#>"))
						{
							//clientSocket.Send(Encoding.ASCII.GetBytes("$"));

							Write_Log($"ReceivedData : {receivedData} | <#> Response : continue");

							receivedData = "";

							Thread.Sleep(500);
							continue;
						}
						else if (!string.IsNullOrEmpty(receivedData)
							&& receivedData.Trim().ToUpper().Replace(" ", "").Contains("<@>"))
						{
							mda.Carton_Qty = (long)mda.Carton_Qty + 1;

							_sharedDataService.AddOrUpdate(Interlocked.Increment(ref _sequenceNumber), "##########", "NOK", (long)0, (long)mda.Required_Shipper, (long)mda.Loaded_Shipper, (long)mda.Carton_Qty);

							//clientSocket.Send(Encoding.ASCII.GetBytes("$"));

							Write_Log($"ReceivedData : {receivedData} | <@> Response : continue");

							receivedData = "";

							Thread.Sleep(500);
							continue;
						}
						else if (MDA_QR_Scan_Response_Demo)
						{
							string[] arrayResponse = new string[] { "OK", "NOK" };

							response = arrayResponse[(new Random().Next(arrayResponse.Length))].ToString();

							IsSuccess = !response.Contains("NOK");

							Id = _sharedDataService.GetScanData().OrderByDescending(x => x.Key).Select(x => x.Key).FirstOrDefault() + 1;
							var loaddedShipper = _sharedDataService.GetScanData().Where(x => x.Value.flag == "OK").Count();

							response = response + "#" + "10" + "#" + loaddedShipper + "#" + 0;
						}
						else if (!receivedData.Trim().ToUpper().Replace(" ", "").Contains("MCIDEL")
							&& !receivedData.Trim().ToUpper().Replace(" ", "").Contains("MCSTOP")
							&& !receivedData.Trim().ToUpper().Replace(" ", "").Contains("MCSTART")
							//&& receivedData.Trim().ToUpper().Replace(" ", "").Contains("(")
							&& receivedData.Trim().ToUpper().Replace(" ", "").Length > 0)
						{
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

						Write_Log($"Response : {response}");

						try
						{
							if (!string.IsNullOrEmpty(receivedData)
								&& !receivedData.Trim().ToUpper().Replace(" ", "").Contains("MCIDEL")
								&& !receivedData.Trim().ToUpper().Replace(" ", "").Contains("MCSTOP")
								&& !receivedData.Trim().ToUpper().Replace(" ", "").Contains("MCSTART")
								&& receivedData.Trim().ToUpper().Replace(" ", "").Length > 0)
							{
								receivedData = receivedData.Trim().ToUpper().Replace(" ", "");

								if (response.Contains("#"))
								{
									clientSocket.Send(Encoding.ASCII.GetBytes(response.Split("#")[0].ToString()));

									_receivedData_Prev = new(receivedData, response.Split("#")[0].ToString(), DateTime.Now);

									mda.Required_Shipper = Convert.ToInt64(response.Split("#")[1]);
									mda.Loaded_Shipper = Convert.ToInt64(response.Split("#")[2]);
									mda.Carton_Qty = Convert.ToInt64(response.Split("#")[3]);

									_sharedDataService.AddOrUpdate(Interlocked.Increment(ref _sequenceNumber), receivedData, response.Split("#")[0].ToString(), (long)Id, (long)mda.Required_Shipper, (long)mda.Loaded_Shipper, (long)mda.Carton_Qty);

									if (mda.Required_Shipper <= mda.Loaded_Shipper)
									{
										_sharedDataService.AddOrUpdate(Interlocked.Increment(ref _sequenceNumber), receivedData, "COMPLETED", (long)Id, (long)mda.Required_Shipper, (long)mda.Loaded_Shipper, (long)mda.Carton_Qty);

										Console.WriteLine($"Response = {response.Split("#")[0].ToString()}, RequiredShipper = {mda.Required_Shipper}, LoaddedShipper = {mda.Loaded_Shipper}, RejectShipper = {mda.Carton_Qty}");

										LogService.LogInsert("Load MDA " + AppHttpContextAccessor.Loading_Bay, "MDA Completed | " + (mda != null ? " MDA Id : " + mda.Mda_Id + " Gate In/Out Id : " + mda.GateInOut_Id : ""));
									}

									receivedData = "";

									//clientSocket.Send(Encoding.ASCII.GetBytes("$"));
									Thread.Sleep(1000);

								}
								else
								{
									_receivedData_Prev = new(receivedData, "NOK", DateTime.Now);

									if (clientSocket != null && IsConnected(clientSocket))
									{
										mda.Carton_Qty = (long)mda.Carton_Qty + 1;

										response = "NOK" + "#" + mda.Required_Shipper + "#" + mda.Loaded_Shipper + "#" + mda.Carton_Qty;

										_sharedDataService.AddOrUpdate(Interlocked.Increment(ref _sequenceNumber), receivedData, "NOK", (long)0, (long)mda.Required_Shipper, (long)mda.Loaded_Shipper, (long)mda.Carton_Qty);

										clientSocket.Send(Encoding.ASCII.GetBytes("NOK"));
										Thread.Sleep(1000);

										Write_Log($"Response : {response}");

									}
								}
							}
							else
							{
								if (clientSocket != null && IsConnected(clientSocket))
								{
									mda.Carton_Qty = (long)mda.Carton_Qty + 1;

									response = "NOK" + "#" + mda.Required_Shipper + "#" + mda.Loaded_Shipper + "#" + mda.Carton_Qty;

									_sharedDataService.AddOrUpdate(Interlocked.Increment(ref _sequenceNumber), receivedData, "NOK", (long)0, (long)mda.Required_Shipper, (long)mda.Loaded_Shipper, (long)mda.Carton_Qty);

									clientSocket.Send(Encoding.ASCII.GetBytes("NOK"));
									Thread.Sleep(1000);

									Write_Log($"Response : {response}");

								}
							}
						}
						catch (Exception _ex)
						{
							if (clientSocket != null && IsConnected(clientSocket))
							{
								mda.Carton_Qty = (long)mda.Carton_Qty + 1;

								response = "NOK" + "#" + mda.Required_Shipper + "#" + mda.Loaded_Shipper + "#" + mda.Carton_Qty;

								_sharedDataService.AddOrUpdate(Interlocked.Increment(ref _sequenceNumber), receivedData, "NOK", (long)0, (long)mda.Required_Shipper, (long)mda.Loaded_Shipper, (long)mda.Carton_Qty);

								clientSocket.Send(Encoding.ASCII.GetBytes("NOK"));
								Thread.Sleep(1000);

								Write_Log($"Response : {response}");

							}

							Write_Log($"Error: {JsonConvert.SerializeObject(_ex)}");
						}
					}

					receivedData = "";

					Thread.Sleep(MDA_QR_Scan_Delay_Sec * 1000);

					_cancellationTokenSource.Token.ThrowIfCancellationRequested();
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

					Write_Log($"Error: {JsonConvert.SerializeObject(ex)}");

					LogService.LogInsert("Load MDA " + AppHttpContextAccessor.Loading_Bay, (mda != null ? " MDA Id : " + mda.Mda_Id + " Gate In/Out Id : " + mda.GateInOut_Id + " | " : "") + $"Error: {JsonConvert.SerializeObject(ex)}");
				}

			}
		}


		//private async Task BackgroundTaskAsync()
		//{
		//	while (!_cancellationTokenSource.Token.IsCancellationRequested)
		//	{
		//		try
		//		{
		//			if (clientSocket == null || !IsConnected(clientSocket))
		//			{
		//				_isRunning = false;

		//				Write_Log($"{Environment.NewLine}Socket server disconnected.");

		//				return;
		//			}

		//			var received = await clientSocket.ReceiveAsync(_buffer, SocketFlags.None);

		//			var receivedData = Encoding.UTF8.GetString(_buffer, 0, received);

		//			Write_Log($"{Environment.NewLine}Socket server received message Before Split : \"{receivedData}\"");

		//			receivedData = receivedData.Trim().Replace(" ", "").Substring(receivedData.IndexOf(iffco_url.Substring(0, 10)));

		//			//// By VK
		//			//if (receivedData.ToUpper().StartsWith(iffco_url.ToUpper().Substring(0, 10)) && !receivedData.ToUpper().Contains(iffco_url.ToUpper()))
		//			//{
		//			//	Thread.Sleep(500);
		//			//	continue;
		//			//}

		//			if (!string.IsNullOrEmpty(receivedData) && receivedData.Contains(iffco_url))
		//			{
		//				receivedData = receivedData.Substring(receivedData.IndexOf(iffco_url));

		//				var strQR = receivedData.Replace(iffco_url, "");

		//				StringBuilder sb = new StringBuilder(strQR);

		//				bool toggle = true;
		//				int index;

		//				while ((index = sb.ToString().IndexOf("/")) > -1)
		//				{
		//					sb[index] = toggle ? '(' : ')';
		//					toggle = !toggle;
		//				}

		//				receivedData = sb.ToString();
		//				receivedData = Regex.Replace(receivedData, @"[^\w:/\(/\)\.\-]", "");

		//				receivedData = receivedData.Replace("MCIDEL", "");
		//				receivedData = receivedData.Replace("MCSTART", "");
		//				receivedData = receivedData.Replace("MCSTOP", "");

		//			}

		//			Write_Log($"Socket server received message After Split : \"{receivedData}\"");

		//			receivedData = !string.IsNullOrEmpty(receivedData) ? receivedData.Trim().ToUpper().Replace(" ", "") : receivedData;

		//			if (!_isRunning && !_isStopSignal && !string.IsNullOrEmpty(receivedData)
		//				&& (receivedData.Contains("MCSTART") || receivedData.Contains("MCIDEL") || receivedData.Contains("(") || receivedData.Trim().Length > 0))
		//				_isRunning = true;

		//			if (_isRunning && _isStopSignal && !string.IsNullOrEmpty(receivedData) && receivedData.Contains("MCSTOP"))
		//			{
		//				try
		//				{
		//					Write_Log($"MC Stop Request");

		//					// Close the socket when the background task is stopped
		//					listenerSocket.Shutdown(SocketShutdown.Both);
		//					listenerSocket.Close();
		//					clientSocket = null;
		//				}
		//				catch { }

		//				_isRunning = false;
		//				_isStopSignal = false;
		//				_sharedDataService.AddOrUpdate(Interlocked.Increment(ref _sequenceNumber), receivedData, "STOP", 0, (long)mda.Required_Shipper, (long)mda.Loaded_Shipper, (long)mda.Carton_Qty);

		//				LogService.LogInsert("Load MDA " + AppHttpContextAccessor.Loading_Bay, "Stop Loading | " + (mda != null ? " MDA Id : " + mda.Mda_Id + " Gate In/Out Id : " + mda.GateInOut_Id : ""));

		//				_cancellationTokenSource?.Cancel();
		//			}
		//			else if (_isRunning && _isStopSignal && !string.IsNullOrEmpty(receivedData) && !receivedData.Contains("MCSTOP"))
		//			{
		//				Write_Log($"Stop Signal");
		//				continue;
		//			}

		//			if (_isRunning && !_isStopSignal && !string.IsNullOrEmpty(receivedData) && !receivedData.Contains("MCIDEL") && !receivedData.Contains("MCSTOP") && !receivedData.Contains("MCSTART") && receivedData.Length > 0)
		//			{
		//				if (!string.IsNullOrEmpty(_receivedData_Prev.QRCode) && receivedData == _receivedData_Prev.QRCode
		//					&& (DateTime.Now - _receivedData_Prev.DT).TotalSeconds < 10)
		//				{
		//					clientSocket.Send(Encoding.ASCII.GetBytes("$"));
		//					Write_Log($"ReceivedData : {receivedData} before 10 sec | Response : continue");

		//					//clientSocket.Send(Encoding.ASCII.GetBytes(_receivedData_Prev.State));

		//					//if (!_sharedDataService.GetScanData().Any(x => x.Value.qr_code == receivedData))
		//					//	Write_Log($"ReceivedData : {receivedData} before 10 sec | Response : {receivedData} not in list.");

		//					receivedData = "";
		//					Thread.Sleep(1000);
		//					continue;
		//				}

		//				var (IsSuccess, response, Id) = (false, "NOK", 0M);

		//				if (!string.IsNullOrEmpty(receivedData) && receivedData.Contains("<#>"))
		//				{
		//					clientSocket.Send(Encoding.ASCII.GetBytes("$"));
		//					Write_Log($"ReceivedData : {receivedData} | <#> Response : continue");
		//					receivedData = "";
		//					Thread.Sleep(500);
		//					continue;
		//				}
		//				else if (!string.IsNullOrEmpty(receivedData) && receivedData.Contains("<@>"))
		//				{
		//					mda.Carton_Qty = (long)mda.Carton_Qty + 1;

		//					_sharedDataService.AddOrUpdate(Interlocked.Increment(ref _sequenceNumber), "##########", "NOK", (long)0, (long)mda.Required_Shipper, (long)mda.Loaded_Shipper, (long)mda.Carton_Qty);

		//					clientSocket.Send(Encoding.ASCII.GetBytes("$"));
		//					Write_Log($"ReceivedData : {receivedData} | <@> Response : continue");
		//					receivedData = "";
		//					Thread.Sleep(500);
		//					continue;
		//				}
		//				else if (MDA_QR_Scan_Response_Demo)
		//				{
		//					string[] arrayResponse = new string[] { "OK", "NOK" };

		//					response = arrayResponse[(new Random().Next(arrayResponse.Length))].ToString();

		//					IsSuccess = !response.Contains("NOK");

		//					Id = _sharedDataService.GetScanData().OrderByDescending(x => x.Key).Select(x => x.Key).FirstOrDefault() + 1;
		//					var loaddedShipper = _sharedDataService.GetScanData().Where(x => x.Value.flag == "OK").Count();

		//					response = response + "#" + "10" + "#" + loaddedShipper + "#" + 0;
		//				}
		//				else
		//				{
		//					if (PLANT_ID <= 0) PLANT_ID = AppHttpContextAccessor.PlantId;

		//					List<MySqlParameter> oParams = new List<MySqlParameter>();

		//					oParams.Add(new MySqlParameter("P_LOADING_BAY", MySqlDbType.VarString) { Value = AppHttpContextAccessor.Loading_Bay });
		//					oParams.Add(new MySqlParameter("P_QR_CODE", MySqlDbType.VarString) { Value = receivedData });
		//					oParams.Add(new MySqlParameter("P_GATE_SYS_ID", MySqlDbType.Int64) { Value = mda.GateInOut_Id });
		//					oParams.Add(new MySqlParameter("P_MDA_SYS_ID", MySqlDbType.Int64) { Value = mda.Mda_Id });
		//					oParams.Add(new MySqlParameter("P_MDA_DTL_SYS_ID", MySqlDbType.Int64) { Value = mda.Id });
		//					oParams.Add(new MySqlParameter("P_PROD_SYS_ID", MySqlDbType.Int64) { Value = mda.Prod_Sys_Id });
		//					oParams.Add(new MySqlParameter("P_IS_MANUAL_SCAN", MySqlDbType.Int64) { Value = 0 });
		//					oParams.Add(new MySqlParameter("P_PLANT_ID", MySqlDbType.Int64) { Value = PLANT_ID });

		//					(IsSuccess, response, Id) = DataContext.ExecuteStoredProcedure_SQL("PC_SHIPPER_QRCODE_CHECK", oParams, true);
		//				}

		//				try
		//				{
		//					if (response.Contains("#"))
		//					{
		//						mda.Required_Shipper = Convert.ToInt64(response.Split("#")[1]);
		//						mda.Loaded_Shipper = Convert.ToInt64(response.Split("#")[2]);
		//						mda.Carton_Qty = Convert.ToInt64(response.Split("#")[3]);

		//						_sharedDataService.AddOrUpdate(Interlocked.Increment(ref _sequenceNumber), receivedData, response.Split("#")[0].ToString(), (long)Id, (long)mda.Required_Shipper, (long)mda.Loaded_Shipper, (long)mda.Carton_Qty);

		//						clientSocket.Send(Encoding.ASCII.GetBytes(response.Split("#")[0].ToString()));
		//					}
		//					else
		//					{
		//						mda.Carton_Qty = (long)mda.Carton_Qty + 1;

		//						response = "NOK" + "#" + mda.Required_Shipper + "#" + mda.Loaded_Shipper + "#" + mda.Carton_Qty;

		//						_sharedDataService.AddOrUpdate(Interlocked.Increment(ref _sequenceNumber), receivedData, "NOK", (long)0, (long)mda.Required_Shipper, (long)mda.Loaded_Shipper, (long)mda.Carton_Qty);

		//						clientSocket.Send(Encoding.ASCII.GetBytes("NOK"));
		//					}

		//					_receivedData_Prev = new(receivedData, response.Split("#")[0].ToString(), DateTime.Now);

		//					if (mda.Required_Shipper <= mda.Loaded_Shipper)
		//					{
		//						_sharedDataService.AddOrUpdate(Interlocked.Increment(ref _sequenceNumber), receivedData, "COMPLETED", (long)Id, (long)mda.Required_Shipper, (long)mda.Loaded_Shipper, (long)mda.Carton_Qty);

		//						LogService.LogInsert("Load MDA " + AppHttpContextAccessor.Loading_Bay, "MDA Completed | " + (mda != null ? " MDA Id : " + mda.Mda_Id + " Gate In/Out Id : " + mda.GateInOut_Id : ""));
		//					}

		//					Write_Log($"Response : {response}");

		//					receivedData = "";
		//					Thread.Sleep(1000);
		//				}
		//				catch (Exception _ex)
		//				{
		//					mda.Carton_Qty = (long)mda.Carton_Qty + 1;

		//					response = "NOK" + "#" + mda.Required_Shipper + "#" + mda.Loaded_Shipper + "#" + mda.Carton_Qty;

		//					_sharedDataService.AddOrUpdate(Interlocked.Increment(ref _sequenceNumber), receivedData, "NOK", (long)0, (long)mda.Required_Shipper, (long)mda.Loaded_Shipper, (long)mda.Carton_Qty);

		//					clientSocket.Send(Encoding.ASCII.GetBytes("NOK"));

		//					Write_Log($"Response : {response} {Environment.NewLine}{Environment.NewLine}Error: {JsonConvert.SerializeObject(_ex)}");
		//				}
		//			}

		//			receivedData = "";
		//			Thread.Sleep(MDA_QR_Scan_Delay_Sec * 1000);
		//			_cancellationTokenSource.Token.ThrowIfCancellationRequested();
		//		}
		//		catch (Exception ex)
		//		{
		//			cnt_error += 1;

		//			if (cnt_error > 10)
		//			{
		//				cnt_error = 0;

		//				_isStopSignal = true;

		//				_errorMessage = $"{JsonConvert.SerializeObject(ex)}";
		//			}

		//			Write_Log($"Error: {JsonConvert.SerializeObject(ex)}");
		//			LogService.LogInsert("Load MDA " + AppHttpContextAccessor.Loading_Bay, (mda != null ? " MDA Id : " + mda.Mda_Id + " Gate In/Out Id : " + mda.GateInOut_Id + " | " : "") + $"Error: {JsonConvert.SerializeObject(ex)}");
		//		}

		//	}
		//}


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
			if (!string.IsNullOrEmpty(text))
			{
				Console.WriteLine((text.StartsWith("<$>") ? System.Environment.NewLine : "") + DateTime.Now.ToString("dd/MM/yyyy hh:mm:ss tt") + " || " + text.Replace("<$>", "") + System.Environment.NewLine);

				if (!MDA_QR_Scan_Log_IsActive) return;

				try
				{
					var _filePath = filePath.Replace("<YYYYMMDD>", DateTime.Now.ToString("yyyyMMdd"));
					_filePath = _filePath.Replace("<HH>", DateTime.Now.ToString("HH"));

					if (!System.IO.Directory.Exists(Path.GetDirectoryName(_filePath)))
						System.IO.Directory.CreateDirectory(Path.GetDirectoryName(_filePath));

					if (!System.IO.File.Exists(_filePath))
						System.IO.File.Create(_filePath).Dispose();

					using (StreamWriter sw = System.IO.File.AppendText(_filePath))
						sw.WriteLine((text.StartsWith("<$>") ? System.Environment.NewLine : "") + DateTime.Now.ToString("dd/MM/yyyy hh:mm:ss tt") + " || " + text.Replace("<$>", "") + System.Environment.NewLine);
				}
				catch (Exception) { }
			}

		}
	}


	public class SharedDataService
	{
		private ConcurrentDictionary<long, (string qr_code, string flag, Int64 id, Int64 requiredShipper, Int64 loaddedShipper, Int64 rejectShipper)> _sharedData = new ConcurrentDictionary<long, (string qr_code, string flag, Int64 id, Int64 requiredShipper, Int64 loaddedShipper, Int64 rejectShipper)>();

		public void AddOrUpdate(long key, string value, string flag, Int64 id, Int64 requiredShipper, Int64 loaddedShipper, Int64 rejectShipper)
		{
			if (_sharedData.ContainsKey(key))
			{
				_sharedData[key] = (value, flag, id, requiredShipper, loaddedShipper, rejectShipper);
			}
			else
			{
				_sharedData.TryAdd(key, (value, flag, id, requiredShipper, loaddedShipper, rejectShipper));
			}
		}

		public void AddOrUpdate(List<(long key, string value, string flag, Int64 id, Int64 requiredShipper, Int64 loaddedShipper, Int64 rejectShipper)> values)
		{
			foreach (var item in values)
				if (_sharedData.ContainsKey(item.key))
				{
					_sharedData[item.key] = (item.value, item.flag, item.id, item.requiredShipper, item.loaddedShipper, item.rejectShipper);
				}
				else
				{
					_sharedData.TryAdd(item.key, (item.value, item.flag, item.id, item.requiredShipper, item.loaddedShipper, item.rejectShipper));
				}
		}

		public (string qr_code, string flag, Int64 id, Int64 requiredShipper, Int64 loaddedShipper, Int64 rejectShipper) GetValue(long key)
		{
			_sharedData.TryGetValue(key, out var value);
			return value;
		}

		public ConcurrentDictionary<long, (string qr_code, string flag, Int64 id, Int64 requiredShipper, Int64 loaddedShipper, Int64 rejectShipper)> GetScanData() => _sharedData;

		public void ClearScanData() { _sharedData = new ConcurrentDictionary<long, (string qr_code, string flag, Int64 id, Int64 requiredShipper, Int64 loaddedShipper, Int64 rejectShipper)>(); }
	}
}
