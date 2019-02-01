/*	
	Trigger - Total Loans
	September 23 2018
	Developed by:	Dongguo Wu	
					Scott Pelletier
					Tianyun Liu
					Sugirtha Nagesu
*/
---------------------------------------------------------------------
				-- QUERY 11.1: 
/*
How many loans did the library do last year?
*/
---------------------------------------------------------------------
use librarydb;
go


if OBJECT_ID('services.TotalLoanTR') is not null
	drop trigger services.TotalLoanTR;
go


create trigger services.TotalLoanTR
on Services.loanhist
after insert, delete
as
	begin
		select sum(t) as 'Total loans made last year'
		from 
		(
			select count(ISBN)	as 't'
			from services.loan
			where year(out_date) = year(GETDATE())-1
	
			UNION ALL
				
			select count(ISBN)	as 't'
			from services.loanhist
			where year(out_date) = year(GETDATE())-1
		) as t
	end;
go




