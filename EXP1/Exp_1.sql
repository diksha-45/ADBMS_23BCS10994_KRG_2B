/*Easy-level problem first*/
CREATE TABLE AUTHOR (
    AUTHOR_ID INT PRIMARY KEY,
    AUTHOR_NAME VARCHAR(100),
    COUNTRY VARCHAR(50)
);

CREATE TABLE BOOKS (
    BOOK_ID INT PRIMARY KEY,
    BOOK_NAME VARCHAR(100),
    AUTHOR_ID INT,
    FOREIGN KEY (AUTHOR_ID) REFERENCES AUTHOR(AUTHOR_ID)
);
INSERT INTO AUTHOR (AUTHOR_ID, AUTHOR_NAME, COUNTRY) VALUES
(1, 'Author X', 'USA'),
(2, 'Author Y', 'India'),
(3, 'Author Z', 'Canada');

INSERT INTO BOOKS (BOOK_ID, BOOK_NAME, AUTHOR_ID) VALUES
(101, 'Book A', 1),
(102, 'Book B', 2),
(103, 'Book C', 3);
SELECT 
    B.BOOK_NAME,
    A.AUTHOR_NAME,
    A.COUNTRY
FROM 
    BOOKS B
INNER JOIN 
    AUTHOR A ON B.AUTHOR_ID = A.AUTHOR_ID;
    SELECT * FROM BOOKS
    SELECT * FROM AUTHOR

/*Second problem*/
-- 1. Create Departments table
CREATE TABLE departments (
    department_id INT PRIMARY KEY,
    department_name VARCHAR(100) NOT NULL
);

-- 2. Create Courses table with foreign key
CREATE TABLE courses (
    course_id INT PRIMARY KEY,
    course_name VARCHAR(100) NOT NULL,
    department_id INT FOREIGN KEY REFERENCES departments(department_id)
);

-- 3. Insert Departments
INSERT INTO departments (department_id, department_name) VALUES
(1, 'Computer Science'),
(2, 'Mathematics'),
(3, 'Physics'),
(4, 'English'),
(5, 'Biology');

-- 4. Insert Courses
INSERT INTO courses (course_id, course_name, department_id) VALUES
(101, 'Data Structures', 1),
(102, 'Algorithms', 1),
(103, 'Operating Systems', 1),
(201, 'Calculus I', 2),
(202, 'Linear Algebra', 2),
(301, 'Quantum Mechanics', 3),
(302, 'Electromagnetism', 3),
(303, 'Thermodynamics', 3),
(401, 'English Literature', 4),
(501, 'Genetics', 5);

-- 5. Query: Departments offering more than 2 courses
SELECT department_name
FROM departments
WHERE department_id IN (
    SELECT department_id
    FROM courses
    GROUP BY department_id
    HAVING COUNT(*) > 2
);

GRANT SELECT ON courses TO readonly_user;

