											 ---------------------------------------------------------------------
 															-- QUERY 11.2: 
											/*
											What percentage of the membership borrowed at least one book?
											*/
											---------------------------------------------------------------------
use librarydb;
go

--if OBJECT_ID('services.TotalLoanView') is not null
--	drop view services.TotalLoanView;
--go

select	CONVERT(DECIMAL,(COUNT(DISTINCT LH.member_no))) 
		/ 
		CONVERT(DECIMAL,(COUNT(M.member_no))) * 100			as 'Active Membership (%)'
FROM services.loanhist as LH
	join members.member as M
		on LH.member_no = M.member_no;
go














