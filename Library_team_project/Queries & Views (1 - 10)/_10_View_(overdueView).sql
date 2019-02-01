/*	
	OverDue View
	September 23 2018
	Developed by:	Dongguo Wu	
					Scott Pelletier
					Tianyun Liu
					Sugirtha Nagesu
*/
---------------------------------------------------------------------
				-- QUERY 10: 
/*
Create a view and save it as OverdueView that queries OnloanView 
(3-table join.) Lists the member, title, and loan information of a copy 
on loan that is overdue (due_date < current date).  
*/
---------------------------------------------------------------------
use librarydb;
go

if OBJECT_ID('Books.OverdueView','V') is not null
   drop view Books.OverdueView;
go

create view Books.OverdueView
as
		select	OLV.[Member ID],
				OLV.Title,
				OLV.[On Loan]
		from books.OnloanView as OLV
		where OLV.[Date Due] < GETDATE()	
go