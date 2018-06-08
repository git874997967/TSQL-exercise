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

DBCC SHOW_STATISTICS ("Person.Address", AK_Address_rowguid)  WITH HISTOGRAM  
 DBCC CHECKTABLE ('HumanResources.Employee')

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

 
 select firstname,ModifiedDate,rowguid from pp where   year(ModifiedDate)>2002 


 select firstname,ModifiedDate,rowguid from sbv_pp      




 select * from sys.dm_exec_connections
 select   avg_fragmentation_in_percent as 'external frag', avg_page_space_used_in_percent as 'internal frag',page_count
 from sys.dm_db_index_physical_stats(db_id('B88'),OBJECT_ID('he'),0,null,'detailed')
  select   *--avg_fragmentation_in_percent as 'external frag', avg_page_space_used_in_percent as 'internal frag',page_count
 from sys.dm_db_index_physical_stats(db_id('B88'),OBJECT_ID('he'),object_id('ncci'),null,'detailed')
  select  * --avg_fragmentation_in_percent as 'external frag', avg_page_space_used_in_percent as 'internal frag',page_count
 from sys.dm_db_index_physical_stats(db_id('B88'),OBJECT_ID('pp'),object_id('idx3'),null,'detailed')

dbcc  showcontig('pp','idx3')
dbcc  showcontig('pp','idx1')
dbcc  showcontig('pp','idx2') 
 ALTER index all  on he   
 rebuild with (fillfactor=80,pad_index=on,sort_in_tempdb=on,online=on) 

alter index idx1 on pp disable
--dmv dmf 
--master resource tempdb  model msdb 


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
 
 
 --  
EXEC sp_depends  N'Sales.Customer'  
sp_helptext sp_depends



  