#进阶5:分组查询
/*
语法： 
        select 分组函数，列（要求出现在group by 的后面）
        from 表
        【where 筛选条件】
        group by 分组的列表
        【order by 子句】
注意：
        查询列表必须特殊，要求是分组函数和group by 后出现的字段。

特点：
        1.分组查询中的筛选条件可以分为两类
                        数据源                位置                  关键字
        分组前筛选        原始表                group by子句的前面     where
        分组后筛选        分组后的结果集         group by子句的后面     having

        重点：
        ①分组函数做条件肯定是放在having子句中******
        ②能用分组前筛选的，就优先考虑使用分组前筛选

        2.group by 子句支持单个字段分组，多个字段分组（多个字段之间用逗号隔开没有顺序要求，
         表达式或函数，用的较少）
        
        3.也可以添加排序（排序放在整个分组查询的最后）
*/

#引入：查询每个部门的平均工资
select avg(salary) from employees;

#例子1：查询每个工种的最高工资
select max(salary),job_id
from employees
group by job_id;

#例子2：查询每个位置上的部门个数
select count(*),location_id
from departments
group by location_id;

#添加’筛选前‘筛选条件
#例子1： 查询邮箱中包含a字符的，每个部门的平均工资(包含的话用like())

select avg(salary),department_id
from employees
where email like '%a%' 
group by department_id

#例子2：查询有奖金的每个领导手下员工的最高工资

select max(salary),manager_id
from employees
where commission_pct is not null
group by manager_id;

#添加分组后的筛选条件
#例子1：查询哪个部门的员工个数>2

#①查询每个部门的员工个数
select count(*),department_id
from employees
group by department_id;

#②根据①的结果进行筛选，查询哪个部门的员工个数>2
select count(*),department_id
from employees
group by department_id
having count(*)>2;

#例子2：查询每个工种有奖金的员工的最高工资>12000的工种编号和最高工资
#①查询每个工种有奖金的员工的最高工资
select max(salary),job_id
from employees
where commission_pct is not null
group by job_id;

#②根据①结果继续筛选，最高工资>12000
select max(salary),job_id
from employees
where commission_pct is not null
group by job_id
having max(salary)>12000;

#例子3：查询领导编号>102的每个领导手下的最低工资>5000的领导编号是哪个，以及其最低工资

#自己的答案
select manager_id,salary
from employees
where min(salary)>5000
group by manager_id
having (manager_id)>102;

#标准答案
①查询每个领导手下的员工固定最低工资
select min(salary),manager_id
from employees 
group by manager_id 

#②添加筛选条件：编号>102
select min(salary),manager_id
from employees 
where manager_id>102
group by manager_id 

#③添加筛选条件：最低工资大于5000
select min(salary),manager_id
from employees 
where manager_id>102
group by manager_id 
having min(salary)>5000;

#按表达式或函数分组

#例子：按员工姓名的长度分组，查询每一组的员工个数，筛选员工个数>5的有哪些

#①查询每个长度的员工个数
selecet count(*),length(last_name) len_name
from employees
group by length(last_name);

#②添加筛选条件
selecet count(*),length(last_name) len_name
from employees
group by length(last_name)
having count(*)>5;


#按多个字段分组

#例子：查询每个部门每个工种的员工的平均工资

select avg(salary),department_id,job_id
from employees
group by department_id,job_id;

#添加排序
##例子：查询每个部门每个工种的员工的平均工资，并且按平均工资的高低显示

select avg(salary),department_id,job_id
from employees
group by job_id,department_id
order by avg(salary) desc;
