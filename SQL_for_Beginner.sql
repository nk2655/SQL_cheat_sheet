/* This learning materials for beginner in SQL, authored by NK Zou, please don't remove this line */

/*
SQL 对大小写不敏感
数据操作语言DML
SELECT, UPDATE, DELETE, INSERT INTO
数据定义语言DDL
CREATED DATABASE, ALTER DATABASE, CREATE TABLE, ALTER TABLE,
DROP TABLE, CREATE INDEX, DROP INDEX

database > tables > rows & colums

example
table_name: Persons
Id | LastName | FirstName | Address    | City
1  | Adams    | John      | Oxford St  | London
2  | Bush     | George    | Fifth Ave  | New York
3  | Carter   | Thomas    | Changan St | Beijing
*/

-- 创建数据库
CREATE DATABASE database_name

-- 创建table
CREATE TABLE Persons
(
Id_P int,                        --int代表整数
LastName varchar(255),           --代表最大长度255个字符
FirstName varchar(255) NOT NULL, --NOT NULL代表不接受NULL值
Address varchar(255),
City varchar(255),
UNIQUE (Id_P),     --UNIQUE代表唯一标识，在MYSQL定义UNIQUE
Id_P int NOT NULL UNIQUE, --在SQL Server/Oracle/MS Access定义UNIQUE
CONSTRAINT uc_PersonID UNIQUE, (Id_P,LastName) --给几个colums定义UNIQUE
PRIMARY KEY (Id_P),  --在MYSQL定义PRIMARY KEY
Id_P int NOT NULL PRIMARY KEY, --在SQL Server/Oracle/MS Access定义PRIMARY KEY
CONSTRAINT pk_PersonID PRIMARY KEY, (Id_P,LastName)  --给几个columns定义PRIMARY KEY
FOREIGN KEY (Id_P) REFERENCES Persons(Id_P), --在MYSQL定义FOREIGN KEY用于连接到外表防止key错误
CHECK (Id_P>0),  --在MYSQL规定条件
Id_P int NOT NULL CHECK (Id_P>0), --在SQL Server/Oracle/MS Access规定条件
CONSTRAINT chk_Person CHECK (Id_P>0 AND City='Sandnes') --规定多个条件
City varchar(255) DEFAULT 'Sandnes'， --规定默认值
)

ALTER TABLE Persons
ADD UNIQUE (Id_P)   --在已存在的table新增定义UNIQUE
ADD CONSTRAINT uc_PersonID UNIQUE (Id_P,LastName)
DROP INDEX uc_PersonID  --在MYSQL撤销UNIQUE
DROP CONSTRAINT uc_PersonID  --在SQL Server/Oracle/MS Access撤销UNIQUE
P_Id int NOT NULL AUTO_INCREMENT, --用于MYSQL在新插入时自动生成唯一值
P_Id int PRIMARY KEY IDENTITY, --用于SQL Server在新插入时自动生成唯一值
P_Id int PRIMARY KEY AUTOINCREMENT,  --用于Access在新插入时自动生成唯一值
/* Oracle比较麻烦,通过 sequence,分成创建table和插入数据两部分操作
CREATE SEQUENCE seq_person MINVALUE 1 START WITH 1 INCREMENT BY 1 CACHE 10
INSERT INTO Persons (P_Id,FirstName,LastName) VALUES (seq_person.nextval,'Lars','Monsen')
*/
ADD PRIMARY KEY (Id_P)   --在已存在的table新增定义PRIMARY KEY
ADD CONSTRAINT pk_PersonID PRIMARY KEY (Id_P,LastName)
DROP PRIMARY KEY  --在MYSQL撤销PRIMARY KEY
DROP CONSTRAINT pk_PersonID  --在SQL Server/Oracle/MS Access撤销PRIMARY KEY
ADD FOREIGN KEY (Id_P) REFERENCES Persons(Id_P) --在已存在的table新增定义FOREIGN KEY
DROP FOREIGN KEY fk_PerOrders  --在MYSQL撤销FOREIGN KEY
DROP CONSTRAINT fk_PerOrders  --在SQL Server/Oracle/MS Access撤销FOREIGN KEY
ADD CHECK (Id_P>0)   --在已存在的table新增条件
ADD CONSTRAINT chk_Person CHECK (Id_P>0 AND City='Sandnes')
DROP CHECK chk_Person --在MYSQL撤销条件
DROP CONSTRAINT chk_Person  --在SQL Server/Oracle/MS Access撤销条件
ALTER City SET DEFAULT 'SANDNES'--在MYSQL新增默认值
ALTER COLUMN City SET DEFAULT 'SANDNES' --在SQL Server/Oracle/MS Access新增默认值
ALTER City DROP DEFAULT  --在MYSQL撤销默认值
ALTER COLUMN City DROP DEFAULT  --在SQL Server/Oracle/MS Access撤销默认值

-- 创建和删除INDEX,可以不读取整个表更快的查找数据
CREATE INDEX PersonIndex ON Person (LastName DESC)
CREATE INDEX PersonIndex ON Person (LastName, FirstName)
DROP INDEX index_name ON table_name  --用于 Microsoft SQLJet以及 Microsoft Access
DROP INDEX table_name.index_name  --用于 MS SQL Server
DROP INDEX index_name  --用于 IBM DB2 和 Oracle
ALTER TABLE table_name DROP INDEX index_name  --用于 MySQL

-- INSERT, 插入数据
INSERT INTO Persons VALUES ('Gates', 'Bill', 'Xuanwumen 10', 'Beijing') --插入新的行
INSERT INTO Persons (LastName, Address) VALUES ('Wilson', 'Champs-Elysees') --在指定的列插入数据

-- UPDATE, 修改数据
UPDATE Person SET FirstName = 'Fred' WHERE LastName = 'Wilson'
UPDATE Person SET Address = 'Zhongshan 23', City = 'Nanjing' WHERE LastName = 'Wilson'

-- DELETE, 删除数据
DELETE FROM Person WHERE LastName = 'Wilson' 
DELETE FROM table_name --删除所有rows, 但不删除table, index还在
DELETE * FROM table_name --删除所有rows, 但不删除table, index还在
DROP DATABASE database_name  --删除整个数据库
DROP TABLE table_name --删除整个table
TRUNCATE TABLE table_name --删除所有rows, 但不删除table, index还在

-- ALTER TABLE, 修改table.colum
ALTER TABLE Persons ADD Birthday date  --新增colum，最后date是定义数据类型，可以存放日期
ALTER TABLE Persons ALTER COLUMN Birthday year  --修改colum类型，year可以存放2位或4位的年份
ALTER TABLE Persons ALTER COLUMN Birthday year --删除colum

-- SELECT, 查询数据，最基础的语法
SELECT LastName FROM persons
SELECT LastName, FirstName FROM persons
SELECT * FROM Persons
SELECT DISTINCT Company FROM Orders --返回唯一不同值，类似于Python的set
SELECT * FROM Persons WHERE city='Beijing' --操作符有=, <>或!=, >, <, >=, <=, BETWEEN, LIKE
SELECT LastName,FirstName,Address FROM Persons WHERE Address IS NULL  --检验数值是否NULL，查找不是NULL的语法用 IS NOT NULL，NULL函数计算往下看function部分
SELECT * FROM Persons WHERE LastName IN ('Adams','Carter') --IN的作用类似于=
SELECT * FROM Persons WHERE LastName BETWEEN 'Adams' AND 'Carter' --BETWEEN不包括后者
SELECT * FROM Persons WHERE LastName NOT BETWEEN 'Adams' AND 'Carter' --NOT代表不包含
SELECT * FROM Persons WHERE FirstName='Thomas' AND LastName='Carter' -- AND 和 OR
SELECT * FROM Persons WHERE (FirstName='Thomas' OR FirstName='William') AND LastName='Carter'
SELECT Company, OrderNumber FROM Orders ORDER BY Company DESC -- DESC是倒序，ASC是顺序，不标注的话默认顺序
SELECT Company, OrderNumber FROM Orders ORDER BY Company DESC, OrderNumber ASC

-- TOP, 查看前几位数据
SELECT * FROM Persons LIMIT 5 --MYSQL语法
SELECT * FROM Persons WHERE ROWNUM <= 5 --Oracle语法
SELECT TOP 2 * FROM Persons --SQL语法
SELECT TOP 50 PERCENT * FROM Persons

-- LIKE, 查询类似值
SELECT * FROM Persons WHERE City LIKE 'N%' --LIKE是通配符，代表缺少的字母，可放任何位置
SELECT * FROM Persons WHERE City NOT LIKE '%lon%' --NOT代表不包含
SELECT * FROM Persons WHERE City LIKE '[ALN]%' --查找包含ALN任意一个字母开头的数据，注意%的位置
/* 替代一个或多个字符， _仅替代一个字符, [charlist]字符列中的任何单一字符,
[^charlist]或[!charlist]不在字符列中的任何单一字符 */

-- Alias, 别名
--table.colum语法
--用AS定义table的别名
SELECT po.OrderID, p.LastName, p.FirstName FROM Persons AS p, Product_Orders AS po WHERE p.LastName='Adams' AND p.FirstName='John'
--用AS定义colum的别名
SELECT LastName AS Family, FirstName AS Name FROM Persons

-- JOIN 和 key, 连接两个tables
--Id_P是key,两个tables都有这个key作为连接点
SELECT Persons.LastName, Persons.FirstName, Orders.OrderNo FROM Persons, Orders WHERE Persons.Id_P = Orders.Id_P

-- INNER JOIN和JOIN的作用是相同的
SELECT Persons.LastName, Persons.FirstName, Orders.OrderNo FROM Persons INNER JOIN Orders ON Persons.Id_P = Orders.Id_P ORDER BY Persons.LastName
/* JOIN: 如果表中有至少一个匹配，则返回行
LEFT JOIN: 即使右表中没有匹配，也从左表返回所有的行
RIGHT JOIN: 即使左表中没有匹配，也从右表返回所有的行
FULL JOIN: 只要其中一个表中存在匹配，就返回行 */

-- UNION, 连接两个或多个tables
--UNION生成不重复的值，类似set，UNION ALL即使有重复值也加进去
SELECT E_Name FROM Employees_China UNION SELECT E_Name FROM Employees_USA

-- INTO, 生成新table或复制到特定数据库
SELECT * INTO Persons IN 'Backup.mdb' FROM Persons
SELECT Persons.LastName,Orders.OrderNo INTO Persons_Order_Backup FROM Persons INNER JOIN Orders ON Persons.Id_P=Orders.Id_P

-- VIEW, 视图是基于SQL语句的结果集的可视化的表
CREATE VIEW [Current Product List] AS SELECT ProductID,ProductName FROM Products WHERE Discontinued=No
SELECT * FROM [Current Product List] --查看视图
SQL DROP VIEW Syntax DROP VIEW view_name --删除视图

-- Date类型和函数
/*
MySQL 使用下列数据类型在数据库中存储日期或日期/时间值：
DATE - 格式 YYYY-MM-DD
DATETIME - 格式: YYYY-MM-DD HH:MM:SS
TIMESTAMP - 格式: YYYY-MM-DD HH:MM:SS
YEAR - 格式 YYYY 或 YY

NOW()	返回当前的日期和时间
CURDATE()	返回当前的日期
CURTIME()	返回当前的时间
DATE()	提取日期或日期/时间表达式的日期部分
EXTRACT()	返回日期/时间按的单独部分
DATE_ADD()	给日期添加指定的时间间隔
DATE_SUB()	从日期减去指定的时间间隔
DATEDIFF()	返回两个日期之间的天数
DATE_FORMAT()	用不同的格式显示日期/时间

SQL Server 使用下列数据类型在数据库中存储日期或日期/时间值：
DATE - 格式 YYYY-MM-DD
DATETIME - 格式: YYYY-MM-DD HH:MM:SS
SMALLDATETIME - 格式: YYYY-MM-DD HH:MM:SS
TIMESTAMP - 格式: 唯一的数字

GETDATE()	返回当前日期和时间
DATEPART()	返回日期/时间的单独部分
DATEADD()	在日期中添加或减去指定的时间间隔
DATEDIFF()	返回两个日期之间的时间
CONVERT()	用不同的格式显示日期/时间
*/

--NULL 函数的计算
--如果 "UnitsOnOrder" 是 NULL，则不利于计算，因此如果值是 NULL 则 ISNULL() 返回 0
SELECT ProductName,UnitPrice*(UnitsInStock+ISNULL(UnitsOnOrder,0)) FROM Products --用于SQL Server/MS Access
SELECT ProductName,UnitPrice*(UnitsInStock+NVL(UnitsOnOrder,0)) FROM Products  --Oracle 没有 ISNULL() 函数。不过，我们可以使用 NVL() 函数达到相同的结果
SELECT ProductName,UnitPrice*(UnitsInStock+IFNULL(UnitsOnOrder,0)) FROM Products  --用于SQL的方法一
SELECT ProductName,UnitPrice*(UnitsInStock+COALESCE(UnitsOnOrder,0)) FROM Products  --用于SQL的方法二

-- FUNCTION函数  SELECT function(colum_name) FROM table_name

--合计函数（Aggregate functions）的操作面向一系列的值，并返回一个单一的值

--MS Access合计函数
--AVG(column)	返回某列的平均值
SELECT AVG(OrderPrice) AS OrderAverage FROM Orders
SELECT Customer FROM Orders WHERE OrderPrice>(SELECT AVG(OrderPrice) FROM Orders)
--COUNT(column)	返回某列的行数(不包括 NULL 值), DISTINCT返回共有几个客户
SELECT COUNT(Customer) AS CustomerNilsen FROM Orders WHERE Customer='Carter'
SELECT COUNT(DISTINCT Customer) AS NumberOfCustomers FROM Orders
--OUNT(*)	返回被选行数，即该table总共有多少rows
SELECT COUNT(*) AS NumberOfOrders FROM Orders
--FIRST(column)	返回在指定的域中第一个记录的值
SELECT FIRST(OrderPrice) AS FirstOrderPrice FROM Orders
--LAST(column)	返回在指定的域中最后一个记录的值
SELECT LAST(OrderPrice) AS LastOrderPrice FROM Orders
--MAX(column)	返回某列的最高值
SELECT MAX(OrderPrice) AS LargestOrderPrice FROM Orders
--MIN(column)	返回某列的最低值
SELECT MIN(OrderPrice) AS SmallestOrderPrice FROM Orders
--STDEV(column)	 
--STDEVP(column)	 
--SUM(column)	返回某列的总和
SELECT SUM(OrderPrice) AS OrderTotal FROM Orders
--VAR(column)	 
--VARP(column)
--GROUP BY
SELECT column_name, aggregate_function(column_name) FROM table_name WHERE column_name operator value GROUP BY column_name
SELECT Customer,SUM(OrderPrice) FROM Orders GROUP BY Customer
SELECT Customer,OrderDate,SUM(OrderPrice) FROM Orders GROUP BY Customer,OrderDate
--HAVING, 在 SQL 中增加 HAVING 子句原因是，WHERE 关键字无法与合计函数一起使用
SELECT column_name, aggregate_function(column_name) FROM table_name WHERE column_name operator value GROUP BY column_name HAVING aggregate_function(column_name) operator value
SELECT Customer,SUM(OrderPrice) FROM Orders GROUP BY Customer HAVING SUM(OrderPrice)<2000
SELECT Customer,SUM(OrderPrice) FROM Orders WHERE Customer='Bush' OR Customer='Adams' GROUP BY Customer HAVING SUM(OrderPrice)>1500

--SQL Server合计函数
--AVG(column)	返回某列的平均值
--BINARY_CHECKSUM	 
--CHECKSUM	 
--CHECKSUM_AGG	 
--COUNT(column)	返回某列的行数（不包括NULL值）
--COUNT(*)	返回被选行数
--COUNT(DISTINCT column)	返回相异结果的数目
--FIRST(column)	返回在指定的域中第一个记录的值（SQLServer2000 不支持）
--LAST(column)	返回在指定的域中最后一个记录的值（SQLServer2000 不支持）
--MAX(column)	返回某列的最高值
--MIN(column)	返回某列的最低值
--STDEV(column)	 
--STDEVP(column)	 
--SUM(column)	返回某列的总和
--VAR(column)	 
--VARP(column)

--MS Access的 Scalar 函数的操作面向某个单一的值，并返回基于输入值的一个单一的值
--UCASE(c)	将某个域转换为大写
SELECT UCASE(LastName) as LastName,FirstName FROM Persons
--LCASE(c)	将某个域转换为小写
SELECT LCASE(LastName) as LastName,FirstName FROM Persons
--MID(c,start[,end])	从某个文本域提取字符
SELECT MID(column_name,start[,length]) FROM table_name
SELECT MID(City,1,3) as SmallCity FROM Persons    --从city提取第1至3个字符
--LEN(c)	返回某个文本域的长度
SELECT LEN(City) as LengthOfCity FROM Persons
--INSTR(c,char)	返回在某个文本域中指定字符的数值位置
--LEFT(c,number_of_char)	返回某个被请求的文本域的左侧部分
--RIGHT(c,number_of_char)	返回某个被请求的文本域的右侧部分
--ROUND(c,decimals)	对某个数值域进行指定小数位数的四舍五入
SELECT ProductName, ROUND(UnitPrice,0) as UnitPrice FROM Products
--MOD(x,y)	返回除法操作的余数
--NOW()	返回当前的系统日期,如果使用Sql Server数据库则使用getdate()来获得当前的日期时间
SELECT ProductName, UnitPrice, Now() as PerDate FROM Products
--FORMAT(c,format)	改变某个域的显示方式
SELECT ProductName, UnitPrice, FORMAT(Now(),'YYYY-MM-DD') as PerDate FROM Products
--DATEDIFF(d,date1,date2)	用于执行日期计算