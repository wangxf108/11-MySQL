#视图
/*
含义：虚拟表，和普通表一样使用
mysql5.1版本出现的新特性。一种虚拟存在的表。只保存sql逻辑，不保存查询结果。

应用场景：
        ①多个地方用到同样的查询结果
        ②该查询结果使用的sql语句较复杂

优点：
    重用sql语句
    简化复杂的sql操作，不必知道她的查询细节
    保护数据，提高安全性


视图与表的对比：
            创建语法的关键字            是否实际占用物理空间         增删改查
视图          create view              只是保存了sql逻辑          一般不能                                          
表            create table             保存了数据                   能

*/

#案例：查询姓张的学生名和专业名
select stuname,majorname
from stuinfo s
inner join major m on s.'majorid'= m.'id'
where s.'stuname' like '张&'；

#打包成视图，封装
create view v1
As
select stuname,majorname
from stuinfo s
inner join major m on s.'majorid'= m.'id'

#下次执行时
select * from v1 where stuname like '张%'；


#一.创建视图

/*
语法：
create view 视图名
as
查询语句；

*/

#案例：140节，此处记录略去。
https://www.youtube.com/watch?v=7nA8QZxwoVs&list=PLmOn9nNkQxJHvSwmwwnH3oInxIr7HIZ8U&index=140

#

#二。视图的修改

#方式一：
/*
create or replace view 视图名
as
查询语句；

#以下类型的视图不能更新：
        ①包含一下关键字的sql语句：分组函数，distanci, group by, having, union, union all
        ②常量视图
        ③select中包含子查询
        ④join
        ⑤from 一个不能更新的视图
        ⑥where 子句的子查询引用了from子句中的表

具体例子在第144节，进行了举例
https://www.youtube.com/watch?v=dng9UdfHI-Q&list=PLmOn9nNkQxJHvSwmwwnH3oInxIr7HIZ8U&index=144
*/
select * from myv3

create or replace view myv3
as
select avg(salary),job_id
from employees
group by job_id;

#方式二：
/*
语法：
alter view 视图名
as
查询语句；

*/
alter view myv3
as
select * from employees;

#三。删除视图
/*
语法：drop view 视图名，视图名，。。。；

*/
drop view myv1，myv2，myv3；

#四。查看视图

desc myv1； 

show create view myv3;

#五.视图的更新

create or replace view myv1 
as
select last_name,email,salary*12*(1+ifnull(commission_pct,0)) "annual salary"
from employess;

select * from myv1；

##对视图的修改会自动完成对原表的修改

#1.插入

insert into myv1 values('zhang','zf@a.com');

#2.修改
update myv1 set last_name = 'wang' where last_name=''

#3.删除
delete from myv1 where last_name ='zhang';



