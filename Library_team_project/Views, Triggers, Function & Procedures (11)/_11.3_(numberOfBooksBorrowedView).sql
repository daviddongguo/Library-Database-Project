/*	
	Procedure - Books borrowed
	September 23 2018
	Developed by:	Dongguo Wu	
					Scott Pelletier
					Tianyun Liu
					Sugirtha Nagesu
*/
---------------------------------------------------------------------
				-- QUERY 11.3: 
/*
What was the greatest number of books borrowed by any one individual?
*/
---------------------------------------------------------------------
use librarydb;
go

if OBJECT_ID('services.BooksBorrowedTotalView', 'V') is not null
	drop view services.BooksBorrowedTotalView;
go

create view services.BooksBorrowedTotalView
as (
select 
	lh.member_no as 'member_no', 
	count(lh.ISBN) as 'Total'
from services.loanhist as lh
group by lh.member_no
union 
select 
	l.member_no as 'member_no', 
	count(l.ISBN) as 'Total'
from services.loan as l
group by l.member_no
);
go

-- Find the greatest total books by a individual
select 
	max(total) as 'The greatest number of book borrowed'
from services.BooksBorrowedTotalView;
go

-- Greatest books borrowed by each members
select *
from services.BooksBorrowedTotalView;
go


---------------------------------------------------------------------
				-- Procedure: 
/*
	Additionally you can also create a procedure to call out any 
	members to find out the total number of books they borrowed
*/
---------------------------------------------------------------------
if OBJECT_ID('services.numberOfBooksBorrowed','P') is not null
  drop procedure services.numberOfBooksBorrowed;
go


create procedure services.numberOfBooksBorrowed
( 
@member_no as int
)
as


select 
LH.member_no as 'member_no', 
concat(M.FirstName,' ',M.MiddleInitial,'. ', M.LastName) as 'Full Name',
count(lh.ISBN) as 'Total'
from services.loanhist as LH
inner join members.Member as M
on LH.Member_no = M.member_no
where lh.member_no = @member_no
group by LH.member_no, M.FirstName, M.MiddleInitial, M.LastName

union 
select 


l.member_no as 'member_no', 
concat(M.FirstName,' ',M.MiddleInitial,'. ', M.LastName) as 'Full Name',
count(l.ISBN) as 'Total'
from services.loan as l
inner join members.Member as M
on L.Member_no = M.member_no
where l.member_no = @member_no
group by l.member_no, M.FirstName, M.MiddleInitial, M.LastName


-- ) as t
order by 'Total' desc;
go


execute services.numberOfBooksBorrowed @member_no = '201';
go











