create database Examination ;
go
CREATE TABLE Departments (
    DepartmentID INT PRIMARY KEY IDENTITY(1,1),
    DepartmentName NVARCHAR(100) NOT NULL,
    Description NVARCHAR(255)
);
go

CREATE TABLE Branches (
    BranchID INT PRIMARY KEY IDENTITY(1,1),
    BranchName NVARCHAR(100) NOT NULL,
    Description NVARCHAR(255),
  
);

go
CREATE TABLE Tracks (
    TrackID INT PRIMARY KEY IDENTITY(1,1),
    BranchID INT FOREIGN KEY REFERENCES Branches(BranchID),
    TrackName NVARCHAR(100) NOT NULL,
    Description NVARCHAR(255),
	 DeptID INT FOREIGN KEY REFERENCES Departments(DepartmentID)
);
go
CREATE TABLE Intakes (
    IntakeID INT PRIMARY KEY IDENTITY(1,1),
    IntakeName NVARCHAR(100) NOT NULL,
    StartDate DATE,
    EndDate DATE
);

go
CREATE TABLE Courses (
    CourseID INT PRIMARY KEY IDENTITY(1,1),
    CourseName NVARCHAR(100) NOT NULL,
    Description NVARCHAR(255),
    MaxDegree INT,
    MinDegree INT,
  
);

go
CREATE TABLE Instructors (
    InstructorID INT PRIMARY KEY IDENTITY(1,1),
    FirstName NVARCHAR(50) NOT NULL,
    LastName NVARCHAR(50) NOT NULL,
    Email NVARCHAR(100) NOT NULL,
    Phone NVARCHAR(15),
    HireDate DATE,
    
);

go
CREATE TABLE Students (
    StudentID INT PRIMARY KEY IDENTITY(1,1),
    Name NVARCHAR(50) NOT NULL,
    Email NVARCHAR(100) NOT NULL,
    Phone NVARCHAR(15),
    IntakeID INT FOREIGN KEY REFERENCES Intakes(IntakeID),
    BranchID INT FOREIGN KEY REFERENCES Branches(BranchID),
    TrackID INT FOREIGN KEY REFERENCES Tracks(TrackID)
);

go

CREATE TABLE InstructorCourses (
    InstructorID INT FOREIGN KEY REFERENCES Instructors(InstructorID),
    CourseID INT FOREIGN KEY REFERENCES Courses(CourseID),
	yearOfCourse varchar(4) 
	CONSTRAINT PK_Orders PRIMARY KEY (InstructorID, CourseID,yearOfCourse)

);
go
CREATE TABLE StudentCourse (
    StudentID INT FOREIGN KEY REFERENCES Students(StudentID),
    CourseID INT FOREIGN KEY REFERENCES Courses(CourseID),
	CONSTRAINT PK_StudentCourse PRIMARY KEY (StudentID, CourseID)	
);

go
CREATE TABLE Questions (
    QuestionID INT PRIMARY KEY IDENTITY(1,1),
    CourseID INT FOREIGN KEY REFERENCES Courses(CourseID),
    QuestionType NVARCHAR(20) CHECK (QuestionType IN ('Multiple Choice', 'True/False', 'Text')),
    QuestionContent NVARCHAR(1000) NOT NULL,
    CorrectAnswer NVARCHAR(1000), -- For Multiple Choice and True/False questions
    BestAcceptedAnswer NVARCHAR(1000) -- For Text questions
);


go
CREATE TABLE Exams (
    ExamID INT PRIMARY KEY IDENTITY(1,1),
    CourseID INT FOREIGN KEY REFERENCES Courses(CourseID),
    InstructorID INT FOREIGN KEY REFERENCES Instructors(InstructorID),
    ExamType NVARCHAR(20) CHECK (ExamType IN ('Exam', 'Corrective')),
    IntakeID INT FOREIGN KEY REFERENCES Intakes(IntakeID),
    BranchID INT FOREIGN KEY REFERENCES Branches(BranchID),
    TrackID INT FOREIGN KEY REFERENCES Tracks(TrackID),
    StartTime DATETIME,
    EndTime DATETIME,
    TotalTime INT
);

go
CREATE TABLE ExamQuestions (
    ExamQuestionID INT PRIMARY KEY IDENTITY(1,1),
    ExamID INT FOREIGN KEY REFERENCES Exams(ExamID),
    QuestionID INT FOREIGN KEY REFERENCES Questions(QuestionID),
    QuestionDegree INT
);

go
CREATE TABLE StudentAnswers (
    StudentAnswerID INT PRIMARY KEY IDENTITY(1,1),
    ExamID INT FOREIGN KEY REFERENCES Exams(ExamID),
    StudentID INT FOREIGN KEY REFERENCES Students(StudentID),
    QuestionID INT FOREIGN KEY REFERENCES Questions(QuestionID),
    StudentAnswer NVARCHAR(1000),
    IsCorrect BIT,
    Marks INT
);
go

create table userSys(
	userId int primary key identity(1,1),
	userName varchar(50) not null,
	userPassword varchar(50) not null,
	typeOfUser varchar(20),
	constraint checkTypeOfUser check (typeOfUser in  ('admin','manager','instructor','student'))
)

go
alter table [dbo].[Instructors]
add userId int foreign key references userSys(userId)

go

alter table [dbo].[Students]
add userId int foreign key references userSys(userId)

go

