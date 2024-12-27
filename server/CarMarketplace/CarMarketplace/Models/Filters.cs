namespace CarMarketplace.Models
{
    public class Filters
    {
        public int MinPrice { get; set; } = int.MinValue;
        public int MaxPrice { get; set; } = int.MaxValue;
        public int Condition { get; set; } = 0;
        public string Brand { get; set; } = string.Empty;
        public string Model { get; set; } = string.Empty;
        public int FuelType { get; set; } = 0;
        public int BodyStyle { get; set; } = 0;
        public int MinManufactureYear { get; set; } = int.MinValue;
        public int MaxManufactureYear { get; set; } = int.MaxValue;
        public int MinMileage { get; set; } = int.MinValue;
        public int MaxMileage { get; set; } = int.MaxValue;
        public string Country { get; set; } = string.Empty;
        public string City { get; set; } = string.Empty;
    }
}
