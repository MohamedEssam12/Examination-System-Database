CREATE LOGIN student
WITH PASSWORD='student@123';

go
CREATE LOGIN instructor
WITH PASSWORD='instructor@123';

go
CREATE LOGIN manager
WITH PASSWORD='manager@123';

go
create user student
for login student
go
create user instructor
for login instructor
go


create user manager
for login manager


go





GRANT SELECT, INSERT, UPDATE, DELETE ON Questions TO Instructor;
GRANT EXECUTE ON AddQuestion TO Instructor,manager;
GRANT EXECUTE ON UpdateQuestion TO Instructor,manager;
GRANT EXECUTE ON DeleteQuestion TO Instructor,manager;



GRANT EXECUTE ON AddInstructor TO manager;
GRANT EXECUTE ON UpdateInstructor TO manager;
GRANT EXECUTE ON DeleteInstructor TO manager;



GRANT EXECUTE ON AddCourse TO manager;
GRANT EXECUTE ON UpdateCourse TO manager;
GRANT EXECUTE ON DeleteCourse TO manager;

GRANT EXECUTE ON InstructorToCourse TO manager;
GRANT EXECUTE ON RemoveInstructorFromCourse TO manager;





GRANT EXECUTE ON AddBranch TO manager;
GRANT EXECUTE ON UpdateBranch TO manager;
GRANT EXECUTE ON DeleteBranch TO manager;

GRANT EXECUTE ON AddTrack TO manager;
GRANT EXECUTE ON UpdateTrack TO manager;
GRANT EXECUTE ON DeleteTrack TO manager;

GRANT EXECUTE ON AddIntake TO manager;
GRANT EXECUTE ON UpdateIntake TO manager;
GRANT EXECUTE ON DeleteIntake TO manager;




GRANT EXECUTE ON [dbo].[AddDepartment] TO manager;
GRANT EXECUTE ON [dbo].[UpdateDepartment] TO manager;
GRANT EXECUTE ON [dbo].[DeleteDepartment] TO manager;


GRANT EXECUTE ON [dbo].[AddQuestionToExam] TO manager;

GRANT EXECUTE ON  [dbo].[AddStudent] TO manager;
GRANT EXECUTE ON [dbo].[AddUser] TO manager;
GRANT EXECUTE ON [dbo].[AssignStudentsToExam] TO manager;


GRANT EXECUTE ON [dbo].[CalculateExamResults] TO manager;
GRANT EXECUTE ON [dbo].[CreateExam] TO manager;
GRANT EXECUTE ON [dbo].[DeleteStudent] TO manager;


GRANT EXECUTE ON [dbo].[DeleteUser] TO manager;
GRANT EXECUTE ON [dbo].[EvaluateTrueFalseAnswers] TO manager;
GRANT EXECUTE ON [dbo].[InstructorToCourse] TO manager;


GRANT EXECUTE ON [dbo].[RemoveInstructorFromCourse] TO manager;
GRANT EXECUTE ON [dbo].[sp_GetStudentCourse] TO manager;
GRANT EXECUTE ON  [dbo].[UpdateStudent]TO manager;


GRANT EXECUTE ON [dbo].[UpdateUser] TO manager;



GRANT EXECUTE ON [dbo].[InstructorToCourse] TO manager;



GRANT  select on [ExamQuestionsView] TO manager,instructor;
GRANT select ON [dbo].[InstructorCoursesView] TO manager,instructor;


GRANT select ON  [dbo].[show_Branch_view] TO manager;
GRANT select ON [dbo].[show_Course_view] TO manager,instructor;
GRANT select ON [dbo].[show_Dept_view] TO manager;


GRANT select ON [dbo].[show_DeptofBranch_view] TO manager;
GRANT select ON [dbo].[show_Exam_view] TO manager,instructor;
GRANT select ON [dbo].[show_Instructor_view] TO manager,instructor;


GRANT select ON [dbo].[show_Intake_view] TO manager;
GRANT select ON [dbo].[show_Questions_view] TO manager,instructor;
GRANT select ON [dbo].[show_Students_view] TO manager,instructor;



GRANT select ON [dbo].[show_Track_view] TO manager;
GRANT select ON[dbo].[show_User_view] TO manager;
GRANT select ON [dbo].[StudentAnswersView] TO manager;
GRANT select ON  [dbo].[StudentCourseView] TO manager,instructor;
GRANT select ON [dbo].[StudentView] TO manager,instructor,student;


