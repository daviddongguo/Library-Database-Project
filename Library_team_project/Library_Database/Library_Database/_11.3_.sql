---------------------------------------------------------------------
				-- QUERY 11.3: 
/*
What was the greatest number of books borrowed by any one individual?
*/
---------------------------------------------------------------------
use librarydb;
go

if OBJECT_ID('services.numberOfBooksBorrowed','V') is not null
  drop view services.numberOfBooksBorrowed;
go

create view services.numberOfBooksBorrowed
as
	select top 1 * from
	(
		select 
		lh.member_no as 'Member ID', 
		count(lh.ISBN) as 'Total'
		from services.loanhist as lh
		group by lh.member_no
	
		union 

		select 
		l.member_no as 'Member ID', 
		count(l.ISBN) as 'Total'
		from services.loan as l
		group by l.member_no

	) as t
	order by 'Total' desc;
go

















create procedure services.numberOfBooksBorrowedSP
(
	@member_no as int
)
as
	begin
		select M.member_no											as 'Member ID',
		concat(M.FirstName,' ',M.MiddleInitial,'. ', M.LastName)	as 'Full Name',
		COUNT(L.ISBN)												as 'No. Borrowed Books' 
		from members.Member as M
			inner join services.loanhist as L
				on M.member_no = L.member_no
		--where m.member_no = @member_no
		group by M.member_no, M.FirstName, M.MiddleInitial, M.LastName
	end;
go


select TOP 1 LH.member_no, COUNT(LH.member_no)
from services.loanhist as LH
group by LH.member_no
order by COUNT(LH.member_no) desc



















