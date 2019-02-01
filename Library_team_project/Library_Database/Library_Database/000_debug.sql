/* Create LoanInsertDataTr trigger */
use librarydb;
go

select * from services.loan;
select * from books.Item;
select * from books.Title;
select * from books.copy;
select * from members.adult;
select * from members.juvenile;
select * from members.Member;

select * from books.TitleDetailedView;

select count(copy_no) from books.copy
group by isbn




