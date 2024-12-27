using CarMarketplace.Models;
using CarMarketplace.Models.DTOs;

namespace CarMarketplace.Repositories.ListingRepository
{
    public interface IListingRepository
    {
        Task<Listing?> AddListing(string connectionString, int sellerId, ListingForAddUpdateDTO listing);
        Task<Listing?> GetListingById(string connectionString, int listingId);
        Task<List<Listing>> GetListings(string connectionString);
        Task UpdateListing(string connectionString, int listingId, ListingForAddUpdateDTO listingData);
        Task RemoveListing(string connectionString, int listingId);
    }
}
