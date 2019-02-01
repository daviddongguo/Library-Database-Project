---------------------------------------------------------------------
				-- QUERY 9: 
/*
Create a view and save it as OnloanView that queries the loan, title, 
and member tables. Lists the member, title, and loan information of a 
copy that is currently on loan. 
*/
---------------------------------------------------------------------
use librarydb;
go

if OBJECT_ID('Books.OnloanView','V') is not null
   drop view Books.OnloanView;
go

create view Books.OnloanView (	[Member ID],
								[Full Name],
								Photograph,
								ISBN,
								[No. Copy],
								[Date Out],
								[Date Due],
								[No. Title],
								Title,
								Author,
								Synopsis,
								[On Loan]	)
as
		select	M.Member_no													as 'Member no.',
				concat(M.FirstName,' ',M.MiddleInitial,'. ', M.LastName)	as 'Full Name',
				M.Photo														as 'Member Photo',
				C.ISBN														as 'ISBN no.',
				C.Copy_No													as 'Copy no.',
				L.Out_Date													as 'Date Loaned',
				L.Due_Date													as 'Due Date',
				T.Title_no													as 'Title no.',
				T.Title														as 'Title',
				T.Author													as 'Author',
				T.Synopsis													as 'Synopsis',
				C.On_Loan													as 'Loan Status'
	from members.member as M 
		inner join Services.Loan as L
			on M.Member_No = L.Member_No
		inner join Books.Copy as C
			on L.ISBN= C.ISBN 
		inner join Books.Item as I
			on I.ISBN= L.ISBN
		inner join Books.Title as T
			on T.Title_No=I.Title_no
	where 
		L.out_date is not null 
		and 
		C.on_loan='1';
go

