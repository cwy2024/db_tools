-- 预载数据, test_data_panle：数据类型、索引约束、存储过程、函数
-- 预载数据, test_utf8mb4 字符集、触发器、事件

-- 数据面用例：数据库 test_data_panle
-- 创建数据库
drop database if exists test_data_panle;
CREATE DATABASE test_data_panle CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE test_data_panle;

-- 涉及参数
-- set global log_bin_trust_function_creators='ON';

-- 增量阶段默认数据表
CREATE TABLE test (
  id INT NOT NULL PRIMARY KEY COMMENT 'user_id',
  name CHAR(255) COMMENT 'user_name'
);

-- 基础用例：创建包含Mysql典型数据类型的数据表
-- 创建表格
CREATE TABLE mytable (
  id INT NOT NULL AUTO_INCREMENT,
  name VARCHAR(50) NOT NULL,
  age INT NOT NULL,
  email VARCHAR(50) NOT NULL,
  PRIMARY KEY (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- 插入数据
INSERT INTO mytable (name, age, email) VALUES
('Alice', 25, 'alice@example.com'),
('Bob', 30, 'bob@example.com'),
('Charlie', 35, 'charlie@example.com');

select * from mytable;

-- 创建简单存储过程
DELIMITER //
CREATE PROCEDURE myprocedure()
BEGIN
  SELECT * FROM mytable WHERE age > 30;
END //
DELIMITER ;

CALL myprocedure();

-- 创建简单视图
CREATE VIEW myview AS SELECT name, age FROM mytable WHERE age > 30;

SELECT * FROM myview;


-- 数据类型
-- 创建包含整数类型的数据表
CREATE TABLE mytable_INT (
  tinyint_col TINYINT,
  smallint_col SMALLINT,
  mediumint_col MEDIUMINT,
  int_col INT,
  bigint_col BIGINT,
  integer_col INTEGER
);

INSERT INTO mytable_INT 
(tinyint_col, smallint_col, mediumint_col, int_col, bigint_col, integer_col) VALUES
(1, 100, 10000, 1000000, 1000000000, 2147483647),
(2, 200, 20000, 2000000, 2000000000, -2147483648),
(3, 300, 30000, 3000000, 3000000000, 0);

SELECT * FROM mytable_INT;

-- 创建包含浮点数类型的数据表
CREATE TABLE mytable_FLOAT (
  float_col FLOAT,
  double_col DOUBLE,
  decimal_col DECIMAL(10,5),
  numeric_col NUMERIC(10,2)
);

INSERT INTO mytable_FLOAT (float_col, double_col, decimal_col, numeric_col) VALUES
(1.23, 1.234567890123456789, 1234.560000, 1234.56),
(2.34, 2.345678901234567890, 2345.670034, 2345.67),
(3.45, 3.456789012345678901, 3456.78000007, 3456.7832);

SELECT * FROM mytable_FLOAT;

-- 创建包含日期与时间类型的数据表
CREATE TABLE mytable_TIME (
  date_col DATE,
  time_col TIME,
  datetime_col DATETIME,
  timestamp_col TIMESTAMP,
  year_col YEAR
);

INSERT INTO mytable_TIME (date_col, time_col, datetime_col, timestamp_col, year_col) VALUES
('2022-01-01', '12:30:45', '2022-01-01 12:30:45', '2022-01-01 12:30:45', '2022'),
('2022-02-01', '13:30:45', '2022-02-01 13:30:45', '2022-02-01 13:30:45', '2022'),
('2022-03-01', '14:30:45', '2022-03-01 14:30:45', '2022-03-01 14:30:45', '2022');

SELECT * FROM mytable_TIME;

-- 创建包含字符串类型的数据表
CREATE TABLE mytable_string (
  id INT PRIMARY KEY,
  varchar_col VARCHAR(255),
  char_col CHAR(10),
  text_col TEXT,
  enum_col ENUM('value1', 'value2', 'value3'),
  set_col SET('option1', 'option2', 'option3')
);

INSERT INTO mytable_string (id, varchar_col, char_col, text_col, enum_col, set_col) VALUES
(1, 'Hello', 'World', 'This is a text', 'value1', 'option1,option2'),
(2, 'Foo', 'Bar', 'Another text', 'value2', 'option2'),
(3, 'Baz', 'Qux', 'Yet another text', 'value3', 'option1,option3');

select * from mytable_string;

-- 创建包含所有TEXT类型的数据表
CREATE TABLE mytable_TEXT (
  tinytext_col TINYTEXT,
  text_col TEXT,
  mediumtext_col MEDIUMTEXT,
  longtext_col LONGTEXT
);

INSERT INTO mytable_TEXT (tinytext_col, text_col, mediumtext_col, longtext_col) VALUES
('This is a tinytext', 'This is a text', 'This is a mediumtext', 'This is a longtext'),
('Another tinytext', 'Another text', 'Another mediumtext', 'Another longtext'),
('Yet another tinytext', 'Yet another text', 'Yet another mediumtext', 'Yet another longtext');

SELECT * FROM mytable_TEXT;

-- 创建包含所有BLOB类型的数据表
CREATE TABLE mytable_BLOB (
  tinyblob_col TINYBLOB,
  blob_col BLOB,
  mediumblob_col MEDIUMBLOB,
  longblob_col LONGBLOB
);

INSERT INTO mytable_BLOB (tinyblob_col, blob_col, mediumblob_col, longblob_col) VALUES
('This is a tinyblob', 'This is a blob', 'This is a mediumblob', 'This is a longblob'),
('Another tinyblob', 'Another blob', 'Another mediumblob', 'Another longblob'),
('Yet another tinyblob', 'Yet another blob', 'Yet another mediumblob', 'Yet another longblob');

SELECT * FROM mytable_BLOB;

-- 创建Enum类型、Set类型、Bit类型、JSON字段的数据表
CREATE TABLE mytable_enum (
  id INT NOT NULL AUTO_INCREMENT,
  name VARCHAR(50) NOT NULL,
  gender ENUM('male', 'female') NOT NULL,
  PRIMARY KEY (id)
);

CREATE TABLE mytable_set (
  id INT NOT NULL AUTO_INCREMENT,
  name VARCHAR(50) NOT NULL,
  interests SET('reading', 'music', 'sports', 'travel') NOT NULL,
  PRIMARY KEY (id)
);

CREATE TABLE mytable_bit (
  id INT NOT NULL AUTO_INCREMENT,
  name VARCHAR(50) NOT NULL,
  permissions BIT(4) NOT NULL,
  PRIMARY KEY (id)
);

CREATE TABLE mytable_json (
  id INT NOT NULL AUTO_INCREMENT,
  name VARCHAR(50) NOT NULL,
  data JSON NOT NULL,
  PRIMARY KEY (id)
);


INSERT INTO mytable_enum (name, gender) VALUES
('Alice', 'female'),
('Bob', 'male'),
('Charlie', 'male');

INSERT INTO mytable_set (name, interests) VALUES
('Alice', 'reading,music'),
('Bob', 'sports,travel'),
('Charlie', 'reading,music,sports,travel');

INSERT INTO mytable_bit (name, permissions) VALUES
('Alice', b'0001'),
('Bob', b'0010'),
('Charlie', b'0100');

INSERT INTO mytable_json (name, data) VALUES
('Alice', '{"age": 25, "email": "alice@example.com"}'),
('Bob', '{"age": 30, "email": "bob@example.com"}'),
('Charlie', '{"age": 35, "email": "charlie@example.com"}');


SELECT * FROM mytable_enum;
SELECT * FROM mytable_set;
SELECT * FROM mytable_bit;
SELECT * FROM mytable_json;


-- 其它约束：AUTO_INCREMENT约束、COMMENT约束、UNSIGNED约束、ZEROFILL约束、检查约束
CREATE TABLE mytable_constraint (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'Primary Key',
  name VARCHAR(50) NOT NULL COMMENT 'Not Null',
  age INT UNSIGNED NOT NULL COMMENT 'Not Null',
  email VARCHAR(50) NOT NULL UNIQUE COMMENT 'Unique',
  city VARCHAR(50) DEFAULT 'New York' COMMENT 'Default',
  country VARCHAR(50) COMMENT 'Foreign Key',
  salary INT UNSIGNED ZEROFILL COMMENT 'ZEROFILL',
  CONSTRAINT pk_mytable PRIMARY KEY (id),
  CONSTRAINT chk_mytable_age CHECK (age >= 18)
);

INSERT INTO mytable_constraint (name, age, email, country, salary) VALUES
('Alice', 25, 'alice@example.com', 'USA', 100000),
('Bob', 30, 'bob@example.com', 'Canada', 150000),
('Charlie', 35, 'charlie@example.com', 'UK', 200000);

SELECT * FROM mytable_constraint;

-- 其它数据类型：bit、geometrycollection、..、point、polygon
CREATE TABLE `z_gis` (
  `id` varchar(45) NOT NULL,
  `name` varchar(10) NOT NULL COMMENT '姓名',
  `gis` geometry NOT NULL COMMENT '空间位置信息',
  `geohash` varchar(20) GENERATED ALWAYS AS (st_geohash(`gis`,8)) VIRTUAL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`),
  SPATIAL KEY `idx_gis` (`gis`),
  KEY `idx_geohash` (`geohash`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='空间位置信息';

insert into z_gis(id,name,gis) values
(replace(uuid(),'-',''),'张三',ST_GeometryFromText('point(108.9498710632 34.2588125935)')),
(replace(uuid(),'-',''),'李四',ST_GeometryFromText('point(108.9465236664 34.2598766768)')),
(replace(uuid(),'-',''),'王五',ST_GeometryFromText('point(108.9477252960 34.2590342786)')),
(replace(uuid(),'-',''),'赵六',ST_GeometryFromText('point(108.9437770844 34.2553719653)')),
(replace(uuid(),'-',''),'小七',ST_GeometryFromText('point(108.9443349838 34.2595663206)')),
(replace(uuid(),'-',''),'孙八',ST_GeometryFromText('point(108.9473497868 34.2643456798)')),
(replace(uuid(),'-',''),'十九',ST_GeometryFromText('point(108.9530360699 34.2599476152)'));

select * from z_gis;

CREATE TABLE geom_01 (g GEOMETRY);

INSERT INTO geom_01 VALUES (ST_GeometryFromText('POINT(1 1)'));
INSERT INTO geom_01 VALUES (ST_GeometryFromText('LINESTRING(0 0,1 1,2 2)'));
SET @g = 'POLYGON((0 0,10 0,10 10,0 10,0 0),(5 5,7 5,7 7,5 7, 5 5))';
INSERT INTO geom_01 VALUES (ST_GeometryFromText(@g));

CREATE TABLE geom_02 (g GEOMCOLLECTION);
INSERT INTO geom_02 VALUES (ST_MPOINTFromText('MULTIPOINT (1 2, 2 4, 3 6, 4 8)'));
INSERT INTO geom_02 VALUES (ST_GeometryFromText('MultiLineString((1 1,2 2,3 3),(4 4,5 5))'));
SET @mpoly = 'MultiPolygon(((0 0,0 3,3 3,3 0,0 0),(1 1,1 2,2 2,2 1,1 1)))';
INSERT INTO geom_02 VALUES (ST_GeometryFromText(@mpoly));
SET @gc = 'GeometryCollection(Point(1 1),LineString(2 2, 3 3))';
INSERT INTO geom_02 VALUES (ST_GeomFromText(@gc));


-- 外键约束：包含CASCADE、RESTRICT、NO ACTION、SET DEFAULT和SET NULL级联外键
-- CASCADE级联外键
CREATE TABLE parent_01 (
  id INT PRIMARY KEY
);

CREATE TABLE child_01 (
  id INT PRIMARY KEY,
  parent_id INT,
  FOREIGN KEY (parent_id) REFERENCES parent_01(id) ON DELETE CASCADE
);

INSERT INTO parent_01 (id) VALUES (1);
INSERT INTO child_01 (id, parent_id) VALUES (1, 1);

-- 删除父表记录，子表记录也会被删除，返回空结果集
DELETE FROM parent_01 WHERE id = 1;
SELECT * FROM child_01; 


-- DISTRICT级联外键
CREATE TABLE parent_02 (
  id INT PRIMARY KEY
);

CREATE TABLE child_02 (
  id INT PRIMARY KEY,
  parent_id INT,
  FOREIGN KEY (parent_id) REFERENCES parent_02(id) ON DELETE RESTRICT
);

INSERT INTO parent_02 (id) VALUES (1);
INSERT INTO child_02 (id, parent_id) VALUES (1, 1);

-- 删除父表记录，会抛出外键约束错误
-- DELETE FROM parent_02 WHERE id = 1;

-- NO ACTION级联外键
-- foreign key constraints are checked immediately, so NO ACTION is the same as RESTRICT.
CREATE TABLE parent_03 (
  id INT PRIMARY KEY
);

CREATE TABLE child_03 (
  id INT PRIMARY KEY,
  parent_id INT,
  FOREIGN KEY (parent_id) REFERENCES parent_03(id) ON DELETE NO ACTION
);

INSERT INTO parent_03 (id) VALUES (1);
INSERT INTO child_03 (id, parent_id) VALUES (1, 1);

-- 删除父表记录，会抛出外键约束错误
-- DELETE FROM parent_03 WHERE id = 1;


-- SET DEFAULT级联外键
-- InnoDB and NDB reject table definitions containing ON DELETE SET DEFAULT clauses.
CREATE TABLE parent_04 (
  id INT PRIMARY KEY
);

CREATE TABLE child_04 (
  id INT PRIMARY KEY,
  parent_id INT,
  value INT DEFAULT 0,
  FOREIGN KEY (parent_id) REFERENCES parent_04(id) ON DELETE SET DEFAULT
);

INSERT INTO parent_04 (id) VALUES (1);
INSERT INTO child_04 (id, parent_id) VALUES (1, 1);
-- 删除父表记录，会抛出外键约束错误
-- delete from parent_04 WHERE id = 1;


-- SET NULL级联外键
CREATE TABLE parent_05 (
  id INT PRIMARY KEY
);

CREATE TABLE child_05 (
  id INT PRIMARY KEY,
  parent_id INT,
  value INT,
  FOREIGN KEY (parent_id) REFERENCES parent_05(id) ON DELETE SET NULL
);

INSERT INTO parent_05 (id) VALUES (1);
INSERT INTO child_05 (id, parent_id, value) VALUES (1, 1, 10);

-- 更新父表记录，子表记录的parent_id会被设置为NULL
delete from parent_05 WHERE id = 1;
SELECT * FROM child_05; -- 返回子表记录，parent_id为NULL


-- 存储过程：使用in、out和inout参数
DELIMITER //
CREATE PROCEDURE test_proc_inout(IN in_param INT, OUT out_param INT, INOUT inout_param INT)
BEGIN
  SET out_param = in_param * 2;
  SET inout_param = inout_param + 1;
  SELECT out_param, inout_param;
END //
DELIMITER ;

-- 定义变量来存储out参数和inout参数的值
SET @test_out_param = 0;
SET @test_inout_param = 20;

-- 调用存储过程，并将参数传递给它
CALL test_proc_inout(10, @test_out_param, @test_inout_param);

-- 创建数据表，并使用存储过程写入数据
CREATE TABLE task (id INT NOT NULL AUTO_INCREMENT, name varchar(25), createtime datetime NOT NULL, PRIMARY KEY (id));

DELIMITER //
CREATE PROCEDURE insert_100_records()
BEGIN
    DECLARE i INT DEFAULT 1;
    WHILE i <= 100 DO
        INSERT INTO task  (`name`, `createtime`) values ('hello world 292', now());
        SET i = i + 1;
    END WHILE;
END //
DELIMITER ;

call insert_100_records();

-- 函数:有参函数、无参函数
-- 创建一个有参函数，接受一个整数参数，返回该参数的平方
DELIMITER $$
CREATE FUNCTION test_square(x INT) RETURNS INT
BEGIN
    RETURN x * x;
END $$
DELIMITER ;

-- 调用有参函数
SELECT test_square(5); -- 返回25

-- 创建一个无参函数，返回一个字符串
DELIMITER $$
CREATE FUNCTION test_char() RETURNS Varchar(20)
BEGIN
    RETURN 'hello world';
END $$
DELIMITER ;

-- 调用无参函数
SELECT test_char();

show function status where DB ="test_DATA_PANLE";
show tables;
show procedure status where DB ="test_DATA_PANLE";


-- 编写预载数据：字符集、触发器、事件
drop database if exists test_utf8;
drop database if exists test_gbk;
drop database if exists test_lantin1;
drop database if exists test_acsii;
drop database if exists test_utf8mb4;
-- set global log_bin_trust_function_creators='ON';
-- set global event_scheduler = ON;

-- 字符集：utf8bm4字符集、gbk字符集、latin1字符集、ascii字符集、utf8字符集
-- utf8字符集
CREATE DATABASE test_utf8 CHARACTER SET utf8 COLLATE utf8_general_ci;

USE test_utf8;

CREATE TABLE mytable (
  id INT NOT NULL AUTO_INCREMENT,
  name VARCHAR(255) NOT NULL,
  PRIMARY KEY (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

INSERT INTO mytable (name) VALUES ('test_中文_utf8');
SELECT * FROM mytable;

-- gbk字符集
CREATE DATABASE test_gbk CHARACTER SET gbk COLLATE gbk_chinese_ci;

USE test_gbk;

CREATE TABLE mytable (
  id INT NOT NULL AUTO_INCREMENT,
  name VARCHAR(255) NOT NULL,
  PRIMARY KEY (id)
) ENGINE=InnoDB DEFAULT CHARSET=gbk COLLATE=gbk_chinese_ci;

INSERT INTO mytable (name) VALUES ('test_中文_gbk');
SELECT * FROM mytable;

-- latin1字符集
CREATE DATABASE test_lantin1 CHARACTER SET latin1 COLLATE latin1_swedish_ci;

USE test_lantin1;

CREATE TABLE mytable (
  id INT NOT NULL AUTO_INCREMENT,
  name VARCHAR(255) NOT NULL,
  PRIMARY KEY (id)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

INSERT INTO mytable (name) VALUES ('Hello World');
SELECT * FROM mytable;

-- ascii字符集
CREATE DATABASE test_acsii CHARACTER SET ascii COLLATE ascii_general_ci;

USE test_acsii;

CREATE TABLE mytable (
  id INT NOT NULL AUTO_INCREMENT,
  name VARCHAR(255) NOT NULL,
  PRIMARY KEY (id)
) ENGINE=InnoDB DEFAULT CHARSET=ascii COLLATE=ascii_general_ci;

INSERT INTO mytable (name) VALUES ('Hello World');
SELECT * FROM mytable;

-- utf8bm4字符集
CREATE DATABASE test_utf8mb4 CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

USE test_utf8mb4;

CREATE TABLE mytable_utf8mb4 (
  id INT NOT NULL AUTO_INCREMENT,
  name VARCHAR(255) NOT NULL,
  PRIMARY KEY (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO mytable_utf8mb4 (name) VALUES ('test_中文_utf8mb4');
SELECT * FROM mytable_utf8mb4;

-- 增量阶段默认数据表
CREATE TABLE test (
  id INT NOT NULL PRIMARY KEY COMMENT '用户id',
  name CHAR(255) COMMENT '用户姓名'
);

-- 数据表：字符集
CREATE TABLE mytable_acsii (
  id INT NOT NULL AUTO_INCREMENT,
  name VARCHAR(255) NOT NULL,
  PRIMARY KEY (id)
) ENGINE=InnoDB DEFAULT CHARSET=ascii COLLATE=ascii_general_ci;

INSERT INTO mytable_acsii (name) VALUES ('Hello World');
SELECT * FROM mytable_acsii;

CREATE TABLE mytable_lantin1 (
  id INT NOT NULL AUTO_INCREMENT,
  name VARCHAR(255) NOT NULL,
  PRIMARY KEY (id)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

INSERT INTO mytable_lantin1 (name) VALUES ('Hello World');
SELECT * FROM mytable_lantin1;

CREATE TABLE mytable_gbk (
  id INT NOT NULL AUTO_INCREMENT,
  name VARCHAR(255) NOT NULL,
  PRIMARY KEY (id)
) ENGINE=InnoDB DEFAULT CHARSET=gbk COLLATE=gbk_chinese_ci;

INSERT INTO mytable_gbk (name) VALUES ('test_中文_gbk');
SELECT * FROM mytable_gbk;

CREATE TABLE mytable_utf8 (
  id INT NOT NULL AUTO_INCREMENT,
  name VARCHAR(255) NOT NULL,
  PRIMARY KEY (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

INSERT INTO mytable_utf8 (name) VALUES ('test_中文_utf8');
SELECT * FROM mytable_utf8;


-- 触发器：数据库test_utf8mb4
-- 触发时机：BEFORE、AFTER；触发事件：INSERT、DELETE、UPDATE
CREATE TABLE account (acct_num INT, amount DECIMAL(10,2));
INSERT INTO account VALUES (137,14.98),(141,1937.50),(97,-100.00);

DELIMITER $$
CREATE TRIGGER upd_check BEFORE UPDATE ON account
FOR EACH ROW
BEGIN
IF NEW.amount < 0 THEN
  SET NEW.amount = 0;
ELSEIF NEW.amount > 100 THEN
  SET NEW.amount = 100;
END IF;
END $$
DELIMITER ;

update account set amount=-10 where acct_num=137;
update account set amount=200 where acct_num=97;
select * from account;

-- 触发事件：INSERT、DELETE、UPDATE
CREATE TABLE customers (
  customer_id BIGINT PRIMARY KEY, 
  customer_name VARCHAR(50), 
  level VARCHAR(50)
) ENGINE=INNODB;

INSERT INTO customers VALUES 
('1','Jack Ma','BASIC'),('2','Robin Li','BASIC'),('3','Pony Ma','VIP');

CREATE TABLE customer_status(
  customer_id BIGINT PRIMARY KEY, 
  status_notes VARCHAR(50)
) ENGINE=INNODB;

CREATE TABLE sales(
  sales_id BIGINT PRIMARY KEY,
  customer_id BIGINT,
  sales_amount DOUBLE
) ENGINE=INNODB;

CREATE TABLE audit_log(
  log_id BIGINT PRIMARY KEY AUTO_INCREMENT, 
  sales_id BIGINT, previous_amount DOUBLE, 
  new_amount DOUBLE, updated_by VARCHAR(50), 
  updated_on DATETIME 
) ENGINE=INNODB;

DELIMITER //
CREATE TRIGGER validate_sales_amount
BEFORE INSERT
ON sales
FOR EACH ROW
IF NEW.sales_amount>10000 THEN
SIGNAL SQLSTATE '45000'
SET MESSAGE_TEXT = "你输入的销售总额超过 10000 元。";
END IF//
DELIMITER ;

insert into sales(sales_id, customer_id, sales_amount) values ('1','1','9000');

DELIMITER //
CREATE TRIGGER customer_status_records
AFTER INSERT
ON customers
FOR EACH ROW
Insert into customer_status(customer_id, status_notes) VALUES
(NEW.customer_id, '账户创建成功')//
DELIMITER ;

insert into customers (customer_id, customer_name, level ) values ('4','Xing Wang','VIP');

DELIMITER //
CREATE TRIGGER log_sales_updates
AFTER UPDATE
ON sales
FOR EACH ROW
Insert into audit_log(sales_id, previous_amount, new_amount, updated_by, updated_on) VALUES
(NEW.sales_id,OLD.sales_amount, NEW.sales_amount,(SELECT USER()), NOW() )//
DELIMITER ;

insert into sales(sales_id, customer_id, sales_amount) values('5', '2','8000');
Update sales set sales_amount='9000' where sales_id='5';

DELIMITER //
CREATE TRIGGER validate_related_records
BEFORE DELETE
ON customers
FOR EACH ROW
IF OLD.level='VIP' THEN
  SIGNAL SQLSTATE '01000'
  SET MESSAGE_TEXT = 'VIP 级别客户销售记录谨慎删除';
END IF//
DELIMITER ;

delete from customers where customer_id='3';

DELIMITER //
CREATE TRIGGER delete_related_info
AFTER DELETE
ON sales
FOR EACH ROW
Delete from customers where customer_id=OLD.customer_id;//
DELIMITER ;

delete from customers where customer_id='2';

select * from customers;
select * from customer_status;
select * from sales;
select * from audit_log;


-- 视图
-- ALGORITHM=UNDEFINED DEFINER=`root`@`localhost`
CREATE VIEW view_custom_sale as 
(select customers.customer_id,customers.customer_name,sales.sales_id,sales.sales_amount
from customers left join sales on customers.customer_id=sales.customer_id);

insert into sales(sales_id, customer_id, sales_amount) values('2','1','4500');
insert into sales(sales_id, customer_id, sales_amount) values('3','3','6000');

-- ALGORITHM = MERGE\DEFINER=`rootgg`@`%`\ SQL SECURITY DEFINER
CREATE ALGORITHM=MERGE SQL SECURITY DEFINER VIEW view_customers
as (select * from customers where customer_name='Jack Ma') WITH CHECK OPTION;

-- 默认：ALGORITHM=UNDEFINED
CREATE ALGORITHM=UNDEFINED VIEW view_audit_log as 
(select * from audit_log where log_id < 4) WITH CHECK OPTION;

insert into customers (customer_id, customer_name, level) values ('5','CEHNG WENYU','VIP');
insert into sales(sales_id, customer_id, sales_amount) values('6', '5','8000');
Update sales set sales_amount='7000' where sales_id='6';
Update sales set sales_amount='6000' where sales_id='6';
Update sales set sales_amount='8000' where sales_id='6';

-- 嵌套视图
CREATE VIEW view_nested as 
(select * from view_audit_log where sales_id = 6) WITH CASCADED CHECK OPTION;

-- 临时视图
CREATE ALGORITHM=UNDEFINED VIEW view_auditlog_temp as 
(select * from audit_log where log_id < 10) WITH CHECK OPTION;

select * from view_custom_sale;
select * from view_customers;
select * from view_audit_log;
select * from view_nested;
select * from view_auditlog_temp;


-- 事件
drop table if exists events_list;  

create table events_list(event_name varchar(20) not null, event_started timestamp not null);

create event event_now 
on schedule at now() ON COMPLETION PRESERVE ENABLE
do insert into events_list values('event_now', now());

create event event_hour
on schedule every 1 hour STARTS '2022-04-01 02:00:00'
ON COMPLETION PRESERVE ENABLE
do insert into events_list values('event_hour', now());

create event event_day
on schedule every 1 day STARTS '2022-04-01 02:00:00'
ON COMPLETION PRESERVE ENABLE
do insert into events_list values('event_day', now());

DELIMITER //
CREATE EVENT check_data_table
ON SCHEDULE EVERY 1 DAY STARTS '2022-04-01 02:00:00'
ON COMPLETION PRESERVE ENABLE
DO
  BEGIN
    DECLARE data_count INT;
    SELECT COUNT(*) INTO data_count FROM events_list;
    IF data_count > 100 THEN
      DELETE FROM events_list ORDER BY id LIMIT 30;
    END IF;
  END//
DELIMITER ;

select * from events_list;
show events where Db ="test_utf8mb4";
show table status where comment='view';


-- 分区表
-- 库表恢复分区表测试
Drop database if exists db_partition;
create database db_partition;
use db_partition;


-- 创建 range 分区表
CREATE TABLE range_partitioned_table (
    id INT,
    data VARCHAR(100),
    createtime TIMESTAMP DEFAULT current_timestamp
)
PARTITION BY RANGE (id) (
    PARTITION p0 VALUES LESS THAN (100),
    PARTITION p1 VALUES LESS THAN (200),
    PARTITION p2 VALUES LESS THAN (300)
);
ALTER TABLE range_partitioned_table ANALYZE PARTITION p1;


-- 创建 list 分区表
CREATE TABLE list_partitioned_table (
    id INT,
    data VARCHAR(100),
    createtime TIMESTAMP DEFAULT current_timestamp
)
PARTITION BY LIST (id) (
    PARTITION p0 VALUES IN (1, 2, 3),
    PARTITION p1 VALUES IN (4, 5, 6),
    PARTITION p2 VALUES IN (7, 8, 9)
);

-- 创建 hash 分区表
CREATE TABLE hash_partitioned_table (
    id INT,
    data VARCHAR(100),
    createtime TIMESTAMP DEFAULT current_timestamp
)
PARTITION BY HASH (id)
PARTITIONS 4;

-- 创建 key 分区表
CREATE TABLE key_partitioned_table (
    id INT,
    data VARCHAR(100),
    createtime TIMESTAMP DEFAULT current_timestamp
)
PARTITION BY KEY (id)
PARTITIONS 4;

-- 创建 column 分区表
CREATE TABLE column_partitioned_table (
    id INT,
    data VARCHAR(100),
    createtime TIMESTAMP DEFAULT current_timestamp
)
PARTITION BY RANGE COLUMNS (id)(
    PARTITION p0 VALUES LESS THAN (100),
    PARTITION p1 VALUES LESS THAN (200),
    PARTITION p2 VALUES LESS THAN (300)
);

-- 创建子分区表（组合分区）
CREATE TABLE t_partition (id INT, name VARCHAR(50), purchased DATE)
    PARTITION BY RANGE( YEAR(purchased) )
    SUBPARTITION BY HASH( TO_DAYS(purchased) ) (
        PARTITION p0 VALUES LESS THAN (1990) (
            SUBPARTITION s0,
            SUBPARTITION s1
        ),
        PARTITION p1 VALUES LESS THAN (2000) (
            SUBPARTITION s2,
            SUBPARTITION s3
        ),
        PARTITION p2 VALUES LESS THAN MAXVALUE (
            SUBPARTITION s4,
            SUBPARTITION s5
        )
    );
INSERT INTO `t_partition` VALUES
 (1, 'desk organiser', '2003-10-15'),
 (2, 'alarm clock', '1997-11-05'),
 (3, 'chair', '2009-03-10'),
 (4, 'bookcase', '1989-01-10'),
 (5, 'exercise bike', '2008-05-09'),
 (6, 'sofa', '1987-06-05'),
 (7, 'espresso maker', '2011-11-22'),
 (8, 'aquarium', '1992-08-04'),
 (9, 'study desk', '2006-09-16'),
 (10, 'lava lamp', '1998-11-25');

CREATE TABLE `t_partition2` (
    id INT,
    year_col INT
)
PARTITION BY RANGE (year_col) (
    PARTITION p0 VALUES LESS THAN (1991),
    PARTITION p1 VALUES LESS THAN (1995),
    PARTITION p2 VALUES LESS THAN (1999)
);
ALTER TABLE `t_partition2` ADD PARTITION (PARTITION p3 VALUES LESS THAN (2002));
ALTER TABLE `t_partition2` DROP PARTITION p0, p1;
ALTER TABLE `t_partition2` TRUNCATE PARTITION p2, p3;
insert into `t_partition2` values (1, 1900),(2, 1996);

CREATE TABLE `t_partition3` (
    name VARCHAR (30),
    started DATE
)
PARTITION BY HASH( YEAR(started) )
PARTITIONS 6;
ALTER TABLE `t_partition3` COALESCE PARTITION 2;

CREATE TABLE `t_partition4` (
    id INT,
    year_col INT
)
PARTITION BY RANGE (year_col) (
    PARTITION p0 VALUES LESS THAN (1991),
    PARTITION p1 VALUES LESS THAN (1995),
    PARTITION p2 VALUES LESS THAN (1999),
    PARTITION p3 VALUES LESS THAN (2000)
);
ALTER TABLE `t_partition4` REORGANIZE PARTITION p0,p1,p2,p3 INTO (
    PARTITION m0 VALUES LESS THAN (1980),
    PARTITION m1 VALUES LESS THAN (2000)
);
insert into `t_partition4` values (1, 1900),(2, 1996);

CREATE TABLE `分区表#` (
    id INT,
    year_col INT
)
PARTITION BY RANGE (year_col) (
    PARTITION p0 VALUES LESS THAN (1991),
    PARTITION p1 VALUES LESS THAN (1995),
    PARTITION p2 VALUES LESS THAN (1999),
    PARTITION p3 VALUES LESS THAN (2000)
);
ALTER TABLE `分区表#` REORGANIZE PARTITION p0,p1,p2,p3 INTO (
    PARTITION m0 VALUES LESS THAN (1980),
    PARTITION m1 VALUES LESS THAN (2000)
);
insert into `分区表#` values (1, 1900),(2, 1996);

-- 特殊字符
CREATE TABLE `±í¸ñ` (`×Ö¶ÎÒ»` CHAR(5)) DEFAULT CHARSET = gb18030;

insert into `±í¸ñ` values ('xsxs');
ALTER TABLE `±í¸ñ` ADD `ÐÂ×Ö¶ÎÒ»` CHAR(1) FIRST;
ALTER TABLE `±í¸ñ` ADD `ÐÂ×Ö¶Î¶þ` CHAR(1) AFTER `×Ö¶ÎÒ»`;
ALTER TABLE `±í¸ñ` ADD `ÐÂ×Ö¶ÎÈý` CHAR(1);
ALTER TABLE `±í¸ñ` ADD INDEX (`ÐÂ×Ö¶Î¶þ`);
ALTER TABLE `±í¸ñ` ADD PRIMARY KEY (`×Ö¶ÎÒ»`);
ALTER TABLE `±í¸ñ` ADD UNIQUE (`ÐÂ×Ö¶ÎÈý`);
ALTER TABLE `±í¸ñ` CHANGE `ÐÂ×Ö¶Î¶þ` `<82>3<95>2<82>3<95>2Ò»` CHAR(1);
ALTER TABLE `±í¸ñ` MODIFY `ÐÂ×Ö¶ÎÈý` CHAR(6);
insert into `±í¸ñ` values ('s', 'xsx', 's', 'xsaxs');

-- 向 range 分区表插入数据
INSERT INTO range_partitioned_table (id, data) VALUES (50, 'Data in p0');
INSERT INTO range_partitioned_table (id, data) VALUES (150, 'Data in p1');
INSERT INTO range_partitioned_table (id, data) VALUES (250, 'Data in p2');

-- 向 list 分区表插入数据
INSERT INTO list_partitioned_table (id, data) VALUES (1, 'Data in p0');
INSERT INTO list_partitioned_table (id, data) VALUES (4, 'Data in p1');
INSERT INTO list_partitioned_table (id, data) VALUES (8, 'Data in p2');

-- 向 hash 分区表插入数据
INSERT INTO hash_partitioned_table (id, data) VALUES (10, 'Data in partition 2');
INSERT INTO hash_partitioned_table (id, data) VALUES (20, 'Data in partition 0');
INSERT INTO hash_partitioned_table (id, data) VALUES (13, 'Data in partition 1');
INSERT INTO hash_partitioned_table (id, data) VALUES (15, 'Data in partition 3');

-- 向 key 分区表插入数据
INSERT INTO key_partitioned_table (id, data) VALUES (100, 'Data in partition 1');
INSERT INTO key_partitioned_table (id, data) VALUES (200, 'Data in partition 0');
INSERT INTO key_partitioned_table (id, data) VALUES (300, 'Data in partition 1');

-- 向 column 分区表插入数据
INSERT INTO column_partitioned_table (id, data) VALUES (50, 'Data in p0');
INSERT INTO column_partitioned_table (id, data) VALUES (150, 'Data in p1');
INSERT INTO column_partitioned_table (id, data) VALUES (250, 'Data in p2');


SELECT PARTITION_NAME FROM INFORMATION_SCHEMA.PARTITIONS WHERE TABLE_SCHEMA = 'db_partition' AND TABLE_NAME = 'column_partitioned_table';
SELECT * FROM column_partitioned_table PARTITION (p0);

CREATE TABLE t1 (
    id INT,
    year_col INT
);
-- 普通表转换为分区表
alter table t1 PARTITION BY RANGE (year_col) (
    PARTITION p0 VALUES LESS THAN (1991),
    PARTITION p1 VALUES LESS THAN (1995),
    PARTITION p2 VALUES LESS THAN (1999)
);
insert into t1 value (0, 1990);
insert into t1 value (1, 1994);
insert into t1 value (2, 1997);
-- 添加分区
ALTER TABLE t1 ADD PARTITION (PARTITION p3 VALUES LESS THAN (2002));
insert into t1 value (3, 2000);
-- 分析与检查分区
ALTER TABLE t1 ANALYZE PARTITION p1, p2;
ALTER TABLE t1 CHECK PARTITION p3;
-- 修复被破坏的分区
ALTER TABLE t1 REPAIR PARTITION p0,p1;
-- 用于回收空闲空间和分区的碎片整理
ALTER TABLE t1 OPTIMIZE PARTITION p0, p1;
-- 重建分区
ALTER TABLE t1 REBUILD PARTITION p2, p3;
-- 迁移分区
ALTER TABLE t1 DISCARD PARTITION p3 TABLESPACE;
-- ALTER TABLE t1 IMPORT PARTITION p3 TABLESPACE;
ALTER TABLE t1 DROP PARTITION p3;

CREATE TABLE t2 (
    id INT,
    year_col INT
);
insert into t2 value (2, 1998);
-- 分区交换
ALTER TABLE t1 EXCHANGE PARTITION p2 WITH TABLE t2;

-- test_mig
drop database if exists test_cwy;
create database test_cwy;
use test_cwy;

create table test(`id` int NOT NULL AUTO_INCREMENT PRIMARY KEY, `date` DATE NOT NULL, `sess_id` varchar(50) DEFAULT NULL, `keyword` varchar(50) NOT NULL UNIQUE KEY,`url_n` varchar(255) DEFAULT NULL)ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb3 ROW_FORMAT=COMPACT;

drop table if exists task;
create table task(id INT NOT NULL AUTO_INCREMENT, name varchar(25), createtime datetime NOT NULL, PRIMARY KEY (id));
CREATE EVENT `task_event` ON SCHEDULE EVERY 2 SECOND STARTS '2023-04-21 19:52:55' ON COMPLETION PRESERVE ENABLE DO insert into `task` (`name`, `createtime`) values ('hello world', now());
DELIMITER //
CREATE EVENT check_data_task
ON SCHEDULE EVERY 10 minute STARTS '2022-04-01 02:00:00'
ON COMPLETION PRESERVE ENABLE
DO
  BEGIN
    DECLARE task_count INT;
    SELECT COUNT(*) INTO task_count FROM task;
    IF task_count > 500 THEN
      DELETE FROM task  LIMIT 360;
    END IF;
  END//
DELIMITER ;

