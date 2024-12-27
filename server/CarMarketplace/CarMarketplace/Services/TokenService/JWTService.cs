using Microsoft.IdentityModel.Tokens;
using System.IdentityModel.Tokens.Jwt;
using System.Security.Claims;
using System.Text;

namespace CarMarketplace.Services.TokenService
{
    public class JWTService : ITokenService
    {
        private readonly IConfiguration _configuration;

        public JWTService(IConfiguration configuration)
        {
            _configuration = configuration ?? throw new ArgumentNullException(nameof(configuration));
        }

        public string GenerateToken(int userId)
        {
            var securityKey = new SymmetricSecurityKey(Encoding.UTF8.GetBytes(_configuration["Jwt:Key"]!));
            var credentials = new SigningCredentials(securityKey, SecurityAlgorithms.HmacSha256);

            List<Claim> claims = [
                new Claim(ClaimTypes.NameIdentifier, userId.ToString())
            ];

            var securityToken = new JwtSecurityToken(
                _configuration["Jwt:Issuer"],
                _configuration["Jwt:Issuer"],
                claims: claims,
                expires: DateTime.Now.AddMinutes(120),
                signingCredentials: credentials);

            var jwtToken = new JwtSecurityTokenHandler().WriteToken(securityToken);
            return jwtToken;
        }

        public int GetUserIdFromToken(string token)
        {
            var jwtToken = new JwtSecurityTokenHandler().ReadJwtToken(token);
            return int.Parse(jwtToken.Claims.First(claim => claim.Type == ClaimTypes.NameIdentifier).Value);
        }
    }
}
