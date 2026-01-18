namespace Lab5_Identity.Data;

public class Hall
{
    public int HallId { get; set; }
    public int CinemaId { get; set; }
    public string Name { get; set; } = string.Empty;
    public int Rows { get; set; }
    public int SeatsPerRow { get; set; }
    public bool IsActive { get; set; } = true;

    public Cinema? Cinema { get; set; }
    public ICollection<Seat> Seats { get; set; } = new List<Seat>();
    public ICollection<Showtime> Showtimes { get; set; } = new List<Showtime>();
}
