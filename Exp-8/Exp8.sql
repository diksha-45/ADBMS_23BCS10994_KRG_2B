--Creating Table and Basic Transactions

--Creating the Students table

CREATE TABLE Students(
Id INT PRIMARY KEY,
Name VARCHAR(50) UNIQUE,
Age INT,
Class INT
);

Inserting sample data

INSERT INTO Students (ID, Name, Age, Class) VALUES
(1, 'Aarav', 17, 8),
(2, 'Vikram', 16, 4),
(3, 'Priya', 15, 6),
(4, 'Rohan', 16, 7),
(5, 'Sita', 17, 8),
(6, 'Kiran', 15, 6);
SELECT FROM STUDENTS;

--Implicit Transaction (Auto-commit):

--This UPDATE commits automatically
UPDATE STUDENTS
SET NAME = 'XYZ'
WHERE ID = 6;
--Changes are permanent immediately
SELECT FROM STUDENTS,

--Explicit Transaction with COMMIT:
--Start explicit transaction
BEGIN TRANSACTION;
UPDATE STUDENTS SET NAME = 'DIKSHA' WHERE ID = 1;
SELECT FROM STUDENTS;

--Explicit Transaction with ROLLBACK:
Start transaction BEGIN TRANSACTION;
UPDATE STUDENTS SET NAME = 'TEMP' WHERE ID = 6;
SELECT FROM STUDENTS;

--Advanced: Exception Handling with Savepoints (Hard Level)
  
CREATE TABLE students (
id SERIAL PRIMARY KEY, name VARCHAR(50) UNIQUE,
age INT,
class INT
--Successful Transaction Scenario:
DO $$
BEGIN
--Start transaction
BEGIN
--Insert multiple studente
INSERT INTO students(name, age, class)
VALUED ('Anisha', 16,8):
INSERT INTO students (name, age, class)
VALUES ('Diksha', 17,8)
INSERT INTO students (name, age, class)
VALUES('Neha', 19.9)
--If all succeed
RAISE NOTICE 'Transaction Successfully Done':
EXCEPTION WHEN OTHERS THEN
--If any insert fails
RAISE NOTICE 'Transaction Failed! Rolling back changes.';
RAISE;
END;
END;
$$;
SELECT * FROM students;
