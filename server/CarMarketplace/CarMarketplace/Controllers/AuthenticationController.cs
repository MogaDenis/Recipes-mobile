using CarMarketplace.Models.DTOs;
using CarMarketplace.Services.TokenService;
using Microsoft.AspNetCore.Mvc;

namespace CarMarketplace.Controllers
{
    [ApiController]
    [Route("api/Auth")]
    public class AuthenticationController : Controller
    {
        private readonly ITokenService _tokenService;

        public AuthenticationController(ITokenService tokenService)
        {
            _tokenService = tokenService ?? throw new ArgumentNullException(nameof(tokenService));
        }

        [HttpPost("login")]
        public IActionResult Login([FromBody] UserForLoginRegisterDTO user)
        {
            try
            {
                var token = _tokenService.GenerateToken(1);
                return Ok(token);
            }
            catch (Exception ex)
            {
                return StatusCode(500, "Internal Server Error: " + ex.Message);
            }
        }
    }
}
