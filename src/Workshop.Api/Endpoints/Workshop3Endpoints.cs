using System.Data;
using Microsoft.Data.SqlClient;
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

        // LAB08: hold an uncommitted update, then roll it back.
        group.MapPost("/isolation/hold/{orderId:int}", async (int orderId, LabDbContext db) =>
        {
            await using var tx = await db.Database.BeginTransactionAsync();

            var order = await db.Orders.SingleAsync(o => o.OrderId == orderId);
            var previous = order.Status;
            order.Status = "Processing";
            await db.SaveChangesAsync();

            await Task.Delay(TimeSpan.FromSeconds(30));

            await tx.RollbackAsync();

            return Results.Ok(new
            {
                orderId,
                heldStatus = "Processing",
                rolledBackTo = previous
            });
        });

        group.MapGet("/isolation/read-committed/{orderId:int}", async (int orderId, LabDbContext db) =>
        {
            await using var tx = await db.Database.BeginTransactionAsync(IsolationLevel.ReadCommitted);
            var order = await db.Orders.AsNoTracking().SingleAsync(o => o.OrderId == orderId);
            await tx.CommitAsync();
            return Results.Ok(new { isolation = "ReadCommitted", order.OrderId, order.Status });
        });

        group.MapGet("/isolation/read-uncommitted/{orderId:int}", async (int orderId, LabDbContext db) =>
        {
            await using var tx = await db.Database.BeginTransactionAsync(IsolationLevel.ReadUncommitted);
            var order = await db.Orders.AsNoTracking().SingleAsync(o => o.OrderId == orderId);
            await tx.CommitAsync();
            return Results.Ok(new { isolation = "ReadUncommitted", order.OrderId, order.Status });
        });

        // LAB09: lock Customers then Orders.
        group.MapPost("/deadlock/session-a", async (LabDbContext db, int customerId = 1, int orderId = 1) =>
        {
            try
            {
                await using var tx = await db.Database.BeginTransactionAsync();

                var customer = await db.Customers.SingleAsync(c => c.CustomerId == customerId);
                customer.City = "Braganca";
                await db.SaveChangesAsync();

                await Task.Delay(TimeSpan.FromSeconds(5));

                var order = await db.Orders.SingleAsync(o => o.OrderId == orderId);
                order.Status = "Processing";
                await db.SaveChangesAsync();

                await tx.CommitAsync();
                return Results.Ok(new { session = "A", customerId, orderId, outcome = "committed" });
            }
            catch (Exception ex) when (IsDeadlock(ex))
            {
                return DeadlockVictim(ex, "A");
            }
        });

        // LAB09: lock Orders then Customers (reverse order).
        group.MapPost("/deadlock/session-b", async (LabDbContext db, int customerId = 1, int orderId = 1) =>
        {
            try
            {
                await using var tx = await db.Database.BeginTransactionAsync();

                var order = await db.Orders.SingleAsync(o => o.OrderId == orderId);
                order.Status = "Completed";
                await db.SaveChangesAsync();

                await Task.Delay(TimeSpan.FromSeconds(5));

                var customer = await db.Customers.SingleAsync(c => c.CustomerId == customerId);
                customer.City = "Warsaw";
                await db.SaveChangesAsync();

                await tx.CommitAsync();
                return Results.Ok(new { session = "B", customerId, orderId, outcome = "committed" });
            }
            catch (Exception ex) when (IsDeadlock(ex))
            {
                return DeadlockVictim(ex, "B");
            }
        });

        return app;
    }

    private static bool IsDeadlock(Exception ex) =>
        ex is SqlException sql && sql.Number == 1205
        || ex.InnerException is SqlException inner && inner.Number == 1205
        || ex.InnerException?.InnerException is SqlException nested && nested.Number == 1205;

    private static IResult DeadlockVictim(Exception ex, string session)
    {
        var sql = ex as SqlException
                  ?? ex.InnerException as SqlException
                  ?? ex.InnerException?.InnerException as SqlException;

        return Results.Conflict(new
        {
            session,
            outcome = "deadlock victim",
            sqlError = 1205,
            message = sql?.Message ?? ex.Message
        });
    }
}
