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

create view books.CopywideView (	-- [No. Copy],
									ISBN,
									-- [No. Title],
									Title,
									Author,
									-- Synopsis,
									-- [On Loan],
									Language,
									Cover
									-- ,Loanable	
								)
as
		select	-- bc.copy_no, 
				bi.ISBN, 
				-- bt.title_no, 
				bt.title, 
				bt.author, 
				-- bt.synopsis, 
				-- on_loan, 
				bi.language, 
				bi.cover 
				-- ,bi.loanable
		from  books.copy as bc
			inner join books.item as bi
				on bc.ISBN	= bi.ISBN
			inner join books.title as bt
				on bi.Title_No = bt.Title_No;
go

if OBJECT_ID('books.TitleDetailedView') is not null
	drop view books.TitleDetailedView;
go
create view books.TitleDetailedView (	
									ISBN,
									Title,
									Author,
									Language,
									Cover,
									Loanable	
								)
as
		select	
				bi.ISBN, 
				bt.title, 
				bt.author, 
				bi.language, 
				bi.cover, 
				bi.loanable
		from   books.item as bi
			inner join books.title as bt
				on bi.Title_No = bt.Title_No;
go
