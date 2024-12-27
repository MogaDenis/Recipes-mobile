using System.ComponentModel.DataAnnotations;

namespace CarMarketplace.Models.DTOs
{
    public class UserForLoginRegisterDTO
    {
        [MaxLength(20, ErrorMessage = "Username can't exceed 20 characters.")]
        public string UserName { get; } = string.Empty;
    }
}
