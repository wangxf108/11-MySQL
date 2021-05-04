#进阶1: 基础查询

语法：
select 查询列表 from 表名；

类似于： system.out.printlin;

打开指定数据库
USE myemployees;

特点：
1.查询列表可以是：字段，常量，表达式，函数
2.查询的结果是一个虚拟表格。

#1.查询单个字节
SELECT last_name FROM employees;

#2.查询多个字节
SELECT last_name,salary,email FROM employees;

#3.SELECT * FROM employees;

#4.查询常量值
SELECT 100；
注意：字符型和日期型的常量必须用单引号引起来，数值型不需要

#5.查询表达式
SELECT 100%98；

#6.查询函数
SELECT VERSION();

#7.起别名
/*
1.便于理解
2.查询的字段有
*/
#方式一：使用AS
SELECT 100%98 AS 结果；
SELECT last_name AS 姓， first_name AS 名 FROM employees；
#方式二：使用空格
SELECT last_name 姓，first_name 名 FROM employees;

#案例（特殊情况，要加双引号，不然系统会出错）
SELECT salary AS “out put” FROM emplyees；

#8.去重(DISTINCT)
SELECT DISTINCT department_id FROM employees;

#9.+号的作用
/*
mysql中，只有一个功能，运算符，不作为链接字符的符号

select 100+90;两个都为数值，则做加法运算；
select '123'+90;其中一个为字符形，会试图将字符型变成数值；
select 'john'+90;如果转化失败，则会将字符型数值转换成0
select null+0; 只要其中一个为null，则结果也为null
*/

#10.连接，合并
CONCAT（）
功能：拼接字符
select CONCAT（字符1，字符2，字符3，。。。）

#11. ifnull()
功能：判断某字段或表达式是否为null，如果为null返回指定的值，否则返回原本的值

select ifnull(commission_pct, 0) from employees;
(如果选取的值为null，则返回值为0)

#12 isnull()
功能：判断某字段是否为null，如果是null，则返回1，否则为0







