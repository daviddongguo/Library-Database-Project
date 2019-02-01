use librarydb
;
go

if OBJECT_ID('Books.FindBooksSP', 'P') is not null
	drop procedure Books.FindBooksSP
;
go
create procedure Books.FindBooksSP
(
	@Title as nvarchar(60) = null,
	@ISBN as nvarchar(60) = null,
	@Author as nvarchar(60) = null,
	@Language as nvarchar(60) = null,
	@Cover as nvarchar(60) = null
)
as
	begin
		select distinct Title, ISBN, Author, Language, Cover 
		-- ,IIF((Loanable = 1), 'Available', 'Not Available') as 'Loanable'
		from books.CopywideView
		where Title like { fn CONCAT('%', { fn CONCAT(IIF((@Title is null), '%', @Title), '%') }) }
			and ISBN like { fn CONCAT('%', { fn CONCAT(IIF((@ISBN is null), '%', @ISBN), '%') }) }
			and Author like { fn CONCAT('%', { fn CONCAT(IIF((@Author is null), '%', @Author), '%') }) }
			and Language like { fn CONCAT('%', { fn CONCAT(IIF((@Language is null), '%', @Language), '%') }) }
			and Cover like { fn CONCAT('%', { fn CONCAT(IIF((@Cover is null), '%', @Cover), '%') }) }
	end
;
go

execute Books.FindBooksSP @Title = 'first', @ISBN = '5', @Language='German'
;
go


--  select * from books.CopywideView  
--  select * from books.Item  