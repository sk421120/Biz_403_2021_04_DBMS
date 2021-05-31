-- 관리자
SHOW databases;
use mysql;

CREATE DATABASE todoList;
use todoList;

CREATE USER tdUser@localhost;
DESC USER;

SHOW GRANTS FOR tdUser@localhost;
SHOW GRANTS FOR tdUser@'192.168.0.%';
GRANT all privileges on *.* TO tdUser@localhost;

CREATE USER tdUser@'192.168.0.%';
GRANT ALL privileges ON *.* TO 'tdUser'@'192.168.0.%';

ALTER USER 'tdUser'@'localhost'
identified WITH mysql_native_password BY '12345';
flush privileges;

SELECT * FROM USER WHERE User='tdUser';