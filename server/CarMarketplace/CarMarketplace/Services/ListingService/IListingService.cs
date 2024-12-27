using CarMarketplace.Models;
using CarMarketplace.Models.DTOs;

namespace CarMarketplace.Services.ListingService
{
    public interface IListingService
    {
        Task<Listing?> GetListingById(int listingId);
        Task<List<Listing>> GetListings();
        Task<Listing?> AddListing(ListingForAddUpdateDTO listing);
        Task UpdateListing(int listingId, ListingForAddUpdateDTO listingData);
        Task RemoveListing(int listingId);
    }
}
