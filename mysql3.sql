# 进阶3：排序查询

/*
引入:
    select * from employees;

语法：
    select 查询列表
    from 表
    【where 筛选列表】
    order by 排序列表 【asc|desc】

特点：1.asc：升序，从高到低； desc：降序，从低到高
     asc可以不写
     2.order by子句中可以支持单个字段，多个字段，表达式，函数，别名
     3。order by子句一般是放在查询语句的最后面， limit子句除外（比order by 还要靠后）。
*/

#例子1：查询员工信息，要求工资从高到低排序
select * from employees order by desc;

#例子2：查询部门编号>=90的员工信息，按照入职时间的先后排序[添加筛选条件]

select *
from employees
where department_id >= 90
order by hiredate ASC;

#例子3：按照年薪的高低显示员工的信息和年薪【按照表达式排序】
select *, salary*12*(1+ifnull(commission_pct,0)) 年薪     ***此处，给年薪设置了一个别名
from employees
order by salary*12*(1+ifnull(commission_pct,0)) desc；

#例子4：按照年薪的高低显示员工的信息和年薪【按别名排序】
select *, salary*12*(1+ifnull(commission_pct,0)) 年薪     ***此处，给年薪设置了一个别名
from employees
order by 年薪 desc；

#例子5：按照姓名长度显示姓名和工资【按函数排序】
select length（last_name） 字节长度，last_name,salary
from employees
order by length(last_name) desc;

 #例子6：查询员工信息，要求先按照工资升序，再按照员工编号降序【按多个字段排序】
 select *
 from employees
 order by salary asc, employee_id desc;
 (先按照薪水从低到高，同一薪水里面再按照id从高到低排列)




