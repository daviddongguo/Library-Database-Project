-- ====================================================================
			-- Script 1: Create Databse
-- ====================================================================

use master;
go
ALTER DATABASE librarydb SET SINGLE_USER WITH ROLLBACK IMMEDIATE
;
GO
DROP DATABASE IF EXISTS librarydb
;
GO
create database librarydb;
go

-- ====================================================================
			-- Script 2: Create Database Schema
-- ====================================================================

use librarydb;
go

create schema members authorization dbo;
go

create schema books authorization dbo;
go

create schema services authorization dbo;
go

-- ====================================================================
			-- Script 3: Create Database Tables
-- ====================================================================

use librarydb;
go


create table  Members.Juvenile
(
   Member_no  int  not null,					--PK,FK
   adult_member_no  int  not null,				--FK
   BirthDate date not null,
   constraint pk_Juvenile primary key clustered (member_no asc)
); 
go

create table  Members.Adult
(
   member_no  int  not null,					--PK,FK
   Street varchar(60) not null,
   City varchar(20) not null,
   State varchar(5) not null,
   Zip varchar(15) not null,
   PhoneNo varchar(15) null,
   ExprDate date not null,
   constraint pk_Adult primary key clustered (member_no asc)
);
go

create table  Members.Member
(
   member_no  int identity(1,1) not null,		--PK
   LastName varchar(20) not null,
   MiddleInitial varchar(1) null,
   FirstName varchar(20) not null,
   Photo varbinary(max) null,
   constraint pk_Member primary key clustered (member_no asc)
);
go

create table Books.Title
(
	Title_No bigint identity(1, 1) not null,	-- PK
	Title varchar(100) not null,
	Author varchar(50) not null,
	Synopsis text null
   constraint pk_Title primary key clustered (Title_no asc)
);
go

create table  Books.Item
(
   ISBN  varchar(20) not null,					--PK
   Title_no  bigint  not null,					--FK
   Language  varchar(15) null,
   Cover  varchar(10) null,
   Loanable bit null,
   constraint pk_Item primary key clustered (ISBN asc)
);
go

create table Books.Copy
(
	ISBN  varchar(20) not null,					--PK,FK
    Copy_No smallint not null,					--PK
    On_Loan bit not null,
    constraint pk_Copy primary key clustered (ISBN asc, Copy_No asc)
);
go

create table services.Reservation
(
	ISBN varchar(20) not null,					--PK/FK
	Member_no int not null,						--PK/FK
	Log_date datetime not null,					--PK
	--State char(2) not null,
	Remarks varchar(255) null
	constraint pk_Reservation primary key clustered (ISBN, member_no, log_date)
);
go


if OBJECT_ID ('services.loan', 'U') is not null
	drop table services.loan
;
create table services.loan
(
	ISBN			varchar(20)	not null,		--PK,FK
	copy_no			smallint	not null,		--PK,FK
	member_no		int			not null,		--FK
	out_date		datetime	not null,		--PK
	due_date		datetime	not null,		
	constraint pk_loan primary key clustered (ISBN, copy_no, out_date)
);
go

if OBJECT_ID ('services.loanhist', 'U') is not null
	drop table services.loanhist
;
create table services.loanhist
(
	ISBN			varchar(20)	not null,		--PK/FK
	copy_no			smallint	not null,		--PK,FK
	out_date		datetime	not null,		--PK
	member_no		int			not null,		--FK
	due_date		datetime	not null,
	in_date			datetime	not null,
	fine_assessed	smallmoney	null,
	fine_paid		smallmoney	null,
	fine_waived		smallmoney	null,
	remarks			varchar(255)	null,
	constraint pk_loanhist primary key clustered (ISBN, copy_no, out_date)
);
go

