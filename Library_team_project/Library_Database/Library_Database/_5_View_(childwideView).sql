---------------------------------------------------------------------
				-- QUERY 5: 
/*
Create a view and save it as ChildwideView that queries the member, adult, and 
juvenile tables.  Lists the name & address for the juveniles.
*/
---------------------------------------------------------------------
use librarydb;
go

if OBJECT_ID('Members.Childwideview','V') is not null
   drop view Members.Childwideview;
go

create view Members.Childwideview ([Member no.], [Full Name], [Adult's Full Address])
as
	select	J.member_no													as 'Member no.',
			concat(M.FirstName,' ', M.MiddleInitial,'. ', M.LastName)	as 'Full Name',
			concat(A.Street,' ', A.City,' ', A.State,' ', A.zip)		as 'Adult''s Full Address'

	from members.juvenile as J
		join members.member as M
			on J.member_no = M.member_no
		join members.adult as A
			on J.adult_member_no = A.member_no
go
