namespace CarMarketplace.Models
{
    public class Listing
    {
        public int ListingId { get; set; }
        public string Title { get; set; } = string.Empty;
        public string Description { get; set; } = string.Empty;
        public int Price { get; set; } = 1;
        public int Condition { get; set; } = 0;
        public string Brand { get; set; } = string.Empty;
        public string Model { get; set; } = string.Empty;
        public int FuelType { get; set; } = 0;
        public int BodyStyle { get; set; } = 0;
        public string Colour { get; set; } = string.Empty;
        public int ManufactureYear { get; set; } = 2000;
        public int Mileage { get; set;} = 0;
        public int EmissionStandard { get; set; } = 0;
        public int SellerId { get; set; } = 0;
        public string SellerName { get; set; } = string.Empty;
        public string Country { get; set; } = string.Empty;
        public string City { get; set; } = string.Empty;
        public DateOnly CreatedAt { get; set; }
        public string? ImagePath { get; set; }
    }
}
