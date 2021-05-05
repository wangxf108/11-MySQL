#进阶8：分页查询☆☆☆☆☆☆☆常用，较简单
/*

应用场景：当要显示的数据，一页显示不全，需要分页提交sql请求
语法：
        select 查询列表
        from 表
        【join type】 join 表2
        on 连接条件
        where 筛选条件
        group by 分组字段
        having 分组后的筛选
        order by 排序的字段
        limit offset，size；

        offset要显示条目的起始索引（起始索引从0开始）
        size 要显示的条目数

特点：
        ①limit语句放在查询语句的最后
        ②公式
        要显示的页数page，每页的条目数size

        select 查询列表
        from 表
        limit （page-1）*size ， size；￥￥￥￥￥￥￥￥￥￥￥￥￥此处公式要记住

*/

#案例1： 查询全五条员工信息

select * from employees limit 0,5;
select * from employees limit 5;

以上两个效果相同


#案例2：查询第11条到第25条
select * from employees 10,15;

#案例3：有奖金的员工信息，并且工资较高的前10名显示出来
select * from employees 
where commission_pct is not null 
order by salary desc 
limit 10;




===================================================
#课程第99节，讲解了一些经典题型。可以用作复习。
===================================================