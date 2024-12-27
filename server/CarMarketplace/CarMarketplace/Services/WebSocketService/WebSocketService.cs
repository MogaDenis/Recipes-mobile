using CarMarketplace.Models;
using CarMarketplace.Services.WebSocketConnectionManager;
using System.Net.WebSockets;
using System.Text;
using System.Text.Json;

namespace CarMarketplace.Services.WebSocketService
{
    public class WebSocketService : IWebSocketService
    {
        private readonly IWebSocketConnectionManager _connectionManager;

        public WebSocketService(IWebSocketConnectionManager connectionManager)
        {
            _connectionManager = connectionManager ?? throw new ArgumentNullException(nameof(connectionManager));
        }

        public async Task BroadcastListingChange(Listing listing, string action)
        {
            var message = JsonSerializer.Serialize(new
            {
                Action = action,
                Data = listing
            });

            var tasks = _connectionManager.GetAllConnections().Select(socket =>
                socket.SendAsync(
                    new ArraySegment<byte>(Encoding.UTF8.GetBytes(message)),
                    WebSocketMessageType.Text,
                    true,
                    CancellationToken.None
                )
            );

            await Task.WhenAll(tasks);
        }
    }
}
