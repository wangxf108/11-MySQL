#进阶6：连接查询
/*
含义：又称多表查询，当查询的字段来自多个表时，就会用到连接查询

笛卡尔乘机现象：表1有m行， 表2有n行，结果=m*n行

发生原因：没有有效的连接条件
如何避免：添加有效的连接条件

分类：
        按年代分类：
        sq192标准：仅仅支持内连接
        sql99标准（推荐)：支持内外交叉连接

        按功能分类：
                内连接：
                        等值连接
                        非等值连接
                        自连接
                外连接：
                        左外连接
                        右外连接
                        全外连接
                交叉连接

*/

select * from beauty;
select * from boys;
select name,boyname from boys,girls

#一、sql92标准

#1.等值连接
/*
①多表等值连接的结果为多表的交集部分
②n表连接至少需要n-1个连接条件
③多表的顺序没有要求
④一般需要为表起别名
⑤可以搭配前面介绍的所有子句使用，排序

#语法：
        select 查询列表
        from 表1 别名，表2 别名
        where 表1.key=表2.key
        【and 筛选条件】
        【group by 分组字段】
        【having 分组后的筛选】
        【order by 排序字段】
*/

#案例1：查询女和对应男名

select name,boyname
from boys,beauty
where beauty.boyfriend_id=boys.id;

#案例2：查询员工名和对应的部门名
select last_name,department_name
from employees,departments
where employees.'department_id'=departments.'department_id';

#2.为表起别名
/*
①提高语句的简洁度
②区分多个重名的字段

注意：如果为表起了别名，则查询的字段就不能使用原来的表名去限定

*/
#查询员工名，工种号，工种名

select e.last_name,e.job_id,j.job_titile
from employees as e,jobs as j   （一般先执行这一段，所以起了别名以后，select的部分也要相应的改变）
where e.'job_id'=j.'job_id';

#3.两个表的顺序是否可以调换,可以

#4.可以筛选吗—？可以

#案例1：查询有奖金的员工名，部门名
select last_name,department_name 
from employees e,departments department_id
where e.'department_id'=d.'department_id'
and e.'commission_pct' is not null;

#案例2：查询城市名中第二个字符为o的部门名和城市名
select department_name,city
from departments d,locations last_name
where d.'loation_id' = l.'location_id'
and city like '_o%';

#5.可以加分组吗？ 可以
#案例1：查询每个城市的部门个数
select count(*) 个数,city
from departments d,locations l
where d.'locaton_id'=l.'location_id'
group by city;

#案例2：查询有奖金的每个部门的部门名和部门的领导标号和该部门的最低工资
from departments d,employees e
where d.'department_id'=e.'department_id'
and commission_pct is not null
group by department_name,d.'manageer_id'; 

#6.可以加排序
#案例：查询每个工种的工种名和员工的个数，并且按员工个数降序
select job_title,count(*)
from employees e,jobs job_id
where e.'job_id'=j.'job_id'
group by job_title
order by count(*) desc;

#7.可以实现三表连接吗？可以
#案例：查询员工名，部门名，和所在城市
select last_name,department_name,city
from employees e,departments d,locations l
where e.'department_id'=d.'department_id'
and d.'location_id'=l.'location_id'
and city like 's%'
order by department_name desc;

#2.非等值连接

#3.自连接


#一、sql99语法
/*
语法：
        select 查询列表
        from 表1 别名 【连接类型】
        join 表2 别名 
        on 连接条件
        where 筛选条件
        group by 分组
        having 筛选条件
        order by 排序条件

分类：
内连接：inner
外连接：
        左外：left【outer】
        右外：right 【outer】
        全外：full【outer】
交叉连接：cross

*/

#一）内连接
/*
语法：
        select 查询列表
        from 表1 别名
        inner join 表2 别名
        on 连接条件；


分类：
        等值
        非等值
        自连接

特点：
        ①添加排序，分组，筛选
        ②inner可以省略
        ③筛选条件放在where后面，连接条件放在on后面，提高分离性，便于阅读
        ④inner join 连接和sql92语法中的等值连接效果是一样的，都是查询多表的交集

*/
 
#1.等值连接
#案例1.查询员工名，部门名
select last_name,department_name
from employees e
inner join departments d
on e.'department_id' = d.'department_id';

#案例2.查询名字中包含e的员工名和工种名（添加筛选）
select last_name,job_title
from employees e
inner join jobs j
on e.'job_id'=j.'job_id'
where e.'last_name' like '%e%';

#3.查询部门个数>3的城市名和部门个数，（添加分组+筛选）

#①查询每个城市的部门个数
#②在①结果上，筛选满足条件的
select city,count(*) 部门个数
from departments d
inner join locations l
on d.'location_id'=l.'location_id'
group by city 
having count(*)>3;


#案例4，查询哪个部门的员工个数>3的部门名和员工个数，并按个数降序（添加排序)
#①查询每个部门的员工个数
select count(*),department_id
from employees
inner join departments d 
on e.'department_id'=d.'department_id'
group by department_name
#②在①的结果上筛选员工个数大于3的记录，并排序
select count(*),department_name
from employees
group by department_name
having count(*)>3
order by count(*) desc;


#二）非等值连接
#查询员工的工资级别
select salary,grade_level
from employees e
join job_grades g 
on e.'salary' between g.'lowest_sal' and g.'highest_sal';

#查询工资级别的个数>20的个数，并且按工资级别降序
select count(*),grade_level
from employees e
join job_grades g 
on e.'salary' between g.'lowest_sal' and g.'highest_sal'
group by grade_level
having count(*)>20
order by grade_lever desc;

#三） 自连接

#查询员工的名字，上级的名字
select e.last_name,m.last_name
from employees e 
inner join employees m
on e.'manager_id'=m.'employee_id';

#查询姓名中包含字符k的员工的名字，上级的名字
select e.last_name,m.last_name
from employees e 
inner join employees m
on e.'manager_id'=m.'employee_id'
where e.'last_name' like '%k%';



#二，外连接
/*
应用场景：用于查询一个表中有，另一个表没有的记录

特点：
1.外连接的查询结果为主表中的所有记录
        如果从表中有和他匹配的，则电视匹配的值
        如果从表中没有和他匹配的，则显示null
        外连接查询结果=内连接结果+主表中有而从表没有的记录
2.左外连接，left join 左边的是主表
  右外连接，right join右边的是主表
3.左外和右外交换两个表的顺序，可以实现同样的效果
4.全外连接=内连接的结果+表1中有但表2没有的+表2中有但表1中没有的
*/

#引入：查询男朋友，不在男友姓名表的女生姓名
select * from beauty
select * from boys

#左外连接
select b.name,bo.*
from beauty b 
left outer join boys bo
on b.'boyfriend_id' = bo.'id'
where bo.'id' is null;

#案例1：查询哪个部门没有员工
#左外
select d.*,e.employee_id
from departments d
left outer join employees e 
on d.'department_id' = e.'department_id'
where e.'employee_id' is null;

#右外
select d.*,e.employee_id
from employees e
right outer join departments d
on d.'department_id' = e.'department_id'
where e.'employee_id' is null;

#全外
use girls;
select b.*,bo.*
from beauty b
full outer join boys bo 
on b.'boyfriend_id' = bo.id;

#交叉连接
select b.*,bo.*
from beauty b
cross join boys bo;


#sql92 和 sql99 
功能：sql99支持的较多
可读性：sql99实现连接条件和筛选条件的分离，可读性较高