#TCL 事务控制语言
/*
Transaction Control Language 事务控制语言

事务：
一个或一组sql语句组成一个执行单元，这个执行单元要么全部执行，要么全部不执行。


事务的特性：
ACID

原子性：一个事务不可再分割，要么都执行都么都不执行
一致性：一个事务执行会使数据从一个一致状态切换到另外一个一致状态
隔离性：一个事务的执行不受其他事务的干扰
持久性：一个事务一旦提交，则会永久的改变数据库的数据

事务的创建
隐式事务：事务没有明显的开启和结束的标记
比如insert,update,delete语句

delete from 表 where id=1；

显式事务：事务具有明显的开启和结束的标记
前提：必须先设置自动提交功能为禁止

set autocommit=0；

步骤1：开启事务
set autocommit=0;
start transaction:可选的

步骤2：编写事务中的sql语句（select insert update delete）
语句1；
语句2；
。。。

步骤3：结束事务
commit；提交事务
rollback；回滚事务

savepoint 节点名：

事务的隔离级别：
                   脏读       不可重复度       幻读
read uncomitted:    √           √             √       
read committed:     ×           √             √       
repeatable read:    ×           ×             √       
serializable:       ×           ×             ×           

mysql中默认 第三个隔离级别 repeatable read
oracle中默认第二个隔离  

#相关操作
#①每启动一个mysql程序，就会获得一个单独的数据库连接，每个数据库连接都有一个全局变量
  @@tx_isolation,表示当前的事务隔离级别

#②查看当前的隔离级别：select @@tx_isolation;

#③设置当前mysql连接的隔离级别：
  set transaction isolation level committed;

#④设置数据库系统的全局的隔离级别：
  set global transaction isolation level read committed;


*/

#1.演示事务的使用步骤

#开启事务
set autocommit=0;
start transaction;
#编写一组事务的语句
update account set balance = 500 where username='张'；
update account set balance = 1500 where username='王'；

#结束事务
coomit；
#rollback; #回滚业务

select * from account；

#2.演示事务对于delete和truncate的处理的区别

set autocomit=0;
start transaction;

delete from account;
rollback;

#3.演示sabepoint 的使用

set autocommit=0;
strat transaction;
delete from accout where id=25;
savepoint a;#设置保存点
delete from account where id=28;
rollback to a;#回滚到保存点







