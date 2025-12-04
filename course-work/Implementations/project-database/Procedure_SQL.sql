CREATE PROCEDURE CreateReservation
    @Field_Id INT,
    @User_Id INT,
    @Start_At DATETIME,
    @End_At DATETIME,
    @Notes VARCHAR(MAX) = NULL
AS
BEGIN
    SET NOCOUNT ON;

    IF EXISTS (
        SELECT 1 FROM Reservations
        WHERE Field_Id = @Field_Id
        AND Status != 'cancelled'
        AND (
            (@Start_At < End_At AND @End_At > Start_At) 
        )
    )
    BEGIN
        RAISERROR('Time slot is already reserved.', 16, 1);
        RETURN;
    END

    -- Insert reservation
    INSERT INTO Reservations (Field_Id, User_Id, Start_At, End_At, Notes)
    VALUES (@Field_Id, @User_Id, @Start_At, @End_At, @Notes);

    SELECT SCOPE_IDENTITY() AS NewReservationId;
END;
