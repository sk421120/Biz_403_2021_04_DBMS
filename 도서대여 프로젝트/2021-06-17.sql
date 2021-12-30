show databases;

use bookrent;
show tables;

-- drop table tbl_memeber;

create table tbl_member (
mb_username	VARCHAR(20)		PRIMARY KEY,
mb_password	VARCHAR(10)	NOT NULL	,
mb_name	VARCHAR(20)	NOT NULL	,
mb_nname	VARCHAR(20)	NOT NULL,	
mb_email	VARCHAR(50)		,
mb_tel	CHAR(13)		,
mb_addr	VARCHAR(125)	,	
mb_expire	BOOLEAN		
);

desc tbl_member;