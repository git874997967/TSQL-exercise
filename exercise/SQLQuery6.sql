use b88  
go
--indexes
--cluster 
--non cluster index
--nci- h
--nci-ci 
--covering index
--filter index 
--full text index 
SELECT name AS FileName, 
   size*1.0/128 AS FileSizeinMB,
   CASE max_size 
       WHEN 0 THEN 'Autogrowth is off.'
       WHEN -1 THEN 'Autogrowth is on.'
       ELSE 'Log file grows to a maximum size of 2 TB.'
   END,
   growth AS 'GrowthValue',
   'GrowthIncrement' = 
       CASE
           WHEN growth = 0 THEN 'Size is fixed.'
           WHEN growth > 0 AND is_percent_growth = 0 
               THEN 'Growth value is in 8-KB pages.'
           ELSE 'Growth value is a percentage.'
       END
FROM tempdb.sys.database_files;
GO

SELECT SUM(unallocated_extent_page_count) AS [free pages], 
 (SUM(unallocated_extent_page_count)*1.0/128) AS [free space in MB]
FROM sys.dm_db_file_space_usage;

-- index views

select * from he
select * from pp
drop table pp


select P.ModifiedDate,P.BusinessEntityID,P.FirstName,P.LastName,P.rowguid into pp from AdventureWorks2012.Person.Person  P

create table t99
(id int,name varchar(20),addr varchar(20),ssn varchar(50))

insert into t99 values(
12,'john','poway','123gfvc'
),
(
7,'peter','san diego','123cesgfvc'
),
(
4,'kimberley','new york','123gxvfvc'
),
(
8,'Denise','Mira mesa','cv123gfvc'
),
(
15,'george','los angeles','xvxxc'
),
(
10,'Adutya','carmel mountain','1xvsw23gfvc'
),
(
45,'Song','Harbor city','123gfvc'
),
(
3,'Bina','Kery mesa','vbcxcv'
),
(
6,'Nancy','San francisco','xxcvz'
)
select * from t99
where id=10


select BusinessEntityID  from AdventureWorks2012.Person.Person where BusinessEntityID=2
select  BusinessEntityID from pp  where BusinessEntityID=2
--unique follow the unique constraint 
create unique clustered index idx1 
on pp (BusinessEntityID)

--inner  join 
select pp.BusinessEntityID from AdventureWorks2012.Person.Person pp inner join AdventureWorks2012.HumanResources.Employee he
on pp.BusinessEntityID=he.BusinessEntityID
--where 
select pp.BusinessEntityID from AdventureWorks2012.Person.Person pp 
where pp.BusinessEntityID in(select he.BusinessEntityID from AdventureWorks2012.HumanResources.Employee he)
--
select pp.BusinessEntityID from pp inner join he 
on pp.BusinessEntityID=he.BusinessEntityID
--where
select pp.BusinessEntityID from   pp 
where pp.BusinessEntityID in(select he.BusinessEntityID from  he)


create unique clustered index idx1 
on pp (BusinessEntityID)

--
create unique clustered index idx1 
on pp (BusinessEntityID)
drop index idx1 on pp
--
alter table pp
add  constraint pk_pp_bi  primary key nonclustered(businessentityid) 

alter table pp
drop constraint pk_pp_bi 

select * from pp where BusinessEntityID=20 or Title='boss'

drop index idx1 on he	

create  clustered index id2
on pp (BusinessEntityID,title)

--non cluster index
--nci -h
create unique nonclustered index uhenc1 on he (BusinessEntityID)

create   nonclustered index uhenc2 on he (BusinessEntityID,Loginid)

drop index uhenc2 on he
select * from he where Gender='M'
select * from  he where BusinessEntityID=20
select he.LoginID,he.jobtitle
 from AdventureWorks2012.HumanResources.Employee he 
 where he.LoginID='adventure-works\ken1'
 select he.LoginID,he.JobTitle 
 from he
 where he.LoginID='adventure-works\ken1'
 --
 SELECT SalesOrderDetailID, OrderQty
FROM AdventureWorks2012.sales.SalesOrderDetail
WHERE ProductID = 870
 SELECT SalesOrderDetailID, OrderQty
FROM AdventureWorks2012.sales.SalesOrderDetail
WHERE ProductID = 895




--OPTION (OPTIMIZE FOR (ProductID=945)
go
  @pid smallint
 


alter PROCEDURE Get_OrderID_OrderQty1 @ProductID INT
AS
SELECT  SalesOrderDetailID, OrderQty
FROM AdventureWorks2012.Sales.SalesOrderDetail
WHERE ProductID = @ProductID
OPTION (OPTIMIZE FOR (@ProductID=945))

 exec Get_OrderID_OrderQty1 911 
 go 3	
 exec Get_OrderID_OrderQty1 870
 go 5
 --1 intelligent analysis predicateive search 
--2 recompile
--3  

DBCC SHOW_STATISTICS ("adventureworks2012.Person.Address", AK_Address_rowguid)  WITH HISTOGRAM  
 DBCC CHECKTABLE ('pp')

 dbcc  checktable(emp2)
 dbcc checktable(he)
 dbcc checktable(pp)


 select FirstName from pp

create   nonclustered index uhenc2 on he (BusinessEntityID,Loginid)

 create nonclustered index idx3  
 on pp(firstname)
 
 create nonclustered index idx2
 on pp(lastname)

 select  modifiedDate from pp where FirstName='Rob' or rowguid='D8763459-8AA8-47CC-AFF7-C9079AF79033'
  select  * from pp where FirstName='Rob' or LastName='Walters'


  create   statistics  stats_ssn
  on pp£¨modifiedDate£©

select * from emp2 where  eid =102 


alter table he
add constraint pk_he_id primary key(Businessentityid)

alter table he
drop constraint pk_he_id

select * from t9   cluster scan
select * from t9   where id=9  ci seek
select * from  to where id=9 and name='peter' Nci seek + key lookup 
select  name,id from t9  where id=100 and name='peter' and city='los angeles'
select name,address from t9 where name ='peter'
select *
 from pp  where BusinessEntityID=20 and FirstName='abc' and LastName='456'

 --non cluster covering index 
 --include  clause   £¨col1 col2...£©
 select * from he
 create nonclustered index ncci on he(MaritalStatus) include(Gender)


 SELECT * FROM HE WHERE MaritalStatus='s'

--filter index  with where clause   rows level filter
create  index index_name on he(loginid)
where jobtitle!=(select JobTitle from he where JobTitle!='chief executive officer')

select name from t9  where name='peter'		

 
--ALTER DATABASE B88 SET QUERY_STORE = ON
--  alter database B88
--SET AUTOMATIC_TUNING ( FORCE_LAST_GOOD_PLAN = ON )
  ALTER DATABASE B88 SET QUERY_STORE = ON
  go 
 

 step1 create sbv on tables 

 step2   create  unique cluster index on any candidate key column sbv
 step3  
 
 select * from pp
 alter view sbv_pp with schemabinding   as 
 select firstname,ModifiedDate,rowguid  from dbo.pp -- with schemabinding
 where  year(ModifiedDate)>2002


 create unique clustered index idx_sbv_pp on sbv_pp(rowguid)

 
 select firstname,ModifiedDate,rowguid from pp where   rowguid='92C4279F-1207-48A3-8448-4636514EB7E2'--   year(ModifiedDate)>2002 


 select firstname,ModifiedDate,rowguid from sbv_pp      




 select * from sys.dm_exec_connections
 select   avg_fragmentation_in_percent as 'external frag', avg_page_space_used_in_percent as 'internal frag',page_count
 from sys.dm_db_index_physical_stats(db_id('B88'),OBJECT_ID('he'),0,null,'detailed')
  select   *--avg_fragmentation_in_percent as 'external frag', avg_page_space_used_in_percent as 'internal frag',page_count
 from sys.dm_db_index_physical_stats(db_id('B88'),OBJECT_ID('he'),object_id('ncci'),null,'detailed')
  select  * --avg_fragmentation_in_percent as 'external frag', avg_page_space_used_in_percent as 'internal frag',page_count
 from sys.dm_db_index_physical_stats(db_id('B88'),OBJECT_ID('pp'),object_id('idx3'),null,'detailed')

dbcc  showcontig('pp','idx3')
dbcc  showcontig('pp','idx1_p')
dbcc  showcontig('pp','idx2') 
 ALTER index all  on he   
 rebuild with (fillfactor=80,pad_index=on,sort_in_tempdb=on,online=on) 

alter index idx1 on pp disabled
DBCC DBREINDEX (pp, idx1)
--dmv dmf 
--master resource tempdb  model msdb 
 
	select @@DATEFIRST
	select @@language
	select @@CPU_BUSY

select * from sys.columns
select * from sys.all_views
select * from sys.views
select * from sys.tables
select * from sys.table_types

--table name as input and table  colname   and views and triggers and indexs and sp  and user function and schema name
go

create PROCEDURE Find(@TabName varchar(20)) as
begin

select st.name, ss.name,sc.max_length,  case sc.is_nullable
when 0 then 'no'
else 'yes'
end as nullable
, sty.name
from sys.tables  st inner join 
sys.columns sc  on
st.object_id=sc.object_id
inner join  sys.schemas ss
on st.schema_id=ss.schema_id
inner join sys.types sty
on sc.system_type_id=sty.system_type_id
where st.name=@TabName
end
exec Find @tabname='emp2'
-- table index name type of index   cluster  key 
select st.name as tablename,si.type_desc as indextype,si.name as indexname,sic.column_id,sty.name,sc.name as colname--, sc.name as columnname
from sys.tables  st inner join sys.indexes si
on st.object_id=si.object_id
inner join sys.index_columns sic
on si.index_id=sic.index_id   and si.object_id=sic.object_id
inner join  sys.columns sc
on sic.column_id=sc.column_id  and sic.object_id=sc.object_id
inner join sys.types sty
on sc.system_type_id=sty.system_type_id
where st.name='pp'
 

select * from  [LAPTOP-8HF2VF6N].B88.dbo.he
 --  
EXEC sp_depends  N'Sales.Customer'  
sp_helptext sp_depends
-- partitions 
go
-- step 1 create partition function
create partition function pf(int) as 

range left for values(50,100,150,200)

--create filegroup 
 alter database b88
	add filegroup filegroup1 
 alter database b88
	add filegroup filegroup2
 alter database b88
	add filegroup filegroup3 
 alter database b88
	add filegroup filegroup4 
 alter database b88
	add filegroup filegroup5 

alter database b88 
add file (Name=FG1_dat,filename="C:\Part\fg1.ndf",size=30mb,maxsize=50mb,filegrowth=5mb) to filegroup filegroup1

alter database b88 
add file (Name=FG2_dat,filename="C:\Part\fg2.ndf",size=30mb,maxsize=50mb,filegrowth=5mb) to filegroup filegroup2

alter database b88 
add file (Name=FG3_dat,filename="C:\Part\fg3.ndf",size=30mb,maxsize=50mb,filegrowth=5mb) to filegroup filegroup3

alter database b88 
add file (Name=FG4_dat,filename="C:\Part\fg4.ndf",size=30mb,maxsize=50mb,filegrowth=5mb) to filegroup filegroup4

alter database b88 
add file (Name=FG5_dat,filename="C:\Part\fg5.ndf",size=30mb,maxsize=50mb,filegrowth=5mb) to filegroup filegroup5
 

--scheme
create partition scheme ps
as
partition pf to (filegroup1,filegroup2,filegroup3,filegroup4,filegroup5)

create table pt (
id int identity(1,1),
name varchar(50)
)on ps(id)

insert into pt values('peter')
go 500

--drop table
  drop table pt
--drop scheme
drop partition scheme ps
--drop function
drop partition function pf 


alter database b88
remove file FG1_dat
alter database b88
remove file FG2_dat
alter database b88
remove file FG3_dat
alter database b88
remove file FG4_dat
alter database b88
remove file FG5_dat


alter database b88
remove filegroup filegroup1

alter database b88
remove filegroup filegroup2

alter database b88
remove filegroup filegroup3

alter database b88
remove filegroup filegroup4

alter database b88
remove filegroup filegroup5

 select st.name,sp.partition_number,sp.rows
 from sys.tables st
 inner join sys.partitions sp
 on st.object_id=sp.object_id
 where st.name='pt'


 select * from pt 
 where  name='peter'
  select * from pt1 
 where   name ='peter'

 create unique clustered index uci on pt(id)
 drop index uci on pt
  create   clustered index uci on pt(name)
 select * into pt1 from pt


 merge and split partitons 



 alter partition function pf()
 merge range(150)

 alter partition function pf()
 split range(150)

 alter table pp
 add constraint pk_pp_bid primary key  (businessentityid)

 create clustered index idx1_p on pp(businessentityid) 

 drop index pk_pp_bid on pp

 go

 create clustered index idx1_p on pp(businessentityid) WITH(DROP_EXISTING = ON) on ps(businessentityid) ---???


 

 
 select * from sales s inner  loop join client c
 on s.sid=c.sid

select * from sales with(nolock)

select * from sales with(xlock)


 use b88
 go

 select  * from pp 
 with(index(idx2))
 inner join he
 on pp.BusinessEntityID=he.BusinessEntityID

 select * from emp2

 create clustered index cin on emp2(mid)
 insert into  emp2 values(5,null,12)
 drop index cin on emp2
 create clustered index cin on emp2(name)
 select * from emp2



 alter database b88  set recovery bulk_logged

 --fullbackup 
 backup database b88 to disk ='c:\Bak\B88_full.bak'
 --differentail backup
 backup database b88 to disk='c:\bak\B88_diff.dif'
 --transaction
backup database b88 to disk='c:\bak\b88_tlb.trn'
-- job agents 
create database test_encoding


--isoloation 
-- related with the currency control 

--read uncommited low
--read commited  default
--repeatable read
--serializable high
--snapshot  
--locks  to make sure data consistancy
--share lock read operation only (select) row level lock
-- xlock exclusive  lock  any modify operations 
--update lock ulock result deadlock
--intent share  wait to get next share lock a kind of ticket
--intent exclusive
--intent update
--lock part finished by database engine  step3 

--dat inconsisiteny provlem
--dirty  reads
-- read during modify
--non repeatable read
--
--phantom read 
----read uncommitted 
-- user1 
dbcc useroptions

use Test_DB
go

--dirty read
begin tran 
	update stock set pname='bike'
		waitfor delay '00:00:10'
rollback

--non repeatable read

update stock set pname='bike' where pid=100

--phantom read
set showplan_text on
insert into stock 
values(104,'car',40,5000)

select * from stock

begin tran
select * from stock
waitfor delay '00:00:10'
select * from stock
commit

alter database test_db
set allow_snapshot_isolation on


--repeated read

--serializable
set transaction isolation level   read committed

begin tran
select * from stock  
waitfor delay '00:00:10'
update stock set pname='perfume' where pid=102
commit
dbcc useroptions

begin tran
select * from stock
waitfor delay '00:00:10'
update stock set pname='perfume' where pid=102
commit

use b88
go

 create   view VE3 with schemabinding    as
 select emp2.* from emp2
 
 dbcc  checkident(emp2)

 select * from emp2   where eid <5

 union 
 select * from emp2  where eid>10
	
SELECT conn.session_id, host_name, program_name,
    nt_domain, login_name, connect_time, last_request_end_time 
FROM sys.dm_exec_sessions AS sess
JOIN sys.dm_exec_connections AS conn
   ON sess.session_id = conn.session_id



   set showplan_text   off
   select  case   
   when eid =8 then 'boss'
   when mid=5 then 'emp'
   end as level ,*
    from emp2

	dbcc checkdb('b88')
	DBCC CHECKALLOC
	dbcc checkconstraints('sale2')
---  sql profiler and DTA 

insert into pp(BusinessEntityID,ModifiedDate,rowguid) values(0001,GETDATE(),'peter',)
go 100000
select BusinessEntityID  from pp

























--login & users
create login [mytestlogin] with password ='changeme'
Must_change,Check_expiration=on,default_database=[b88]

create user test_mc_test for login mytestlogin

--diff login user

 
--login for server level    user for database level 
--login must be mapped to a user   
-- user may without login
--one login with multi users   single may not multi login
-- login for instance level security principle    user for database level security

-- new features  2012

SELECT MAX(login_time) AS [Last Login Time], login_name [Login]
FROM sys.dm_exec_sessions
GROUP BY login_name;

 select * from sys.dm_exec_sessions 
 select * from sys.dm_exec_connections


SELECT DATABASEPROPERTYEX('master', 'Status')
GO


