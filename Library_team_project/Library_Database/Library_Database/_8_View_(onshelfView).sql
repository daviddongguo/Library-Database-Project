---------------------------------------------------------------------
				-- QUERY 8: 
/*
Create a view and save it as OnshelfView that queries CopywideView 
(3-table join). Lists complete information about each copy that is 
not currently on loan (on_loan ='N'). 
*/
---------------------------------------------------------------------
use librarydb;
go

if OBJECT_ID('Books.OnshelfView','V') is not null
   drop view Books.OnshelfView;
go

create view Books.OnshelfView
as
		select *
		from books.CopywideView as CWV
		where CWV.[On Loan]='0';
go

select count(On_Loan) from books.Copy
where isbn = 10 and On_Loan = 0;
select top 1 Copy_No from books.Copy
where isbn = 10 and On_Loan = 0
order by copy_no;

select count(Copy_No) from services.loan
where isbn = 10
select Copy_No from services.loan
where isbn = 10

select count(Copy_No) from services.loanhist
where isbn = 10
select * from services.loanhist
where isbn = 10
order by due_date desc

select * from services.loanhist
order by in_date desc


