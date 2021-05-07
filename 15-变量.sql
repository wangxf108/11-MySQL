#变量
/*
系统变量：
        全局变量
        会话变量

自定义变量：
        用户变量
        局部变量

*/

#一.系统变量
/*
说明：变量由系统提供，不是用户变量，数据服务器层面

使用的语法：
1.查看所有的系统变量
show global|[session] variables;

2.查看满足条件的部分系统变量
show global|[session] variables like 'char%';

3.查看指定的某个系统变量的值
select @@global|[session].系统变量名；

4.为某个系统变量赋值
方式一：
set global|[session] 系统变量名 = 值；

方式二：
set @@global|【session】.系统变量名=值；

注意：
如果是全局级别，则需要加global，如果是会话级别，则需要加session，如果不写，则默认session

*/

#1》全局变量
/*
作用域：服务器每次启动都为所有的全局变量赋初始值，针对于所有的会话（连接）有效，但不能跨重启
*/


#①查看所有的全局变量
show global variables;

#②查看部分的全局变量
show global variables like '%char%';

#③查看指定的全局变量的值
select @@global.autocommit;
select @@tx_isolation;

#④为某个指定的全局变量赋值
set @@global.autocommit=0;

#2》会话变量
/*
作用域：仅仅针对于当前会话（连接）有效

*/

#①查看所有的会话变量
show variables;
show session variables;

#②查看部分的会话变量
show variables like '%char%';
show session variables like '%char%';

#③查看指定的某个会话变量
select @@tx_isolation;
select @@session.tx_isolation;

#④为某个会话变量赋值
方式一：
set @@ssession.tx_isolation='read-uncommitted';

方式二：
set session tx_isolation ='read-committed';


#二。自定义变量
/*
说明：变量是用户自定义的，不是由系统的
使用步骤：
声明
赋值
使用（查看，比较，运算等）
*/

#1.用户变量
/*
作用域：针对于当前会话（连续）有效，同于会话变量的作用域
应用在任何地方
*/

赋值的操作符： = 或 :=
#①声明并初始化
set @用户名=值；或
set @用户变量名:=值；或
select @用户变量名:=值;

#②赋值（更新用户变量的值）
方式一：通过set 或 select
        set @用户名=值；或
        set @用户变量名:=值；或
        select @用户变量名:=值;

方式二：通过select into

        select 字段 into 变量名
        from 表；

#③使用（查看用户变量的值）
select @变量名；

#2.局部变量
/*
作用域：仅仅在定义它的begin end 中有效
应用在 begin end中的第一句话！
*/

#①声明
declare 变量名 类型；
declare 变量名 类型 default 值；或

#②赋值

方式一：通过set或select
       set 局部变量名=值；或
       set 变量名:=值;或
       select @局部变量名:=值;

方式二：通过select into 
       
       select 字段 into @局部变量名
       from 表;

#③使用
select 局部变量名；

对比用户变量和局部变量；

                作用域             定义和使用的位置                            语法
用户变量        当前会话             会话中任何地方                        必须加@符号，不用限定类型

局部变量        begin end 中         只能在begin end中，且为第一句         一般不用加@符号，需要限定类型
