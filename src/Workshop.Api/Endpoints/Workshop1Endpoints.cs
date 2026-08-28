using Microsoft.EntityFrameworkCore;
using Workshop.Api.Data;

namespace Workshop.Api.Endpoints;

public static class Workshop1Endpoints
{
    public static IEndpointRouteBuilder MapWorkshop1Endpoints(this IEndpointRouteBuilder app)
    {
        var group = app.MapGroup("/workshop1").WithTags("Workshop 1");

        // Intentionally over-fetches entities and related orders.
        group.MapGet("/customers-bad", async (LabDbContext db) =>
            await db.Customers
                .Include(c => c.Orders)
                .Take(100)
                .ToListAsync());

        // Better: projection and only required data.
        group.MapGet("/customers-good", async (LabDbContext db) =>
            await db.Customers
                .OrderBy(c => c.CustomerId)
                .Select(c => new
                {
                    c.CustomerId,
                    c.Name,
                    OrdersCount = c.Orders.Count()
                })
                .Take(100)
                .ToListAsync());

        // Demonstrates deferred execution.
        group.MapGet("/deferred/{city}", async (string city, LabDbContext db) =>
        {
            var query = db.Customers.Where(c => c.City == city);
            // No SQL has executed yet.
            var result = await query.Take(50).ToListAsync();
            return result;
        });

        return app;
    }
}
