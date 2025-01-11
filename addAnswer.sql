CREATE PROCEDURE AddAbnswer
    @StudentID INT,
    @ExamID INT,
    @QuestionID int,
    @Answer NVARCHAR(1000)
   
AS
BEGIN
    IF EXISTS (
        SELECT 1
        FROM [dbo].[StudentAnswers]
        WHERE [StudentID] = @StudentID AND [ExamID] = @ExamID  AND [QuestionID] = @QuestionID
    )
    BEGIN
       update [dbo].[StudentAnswers] 
	   set [StudentAnswer]=@Answer
	   WHERE [StudentID] = @StudentID AND [ExamID] = @ExamID  AND [QuestionID] = @QuestionID
    END
    ELSE
    BEGIN
        RAISERROR ('You are not authorized to add questions to this course.', 16, 1);
    END
END;


grant exec on AddAbnswer to student

