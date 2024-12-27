using CarMarketplace.Models;
using Microsoft.Data.SqlClient;

namespace CarMarketplace.Mappers.ListingMapper
{
    public interface IListingMapper
    {
        Task<List<Listing>> ConvertReaderToListings(SqlDataReader reader);
        Task<Listing?> ConvertReaderToSingleListing(SqlDataReader reader);
    }
}
