---------------------------------------------------------------------
				-- QUERY 11.4: 
/*
What percentage of the books was loaned out at least once last year? 
*/
---------------------------------------------------------------------
use librarydb;
go

if OBJECT_ID('services.TotalLoan') is not null
	drop view services.TotalLoan
;
go
create view services.TotalLoan
as
with TotalLoan as
(
	select distinct CONCAT(ln.isbn,'-', ln.copy_no) as 'loadID'
	from services.loan as ln
    UNION ALL
	select distinct CONCAT(lh.isbn,'-',  lh.copy_no) as 'loadID'
	from services.loanhist as lh
)
select distinct loadID as 'loadID' from TotalLoan
;
go

if OBJECT_ID('books.copydata') is not null
	drop view books.copydata
;
go
create view books.copydata
as
select CONCAT(BC.isbn,'-',  BC.copy_no) as 'loadID'
from books.copy as BC
;
go

select convert(decimal, count(distinct ST.loadID) ) / (convert(decimal, count(distinct ca.loadID))) * 100
from 
	books.copydata as ca
		left join services.TotalLoan as ST
			on ca.loadID = ST.loadID
;
go


