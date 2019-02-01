---------------------------------------------------------------------
				-- QUERY 4: 
/*
Create a view and save it as adultwideView that queries the member and adult 
tables.  Lists the name & address for all adults. 
*/
 ---------------------------------------------------------------------
use librarydb;
go

if OBJECT_ID('Members.adultwideview','V') is not null
   drop view Members.adultwideview;
go

create view Members.adultwideview ([Member no.], [Full Name], [Full Address])
as
	select	A.member_no													as 'Member no.',
			concat(M.FirstName,' ', M.MiddleInitial,'. ', M.LastName)	as 'Full Name',
			concat(A.Street,' ', A.City,' ', A.State,' ', A.zip)		as 'Full Address'

	from members.adult as A
		join members.member as M
			on A.member_no = M.member_no;
go