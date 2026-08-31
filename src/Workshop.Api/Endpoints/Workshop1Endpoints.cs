using Microsoft.EntityFrameworkCore;
using Workshop.Api.Data;
using Workshop.Api.Dtos;
using Workshop.Api.Models;

namespace Workshop.Api.Endpoints;

public static class Workshop1Endpoints
{
    public static IEndpointRouteBuilder MapWorkshop1Endpoints(this IEndpointRouteBuilder app)
    {
        var group = app.MapGroup("/workshop1").WithTags("Workshop 1");

        // Intentionally over-fetches entities and related orders.
        // The database query remains intentionally wide, but the HTTP response is mapped
        // to a non-cyclic shape so JSON serialization does not follow Order -> Customer -> Orders.
        group.MapGet("/customers-bad", async (LabDbContext db) =>
        {
            var customers = await db.Customers
                .Include(c => c.Orders)
                .OrderBy(c => c.CustomerId)
                .Take(100)
                .ToListAsync();

            return customers.Select(c => new
            {
                c.CustomerId,
                c.Name,
                c.Email,
                c.City,
                c.CreatedAt,
                Orders = c.Orders.Select(o => new
                {
                    o.OrderId,
                    o.CustomerId,
                    o.OrderDate,
                    o.Status,
                    o.TotalAmount,
                    o.Notes
                })
            });
        });

        // Better: projection and only required data.
        group.MapGet("/customers-good", async (LabDbContext db) =>
            await db.Customers
                .OrderBy(c => c.CustomerId)
                .Select(c => new CustomerSummaryDto(
                    c.CustomerId,
                    c.Name,
                    c.Orders.Count()))
                .Take(100)
                .ToListAsync());

        // Demonstrates deferred execution: optional minId is composed onto the IQueryable
        // before materialization, so it appears in the final SQL.
        group.MapGet("/deferred/{city}", async (string city, int? minId, LabDbContext db) =>
        {
            IQueryable<Customer> query = db.Customers.Where(c => c.City == city);

            if (minId is > 0)
            {
                query = query.Where(c => c.CustomerId > minId.Value);
            }

            // No SQL has executed yet.
            var result = await query.OrderBy(c => c.CustomerId).Take(50).ToListAsync();
            return result;
        });

        return app;
    }
}
