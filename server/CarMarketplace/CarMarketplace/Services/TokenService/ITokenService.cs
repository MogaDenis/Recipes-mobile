namespace CarMarketplace.Services.TokenService
{
    public interface ITokenService
    {
        string GenerateToken(int userId);
        int GetUserIdFromToken(string token);
    }
}
