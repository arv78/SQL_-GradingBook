 --INSTRUCTOR

 -- 1.insert
 create procedure Add_Instructor
 @id int,
 @name nvarchar(50),
 @family nvarchar(50)
 AS
 BEGIN
 insert into INSTRUCTOR(INSTRUCTOR_ID,FNAME,LNAME)
 values(@id, @name, @family)
 END

 --EXEC Add_Instructor @id = 1, @name='f',@family='g';

 -- 2.update
 create procedure update_Instructor
 @id int,
 @name nvarchar(50),
 @family nvarchar(50)
 AS
 BEGIN
 update INSTRUCTOR
 set FNAME = @name, LNAME = @family
 where INSTRUCTOR_ID = @id;
 END

--EXEC update_Instructor @id=1, @name='c',@family='d';

 -- 3.select
 create procedure select_instructor
 AS
 BEGIN
 select* from INSTRUCTOR
 END

 --EXEC select_instructor;

 -- 4.delete
  create procedure delete_Instructor
 @id int
 AS
 BEGIN
 delete from INSTRUCTOR
 where INSTRUCTOR_ID = @id
 END

--EXEC delete_Instructor @id=1;
 
 
-- STUDENT
 -- 1.insert
create procedure Add_Student
 @id int,
 @name nvarchar(50),
 @family nvarchar(50),
 @email nvarchar(50)
 AS
 BEGIN
 insert into STUDENT(STUDENT_ID,FNAME,LNAME,EMAIL)
 values(@id, @name, @family, @email)
 END

 --EXEC Add_Student @id=1, @name='regina',@family='phalangee',@email='regina.phalangee'

 
 -- 2.update
 create procedure update_Student
 @id int,
 @name nvarchar(50),
 @family nvarchar(50),
 @email nvarchar(50)
 AS
 BEGIN
 update STUDENT
 set FNAME = @name, LNAME = @family, EMAIL = @email
 where STUDENT_ID = @id;
 END

 --EXEC update_Student @id=1, @name='reg',@family='ph',@email='hhh@g.com';

 -- 3.select
 create procedure select_Student
 AS
 BEGIN
 select* from STUDENT
 END

 --EXEC select_Student;

 -- 4.delete
create procedure delete_Student
 @id int
 AS
 BEGIN
 delete from STUDENT
 where STUDENT_ID = @id;
 END

 --EXEC delete_Student @id=1;

-- COURSE
 -- 1.insert
create procedure Add_Course
 @id int,
 @name nvarchar(50),
 @term nvarchar(20),
 @section int,
 @ins_id int,
 @a int,
 @b int,
 @c int,
 @d int,
 @f int
 AS
 BEGIN
 insert into COURSE(COURSE_ID,COURSE_NAME,TERM,SECTION_NUMBER,INSTRUCTOR_ID,A,B,C,D,F)
 values(@id, @name, @term, @section, @ins_id, @a, @b, @c, @d, @f)
 END

 --EXEC Add_Course @id = 8,@name='t',@term='t',@section=2 ,@ins_id=44 ,@a = 80, @b = 60, @c = 40, @d = 20, @f = 0


 -- 2.update
 create procedure update_Course
 @id int,
 @name nvarchar(50),
 @term nvarchar(20),
 @section int,
 @ins_id int,
 @a int,
 @b int,
 @c int,
 @d int,
 @f int
 AS
 BEGIN
 update COURSE
 set COURSE_NAME = @name, TERM = @term, SECTION_NUMBER = @section, INSTRUCTOR_ID = @ins_id, A = @a, B = @b, C = @c, D = @d, F = @f
 where COURSE_ID = @id;
 END

 --EXEC update_Course @id = 8, @name='temp',@term='temp',@section=2 ,@ins_id=44 ,@a = 80, @b = 60, @c = 40, @d = 20, @f = 0


  -- 3.select
 create procedure select_Course
 AS
 BEGIN
 select* from COURSE
 END

 --EXEC select_Course;

  -- 4.delete
create procedure delete_Course
 @id int
 AS
 BEGIN
 delete from COURSE
 where COURSE_ID = @id;
 END

-- EXEC delete_Course @id=8;


-- TAKE
 -- 1.insert
 create procedure insert_Take
 @s_id int,
 @c_id int
 AS
 BEGIN
 insert into TAKE(STUDENT_ID,COURSE_ID)
 values(@s_id, @c_id)
 END

 --EXEC insert_Take @s_id = 964401 , @c_id = 3;


-- 2.select
 create procedure select_Take
 AS
 BEGIN
 select* from TAKE
 END

 --EXEC select_Take;

-- 3.delete
  create procedure delete_Take
 @s_id int,
 @c_id int
 AS
 BEGIN
 delete from TAKE
 where STUDENT_ID = @s_id AND COURSE_ID = @c_id
 END

--EXEC delete_Take @s_id=964401 , @c_id = 3;
 
 
-- GRADING COMPONENT 
 -- 1.insert

 create procedure Add_Component
 @id int,
 @name nvarchar(50),
 @weight int,
 @max int
 AS
 BEGIN
 insert into GRADING_COMPONENT(COURSE_ID,NAME,WEIGHT,MAX_POINT)
 values(@id, @name, @weight, @max)
 END

 --EXEC Add_Component @id = 2, @name='Project', @weight = 3, @max = 50;

 -- 2.update
 create procedure update_Component
 @id int,
 @name nvarchar(50),
 @weight int,
 @max int
 AS
 BEGIN
 update GRADING_COMPONENT
 set WEIGHT = @weight, MAX_POINT = @max
 where COURSE_ID = @id and NAME = @name
 END

-- EXEC update_Component @id = 2, @name='Project', @weight = 3, @max = 50;


 -- 3.select
 create procedure select_Component
 AS
 BEGIN
 select* from GRADING_COMPONENT
 END

 --EXEC select_Component;

 -- 4.delete
  create procedure delete_Component
 @id int,
 @name nvarchar(50)
 AS
 BEGIN
 delete from GRADING_COMPONENT
 where COURSE_ID = @id AND [NAME] = @name 
 END

 --EXEC delete_Component @id = 2, @name = 'Project';
 
 -- GRADE
  -- 1.insert
 create procedure insert_Grade
 @s_id int,
 @c_id int,
 @name nvarchar(50),
 @grade int
 AS
 BEGIN
 insert into GRADE(STUDENT_ID,COURSE_ID,NAME,GRADE)
 values(@s_id, @c_id,@name,@grade)
 END

-- EXEC insert_Grade @s_id = 964401 , @c_id = 6, @name = 'Final', @grade = 18;

 -- 2.update

 create procedure update_Grade
  @s_id int,
 @c_id int,
 @name nvarchar(50),
 @grade int
 AS
 BEGIN
 update GRADE
 set GRADE = @grade
 where [NAME] = @name and STUDENT_ID = @s_id and COURSE_ID = @c_id
 END

 -- EXEC update_Grade @s_id = 964401 , @c_id = 6, @name = 'Final', @grade = 18;


 -- 3.select
 create procedure select_Grade
 AS
 BEGIN
 select* from GRADE
 END

 -- EXEC select_Grade;

 -- 4.delete
  create procedure delete_Grade
 @s_id int,
 @c_id int,
 @name nvarchar(50)
 AS
 BEGIN
 delete from Grade
 where STUDENT_ID = @s_id AND COURSE_ID = @c_id AND NAME = @name
 END 

 --EXEC delete_Grade @s_id=964401 , @c_id = 6, @name = 'Final'
 
 