/*	
	Specific Members
	September 23 2018
	Developed by:	Dongguo Wu	
					Scott Pelletier
					Tianyun Liu
					Sugirtha Nagesu
*/
---------------------------------------------------------------------
				-- QUERY 3: 
/*
Write and execute a query to retrieve the member’s full name and member_no from 
the member table and the isbn and log_date values from the reservation table for 
members 250, 341, 1675. Order the results by member_no. You should show 
information for these members, even if they have no books or reserve.  
*/
---------------------------------------------------------------------
use librarydb;
go

select	M.member_no														as 'Member no.', 
		concat(M.FirstName, ' ', M.MiddleInitial, '. ', M.LastName)		as 'Name',
		R.ISBN															as 'ISBN no.',	
		R.log_date														as 'Reservation Date'

from Members.member as M
	left join services.reservation as R
		on M.member_no = R.member_no

where M.member_no IN(250, 341, 1675);
go






