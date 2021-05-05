#DML语言
/*
数据操作语言：
插入：insert
修改：update
删除：delete
*/


#一、插入语句

#方式一：经典的插入
/*
语法：
insert into 表名（列名，。。。） values（值1，。。。）
*/

#1.插入的值得类型要与列的类型一致或兼容
insert into beauty(id,name, sex,borndate,phone,photo,boyfriend_id)
value(13,'唐艺昕','女','1990-4-23','188888888',null,2);

#2.不可以为null的列，必须插入值。可以为null的列如何插入值?
#方式一：
insert into beauty(id,name, sex,borndate,phone,photo,boyfriend_id)
value(13,'唐艺昕','女','1990-4-23','188888888',null,2);

方式二：
insert into beauty(id,name,borndate,phone)
value(13,'唐艺昕','1990-4-23','188888888');

#3.列的顺序可以调换，但要一一对应。

#4.列数和插入值得个数必须相同。

#5.可以省略列名，默认所有列，而且列的顺序和表中列的顺序一致。


#方式二：
/*
语法：
insert into 表名
set 列名=值，列名=值，。。。。
*/

insert into beauty
set id=19,name='刘涛'，phone='1229292922';


#两种方式大pk

1.方式一支持插入多行,方式二不支持
insert into beauty
value(13,'唐','女','1990-4-23','188888888',null,2),
(14,'艺','女','1990-4-23','188888888',null,2),
(15,'昕','女','1990-4-23','188888888',null,2);

2.方式一支持子查询，方式二不支持


#二。修改语句

/*
1.修改单表的记录☆☆☆

语法：
update 表名
set 列=新值，列=新值，。。。
where 筛选条件；

2.修改多表的记录【】记录

语法：
sql92语法：
update 表1 别名，表2 别名
set 列=值，。。。。
where 连接条件
and 筛选条件

sql99语法：
update 表1 别名
inner|left|right join 表2 别名
on 连接条件
set 列=值，。。。
where 筛选条件；


*/

#1.修改单表的记录
#案例1：修改beauty表中姓唐的女生的电话为12312839123

update beauty set phone = ’12312839123‘
where name like ’唐%‘；

#案例2：修改boys表中id号为2的名称为张二，魅力值10
update boys set boyname='zhanger',usercp=10
where id=2

#三。删除语句
/*

方式一。delete
语法：
1.单表的删除
delete from 表名 where 筛选条件

2.多表的删除【补充】
课件第108节，此处不记录了，头晕了

方式二：truncate
语法：truncate table 表名；
*/


#方式一：delete
#1.单表的删除
#案例：删除手机号以9结尾的女神信息

delete from beauty where phone like ’%9‘；
select * from beauty；

#2.多表的删除


#方式二：truncate语句
#案例：将魅力值>100的男神信息删除
truncate table boys；


#delete pk truncate
/*
1.delete 可以加where 条件，truncate 不能加

2.truncate删除，效率高一点

3.加入要删除的表中有自增长列，如果用delete删除后，再插入数据，自增长列的值从断点开始，
而truncate删除后，再插入数据，自增长列的值从1开始。

4.truncate删除没有返回值，delete删除有返回值。

5.truncate删除不能回滚，delete删除可以回滚。

*/


