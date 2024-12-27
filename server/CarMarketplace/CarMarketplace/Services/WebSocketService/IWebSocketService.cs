using CarMarketplace.Models;

namespace CarMarketplace.Services.WebSocketService
{
    public interface IWebSocketService
    {
        Task BroadcastListingChange(Listing listing, string action);
    }
}
