/*	
	OnShelf View
	September 23 2018
	Developed by:	Dongguo Wu	
					Scott Pelletier
					Tianyun Liu
					Sugirtha Nagesu
*/
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