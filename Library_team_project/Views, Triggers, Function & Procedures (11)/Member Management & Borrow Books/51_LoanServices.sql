/*
	Validate the membership
	by the age of a juvenile
	and the expr_date of an adult
*/

/*
	Members.IsExpiredFn
	Return 0 when the ExprDate is larger than today
	otherwise return 1, means Yes, expired
*/
use librarydb
;
go
if OBJECT_ID('Members.IsExpiredFn', 'Fn') is not null
	drop function Members.IsExpiredFn
;
go
create function Members.IsExpiredFn
(
	-- delcare parameter
	@Member_no as int
)
returns int 
as
	begin
		-- declare the variable
		declare @ValidatedResult as int = 1
		declare @ExprDate as date

		select @ExprDate = a.ExprDate
		from members.Adult as a
		where a.member_no = @Member_no

		-- return the result to the function caller
		if ((@ExprDate) > GETDATE())  -- Not expired
			begin
				set @ValidatedResult = 0
			end
		return @ValidatedResult
	end
;
go


-- testing
update members.Adult
set ExprDate ='2018-12-10'
where member_no = 3
;
select Members.IsExpiredFn(3), 'Expected Value is 0'
;
select Members.IsExpiredFn(1), 'Expected Value is 1'
;
go


/*
	Members.IsInJuvenileTableFn
	Return 1 when the the member is an Juvenile
	otherwise return 0 when the member is in the juvenile table
*/
use librarydb
;
go
if OBJECT_ID('Members.IsInJuvenileTableFn', 'Fn') is not null
	drop function Members.IsInJuvenileTableFn
;
go
create function Members.IsInJuvenileTableFn
(
	-- delcare parameter
	@Member_no as int
)
returns int 
as
	begin
		-- declare the variable
		declare @ValidatedResult as int = 0
		declare @BirthDate as date

		select @BirthDate = j.BirthDate
		from members.juvenile as j
		where j.member_no = @Member_no

		-- return the result to the function caller
		if  @BirthDate is not null
			begin
				set @ValidatedResult = 1
			end
		return @ValidatedResult
	end
;
go


-- testing
select Members.IsInJuvenileTableFn(2), 'Expected Value is 1'
;
select Members.IsInJuvenileTableFn(1), 'Expected Value is 0'
;
go


/*
	Members.IsActualJuvenileFn
	Return 1 when the the member is an actual Juvenile
	otherwise return 0 when the member is in the juvenile table
*/
use librarydb
;
go
if OBJECT_ID('Members.IsActualJuvenileFn', 'Fn') is not null
	drop function Members.IsActualJuvenileFn
;
go
create function Members.IsActualJuvenileFn
(
	-- delcare parameter
	@Member_no as int
)
returns int 
as
	begin
		-- declare the variable
		declare @ValidatedResult as int = 0
		declare @BirthDate as date

		select @BirthDate = j.BirthDate
		from members.juvenile as j
		where j.member_no = @Member_no

		-- return the result to the function caller
		if  @BirthDate > DATEADD(year, -18, getdate() )
			begin
				set @ValidatedResult = 1
			end
		return @ValidatedResult
	end
;
go

-- testing
update members.Juvenile
set BirthDate ='2000-10-10'
where member_no = 4
;
update members.Juvenile
set BirthDate ='2000-10-10'
where member_no = 2
;
select Members.IsActualJuvenileFn(2), 'Expected Value is 1'
select Members.IsActualJuvenileFn(4), 'Expected Value is 1'
select Members.IsActualJuvenileFn(6), 'Expected Value is 0'
;
go


/*
	Books.Isloanable
	Return 1 when the the ISBN is available to loan
	otherwise return 0 when no copy of this ISBN in the library
*/

if OBJECT_ID('Books.IsloanableFn', 'Fn') is not null
	drop function Books.IsloanableFn
;
go
create function Books.IsloanableFn
(
	-- delcare parameter
	@ISBN as nvarchar(20)
)
returns int 
as
	begin
		-- declare the variable
		declare @isloanable as int = 0 -- default value means not availbe
		declare @numOfCopyInlibrary as int = 0

		select @numOfCopyInlibrary = count(Copy_No) 
			from books.Copy
			where isbn = @ISBN and On_Loan = 0 -- books is not ont loan

		-- return the result to the function caller
		if  @numOfCopyInlibrary >= 1
			begin
				set @isloanable = 1
			end
		return @isloanable
	end
;
go


-- testing
select Books.IsloanableFn(100), 'Expected Value is 1'
select * from Books.item where isbn	=100;
go


/*
	Books.getNextCopyAvailabeFn
	Return Copy_no when the the ISBN is available to loan
	otherwise return null when no copy of this ISBN in the library
*/

if OBJECT_ID('Books.getNextCopyAvailabeFn', 'Fn') is not null
	drop function Books.getNextCopyAvailabeFn
;
go
create function Books.getNextCopyAvailabeFn
(
	-- delcare parameter
	@ISBN as nvarchar(20)
)
returns nvarchar(20)
as
	begin
		-- declare the variable
		declare @firstCopyAvailabe as nvarchar(20)

		select @firstCopyAvailabe = Copy_No
			from books.Copy
			where isbn = @ISBN and On_Loan = 0 -- books is not ont loan
			order by copy_no desc

		-- return the result to the function caller
		return @firstCopyAvailabe
	end
;
go

-- testing
select Books.getNextCopyAvailabeFn(100), 'Expected Value is 2'
--select * from Books.copy where isbn	=100
--select * from Books.item where isbn	=100
select Books.getNextCopyAvailabeFn(1), 'Expected Value is null'




/*
	Members.MoveJuvenileToAdult
*/
use librarydb
;
go
if OBJECT_ID('Members.MoveJuvenileToAdult', 'P') is not null
	drop procedure Members.MoveJuvenileToAdult
;
go
create procedure Members.MoveJuvenileToAdult
(
	-- delcare parameter
	@Member_no as int
)
as
	begin
		
		BEGIN TRANSACTION;  
		-- insert one record in adult table		
		insert into members.Adult
			execute Members.GetJuvenileInfoSP @Juvenile_Member_no = @Member_no -- Get the information about this juvenile

		-- delete one record in juvenile table
		delete from members.Juvenile where Member_no = @Member_no
		COMMIT TRANSACTION;
	end
;
go

--execute Members.MoveJuvenileToAdult 18


/*
	Members.GetJuvenileInfoSP
	Return the Member_NO of this juvenile
		and the Street, City, Zip, State, Zip, PhoneNo from this parent
		and the ExprDate creeated as a expired date
*/
if OBJECT_ID('Members.GetJuvenileInfoSP', 'P') is not null
	drop procedure Members.GetJuvenileInfoSP
;
go
create procedure Members.GetJuvenileInfoSP
(
	-- delcare parameter
	@Juvenile_Member_no as int
)
as
	begin
		select 
			j.Member_no as 'Member_no',
			CONCAT('ex-', a.Street) as 'Street',
			CONCAT('ex-', a.City) as 'City',
			CONCAT('ex-', a.State) as 'State',
			CONCAT('ex-', a.Zip) as 'Zip',
			IIF((a.PhoneNo is null), null, CONCAT('ex-', a.PhoneNo)) as 'PhoneNo ',
			DATEADD(year, -1, getdate()) as 'ExprDate' --For a new membership set exprdate is expired
		from Members.Juvenile as j
			inner join members.Adult as a
				on a.member_no = j.adult_member_no
		where j.member_no = @Juvenile_Member_no
	end
;
go

execute Members.GetJuvenileInfoSP @Juvenile_Member_no = 2


/*
	Services.LoanByISBNMemberSP
	Insert one record into the loan table when the isbn and membership are all availble.
*/
if OBJECT_ID('Services.LoanByISBNMemberSP', 'P') is not null
	drop procedure Services.LoanByISBNMemberSP
;
go
create procedure Services.LoanByISBNMemberSP
(
	-- delcare parameter
	@ISBN as nvarchar(20), 
	@Member_No as nvarchar(20)	
)
as
	begin
		-- Making decision on membership first,  then on book
		declare @expiredDate as date
		declare @canLoan as int = 0
		if ( (select Members.IsInJuvenileTableFn(@Member_no)) = 1) -- in Juvenile table
			begin
				if ( (select Members.IsActualJuvenileFn(@Member_no)) = 0) -- Not a real juvenile
					begin
						execute Members.MoveJuvenileToAdult @Member_no  -- Move from Juvenile to Adult
						print concat ('***debugging info***  Moved one juvenile to adult  Member_NO:' ,  @Member_no)  -- debuging
					end
				if ( (select Members.IsActualJuvenileFn(@Member_no)) = 1)		-- A real juvenile
					begin
						select @expiredDate = a.ExprDate            -- Get the adult's exprDate 
							from Members.Juvenile as j
								inner join Members.Adult as a
									on j.adult_member_no = a.member_no
							where j.Member_no = @Member_no
						if (@expiredDate > getdate())
							begin
								set @canLoan = 1 -- can loan
							end
						if (@expiredDate <= getdate())
							begin
								set @canLoan = 0 -- can loan
							end
					end
			end
		if ( (select Members.IsInJuvenileTableFn(@Member_no)) = 0) -- Not in Juvenile table = in Adult table
			begin
				if ( (select Members.IsExpiredFn(@Member_no)) = 1) -- can not loan because the membership is not effective
					begin
						set @canLoan = 0 -- can not loan
						print 'Sorry, The membership is expired.'
					end
				if((select members.IsExpiredFn(@Member_No)) = 0)   -- can loan
					begin
						set @canLoan = 1 -- can loan
					end
			end	-- end of if	
		-- Begin to loan book
		if (@canLoan = 1)
			begin
				declare @Copy_No as nvarchar(20) 
						select @Copy_No= Books.getNextCopyAvailabeFn(@ISBN)  -- Find the availabe copy of this isbn
						if (@Copy_No is null)	-- can not loan
							begin
								print 'Sorray, this book is not availabe to loan'
							end
						if (@Copy_No is not null) -- can loan
							begin
								insert into services.loan(ISBN, copy_no, member_no, out_date, due_date)
								values
								(
									@ISBN     
									, @Copy_No
									, @Member_No
									, getdate()
									, DATEADD(day, 14, getdate())
								)
								print 'Loaned success.'
							end
			end	
	end -- end of as
;
go
-- testing
execute Services.LoanByISBNMemberSP @ISBN = 1, @Member_No = 1;
print 'expected message: Sorry, The membership is expired.'
execute Services.LoanByISBNMemberSP @ISBN = 1, @Member_No = 3
print 'expected message: Sorray, this book is not availabe to loan'
go