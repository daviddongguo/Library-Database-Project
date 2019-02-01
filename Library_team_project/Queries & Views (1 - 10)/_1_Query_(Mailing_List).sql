/*	
	Mailing List
	September 23 2018
	Developed by:	Dongguo Wu	
					Scott Pelletier
					Tianyun Liu
					Sugirtha Nagesu
*/
---------------------------------------------------------------------
				-- QUERY 1:  
/*
Create a mailing list of Library members that includes the members’ full 
names and complete address information.  
 */
---------------------------------------------------------------------

use librarydb;
go

select	M.member_no													as 'Member ID',
		concat(M.FirstName,' ',M.MiddleInitial,'. ', M.LastName)	as 'Full Name',	
		concat(A.Street,' ' ,A.City,' ' ,A.State,' ' ,A.zip)		as 'Full Address'			  

from members.member as M 
	inner join members.adult as A 
		on M.member_no = A.member_no

UNION

select	M.member_no													as 'Member ID', 
		concat(M.FirstName,' ',M.MiddleInitial,'. ', M.LastName)	as 'Full Name',	
		concat(A.Street,'... ' ,A.City,' ' ,A.State,' ' ,A.zip)		as 'Full Address'		  

from members.juvenile as J
	join members.member as M on J.member_no = M.member_no
	join members.adult as A on J.adult_member_no = A.member_no

order by M.Member_no;
go


if OBJECT_ID('Members.MailingList','V') is not null
   drop view Members.MailingList
;
go

create view Members.MailingList
	as
SELECT M.member_no AS 'Member ID', 
{ fn CONCAT(M.FirstName, { fn CONCAT(' ', { fn CONCAT(M.MiddleInitial, { fn CONCAT('. ', M.LastName) }) }) }) } AS 'Full Name', 
{ fn CONCAT(A.Street, { fn CONCAT(' ', { fn CONCAT( A.State, { fn CONCAT(' ', A.Zip) }) }) }) } AS 'Full Address'
FROM     members.Member AS M INNER JOIN
                  members.Adult AS A ON M.member_no = A.member_no
UNION
SELECT M.member_no AS 'Member ID', 
{ fn CONCAT(M.FirstName, { fn CONCAT(' ', { fn CONCAT(M.MiddleInitial, { fn CONCAT('. ', M.LastName) }) }) }) } AS 'Full Name', 
{ fn CONCAT(A2.Street, { fn CONCAT(' ', { fn CONCAT( A2.State, { fn CONCAT(' ', A2.Zip) }) }) }) } AS 'Full Address'
FROM     members.Juvenile AS J INNER JOIN
                  members.Member AS M ON J.Member_no = M.member_no INNER JOIN
                  members.Adult AS A2 ON J.adult_member_no = A2.member_no
;
go