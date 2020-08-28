CREATE TABLE COURSE
(
COURSE_ID INT NOT NULL,
COURSE_NAME NVARCHAR(50) NOT NULL,
TERM NVARCHAR(20) NOT NULL,
SECTION_NUMBER INT NOT NULL,
INSTRUCTOR_ID INT NOT NULL,
A INT,
B INT,
C INT,
D INT,
F INT,
PRIMARY KEY (COURSE_ID)
);

CREATE TABLE INSTRUCTOR
(
INSTRUCTOR_ID INT NOT NULL,
FNAME NVARCHAR(50) NOT NULL,
LNAME NVARCHAR(50) NOT NULL,
PRIMARY KEY(INSTRUCTOR_ID)
);

CREATE TABLE GRADING_COMPONENT
(
[NAME] NVARCHAR(50) NOT NULL,
[WEIGHT] INT,
MAX_POINT INT,
COURSE_ID INT NOT NULL,
PRIMARY KEY([NAME],COURSE_ID)
);

CREATE TABLE STUDENT
(
STUDENT_ID INT NOT NULL,
FNAME NVARCHAR(50) NOT NULL,
LNAME NVARCHAR(50) NOT NULL,
EMAIL NVARCHAR(60) NOT NULL,
PRIMARY KEY(STUDENT_ID)
);

CREATE TABLE [TAKE]
(
STUDENT_ID INT NOT NULL,
COURSE_ID INT NOT NULL,
PRIMARY KEY(STUDENT_ID,COURSE_ID)
);

CREATE TABLE GRADE
(
COURSE_ID INT NOT NULL,
[NAME] NVARCHAR(50) NOT NULL,
STUDENT_ID INT NOT NULL,
GRADE INT NOT NULL,
PRIMARY KEY(COURSE_ID,[NAME],STUDENT_ID)
);

CREATE TABLE ACTIVITIES
(
ID INT IDENTITY(1,1),
[DATETIME] DATETIME NOT NULL,
[ACTION] NVARCHAR(50) NOT NULL,
PK NVARCHAR(50) NOT NULL,
PRIMARY KEY (ID)
);


--ACTIVITY TRIGGERS FOR STUDENT TABLE
create trigger [dbo].[OnInsertStudent]
on [dbo].[student]
after insert --or for insert
as
insert into Activities([DateTime],[Action],[PK]) values
(getdate(),'INSERT Student',(select inserted.STUDENT_ID from inserted))

create trigger [dbo].[OnUpdateStudent]
on [dbo].[student]
after update
as
insert into Activities([DateTime],[Action],[PK]) values
(getdate(),'UPDATE Student',(select inserted.STUDENT_ID from inserted))

create trigger [dbo].[OnDeleteStudent]
on [dbo].[student]
after delete
as
insert into Activities([DateTime],[Action],[PK]) values
(getdate(),'DELETE Student',(select deleted.STUDENT_ID from deleted))

--ACTIVITY TRIGGERS FOR COURSE TABLE
create trigger [dbo].[OnInsertCourse]
on [dbo].[course]
after insert --or for insert
as
insert into Activities([DateTime],[Action],[PK]) values
(getdate(),'INSERT Course',(select inserted.COURSE_ID from inserted))

create trigger [dbo].[OnUpdateCourse]
on [dbo].[Course]
after update
as
insert into Activities([DateTime],[Action],[PK]) values
(getdate(),'UPDATE Course',(select inserted.COURSE_ID from inserted))

create trigger [dbo].[OnDeleteCourse]
on [dbo].[Course]
after delete
as
insert into Activities([DateTime],[Action],[PK]) values
(getdate(),'DELETE Course',(select deleted.COURSE_ID from deleted))

--ACTIVITY TRIGGERS FOR INSTRUCTOR TABLE
create trigger [dbo].[OnInsertInstructor]
on [dbo].[Instructor]
after insert --or for insert
as
insert into Activities([DateTime],[Action],[PK]) values
(getdate(),'INSERT Instructor',(select inserted.INSTRUCTOR_ID from inserted))

create trigger [dbo].[OnUpdateInstructor]
on [dbo].[Instructor]
after update
as
insert into Activities([DateTime],[Action],[PK]) values
(getdate(),'UPDATE Instructor',(select inserted.INSTRUCTOR_ID from inserted))

create trigger [dbo].[OnDeleteInstructor]
on [dbo].[Instructor]
after delete
as
insert into Activities([DateTime],[Action],[PK]) values
(getdate(),'DELETE Instructor',(select deleted.INSTRUCTOR_ID from deleted))

--ACTIVITY TRIGGERS FOR GRADING COMPONENT TABLE
create trigger [dbo].[OnInsertGrading]
on [dbo].[grading_component]
after insert
as
insert into activities([datetime],[action],[pk]) values
(getdate(), 'INSERT Grading component', (select concat(inserted.[name], '-',inserted.course_id) from inserted))

create trigger [dbo].[OnUpdateGrading]
on [dbo].[grading_component]
after UPDATE
as
insert into activities([datetime],[action],[pk]) values
(getdate(), 'UPDATE Grading component', (select concat(inserted.[name], '-',inserted.course_id) from inserted))

create trigger [dbo].[OnDeleteGrading]
on [dbo].[grading_component]
after delete
as
insert into activities([datetime],[action],[pk]) values
(getdate(), 'DELETE Grading component', (select concat(deleted.[name], '-',deleted.course_id) from deleted))

--ACTIVITY TRIGGERS FOR TAKE TABLE
create trigger [dbo].[OnInsertTake]
on [dbo].[take]
after insert
as insert into activities([datetime],[action],[pk]) values
(getdate(), 'INSERT Take', (select concat(inserted.student_id, '-',inserted.course_id) from inserted))

create trigger [dbo].[OnUpdateTake]
on [dbo].[take]
after UPDATE
as insert into activities([datetime],[action],[pk]) values
(getdate(), 'UPDATE Take',(select concat(inserted.student_id, '-', inserted.course_id) from inserted))

create trigger [dbo].[OnDeleteTake]
on [dbo].[take]
after delete
as insert into activities([datetime],[action],[pk]) values
(getdate(), 'DELETE Take',(select concat(inserted.student_id, '-', inserted.course_id) from inserted))

--ACTIVITY TRIGGERS FOR GRADE TABLE
create trigger [dbo].[OnInsertGrade]
on [dbo].[Grade]
after insert
as insert into activities([datetime],[action],[pk]) values
(getdate(), 'INSERT Grade',(select concat(inserted.COURSE_ID, '-',inserted.[NAME], '-',inserted.STUDENT_ID) from inserted))

create trigger [dbo].[OnUpdateGrade]
on [dbo].[Grade]
after UPDATE
as insert into activities([datetime],[action],[pk]) values
(getdate(), 'UPDATE Grade', (select concat(inserted.COURSE_ID, '-',inserted.[NAME], '-',inserted.STUDENT_ID) from inserted))

create trigger [dbo].[OnDeleteGrade]
on [dbo].[Grade]
after delete
as insert into activities([datetime],[action],[pk]) values
(getdate(), 'DELETE Grade', (select concat(inserted.COURSE_ID, '-',inserted.[NAME], '-',inserted.STUDENT_ID) from inserted))

ALTER TABLE COURSE ADD CONSTRAINT FK_COURSE_INSTRUCTOR FOREIGN KEY(INSTRUCTOR_ID) REFERENCES INSTRUCTOR(INSTRUCTOR_ID) ON DELETE NO ACTION ON UPDATE CASCADE
ALTER TABLE GRADING_COMPONENT ADD CONSTRAINT FK_GRADINGCOMPONENT_COURSE FOREIGN KEY(COURSE_ID) REFERENCES COURSE(COURSE_ID) ON DELETE NO ACTION ON UPDATE CASCADE
ALTER TABLE [TAKE] ADD CONSTRAINT FK_TAKE_STUDENT FOREIGN KEY(STUDENT_ID) REFERENCES STUDENT(STUDENT_ID) ON DELETE NO ACTION ON UPDATE CASCADE
ALTER TABLE [TAKE] ADD CONSTRAINT FK_TAKE_COURSE FOREIGN KEY(COURSE_ID) REFERENCES COURSE(COURSE_ID) ON DELETE NO ACTION ON UPDATE CASCADE
ALTER TABLE GRADE ADD CONSTRAINT FK_GRADE_GRADINGCOMPONENT FOREIGN KEY([NAME],COURSE_ID) REFERENCES GRADING_COMPONENT([NAME],COURSE_ID) ON DELETE NO ACTION ON UPDATE CASCADE
ALTER TABLE GRADE ADD CONSTRAINT FK_GRADE_STUDENT FOREIGN KEY(STUDENT_ID) REFERENCES STUDENT(STUDENT_ID) ON DELETE NO ACTION ON UPDATE CASCADE
