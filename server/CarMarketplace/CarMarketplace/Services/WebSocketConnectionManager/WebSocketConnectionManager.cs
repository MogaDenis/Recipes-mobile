using System.Net.WebSockets;

namespace CarMarketplace.Services.WebSocketConnectionManager
{
    public class WebSocketConnectionManager : IWebSocketConnectionManager
    {
        private readonly Dictionary<string, WebSocket> _connections = [];

        public void AddConnection(string id, WebSocket socket)
        {
            _connections.Add(id, socket);
        }

        public void RemoveConnection(string id)
        {
            _connections.Remove(id);
        }

        public IEnumerable<WebSocket> GetAllConnections()
        {
            return _connections.Values;
        }
    }
}
