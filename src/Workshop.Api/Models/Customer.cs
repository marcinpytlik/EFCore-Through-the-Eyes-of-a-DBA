namespace Workshop.Api.Models;

public sealed class Customer
{
    public int CustomerId { get; set; }
    public string Name { get; set; } = "";
    public string Email { get; set; } = "";
    public string City { get; set; } = "";
    public DateTime CreatedAt { get; set; }

    public List<Order> Orders { get; set; } = [];
}
