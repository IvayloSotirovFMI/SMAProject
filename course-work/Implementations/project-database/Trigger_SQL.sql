CREATE TRIGGER TR_Field_Activate_Check
ON Fields
FOR UPDATE
AS
BEGIN
    IF EXISTS (
        SELECT 1
        FROM inserted i
        JOIN Fields f ON f.Id = i.Id
        WHERE i.Is_Active = 1 AND
              (SELECT COUNT(*) FROM Field_Photos WHERE Field_Id = i.Id) < 3
    )
    BEGIN
        RAISERROR('Field cannot be activated. At least 3 photos are required.', 16, 1);
        ROLLBACK TRANSACTION;
        RETURN;
    END
END;