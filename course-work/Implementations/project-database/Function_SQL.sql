CREATE FUNCTION CalcPrice (
    @Field_Id INT,
    @Start_At DATETIME,
    @End_At DATETIME
)
RETURNS DECIMAL(10,2)
AS
BEGIN
    DECLARE @Hours DECIMAL(10,2);
    DECLARE @Price DECIMAL(10,2);

    SET @Hours = DATEDIFF(MINUTE, @Start_At, @End_At) / 60.0;
   
    SELECT @Price = Price_Per_Hour FROM Fields WHERE Id = @Field_Id;

    RETURN @Hours * @Price;
END;