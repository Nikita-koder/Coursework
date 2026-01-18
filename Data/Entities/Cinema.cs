namespace Lab5_Identity.Data;

public class Cinema
{
    public int CinemaId { get; set; }
    public string Name { get; set; } = string.Empty;
    public string Address { get; set; } = string.Empty;
    public string City { get; set; } = string.Empty;
    public string? Phone { get; set; }
    public bool IsActive { get; set; } = true;

    public ICollection<Hall> Halls { get; set; } = new List<Hall>();
}
