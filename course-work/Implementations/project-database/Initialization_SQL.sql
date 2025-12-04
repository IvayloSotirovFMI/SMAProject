
CREATE TABLE Roles (
    Id INT IDENTITY(1,1) PRIMARY KEY,
    Name VARCHAR(50) NOT NULL UNIQUE,
    Description VARCHAR(255)
);

INSERT INTO Roles (Name, Description) VALUES
('Player', 'Играч / обикновен потребител'),
('Owner', 'Собственик на терен'),
('Admin', 'Администратор');



CREATE TABLE Users (
    Id INT IDENTITY(1,1) PRIMARY KEY,
    Role_Id INT NOT NULL,
    Email VARCHAR(50) NOT NULL UNIQUE,
    Display_Name VARCHAR(15),
    User_Password VARCHAR(20) NOT NULL,
    Phone VARCHAR(30),
    Created_At DATETIME NOT NULL DEFAULT GETDATE(),
    Updated_At DATETIME NOT NULL DEFAULT GETDATE(),
    Is_Active BIT NOT NULL DEFAULT 1,
    CONSTRAINT FK_Users_Roles FOREIGN KEY (Role_Id) REFERENCES Roles(Id)
);


CREATE TABLE Fields (
    Id INT IDENTITY(1,1) PRIMARY KEY,
    Owner_User_Id INT NOT NULL,
    Title VARCHAR(50) NOT NULL,
    Description TEXT,
    Address VARCHAR(100) NOT NULL,
    Contact_Phone VARCHAR(50) NOT NULL,
    Max_Players_Per_Team INT NOT NULL DEFAULT 7,
    Price_Per_Hour DECIMAL(8,2) NOT NULL DEFAULT 0.00,
    Currency VARCHAR(10) NOT NULL DEFAULT 'EUR',
    Is_Active BIT NOT NULL DEFAULT 0,
    Last_Updated DATETIME NOT NULL DEFAULT GETDATE(),
    Created_At DATETIME NOT NULL DEFAULT GETDATE(),
    CONSTRAINT FK_Fields_Owner FOREIGN KEY (Owner_User_Id) REFERENCES Users(Id)
);


CREATE TABLE Field_Photos (
    Id INT IDENTITY(1,1) PRIMARY KEY,
    Field_Id INT NOT NULL,
    Url VARCHAR(1000) NOT NULL,
    Caption VARCHAR(255),
    Uploaded_At DATETIME NOT NULL DEFAULT GETDATE(),
    CONSTRAINT FK_Photos_Field FOREIGN KEY (Field_Id) REFERENCES Fields(Id) ON DELETE CASCADE
);



CREATE TABLE Field_Availability (
    Id INT IDENTITY(1,1) PRIMARY KEY,
    Field_Id INT NOT NULL,
    Weekday TINYINT,
    Start_Time TIME NOT NULL,
    End_Time TIME NOT NULL,
    Special_Date DATE NULL,
    CONSTRAINT FK_Avail_Field FOREIGN KEY (Field_Id) REFERENCES Fields(Id) ON DELETE CASCADE,
    CONSTRAINT CK_Avail_Time CHECK (Start_Time < End_Time)
);



CREATE TABLE Reservations (
    Id INT IDENTITY(1,1) PRIMARY KEY,
    Field_Id INT NOT NULL,
    User_Id INT NOT NULL,
    Start_At DATETIME NOT NULL,
    End_At DATETIME NOT NULL,
    Created_At DATETIME NOT NULL DEFAULT GETDATE(),
    Status VARCHAR(20) NOT NULL DEFAULT 'pending',
    Total_Price DECIMAL(10,2) NOT NULL DEFAULT 0.00,
    Currency VARCHAR(10) NOT NULL DEFAULT 'EUR',
    Notes TEXT,
    Is_Paid BIT NOT NULL DEFAULT 0,

    CONSTRAINT CK_Res_Time CHECK (Start_At < End_At),
    CONSTRAINT CK_Res_Status CHECK (Status IN ('pending','confirmed','cancelled','completed')),

    CONSTRAINT FK_Res_Field FOREIGN KEY (Field_Id) REFERENCES Fields(Id) ON DELETE CASCADE,
    CONSTRAINT FK_Res_User FOREIGN KEY (User_Id) REFERENCES Users(Id) ON DELETE CASCADE
);


CREATE TABLE Payments (
    Id INT IDENTITY(1,1) PRIMARY KEY,
    Reservation_Id INT NOT NULL,
    User_Id INT NOT NULL,
    Amount DECIMAL(10,2) NOT NULL,
    Currency VARCHAR(10) NOT NULL DEFAULT 'EUR',
    Payment_Provider VARCHAR(100),
    Provider_Payment_Id VARCHAR(50),
    Status VARCHAR(20) NOT NULL DEFAULT 'initiated',
    Created_At DATETIME NOT NULL DEFAULT GETDATE(),
    Refunded_At DATETIME NULL,

    CONSTRAINT CK_Payment_Status CHECK (Status IN ('initiated','succeeded','failed','refunded')),

    CONSTRAINT FK_Pay_Res FOREIGN KEY (Reservation_Id) 
        REFERENCES Reservations(Id) ON DELETE CASCADE,

    CONSTRAINT FK_Pay_User FOREIGN KEY (User_Id) 
        REFERENCES Users(Id) 
        ON DELETE NO ACTION 
);
