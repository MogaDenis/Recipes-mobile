using CarMarketplace.Mappers.ListingMapper;
using CarMarketplace.Repositories.ListingRepository;
using CarMarketplace.Services.ListingService;
using CarMarketplace.Services.TokenService;
using CarMarketplace.Services.WebSocketConnectionManager;
using CarMarketplace.Services.WebSocketService;
using Microsoft.AspNetCore.Authentication.JwtBearer;
using Microsoft.IdentityModel.Tokens;
using System.Net.WebSockets;
using System.Text;

var builder = WebApplication.CreateBuilder(args);

var jwtIssuer = builder.Configuration.GetSection("Jwt:Issuer").Get<string>();
var jwtKey = builder.Configuration.GetSection("Jwt:Key").Get<string>();

builder.Services.AddAuthentication(JwtBearerDefaults.AuthenticationScheme)
    .AddJwtBearer(options =>
    {
        options.TokenValidationParameters = new TokenValidationParameters
        {
            ValidateIssuer = true,
            ValidateAudience = true,
            ValidateLifetime = true,
            ValidateIssuerSigningKey = true,
            ValidIssuer = jwtIssuer,
            ValidAudience = jwtIssuer,
            IssuerSigningKey = new SymmetricSecurityKey(Encoding.UTF8.GetBytes(jwtKey!))
        };
    });

// Inject mappers.
builder.Services.AddScoped<IListingMapper, ListingMapper>();

// Inject repositories.
builder.Services.AddScoped<IListingRepository, ListingRepository>();

// Inject services.
builder.Services.AddScoped<ITokenService, JWTService>();
builder.Services.AddScoped<IListingService, ListingService>();

builder.Services.AddSingleton<IWebSocketConnectionManager, WebSocketConnectionManager>();
builder.Services.AddSingleton<IWebSocketService, WebSocketService>();

builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen();

builder.Services.AddControllers();

var app = builder.Build();

app.UseCors(c => c.AllowAnyOrigin().AllowAnyHeader().AllowAnyMethod().WithExposedHeaders("Location"));

if (app.Environment.IsDevelopment())
{
    app.UseSwagger();
    app.UseSwaggerUI();
}

app.UseWebSockets();

//app.UseHttpsRedirection();

app.MapControllers();

app.Run();