using Microsoft.EntityFrameworkCore;
using Workshop.Api.Data;
using Workshop.Api.Endpoints;

var builder = WebApplication.CreateBuilder(args);

builder.Services.AddDbContext<LabDbContext>(options =>
{
    options.UseSqlServer(builder.Configuration.GetConnectionString("LabDb"));
    options.EnableDetailedErrors();
    options.EnableSensitiveDataLogging();
});

builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen();

var app = builder.Build();

app.UseSwagger();
app.UseSwaggerUI();

app.MapGet("/", () => Results.Ok(new
{
    workshop = "EF Core Through the Eyes of a DBA",
    database = "EfCoreDbaLab",
    swagger = "/swagger",
    hotCustomerId = 123
}));

app.MapWorkshop1Endpoints();
app.MapWorkshop2Endpoints();
app.MapWorkshop3Endpoints();
app.MapWorkshop4Endpoints();

app.Run();
