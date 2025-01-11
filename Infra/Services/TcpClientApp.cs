using Newtonsoft.Json;
using System.Net.Sockets;
using System.Text;

namespace VendorQRGeneration.Infra.Services
{
	public static class TcpClientApp
	{
		public static TcpClient client = null;

		public static async Task Run(string server, int port)
		{
			try
			{
				if (client == null || !client.Connected)
				{
					client = new TcpClient();
					await client.ConnectAsync(server, port);
				}
			}
			catch (Exception ex) { }
		}
		public static async Task<string> GetData(string server, int port, CancellationToken cancellationToken)
		{
			try
			{
				if (client == null || !client.Connected)
					await Run(server, port);

				if (client != null && client.Connected)
				{
					using NetworkStream stream = client.GetStream();

					byte[] buffer = new byte[256];
					int bytesRead = await stream.ReadAsync(buffer, 0, buffer.Length, cancellationToken);
					if (bytesRead > 0)
					{
						string currentWeight = Encoding.UTF8.GetString(buffer, 0, bytesRead);

						return currentWeight;
					}
				}
			}
			catch (Exception ex) { throw ex; }

			return "0";
		}


	}
}
