using CarMarketplace.Models;
using CarMarketplace.Models.DTOs;
using CarMarketplace.Repositories.ListingRepository;
using CarMarketplace.Services.TokenService;
using CarMarketplace.Services.WebSocketService;
using System.Diagnostics;

namespace CarMarketplace.Services.ListingService
{
    public class ListingService : IListingService
    {
        private readonly IListingRepository _repository;
        private readonly IConfiguration _configuration;
        private readonly ITokenService _tokenService;
        private readonly IWebSocketService _webSocketService;
        private readonly string _connectionString;

        public ListingService(
            IListingRepository repository, 
            IConfiguration configuration, 
            ITokenService tokenService, 
            IWebSocketService webSocketService
        ) 
        {
            _repository = repository ?? throw new ArgumentNullException(nameof(repository));
            _configuration = configuration ?? throw new ArgumentNullException(nameof(configuration));
            _tokenService = tokenService ?? throw new ArgumentNullException(nameof(tokenService));
            _webSocketService = webSocketService ?? throw new ArgumentNullException(nameof(webSocketService));
            _connectionString = _configuration.GetConnectionString("DefaultConnection") ?? throw new ArgumentNullException(nameof(configuration));
        }

        public async Task<Listing?> AddListing(ListingForAddUpdateDTO listing)
        {
            var addedListing = await _repository.AddListing(_connectionString, 1, listing);
            if (addedListing != null)
            {
                await _webSocketService.BroadcastListingChange(addedListing, "add");
            }

            return addedListing;
        }

        public Task<Listing?> GetListingById(int listingId)
        {
            return _repository.GetListingById(_connectionString, listingId);
        }

        public async Task<List<Listing>> GetListings()
        {
            return await _repository.GetListings(_connectionString);
        }

        public async Task UpdateListing(int listingId, ListingForAddUpdateDTO listingData)
        {
            var listingToUpdate = await GetListingById(listingId);
            if (listingToUpdate != null)
            {
                await _repository.UpdateListing(_connectionString, listingId, listingData);
                await _webSocketService.BroadcastListingChange(listingToUpdate, "update");
            }
        }

        public async Task RemoveListing(int listingId)
        {
            var listingToRemove = await GetListingById(listingId);
            if (listingToRemove != null)
            {
                await _repository.RemoveListing(_connectionString, listingId);
                await _webSocketService.BroadcastListingChange(listingToRemove, "delete");
            }
        }
    }
}
