/*	
	View - OverDue View
	September 23 2018
	Developed by:	Dongguo Wu	
					Scott Pelletier
					Tianyun Liu
					Sugirtha Nagesu
*/
---------------------------------------------------------------------
				-- QUERY 11.5: 
/*
What percentage of all loans eventually becomes overdue? 
*/
---------------------------------------------------------------------
use librarydb;
go

if OBJECT_ID('services.OverdueView') is not null
	drop view services.OverdueView;
go

create view services.OverdueView
as
	(
		select 
			lh.member_no as 'member_no', 
			lh.isbn as 'OverdueISBN'	
		from services.loanhist as lh
		where lh.in_date > lh.due_date
union 
		select 
			l.member_no as 'member_no', 
			l.isbn as 'OverdueISBN'
		from services.loan as l
		where l.due_date < '2008-01-05' -- getdate()
	);
go

if OBJECT_ID('services.AllLoanView') is not null
drop view services.AllLoanView;
go

create view services.AllLoanView
as
	(
		select 
			lh.member_no as 'member_no', 
			lh.isbn as 'ISBN'
		from services.loanhist as lh
--where lh.in_date > lh.due_date
union 
		select 
		l.member_no as 'member_no', 
		l.isbn as 'ISBN'
		from services.loan as l
--where l.due_date > '2008-01-05' -- getdate()
);
go


select 
convert(decimal, count(distinct so.OverdueISBN) ) / (convert(decimal, count(distinct sa.ISBN))) * 100
as 'The percentage of Overdue loan'
from 
services.OverdueView as so
right join services.AllLoanView as sa
on so.OverdueISBN = sa.ISBN;
go
 







											