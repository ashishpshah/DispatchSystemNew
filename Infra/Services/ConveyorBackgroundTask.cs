using Dispatch_System;
using Dispatch_System.Infra;
using DocumentFormat.OpenXml.Office2010.Excel;
using Microsoft.AspNetCore.SignalR;
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
	public class ConveyorBackgroundTask
	{

		private IPAddress ConnectionIP;
		private int ConnectionPort;
		private TcpListener tcpListener;
		private Thread tcpServerThread;
		private bool isRunning = false;

		public event EventHandler<TcpServerListenerEventArgs> DataReceive;
		public event EventHandler ConnectionClosed;
		public event EventHandler ServerStarted;


		private Int64 PLANT_ID { get; set; }
		private dynamic objLoad { get; set; }
		private bool MDA_QR_Scan_Response_Demo { get; set; }
		private int MDA_QR_Scan_Delay_Sec = 1;
		private string iffco_url { get; set; }

		public ConveyorBackgroundTask()
		{
			PLANT_ID = Common.Get_Session_Int(SessionKey.PLANT_ID);

			try { MDA_QR_Scan_Response_Demo = Convert.ToBoolean(AppHttpContextAccessor.AppConfiguration.GetSection("MDA_QR_Scan_Response_Demo").Value); }
			catch { MDA_QR_Scan_Response_Demo = false; }

			MDA_QR_Scan_Delay_Sec = Convert.ToInt32(AppHttpContextAccessor.AppConfiguration.GetSection("MDA_QR_Scan_Delay_Sec").Value ?? "1");

			iffco_url = AppHttpContextAccessor.IFFCO_Domain.TrimEnd('/');

		}

		public void SetObjLoad(dynamic _objLoad) => objLoad = _objLoad;
		public dynamic GetObjLoad() => objLoad;

		public bool IsConnect()
		{
			try
			{
				Socket s = new Socket(AddressFamily.InterNetwork, SocketType.Stream, ProtocolType.Tcp);

				s.Connect(ConnectionIP, ConnectionPort);

				if (s.Connected) return true;
			}
			catch (Exception ex) { }

			return false;
		}

		public void ConnectToServer(IPAddress listenIP, int listenPort)
		{
			ConnectionIP = listenIP;
			ConnectionPort = listenPort;

			isRunning = true;
			tcpServerThread = new Thread(TcpServerRun);
			tcpServerThread.Start();
		}

		private void TcpServerRun()
		{
			tcpListener = new TcpListener(ConnectionIP, ConnectionPort);
			tcpListener.Start();

			try
			{
				while (isRunning)
				{
					if (!tcpListener.Pending())
					{
						Thread.Sleep(100); // Avoid CPU overload.
						continue;
					}

					TcpClient client = tcpListener.AcceptTcpClient();
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
				//int bytesRead = stream.Read(buffer, 0, buffer.Length);

				//if (bytesRead > 0)
				//{
				//	TcpServerListenerEventArgs args = new TcpServerListenerEventArgs { buffer = buffer };
				//	OnDataReceive(args);
				//}

				while (isRunning)
				{
					if (stream.DataAvailable)
					{
						int bytesRead = stream.Read(buffer, 0, buffer.Length);

						if (bytesRead > 0)
						{
							TcpServerListenerEventArgs args = new TcpServerListenerEventArgs { buffer = buffer };
							OnDataReceive(args);
						}
					}

					// Optionally add a small delay to prevent busy waiting
					Thread.Sleep(MDA_QR_Scan_Delay_Sec * 1000);
				}
			}
			catch (Exception ex)
			{
				// Log or handle exceptions during communication.
			}
			finally
			{
				mClient.Close();
				OnConnectionClosed();
			}
		}

		protected virtual void OnDataReceive(TcpServerListenerEventArgs e)
		{
			EventHandler<TcpServerListenerEventArgs> handler = DataReceive;
			handler?.Invoke(this, e);
		}

		protected virtual void OnConnectionClosed()
		{
			ConnectionClosed?.Invoke(this, EventArgs.Empty);
		}

		protected virtual void OnServerStarted()
		{
			ServerStarted?.Invoke(this, EventArgs.Empty);
		}


		public void DisconnectToServer()
		{
			isRunning = false;

			tcpListener?.Stop();

			if (tcpServerThread != null && tcpServerThread.IsAlive)
				tcpServerThread.Join();

			OnConnectionClosed();
		}
	}

	public class TcpServerListenerEventArgs : EventArgs
	{
		public byte[] buffer { get; set; }
	}

	public class ClientConnectionEventArgs : EventArgs
	{
		public string ClientIP { get; set; }
	}
}
