use Examination
go
------------Insert User data--------------
insert into [dbo].[userSys] ( userName, userPassword, typeOfUser)
values
('admin', 'admin123', 'admin'),
( 'manager1', 'manager123', 'manager'),
( 'instructor1', 'instructor123', 'instructor'),
( 'student1', 'student123', 'student'),
( 'student2', 'student456', 'student');
go
------------Insert department data--------------
insert into [dbo].[Departments] ( DepartmentName, [Description])
values
( 'Software Dept', 'For Software content'),
( 'Hardware Dept', 'For Hardware content');
go
------------Insert Course data--------------
insert into [dbo].[Courses] ( CourseName, [Description], MaxDegree, MinDegree)
values
( 'Database Management', 'Introduction to database management systems.', 100, 0),
( 'Programming Fundamentals', 'Introduction to programming concepts.', 90, 10),
( 'Human Resource Management', 'Overview of HR principles.', 95, 5),
( 'Financial Accounting', 'Basic financial accounting principles.', 98, 2),
( 'Marketing Strategies', 'Strategies for effective marketing.', 92, 8);
go
------------Insert Instructors data--------------
insert into [dbo].[Instructors] ( [Name], Email, Phone, HireDate, userId)
values
( 'John Instructor', 'john@example.com', '123-456-7890', getdate(), 12),
( 'Jane Instructor', 'jane@example.com', '987-654-3210', '2019-3-6',13),
( 'Bob Trainer', 'bob@example.com', '111-222-3333', '2022-11-7',7),
( 'Alice Teacher', 'alice@example.com', '444-555-6666', '2020-1-26',13),
( 'Sara Educator', 'Sara@example.com', '222-664-4433', '2024-02-15',12),
( 'Charlie Educator', 'charlie@example.com', '777-888-9999', '2017-06-07',7);
go

------------Insert Branches data--------------
insert into [dbo].[Branches] ( BranchName, [Description])
values
( 'Main Branch', 'Managment'),
( 'HR Branch', 'Human Resources'),
( 'Finance Branch', 'Money Management'),
( 'Marketing Branch', 'Advertising annd Management');
go
------------Insert Tracks data--------------
insert into [dbo].[Tracks] ( TrackName, DeptID)
values
( 'Database Track', 1 ),
( 'Programming Track', 1),
( 'HR Track', 1),
( 'Finance Track', 2),
( 'Marketing Track', 2);
go
------------Insert Intake data--------------
insert into [dbo].[Intakes] (IntakeName,StartDate,EndDate)
values
( 'Spring', '2023-2-4','2023-2-8'),
( 'Fall', '2023-12-11', '2024-10-3'),
( 'Summer', '2023-4-8', '2023-1-12'),
( 'Winter', '2023-3-1', '2023-3-4'),
( 'Spring', '2024-1-5', '2024-2-9');
go
------------Insert Students data--------------
insert into [dbo].[Students] ( [Name], Email, Phone, IntakeID, BranchID, TrackID, userId)
values
( 'Student One', 'student1@example.com', '111-222-3333', 5, 1, 1, 8),
( 'Student Two', 'student2@example.com', '444-555-6666', 6, 2, 2, 9),
( 'Student Three', 'student3@example.com', '777-888-9999', 7, 3, 3, 15),
( 'Student Four', 'student4@example.com', '123-456-7890', 8, 4, 4, 16),
( 'Student Five', 'student5@example.com', '987-654-3210', 9, 5, 5, 8);
go
------------Insert Exam data--------------
insert into [dbo].[Exams] ( ExamType, StartTime, TotalTime, IntakeID, BranchID, TrackID)
values
( 'Exam', '10:00:00', 120, 5, 1, 2),
( 'Exam', '14:00:00', 180, 6, 3, 4),
( 'Corrective', '11:00:00', 60, 7, 2, 1),
( 'Corrective', '9:00:00', 120, 8, 4, 5);
go
------------Insert Questions data--------------
insert into [dbo].[Questions] ( QuestionContent, QuestionType, CorrectAnswer, CourseID)
values
( 'What is 2 + 2?', 'Multiple Choice', '4', 1),
( 'Is the Earth round?', 'True/False', 'True', 4),
( 'Name one element on the periodic table.', 'Text', 'Oxygen', 2);
go
------------Insert Student Course data--------------
insert into [dbo].[StudentCourse](StudentID, CourseID)
values
(4, 1),
(5, 2),
(3, 3);
go
------------Insert Student Answers data--------------
insert into [dbo].[StudentAnswers] ( IsCorrect, ExamID, QuestionID, StudentID, StudentAnswer,Marks)
values
(1,4, 7, 4, 'Option A', 10),
(0,5, 8, 5, 'True', 15),
(0,3, 9, 3, 'Oxygen', 30);
go
------------Insert Instructor Course data--------------
insert into [dbo].[InstructorCourses] (InstructorID, CourseID, yearOfCourse)
values
(25,1,'2023'),
(26,2,'2023'),
(30,3,'2024'),
(31,4,'2023');
go
------------Insert Exam Questions data--------------
insert into [dbo].[ExamQuestions] ( QuestionDegree, ExamID, QuestionID)
values
( 10, 6, 7),
( 15, 5, 8),
( 20, 3, 9),
( 20, 4, 7);


