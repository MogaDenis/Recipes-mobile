using CarMarketplace.Models.DTOs;
using CarMarketplace.Services.ListingService;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Data.SqlClient;

namespace CarMarketplace.Controllers
{
    [Route("api/Listings")]
    [ApiController]
    public class ListingController : Controller
    {
        private readonly IListingService _listingService;

        public ListingController(IListingService listingService)
        {
            _listingService = listingService ?? throw new ArgumentNullException(nameof(listingService));
        }

        [HttpGet("{listingId}")]
        public async Task<IActionResult> GetListingById(int listingId)
        {
            try
            {
                var listing = await _listingService.GetListingById(listingId);
                if (listing == null)
                {
                    return NotFound();
                }

                return Ok(listing);
            }
            catch (SqlException ex)
            {
                return StatusCode(500, "SQL Related Issue: " + ex.Message);
            }
            catch (Exception ex)
            {
                return StatusCode(500, "Internal Server Error: " + ex.Message);
            }
        }

        [HttpGet]
        public async Task<IActionResult> GetListings()
        {
            try
            {
                var listings = await _listingService.GetListings();
                return Ok(listings);
            }
            catch (SqlException ex)
            {
                return StatusCode(500, "SQL Related Issue: " + ex.Message);
            }
            catch (Exception ex)
            {
                return StatusCode(500, "Internal Server Error: " + ex.Message);
            }
        }

        [HttpPost]
        public async Task<IActionResult> PostListing([FromBody] ListingForAddUpdateDTO listing)
        {
            try
            {
                var newListing = await _listingService.AddListing(listing);
                if (newListing == null)
                { 
                    return BadRequest("Invalid listing!");
                }

                return Ok(newListing);
            }
            catch (SqlException ex)
            {
                return StatusCode(500, "SQL Related Issue: " + ex.Message);
            }
            catch (Exception ex)
            {
                return StatusCode(500, "Internal Server Error: " + ex.Message);
            }
        }

        [HttpPut("{listingId}")]
        public async Task<IActionResult> UpdateListing(int listingId, [FromBody] ListingForAddUpdateDTO listingData)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState.Values.First().Errors.First().ErrorMessage);
            }

            try
            {
                await _listingService.UpdateListing(listingId, listingData);
                return Ok();
            }
            catch (SqlException ex)
            {
                return StatusCode(500, "SQL Related Issue: " + ex.Message);
            }
            catch (Exception ex)
            {
                return StatusCode(500, "Internal Server Error: " + ex.Message);
            }
        }

        [HttpDelete("{listingId}")]
        public async Task<IActionResult> RemoveListing(int listingId)
        {
            try
            {
                await _listingService.RemoveListing(listingId);
                return Ok();
            }
            catch (SqlException ex)
            {
                return StatusCode(500, "SQL Related Issue: " + ex.Message);
            }
            catch (Exception ex)
            {
                return StatusCode(500, "Internal Server Error: " + ex.Message);
            }
        }
    }
}
