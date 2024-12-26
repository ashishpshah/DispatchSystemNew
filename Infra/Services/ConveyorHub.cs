using Microsoft.AspNetCore.SignalR;
using System.Collections.Concurrent;
using VendorQRGeneration.Infra.Services;

namespace Dispatch_System.Infra
{
	public class ConveyorHub : Hub
	{
		private static readonly ConcurrentDictionary<string, string> _userConnections = new();
		private readonly SocketBackgroundTask _socketBackgroundTask;
		private readonly SharedDataService _sharedDataService;

		// Constructor injection of services
		public ConveyorHub(SocketBackgroundTask socketBackgroundTask, SharedDataService sharedDataService)
		{
			_socketBackgroundTask = socketBackgroundTask;
			_sharedDataService = sharedDataService;
		}

		public override async Task OnConnectedAsync()
		{
			var userGuid = Context.ConnectionId;

			if (_userConnections.ContainsKey(userGuid))
			{
				await Clients.Caller.SendAsync("ReceiveMessage", "You are already connected. Only one connection is allowed.");

				throw new HubException("Only one connection allowed per user.");
			}

			if (_userConnections.Count > 0)
			{
				await Clients.Caller.SendAsync("ReceiveMessage", "Only one user can connect at a time.");
				throw new HubException("Only one user can connect at a time.");
			}
			_userConnections[userGuid] = Context.ConnectionId;

			await base.OnConnectedAsync();
		}

		public override Task OnDisconnectedAsync(Exception? exception)
		{
			var userGuid = Context.ConnectionId;
			_userConnections.TryRemove(userGuid, out _);
			return base.OnDisconnectedAsync(exception);
		}

		public async Task SendMessage(string targetUserGuid, string msg)
		{
			if (_userConnections.TryGetValue(targetUserGuid, out var connectionId))
			{
				await Clients.Client(connectionId).SendAsync("ReceiveMessage", msg);
			}
		}

		public async Task SendDateTimeToCaller(string msg)
		{
			await Clients.Caller.SendAsync("ReceiveMessage", msg);
		}

		public Task<string> GetConnectionIdAsync()
		{
			if (_userConnections.Count > 0)
			{
				var connectionId = _userConnections.Values.First();
				return Task.FromResult(connectionId);
			}

			return Task.FromResult<string>(null);
		}
				
	}
}
