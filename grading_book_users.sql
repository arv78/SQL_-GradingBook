-- creating the first login
use [master]
go
create login [SANS]
with password = N'SANS',
default_database = [GRADE_BOOK]
go
-- creating the second login
use [master]
go
create login [SANS2]
with password = N'SANS2',
default_database = [GRADE_BOOK]
go
-- creating the first role
use [GRADE_BOOK]
go 
create role [OnlySelectOnActivities]
go
use [GRADE_BOOK]
go
grant select on [dbo].[ACTIVITIES]
to [OnlySelectOnActivities]
go
-- creating the second role
use [GRADE_BOOK]
go 
create role [All_TAKE]
go
use [GRADE_BOOK]
go
grant delete, select, insert, references on [dbo].[TAKE]
to [All_TAKE]
go
-- creating the first user 
use [GRADE_BOOK]
go
create user [Unknown_01] for login [SANS]
go
--assign a role to the user
use [GRADE_BOOK]
go
alter role [OnlySelectOnActivities] add member [Unknown_01]
go
-- creating the second user
use [GRADE_BOOK]
go
create user [Unknown_02] for login [SANS2]
go
use [GRADE_BOOK]
go
alter role [All_TAKE] add member [Unknown_02]
go