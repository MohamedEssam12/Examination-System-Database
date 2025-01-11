EXEC AddInstructor 'shaban',  'shaban@example.com', '1234567890', '2024-07-05', 'Computer Science';



EXEC [dbo].[UpdateInstructor] 7, 'John', 'john.smith@example.com', '0987654321', '2024-07-05';

-- Deleting an instructor
EXEC DeleteInstructor 1;

-- Adding a new course
EXEC AddCourse 'Database Systems', 'Introduction to Database Systems', 100, 50;

-- Updating a course's information
EXEC UpdateCourse 1, 'Advanced Database Systems', 'Advanced topics in Database Systems', 100, 50;

-- Deleting a course
EXEC DeleteCourse 1;

-- Assigning an instructor to a course
EXEC InstructorToCourse 1, 1;

-- Removing an instructor from a course
EXEC RemoveInstructorFromCourse 1;