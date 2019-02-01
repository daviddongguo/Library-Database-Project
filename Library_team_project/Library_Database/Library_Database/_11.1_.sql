---------------------------------------------------------------------
				-- QUERY 11.1: 
/*
How many loans did the library do last year?
*/
---------------------------------------------------------------------
use librarydb;
go


if OBJECT_ID('services.TotalLoanView') is not null
	drop trigger services.TotalLoanView;
go


create trigger services.TotalLoanView
on Services.loan
for insert
as
	begin
				select count(ISBN)	as 't'
		from services.loan
		where year(out_date) = 2007--year(GETDATE())-1
	
		UNION ALL
	
		select count(ISBN)	as 't'
		from services.loanhist
		where year(out_date) = 2007--year(GETDATE())-1
)
	select sum(t) as 'Number of Total Loan'
	from total



	end;













if OBJECT_ID('services.TotalLoanView') is not null
	drop view services.TotalLoanView;
go

create view services.TotalLoanView
as
with total as
(
		select count(ISBN)	as 't'
		from services.loan
		where year(out_date) = 2007--year(GETDATE())-1
	
		UNION ALL
	
		select count(ISBN)	as 't'
		from services.loanhist
		where year(out_date) = 2007--year(GETDATE())-1
)
	select sum(t) as 'Number of Total Loan'
	from total
;
go


-- testing
--select *
--from services.TotalLoanView;
--go


-- the second way to count the number of loan
/*
select count(n.ISBN) as 'Total Number of Loan in second ways'
from books.copy as c
	left join services.loan as n
		on c.isbn = n.isbn and c.Copy_No = n.copy_no
	left join services.loanhist as t
		on c.isbn = t.isbn and c.Copy_No = t.copy_no	
	where year(n.out_date) = 2007 or year(t.out_date) = 2007
*/







