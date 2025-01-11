alter FUNCTION dbo.fn_GetTotalCorrectAnswers
(
    @StudentID INT,
    @ExamID INT
)
RETURNS INT
AS
BEGIN
    DECLARE @TotalCorrectAnswers INT;

    SELECT @TotalCorrectAnswers = sum([Marks])
    FROM StudentAnswers AS SA
    
    WHERE SA.StudentID = @StudentID AND SA.ExamID = @ExamID AND SA.[IsCorrect] = 1;

    RETURN @TotalCorrectAnswers;
END;