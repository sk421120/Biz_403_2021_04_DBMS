-- bookuser
 DROP TABLE tbl_books CASCADE CONSTRAINTS;
CREATE TABLE tbl_books (
    bk_isbn   CHAR(13) PRIMARY KEY,
    bk_title  NVARCHAR2(125) NOT NULL,
    bk_ccode  CHAR(5) NOT NULL,
    bk_acode  CHAR(5) NOT NULL,
    bk_date   VARCHAR2(10),
    bk_price  NUMBER,
    bk_pages  NUMBER
);
DESC tbl_books;

INSERT INTO tbl_books (bk_isbn, bk_title, bk_ccode, bk_acode, bk_date, bk_price, bk_pages)
VALUES ('9788993928037', '보통의 존재', '00001', '00001', '2009-11-04', 10800, 386);
DELETE FROM tbl_books;

CREATE TABLE tbl_company (
    cp_code   CHAR(5) PRIMARY KEY,
    cp_title  NVARCHAR2(125) NOT NULL,
    cp_ceo    NVARCHAR2(20),
    cp_tel    VARCHAR2(20),
    cp_addr   NVARCHAR2(125),
    cp_genre  NVARCHAR2(30)
);
DESC tbl_company;

INSERT INTO tbl_company (cp_code, cp_title, cp_ceo, cp_tel, cp_addr, cp_genre)
VALUES ('00001', '달', '염현숙', '031-8071-8688', '경기도 파주시 회동길 455-3', '에세이');
DELETE FROM tbl_company;

CREATE TABLE tbl_author (
    au_code   CHAR(5) PRIMARY KEY,
    au_name   NVARCHAR2(50) NOT NULL,
    au_tel    VARCHAR2(20),
    au_addr   NVARCHAR2(125),
    au_genre  NVARCHAR2(30)
);

-- 데이터 improt 후에 확인
SELECT COUNT(*) FROM tbl_books;
SELECT COUNT(*) FROM tbl_company;
SELECT COUNT(*) FROM tbl_author;

-- 3개의 table을 JOIN하여 view 만들기
-- ISBN   도서명   출판사명   출판사대표   저자명   저자연락처   출판일   가격

CREATE VIEW view_도서정보표
AS (
SELECT BK.bk_isbn ISBN, BK.bk_title 도서명, CP.cp_title 출판사명, CP.cp_ceo 출판사대표,
    AU.au_name 저자명, AU.au_tel 저자연락처, BK.bk_date 출판일, BK.bk_price 가격
FROM tbl_books BK
    LEFT JOIN tbl_company CP
        ON BK.bk_ccode = CP.cp_code
    LEFT JOIN tbl_author AU
        ON BK.bk_acode = AU.au_code
);

DROP VIEW view_도서정보표 CASCADE CONSTRAINTS;

SELECT * FROM view_도서정보표;

/*
고정문자열 type칼럼 주의사항
CHAR() Type의 문자열 칼럼은 실제 저장되는 데이터 type에 따라 주의를 해야 한다

만약 데이터가 숫자값으로만 되어 있는 경우
00001, 00002 와 같이 입력할 경우 0을 삭제해버리는 경우가 있다.

(엑셀에서 import하는) 실제데이터가 날짜 타입일 경우 SQL의 날짜형 데이터로 변환한 후 다시 문자열 변환 저장

칼럼을 PK로 설정하지 않는 경우는 가급적 CHAR로 설정하지 말고 VARCHAR2로 설정하는 것이 좋다.

고정문자열 칼럼으로 조회를 할 때 아래와 같은 조건을 부여하면 데이터가 조회 되지 않는 현상 발생 가능
WHERE 코드 = '00001'
*/

-- 출판일이 2018인 모든 데이터
SELECT * FROM view_도서정보표
WHERE 출판일 BETWEEN '2018-01-01' AND '2018-12-31';

-- SUBSTR() 함수를 사용한 문자열 자르기
-- SUBSTR( 문자열데이터, 시작위치, 개수 )
-- 타 DB에서는 LEFT(문자열, 몇글자)함수를 사용 /   RIGHT(문자열, 몇글자) 오른쪽에서 몇글자
SELECT * FROM VIEW_도서정보표
WHERE SUBSTR(출판일,0,4) = '2018';

-- 출판일 칼럼의 데이터를 앞에서 4글자만 잘라서 보여라
SELECT SUBSTR(출판일,0,4) AS 출판년도 FROM view_도서정보표;
-- 출판일 칼럼의 데이터를 오른쪽으로 부터 4글자만 잘라서 보여라
SELECT SUBSTR(출판일,-5) AS 출판월일 FROM view_도서정보표;