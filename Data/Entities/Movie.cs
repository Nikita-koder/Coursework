namespace Lab5_Identity.Data;

public class Movie
{
    public int MovieId { get; set; }
    public string Title { get; set; } = string.Empty;
    public string? Description { get; set; }
    public int DurationMinutes { get; set; }
    public string? AgeRating { get; set; }
    public DateTime? ReleaseDate { get; set; }
    public string? PosterUrl { get; set; }
    public bool IsActive { get; set; } = true;

    public ICollection<Showtime> Showtimes { get; set; } = new List<Showtime>();
}
