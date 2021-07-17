/*创建表格*/
create table SheYuanTable (sheyuanid nchar(10), username nchar(10), age int, bumenid nchar(10))
create table BuMenTable (bumenid nchar(10), bumenname nchar(10), placeid nchar(10))


/*插入数据*/
insert into SheYuanTable(sheyuanid, username, age, bumenid) values('A01','田中', 20, 'KAIFA01')
select sheyuanid, username, age, bumenid from SheYuanTable
insert into SheYuanTable(sheyuanid, username, age, bumenid) values('A02','田中', 30, 'KAIFA02')
insert into SheYuanTable(sheyuanid, username, age, bumenid) values('A03','山田', 25, 'KAIFA03')
insert into SheYuanTable(sheyuanid, username, age, bumenid) values('S1004','田田', 53, 'A04')
insert into SheYuanTable(sheyuanid, username, age, bumenid) values('S1004', '渡辺', 40, null)


/*插入数据*/
insert into BuMenTable(bumenid, bumenname, placeid) values('A01', '開発部', 'P01')
insert into BuMenTable(bumenid, bumenname, placeid) values('A02', '営業部', 'P02')
insert into BuMenTable(bumenid, bumenname, placeid) values('A03', '海外部', 'P03')


/*更新数据*/
update SheYuanTable set bumenid = 'A01', sheyuanid = 'S1001' where username = '田中' 
update SheYuanTable set bumenid = 'A02', sheyuanid = 'S1002' where username = '本田' 
update SheYuanTable set bumenid = 'A03', sheyuanid = 'S1003' where username = '山田' 
update SheYuanTable set age = 30 where username = '田田' 

/*删除数据*/
delete from SheYuanTable where sheyuanid = 'A02'

select * from BuMenTable
select * from SheYuanTable

/*数据选取*/
select username, age, bumenid from SheYuanTable
select * from SheYuanTable where age>=20 and age<=50
select * from SheYuanTable where age<=20 or age>=50

/*数据按条件选择*/
select * from SheYuanTable 
where age>=20 and age<=30 
and sheyuanid >='A01' and sheyuanid <= 'A03'
or ( bumenid ='KAIFA01' or bumenid = 'KAIFA03')

select distinct bumenid from SheYuanTable

/*表的结合*/
select SheYuanTable.username, BumenTable.bumenname 
from SheYuanTable inner join BuMenTable on SheYuanTable.bumenid = BuMenTable.bumenid

/*起别名,表结合*/
select t1.username, t2.bumenname from SheYuanTable t1 inner join BuMenTable t2 
on t1.bumenid = t2.bumenid

/*起别名，表结合加条件*/
select t1.username, t1.age, t2.bumenname 
from SheYuanTable t1 inner join BuMenTable t2 
on t1.bumenid = t2.bumenid
where t2.bumenname='開発部' and t1.age >= 20 and t1.age <= 50


select t1.sheyuanid, t1.username, t1.age, t2.bumenname
from SheYuanTable t1 inner join BuMenTable t2
on t1.bumenid = t2.bumenid
where (t1.age <= 20 or t1.age >=45) 
and (t2.bumenname = '営業部' or t2.bumenname = '海外部')

/*查找null*/
select * from SheYuanTable where bumenid is null
select * from SheYuanTable where bumenid is not null