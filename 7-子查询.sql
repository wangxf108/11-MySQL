#进阶7：子查询
/*
含义：
    出现在其他语句中的select语句，称为子查询或查询
    外部的查询语句，称为主查询或外查询。

分类：
    按子查询出现的位置：
        select后面；
                仅仅支持标量子查询

        from 后面：
                支持表子查询

        where 或 having后面：  ☆☆☆（重点部分）
                标量子查询（单行）     ☆☆☆
                列子查询（多行）       ☆☆☆
                行子查询

        exists 后面（相关子查询）：
                表子查询

    按结果集的行列数不同：
        标量子查询（结果集只有一行一列）
        列子查询（结果集只有一列多行）
        行子查询（结果集有一行多列）
        表子查询（结果集一般为多行多列）

*/

#一. where 或 having 后面
/*
1.标量子查询（单行子查询）
2.列子查询（多行子查询）
3.行子查询（多列多行）

特点：
①子查询放在小括号内
②子查询一般放在条件的右侧
③标量子查询，一般搭配着单行操作符使用
><= >= <= <>

列子查询，一般搭配着多行操作符使用
in， any、some、all

④子查询的执行优先于主查询执行，主查询的条件用到了子查询的结果。
*/


#1.标量子查询

#案例1：谁的工资比Abel高？

# ①查询Abel的工资
select salary
from employees
where last_name = 'Abel'

# ②查询员工的消息，满足salary>①结果
select *
from employees
where salary>(
        select salary
        from employees
        where last_name = 'Abel'
);

#案例2：返回job_id 与 141号员工相同， salary比143号员工多的员工 姓名，job_id和工资

# ①查询141号员工的job_id
select job_id
from employees
where employee_id = 141

# ②查询143号员工的salary
select salary 
from employees
where employee_id = 143

# ③查询员工的姓名， job_id 和工资，要求job_id=①并且salary大于②

select last_name,job_id,salary
from employees
where job_id = (
        select job_id
        from employees
        where employee_id = 141
) and salary>(
        select salary 
        from employees
        where employee_id = 143
);

#案例3：返回公司工资最少的员工的last_name,job_id和salary

# ①查询公司的最低工资
select min(salary)
from employees

# ②查询last_name，job_id和salary，要求salary=①
select last_name,job_id,salary
from employees
where salary=(
        select min(salary)
        from employees
);

#案例4：查询最低工资大于50号部门最低工资的部门id和最低工资

# ①查询50号部门的最低工资
select min(salary)
from employees
where department_id = 50;

# ②查询每个部门的最低工资
select min(salary),department_id
from employees
group by department_id

#③筛选②，满足min(salary)>①
select min(salary),department_id
from employees
group by department_id
having min(salary)>(
        elect min(salary)
        from employees
        where department_id = 50
);

#非法使用标量子查询，子查询的结果必须为 【一行一列】


#2.列子查询（多行子查询）
#返回多行
#使用多行比较操作符 
 in/ not in ：等于列表中的任意一个
 any|some ：和子查询返回的某一个值比较
 all   ： 和子查询返回的所有值比较

#案例1：返回location_id是1400或1700的部门中的所有员工姓名

#①查询location_id是1400或1700的部门编号
select distinct department_id
from departments
where location_id in(1400,1700)

#②查询员工姓名，要求部门号是①列表中的某一个
select last_name
from employees
where department_id in(
        select distinct department_id
        from departments
        where location_id in(1400,1700)
);

#案例2：返回其他部门中比job_id为’IT_PROG‘部门任一工资低的员工的员工号，姓名，job_id 以及salary
#①查询job_id为’IT_PROG‘部门任一工资
select distinct salary
from employees
where job_id='IT_PROG'

②查询员工号，姓名，job_id以及salary，salary<（①）的任意一个
select last_name,employee_id,job_id,salary
from employees
where salary<ANY(
        select distinct salary
        from employees
        where job_id='IT_PROG'
)and job_id<>'IT_PROG';


#3.行子查询（结果集一行多列或多行多列）
#案例：查询员工编号最小并且工资最高的员工信息

select *
from employees
where (empolyee_id,salary)=(
        select min(emploee_id),max(salary)
        from employees
);


#①查询最小的员工编号
select min(employee_id)
from employees

#②查询最高工资
select max(salary)
from employees

#③查询员工信息
select *
from employees
where employee_id=(
        select min(employee_id)
        from employees
)and salary=(
        select max(salary)
        from employees
);


#二。select后面（可以用其他方式代替，了解即可）
/*
仅仅支持标量子查询
*/

#案例：查询每个部门的员工个数

select d.*,(   
        select count(*) 
        from employees
        where e.department_id = d.'department_id'
) 个数
from departments d;


#案例2：查询员工号=102的部门名

select (
        select department_name
        from departments d
        inner join deployees e 
        on d.department_id=e.department_id
        where e.employee_id=102
) 部门名；



#三。from 后面
/*
将子查询结果充当一张表，要求必须起别名
*/

#案例：查询每个部门的平均工资的工资等级

#①先查询每个部门的平均工资

select avg(salary),department_id
from employees
group by department_id

select * from job_grades;

#②连接①的结果集和job_grades表，筛选条件平均工资between lowest_sal and hightest_sal
#(下方，新建的子查询表必须起别名 ag_dep，不然找不到)

select ag_dep.*,g.'grade_level'                  
from (
        select avg(salary) ag,department_id
        from employees
        group by department_id
) ag_dep
inner join job_grades g
on ag_dep.ag between lowest_sal and highest_sal;


#四。exists后面（相关子查询）
/*
语法：
        exists（完整的查询语句）
结果：
        1或0
*/

#结果存在，输出1；无结果，输出0
>>>select exists(select employee_id from employees);
>>>1/0

#案例1：查询有员工的部门名

#in 的方法
select department_name
from departments d 
where d.'department_id' in(
        select department_id
        from employees
);


#exists

select department_name
from departments d
where exists(
        select *
        from employees e
        where d.'department_id'=e.'department_id'
);


#习题：查询各部门中工资比本部门平均工资高的员工的员工号，姓名和工资
#①查询各部门的平均工资
select avg(salary),department_id
from employees
group by department_id

#②连接①结果集和employees表，进行筛选
select employee_id,last_name,salary
from employees e
inner join (
        select avg(salary) ag,department_id
        from employees
        group by department_id 
) ag_dep
on e.department_id = ag_dep.department_id
where salary>ag_dep.ag ;


