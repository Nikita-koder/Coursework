namespace Lab5_Identity.Data;

public class Order
{
    public Guid OrderId { get; set; }
    public string UserId { get; set; } = string.Empty;
    public OrderStatus Status { get; set; } = OrderStatus.Reserved;
    public decimal TotalAmount { get; set; }
    public DateTime ReservedAt { get; set; }
    public DateTime? ExpiresAt { get; set; }

    public ApplicationUser? User { get; set; }
    public ICollection<Ticket> Tickets { get; set; } = new List<Ticket>();
    public Payment? Payment { get; set; }
}
