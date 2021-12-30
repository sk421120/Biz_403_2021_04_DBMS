-- myLibs
use myLibs;

SELECT * FROM tbl_files;
SELECT * FROM tbl_gallery;

-- INSERT를 수행할 때
-- AUTO_INCREMENT로 설정된 칼럼에 0또는 null, ''등을 설정하면
-- AUTO_INCREMENT가 실행되어 새로운 seq값이 만들어진다.
INSERT INTO tbl_gallery(g_seq,g_writer,g_date,g_time,g_subject,g_content)
VALUE('0','callor','2021','00:00','제목','내용');

-- EQ JOIN
-- 카티션 곱
-- 두개의 table을 JOIN하여 table1 개수 * table2 개수만큼 list출력
SELECT * FROM tbl_gallery G, tbl_files F
   WHERE G.g_seq = F.file_seq;

-- 카티션 곱으로 해서 1개의 값을 보여주기    
SELECT * FROM tbl_gallery G, tbl_files F
   WHERE G.g_seq = F.file_seq
    AND G.g_seq =1;

CREATE VIEW view_gallery AS (    
SELECT G.g_seq AS g_seq, G.g_writer AS g_writer, G.g_date AS g_date, G.g_time AS g_time,
      G.g_subject AS g_subject, G.g_content AS g_content, G.g_image AS g_image,
      F.file_seq AS f_seq, F.file_original AS f_original, F.file_upname AS f_upname
FROM tbl_gallery G, tbl_files F
   WHERE G.g_seq = F.file_seq
); 

SELECT * FROM view_gallery;

DESC view_gallery;