namespace Lab5_Identity.Data;

public class Seat
{
    public int SeatId { get; set; }
    public int HallId { get; set; }
    public int RowNumber { get; set; }
    public int SeatNumber { get; set; }
    public SeatType SeatType { get; set; } = SeatType.Standard;
    public bool IsActive { get; set; } = true;

    public Hall? Hall { get; set; }
    public ICollection<Ticket> Tickets { get; set; } = new List<Ticket>();
}
