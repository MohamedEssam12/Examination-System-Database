The Examination System Database is a comprehensive system designed to manage the creation, administration, and evaluation of exams within an educational institution. The system allows instructors to create exams from a pool of questions, manage courses, and evaluate student performance. The Training Manager oversees the overall system, including managing branches, tracks, instructors, courses, and student enrollments.


Key Features

System Requirements
Question Pool Management

Supports multiple question types: Multiple Choice, True/False, and Text Questions.
Instructors can add, update, and delete questions within their courses.
Course and Instructor Management

Stores detailed information about courses, instructors, and students.
Each course can have one or more instructors, and instructors can teach multiple courses.
Exam Creation and Administration

Instructors can create exams by selecting questions manually or randomly from the question pool.
Allows setting the exam type, start and end times, total duration, and other allowances.
Supports multiple exams per course, defined by year, course, and instructor.
Student Exam Participation

Students can only see and take exams at the specified times.
System records student answers and calculates the results automatically for objective questions.
Instructors manually review and grade text answers.
User Accounts and Permissions

Different user roles with specific permissions: Training Manager, Instructor, and Student.
Each user can only access and manage data relevant to their role.
Data Integrity and Performance

Utilizes constraints, triggers, indexes, and appropriate data types for optimal performance and integrity.
Daily automatic backups to ensure data safety.
Technical Details
Database Design

Tables for courses, instructors, students, exams, questions, student answers, branches, tracks, and intakes.
Relationships between tables to manage course-instructor assignments, student enrollments, and exam questions.
Stored Procedures

Procedures for adding, updating, and deleting data in various tables.
Procedures for creating exams, both manually and with random question selection.
Functions and Triggers

Functions for calculating student scores and validating data integrity.
Triggers to enforce business rules and maintain consistency.
Views

Views to simplify data retrieval for users, ensuring they do not need to write complex queries.
User Permissions

SQL users and roles defined to restrict access based on user roles.
Permissions granted on views to ensure secure data access.
Deliverables
System Requirement Sheet

Detailed document outlining system requirements and functionalities.
System ERD

Entity-Relationship Diagram representing the database structure.
Database Files

SQL scripts for creating the database, tables, and inserting test data.
SQL Server Solution

Script files for individual contributions and a combined script for the entire database structure, objects, and data.
Documentation

Text file with descriptions of all database objects (views, procedures, functions, triggers).
Test sheets with queries, results, and comments.
Account details for the database users.
