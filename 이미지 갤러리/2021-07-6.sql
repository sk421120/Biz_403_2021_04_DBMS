-- myLibs
use myLibs;

CREATE TABLE tbl_gallery (
    g_seq BIGINT PRIMARY KEY AUTO_INCREMENT,
    g_writer VARCHAR(20) NOT NULL,
    g_date VARCHAR(10) NOT NULL,
    g_time VARCHAR(10) NOT NULL,
    g_subject VARCHAR(50) NOT NULL,
    g_content VARCHAR(1000) NOT NULL,
    g_image VARCHAR(125)
);

show tables;

drop table tbl_gallery;
drop table tbl_files;
select * from tbl_files;
select * from tbl_gallery;

delete from tbl_gallery where g_seq = 5;
delete from tbl_files where file_seq = 5;

CREATE TABLE tbl_files (
    file_seq BIGINT PRIMARY KEY AUTO_INCREMENT,
    file_gseq BIGINT NOT NULL,
    file_original VARCHAR(125) NOT NULL,
    file_upname VARCHAR(125) NOT NULL
);

INSERT INTO tbl_gallery (g_writer, g_date, g_time, g_subject, g_content)
VALUES ('sk', '2021-07-06', '15:18:00', '냥냥', '테스트 냥냥');

-- 현재 연결된 session에서 INSERT가 수행되고 그 과정에서 AUTO_INCREMENT 칼럼이 변화가 있으면
-- 그 값을 알려주는 함수 
SELECT LAST_INSERT_ID();