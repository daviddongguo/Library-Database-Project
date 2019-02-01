/*	
	Copy Wide View
	September 23 2018
	Developed by:	Dongguo Wu	
					Scott Pelletier
					Tianyun Liu
					Sugirtha Nagesu
*/
---------------------------------------------------------------------
				-- QUERY 6: 
/*
Create a view and save it as and CopywideView that queries the copy, title and 
item tables.  Lists complete information about each copy. 
*/
---------------------------------------------------------------------
use librarydb;
go

if OBJECT_ID('books.CopywideView') is not null
	drop view books.CopywideView;
go

create view books.CopywideView (	[No. Copy],
									ISBN,
									[No. Title],
									Title,
									Author,
									Synopsis,
									[On Loan],
									Language,
									Cover,
									Loanable	)
as
		select	bc.copy_no			as 'Copy no.', 
				bi.ISBN				as 'ISBN no.', 
				bt.title_no			as 'Title no.', 
				bt.title			as 'Title', 
				bt.author			as 'Author', 
				bt.synopsis			as 'Synopsis', 
				on_loan				as 'Loan Status',  
				bi.language			as 'Language', 
				bi.cover			as 'Cover Type', 
				bi.loanable			as 'Availibility'
		from  books.copy as bc
			inner join books.item as bi
				on bc.ISBN	= bi.ISBN
			inner join books.title as bt
				on bi.Title_No = bt.Title_No;
go
