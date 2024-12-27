using CarMarketplace.Mappers.ListingMapper;
using CarMarketplace.Models;
using CarMarketplace.Models.DTOs;
using Microsoft.Data.SqlClient;
using System.Data;
using System.Reflection;

namespace CarMarketplace.Repositories.ListingRepository
{
    public class ListingRepository : IListingRepository
    {
        private readonly IListingMapper _mapper;

        public ListingRepository(IListingMapper mapper)
        {
            _mapper = mapper ?? throw new ArgumentNullException(nameof(mapper));
        }

        public async Task<Listing?> AddListing(string connectionString, int sellerId, ListingForAddUpdateDTO listing)
        {
            using (SqlConnection connection = new(connectionString))
            {
                await connection.OpenAsync();

                SqlCommand command = new("sp_Add_Listing", connection)
                {
                    CommandType = CommandType.StoredProcedure
                };

                command.Parameters.Add(new SqlParameter("@Title", listing.Title));
                command.Parameters.Add(new SqlParameter("@Description", listing.Description));
                command.Parameters.Add(new SqlParameter("@Price", listing.Price));
                command.Parameters.Add(new SqlParameter("@Condition", listing.Condition));
                command.Parameters.Add(new SqlParameter("@Brand", listing.Brand));
                command.Parameters.Add(new SqlParameter("@Model", listing.Model));
                command.Parameters.Add(new SqlParameter("@FuelType", listing.FuelType));
                command.Parameters.Add(new SqlParameter("@BodyStyle", listing.BodyStyle));
                command.Parameters.Add(new SqlParameter("@Colour", listing.Colour));
                command.Parameters.Add(new SqlParameter("@ManufactureYear", listing.ManufactureYear));
                command.Parameters.Add(new SqlParameter("@Mileage", listing.Mileage));
                command.Parameters.Add(new SqlParameter("@EmissionStandard", listing.EmissionStandard));
                command.Parameters.Add(new SqlParameter("@ImagePath", listing.ImagePath != null ? listing.ImagePath : DBNull.Value));

                using (SqlDataReader reader = await command.ExecuteReaderAsync())
                {
                    return await _mapper.ConvertReaderToSingleListing(reader);
                }
            }
        }

        public async Task<Listing?> GetListingById(string connectionString, int listingId)
        {
            using (SqlConnection connection = new(connectionString))
            {
                await connection.OpenAsync();

                SqlCommand command = new("sp_Get_Listing_by_Id", connection)
                {
                    CommandType = CommandType.StoredProcedure
                };

                command.Parameters.Add(new SqlParameter("@ListingId", listingId));

                using (SqlDataReader reader = await command.ExecuteReaderAsync())
                {
                    return await _mapper.ConvertReaderToSingleListing(reader);
                }
            }
        }

        public async Task<List<Listing>> GetListings(string connectionString)
        {
            using (SqlConnection connection = new(connectionString))
            {
                await connection.OpenAsync();

                SqlCommand command = new("sp_Get_Listings", connection)
                {
                    CommandType = CommandType.StoredProcedure
                };

                using (SqlDataReader reader = await command.ExecuteReaderAsync()) 
                {
                    return await _mapper.ConvertReaderToListings(reader);
                }
            }
        }

        public async Task UpdateListing(string connectionString, int listingId, ListingForAddUpdateDTO listingData)
        {
            using (SqlConnection connection = new(connectionString))
            {
                await connection.OpenAsync();

                SqlCommand command = new("sp_Update_Listing", connection)
                {
                    CommandType = CommandType.StoredProcedure
                };

                command.Parameters.Add(new SqlParameter("@ListingId", listingId));
                command.Parameters.Add(new SqlParameter("@Title", listingData.Title));
                command.Parameters.Add(new SqlParameter("@Description", listingData.Description));
                command.Parameters.Add(new SqlParameter("@Price", listingData.Price));
                command.Parameters.Add(new SqlParameter("@Condition", listingData.Condition));
                command.Parameters.Add(new SqlParameter("@Brand", listingData.Brand));
                command.Parameters.Add(new SqlParameter("@Model", listingData.Model));
                command.Parameters.Add(new SqlParameter("@FuelType", listingData.FuelType));
                command.Parameters.Add(new SqlParameter("@BodyStyle", listingData.BodyStyle));
                command.Parameters.Add(new SqlParameter("@Colour", listingData.Colour));
                command.Parameters.Add(new SqlParameter("@ManufactureYear", listingData.ManufactureYear));
                command.Parameters.Add(new SqlParameter("@Mileage", listingData.Mileage));
                command.Parameters.Add(new SqlParameter("@EmissionStandard", listingData.EmissionStandard));
                command.Parameters.Add(new SqlParameter("@ImagePath", listingData.ImagePath != null ? listingData.ImagePath : DBNull.Value));
                await command.ExecuteNonQueryAsync();
            }
        }

        public async Task RemoveListing(string connectionString, int listingId)
        {
            using (SqlConnection connection = new(connectionString))
            {
                await connection.OpenAsync();

                SqlCommand command = new("sp_Remove_Listing", connection)
                {
                    CommandType = CommandType.StoredProcedure
                };

                command.Parameters.Add(new SqlParameter("@ListingId", listingId));

                await command.ExecuteNonQueryAsync();
            }
        }
    }
}
