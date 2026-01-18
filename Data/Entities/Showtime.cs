namespace Lab5_Identity.Data;

public class Showtime
{
    public int ShowtimeId { get; set; }
    public int MovieId { get; set; }
    public int HallId { get; set; }
    public DateTime StartAt { get; set; }
    public DateTime EndAt { get; set; }
    public decimal BasePrice { get; set; }
    public ShowtimeStatus Status { get; set; } = ShowtimeStatus.Scheduled;

    public Movie? Movie { get; set; }
    public Hall? Hall { get; set; }
    public ICollection<Ticket> Tickets { get; set; } = new List<Ticket>();
}
