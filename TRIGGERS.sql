----------------------------------

create TRIGGER trg_CheckBranchExistsForTrack
ON [dbo].[Tracks]
INSTEAD OF INSERT,UPDATE
AS
BEGIN
    IF NOT EXISTS (SELECT * FROM Branches WHERE BranchID IN (SELECT BranchID FROM INSERTED))
	            
    BEGIN
        RAISERROR('Branch does not exist.', 16, 1);
        ROLLBACK TRANSACTION;
    END
	else if NOT EXISTS (SELECT * FROM Departments WHERE DepartmentID IN (SELECT DeptID FROM INSERTED))
	 BEGIN
        RAISERROR('Department does not exist.', 16, 1);
        ROLLBACK TRANSACTION;
    END
    ELSE
    BEGIN
        INSERT INTO Tracks (BranchID, TrackName, Description,DeptID)
        SELECT BranchID, TrackName, Description,DeptID
        FROM INSERTED;
    END
END;
exec AddTrack 'Data Enginner',5,'track Data',3;


create trigger DelectTrack
on [dbo].[Tracks]
INSTEAD OF delete
as
begin 

	 IF NOT EXISTS (SELECT * FROM student WHERE [TrackID] IN (SELECT [TrackID] FROM Deleted))            
    BEGIN
        RAISERROR('update or delect track from student procedure', 16, 1);
        
    END
	else if NOT EXISTS (SELECT * FROM [dbo].[Exams] WHERE [TrackID] IN (SELECT [TrackID] FROM Deleted))
	 BEGIN
        RAISERROR('update or delect track from exam procedure', 16, 1);
        
    END
    ELSE
    BEGIN
        delete from  Tracks 
		where [TrackID] IN (SELECT [TrackID] FROM Deleted)
    END
end;


go
exec [dbo].[DeleteTrack] 2;


go



---------------------------------------


CREATE TRIGGER trg_CheckIntakeDates
ON Intakes
INSTEAD OF INSERT, UPDATE
AS
BEGIN
    IF EXISTS (SELECT * FROM INSERTED WHERE StartDate >= EndDate)
    BEGIN
        RAISERROR('Start date must be earlier than end date.', 16, 1);
        ROLLBACK TRANSACTION;
    END
    ELSE
    BEGIN
        IF EXISTS (SELECT * FROM INSERTED)
        BEGIN
            INSERT INTO Intakes (IntakeName, StartDate, EndDate)
            SELECT IntakeName, StartDate, EndDate
            FROM INSERTED;
        END

        IF EXISTS (SELECT * FROM deleted)
        BEGIN
            UPDATE Intakes
            SET IntakeName = INSERTED.IntakeName,
                StartDate = INSERTED.StartDate,
                EndDate = INSERTED.EndDate
            FROM INSERTED
            WHERE Intakes.IntakeID = INSERTED.IntakeID;
        END
    END
END;




------------------------------------------------






go


create TRIGGER triggerForInsertStudent
ON [dbo].[Students]
INSTEAD OF INSERT,UPDATE
AS
BEGIN
    IF NOT EXISTS (SELECT * FROM Branches WHERE BranchID IN (SELECT BranchID FROM INSERTED))
	            
    BEGIN
        RAISERROR('Branch does not exist.', 16, 1);
        ROLLBACK TRANSACTION;
    END
	IF NOT EXISTS (SELECT * FROM [dbo].[Intakes] WHERE [IntakeID] IN (SELECT [IntakeID] FROM INSERTED))
	            
    BEGIN
        RAISERROR('Intackes does not exist.', 16, 1);
        ROLLBACK TRANSACTION;
    END
	IF NOT EXISTS (SELECT * FROM [dbo].[Tracks] WHERE [TrackID] IN (SELECT [TrackID] FROM INSERTED))
	            
    BEGIN
        RAISERROR('track does not exist.', 16, 1);
        ROLLBACK TRANSACTION;
    END
	else if NOT EXISTS (SELECT * FROM [dbo].[userSys] WHERE [userId] IN (SELECT [userId] FROM INSERTED))
	 BEGIN
        RAISERROR('user does not exist.', 16, 1);
        ROLLBACK TRANSACTION;
    END
    ELSE
    BEGIN
        
		 INSERT INTO Students (Name, Email, Phone, IntakeID, BranchID, TrackID,[userId])
         select Name, Email, Phone, IntakeID, BranchID, TrackID,[userId]
        FROM INSERTED;
    END
END;
go
exec [dbo].[AddStudent] 'shaban','shaban@gmail.com','01120417134',5,500,5,5;

go
create trigger triggerForDeleteStudent
ON [dbo].[Students]
INSTEAD OF delete
as
begin 

	 IF NOT EXISTS (SELECT * FROM [dbo].[StudentCourse] WHERE StudentID IN (SELECT StudentID FROM Deleted))            
    BEGIN
        RAISERROR('update or delect student from [StudentCourse] procedure', 16, 1);
        
    END
	else if NOT EXISTS (SELECT * FROM [dbo].[StudentAnswers] WHERE StudentID IN (SELECT StudentID FROM Deleted))
	 BEGIN
        RAISERROR('update or delect track from [StudentAnswers] procedure', 16, 1);
        
    END
    ELSE
    BEGIN
        delete from  [dbo].[Students] 
		where StudentID IN (SELECT StudentID FROM Deleted)
    END

end;
go
exec [dbo].[DeleteStudent] 4;



--ExamQuestions Triggers
create TRIGGER trg_CheckExamforQuestions
ON [dbo].[ExamQuestions]
INSTEAD OF INSERT,UPDATE
AS
BEGIN
    IF NOT EXISTS (SELECT * FROM [dbo].[Questions] WHERE QuestionID IN (SELECT QuestionID FROM INSERTED))
	            
    BEGIN
        RAISERROR('Question does not exist.', 16, 1);
        ROLLBACK TRANSACTION;
    END
	else if NOT EXISTS (SELECT * FROM Exams WHERE ExamID IN (SELECT ExamID FROM INSERTED))
	 BEGIN
        RAISERROR('Exam does not exist.', 16, 1);
        ROLLBACK TRANSACTION;
    END
    ELSE
    BEGIN
        INSERT INTO [dbo].[ExamQuestions] ([ExamQuestionID],[ExamID],[QuestionID],[QuestionDegree])
        SELECT [ExamQuestionID],[ExamID],[QuestionID],[QuestionDegree]
        FROM INSERTED;
    END
END;



go
create trigger trg_DeleteExamQuestions
on [dbo].[ExamQuestions]
INSTEAD OF delete
as
    BEGIN
        delete from  [dbo].[ExamQuestions]
		where ExamQuestionID IN (SELECT ExamQuestionID FROM Deleted)
    END
go


go
--Exam Triggers
--Exam Triggers
create TRIGGER trg_CheckBranchExistsForExam
ON [dbo].[Exams]
INSTEAD OF INSERT,UPDATE
AS
BEGIN
    IF NOT EXISTS (SELECT * FROM Branches WHERE BranchID IN (SELECT BranchID FROM INSERTED))
	            
    BEGIN
        RAISERROR('Branch does not exist.', 16, 1);
        ROLLBACK TRANSACTION;
    END
	else if NOT EXISTS (SELECT * FROM Instructors WHERE InstructorID IN (SELECT InstructorID FROM INSERTED))
	 BEGIN
        RAISERROR('Instructor does not exist.', 16, 1);
        ROLLBACK TRANSACTION;
    END
	else if NOT EXISTS (SELECT * FROM Courses WHERE CourseID IN (SELECT CourseID FROM INSERTED))
	 BEGIN
        RAISERROR('Course does not exist.', 16, 1);
        ROLLBACK TRANSACTION;
    END
	else if NOT EXISTS (SELECT * FROM Intakes WHERE IntakeID IN (SELECT IntakeID FROM INSERTED))
	 BEGIN
        RAISERROR('Intake does not exist.', 16, 1);
        ROLLBACK TRANSACTION;
    END
	else if NOT EXISTS (SELECT * FROM Tracks WHERE TrackID IN (SELECT TrackID FROM INSERTED))
	 BEGIN
        RAISERROR('Track does not exist.', 16, 1);
        ROLLBACK TRANSACTION;
    END
    ELSE
    BEGIN
        INSERT INTO Exams([ExamID],[CourseID],[InstructorID],[ExamType],[IntakeID],[BranchID],[TrackID],[StartTime],[TotalTime])
        SELECT [ExamID],[CourseID],[InstructorID],[ExamType],[IntakeID],[BranchID],[TrackID],[StartTime],[TotalTime]
        FROM INSERTED;
    END
END;
go
create trigger trg_DelectExam
on [dbo].[Exams]
INSTEAD OF delete
as
begin 

	 IF NOT EXISTS (SELECT * FROM [dbo].[StudentAnswers] WHERE ExamID IN (SELECT ExamID FROM Deleted))            
    BEGIN
        RAISERROR('update or delect track from [StudentAnswers] procedure', 16, 1);
        
    END
	else if NOT EXISTS (SELECT * FROM [dbo].[ExamQuestions] WHERE ExamID IN (SELECT ExamID FROM Deleted))
	 BEGIN
        RAISERROR('update or delect track from [ExamQuestions] procedure', 16, 1);
        
    END
    ELSE
    BEGIN
        delete from  Exams 
		where ExamID IN (SELECT ExamID FROM Deleted)
    END

end;
go


---------------------------------------Triggers----------------------------------------------
--Student Answers

CREATE TRIGGER trg_StudentAnswer
ON [dbo].[StudentAnswers]
INSTEAD OF INSERT,UPDATE
AS
BEGIN
    IF NOT EXISTS (SELECT * FROM [dbo].[Exams] WHERE [ExamID] IN (SELECT [ExamID] FROM INSERTED))
	            
    BEGIN
        RAISERROR('Exam does not exist.', 16, 1);
        ROLLBACK TRANSACTION;
    END
	IF NOT EXISTS (SELECT * FROM [dbo].[Questions] WHERE [QuestionID] IN (SELECT [QuestionID] FROM INSERTED))
	            
    BEGIN
        RAISERROR('Question does not exist.', 16, 1);
        ROLLBACK TRANSACTION;
    END
	else if NOT EXISTS (SELECT * FROM [dbo].[Students] WHERE [StudentID] IN (SELECT [StudentID] FROM INSERTED))
	 BEGIN
        RAISERROR('Student does not exist.', 16, 1);
        ROLLBACK TRANSACTION;
    END
    ELSE
    BEGIN
        INSERT INTO [dbo].[StudentAnswers] ([ExamID], [StudentID],[QuestionID],[StudentAnswer])
        SELECT [ExamID],[StudentID], [QuestionID],[StudentAnswer]
        FROM INSERTED;
    END
END;



--Student Answers DELETE
CREATE TRIGGER DeleteStudentAnswer
ON [dbo].[StudentAnswers]
INSTEAD OF delete
AS
begin 
IF NOT EXISTS (SELECT * FROM [dbo].[Exams] WHERE [ExamID] IN (SELECT [ExamID] FROM INSERTED))
	            
    BEGIN
        RAISERROR('update or delete ExamID from Exams procedure.', 16, 1);
        ROLLBACK TRANSACTION;
    END
	IF NOT EXISTS (SELECT * FROM [dbo].[Questions] WHERE [QuestionID] IN (SELECT [QuestionID] FROM INSERTED))
	            
    BEGIN
        RAISERROR('update or delete QuestionID from Question procedure.', 16, 1);
        ROLLBACK TRANSACTION;
    END
	else if NOT EXISTS (SELECT * FROM [dbo].[Students] WHERE [StudentID] IN (SELECT [StudentID] FROM INSERTED))
	 BEGIN
        RAISERROR('Student does not exist.', 16, 1);
        ROLLBACK TRANSACTION;
    END
	ELSE
    BEGIN
        delete from  [dbo].[StudentAnswers]
		where [StudentAnswerID] IN (SELECT [StudentAnswerID] FROM Deleted)
    END
end;
go

EXEC [dbo].[DeleteStudentAnswer] 2;





--InstructorCourses Triggers
create TRIGGER trg_instructorCourses
ON [dbo].[InstructorCourses]
INSTEAD OF INSERT,UPDATE
AS
BEGIN
    IF NOT EXISTS (SELECT * FROM Instructors WHERE InstructorID IN (SELECT InstructorID FROM INSERTED))
	            
    BEGIN
        RAISERROR('Instructor does not exist.', 16, 1);
        ROLLBACK TRANSACTION;
    END
	else if NOT EXISTS (SELECT * FROM Courses WHERE CourseID IN (SELECT CourseID FROM INSERTED))
	 BEGIN
        RAISERROR('Course does not exist.', 16, 1);
        ROLLBACK TRANSACTION;
    END
    ELSE
    BEGIN
        INSERT INTO [dbo].[InstructorCourses] ([InstructorID],[CourseID],[yearOfCourse])
        SELECT [InstructorID],[CourseID],[yearOfCourse]
        FROM INSERTED;
    END
END;
go
create trigger trg_DeleteInstructorCourses
on [dbo].[InstructorCourses]
INSTEAD OF delete
as
begin 

    BEGIN
        delete from   [dbo].[InstructorCourses]
		where yearOfCourse IN (SELECT yearOfCourse FROM Deleted)
    END

end;
go


--Intakes Triggers
create TRIGGER trg_InserTIntakes
ON [dbo].[Intakes]
INSTEAD OF INSERT,UPDATE
AS
BEGIN
    BEGIN
        INSERT INTO [dbo].[Intakes] ([IntakeID],[IntakeName],[StartDate],[EndDate])
        SELECT [IntakeID],[IntakeName],[StartDate],[EndDate]
        FROM INSERTED;
    END
END;
go
create trigger trg_DeleteIntakes
on [dbo].[Intakes]
INSTEAD OF delete
as
begin 

	 IF NOT EXISTS (SELECT * FROM [dbo].[Exams] WHERE IntakeID IN (SELECT IntakeID FROM Deleted))            
    BEGIN
        RAISERROR('update or delect track from [Exams] procedure', 16, 1);
        
    END
	else if NOT EXISTS (SELECT * FROM [dbo].[Students] WHERE IntakeID IN (SELECT IntakeID FROM Deleted))
	 BEGIN
        RAISERROR('update or delect track from [dbo].[Students] procedure', 16, 1);
    END
    ELSE
    BEGIN
        delete from  [dbo].[Intakes]
		where IntakeID IN (SELECT IntakeID FROM Deleted)
    END

end;
go








--  لإدراج أو تحديث البيانات في جدول Courses
use Examination
go
CREATE TRIGGER trg_Courses
ON [dbo].[Courses]
INSTEAD OF INSERT, UPDATE
AS
BEGIN
    INSERT INTO [dbo].[Courses] ([CourseID], [CourseName], [Description],[MaxDegree],[MinDegree])
    SELECT [CourseID], [CourseName], [Description],[MaxDegree],[MinDegree]
    FROM INSERTED;
END;
GO

--  لحذف البيانات من جدول Courses
CREATE TRIGGER trg_DeleteCourses
ON [dbo].[Courses]
INSTEAD OF DELETE
AS
BEGIN
    IF NOT EXISTS (SELECT * FROM [dbo].[StudentCourse] WHERE CourseID IN (SELECT CourseID FROM DELETED))
    BEGIN
        RAISERROR('Cannot delete Course as it is referenced in StudentCourses', 16, 1);
    END
    ELSE
    BEGIN
        DELETE FROM [dbo].[Courses]
        WHERE CourseID IN (SELECT CourseID FROM DELETED);
    END
END;
GO

--  لإدراج أو تحديث البيانات في جدول Branch
CREATE TRIGGER trg_Branch
ON [dbo].[Branches]
INSTEAD OF INSERT, UPDATE
AS
BEGIN
    INSERT INTO [dbo].[Branches] ([BranchID], [BranchName], [Description])
    SELECT [BranchID], [BranchName], [Description]
    FROM INSERTED;
END;
GO

-- مشغل لحذف البيانات من جدول Branch
CREATE TRIGGER trg_DeleteBranch
ON [dbo].[Branches]
INSTEAD OF DELETE
AS
BEGIN
    IF NOT EXISTS (SELECT * FROM [dbo].[DeptOfBranch] WHERE BranchID IN (SELECT BranchID FROM DELETED))
    BEGIN
        RAISERROR('Cannot delete Branch as it is referenced in DepartmentBranch', 16, 1);
    END
    ELSE
    BEGIN
        DELETE FROM [dbo].[Branches]
        WHERE BranchID IN (SELECT BranchID FROM DELETED);
    END
END;
GO




--  لإدراج أو تحديث البيانات في جدول DepartmentBranch
CREATE TRIGGER trg_DepartmentBranch
ON [dbo].[DeptOfBranch]
INSTEAD OF INSERT, UPDATE
AS
BEGIN
    INSERT INTO [dbo].[DeptOfBranch] ([year], [DepartmentID], [BranchID])
    SELECT [year], [DepartmentID], [BranchID]
    FROM INSERTED;
END;
GO

--  لحذف البيانات من جدول DepartmentBranch
CREATE TRIGGER trg_DeleteDepartmentBranch
ON [dbo].[DeptOfBranch]
INSTEAD OF DELETE
AS
BEGIN
    DELETE FROM [dbo].[DeptOfBranch]
    WHERE DepartmentID IN (SELECT DepartmentID FROM DELETED);
END;
GO
CREATE TABLE newValue(
    newValueId INT PRIMARY KEY IDENTITY(1,1),
    TableName NVARCHAR(50),
    Operation NVARCHAR(50),
    PrimaryKey INT,
    OldValue NVARCHAR(MAX),
    NewValue NVARCHAR(MAX),
    ChangeDate DATETIME DEFAULT GETDATE()
);

--DeleteStudent
CREATE TRIGGER trg_DeleteStudent
ON Students
AFTER DELETE
AS
BEGIN
    INSERT INTO newValue (TableName, Operation, PrimaryKey, OldValue)
    SELECT 
        'Students', 
        'DELETE', 
        deleted.StudentId, 
        CONCAT('Name: ', deleted.Name, ', email: ', deleted.Email, ', Intake: ', deleted.IntakeID, ', Branch: ', deleted.BranchID, ', Track: ', deleted.TrackID)
    FROM deleted;
END;

--UpdateCourse
CREATE TRIGGER trg_UpdateCourse
ON Courses
AFTER UPDATE
AS
BEGIN
    INSERT INTO newValue (TableName, Operation, PrimaryKey, OldValue, NewValue)
    SELECT 
        'Courses', 
        'UPDATE', 
        deleted.CourseId, 
        CONCAT('CourseName: ', deleted.CourseName, ', Description: ', deleted.Description, ', MaxDegree: ', deleted.MaxDegree, ', MinDegree: ', deleted.MinDegree),
        CONCAT('CourseName: ', inserted.CourseName, ', Description: ', inserted.Description, ', MaxDegree: ', inserted.MaxDegree, ', MinDegree: ', inserted.MinDegree)
    FROM deleted
    JOIN inserted ON deleted.CourseId = inserted.CourseId;
END;

--DeleteCourse
CREATE TRIGGER trg_DeleteCourse
ON Courses
AFTER DELETE
AS
BEGIN
    INSERT INTO newValue (TableName, Operation, PrimaryKey, OldValue)
    SELECT 
        'Courses', 
        'DELETE', 
        deleted.CourseId, 
        CONCAT('CourseName: ', deleted.CourseName, ', Description: ', deleted.Description, ', MaxDegree: ', deleted.MaxDegree, ', MinDegree: ', deleted.MinDegree)
    FROM deleted;
END;

--InsertStudent
CREATE TRIGGER trg_InsertStudent
ON Students
AFTER INSERT
AS
BEGIN
    INSERT INTO newValue (TableName, Operation, PrimaryKey, NewValue)
    SELECT 
        'Students', 
        'INSERT', 
        inserted.StudentId, 
        CONCAT('Name: ', inserted.Name, ', Email: ', inserted.Email, ', Intake: ', inserted.IntakeID, ', Branch: ', inserted.BranchID, ', Track: ', inserted.TrackID)
    FROM inserted;
END;


--UpdateStudent
CREATE TRIGGER trg_UpdateStudent
ON [dbo].[Students]
AFTER UPDATE
AS
BEGIN
    INSERT INTO newValue (TableName, Operation, PrimaryKey, OldValue, NewValue)
    SELECT 
        'Students', 
        'UPDATE', 
        deleted.StudentId, 
        CONCAT('Name: ', deleted.Name, ', Email: ', deleted.Email, ', Intake: ', deleted.IntakeID, ', Branch: ', deleted.BranchID, ', Track: ', deleted.TrackID),
        CONCAT('Name: ', inserted.Name, ', Email: ', inserted.Email, ', Intake: ', inserted.IntakeID, ', Branch: ', inserted.BranchID, ', Track: ', inserted.TrackID)
    FROM deleted
    JOIN inserted ON deleted.StudentId = inserted.StudentId;
END;

--DeleteStudent
alter TRIGGER trg_DeleteStudents
ON Students
AFTER DELETE
AS
BEGIN
    INSERT INTO newValue (TableName, Operation, PrimaryKey, OldValue)
    SELECT 
        'Students', 
        'DELETE', 
        deleted.StudentId, 
        CONCAT('Name: ', deleted.Name, ', Email: ', deleted.Email, ', Intake: ', deleted.IntakeID, ', Branch: ', deleted.BranchID, ', Track: ', deleted.TrackID)
    FROM deleted;
END;
insert into Students  ([Name],[Email],[IntakeID],[TrackID])
values ( 'ahmed','ahmed1232@gmail.com',2024,1); 
delete from students where StudentID = 1;
select * from newValue;