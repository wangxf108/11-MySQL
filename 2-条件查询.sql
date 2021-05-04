#进阶2：条件查询
/*
    语法：
    select
        查询列表
    from
        表名
    where
        筛选条件；

    分类：
     一。按条件表达式帅选
     条件运算符：> < !=  <> 
     二。按照逻辑表达式筛选
     and or not
    &&和and：两个都为ture，结果为true，反之为false；
    ||或or：只要其中一个为true，结果为true，反之为false
    ！或not：如果连接的条件本身为false，结果为true，反之为false    

    三。模糊查询
    like 
    /*
     特点:
     1.和通配符%一起用
        通配符：
        % 任意多个字符，包含0个字符
        _ 任意单个字符
    */  
    
    between and 
    /*
     1.包含临界值
     2.两个临界值不能颠倒
    */

    in 
    /*
     含义：判断某字段的值是否属于in列表中的某一项
     特点：提高简洁度
        in列表的值类型必须一致或兼容
        不支持通配符的使用
    */
    is null 
    /*
    = > < 不能用于判断null 值
    */

    is not null 
    /* 可以判断.

    */
*/

#一.按照条件表达式筛选
SELECT
   *
FROM
    employees
WHERE 
    salary>2000;

#二。按照逻辑表达式
SELECT
    last_name,
    salary,
    commision_pct
from 
    employees 
where 
    salary>=10000 and salary<=20000;

SELECT
*
FROM 
    employees
WHERE
    not (department_id>=90 and department_id<=110) or salary>15000;

#三。模糊查询
#例子，查询员工名包含字符a的员工信息
SELECT 
    *
FROM 
    employees
WHERE
    last_name like '%a%'
    #(%代表通配符，a前面后面都可能有字符)

#例子，查询员工名中第三个字符为e，第五个字符为a的员工名字和工资
select
    last_name, 
    salary
from 
    employees
where
    last_name like '__e_a%'

#例子，查询员工名字中第三个为字符_的员工名
select
    last_name, 
from 
    employees
where
    last_name like '_\_%';
    (转义字符， \ 或者 $ )
    last_name like '_$_%' escape '$'     (escape 对转义字符的说明，此方法也可行)
 
#2.between and 
select 
    *
from 
    employees 
where 
    employee_id between 100 and 200;

#3.in
select 
    last_name,
    job_id
from 
    employees 
where 
    job_id = 'IT_port' or job_id = 'AD_vp' or job_id = 'AD_pres';
换成 job_id in ('IT_port','AD_vp','AD_pres');

#4. is null
#例子，查询没有奖金的员工名
elect 
    last_name,
    commission_pct
from 
    employees 
where 
    commission_pct is null; 
   (此处的 is 不能换成 ‘=’， 因为 ‘=’不能识别 null )

#例子，查询有奖金的员工名
elect 
    last_name,
    commission_pct
from 
    employees 
where 
    commission_pct is not null; 

#安全等于  <=>
#例子，查询没有奖金的员工名
elect 
    last_name,
    commission_pct
from 
    employees 
where 
    commission_pct <=>null; 
    commission_pct <=> 20000;  (此时，可以连接数字，进行安全判断。)

# is null pk <=>

is null : 仅仅可以判断 NULL值，可读性较高，建议使用
<=>     : 既可以判断null值得，又可以判断普通的数值，可读性较低
