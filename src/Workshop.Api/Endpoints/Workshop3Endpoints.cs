using Microsoft.EntityFrameworkCore;
using Workshop.Api.Data;

namespace Workshop.Api.Endpoints;

public static class Workshop3Endpoints
{
    public static IEndpointRouteBuilder MapWorkshop3Endpoints(this IEndpointRouteBuilder app)
    {
        var group = app.MapGroup("/workshop3").WithTags("Workshop 3");

        // Intentionally holds a transaction and an X lock for a long time.
        group.MapPost("/blocking/{orderId:int}", async (int orderId, LabDbContext db) =>
        {
            await using var tx = await db.Database.BeginTransactionAsync();

            var order = await db.Orders.SingleAsync(o => o.OrderId == orderId);
            order.Status = "Processing";
            await db.SaveChangesAsync();

            await Task.Delay(TimeSpan.FromSeconds(30));

            await tx.CommitAsync();

            return Results.Ok(new { orderId, status = order.Status });
        });

        // Use while /blocking/{id} is waiting.
        group.MapPost("/update/{orderId:int}", async (int orderId, string status, LabDbContext db) =>
        {
            var order = await db.Orders.SingleAsync(o => o.OrderId == orderId);
            order.Status = status;
            await db.SaveChangesAsync();
            return Results.Ok(new { orderId, status });
        });

        return app;
    }
}
