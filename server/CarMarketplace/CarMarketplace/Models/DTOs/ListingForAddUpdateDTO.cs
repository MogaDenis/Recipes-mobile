using System.ComponentModel.DataAnnotations;

namespace CarMarketplace.Models.DTOs
{
    public class ListingForAddUpdateDTO
    {
        [Required]
        [MaxLength(100, ErrorMessage = "Title length can't exceed 100 characters.")]
        public string Title { get; set; } = string.Empty;

        public string Description { get; set; } = string.Empty;

        [Required]
        [Range(1, int.MaxValue, ErrorMessage = "The price must be at least 1.")]
        public int Price { get; set; } = 1;

        public int Condition { get; set; } = 0;

        [Required]
        [MaxLength(100, ErrorMessage = "The brand of the car can't exceed 100 characters.")]
        public string Brand { get; set; } = string.Empty;

        [Required]
        [MaxLength(100, ErrorMessage = "The brand of the car can't exceed 100 characters.")]
        public string Model { get; set; } = string.Empty;

        [Required]
        public int FuelType { get; set; } = 0;

        [Required]
        public int BodyStyle { get; set; } = 0;

        [Required]
        [MaxLength(100, ErrorMessage = "The length of the colour can't exceed 100 characters.")]
        public string Colour { get; set; } = string.Empty;

        [Required]
        [Range(1900, 2100, ErrorMessage = "The given year is invalid.")]
        public int ManufactureYear { get; set; } = 2000;

        [Required]
        [Range(0, int.MaxValue, ErrorMessage = "The mileage can't be a negative number.")]
        public int Mileage { get; set; } = 0;

        public int EmissionStandard { get; set; } = 0;

        public string? ImagePath { get; set; }
    }
}