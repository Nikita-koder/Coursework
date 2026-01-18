-- SQL скрипт для назначения роли Admin пользователю
-- Замените 'ваш_email@example.com' на email вашего пользователя

-- Шаг 1: Убедитесь, что роль Admin существует (она создаётся автоматически при запуске приложения)

-- Шаг 2: Найдите ID вашего пользователя и роли Admin
DECLARE @UserId NVARCHAR(450);
DECLARE @RoleId NVARCHAR(450);

-- Замените 'ваш_email@example.com' на email вашего пользователя
SELECT @UserId = Id FROM AspNetUsers WHERE Email = 'ваш_email@example.com';
SELECT @RoleId = Id FROM AspNetRoles WHERE Name = 'Admin';

-- Шаг 3: Проверьте, что пользователь и роль найдены
IF @UserId IS NULL
BEGIN
    PRINT 'Ошибка: Пользователь не найден. Проверьте email.';
    RETURN;
END

IF @RoleId IS NULL
BEGIN
    PRINT 'Ошибка: Роль Admin не найдена. Запустите приложение один раз, чтобы создать роль.';
    RETURN;
END

-- Шаг 4: Назначьте роль (если она еще не назначена)
IF NOT EXISTS (SELECT 1 FROM AspNetUserRoles WHERE UserId = @UserId AND RoleId = @RoleId)
BEGIN
    INSERT INTO AspNetUserRoles (UserId, RoleId)
    VALUES (@UserId, @RoleId);
    PRINT 'Роль Admin успешно назначена пользователю!';
END
ELSE
BEGIN
    PRINT 'Роль Admin уже назначена этому пользователю.';
END

-- Проверка: вывести всех пользователей с ролью Admin
SELECT 
    u.Email,
    u.UserName,
    r.Name AS RoleName
FROM AspNetUsers u
INNER JOIN AspNetUserRoles ur ON u.Id = ur.UserId
INNER JOIN AspNetRoles r ON ur.RoleId = r.Id
WHERE r.Name = 'Admin';
