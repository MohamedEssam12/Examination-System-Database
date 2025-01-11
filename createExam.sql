alter PROCEDURE CreateExam
    @ExamType NVARCHAR(50),
    @CourseID INT,
    @InstructorID INT,
    @IntakeID INT,
    @BranchID INT,
    @TrackID INT,
    @StartTime DATETIME,
    @EndTime DATETIME,
    @TotalTime INT,
    @AllowanceOptions NVARCHAR(50),
    @QuestionIDs nvarchar(max) = NULL -- This can be a comma-separated list of question IDs if questions are to be manually selected
AS
BEGIN
    SET NOCOUNT ON;
    
    -- Ensure the instructor teaches the specified course
    IF NOT EXISTS (SELECT 1 FROM [dbo].[InstructorCourses] WHERE CourseID = @CourseID AND InstructorID = @InstructorID)
    BEGIN
        RAISERROR('The specified instructor does not teach the specified course.', 16, 1);
        RETURN;
    END
    
    -- Insert the exam details into the Exams table
    DECLARE @ExamID INT;
    INSERT INTO Exams (ExamType, CourseID, InstructorID, IntakeID, BranchID, TrackID, StartTime, TotalTime, AllowanceOptions)
    VALUES (@ExamType, @CourseID, @InstructorID, @IntakeID, @BranchID, @TrackID, @StartTime, @TotalTime, @AllowanceOptions);
    
    -- Get the newly inserted ExamID
    SET @ExamID = SCOPE_IDENTITY();
    
    -- If question IDs are provided, assign questions to the exam
    IF @QuestionIDs IS NOT NULL
    BEGIN
        DECLARE @QuestionID INT;
        DECLARE @QuestionDegree INT;
        DECLARE @TotalDegrees INT = 0;
        
        -- Create a table variable to store question IDs
        DECLARE @QuestionIDTable TABLE (QuestionID int);
        
        -- Split the comma-separated list of question IDs into the table variable
        INSERT INTO @QuestionIDTable (QuestionID)
        SELECT cast(value as int) FROM STRING_SPLIT(@QuestionIDs, ',');
        
        -- Validate and insert each question for the exam
        DECLARE QuestionCursor CURSOR FOR
        SELECT QuestionID FROM @QuestionIDTable;
        
        OPEN QuestionCursor;
        FETCH NEXT FROM QuestionCursor INTO @QuestionID;
        
        WHILE @@FETCH_STATUS = 0
        BEGIN
            -- Get the degree for the question
            SELECT @QuestionDegree =[QuestionDegree]  FROM [dbo].[ExamQuestions] WHERE QuestionID = @QuestionID;
            
            -- Ensure the total degrees do not exceed the course's maximum degree
            SELECT @TotalDegrees = @TotalDegrees + @QuestionDegree;
            
            IF @TotalDegrees > (SELECT MaxDegree FROM Courses WHERE CourseID = @CourseID)
            BEGIN
                RAISERROR('The total degrees for the selected questions exceed the course''s maximum degree.', 16, 1);
              
                RETURN;
            END
            
            -- Insert the question into the ExamQuestions table
            INSERT INTO ExamQuestions (ExamID, QuestionID, QuestionDegree)
            VALUES (@ExamID, @QuestionID, @QuestionDegree);
            
            FETCH NEXT FROM QuestionCursor INTO @QuestionID;
        END
        
        CLOSE QuestionCursor;
        DEALLOCATE QuestionCursor;
    END
    
    PRINT 'Exam created successfully with ExamID = ' + CAST(@ExamID AS NVARCHAR(50));
END;


 




