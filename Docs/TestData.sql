-- SQL скрипт для заполнения тестовыми данными
-- База данных: Lab5_Identity
-- Использование: Выполнить скрипт целиком в SQL Server Management Studio или через sqlcmd

USE [Lab5_Identity]
GO

BEGIN TRANSACTION;

-- ============================================
-- 1. ТАРИФЫ (Tariffs)
-- ============================================
SET IDENTITY_INSERT [Tariffs] ON;

INSERT INTO [Tariffs] ([TariffId], [Name], [PriceModifier], [Description], [IsActive])
VALUES
    (1, N'Стандартный', 0.00, N'Базовый тариф без доплат', 1),
    (2, N'VIP', 150.00, N'Улучшенные места с повышенным комфортом', 1),
    (3, N'Льготный', -50.00, N'Скидка для студентов и пенсионеров', 1);

SET IDENTITY_INSERT [Tariffs] OFF;
GO

-- ============================================
-- 2. КИНОТЕАТРЫ (Cinemas)
-- ============================================
SET IDENTITY_INSERT [Cinemas] ON;

INSERT INTO [Cinemas] ([CinemaId], [Name], [Address], [City], [Phone], [IsActive])
VALUES
    (1, N'Кинотеатр Центральный', N'ул. Ленина, д. 10', N'Москва', N'+7 (495) 123-45-67', 1),
    (2, N'Кинотеатр Северный', N'пр. Мира, д. 25', N'Москва', N'+7 (495) 234-56-78', 1),
    (3, N'Кинотеатр Южный', N'ул. Победы, д. 5', N'Санкт-Петербург', N'+7 (812) 345-67-89', 1);

SET IDENTITY_INSERT [Cinemas] OFF;
GO

-- ============================================
-- 3. ЗАЛЫ (Halls)
-- ============================================
SET IDENTITY_INSERT [Halls] ON;

INSERT INTO [Halls] ([HallId], [CinemaId], [Name], [Rows], [SeatsPerRow], [IsActive])
VALUES
    -- Кинотеатр Центральный (CinemaId = 1)
    (1, 1, N'Зал 1', 10, 12, 1),
    (2, 1, N'Зал 2', 8, 10, 1),
    -- Кинотеатр Северный (CinemaId = 2)
    (3, 2, N'Зал 1', 12, 15, 1),
    (4, 2, N'VIP Зал', 6, 8, 1),
    -- Кинотеатр Южный (CinemaId = 3)
    (5, 3, N'Зал 1', 10, 12, 1);

SET IDENTITY_INSERT [Halls] OFF;
GO

-- ============================================
-- 4. МЕСТА (Seats)
-- ============================================
-- Генерация мест для каждого зала
-- SeatType: 0 = Standard, 1 = Vip

-- Зал 1 (HallId = 1): 10 рядов по 12 мест
INSERT INTO [Seats] ([HallId], [RowNumber], [SeatNumber], [SeatType], [IsActive])
SELECT 1, row_num, seat_num, 
    CASE WHEN row_num <= 2 THEN N'Vip' ELSE N'Standard' END AS SeatType, -- Первые 2 ряда VIP
    1
FROM (
    SELECT TOP 120 ROW_NUMBER() OVER (ORDER BY (SELECT NULL)) AS n
    FROM sys.objects
) AS nums
CROSS APPLY (
    SELECT 
        (n - 1) / 12 + 1 AS row_num,
        ((n - 1) % 12) + 1 AS seat_num
) AS calc;
GO

-- Зал 2 (HallId = 2): 8 рядов по 10 мест
INSERT INTO [Seats] ([HallId], [RowNumber], [SeatNumber], [SeatType], [IsActive])
SELECT 2, row_num, seat_num, N'Standard', 1
FROM (
    SELECT TOP 80 ROW_NUMBER() OVER (ORDER BY (SELECT NULL)) AS n
    FROM sys.objects
) AS nums
CROSS APPLY (
    SELECT 
        (n - 1) / 10 + 1 AS row_num,
        ((n - 1) % 10) + 1 AS seat_num
) AS calc;
GO

-- Зал 3 (HallId = 3): 12 рядов по 15 мест
INSERT INTO [Seats] ([HallId], [RowNumber], [SeatNumber], [SeatType], [IsActive])
SELECT 3, row_num, seat_num, 
    CASE WHEN row_num <= 3 THEN N'Vip' ELSE N'Standard' END AS SeatType, -- Первые 3 ряда VIP
    1
FROM (
    SELECT TOP 180 ROW_NUMBER() OVER (ORDER BY (SELECT NULL)) AS n
    FROM sys.objects CROSS JOIN sys.objects
) AS nums
CROSS APPLY (
    SELECT 
        (n - 1) / 15 + 1 AS row_num,
        ((n - 1) % 15) + 1 AS seat_num
) AS calc;
GO

-- VIP Зал 4 (HallId = 4): 6 рядов по 8 мест (все VIP)
INSERT INTO [Seats] ([HallId], [RowNumber], [SeatNumber], [SeatType], [IsActive])
SELECT 4, row_num, seat_num, N'Vip', 1
FROM (
    SELECT TOP 48 ROW_NUMBER() OVER (ORDER BY (SELECT NULL)) AS n
    FROM sys.objects
) AS nums
CROSS APPLY (
    SELECT 
        (n - 1) / 8 + 1 AS row_num,
        ((n - 1) % 8) + 1 AS seat_num
) AS calc;
GO

-- Зал 5 (HallId = 5): 10 рядов по 12 мест
INSERT INTO [Seats] ([HallId], [RowNumber], [SeatNumber], [SeatType], [IsActive])
SELECT 5, row_num, seat_num, N'Standard', 1
FROM (
    SELECT TOP 120 ROW_NUMBER() OVER (ORDER BY (SELECT NULL)) AS n
    FROM sys.objects
) AS nums
CROSS APPLY (
    SELECT 
        (n - 1) / 12 + 1 AS row_num,
        ((n - 1) % 12) + 1 AS seat_num
) AS calc;
GO

-- ============================================
-- 5. ФИЛЬМЫ (Movies)
-- ============================================
SET IDENTITY_INSERT [Movies] ON;

INSERT INTO [Movies] ([MovieId], [Title], [Description], [DurationMinutes], [AgeRating], [ReleaseDate], [PosterUrl], [IsActive])
VALUES
    (1, N'Ночной рейс', N'Погоня за тайной приводит героя в другой город, где каждая улица может стать ловушкой.', 110, N'16+', '2024-01-15', NULL, 1),
    (2, N'Свет звёзд', N'Космическая экспедиция ищет новый дом для человечества на далёкой планете.', 124, N'12+', '2024-02-20', NULL, 1),
    (3, N'Дом у моря', N'История семьи, которая снова учится быть вместе после долгой разлуки.', 98, N'12+', '2024-03-10', NULL, 1),
    (4, N'Скорость', N'Гонка со временем и опасными решениями, когда цена ошибки — человеческая жизнь.', 105, N'16+', '2024-04-05', NULL, 1),
    (5, N'Соседи', N'Новые жильцы превращают спокойную жизнь в настоящее приключение.', 92, N'12+', '2024-05-12', NULL, 1),
    (6, N'Тайна музея', N'Артефакт оживляет экспонаты и открывает тайны прошлого, которые должны были остаться скрытыми.', 115, N'6+', '2024-06-01', NULL, 1);

SET IDENTITY_INSERT [Movies] OFF;
GO

-- ============================================
-- 6. СЕАНСЫ (Showtimes)
-- ============================================
-- ShowtimeStatus хранится как строка: "Scheduled" или "Cancelled"
-- Вставляем сеансы на ближайшие дни

SET IDENTITY_INSERT [Showtimes] ON;

-- Сегодня и завтра (примеры дат, можно скорректировать)
DECLARE @Today DATETIME2 = CAST(GETDATE() AS DATE);
DECLARE @Tomorrow DATETIME2 = DATEADD(DAY, 1, @Today);
DECLARE @DayAfter DATETIME2 = DATEADD(DAY, 2, @Today);

-- Сегодня
INSERT INTO [Showtimes] ([ShowtimeId], [MovieId], [HallId], [StartAt], [EndAt], [BasePrice], [Status])
VALUES
    -- Кинотеатр Центральный, Зал 1
    (1, 1, 1, DATEADD(HOUR, 14, @Today), DATEADD(MINUTE, 110, DATEADD(HOUR, 14, @Today)), 250.00, N'Scheduled'),
    (2, 1, 1, DATEADD(HOUR, 18, @Today), DATEADD(MINUTE, 110, DATEADD(HOUR, 18, @Today)), 280.00, N'Scheduled'),
    (3, 2, 1, DATEADD(HOUR, 20, @Today), DATEADD(MINUTE, 124, DATEADD(HOUR, 20, @Today)), 300.00, N'Scheduled'),
    
    -- Кинотеатр Центральный, Зал 2
    (4, 3, 2, DATEADD(HOUR, 15, @Today), DATEADD(MINUTE, 98, DATEADD(HOUR, 15, @Today)), 220.00, N'Scheduled'),
    (5, 4, 2, DATEADD(HOUR, 17, @Today), DATEADD(MINUTE, 105, DATEADD(HOUR, 17, @Today)), 270.00, N'Scheduled'),
    
    -- Кинотеатр Северный, Зал 1
    (6, 5, 3, DATEADD(HOUR, 16, @Today), DATEADD(MINUTE, 92, DATEADD(HOUR, 16, @Today)), 200.00, N'Scheduled'),
    (7, 6, 3, DATEADD(HOUR, 19, @Today), DATEADD(MINUTE, 115, DATEADD(HOUR, 19, @Today)), 250.00, N'Scheduled'),

-- Завтра
    (8, 1, 1, DATEADD(HOUR, 14, @Tomorrow), DATEADD(MINUTE, 110, DATEADD(HOUR, 14, @Tomorrow)), 250.00, N'Scheduled'),
    (9, 2, 1, DATEADD(HOUR, 18, @Tomorrow), DATEADD(MINUTE, 124, DATEADD(HOUR, 18, @Tomorrow)), 300.00, N'Scheduled'),
    (10, 3, 2, DATEADD(HOUR, 15, @Tomorrow), DATEADD(MINUTE, 98, DATEADD(HOUR, 15, @Tomorrow)), 220.00, N'Scheduled'),
    (11, 4, 3, DATEADD(HOUR, 16, @Tomorrow), DATEADD(MINUTE, 105, DATEADD(HOUR, 16, @Tomorrow)), 270.00, N'Scheduled'),
    (12, 5, 4, DATEADD(HOUR, 19, @Tomorrow), DATEADD(MINUTE, 92, DATEADD(HOUR, 19, @Tomorrow)), 350.00, N'Scheduled'), -- VIP зал

-- Послезавтра
    (13, 6, 1, DATEADD(HOUR, 14, @DayAfter), DATEADD(MINUTE, 115, DATEADD(HOUR, 14, @DayAfter)), 250.00, N'Scheduled'),
    (14, 1, 2, DATEADD(HOUR, 17, @DayAfter), DATEADD(MINUTE, 110, DATEADD(HOUR, 17, @DayAfter)), 280.00, N'Scheduled'),
    (15, 2, 3, DATEADD(HOUR, 20, @DayAfter), DATEADD(MINUTE, 124, DATEADD(HOUR, 20, @DayAfter)), 300.00, N'Scheduled');

SET IDENTITY_INSERT [Showtimes] OFF;
GO

-- ============================================
-- Проверка данных
-- ============================================
SELECT 'Tariffs' AS TableName, COUNT(*) AS RecordCount FROM [Tariffs]
UNION ALL
SELECT 'Cinemas', COUNT(*) FROM [Cinemas]
UNION ALL
SELECT 'Halls', COUNT(*) FROM [Halls]
UNION ALL
SELECT 'Seats', COUNT(*) FROM [Seats]
UNION ALL
SELECT 'Movies', COUNT(*) FROM [Movies]
UNION ALL
SELECT 'Showtimes', COUNT(*) FROM [Showtimes];

COMMIT TRANSACTION;
GO

PRINT 'Тестовые данные успешно добавлены!';
GO
