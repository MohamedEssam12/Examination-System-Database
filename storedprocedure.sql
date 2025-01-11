CREATE PROCEDURE AddQuestion
    @InstructorID INT,
    @CourseID INT,
    @QuestionType NVARCHAR(20),
    @QuestionContent NVARCHAR(1000),
    @CorrectAnswer NVARCHAR(1000),
    @BestAcceptedAnswer NVARCHAR(1000)
AS
BEGIN
    IF EXISTS (
        SELECT 1
        FROM InstructorCourses
        WHERE InstructorID = @InstructorID AND CourseID = @CourseID
    )
    BEGIN
        INSERT INTO Questions (CourseID, QuestionType, QuestionContent, CorrectAnswer, BestAcceptedAnswer)
        VALUES (@CourseID, @QuestionType, @QuestionContent, @CorrectAnswer, @BestAcceptedAnswer);
    END
    ELSE
    BEGIN
        RAISERROR ('You are not authorized to add questions to this course.', 16, 1);
    END
END;

go
CREATE PROCEDURE UpdateQuestion
    @InstructorID INT,
    @QuestionID INT,
    @QuestionType NVARCHAR(20),
    @QuestionContent NVARCHAR(1000),
    @CorrectAnswer NVARCHAR(1000),
    @BestAcceptedAnswer NVARCHAR(1000)
AS
BEGIN
    IF EXISTS (
        SELECT 1
        FROM Questions Q
        JOIN InstructorCourses IC ON Q.CourseID = IC.CourseID
        WHERE IC.InstructorID = @InstructorID AND Q.QuestionID = @QuestionID
    )
    BEGIN
        UPDATE Questions
        SET QuestionType = @QuestionType,
            QuestionContent = @QuestionContent,
            CorrectAnswer = @CorrectAnswer,
            BestAcceptedAnswer = @BestAcceptedAnswer
        WHERE QuestionID = @QuestionID;
    END
    ELSE
    BEGIN
        RAISERROR ('You are not authorized to update questions for this course.', 16, 1);
    END
END;

go

CREATE PROCEDURE DeleteQuestion
    @InstructorID INT,
    @QuestionID INT
AS
BEGIN
    IF EXISTS (
        SELECT 1
        FROM Questions Q
        JOIN InstructorCourses IC ON Q.CourseID = IC.CourseID
        WHERE IC.InstructorID = @InstructorID AND Q.QuestionID = @QuestionID
    )
    BEGIN
        DELETE FROM Questions
        WHERE QuestionID = @QuestionID;
    END
    ELSE
    BEGIN
        RAISERROR ('You are not authorized to delete questions from this course.', 16, 1);
    END
END;

go








-- instructors 

CREATE PROCEDURE AddInstructor
    @Name NVARCHAR(50),
    @Email NVARCHAR(100),
    @Phone NVARCHAR(15),
    @HireDate DATE,
    @Department NVARCHAR(50)
AS
BEGIN
    INSERT INTO Instructors (Name, Email, Phone, HireDate)
    VALUES (@Name, @Email, @Phone, @HireDate);
END;

go

CREATE PROCEDURE UpdateInstructor
   @InstructorID INT,
    @Name NVARCHAR(50),
    @Email NVARCHAR(100),
    @Phone NVARCHAR(15),
    @HireDate DATE
AS
BEGIN
    UPDATE Instructors
    SET Name = @Name,
        Email = @Email,
        Phone = @Phone,
        HireDate = @HireDate
    WHERE InstructorID = @InstructorID;
END;


go

CREATE PROCEDURE DeleteInstructor
    @InstructorID INT
AS
BEGIN
    DELETE FROM Instructors
    WHERE InstructorID = @InstructorID;
END;




--Course
go 


CREATE PROCEDURE AddCourse
    @CourseName NVARCHAR(100),
    @Description NVARCHAR(255),
    @MaxDegree INT,
    @MinDegree INT
AS
BEGIN
    INSERT INTO Courses (CourseName, Description, MaxDegree, MinDegree)
    VALUES (@CourseName, @Description, @MaxDegree, @MinDegree);
END;

go

CREATE PROCEDURE UpdateCourse
    @CourseID INT,
    @CourseName NVARCHAR(100),
    @Description NVARCHAR(255),
    @MaxDegree INT,
    @MinDegree INT
AS
BEGIN
    UPDATE Courses
    SET CourseName = @CourseName,
        Description = @Description,
        MaxDegree = @MaxDegree,
        MinDegree = @MinDegree
    WHERE CourseID = @CourseID;
END;

go

CREATE PROCEDURE DeleteCourse
    @CourseID INT
AS
BEGIN
    DELETE FROM Courses
    WHERE CourseID = @CourseID;
END;


--[InstructorCourses]
go

CREATE PROCEDURE InstructorToCourse
    @InstructorID INT,
    @CourseID INT,
	@year int
AS
BEGIN
    INSERT INTO InstructorCourses (InstructorID, CourseID,[yearOfCourse])
    VALUES (@InstructorID, @CourseID,@year);
END;

go

CREATE PROCEDURE RemoveInstructorFromCourse
    @InstructorCourseID INT
AS
BEGIN
    DELETE FROM InstructorCourses
    WHERE [InstructorID] = @InstructorCourseID;
END;


--------------------------------branch----------

CREATE PROCEDURE AddBranch
    @BranchName NVARCHAR(100),
    @Description NVARCHAR(255)
AS
BEGIN
    INSERT INTO Branches (BranchName, Description)
    VALUES (@BranchName, @Description);
END;


go

CREATE PROCEDURE UpdateBranch
    @BranchID INT,
    @BranchName NVARCHAR(100),
    @Description NVARCHAR(255)
AS
BEGIN
    UPDATE Branches
    SET BranchName = @BranchName,
        Description = @Description
    WHERE BranchID = @BranchID;
END;


go

CREATE PROCEDURE DeleteBranch
    @BranchID INT
AS
BEGIN
    DELETE FROM Branches
    WHERE BranchID = @BranchID;
END;
go

----------------------------------------------track--------

create proc AddTrack
@TrackName varchar(50),
@BranchID int,
@Description varchar(50),
@DeptID int
as
begin
insert into [dbo].[Tracks] ([BranchID],[TrackName],[Description],[DeptID])
values(@BranchID,@TrackName,@Description ,@DeptID)
end


go






go
create PROCEDURE UpdateTrack
    @TrackID INT,
    @BranchID INT,
    @TrackName NVARCHAR(100),
    @Description NVARCHAR(255),
	@DeptID int
AS
BEGIN
    UPDATE Tracks
    SET BranchID = @BranchID,
        TrackName = @TrackName,
        Description = @Description,
		[DeptID]=@DeptID
    WHERE TrackID = @TrackID;
END;


go
CREATE PROCEDURE DeleteTrack
    @TrackID INT
AS
BEGIN
    DELETE FROM Tracks
    WHERE TrackID = @TrackID;
END;

go
-----------------------------------------intack-----

CREATE PROCEDURE AddIntake
    @IntakeName NVARCHAR(100),
    @StartDate DATE,
    @EndDate DATE
AS
BEGIN
    INSERT INTO Intakes (IntakeName, StartDate, EndDate)
    VALUES (@IntakeName, @StartDate, @EndDate);
END;
go


CREATE PROCEDURE UpdateIntake
    @IntakeID INT,
    @IntakeName NVARCHAR(100),
    @StartDate DATE,
    @EndDate DATE
AS
BEGIN
    UPDATE Intakes
    SET IntakeName = @IntakeName,
        StartDate = @StartDate,
        EndDate = @EndDate
    WHERE IntakeID = @IntakeID;
END;

CREATE PROCEDURE DeleteIntake
    @IntakeID INT
AS
BEGIN
    DELETE FROM Intakes
    WHERE IntakeID = @IntakeID;
END;


go
-------------------------------------Courses-----------------


create PROCEDURE AddCourse
    @CourseName NVARCHAR(100),
    @Description NVARCHAR(255),
    @MaxDegree INT,
    @MinDegree INT
    
AS
BEGIN
    INSERT INTO Courses (CourseName, Description, MaxDegree, MinDegree)
    VALUES (@CourseName, @Description, @MaxDegree, @MinDegree);
END;
go

create PROCEDURE UpdateCourse
    @CourseID INT,
    @CourseName NVARCHAR(100),
    @Description NVARCHAR(255),
    @MaxDegree INT,
    @MinDegree INT
    
AS
BEGIN
    UPDATE Courses
    SET CourseName = @CourseName,
        Description = @Description,
        MaxDegree = @MaxDegree,
        MinDegree = @MinDegree
    WHERE CourseID = @CourseID;
END;

go

CREATE PROCEDURE DeleteCourse
    @CourseID INT
AS
BEGIN
    DELETE FROM Courses
    WHERE CourseID = @CourseID;
END;

-------------------------------------------------------instructor

CREATE PROCEDURE AddStudent
    @Name NVARCHAR(50),
    @Email NVARCHAR(100),
    @Phone NVARCHAR(15),
    @IntakeID INT,
    @BranchID INT,
    @TrackID INT,
	@userId int
AS
BEGIN
    INSERT INTO Students (Name, Email, Phone, IntakeID, BranchID, TrackID,[userId])
    VALUES (@Name, @Email, @Phone, @IntakeID, @BranchID, @TrackID ,@userId);
END;



go
CREATE PROCEDURE UpdateStudent
    @StudentID INT,
    @Name NVARCHAR(50),
    @Email NVARCHAR(100),
    @Phone NVARCHAR(15),
    @IntakeID INT,
    @BranchID INT,
    @TrackID INT,
	@userId int 
AS
BEGIN
    UPDATE Students
    SET Name = @Name,
        Email = @Email,
        Phone = @Phone,
        IntakeID = @IntakeID,
        BranchID = @BranchID,
        TrackID = @TrackID,
		[userId]= @userId
    WHERE StudentID = @StudentID;
END;


go


CREATE PROCEDURE DeleteStudent
    @StudentID INT
AS
BEGIN
    DELETE FROM Students
    WHERE StudentID = @StudentID;
END;

----------------------------------------------

go

CREATE PROCEDURE AddDepartment
    @DepartmentName NVARCHAR(100),
    @Description NVARCHAR(255)
AS
BEGIN
    INSERT INTO Departments (DepartmentName, Description)
    VALUES (@DepartmentName, @Description);
END;


go

CREATE PROCEDURE UpdateDepartment
    @DepartmentID INT,
    @DepartmentName NVARCHAR(100),
    @Description NVARCHAR(255)
AS
BEGIN
    UPDATE Departments
    SET DepartmentName = @DepartmentName,
        Description = @Description
    WHERE DepartmentID = @DepartmentID;
END;


go


CREATE PROCEDURE DeleteDepartment
    @DepartmentID INT
AS
BEGIN
    DELETE FROM Departments
    WHERE DepartmentID = @DepartmentID;
END;

go

CREATE PROCEDURE CreateExam
    @CourseID INT,
    @InstructorID INT,
    @ExamType NVARCHAR(20),
    @IntakeID INT,
    @BranchID INT,
    @TrackID INT,
    @StartTime DATETIME,
    @TotalTime INT,
    @AllowanceOptions NVARCHAR(255)
AS
BEGIN
    INSERT INTO Exams (CourseID, InstructorID, ExamType, IntakeID, BranchID, TrackID, StartTime, TotalTime, AllowanceOptions)
    VALUES (@CourseID, @InstructorID, @ExamType, @IntakeID, @BranchID, @TrackID, @StartTime, @TotalTime, @AllowanceOptions);
END;


---------------------------------------
go

CREATE PROCEDURE AddQuestionToExam
    @ExamID INT,
    @QuestionID INT,
    @QuestionDegree INT
AS
BEGIN
    INSERT INTO ExamQuestions (ExamID, QuestionID, QuestionDegree)
    VALUES (@ExamID, @QuestionID, @QuestionDegree);
END;


----------------------------------------

CREATE PROCEDURE AssignStudentsToExam
    @ExamID INT,
    @StudentID INT
AS
BEGIN
    INSERT INTO StudentAnswers (ExamID, StudentID, QuestionID, StudentAnswer, IsCorrect, Marks)
    SELECT @ExamID, @StudentID, QuestionID, NULL, 0, 0
    FROM ExamQuestions
    WHERE ExamID = @ExamID;
END;

go
------------------------------user
CREATE PROCEDURE AddUser
    @Username NVARCHAR(100),
    @PasswordHash NVARCHAR(50),
    @PersonType NVARCHAR(20)
AS
BEGIN
    INSERT INTO Users ([userName], [userPassword],[typeOfUser] )
    VALUES (@Username, @PasswordHash, @PersonType);
END;


go

CREATE PROCEDURE UpdateUser
    @UserID INT,
    @Username NVARCHAR(100),
    @PasswordHash NVARCHAR(100),
    @PersonType NVARCHAR(20)
AS
BEGIN
    UPDATE Users
    SET [userName] = @Username,
        [userPassword] = @PasswordHash,
        [typeOfUser] = @PersonType
    WHERE UserID = @UserID;
END;


go
CREATE PROCEDURE DeleteUser
    @UserID INT
AS
BEGIN
    DELETE FROM Users
    WHERE UserID = @UserID;
END;




go
-----------------------------------------

CREATE FUNCTION CheckTextAnswer (@BestAcceptedAnswer NVARCHAR(1000), @StudentAnswer NVARCHAR(1000))
RETURNS BIT
AS
BEGIN
    DECLARE @IsMatch BIT = 0;
    IF PATINDEX('%' + @BestAcceptedAnswer + '%', @StudentAnswer) > 0
    BEGIN
        SET @IsMatch = 1;
    END
    RETURN @IsMatch;
END;

-------------------------------------------------


CREATE PROCEDURE CalculateExamResults
    @ExamID INT
AS
BEGIN
    UPDATE StudentAnswers
    SET IsCorrect = CASE 
                      WHEN Questions.QuestionType IN ('Multiple Choice', 'True/False') AND StudentAnswers.StudentAnswer = Questions.CorrectAnswer THEN 1
                      WHEN Questions.QuestionType = 'Text' AND dbo.CheckTextAnswer(Questions.BestAcceptedAnswer, StudentAnswers.StudentAnswer) = 1 THEN 1
                      ELSE 0
                    END
    FROM StudentAnswers
    INNER JOIN Questions ON StudentAnswers.QuestionID = Questions.QuestionID
    WHERE StudentAnswers.ExamID = @ExamID;

    UPDATE StudentAnswers
    SET Marks = CASE 
                  WHEN IsCorrect = 1 THEN ExamQuestions.QuestionDegree
                  ELSE 0
                END
    FROM StudentAnswers
    INNER JOIN ExamQuestions ON StudentAnswers.ExamID = ExamQuestions.ExamID AND StudentAnswers.QuestionID = ExamQuestions.QuestionID
    WHERE StudentAnswers.ExamID = @ExamID;
END;



-- Branch Stored Procedure
------Display-------
alter proc GetBranch 

as
select *
from Branches
go

-- Exam Stored Procedure
------Display-------
alter proc GetExam 

as
select *
from Exams
go

-- Students Stored Procedure
------Display-------
alter proc GetStudent 

as
select *
from Students
go

-- User Stored Procedure
------Display-------
alter proc GetUser 

as
select *
from userSys
go

-- StudentAnswers Stored Procedure
------Display-------
alter proc GetStudentAnswers  

as
select *
from StudentAnswers
go
------Insert-------
alter proc InstStudentAnswers
	@Student_answerId int, @Exam_Id int, @Student_Id int, @Question_Id int, @Student_answer nvarchar(1000), @Is_correct bit,
	@Marks int

as
begin try
	insert into [dbo].[StudentAnswers] ([StudentAnswerID],[ExamID],[StudentID],[QuestionID],[StudentAnswer],[IsCorrect],[Marks])
	values (@Student_answerId , @Exam_Id , @Student_Id , @Question_Id , @Student_answer , @Is_correct ,@Marks )
end try
begin catch
	select 'Invalid input or insertion procedure failed'
end catch
go
------Update-------
alter proc UpStudentAnswers
	@Student_answerId int, @Student_answer nvarchar(1000), @Is_correct bit, @Marks int

as
begin try
	update StudentAnswers
	set 
	StudentAnswer = @Student_answer,
	IsCorrect = @Is_correct,
	Marks = @Marks
	where StudentAnswerID = @Student_answerId
end try
begin catch
	select 'Invalid input or update operation failed' 
end catch
go
------Delete-------
alter proc DelStudentAnswers
	@Student_answerId int

as
begin try
	delete from [dbo].[StudentAnswers]
	where StudentAnswerID = @Student_answerId
end try
begin catch
	select 'Invalid inputs or deletion procedure failed' 
end catch
go











CREATE PROCEDURE sp_GetStudentCourse
    @UserName NVARCHAR(50),
    @Password NVARCHAR(50),
    @UserId INT
AS
BEGIN
    BEGIN TRY
        -- التحقق من صحة المستخدم
        IF EXISTS (SELECT 1 FROM userSys WHERE UserName = @UserName AND userPassword = @Password AND [UserId] = @UserId)
        BEGIN
            -- عرض البيانات من جدول الدورة المرتبطة بالطالب
            SELECT c.*
            FROM Courses c
            JOIN StudentCourse sc ON c.CourseId = sc.CourseId
            JOIN Students s ON sc.StudentId = s.StudentId
            WHERE s.UserId = @UserId;
        END
        ELSE
        BEGIN
            -- رجاع رسالة خطأ في حالة عدم صحة البيانات
            RAISERROR('Invalid user credentials', 16, 1);
        END
    END TRY
    BEGIN CATCH
        -- التعامل مع  أخطاء أثناء تنفيذ 
        DECLARE @ErrorMessage NVARCHAR(300);
        DECLARE @ErrorSeverity INT;
        DECLARE @ErrorState INT;

        SELECT 
            @ErrorMessage = ERROR_MESSAGE(),
            @ErrorSeverity = ERROR_SEVERITY(),
            @ErrorState = ERROR_STATE();

        RAISERROR(@ErrorMessage, @ErrorSeverity, @ErrorState);
    END CATCH
END;

--execu التنفيذ 
-- قم باستبدال القيم بالقيم الصحيحة لبيانات المستخدم
DECLARE @UserName NVARCHAR(50) = 'your_username';
DECLARE @Password NVARCHAR(50) = 'your_password';
DECLARE @UserId INT = 'your_user_id';

-- تنفيذ الإجراء المخزن
EXEC [dbo].[sp_GetStudentCourse] @UserName, @Password, @UserId;


-- تنفيذ عمليات  عندما تحدث تغييرات في البيانات داخل هذه الجداول.


