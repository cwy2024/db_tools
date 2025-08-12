# code for cwy

# 1. 快速创建数据库 + 数据表
# 创建数据库
cursor.executeCmd("""DELIMITER $$
                CREATE PROCEDURE create_databases()
                BEGIN
                DECLARE i INT DEFAULT 1001;
                WHILE i < 5001 DO
                SET @db_name = CONCAT('test_db_', i);
                SET @sql = CONCAT('CREATE DATABASE ', @db_name);
                PREPARE stmt FROM @sql;
                EXECUTE stmt;
                DEALLOCATE PREPARE stmt;
                SET i = i + 1;
                END WHILE;
                END$$
                DELIMITER ;
                CALL create_databases();""")
# 删除数据库
cursor.executeCmd("""DELIMITER $$
                CREATE PROCEDURE delete_databases()
                BEGIN
                DECLARE i INT DEFAULT 0;
                WHILE i < 1000 DO
                SET @db_name = CONCAT('test_db_', i);
                SET @sql = CONCAT('DROP DATABASE ', @db_name);
                PREPARE stmt FROM @sql;
                EXECUTE stmt;
                DEALLOCATE PREPARE stmt;
                SET i = i + 1;
                END WHILE;
                END$$
                DELIMITER ;
                CALL delete_databases();""")
				
# 给各个数据库创建一张数据表，结合上述创建数据库使用
DELIMITER $$
CREATE PROCEDURE create_tables()
BEGIN
    DECLARE i INT DEFAULT 1001;
    SET autocommit = 0;
    
    START TRANSACTION;
    
    WHILE i < 5001 DO
        SET @db_name = CONCAT('test_db_', i);
        SET @sql1 = CONCAT('CREATE TABLE ', @db_name, '.t1 (a INT, b INT)');
        SET @sql2 = CONCAT('INSERT INTO ', @db_name, '.t1 VALUES (1, 2)');
        
        PREPARE stmt1 FROM @sql1;
        EXECUTE stmt1;
        DEALLOCATE PREPARE stmt1;
        
        PREPARE stmt2 FROM @sql2;
        EXECUTE stmt2;
        DEALLOCATE PREPARE stmt2;
        
        SET i = i + 1;
    END WHILE;
    
    COMMIT;
    SET autocommit = 1;
    
END$$
DELIMITER ;
CALL create_tables();


# 给指定数据库创建指定张表
sysbench --db-driver=mysql --mysql-host=${mysql_host} --mysql-port=3306 --mysql-user=test_user --mysql-password=Admin@123 --mysql-db=sbtest --table_size=100 --tables=5010 --events=0 --time=600 --threads=32 oltp_read_write prepare


# 写入数据
DELIMITER $$
CREATE PROCEDURE insert_data()
BEGIN
    DECLARE i INT DEFAULT 0;
    SET autocommit = 0;
    START TRANSACTION;
    
	SET @db_name = "test_db";
    SET @sql1 = CONCAT('CREATE TABLE ', @db_name, '.task (id INT NOT NULL AUTO_INCREMENT, name varchar(25), createtime datetime NOT NULL, PRIMARY KEY (id));');
	PREPARE stmt1 FROM @sql1;
    EXECUTE stmt1;
    DEALLOCATE PREPARE stmt1;
    
    WHILE i < 100 DO
        SET @sql2 = CONCAT('INSERT INTO ', @db_name, '.task (`name`, `createtime`) values (\'hello world 292\', now())');
        
        PREPARE stmt2 FROM @sql2;
        EXECUTE stmt2;
        DEALLOCATE PREPARE stmt2;
        
        SET i = i + 1;
    END WHILE;
    
    COMMIT;
    SET autocommit = 1;
    
END$$
DELIMITER ;
CALL insert_data();


DELIMITER $$
CREATE PROCEDURE insert_data()
BEGIN
	SET @db_name = "test_db";
    SET @sql1 = CONCAT('CREATE TABLE ', @db_name, '.task2 (id INT NOT NULL AUTO_INCREMENT, name varchar(25), createtime datetime NOT NULL, PRIMARY KEY (id));');
	PREPARE stmt1 FROM @sql1;
    EXECUTE stmt1;
    DEALLOCATE PREPARE stmt1;
	
	DECLARE i INT DEFAULT 0;
    SET autocommit = 0;
    START TRANSACTION;
    
    WHILE i < 100 DO
        SET @sql2 = CONCAT('INSERT INTO ', @db_name, '.task2 (`name`, `createtime`) values (\'hello world 292\', now())');
        
        PREPARE stmt2 FROM @sql2;
        EXECUTE stmt2;
        DEALLOCATE PREPARE stmt2;
        
        SET i = i + 1;
    END WHILE;
    
    COMMIT;
    SET autocommit = 1;
    
END$$
DELIMITER ;


# 2. 快速检查数据库表恢复一致性

#!/bin/bash
mysql_host=""

tables=("column_partitioned_table"
"hash_partitioned_table"
"key_partitioned_table"
"list_partitioned_table"
"range_partitioned_table"
"t_partition"
"t_partition3"
"t_partition4"
"±í¸ñ")


for table in "${tables[@]}"
do
mysql -h${mysql_host} -P3306 -utest_user -pAdmin@123 -D db_partition -e "show create table $table;" >> nohup.out 
# mysql -h${mysql_host} -P3306 -utest_user -pAdmin@123 -D db_partition -e "select * from $table;" >> nohup.out 
mysql -h${mysql_host} -P3306 -utest_user -pAdmin@123 -D db_partition_bak -e "show create table $table;"  >> nohup_bak.out 
done



# dts_data_panle
"child_01"
"child_02"
"child_03"
"child_04"
"child_05"
"geom_01"
"geom_02"
"mytable"
"mytable_bit"
"mytable_blob"
"mytable_constraint"
"mytable_enum"
"mytable_float"
"mytable_int"
"mytable_json"
"mytable_set"
"mytable_string"
"mytable_text"
"mytable_time"
"myview"
"parent_01"
"parent_02"
"parent_03"
"parent_04"
"parent_05"
"test"
"z_gis"




# 创建千库千表场景
#!/bin/bash

mysql_host=""
table_size=200
tables=2

echo "start test run at"`date "+%Y-%m-%d %H:%M:%S"` > syxtest.out
for ((i=0;i<1000;i++));
do
echo "create database sxytest_$i" >> syxtest.out
mysql -h${mysql_host} -P3306 -utest_user -pAdmin@123 -e "create database sxytest_$i" 
sysbench --db-driver=mysql --mysql-host=${mysql_host} --mysql-port=3306 --mysql-user=test_user --mysql-password=Admin@123 --mysql-db=sxytest_$i --table_size=${table_size} --tables=${tables} --events=0 --time=600 --threads=${th}  oltp_read_write prepare
echo "sxytest_$i prepare done" >> syxtest.out
done

echo "the end_time is"`date "+%Y-%m-%d %H:%M:%S"` >> syxtest.out


# bolb场景 
#!/usr/bin/python
# -*- coding: UTF-8 -*-
import threading
import MySQLdb
import time
BLOB_ARRAY=[
  "a" * 32768,
  "b" * 32768,
  "c" * 32768,
  "d" * 32768,
  "e" * 32768,
  "f" * 32768,
  "g" * 32768,
  "h" * 32768,
]
TEST_TABLE_COUNT = 10
TEST_TABLE_SIZE = 8000000
TEST_HOST=""
TEST_USER="test_user"
TEST_PASSWD="Admin@123"
TEST_DB_NAME="test_db"
TEST_PORT=3306
BATCH_SIZE = 100
def import_data(table_id, row_count):
  conn = MySQLdb.connect(host=TEST_HOST, user=TEST_USER, passwd=TEST_PASSWD, db=TEST_DB_NAME, port=TEST_PORT)
  cursor = conn.cursor()
  table_name = "t" + str(table_id % 10 + 1)
  if table_id <= 10:
    sql = "CREATE TABLE " + TEST_DB_NAME + "." + table_name + " (id BIGINT PRIMARY KEY AUTO_INCREMENT, data BLOB);"
    print("sql=" + sql)
    cursor.execute(sql)
  finish_count = 0
  while (finish_count < row_count):
    sql = "INSERT INTO " + TEST_DB_NAME + "." + table_name + " (data) VALUES "
    for i in range(finish_count, finish_count + BATCH_SIZE):
      sql = sql + " (\'" + str(BLOB_ARRAY[i % 8]) + "\')"
      if i != finish_count + BATCH_SIZE - 1:
        sql += ","
    sql += ";"
    # print("sql=" + sql)
    cursor.execute(sql)
    conn.commit()
    finish_count += BATCH_SIZE
    print("progress: " + table_name + " insert " + str(finish_count) + " rows")
    #time.sleep(5)
  conn.close()
threads=[]
try:
  for i in range(1, TEST_TABLE_COUNT + 1):
    print("start thread: " + str(i))
    t = threading.Thread(target=import_data, args=(i, TEST_TABLE_SIZE))
    t.start()
    threads.append(t)
except Exception as ex:
  print "create thread error" + str(ex)
for t in threads:
    t.join()
	
	

# awk
cat API.json | grep Action | awk '{print $2}'



# 定时创删索引
create table task2(id INT NOT NULL AUTO_INCREMENT, name varchar(25), createtime datetime NOT NULL, PRIMARY KEY (id));

DELIMITER //
CREATE EVENT `add_delete_index_sbtest2`
ON SCHEDULE EVERY 5 minute STARTS '2022-04-01 02:00:00'
ON COMPLETION PRESERVE ENABLE
DO
BEGIN
insert into `task2` (`name`, `createtime`) values ('start create index', now());
ALTER TABLE sbtest2 ADD INDEX temp_key_2 (pad,c);
insert into `task2` (`name`, `createtime`) values ('end create index', now());
select SLEEP(30);
insert into `task2` (`name`, `createtime`) values ('start drop index', now());
ALTER TABLE sbtest2 DROP INDEX temp_key_2;
insert into `task2` (`name`, `createtime`) values ('end drop index', now());
END//
DELIMITER ;




# 重命名数据库

DELIMITER $$
CREATE PROCEDURE rename_tables()
BEGIN
DECLARE i INT DEFAULT 3;
WHILE i < 100 DO
SET @table_name = CONCAT('sbtest', i);
SET @sql = CONCAT('RENAME TABLE polardb_middle.', @table_name, ' to polardb_large.', @table_name);
PREPARE stmt FROM @sql;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;
SET i = i + 1;
END WHILE;
END$$
DELIMITER ;
CALL rename_tables();



# 大事务

CREATE TABLE `apple_test` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `a` int(11) NOT NULL DEFAULT '0' COMMENT 'a',
  `b` int(11) NOT NULL DEFAULT '0' COMMENT 'b',
  `updated_ts` timestamp(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6) ON UPDATE CURRENT_TIMESTAMP(6),
  `created_ts` timestamp(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6) COMMENT '创建时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

insert into apple_test(`a`, `b`) values(1,1);

#!/bin/bash

host=''
user_name='rootgg'
pwd='Admin@1234'
port='3306'
db='dts_utf8mb4'

for i in {1..12}
do
  mysql -h${host} -P${port} -u${user_name} -p${pwd} -D ${db} -e "insert into apple_test(a, b) select a,b from apple_test;"
  echo "执行语句成功${i}"
done



# 数据转冷
# 写入数据
DELIMITER $$
CREATE PROCEDURE convert_cold()
BEGIN
    DECLARE i INT DEFAULT 2;
    SET autocommit = 0;
    
    START TRANSACTION;
    
    WHILE i < 101 DO
        SET @db_name = CONCAT('sbtest', i);
        SET @sql1 = CONCAT('alter table ', @db_name, ' comment="storage_policy=cold"');
        
        PREPARE stmt1 FROM @sql1;
        EXECUTE stmt1;
        DEALLOCATE PREPARE stmt1;
        
        SET i = i + 1;
    END WHILE;
    
    COMMIT;
    SET autocommit = 1;
    
END$$
DELIMITER ;
CALL convert_cold();



# sql kill脚本数据写入
#!/bin/bash

# 随机字符串生成函数
generate_random_string() {
    # 生成一个长度为 1000 的随机字符串
    tr -dc 'a-zA-Z0-9' < /dev/urandom | head -c 1000
}

CONDITION="'31451373586-15688153734-79729593694-96509299839-83724898275-86711833539-78981337422-35049690573-51724173961-87474696253', '21472970079-70972780322-70018558993-71769650003-09270326047-32417012031-10768856803-14235120402-93989080412-18690312264'"

# 设置需要生成的随机字符串数量
N=64  # 你可以根据需要调整这个值

for ((i=1; i<=N; i++)); do
        RANDOM_STRING=$(generate_random_string)
        CONDITION="${CONDITION}, '${RANDOM_STRING}'"
done

#echo "${CONDITION}" 

query_sql="select id , k,(CASE WHEN id IS NOT NULL THEN SLEEP(100) END) AS delay from sbtest1 where id in (1,2,3) and c in ("${CONDITION}");"

M=1 # 拉起M个进程执行慢SQL语句
for ((i=1; i<=M; i++)); do
        echo ${query_sql} > outnew_${i}.sql
done

for ((i=1; i<=M; i++)); do
        nohup mysql -h${host} -P3306 -utest_user -pAdmin@123 -Dsbtest_cwy -e "source ./outnew_${i}.sql" > nohupnew_${i}.out 2>&1 &
done



# tpch脚本
#!/usr/bin/env bash
host=""
port="3306"
user="test_user"
password="Admin@123"
database="tpch_3g"
resfile="result_tpch3g_query"
echo "start test run at"`date "+%Y-%m-%d %H:%M:%S"`|tee -a ${resfile}.out
for (( i=2; i<=3;i=i+1 ))
do
queryfile="/home/software/TPC-H_V3.0.1/Ali_Qsql/Q"${i}".sql"
start_time=`date "+%s.%N"`
echo "run query ${i}"|tee -a ${resfile}.out
mysql -h ${host}  -P${port} -u${user} -p${password} $database -e "source $queryfile;" |tee -a ${resfile}.out
end_time=`date "+%s.%N"`
start_s=${start_time%.*}
start_nanos=${start_time#*.}
end_s=${end_time%.*}
end_nanos=${end_time#*.}
if [ "$end_nanos" -lt "$start_nanos" ];then
        end_s=$(( 10#$end_s -1 ))
        end_nanos=$(( 10#$end_nanos + 10 ** 9))
fi
time=$(( 10#$end_s - 10#$start_s )).`printf "%03d\n" $(( (10#$end_nanos - 10#$start_nanos)/10**6 ))`
echo ${queryfile} "the "${j}" run cost "${time}" second start at"`date -d @$start_time "+%Y-%m-%d %H:%M:%S"`" stop at"`date -d @$end_time "+%Y-%m-%d %H:%M:%S"` >> ${resfile}.time
done
