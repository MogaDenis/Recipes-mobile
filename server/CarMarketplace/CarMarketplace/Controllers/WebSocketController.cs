using CarMarketplace.Services.WebSocketConnectionManager;
using Microsoft.AspNetCore.Mvc;
using System.Net.WebSockets;
using System.Text;

namespace CarMarketplace.Controllers
{
    public class WebSocketController : Controller
    {
        private readonly IWebSocketConnectionManager _connectionManager;

        public WebSocketController(IWebSocketConnectionManager connectionManager)
        {
            _connectionManager = connectionManager ?? throw new ArgumentNullException(nameof(connectionManager));
        }

        [Route("/ws")]
        [HttpGet]
        public async Task Get()
        {
            if (HttpContext.WebSockets.IsWebSocketRequest)
            {
                using var webSocket = await HttpContext.WebSockets.AcceptWebSocketAsync();
                var connectionId = Guid.NewGuid().ToString();

                _connectionManager.AddConnection(connectionId, webSocket);

                // Keep the connection alive and listen for incoming messages
                await ListenToWebSocket(connectionId, webSocket);
            }
            else
            {
                HttpContext.Response.StatusCode = StatusCodes.Status400BadRequest;
            }
        }

        private async Task ListenToWebSocket(string connectionId, WebSocket webSocket)
        {
            var buffer = new byte[1024 * 4];

            try
            {
                while (webSocket.State == WebSocketState.Open)
                {
                    var result = await webSocket.ReceiveAsync(new ArraySegment<byte>(buffer), CancellationToken.None);

                    if (result.MessageType == WebSocketMessageType.Close)
                    {
                        await webSocket.CloseAsync(WebSocketCloseStatus.NormalClosure, "Closing", CancellationToken.None);
                        _connectionManager.RemoveConnection(connectionId);
                    }
                    else if (result.MessageType == WebSocketMessageType.Text)
                    {
                        // Optionally process incoming messages
                        var message = Encoding.UTF8.GetString(buffer, 0, result.Count);
                        Console.WriteLine($"Received: {message}");
                    }
                }
            }
            catch (Exception ex)
            {
                Console.WriteLine($"WebSocket error: {ex.Message}");
                _connectionManager.RemoveConnection(connectionId);
            }
        }
    }
}
