#进阶4： 常见函数
/*
概念：类似于java的方法，将一组逻辑语言封装在方法体内，对外暴露方法名
好处：1。隐藏了实现细节 2.提高代码的重复性
调用： select 函数名（实参列表）【from 表】；
特点：
    1.叫什么（函数名）
    2.干什么（函数功能）
分类：
    1.单行函数
    如：concat、length、ifnull 等
    2.分组函数
    功能：做统计使用，又称为统计函数，聚合函数，组函数


常见函数：
        一、单行函数
        字符函数
        length
        concat
        substr
        instr
        tri
        upper
        lower
        lpad
        rpad
        replace

        数学函数：
        round
        ceil
        floor
        truncate
        mod

        日期函数：
        now
        curdate
        curtime
        year
        month
        monthname
        day
        hour
        minute
        secon
        str_to_date
        date_format
        其他函数：
        version
        database
        user
        控制函数
        if
        else

*/

#一、字符函数

#1.length 获取参数值得字节个数
select length('john')
select length('张三丰hahaha'); (一个汉字三个字节)

show variables like '%char%'

#2.concat 拼接字符串

select concat (last_name,'_',first_name) 姓名 from employees;

#3.upper、lower
select upper('john');
select lower('joHn');
#例子：将姓变大写，名变小写，然后拼接
select concat(upper(last_name),lower(first_name)) 姓名 from employees；

#4.substr、substring （截取字符串）
注意：索引从1开始
#截取从指定索引处后面所有字符
>>>select substr('李莫愁爱上了陆展元',6) out_put;
>>>了陆展元
（上面实例，说明索引是从1开始，并不是从0开始）

#截取从指定所引处指定字符长度的字符
>>>select substr('李莫愁爱上了陆展元',1,3) out_put;
>>>李莫愁
（如果上面有两个数字，则是从第一个数字，到另一个数的所有字符串，进行返回）

#例子：姓名中首字符大写，其他字符小写然后用_拼接，然后显示出来
select concat(upper(substr('first_name',1,1)),'_',lower（substr(last_name,2))） out_put 
from employees;

#5.instr 
功能：返回子串第一次出现的索引，如果找不到就返回0
>>>select instr('杨不悔爱上了殷六侠'，'殷六侠') as out_put
>>>from emplotees;
>>>7

#6.traim
功能：去除子串中字符前后的空格，或者指定字符
>>>select trim('   张翠山        ') as out_put;
>>>张翠山

>>>select trim('a' from 'aaaa张aaaa翠山aaaaa') as out_put;
>>>张aaaa翠山

#7.lpad
功能：用指定的字符实现左填充指定长度
>>>select lpad('殷素素'，10，'*') as out_put;
>>>*******殷素素

#8.rpad
功能：用指定的字符实现右填充指定长度
>>>select rpad('殷素素'，10，'*') as out_put;
>>>殷素素*******

#9.replace 替换
>>>select replace('hello world','world','you') as out_put;
>>>hello you

#二、数学函数

#round 四舍五入
>>>select round(1.65);
>>>2
>>>select round(1.567,2);
>>>1.57

#ceil 向上取整,返回>=该参数的最小整数
>>>select ceil(1.52);
>>>2

#floor 向下取整,返回<=该参数的最大整数
>>>floor ceil(9.99);
>>>9

#truncate 截断,指定位数之后都不要
>>>select truncate(1.69999,1);
>>>1.6

#mod 取余
>>>select mod(10,-3)；
>>>1

#三、日期函数
#now 返回当前系统日期+ 时间
select now();

#curdate 返回当前系统日期，不包含时间
select curdate();

#curtime 返回当前时间，不包含日期
select curtime();

#可以获取指定的部分，年月日小时分钟秒
select year(now()); 年
select year('1998-1-1');
select year（hiredate） 年 from employees；
select month(now()) 月；
select monthname(now()) 月；

#日期格式转换
str_to_date: 将日期格式的字符转换成指定格式的日期
>>>str_to_date('9-13-1999','%m-%d-%Y')       （Y大写代表四位的年份）
>>>1999-09-13

#

#四、其他函数
select version();
select database();
select user();

#五、流程控制函数
#1.if函数： 类似 if else 的效果

select  if(10>5,'大'，'小');

select last_name,commission_pct,if(commission_pct is null,'没奖金，呵呵'，'有奖金，嘻嘻') 备注


#2.case函数的使用一： switch case 的效果
/*
java中
switch(变量或表达式){
        case 常量1：语句1；break；
        ...
        default:语句n;break;
}
mysql中
case 要判断的字段或表达式
when 常量1 then 要显示的值1或语句1；
when 常量2 then 要显示的值2或语句2；
...
else 要显示的值n或语句n；
end
*/



#案例：查询员工的工资，要求
部门号=30，显示的工资为1.1倍
部门号=40，显示的工资为1.2倍
部门号=40，显示的工资为1.3倍
部门号=40，显示的工资为原来工资

select salary 原始工资,department_id,
case department_id
when 30 then salary*1.1
when 40 then salary*1.2
when 50 then salary*1.3
else salary
end as 新工资
from employees；

#3.case函数的使用二：类似于 多重if
/*
case
when 条件1 then 要显示的值1或语句1
when 条件2 then 要显示的值2或语句2
。。。
else 要显示的值n或语句n
end
*/

#案例：查询员工的工资的情况
如果工资大于两万，显示A级别
如果工资大于一万五，显示B级别
如果工资大于一碗，显示C级别
否则，显示D级别

select salary,
when salary>20000 then 'A'
when salary>15000 then 'B'
when salary>10000 then 'C'
else 'D'
end as 工资级别
from employees； 
————————————————————————————————————————————————————————————————————————————————————————
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

/*
(上接)常见函数：
        二、分组函数
        功能：用作统计使用，又称为聚合函数或统计函数或组函数

        分类：
        sum 求和、avg平均值、max最大值、min最小值、count、计算个数

        特点：
            1.sum、avg一般用于处理数值型
              max、min、count可以处理任何类型
            2、以上分组函数都忽略null值
            3、可以和distinct搭配，实现去重的运算
            4、count函数的单独介绍
            一般使用count(*) 来统计行数
            5、和分组函数一同查询的字段要求是group by 后的字段


*/

#1.简单的使用
select sum(salary) from employees;
select min(salary) from employees;
select max(salary) from employees;
select avg(salary) from employees;

select sum(salary) 和,avg(salary), 平均，max(salary) 最高，min(salary) 最低，count(salary) 个数
from employees;

#2.参数支持哪些类型
select sum(last_name)


#3.是否忽略null


#4.和distinct(去重) 搭配
select sum(distinct salary),sum(salary) from employees;


#5.count函数的详细介绍
select count(salary) from employees;
select count(*) from employees;    (所有列中，只要有一个不为null，则计入统计，使用较多)
select count(1) from employees;    (得到结果和上面的一样)

效率： 
myisam存储引擎下， count() 的效率高
innodb存储引擎下，count(1)和count(*)的效率差不多，比count(字段)要高一些

#6.和分组函数一同查询的字段有限制
