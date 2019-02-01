/*	
	Inserting Data
	September 23 2018
	Developed by:	Dongguo Wu	
					Scott Pelletier
					Tianyun Liu
					Sugirtha Nagesu
*/
-- ====================================================================
			-- Script 5: Define Table Constraints
-- ====================================================================

use librarydb;
go

------------------------------------MEMBER DATA------------------------------------
create table tmptable 
(
	index01 int not null,
	column02 varchar(20) null,
	column03 varchar(20) null,
	column04 varchar(20) null,
	column05 varchar(20) null,
);
go


BULK INSERT tmptable  
from													'C:\Users\Sukee\Desktop\Final Project\Design for the Library Database (Data Files)\Populated Data\member_data.txt'
WITH
(
	FIELDTERMINATOR =	'\t',
    ROWTERMINATOR	=	'\n'
);  
GO 

SET IDENTITY_INSERT  Members.Member ON;
go

INSERT into Members.Member (member_no, lastname, middleinitial, firstname, photo)
	SELECT  
	index01,
	t.column02,	
	t.column04,
	t.column03,	
	IIf( (t.column05 = 'NULL'), null, convert(varbinary, 0) )
	from TmpTable as t;
go

drop TABLE if exists TmpTable;
go

SET IDENTITY_INSERT  Members.Member OFF;
go

select *
from members.Member;
go

------------------------------------TITLE DATA------------------------------------

SET IDENTITY_INSERT books.title ON
INSERT INTO books.title (title_no, title, author, synopsis)
	VALUES
	('1','Last of the Mohicans','James Fenimore Cooper',NULL),
	('2','The Village Watch-Tower','Kate Douglas Wiggin',NULL),
	('3','Self Help; Conduct & Perseverance','Samuel Smiles',NULL),
	('4','Songs of a Savoyard','W. S. Gilbert',NULL),
	('5','Fall of the House of Usher','Edgar Allen Poe',NULL),
	('6','The Cook''s Decameron','Mrs. W. G. Water',NULL),
	('7','Poems','Wilfred Owen',NULL),
	('8','The Cherry Orchard','Anton Checkov',NULL),
	('9','Wayfarers','Knut Hamsun',NULL),
	('10','The Night-Born','Jack London',NULL),
	('11','Lemon','Motojirou',NULL),
	('12','Walking','Henry David Thoreau',NULL),
	('13','The Water-Babies','Charles Kingsley',NULL),
	('14','Improvement of Understanding','Spinoza',NULL),
	('15','The Dictionary of the Khazars','Milorad Pavic',NULL),
	('16','The First Men In The Moon','H.G. Wells',NULL),
	('17','Ballads of a Bohemian','Robert W. Service',NULL),
	('18','War and Peace','Lev Tolstoy',NULL),
	('19','The Phantom of the Opera','Gaston Leroux',NULL),
	('20','The Unbearable Lightness of Being','Milan Kundera',NULL),
	('21','Le Petit Prince','Antoine de Saint-Exupery',NULL),
	('22','The Master and Margarita','Mikhael Bulgakov',NULL),
	('23','De La Terre a La Lune','Jules Verne',NULL),
	('24','Tao Teh King','Lau-Tzu',NULL),
	('25','The Black Tulip','Alexandre Dumas',NULL),
	('26','The Adventures of Robin Hood','Howard Pyle',NULL),
	('27','Lady Susan','Jane Austen',NULL),
	('28','The Voyage of the Beagle','Charles Darwin',NULL),
	('29','Misalliance','George Bernard Shaw',NULL),
	('30','A Tale of Two Cities','Charles Dickens',NULL),
	('31','Oliver Twist','Charles Dickens',NULL),
	('32','The Call of the Wild','Jack London',NULL),
	('33','The First 100,000 Prime Numbers','Unknown',NULL),
	('34','The Legend of Sleepy Hollow','Irving, Washington',NULL),
	('35','The Return of Sherlock Holmes','Sir Arthur Conan Doyle',NULL),
	('36','The Scarlet Letter','Nathaniel Hawthorne',NULL),
	('37','Treasure Island','Robert Louis Stevenson',NULL),
	('38','Les Miserables','Victor Marie Hugo',NULL),
	('39','Moby Dick','Herman Melville',NULL),
	('40','Moll Flanders','Daniel Defoe',NULL),
	('41','Sense and Sensibility','Jane Austen',NULL),
	('42','Vanity Fair','William Makepeace Thackeray',NULL),
	('43','Emma','Jane Austen',NULL),
	('44','Adventures of Huckleberry Finn','Mark Twain',NULL),
	('45','Candide','Voltaire',NULL),
	('46','The Complete Works of William Shakespeare','William Shakespeare',NULL),
	('47','The Crossing','Winston Churchill',NULL),
	('48','History of the Decline and Fall of the Roman Empire','Edward Gibbon',NULL),
	('49','Julius Caesar''s Commentaries on the Gallic War','Julius Caesar',NULL),
	('50','Frankenstein','Mary Wollstonecraft Shelley',NULL);
SET IDENTITY_INSERT books.title OFF
go

select *
from books.Title;
go

------------------------------------ADULT DATA------------------------------------

create table tmptable 
(
	int01 int not null,
	var02 varchar(20) null,
	var03 varchar(20) null,
	var04 varchar(20) null,
	var05 varchar(20) null,
	var06 varchar(20) null,
	var07 varchar(20) null,
	var08 varchar(20) null,
);
go

BULK INSERT tmptable  
from														'C:\Users\Sukee\Desktop\Final Project\Design for the Library Database (Data Files)\Populated Data\adult_data.txt'
with
(
	FIELDTERMINATOR =	'\t',
    ROWTERMINATOR	=	'\n'
);  

INSERT into Members.adult 
	SELECT  
	t.int01,
	t.var02,
	t.var03,
	t.var04,
	t.var05,
	IIf( (t.var06 = 'NULL'), null, t.var06 ),
	convert(date, t.var07)
	from TmpTable as t;
go


drop TABLE if exists TmpTable;
go

select *
from members.Adult;
go

------------------------------------JUVENILE DATA------------------------------------

create table tmptable 
(
	int01 int not null,
	int02 int null,
	var03 varchar(20) null,
	var04 varchar(20) null
);
go


BULK INSERT tmptable  
from														'C:\Users\Sukee\Desktop\Final Project\Design for the Library Database (Data Files)\Populated Data\juvenile_data.txt'

WITH
(
	FIELDTERMINATOR =	'\t',
    ROWTERMINATOR	=	'\n'
);  
GO 

INSERT into Members.juvenile 
	SELECT  
	t.int01,
	t.int02,
	convert(date, t.var03)
	from TmpTable as t;
go


drop TABLE if exists TmpTable;
go

select *
from members.Juvenile;
go

------------------------------------ITEM DATA------------------------------------

create table tbl_temp_item 
(
				c1 varchar(20) not null,
				c2 bigint  not null,
                c3 varchar(15) null,
                c4 varchar(10) null,
                c5 varchar(2) null
);
BULK INSERT tbl_temp_item
from														'C:\Users\Sukee\Desktop\Final Project\Design for the Library Database (Data Files)\Populated Data\item_data.txt'
WITH 
   (
	 FIELDTERMINATOR =	'\t',
     ROWTERMINATOR	=	'\n'
    );
go


INSERT INTO Books.Item (ISBN,Title_no, Language, Cover,  Loanable)
SELECT	c1, c2, c3, c4, IIF((c5 = 'Y'),'1','0' )	
FROM tbl_temp_item;

drop table tbl_temp_item;
go

select *
from books.Item;
go

------------------------------------COPY DATA------------------------------------

create table tbl_temp_copy
(
				c1 varchar(20) not null,
				c2 smallint  not null,
                c3 bigint null,
                c4 varchar(2) not null             
);
go

BULK INSERT tbl_temp_copy
from														'C:\Users\Sukee\Desktop\Final Project\Design for the Library Database (Data Files)\Populated Data\copy_data.txt'
WITH 
   (
	 FIELDTERMINATOR =	'\t',
     ROWTERMINATOR	=	'\n'
    );
go

INSERT INTO Books.Copy 
SELECT	c1, c2,
		IIF((c4 = 'Y'),'1','0' )	
FROM tbl_temp_copy;

drop table tbl_temp_copy;
go

select *
from books.Copy;
go

------------------------------------RESERVATION DATA------------------------------------


Create table tbl_temp_reservation 
(              
                C1 varchar(20) not null,
                C2 int not null,
                C3 date not null,
                C4 time not null,
                C5 varchar(255)  null
);
go
 
BULK INSERT tbl_temp_reservation
from														'C:\Users\Sukee\Desktop\Final Project\Design for the Library Database (Data Files)\Populated Data\reservation_data.txt'
WITH
(
       FIELDTERMINATOR =    '\t',
       ROWTERMINATOR =      '\n'
);
go

INSERT INTO services.reservation (ISBN, member_no, log_date, remarks)
SELECT	C1, C2, 
		DATETIME2FROMPARTS(	
								year(c3), 
								month(c3), 
								day(c3), 
								datepart(hour, c4), 
								datepart(minute, c4), 
								datepart(second, c4), 
								0,
								2
							),
		iif(c5 = 'NULL', null, c5)

FROM tbl_temp_reservation;
drop table tbl_temp_reservation;
go

select *
from services.Reservation;
go

------------------------------------LOAN DATA------------------------------------

create table tbl_temp --loan
(
				c1 varchar(10)	not null,
				c2 varchar(10)	not null,
				c3 varchar(10)	not null,
				c4 varchar(10)	not null,
				c5 date			not null,
				c6 time			not null,
				c7 date			not null,
				c8 time			not null
);
go

BULK INSERT tbl_temp
from														'C:\Users\Sukee\Desktop\Final Project\Design for the Library Database (Data Files)\Populated Data\loan_data_new.txt'
WITH
(
	FIELDTERMINATOR =	'\t',
    ROWTERMINATOR	=	'\n'
);
go


INSERT INTO services.loan (ISBN, copy_no, member_no, out_date, due_date)
SELECT	c1, c2, c4,
		DATETIME2FROMPARTS	(	
								year(c5), 
								month(c5), 
								day(c5), 
								datepart(hour, c6), 
								datepart(minute, c6), 
								datepart(second, c6), 
								0,
								2
							),
		DATETIME2FROMPARTS	(	
								year(c7), 
								month(c7), 
								day(c7), 
								datepart(hour, c8), 
								datepart(minute, c8), 
								datepart(second, c8), 
								0,
								2
							)

FROM tbl_temp;
drop table tbl_temp;
go

select *
from services.loan;
go

------------------------------------LOANHIST DATA------------------------------------

create table tbl_temp --loanhist
(
				c1 varchar(10)		not null,
				c2 varchar(10)		not null,
				c3 date				not null,
				c4 time				not null,
				c5 varchar(10)		not null,
				c6 varchar(10)		not null,
				c7 date				not null,
				c8 time				not null,
				c9 date				not null,
				c10 time			not null,
				c11 nvarchar(5)			null,
				c12 nvarchar(5)			null,
				c13 nvarchar(5)			null,
				c14 nvarchar(5)		null				
);
go


BULK INSERT tbl_temp
FROM													'C:\Users\Sukee\Desktop\Final Project\Design for the Library Database (Data Files)\Populated Data\loanhist_data_new.txt'
WITH
(
	FIELDTERMINATOR =	'\t',
    ROWTERMINATOR	=	'\n'
);
go



INSERT INTO services.loanhist (ISBN, copy_no, out_date, member_no, due_date, in_date)
SELECT	c1, c2, 
		DATETIME2FROMPARTS(	
								year(c3), 
								month(c3), 
								day(c3), 
								datepart(hour, c4), 
								datepart(minute, c4), 
								datepart(second, c4), 
								0,
								2
							),
		c6,
		DATETIME2FROMPARTS(	
								year(c7), 
								month(c7), 
								day(c7), 
								datepart(hour, c8), 
								datepart(minute, c8), 
								datepart(second, c8), 
								0,
								2
							),
		DATETIME2FROMPARTS(	
								year(c9), 
								month(c9), 
								day(c9), 
								datepart(hour, c10), 
								datepart(minute, c10), 
								datepart(second, c10), 
								0,
								2
							)
FROM tbl_temp;
drop table tbl_temp;
go

select *
from services.loanhist;
go