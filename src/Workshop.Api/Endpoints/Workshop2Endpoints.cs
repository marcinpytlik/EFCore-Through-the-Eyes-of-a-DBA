using Microsoft.EntityFrameworkCore;
using Workshop.Api.Data;

namespace Workshop.Api.Endpoints;

public static class Workshop2Endpoints
{
    public static IEndpointRouteBuilder MapWorkshop2Endpoints(this IEndpointRouteBuilder app)
    {
        var group = app.MapGroup("/workshop2").WithTags("Workshop 2");

        group.MapGet("/orders/customer/{customerId:int}", async (int customerId, LabDbContext db) =>
            await db.Orders
                .Where(o => o.CustomerId == customerId)
                .OrderByDescending(o => o.OrderDate)
                .ToListAsync());

        group.MapGet("/orders/customer/{customerId:int}/projection", async (int customerId, LabDbContext db) =>
            await db.Orders
                .Where(o => o.CustomerId == customerId)
                .OrderByDescending(o => o.OrderDate)
                .Select(o => new
                {
                    o.OrderId,
                    o.OrderDate,
                    o.Status,
                    o.TotalAmount
                })
                .ToListAsync());

        return app;
    }
}
