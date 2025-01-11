use [Examination]
go
create nonclustered index Branch_Name
on Branches (BranchName)
go
create nonclustered index Course_Name
on Courses (CourseName)
go
create nonclustered index Course_MaxDegree
on Courses ([MaxDegree])
go
create nonclustered index Course_MinDegree
on Courses ([MinDegree])
go
create nonclustered index Dept_Name
on Departments ([DepartmentName])
go
create nonclustered index Exam_Type
on [dbo].[Exams] ([ExamType])
go
create nonclustered index Exam_Intake
on [dbo].[Exams] ([IntakeID])
go
create nonclustered index Exam_Track
on [dbo].[Exams] ([TrackID])
go
create nonclustered index Exam_Branch
on [dbo].[Exams] ([BranchID])
go
create nonclustered index Exam_StartTime
on [dbo].[Exams] ([StartTime])
go
create nonclustered index Exam_Allowance
on [dbo].[Exams] ([AllowanceOptions])
go
create nonclustered index Instructor_Name
on [dbo].[Instructors] ([Name])
go
create nonclustered index Instructor_Email
on [dbo].[Instructors] ([Email])
go
create nonclustered index Instructor_Phone
on [dbo].[Instructors] ([Phone])
go
create nonclustered index Instructor_HireDate
on [dbo].[Instructors] ([HireDate])
go
create nonclustered index Intake_Name
on [dbo].[Intakes] ([IntakeName])
go
create nonclustered index Intake_StartDate
on [dbo].[Intakes] ([StartDate])
go
create nonclustered index Intake_EndDate
on [dbo].[Intakes] ([EndDate])
go
create nonclustered index Question_Type
on [dbo].[Questions] ([QuestionType])
go
create nonclustered index Question_Content
on [dbo].[Questions] ([QuestionContent])
go
create nonclustered index Question_CorrectAnswer
on [dbo].[Questions] ([CorrectAnswer])
go
create nonclustered index Question_BestAnswer
on [dbo].[Questions] ([BestAcceptedAnswer])
go
create nonclustered index Student_Answer
on [dbo].[StudentAnswers] ([StudentAnswer])
go
create nonclustered index Student_IsCorrect
on [dbo].[StudentAnswers] ([IsCorrect])
go
create nonclustered index Student_Marks
on [dbo].[StudentAnswers] ([Marks])
go
create nonclustered index Student_Name
on [dbo].[Students] ([Name])
go
create nonclustered index Student_Email
on [dbo].[Students] ([Email])
go
create nonclustered index Student_Phone
on [dbo].[Students] ([Phone])
go
create nonclustered index Track_Name
on [dbo].[Tracks] ([TrackName])
go
create nonclustered index User_Type
on [dbo].[userSys] ([typeOfUser])
go