using Microsoft.AspNetCore.SignalR;
using System.Collections.Concurrent;
using VendorQRGeneration.Infra.Services;

namespace Dispatch_System.Infra
{
	public class ConveyorHub : Hub
	{
		private static string _userConnectionId { get; set; }
		private readonly ConveyorBackgroundTask _socketBackgroundTask;
		private readonly SharedDataService _sharedDataService;

		// Constructor injection of services
		public ConveyorHub(ConveyorBackgroundTask socketBackgroundTask, SharedDataService sharedDataService)
		{
			_socketBackgroundTask = socketBackgroundTask;
			_sharedDataService = sharedDataService;
		}

		public override async Task OnConnectedAsync()
		{
			if (_userConnectionId == Context.ConnectionId)
			{
				await Clients.Caller.SendAsync("ReceiveMessage", "You are already connected. Only one connection is allowed.");

				throw new HubException("Only one connection allowed per user.");
			}

			if (!string.IsNullOrEmpty(_userConnectionId))
			{
				await Clients.Caller.SendAsync("ReceiveMessage", "Only one user can connect at a time.");
				throw new HubException("Only one user can connect at a time.");
			}

			_userConnectionId = Context.ConnectionId;

			await base.OnConnectedAsync();
		}

		public override Task OnDisconnectedAsync(Exception? exception)
		{
			_userConnectionId = string.Empty;
			return base.OnDisconnectedAsync(exception);
		}

		public async Task SendMessage(string targetUserGuid, string msg)
		{
			if (_userConnectionId == targetUserGuid)
				await Clients.Client(targetUserGuid).SendAsync("ReceiveMessage", msg);
		}

		public async Task SendClientMessage(string msg) => await Clients.All.SendAsync("ReceiveMessage", msg);

		public static string GetConnectionId => _userConnectionId;

		public bool CheckConveyorConnection() => _socketBackgroundTask.IsConnect();
	}
}
