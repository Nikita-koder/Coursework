namespace Lab5_Identity.Data;

public enum SeatType
{
    Standard = 0,
    Vip = 1
}

public enum ShowtimeStatus
{
    Scheduled = 0,
    Cancelled = 1
}

public enum OrderStatus
{
    Reserved = 0,
    Paid = 1,
    Cancelled = 2,
    Expired = 3
}

public enum TicketStatus
{
    Reserved = 0,
    Paid = 1,
    Cancelled = 2
}

public enum PaymentStatus
{
    Pending = 0,
    Success = 1,
    Failed = 2
}
