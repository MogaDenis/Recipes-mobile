using System.Net.WebSockets;

namespace CarMarketplace.Services.WebSocketConnectionManager
{
    public interface IWebSocketConnectionManager
    {
        void AddConnection(string id, WebSocket socket);
        void RemoveConnection(string id);
        IEnumerable<WebSocket> GetAllConnections();
    }
}
