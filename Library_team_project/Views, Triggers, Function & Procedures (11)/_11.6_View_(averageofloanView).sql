/*	
	Procedure - Average Of Loan
	September 23 2018
	Developed by:	Dongguo Wu	
					Scott Pelletier
					Tianyun Liu
					Sugirtha Nagesu
*/
---------------------------------------------------------------------
 				-- QUERY 11.6: 
/*
What is the average length of a loan? 
*/
---------------------------------------------------------------------
use librarydb;
go


if OBJECT_ID('services.AverageOfLoanView') is not null
	drop view services.AverageOfLoanView;
go


create view services.AverageOfLoanView
as
	select avg(DATEDIFF(day, out_date, in_date)) as 'Average length of a loan'
	from services.loanhist
	where DATEDIFF(day, out_date, in_date) > 0;
go

select *
from services.AverageOfLoanView;
go


											