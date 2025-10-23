create database student_management;
use student_management;
create table students (student_id integer primary key,student_name varchar(20),major varchar(25));
insert into students(student_id,student_name,major) values
(1001,"Alice Johnson","Computer Science"),
(1002,"Bob Williams","Mechanical Engineering"),
(1003,"Clara Davis","History"),
(1004,"David Miller","Computer Science"),
(1005,"Emily Brown","Biology"),
(1006,"Frank Wilson","Business"),
(1007,"Grace Lee","Art"),
(1008,"Henry Martin","Physics"),
(1009,"Ivy Chen","Mechanical Engineering"),
(1010,"Jack White","Computer Science"),
(1011,"Kate Hall","History"),
(1012,"Liam Clark","Biology"),
(1013,"Mia Scott","Business"),
(1014,"Noah Young","Art"),
(1015,"Olivia King","Physics"),
(1016,"Peter Green","Computer Science"),
(1017,"Quinn Baker","Biology"),
(1018,"Ryan Adams","Mechanical Engineering"),
(1019,"Sophia Carter","History"),
(1020,"Tom Evans","Business");
SELECT * FROM STUDENTS;

CREATE TABLE COURSES(course_id VARCHAR(10) PRIMARY KEY,course_name VARCHAR(30),credit_hrs INTEGER);
INSERT INTO COURSES(course_id,course_name,credit_hrs)
values ("CS 101","Intro to Programming",3),
("CS 305","Database Management",4),
("ME 201","Thermodynamics",3),
("ME 410","Fluid Dynamics",4),
("HI 102","World History",3),
("HI 350","Modern Asia",3),
("BI 101","General Biology",4),
("BI 220","Microbiology",4),
("BS 101","Principles of Finance",3),
("BS 315","Marketing Strategy",3),
("AR 105","Basic Drawing",3),
("AR 250","Digital Media",4),
("PH 101","Classical Mechanics",4),
("PH 402","Quantum Physics",3),
("CS 499","Capstone Project",3);

SELECT * FROM COURSES;


CREATE TABLE ENROLLMENTS(enrollment_id INTEGER PRIMARY KEY, student_id integer,FOREIGN KEY (STUDENT_ID) REFERENCES students(student_id),
course_id varchar(10),FOREIGN KEY (COURSE_ID) REFERENCES COURSES (course_id),SEMESTER VARCHAR(25));
INSERT INTO ENROLLMENTS (ENROLLMENT_ID,STUDENT_ID,COURSE_ID,SEMESTER)
VALUES(1,1001,"CS 101","Fall 2024"),
(2,1001,"CS 305","Fall 2024"),
(3,1001,"PH 101","Fall 2024"),
(4,1002,"ME 201","Fall 2024"),
(5,1002,"ME 410","Spring 2025"),
(6,1003,"HI 102","Fall 2024"),
(7,1004,"CS 101","Spring 2025"),
(8,1004,"CS 305","Spring 2025"),
(9,1005,"BI 101","Fall 2024"),
(10,1005,"BI 220","Fall 2024"),
(11,1006,"BS 101","Fall 2024"),
(12,1007,"AR 105","Fall 2024"),
(13,1008,"PH 101","Fall 2024"),
(14,1009,"ME 201","Spring 2025"),
(15,1010,"CS 101","Fall 2024"),
(16,1010,"CS 305","Fall 2024"),
(17,1011,"HI 102","Spring 2025"),
(18,1011,"HI 350","Spring 2025"),
(19,1012,"BI 101","Spring 2025"),
(20,1012,"BI 220","Spring 2025"),
(21,1013,"BS 101","Spring 2025"),
(22,1013,"BS 315","Spring 2025"),
(23,1014,"AR 250","Spring 2025"),
(25,1015,"PH 101","Spring 2025"),
(26,1015,"PH 402","Spring 2025"),
(27,1016,"CS 499","Spring 2025"),
(29,1017,"BI 101","Fall 2024"),
(30,1017,"BI 101","Fall 2024"),
(32,1018,"ME 410","Spring 2025"),
(33,1019,"HI 102","Fall 2024"),
(34,1019,"HI 102","Fall 2024"),
(36,1020,"BS 315","Spring 2025"),
(37,1001,"CS 499","Spring 2025"),
(38,1004,"CS 499","Fall 2024"),
(39,1006,"BS 315","Fall 2024"),
(40,1007,"AR 250","Spring 2025");

select * from enrollments;


select distinct student_name from students;
-- There are 20 students.

select distinct course_name from courses;
-- There are 15 different courses available.

select student_id,course_id from enrollments;

-- Every student has enrolled in one of the course atleast.


select c.course_id,c.course_name,count(student_id)
from enrollments as e
join courses as c
using(course_id)
group by course_id
order by count(student_id) desc;

-- The course_id BI 101,HI 102 and course_name General Biology,World History has maximum number of students enrolled in it i.e. 4
 
INSERT INTO STUDENTS (STUDENT_ID,STUDENT_NAME,MAJOR)
VALUES (1021,"John Philis","null");



select s.student_id,s.student_name,s.major,c.course_id,c.course_name,e.semester
from students as s
join enrollments as e 
using(student_id)
join courses as c
using(course_id)
order by student_id asc;


-- Write SQL query which will return the names,major of all students whose major is 'Computer Science'

select student_name,major from students where major="computer science";

-- Write a query to counts the number of students in each unique major
select major,count(student_id)
from students
group by major;

-- The maximum number of students are from computer science major

-- Write query that lists the student name, course name, and semester for all enrollments
select s.student_name,c.course_name,e.semester
from students as s
join enrollments as e
using(student_id)
join courses as c
using(course_id);

-- Write query to find the course_name and the number of enrollments for all courses, ordered from most popular to least popular
select c.course_name,count(enrollment_id) as total_enrollments
from courses as c
join enrollments as e
using(course_id)
group by c.course_name
order by count(enrollment_id) desc;

-- Write a query to find the course_id and course_name for courses whose name contains the word 'Database'
select course_id,course_name
from courses 
where course_name like "%database%";

-- To find a list of all unique student majors that have at least one student enrolled in the 'Spring 2025' semester
select s.major,count(s.student_id)as total_student,e.semester
from students as s
join enrollments as e
using (student_id)
where e.semester="spring 2025"
group by major;

-- Write a query to calculates total credit hours of student where student_id = 1001 and enrolled in for the 'Fall 2024' semester
select sum(c.credit_hrs) as total_credit_hrs
from courses as c
join enrollments as e
using(course_id)
join students as s
using(student_id)
where student_id=1001 and semester="fall 2024"; 


-- Which query finds the names of students who are not enrolled in any courses during the 'Spring 2025' semester
select distinct student_name,semester from students
join enrollments
using(student_id)
where student_id not in
(select student_id from enrollments where semester="spring 2025");

-- Write a query to find student_id and student_name of all students and sort alphabetically by student_name in descending order (Z to A)
select student_id,student_name 
from students
order by student_name desc;

-- Write a query to find the course_name  that have credit hours between 3 and 4 (inclusive)
select course_name
from courses
where credit_hrs between 3 and 4;

-- Write a query that returns the student_name of all students who are enrolled in both 'CS 101' and 'CS 305'
SELECT student_name FROM students WHERE 
student_id IN (SELECT student_id FROM enrollments WHERE course_id = 'CS 101') 
AND student_id IN (SELECT student_id FROM enrollments WHERE course_id = 'CS 305');

-- Write a query that identifies all majors that have students with a student_id greater than 1015
select distinct major from students
where student_id>1015;

-- Write a query to find the student_name who are taking only courses with 4 credit hours
select student_name
from students
where student_id in (select student_id from enrollments join courses using(course_id) where credit_hrs=4);

-- Write a query that returns the student_name and the total number of distinct courses they are currently enrolled in
select student_name,count(distinct course_id)
from students
join enrollments
using(student_id)
group by student_name;

-- Write a SQL query to update the major for the student named 'Henry Martin' (student ID 1008) from 'Physics' to 'Astrophysics'
update students set major="Astrophysics"
where student_id=1008;

-- Write the SQL statement to delete the course 'Quantum Physics' (course ID 'PH 402') from the COURSES table
delete from enrollments 
where course_id="PH 402";

delete from courses
where course_id="PH 402";

-- Write a query to add a new column named gpa with a decimal data type to the STUDENTS table
alter table students
add column (gpa float);
-- Write a query to increase the credit hours for all courses with a course_id starting with 'HI' (History) by 1 hour
update courses set credit_hrs=credit_hrs+1
where course_id like "HI%";

-- Write a query to change the data type of the student_name column in the STUDENTS table to VARCHAR(50).
Alter table students 
modify student_name varchar(50);

-- Write a query to remove all enrollment records that occurred in the 'Spring 2025' semester
delete from enrollments
where semester="spring 2025";
-- Write a query to add a NOT NULL constraint to the student_name column in the STUDENTS table
alter table students 
modify student_name varchar(50) not null;

-- Write an sql query to do inner join,left join,right join on students and enrollments table
 select * from students
 inner join enrollments
 using(student_id);
 
 
 select * from students
 left join enrollments 
 using(student_id);
 
 
 select * from students
 right join enrollments
 using(student_id);
 
 
Update enrollments set enrollment_id=102
where enrollment_id=2;
commit;

Update students set student_name="Ansar Inamdar"
where student_id=1003;

select * from students;
Update students set student_name="Ansar Shaikh"
where student_id=1003;

savepoint sp1;

Delete from students 
where student_id=1021;

savepoint sp2;

rollback to savepoint sp1;

Update students set student_name="Clara Davis"
where student_id=1003;

Update students set major="Computer Science"
where student_id=1003;

savepoint sp3;

COMMIT;

Truncate table enrollments;
-- The records from enrollments table is now deleted enrollments table is now empty








 
 
 
 
 
