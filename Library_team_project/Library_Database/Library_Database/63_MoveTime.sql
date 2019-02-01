use librarydb
;
go

-- Find and check the current day and the lastest record
select top(1) out_date from services.loan
order by out_date desc
select top(1) in_date from services.loanhist
order by in_date desc
select DATEDIFF(day, '2008-01-05', getdate())
select DATEADD(day, 3914, '2008-01-05')
;
go

/*
	Move all the date at table loan and loanhist to current
*/

if OBJECT_ID('services.MoveTimeSP', 'P') is not null
	drop procedure services.MoveTimeSP
;
go
create procedure services.MoveTimeSP
as
	begin
		update services.loan
		set out_date = DATEADD(day, 3914, out_date),
			due_date = DATEADD(day, 3914, due_date)
		update services.loanhist
		set out_date = DATEADD(day, 3914, out_date),
			due_date = DATEADD(day, 3914, due_date),
			in_date = DATEADD(day, 3914, in_date)
	end
;
go

execute services.MoveTimeSP