CREATE PROCEDURE CreateRandomExam
    @ExamType NVARCHAR(50),
    @CourseID INT,
    @InstructorID INT,
    @IntakeID INT,
    @BranchID INT,
    @TrackID INT,
    @StartTime DATETIME,
    @TotalTime INT,
    @AllowanceOptions NVARCHAR(50),
    @NumMultipleChoice INT,
    @NumTrueFalse INT,
    @NumTextQuestions INT
AS
BEGIN
    SET NOCOUNT ON;

    -- Ensure the instructor teaches the specified course
    IF NOT EXISTS (SELECT 1 FROM [dbo].[InstructorCourses] WHERE CourseID = @CourseID AND InstructorID = @InstructorID)
    BEGIN
        RAISERROR('The specified instructor does not teach the specified course.', 16, 1);
        RETURN;
    END;


    DECLARE @ExamID INT;
    INSERT INTO Exams (ExamType, CourseID, InstructorID, IntakeID, BranchID, TrackID, StartTime, TotalTime, AllowanceOptions)
    VALUES (@ExamType, @CourseID, @InstructorID, @IntakeID, @BranchID, @TrackID, @StartTime, @TotalTime, @AllowanceOptions);

   
    SET @ExamID = SCOPE_IDENTITY();


    DECLARE @TotalDegrees INT = 0;
    DECLARE @QuestionDegree INT;

 
    DECLARE @NumQuestions INT;
    DECLARE @QuestionType NVARCHAR(50);
    DECLARE @QuestionsTable TABLE (QuestionID INT, QuestionDegree INT);

    -- Function to add questions of a specified type
  INSERT INTO @QuestionsTable (QuestionID, QuestionDegree)
    SELECT TOP (@NumMultipleChoice) QuestionID,5
    FROM Questions
    WHERE CourseID = @CourseID AND QuestionType = 'Multiple Choice'
    ORDER BY NEWID();

    INSERT INTO @QuestionsTable (QuestionID, QuestionDegree)
    SELECT TOP (@NumTrueFalse) QuestionID, 5
    FROM Questions
    WHERE CourseID = @CourseID AND QuestionType = 'True/False'
    ORDER BY NEWID();

    INSERT INTO @QuestionsTable (QuestionID, QuestionDegree)
    SELECT TOP (@NumTextQuestions) QuestionID, 5
    FROM Questions
    WHERE CourseID = @CourseID AND QuestionType = 'Text'
    ORDER BY NEWID();

    -- Insert selected questions into the ExamQuestions table
    DECLARE @QuestionID INT;
    DECLARE QuestionCursor CURSOR FOR
    SELECT QuestionID, QuestionDegree FROM @QuestionsTable;

    OPEN QuestionCursor;
    FETCH NEXT FROM QuestionCursor INTO @QuestionID, @QuestionDegree;

    WHILE @@FETCH_STATUS = 0
    BEGIN
        -- Ensure the total degrees do not exceed the course's maximum degree
        SET @TotalDegrees = @TotalDegrees + @QuestionDegree;

        IF @TotalDegrees > (SELECT MaxDegree FROM Courses WHERE CourseID = @CourseID)
        BEGIN
            RAISERROR('The total degrees for the selected questions exceed the course''s maximum degree.', 16, 1);
            CLOSE QuestionCursor;
            DEALLOCATE QuestionCursor;
            RETURN;
        END;

        -- Insert the question into the ExamQuestions table
        INSERT INTO ExamQuestions (ExamID, QuestionID, QuestionDegree)
        VALUES (@ExamID, @QuestionID, @QuestionDegree);

        FETCH NEXT FROM QuestionCursor INTO @QuestionID, @QuestionDegree;
    END;

    CLOSE QuestionCursor;
    DEALLOCATE QuestionCursor;

    PRINT 'Exam created successfully with ExamID = ' + CAST(@ExamID AS NVARCHAR(50));
END;