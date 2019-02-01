/*	
	View - Peak Hours
	September 23 2018
	Developed by:	Dongguo Wu	
					Scott Pelletier
					Tianyun Liu
					Sugirtha Nagesu
*/
---------------------------------------------------------------------
				-- QUERY 11.7: 
/*
What are the library peak hours for loans? 
*/
---------------------------------------------------------------------
use librarydb;
go

if OBJECT_ID('services.TotalWorkHourView') is not null
	drop view services.TotalWorkHourView
;
go
create view services.TotalWorkHourView
as
with TotalWorkHour as
(
	select 
		ln.out_date as 'WorkHour',
		ln.member_no	as 'Member_no'
	from services.loan as ln
    UNION all
	select lh1.out_date as 'WorkHour',
		lh1.member_no	as 'Member_no'
	from services.loanhist as lh1
	UNION all
	select lh2.in_date as 'WorkHour',
		lh2.member_no	as 'Member_no'
	from services.loanhist as lh2
)
select  
	WorkHour as 'WorkHour',
	Member_no	as 'Member_no'
 from TotalWorkHour
;
go

select * from services.TotalWorkHourView
order by member_no

-- Time Peak and Records
select DATEPART(HOUR, L.WorkHour) as 'Time', count(*) as 'records'
from services.TotalWorkHourView as L
group by DATEPART(hour, L.WorkHour)
order by records desc
--order by DATEPART(hour, L.WorkHour)
go

