---------------------------------------------------------------------
 				-- QUERY 11.6: 
/*
What is the average length of a loan? 
*/
---------------------------------------------------------------------
use librarydb;
go

create view services.AverageOfLoanView
as
	select avg(DATEDIFF(day, out_date, in_date)) as 'Average length of a loan'
	from services.loanhist
	where DATEDIFF(day, out_date, in_date) > 0
;
go


											