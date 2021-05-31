
use todolist;

use guestbook;

create table tbl_todolist (
td_seq	BIGINT	AUTO_INCREMENT	PRIMARY KEY,
td_sdate	VARCHAR(10)	NOT NULL	,
td_stime	VARCHAR(10)	NOT NULL	,
td_doit	VARCHAR(300)	NOT NULL	,
td_edate	VARCHAR(10)	DEFAULT''	,
td_etime	VARCHAR(10)	DEFAULT''	
);

DESC tbl_todolist;

select * from tbl_todolist;

show tables;

show databases;