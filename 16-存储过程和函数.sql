#存储过程和函数
/*
存储过程和函数：类似于java中的方法
好处：
1.提高代码的重用性
2.简化操作


*/

#存储过程
/*
含义：一组预先编译好的sql语句的集合，理解成批处理语句
1.提高代码的重用性
2.简化操作
3.减少了编译次数并且减少了数据库服务器的连接次数，提高了效率


*/

#一。创建过程
create procedure 存储过程名（参数列表）
begin 

        存储过程体（一组合法的sql语句）

end

注意：
1.参数列表包含三部分
参数模式， 参数名， 参数类型

举例：
in stuname varchar(20)

参数模式：
in：该参数可以作为输入，也就是该参数需要调用方传入值
out：该参数可以作为输出，也就是该参数可以作为返回值
inout：该参数既可以作为输入又可以作为输出，也就是该参数及需要传入值，又可以返回值

2.如果存储过程体仅仅只有一句话，begin end 可以省略
存储过程体中的每条sql 语句的结尾要求必须加分号。
存储过程的结尾可以使用 delimiter 重新设置

语法：
delimiter 结束标记

案例：
delimiter $

#视频155节左右开始，没有详细听，以后用到可以来学习

#二.调用语法
call 存储过程名（实参列表）；

#1.空参列表
#案例：插入到admin表中五条记录

select * from admin;

delimiter $   (#结束标记的设置)
create pricedure myp1()
begin
        insert into admin(username,'password')
        values('john','000')
end $

#调用
call myp1()$

#2.创建带in模式参数的储存过程

#案例1：穿件初春过程实现 根据表名，查询对应的信息

create procedure myp2(in girlname varchar(20))
begin
        select bo.*
        from boys bo
        right join beauty b on bo.id = b.boyfriend_id
        where b.name=girlname;

end $

#调用
call myp2('Ross')$

#3.创建带out模式的存储过程
https://www.youtube.com/watch?v=9nBhegg4SpY&list=PLmOn9nNkQxJHvSwmwwnH3oInxIr7HIZ8U&index=159


#4.创建带inout 模式参数的储存过程
#案例1：传入a和b两个值，最终a和b都翻倍并返回

create procedure myp8(imput a int,inout b int)
begin 
        set a=a*2;
        set b=b*2;
end $

#调用
set @m=10$
set @


#二。删除存储过程
#语法：drop procedure 存储过程名

#三。查看存储过程的信息
show create procedure myp2;












#函数
/*
含义：一组预先编译好的sql语句的集合，理解成批处理语句
1.提高代码的重用性
2.简化操作
3.减少了编译次数并且减少了数据库服务器的连接次数，提高了效率

区别（与存储函数相比）：
存储过程：可以有0个返回，也可以有多个返回（适合做批量插入，更新）
函数：有且仅有1个返回(处理数据后返回一个值)

*/

#一。创建语法
create function函数名（参数列表）returns 返回类型
begin   
        函数体
end 

/*
注意：
参数列表 包含两部分：
参数名 参数类型

函数体：肯定会有return语句，如果没有回报错
如果return语句没有放在函数体的最后也不报错，但不建议

return 值；
3.函数体中仅有一句话，则可以忽略begin end
4.使用delimiter语句设置结束标记

delimiter $;
*/

#二。调用语法
select 函数名（参数列表）

#三。查看函数
show create function myf3;

#四。删除函数
drop function myf3；





