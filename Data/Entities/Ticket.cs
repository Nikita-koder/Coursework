namespace Lab5_Identity.Data;

public class Ticket
{
    public Guid TicketId { get; set; }
    public Guid OrderId { get; set; }
    public int ShowtimeId { get; set; }
    public int SeatId { get; set; }
    public int TariffId { get; set; }
    public decimal Price { get; set; }
    public TicketStatus Status { get; set; } = TicketStatus.Reserved;

    public Order? Order { get; set; }
    public Showtime? Showtime { get; set; }
    public Seat? Seat { get; set; }
    public Tariff? Tariff { get; set; }
}
