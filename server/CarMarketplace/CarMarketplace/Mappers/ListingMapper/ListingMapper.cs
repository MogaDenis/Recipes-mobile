using CarMarketplace.Models;
using Microsoft.Data.SqlClient;

namespace CarMarketplace.Mappers.ListingMapper
{
    public class ListingMapper : IListingMapper
    {
        public async Task<List<Listing>> ConvertReaderToListings(SqlDataReader reader)
        {
            List<Listing> listings = [];

            while (await reader.ReadAsync())
            {
                Listing newListing = GetListingFromReader(reader);
                listings.Add(newListing);
            }

            return listings;
        }

        public async Task<Listing?> ConvertReaderToSingleListing(SqlDataReader reader)
        {
            var existsResult = await reader.ReadAsync();
            if (!existsResult)
            {
                return null;
            }

            return GetListingFromReader(reader);
        }

        private static Listing GetListingFromReader(SqlDataReader reader)
        {
            Listing newListing = new();

            if (!reader.IsDBNull(reader.GetOrdinal("ListingId")))
                newListing.ListingId = reader.GetInt32(reader.GetOrdinal("ListingId"));
            if (!reader.IsDBNull(reader.GetOrdinal("Title")))
                newListing.Title = reader.GetString(reader.GetOrdinal("Title"));
            if (!reader.IsDBNull(reader.GetOrdinal("Description")))
                newListing.Description = reader.GetString(reader.GetOrdinal("Description"));
            if (!reader.IsDBNull(reader.GetOrdinal("Price")))
                newListing.Price = reader.GetInt32(reader.GetOrdinal("Price"));
            if (!reader.IsDBNull(reader.GetOrdinal("Condition")))
                newListing.Condition = reader.GetInt32(reader.GetOrdinal("Condition"));
            if (!reader.IsDBNull(reader.GetOrdinal("Brand")))
                newListing.Brand = reader.GetString(reader.GetOrdinal("Brand"));
            if (!reader.IsDBNull(reader.GetOrdinal("Model")))
                newListing.Model = reader.GetString(reader.GetOrdinal("Model"));
            if (!reader.IsDBNull(reader.GetOrdinal("FuelType")))
                newListing.FuelType = reader.GetInt32(reader.GetOrdinal("FuelType"));
            if (!reader.IsDBNull(reader.GetOrdinal("BodyStyle")))
                newListing.BodyStyle = reader.GetInt32(reader.GetOrdinal("BodyStyle"));
            if (!reader.IsDBNull(reader.GetOrdinal("Colour")))
                newListing.Colour = reader.GetString(reader.GetOrdinal("Colour"));
            if (!reader.IsDBNull(reader.GetOrdinal("ManufactureYear")))
                newListing.ManufactureYear = reader.GetInt32(reader.GetOrdinal("ManufactureYear"));
            if (!reader.IsDBNull(reader.GetOrdinal("Mileage")))
                newListing.Mileage = reader.GetInt32(reader.GetOrdinal("Mileage"));
            if (!reader.IsDBNull(reader.GetOrdinal("EmissionStandard")))
                newListing.EmissionStandard = reader.GetInt32(reader.GetOrdinal("EmissionStandard"));
            if (!reader.IsDBNull(reader.GetOrdinal("CreatedAt")))
                newListing.CreatedAt = DateOnly.FromDateTime(reader.GetDateTime(reader.GetOrdinal("CreatedAt")));
            if (!reader.IsDBNull(reader.GetOrdinal("ImagePath")))
                newListing.ImagePath = reader.GetString(reader.GetOrdinal("ImagePath"));

            return newListing;
        }

    }
}
