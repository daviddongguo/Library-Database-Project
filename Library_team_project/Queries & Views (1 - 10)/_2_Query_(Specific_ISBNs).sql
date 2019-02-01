/*	
	Specific ISBN
	September 23 2018
	Developed by:	Dongguo Wu	
					Scott Pelletier
					Tianyun Liu
					Sugirtha Nagesu
*/
---------------------------------------------------------------------
				-- QUERY 2: 
/*
Write and execute a query on the title, item, and copy tables that returns the 
isbn, copy_no, on_loan, title, translation, and cover, and values for rows in 
the copy table with an ISBN of 1 (one), 500 (five hundred), or 1000 (thousand). 
Order the result by isbn column. 
*/
 ---------------------------------------------------------------------
use librarydb;
go

select	C.ISBN				as 'ISBN no.',
		C.copy_no			as 'Copy no.',
		C.on_loan			as 'Loan Status',
		T.title				as 'Title',
		I.language			as 'Language',
		I.cover				as 'Cover Type'	

from Books.copy as C
	join Books.Item as I
		on C.ISBN = I.ISBN
	join Books.Title as T
		on I.Title_no = T.Title_no

where C.ISBN IN(1, 500, 1000)

order by C.ISBN;
go
