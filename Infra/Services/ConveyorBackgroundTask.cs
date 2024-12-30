using Dispatch_System;
using Dispatch_System.Infra;
using DocumentFormat.OpenXml.Office2010.Excel;
using Microsoft.AspNetCore.SignalR;
using Microsoft.Extensions.Logging;
using MySql.Data.MySqlClient;
using MySqlX.XDevAPI;
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
	public class ConveyorBackgroundTask
	{
		private LoadingData objLoad { get; set; } = new LoadingData();
		private bool isRunning { get; set; }
		private bool MDA_QR_Scan_Response_Demo { get; set; }
		private int MDA_QR_Scan_Delay_Sec = 1;

		private IPAddress ConnectionIP;
		private int ConnectionPort;
		private TcpListener tcpListener;
		private Thread tcpServerThread;

		private TcpClient connectedClient = new();
		public event EventHandler<TcpServerListenerEventArgs> DataReceive;
		public event EventHandler ConnectionClosed;
		public event EventHandler ServerStarted;

		public ConveyorBackgroundTask()
		{
			try { MDA_QR_Scan_Response_Demo = Convert.ToBoolean(AppHttpContextAccessor.AppConfiguration.GetSection("MDA_QR_Scan_Response_Demo").Value); }
			catch { MDA_QR_Scan_Response_Demo = false; }

			MDA_QR_Scan_Delay_Sec = Convert.ToInt32(AppHttpContextAccessor.AppConfiguration.GetSection("MDA_QR_Scan_Delay_Sec").Value ?? "1");

		}

		public bool IsConnect()
		{
			try
			{
				//Socket s = new Socket(AddressFamily.InterNetwork, SocketType.Stream, ProtocolType.Tcp);

				//s.Connect(ConnectionIP, ConnectionPort);

				//if (s.Connected && !(s.Poll(1, SelectMode.SelectRead) && s.Available == 0)) return true;
				lock (connectedClient)
				{
					if (connectedClient?.Client == null || !connectedClient.Client.Connected)
						return false;

					// Poll to check connection state
					if (connectedClient.Client.Poll(0, SelectMode.SelectRead) && connectedClient.Client.Available == 0)
						return false;

					return true;
				}
			}
			catch (Exception ex) { }

			return false;
		}

		public void ConnectToServer(IPAddress listenIP, int listenPort)
		{
			isRunning = true;

			ConnectionIP = listenIP;
			ConnectionPort = listenPort;

			tcpServerThread = new Thread(TcpServerRun);
			tcpServerThread.Start();

		}

		private void TcpServerRunningRun()
		{
			try
			{
				while (true)
				{
					Thread.Sleep(MDA_QR_Scan_Delay_Sec * 1000);
				}

			}
			catch (Exception ex)
			{
				// Log exception or handle it as needed.
			}
		}

		private void TcpServerRun()
		{
			try
			{
				tcpListener = new TcpListener(ConnectionIP, ConnectionPort);
				tcpListener.Start();

				while (isRunning)
				{
					try
					{
						if (!tcpListener.Pending())
						{
							Thread.Sleep(MDA_QR_Scan_Delay_Sec * 1000);
							continue;
						}
					}
					catch { continue; }

					TcpClient client = tcpListener.AcceptTcpClient();

					lock (connectedClient) connectedClient = client;

					Thread tcpHandlerThread = new Thread(new ParameterizedThreadStart(TcpHandler));
					tcpHandlerThread.Start(client);

					OnServerStarted();
				}

			}
			catch (SocketException ex)
			{
				// Log exception or handle it as needed.
			}
			finally
			{
				tcpListener?.Stop();
			}
		}

		private void TcpHandler(object client)
		{
			if (client is not TcpClient mClient)
				return;

			try
			{
				using NetworkStream stream = mClient.GetStream();
				byte[] buffer = new byte[1024];

				while (isRunning)
				{
					if (stream.DataAvailable)
					{
						int bytesRead = stream.Read(buffer, 0, buffer.Length);

						if (bytesRead > 0)
						{
							TcpServerListenerEventArgs args = new TcpServerListenerEventArgs { buffer = buffer, ticks = DateTime.UtcNow.Ticks };
							OnDataReceive(args);
						}
					}

					Thread.Sleep(MDA_QR_Scan_Delay_Sec * 1000);
				}
			}
			catch (Exception ex)
			{
				// Log or handle exceptions during communication.
			}
			finally
			{
				lock (connectedClient) connectedClient = new();

				mClient.Close();
				OnConnectionClosed();
			}
		}

		public bool SendToClient(string data)
		{
			byte[] bytesToSend = Encoding.UTF8.GetBytes(data);

			lock (connectedClient)
			{
				if (connectedClient.Connected)
				{
					try
					{
						NetworkStream stream = connectedClient.GetStream();
						stream.Write(bytesToSend, 0, bytesToSend.Length);

						return true;
					}
					catch (Exception ex)
					{
						// Handle exceptions when sending data.
					}
				}
				else
				{
					IsRunning(false);
					OnConnectionClosed();
				}
			}

			return false;
		}

		protected virtual void OnDataReceive(TcpServerListenerEventArgs e)
		{
			EventHandler<TcpServerListenerEventArgs> handler = DataReceive;
			handler?.Invoke(this, e);
		}

		protected virtual void OnConnectionClosed()
		{
			tcpListener?.Stop();
			ConnectionClosed?.Invoke(this, EventArgs.Empty);
		}

		protected virtual void OnServerStarted()
		{
			ServerStarted?.Invoke(this, EventArgs.Empty);
		}

		public void DisconnectToServer()
		{
			tcpListener?.Stop();

			if (tcpServerThread != null && tcpServerThread.IsAlive)
				tcpServerThread.Join();

		}


		public void SetObjLoad(LoadingData _objLoad) { lock (objLoad) objLoad = _objLoad; }

		public LoadingData GetObjLoad() => objLoad;

		public void IsRunning(bool _isRunning) => isRunning = _isRunning;
		public bool IsRunning() => isRunning;

	}

	public class TcpServerListenerEventArgs : EventArgs
	{
		public byte[] buffer { get; set; }
		public long ticks { get; set; }
	}

	public class ClientConnectionEventArgs : EventArgs
	{
		public string ClientIP { get; set; }
	}

	public class LoadingData
	{
		public long Id { get; set; }
		public dynamic? Data1 { get; set; }
		public dynamic? Data2 { get; set; }
		public long RequiredShipper { get; set; }
		public long LoaddedShipper { get; set; }
		public long RejectShipper { get; set; }
		public string QRCode { get; set; }
		public long Ticks { get; set; }
	}
}
