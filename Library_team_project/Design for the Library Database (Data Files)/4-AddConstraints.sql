/*	
	Creating Constraints: Foreign Key, Defaults, Unique, Check
	September 23 2018
	Developed by:	Dongguo Wu	
					Scott Pelletier
					Tianyun Liu
					Sugirtha Nagesu
*/
-- ====================================================================
			-- Script 4: Define Table Constraints
-- ====================================================================

use librarydb;
go


------------------------------FOREIGN KEYS--------------------------

alter table Members.Juvenile
add constraint fk_Juvenile_Member foreign key (Member_no)
	references Members.Member(Member_no);
go

alter table Members.Juvenile
add constraint fk_Juvenile_adult foreign key (Adult_Member_no)
	references Members.Adult(Member_no);
go

alter table Members.Adult
add constraint fk_Adult_Member foreign key (Member_no)
	references Members.Member(Member_no);
go

alter table Books.Item
add constraint fk_Item_Title foreign key (Title_No)
    references Books.Title(Title_No);
go

alter table Books.Copy
add constraint fk_Copy_Item foreign key (ISBN)
    references Books.Item(ISBN);
go

alter table services.Reservation
	add constraint fk_Reservation_items FOREIGN KEY (ISBN)
		references Books.Item (ISBN);
go

alter table services.Reservation
	add constraint fk_Reservation_Member FOREIGN KEY (Member_no)
		references Members.Member (Member_no);
go

alter table services.loan
	add constraint fk_loan_copy FOREIGN KEY (ISBN, copy_no)
		references books.copy (ISBN, copy_no);
go

alter table services.loan
	add constraint fk_loan_member FOREIGN KEY (member_no)
		references members.member (member_no);
go

alter table services.loanhist
	add constraint fk_loanhist_copy FOREIGN KEY (ISBN, copy_no)
		references books.copy (ISBN, copy_no);
go

alter table services.loanhist
	add constraint fk_loanhist_member FOREIGN KEY (member_no)
		references members.member (member_no);
go

------------------------------DEFAULT--------------------------

alter table members.Adult
	add constraint df_Adult_State default ('WA') for State;
go

alter table services.loan
	add constraint df_loan_due_date DEFAULT (getdate() + 14) for due_date;
go

alter table services.loanhist
	add constraint df_loanhist_due_date DEFAULT (getdate() + 14) for due_date;

alter table services.loanhist
	add constraint df_finehist_assessed DEFAULT (0.00) for fine_assessed;

alter table services.loanhist
	add constraint df_finehist_paid DEFAULT (0.00) for fine_paid;

alter table services.loanhist
	add constraint df_finehist_waived DEFAULT (0.00) for fine_waived;
go

------------------------------CHECK--------------------------

alter table services.loan
	add constraint ck_loan_duedate CHECK (due_date >= out_date);
go

------------------------------UNIQUE--------------------------

CREATE UNIQUE NONCLUSTERED INDEX idx_adult_PhoneNo_notnull
ON Members.adult(PhoneNo)
WHERE PhoneNo IS NOT NULL;


