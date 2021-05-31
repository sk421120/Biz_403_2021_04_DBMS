-- tdUser
use todoList;

drop table tbl_todo cascade;

CREATE TABLE tbl_todo (
	td_seq	BIGINT	PRIMARY KEY AUTO_INCREMENT,
	td_do	VARCHAR(500)	NOT NULL,
	td_date	CHAR(10)	NOT NULL,
	td_time	CHAR(5)	NOT NULL,
	td_place	VARCHAR(125)
);

DESC tbl_todo;

INSERT INTO tbl_todo ( td_do, td_date, td_time, td_place )
VALUES ('테스트', '2021-05-20', '00:00', '학원');

INSERT INTO tbl_todo ( td_do, td_date, td_time)
VALUES ('요것도', '2021-05-21', '00:12' );

Select * from tbl_todo;