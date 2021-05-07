#常见的数据类型
/*
数值型：
        整型
        小数：
                定点数
                浮点数
字符型：
        较短的文本：char. varchar
        较长的文本：text. blob(较长的二进制数据)

日期型：

*/

#教学119节开始，分别介绍各个数据类型。 

#一。整型
/*
分类：

Tinyint   1字节

smallint  2字节

Mediumint 3字节

int/integer 4字节

bigint  8字节

特点：
①如果不设置无符号还是有符号，默认是有符号，如果想设置无符号，需要添加unsigned关键字
②如果插入的数值超出了整型的范围，会报out of range 异常，并且插入临界值
③如果不设置长度，会有默认的长度 
长度代表了显示的最大宽度，如果不够会用0在左边填充，但必须搭配zerofill使用


*/

 #1.如何设置无符号和有符号

 create table tab_int(
         t1 int
         t2 int unsigned
 ); 


 #二。小数
 /*
分类：
1.浮点型
float（M，D）
double(M，D)
2.定点型
dec（M，D）
decimal（M，D）

特点：

①
M：整数部位+小数部位
D：小数部分
如果超过范围，则超如临界值

②
M和D都可以省略
如果是decimal，则M默认为10，D默认为0
如果是float和double，则会根据插入的数值的精度来决定精度

③定点型精确度较高，如果要求插入的数值精度较高，如货币运算等则考虑使用

 */


 #原则：
 /*
所选择的类型越简单越好，能保存数值的类型越小越好

 */

#三。字符型
/*
较短的文本：
char
varchar

其他：

binary和varbinary用于保存较短的二进制
enum用于保存枚举
set用于保存集合

较长的文本：
text
blob（较大的二进制）

特点：

        写法            M的意思                          特点              空间的耗费      效率
char    char（M）       最大的字符数可以省略，默认为1        固定长度的         比较消耗        高
                        
varchar varchar(M)      最大的字符数，不可以省略            可变长度的字符      比较节省        低
*/ 

#四。日期型

/*
分类：
date 只保存日期
time 只保存时间
year 只保存年

datetime 保存日期+时间
timestamp 保存日期+时间

特点：
                字节                   范围                     时区等的影响
datetime        8                       1000-9999               不受
timestamp       4                       1970-2038    ß           受

*/
create talbe tab_date(
        t1 datetime,
        t2 timestamp
);


        

