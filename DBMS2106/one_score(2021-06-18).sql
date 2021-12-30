-- oneday_score

use oneday_score;

create table tbl_student (
st_num	CHAR(8)		PRIMARY KEY,
st_name	VARCHAR(20)	NOT NULL	,
st_dept	VARCHAR(20)	NOT NULL	,
st_grade	INT	NOT NULL	,
st_tel	VARCHAR(15)	NOT NULL	,
st_addr	VARCHAR(125)		
);

create table tbl_score (
sc_seq	CHAR(8)		PRIMARY KEY,
sc_stnum	CHAR(8)	NOT NULL	,
sc_subject	VARCHAR(20)	NOT NULL,	
sc_score	INT	NOT NULL	
);

desc tbl_student;
desc tbl_score;