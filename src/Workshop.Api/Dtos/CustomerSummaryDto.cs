namespace Workshop.Api.Dtos;

public sealed record CustomerSummaryDto(
    int CustomerId,
    string Name,
    int OrdersCount);
