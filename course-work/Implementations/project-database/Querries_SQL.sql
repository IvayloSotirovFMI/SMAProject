INSERT INTO Roles (Name, Description) VALUES
('Player', 'Играч / обикновен потребител'),
('Owner', 'Собственик на терен'),
('Admin', 'Администратор');

INSERT INTO Users (Role_Id, Email, Display_Name, User_Password, Phone)
VALUES
(1, 'player1@mail.com', 'OnziTam', 'Pass123A', '0887000001'),
(1, 'player2@mail.com', 'ToziTam', 'Pass123B', '0887000002'),
(1, 'player3@mail.com', 'EiGoTam', 'Pass123C', '0887000003'),

(2, 'owner1@mail.com', 'AntimParaliov', 'Owner123A', '0887111001'),
(2, 'owner2@mail.com', 'HristoParichkov', 'Owner123B', '0887111002'),

(3, 'admin@mail.com', 'Georgi Ivanov', 'Admin123A', '0887999000');


INSERT INTO Fields (Owner_User_Id, Title, Description, Address, Contact_Phone, 
                    Max_Players_Per_Team, Price_Per_Hour, Currency, Is_Active)
VALUES
(4, 'Arena Sofia', 'Професионално игрище с изкуствена трева', 'Sofia, Studentski grad', '0887111001', 7, 60.00, 'EUR', 1),
(4, 'Mini Football Park', 'Добро осветление и нова настилка', 'Sofia, Mladost 2', '0887111001', 5, 40.00, 'EUR', 1),
(5, 'Varna Mini Football ', 'Малко игрище до плажа', 'Varna, Sea Garden', '0887111002', 5, 35.00, 'EUR', 0);


INSERT INTO Field_Photos (Field_Id, Url, Caption)
VALUES
-- Arena Sofia
(1, 'https://example.com/arena1.jpg', 'Main view'),
(1, 'https://example.com/arena2.jpg', 'Side view'),
(1, 'https://example.com/arena3.jpg', 'Night lights'),

-- Mini Football Park
(2, 'https://example.com/mini1.jpg', 'Entrance'),
(2, 'https://example.com/mini2.jpg', 'Field view'),
(2, 'https://example.com/mini3.jpg', 'Goal area'),

-- Varna Stadium
(3, 'https://example.com/varna1.jpg', 'Sea view'),
(3, 'https://example.com/varna2.jpg', 'Side shot'),
(3, 'https://example.com/varna3.jpg', 'Top view');



INSERT INTO Field_Availability (Field_Id, Weekday, Start_Time, End_Time)
VALUES
-- Arena Sofia (Всеки ден 09:00 – 23:00)
(1, 1, '09:00', '23:00'),
(1, 2, '09:00', '23:00'),
(1, 3, '09:00', '23:00'),
(1, 4, '09:00', '23:00'),
(1, 5, '09:00', '23:00'),
(1, 6, '09:00', '23:00'),
(1, 0, '09:00', '23:00'),

-- Mini Football Park (10:00 – 22:00)
(2, 1, '10:00', '22:00'),
(2, 2, '10:00', '22:00'),
(2, 3, '10:00', '22:00'),
(2, 4, '10:00', '22:00'),
(2, 5, '10:00', '22:00');

INSERT INTO Reservations (Field_Id, User_Id, Start_At, End_At, Status, Total_Price, Currency, Is_Paid)
VALUES
(1, 1, '2025-01-20 18:00', '2025-01-20 19:30', 'confirmed', 90.00, 'EUR', 1),
(1, 2, '2025-01-21 20:00', '2025-01-21 21:00', 'pending', 60.00, 'EUR', 0),
(2, 3, '2025-01-22 17:00', '2025-01-22 18:00', 'completed', 40.00, 'EUR', 1),
(3, 1, '2025-01-25 16:00', '2025-01-25 17:30', 'cancelled', 0.00, 'EUR', 0);

INSERT INTO Payments (Reservation_Id, User_Id, Amount, Currency, Payment_Provider, Provider_Payment_Id, Status)
VALUES
(1, 1, 90.00, 'EUR', 'CashApp', 'PAY123123', 'succeeded'),
(3, 3, 40.00, 'EUR', 'PayPal', 'PP932003', 'succeeded');

