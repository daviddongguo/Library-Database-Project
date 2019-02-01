/* 
	Create LoanInsertDataTr trigger 
*/
use librarydb;
go

if OBJECT_ID('services.LoanInsertDataTr') is not null
	drop trigger services.LoanInsertDataTr
;
go
create trigger services.LoanInsertDataTr
on services.loan
for insert			
as
	begin
		-- Declare variables
		declare @Member_no as int,
				@ISBN as varchar(20),
				@Copy_no as smallint
		select 
				@Member_no = ins.member_no,
				@ISBN = ins.ISBN,
			    @Copy_no = ins.Copy_no
		from inserted as ins

		-- update table books.copy
		update books.copy
		set on_loan = 1
		where isbn = @ISBN and copy_no = @Copy_no
		-- update table books.item
		if ((select Books.IsloanableFn(@ISBN)) = 0)  -- is not availabe to loan
			begin
				update books.Item
				set Loanable = 0
				where isbn = @ISBN 
			end

	end
;


/*
	Testing
	A demo for Borrowing book
*/
-- an right adult
execute Services.LoanByISBNMemberSP @ISBN = 3, @Member_No = 3
go

-- an expired adult
execute Services.LoanByISBNMemberSP @ISBN = 3, @Member_No = 1
;
go

-- an right juvenile that will be still in juvenile table but his partent is expired
execute Services.LoanByISBNMemberSP @ISBN = 3, @Member_No = 2
;
go

-- an right juvenile that will be still in juvenile table and his partent is not expired
execute Services.LoanByISBNMemberSP @ISBN = 4, @Member_No = 4
;
go
--select * from members.Juvenile


-- an 'older' juvenile that will be moven to adult table
execute Services.LoanByISBNMemberSP @ISBN = 3, @Member_No = 6
;
go

--select * from members.juvenile;
--select * from members.Adult