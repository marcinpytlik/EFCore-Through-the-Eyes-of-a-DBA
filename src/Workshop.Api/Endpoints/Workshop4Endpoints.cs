using Microsoft.EntityFrameworkCore;
using Workshop.Api.Data;

namespace Workshop.Api.Endpoints;

public static class Workshop4Endpoints
{
    public static IEndpointRouteBuilder MapWorkshop4Endpoints(this IEndpointRouteBuilder app)
    {
        var group = app.MapGroup("/workshop4").WithTags("Workshop 4");

        // Intentionally expensive: load the full tracked graph + wide Notes column.
        // We shape the HTTP response only after materialization so the database workload
        // remains intentionally bad while avoiding entity-navigation JSON cycles.
        group.MapGet("/customer/{id:int}/orders-bad", async (int id, LabDbContext db) =>
        {
            var customer = await db.Customers
                .Include(c => c.Orders)
                    .ThenInclude(o => o.OrderLines)
                .SingleAsync(c => c.CustomerId == id);

            return Results.Ok(new
            {
                customer.CustomerId,
                customer.Name,
                customer.Email,
                customer.City,
                customer.CreatedAt,
                Orders = customer.Orders.Select(o => new
                {
                    o.OrderId,
                    o.CustomerId,
                    o.OrderDate,
                    o.Status,
                    o.TotalAmount,
                    o.Notes,
                    OrderLines = o.OrderLines.Select(l => new
                    {
                        l.OrderLineId,
                        l.OrderId,
                        l.ProductName,
                        l.Quantity,
                        l.UnitPrice
                    }).ToList()
                }).ToList()
            });
        });

        // Intentionally issues one extra query per order (N+1). Capped so the demo
        // stays visible in logs without hanging the class for minutes.
        group.MapGet("/customer/{id:int}/orders-nplus1", async (int id, LabDbContext db) =>
        {
            var customer = await db.Customers.SingleAsync(c => c.CustomerId == id);
            var orders = await db.Orders
                .Where(o => o.CustomerId == id)
                .OrderByDescending(o => o.OrderDate)
                .Take(50)
                .ToListAsync();

            var payload = new List<object>(orders.Count);
            foreach (var order in orders)
            {
                var lineCount = await db.OrderLines.CountAsync(l => l.OrderId == order.OrderId);
                payload.Add(new { order.OrderId, order.Status, lineCount });
            }

            return Results.Ok(new
            {
                customer.CustomerId,
                customer.Name,
                orders = payload,
                note = "Intentionally issues one extra query per order (N+1)."
            });
        });

        // Improved query shape. Hidden from Swagger so students diagnose first.
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
                .SingleAsync())
            .ExcludeFromDescription();

        return app;
    }
}
