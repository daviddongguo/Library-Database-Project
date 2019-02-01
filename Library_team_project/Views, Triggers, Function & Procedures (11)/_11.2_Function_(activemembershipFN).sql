/*	
	Function - Active Membership
	September 23 2018
	Developed by:	Dongguo Wu	
					Scott Pelletier
					Tianyun Liu
					Sugirtha Nagesu
*/
---------------------------------------------------------------------
 				-- QUERY 11.2: 
/*
What percentage of the membership borrowed at least one book?
*/
---------------------------------------------------------------------
use librarydb;
go

if OBJECT_ID('members.activemembershipFN') is not null
	drop function members.activemembershipFN;
go


create function members.activemembershipFN ()
returns nvarchar(10)
as
	begin
		
		declare @result as decimal(3, 2)		
		
		select @result =
		(
			select (CONVERT(DECIMAL,(COUNT(DISTINCT LH.member_no))) 
			/ 
			CONVERT(DECIMAL,(COUNT(M.member_no))) * 100)
			FROM services.loanhist as LH
				join members.member as M
					on LH.member_no = M.member_no
		)
	return convert(nvarchar(10),@result) + '%'
	end;
go










