/*	
	Loanable View
	September 23 2018
	Developed by:	Dongguo Wu	
					Scott Pelletier
					Tianyun Liu
					Sugirtha Nagesu
*/
---------------------------------------------------------------------
				-- QUERY 7: 
/*
Create a view and save it as LoanableView that queries CopywideView 
(3-table join).  Lists complete information about each copy marked as 
loanable (loanable = 'Y'). 
*/
---------------------------------------------------------------------
use librarydb;
go

if OBJECT_ID('Books.LoanableView','V') is not null
   drop view Books.LoanableView;
go

create view Books.LoanableView
as
		select *
		from books.CopywideView as CWV
		where CWV.Loanable = '1';
go
