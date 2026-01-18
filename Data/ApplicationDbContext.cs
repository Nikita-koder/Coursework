using Microsoft.AspNetCore.Identity.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore;

namespace Lab5_Identity.Data;

public class ApplicationDbContext(DbContextOptions<ApplicationDbContext> options) : IdentityDbContext<ApplicationUser>(options)
{
    public DbSet<Cinema> Cinemas => Set<Cinema>();
    public DbSet<Hall> Halls => Set<Hall>();
    public DbSet<Seat> Seats => Set<Seat>();
    public DbSet<Movie> Movies => Set<Movie>();
    public DbSet<Showtime> Showtimes => Set<Showtime>();
    public DbSet<Tariff> Tariffs => Set<Tariff>();
    public DbSet<Order> Orders => Set<Order>();
    public DbSet<Ticket> Tickets => Set<Ticket>();
    public DbSet<Payment> Payments => Set<Payment>();

    protected override void OnModelCreating(ModelBuilder builder)
    {
        base.OnModelCreating(builder);

        builder.Entity<Seat>()
            .HasIndex(seat => new { seat.HallId, seat.RowNumber, seat.SeatNumber })
            .IsUnique();

        builder.Entity<Ticket>()
            .HasIndex(ticket => new { ticket.ShowtimeId, ticket.SeatId })
            .IsUnique();

        builder.Entity<Payment>()
            .HasIndex(payment => payment.OrderId)
            .IsUnique();

        builder.Entity<Order>()
            .HasOne(order => order.User)
            .WithMany()
            .HasForeignKey(order => order.UserId);

        builder.Entity<Order>()
            .HasOne(order => order.Payment)
            .WithOne(payment => payment.Order)
            .HasForeignKey<Payment>(payment => payment.OrderId)
            .OnDelete(DeleteBehavior.Restrict);

        builder.Entity<Ticket>()
            .HasOne(ticket => ticket.Order)
            .WithMany(order => order.Tickets)
            .HasForeignKey(ticket => ticket.OrderId)
            .OnDelete(DeleteBehavior.Restrict);

        builder.Entity<Ticket>()
            .HasOne(ticket => ticket.Showtime)
            .WithMany(show => show.Tickets)
            .HasForeignKey(ticket => ticket.ShowtimeId)
            .OnDelete(DeleteBehavior.Restrict);

        builder.Entity<Ticket>()
            .HasOne(ticket => ticket.Seat)
            .WithMany(seat => seat.Tickets)
            .HasForeignKey(ticket => ticket.SeatId)
            .OnDelete(DeleteBehavior.Restrict);

        builder.Entity<Ticket>()
            .HasOne(ticket => ticket.Tariff)
            .WithMany(tariff => tariff.Tickets)
            .HasForeignKey(ticket => ticket.TariffId)
            .OnDelete(DeleteBehavior.Restrict);

        builder.Entity<Showtime>()
            .Property(show => show.BasePrice)
            .HasPrecision(10, 2);

        builder.Entity<Tariff>()
            .Property(tariff => tariff.PriceModifier)
            .HasPrecision(10, 2);

        builder.Entity<Ticket>()
            .Property(ticket => ticket.Price)
            .HasPrecision(10, 2);

        builder.Entity<Order>()
            .Property(order => order.TotalAmount)
            .HasPrecision(10, 2);

        builder.Entity<Payment>()
            .Property(payment => payment.Amount)
            .HasPrecision(10, 2);

        builder.Entity<Seat>()
            .Property(seat => seat.SeatType)
            .HasConversion<string>();

        builder.Entity<Showtime>()
            .Property(show => show.Status)
            .HasConversion<string>();

        builder.Entity<Order>()
            .Property(order => order.Status)
            .HasConversion<string>();

        builder.Entity<Ticket>()
            .Property(ticket => ticket.Status)
            .HasConversion<string>();

        builder.Entity<Payment>()
            .Property(payment => payment.Status)
            .HasConversion<string>();
    }
}
