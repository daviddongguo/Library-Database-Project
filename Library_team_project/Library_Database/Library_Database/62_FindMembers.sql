use librarydb
;
go

if OBJECT_ID('Members.FindMembers', 'P') is not null
	drop procedure Members.FindMembers
;
go
create procedure Members.FindMembers
(
	@Name as nvarchar(60) = null,
	@Address as nvarchar(60) = null,
	@ID as int = null
)
as
	begin
		select *
		from Members.MailingList
		where [Full Name] like { fn CONCAT('%', { fn CONCAT(IIF((@Name is null), '%', @Name), '%') }) }
			and [Full Address] like { fn CONCAT('%', { fn CONCAT(IIF((@Address is null), '%', @Address), '%') }) }
			and ( [Member ID] = @ID or @ID is null)
	end
;
go

-- execute Members.FindMembers @Name = 'L'


