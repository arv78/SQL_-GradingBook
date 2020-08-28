-- Scalar Functions That Have Been Used In Multi-Statement
-- 1. Gets a course_id and student_id and returns the sum of all grades the student
--    has taken in that specific course_id.
create function [dbo].[SumOfAllGrades]
(
	@cid int,
	@sid int
)
returns int
as 
begin 
	declare @sum int;
	select @sum = sum(GRADE) from GRADE where COURSE_ID = @cid group by STUDENT_ID having STUDENT_ID = @sid
	return @sum
end
select dbo.SumOfAllGrades(7, 964418);

-- 2. Gets a course_id and returns the sum of all max_points
--    for that specific course_id.
create function [dbo].[SumOfAllPoints]
(
	@cid int
)
returns int
as 
begin
	declare @sum int;
	select @sum = sum(MAX_POINT) from GRADING_COMPONENT where COURSE_ID = @cid group by COURSE_ID
	return @sum
end
select dbo.SumOfAllPoints(7);

-- Table-Valued Multi-statement Function
-- Returns a table with students who have more than average score in all 
-- of the courses they have taken
create function [dbo].[MoreThanAvr]()
returns @MTA_T table
(
	student_id int,
	fname nvarchar(50),
	lname nvarchar(50),
	average int,
	score int,
	course_id int
)
as 
begin
	insert into @MTA_T select STUDENT.STUDENT_ID, FNAME, LNAME, (select dbo.SumOfAllPoints([TAKE].COURSE_ID)) / 2 as average,
	(select dbo.SumOfAllGrades([TAKE].COURSE_ID, STUDENT.STUDENT_ID)) as score, [TAKE].COURSE_ID from STUDENT, [TAKE] 
	where STUDENT.STUDENT_ID = [TAKE].STUDENT_ID and 
	(select dbo.SumOfAllGrades([TAKE].COURSE_ID, STUDENT.STUDENT_ID)) > (select dbo.SumOfAllPoints([TAKE].COURSE_ID)) / 2
	group by STUDENT.STUDENT_ID, FNAME, LNAME, [TAKE].COURSE_ID
	return
end
select * from MoreThanAvr();

-- Table-Valued In-Line Function
create function [dbo].[Instructor_Term]
(
	@term nvarchar(20),
	@ins_id int
)
returns table
as 
return 
(
	select * from COURSE where TERM = @term and INSTRUCTOR_ID = @ins_id
)
select * from Instructor_Term('Fall',44);