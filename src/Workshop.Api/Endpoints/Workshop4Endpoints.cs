using Microsoft.EntityFrameworkCore;
using Workshop.Api.Data;

namespace Workshop.Api.Endpoints;

public static class Workshop4Endpoints
{
    public static IEndpointRouteBuilder MapWorkshop4Endpoints(this IEndpointRouteBuilder app)
    {
        var group = app.MapGroup("/workshop4").WithTags("Workshop 4");

        // Intentionally expensive: full graph + large notes column.
        group.MapGet("/customer/{id:int}/orders-bad", async (int id, LabDbContext db) =>
            await db.Customers
                .Include(c => c.Orders)
                    .ThenInclude(o => o.OrderLines)
                .SingleAsync(c => c.CustomerId == id));

        // Improved query shape.
        group.MapGet("/customer/{id:int}/orders-good", async (int id, LabDbContext db) =>
            await db.Customers
                .Where(c => c.CustomerId == id)
                .Select(c => new
                {
                    c.CustomerId,
                    c.Name,
                    Orders = c.Orders
                        .OrderByDescending(o => o.OrderDate)
                        .Select(o => new
                        {
                            o.OrderId,
                            o.OrderDate,
                            o.Status,
                            o.TotalAmount
                        })
                        .ToList()
                })
                .SingleAsync());

        return app;
    }
}
