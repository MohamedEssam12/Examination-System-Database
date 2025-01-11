CREATE VIEW StudentCourseView
AS
SELECT *
FROM [dbo].[StudentCourse];

go

CREATE VIEW InstructorCoursesView
AS
SELECT *
FROM [dbo].[InstructorCourses];


CREATE VIEW ExamQuestionsView
AS
SELECT *
FROM [dbo].[ExamQuestions];


go
CREATE VIEW StudentAnswersView
AS
SELECT *
FROM [dbo].[StudentAnswers];

--branches view
create OR ALTER view show_Branch_view
as
select BranchName 
from Branches
Go
--track view
create OR ALTER view show_Track_view
as
select  TrackName
from Tracks
GO
--intake view
create OR ALTER view show_Intake_view
as
select Intakename
from Intakes
GO
--courses views
create OR ALTER view show_Course_view
as
select C.[CourseName],C.[MaxDegree],C.[MinDegree]
from Courses C 
GO
--Department views
create OR ALTER view show_Dept_view
as
select [DepartmentName]
from Departments
GO
--Department of Branch views
create OR ALTER view show_DeptofBranch_view
as
select B.BranchName, D.DepartmentName, DB.[year]
from [dbo].[DeptOfBranch] DB
inner join Departments D on DB.DepartmentID = D.DepartmentID
inner join Branches B on B.BranchID = DB.BranchID
GO
--Exam view
create OR ALTER view show_Exam_view
as
select  [ExamType],[StartTime],[TotalTime]
from Exams
Go
--Instructor view
create OR ALTER view show_Instructor_view
as
select  [Name],[Email],[Phone],[HireDate]
from Instructors
Go
--Questions view
create OR ALTER view show_Questions_view
as
select  [QuestionType],[CorrectAnswer],[BestAcceptedAnswer]
from Questions
Go

--Students view
create OR ALTER view show_Students_view
as
select S.[StudentID],S.[Name],S.[Email],S.[Phone], E.ExamType , SA.[Marks] , IT.[IntakeName],
		C.[CourseName],C.[MaxDegree],T.TrackName, D.[DepartmentName], B.BranchName
from Students S
inner join [dbo].[StudentAnswers] SA on S.StudentID = SA.StudentID
inner join [dbo].[Exams] E on SA.ExamID = E.ExamID
inner join [dbo].[Intakes] IT on IT.IntakeID = E.IntakeID
inner join [dbo].[Courses] C on E.CourseID = C.CourseID
inner join [dbo].[Tracks] T on T.TrackID = E.TrackID
inner join [dbo].[Departments] D on D.DepartmentID = T.DeptID
inner join [dbo].[Branches] B on B.BranchID = T.BranchID
Go
--User view
create OR ALTER view show_User_view
as
select [userName],[typeOfUser]
from userSys
Go




CREATE VIEW ViewCourses
AS
SELECT 
    c.CourseID,
    c.CourseName,
    c.Description,
    c.MaxDegree,
    c.MinDegree,
    i.Name AS InstructorName
FROM 
    Courses c
JOIN 
    [dbo].[InstructorCourses] ci ON c.CourseID = ci.CourseID
JOIN 
    Instructors i ON ci.InstructorID = i.InstructorID;


GRANT select ON  [dbo].ViewCourses TO manager,instructor;


go

CREATE VIEW ViewExamsAllDetails
AS
SELECT 
    e.ExamID,
    e.ExamType,
    e.StartTime,
    e.TotalTime,
    e.AllowanceOptions,
    c.CourseName,
    i.Name AS InstructorName,
    b.BranchName,
    t.TrackName,
    inta.IntakeName
FROM 
    Exams e
JOIN 
    Courses c ON e.CourseID = c.CourseID
JOIN 
    Instructors i ON e.InstructorID = i.InstructorID
JOIN 
    Branches b ON e.BranchID = b.BranchID
JOIN 
    Tracks t ON e.TrackID = t.TrackID
JOIN 
    Intakes inta ON e.IntakeID = inta.IntakeID;

GRANT select ON  [dbo].ViewExamsAllDetails TO manager,instructor;


go

CREATE VIEW ViewStudentsAllDetails
AS
SELECT 
    s.StudentID,
    s.Name,
    s.Email,
    s.Phone,
    i.IntakeName,
    b.BranchName,
    t.TrackName
FROM 
    Students s
JOIN 
    Intakes i ON s.IntakeID = i.IntakeID
JOIN 
    Branches b ON s.BranchID = b.BranchID
JOIN 
    Tracks t ON s.TrackID = t.TrackID;




GRANT select ON  [dbo].ViewStudentsAllDetails TO manager,instructor;


go


alter VIEW ViewStudentExamResults
AS
SELECT 
    sa.StudentID,
    st.Name AS StudentName,
    e.ExamID,
    c.CourseName,
    e.ExamType,
    sa.QuestionID,
    q.QuestionContent,
    sa.StudentAnswer,
    sa.IsCorrect,
    sa.Marks
FROM 
    StudentAnswers sa
JOIN 
    Students st ON sa.StudentID = st.StudentID
JOIN 
    Exams e ON sa.ExamID = e.ExamID
JOIN 
    Courses c ON e.CourseID = c.CourseID
JOIN 
    Questions q ON sa.QuestionID = q.QuestionID;


GRANT select ON  [dbo].ViewStudentExamResults TO manager,instructor;


CREATE VIEW ViewQuestionPoolAndInstructor
AS
SELECT 
    q.QuestionID,
    q.QuestionContent,
    q.QuestionType,
    q.CorrectAnswer,
    q.BestAcceptedAnswer,
    c.CourseName,
    i.Name AS InstructorName
FROM 
    Questions q
JOIN 
    Courses c ON q.CourseID = c.CourseID
JOIN 
InstructorCourses ic on c.CourseID=ic.CourseID
join
    Instructors i ON ic.InstructorID = i.InstructorID;



GRANT select ON  [dbo].ViewQuestionPoolAndInstructor TO manager,instructor;


go

CREATE VIEW ViewUserAccounts
AS
SELECT 
    u.UserID,
    u.Username,
    u.[typeOfUser],
    CASE 
        WHEN u.[typeOfUser] = 'Instructor' THEN (SELECT Name FROM Instructors WHERE userId = u.[userId])
        WHEN u.[typeOfUser] = 'Student' THEN (SELECT Name FROM Students WHERE userId = u.[userId])
        ELSE 'N/A'
    END AS PersonName
FROM 
    [dbo].[userSys] u;


