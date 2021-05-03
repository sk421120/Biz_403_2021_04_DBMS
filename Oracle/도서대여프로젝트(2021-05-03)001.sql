-- bookuser
-- DROP TABLE tbl_book_rent CASCADE CONSTRAINTS;
-- DELETE tbl_book_rent;

CREATE TABLE tbl_buyer (
    bu_code   CHAR(5) PRIMARY KEY,
    bu_name   NVARCHAR2(50) NOT NULL,
    bu_birth  NUMBER NOT NULL,
    bu_tel    VARCHAR2(20),
    bu_addr   NVARCHAR2(125)
);

DESC tbl_buyer;

INSERT INTO tbl_buyer(bu_code, bu_name, bu_birth, bu_tel, bu_addr)
VALUES ('B0001', '아무개', 1998, '010-1234-2568', '광주 북구 용봉동');

SELECT * FROM tbl_buyer;

CREATE TABLE tbl_book_rent (
    br_seq    NUMBER PRIMARY KEY,
    br_sdate  VARCHAR2(10) NOT NULL,
    br_isbn   CHAR(13) NOT NULL,
    br_bcode  CHAR(5) NOT NULL,
    br_edate  VARCHAR2(10),
    br_price  NUMBER
);

DESC tbl_book_rent;

INSERT INTO tbl_book_rent(br_seq, br_sdate, br_isbn, br_bcode, br_edate, br_price)
VALUES (1, '2021-05-03', '1234567890123', 'B0001', '2021-05-03', 3000);

SELECT * FROM tbl_book_rent;

ALTER TABLE tbl_books   ADD CONSTRAINT fk_company   FOREIGN KEY (bk_ccode);

-- tbl_book_rent 와 tbl_books, tbl_buyer table을 참조 무결성 설정
-- 대상 Table은 다중관계의 table tbl_buyer 데이터 1개(1명의) 고객이 다수의 tbl_book_rent table에 포함된다
-- tbl_buyer 1 : tbl_book_rent N = 1 : 다 의 관계이다
-- N의 table에서 FK 설정을 하고, 1의 table과 관계를 맺는다
ALTER TABLE tbl_book_rent
ADD CONSTRAINT fk_books
FOREIGN KEY (br_isbn)
REFERENCES tbl_books(bk_isbn);

ALTER TABLE tbl_book_rent
ADD CONSTRAINT fk_buyer
FOREIGN KEY (br_bcode)
REFERENCES tbl_buyer(bu_code);
/*
tbl_book_rent table에는 필수 사용하는 데이터 칼럼을 PK로 설정하는데 어려움이 있다
다른 table의 칼럼을 참조를 하고 있지만 모든 칼럼이 중복 값을 가질 수 있는 관계로
단일 칼럼으로 PK를 설정할 수 없다

PK를 설정하고, 더불어 주문관련 리스트를 보는데 사용할 br_seq 칼럼을 만들고 이 칼럼으로 PK를 설정했다.

book_rent 테이블에 데이터를 INSERT 하려고 할 때 항상 유일한 값으로 PK를 설정해야하는 어려움이 있다
보통 이러한 칼럼은 일련번호 순으로 만드는데 오라클 이외의 다른 DBMS에는 일련번호를 자동으로 만들어주믄 Table 속성이 있다
오라클(11 이하)에서는 그러한 속성이 없다
mySQL의 경우 칼럼 속성에 AUTO_INCREMENT 로 설정을 하면 그 칼럼은 INSERT할 때 별도 값을 지정하지 않아도 항상 유일한 일련번호로 자동 생성이 된다

오라클에서는 일련번호를 생성하기 위한 별도의 객체가 존재한다
오라클에서 일련번호를 생성하는 SEQUENCE 객체
*/

-- 오라클에서 일련번호를 생성하는 SEQUENCE 객체
-- DDL 명령을 사용하여 SEQ 객체 생성
-- 이름을 명명할때 SEQ_ 로 시작하고 뒤에 적용할 대상 table명을 붙여 생성한다
CREATE SEQUENCE seq_book_rent   START WITH 1    INCREMENT BY 1;
--          seq이름                시작값            자동증가값

SELECT seq_book_rent.NEXTVAL FROM DUAL;

INSERT INTO tbl_book_rent(br_seq, br_sdate, br_isbn, br_bcode)
VALUES(seq_book_rent.NEXTVAL, '2021-05-03','9791188850440','B0001');

SELECT * FROM tbl_book_rent;

-- seq삭제
DROP SEQUENCE seq_book_rent;

-- 기존에 사용하던 SEQ를 삭제하고 다시 생성할 경우 반드시 적용되는 Table의 칼럼 값을 확인해야 한다
-- seq 칼럼의 최대값을 확인하고
SELECT MAX(br_seq) FROM tbl_book_rent;

-- SEQ의 START 값을 적용하는 테이블의 SEQ 최대값보다 크게 설정을 하자
CREATE SEQUENCE se_book_rent
START WITH 14
INCREMENT BY 1;

INSERT INTO tbl_book_rent(br_seq, br_sdate, br_isbn, br_bcode)
VALUES(se_book_rent.NEXTVAL, '2021-04-20','9791188850440','B0001');

-- tbl_book_rent는 회원이 도서를 대여한 리스트가 있다
-- 여기에는 도서코드, 회원코드만 있기 때문에 구체적인 정보를 알 수 없다
-- Table JOIN을 통해서 구체적인 정보를 확인하자
SELECT * FROM tbl_book_rent BR, tbl_books BO, tbl_buyer BU
    WHERE BR.br_isbn = BO.bk_isbn AND BR.br_bcode = BU.bu_code;

SELECT * FROM tbl_book_rent BR
    JOIN tbl_books BK
        ON BR.br_isbn = BK.bk_isbn
    JOIN tbl_buyer BU
        ON BR.br_bcode = BU.bu_code;

-- INNER JOIN
-- FK 관계가 설정된 TABLE 간에 사용하는 JOIN
-- FK 관계가 설정되지 않은 TABLE간에서는 조회되는 데이터가 실제와 다를 수 있다.
SELECT
    BR.br_sdate AS 대여일,
    BR.br_bcode AS 회원코드,
    BU.bu_name AS 회원명,
    BR.br_isbn AS ISBN,
    BK.bk_title AS 도서명,
    BR.br_edate AS 반납일,
    BR.br_price AS 대여금
FROM tbl_book_rent BR
    JOIN tbl_books BK
        ON BR.br_isbn = BK.bk_isbn
    JOIN tbl_buyer BU
        ON BR.br_bcode = BU.bu_code;
        
-- LEFT (OUTER) JOIN
-- 테이블간에 FK 가 설정되지 않고 참조하는 테이블의 데이터가 마련되지 않은 경우
-- FROM 절에 표현된 Table 데이터 위주로 조회하고자 할때
-- FK 설정되지 않아도 데이터 조회는 모두 할 수 있다
-- 단 JOIN 된 테이블에 데이터가 없으면 (null)로 표현된다.
SELECT
    BR.br_sdate AS 대여일,
    BR.br_bcode AS 회원코드,
    BU.bu_name AS 회원명,
    BR.br_isbn AS ISBN,
    BK.bk_title AS 도서명,
    BR.br_edate AS 반납일,
    BR.br_price AS 대여금
FROM tbl_book_rent BR
    LEFT JOIN tbl_books BK
        ON BR.br_isbn = BK.bk_isbn
    LEFT JOIN tbl_buyer BU
        ON BR.br_bcode = BU.bu_code;

CREATE VIEW view_도서대여정보 AS (
SELECT
    BR.br_sdate AS 대여일,
    BR.br_bcode AS 회원코드,
    BU.bu_name AS 회원명,
    BR.br_isbn AS ISBN,
    BK.bk_title AS 도서명,
    BR.br_edate AS 반납일,
    BR.br_price AS 대여금
FROM tbl_book_rent BR
    LEFT JOIN tbl_books BK
        ON BR.br_isbn = BK.bk_isbn
    LEFT JOIN tbl_buyer BU
        ON BR.br_bcode = BU.bu_code
);

DROP VIEW view_도서대여정보;

CREATE VIEW view_도서대여정보 AS (
SELECT
    BR.br_sdate AS 대여일,
    BR.br_bcode AS 회원코드,
    BU.bu_name AS 회원명,
    BU.bu_tel AS 연락처,
    BR.br_isbn AS ISBN,
    BK.bk_title AS 도서명,
    BR.br_edate AS 반납일,
    BR.br_price AS 대여금
FROM tbl_book_rent BR
    LEFT JOIN tbl_books BK
        ON BR.br_isbn = BK.bk_isbn
    LEFT JOIN tbl_buyer BU
        ON BR.br_bcode = BU.bu_code
);

SELECT * FROM view_도서대여정보;
SELECT * FROM view_도서대여정보 WHERE 회원명 = '명윤일';

SELECT * FROM view_도서대여정보 WHERE 대여일 < '2021-04-10';

-- 4월 25일 이전에 대여했는데 아직 반납하지 않은 사람
SELECT * FROM view_도서대여정보 WHERE 대여일 < '2021-04-25' AND 반납일 IS NULL;

SELECT 대여일, 회원코드, 회원명, 반납일, BU.bu_tel
FROM view_도서대여정보 BR
    LEFT JOIN tbl_buyer BU
        ON BR."회원코드" = BU.bu_code
WHERE 대여일 < '2021-04-25' AND 반납일 IS NULL;

-- 중복된 데이터가 있으면 그룹으로 묶어서 단순하게 보여달라
SELECT 대여일, 회원코드, 회원명, BU.bu_tel
FROM view_도서대여정보 BR
    LEFT JOIN tbl_buyer BU
        ON BR."회원코드" = BU.bu_code
WHERE 대여일 < '2021-04-25' AND 반납일 IS NULL
GROUP BY 대여일, 회원코드, 회원명, BU.bu_tel;

/*
위의 코드는 전체 데이터중에서 대여일과 반납일에 조건을 부여한 후 데이터를 간추리고,
간추려진 데이터를 GROUP 으로 묶어 보여주기

아래 코드는 전체 데이터를 GROUP으로 묶고 묶인 데이터를 조건에 맞는 항목만 보여주기

이 두 코드는 결과는 같지만 실행하는 성능은 매우 많이 차지가 난다
데이터가 많을 수 록 성능 차이는 매우 극명하게 나타난다
*/
-- 먼저 조건 검색 다음 그룹(읽기)

SELECT 대여일, 회원코드, 회원명, BU.bu_tel
FROM view_도서대여정보 BR
    LEFT JOIN tbl_buyer BU
        ON BR."회원코드" = BU.bu_code
GROUP BY 대여일, 회원코드, 회원명, BU.bu_tel, 반납일
HAVING 대여일 < '2021-04-25' AND 반납일 IS NULL;

-- 먼저 그룹 생성(읽기) 다음 조건

-- 예시)
/*
 학생이름  과목 점수
 --------------------
 홍길동    국어 50
 홍길동    영어 50
 홍길동    수학 50
 홍길동    과학 50
 이몽룡    국어 90
 이몽룡    영어 80
 이몽룡    수학 70
 이몽룡    과학 70
 --------------------
 홍길동        250
 이몽룡        310
 이 데이터에서 홍길동 학생의 4과목 총점을 계산하기 위한 코드
*/
SELECT 학생이름, SUM(점수)
FROM tbl_score
GROUP BY 학생이름
HAVING SUM (점수) > 250;

-- tbl_score에서 과학, 수학 2과목의 점수만 총점을 계산하고 싶다
SELECT 학생이름, SUM(점수)
FROM tbl_score
WHERE 과목 = '과학' OR 과목 = '수학'
GROUP BY 학생이름;

-- 직업별로 급여의 합계 계산하기
SELECT 직업, SUM(급여)
FROM tbl_급여
GROUP BY 직업;

-- 직업별로 급여를 계산할 때 직업이 영업직인 사람을 제외하고 싶다.
SELECT 직업, SUM(급여)
FROM tbl_급여
WHERE 직업!='영업직'
GROUP BY 직업;

SELECT 직업, SUM(급여)
FROM tbl_급여
GROUP BY 직업
HAVING 직업!='영업직';

-- 급여테이블에서 영업직을 제외한 직업의 급여 총합계를 계산하고
-- 총 합계가 300000 이상인 데이터만 보여라
SELECT 직업, SUM(급여)
FROM tbl_급여
GROUP BY 직업
HAVING SUM(급여) >= 3000000;

-- 급여테이블에서 영업직을 제외하고 실 급여가 300000을 초과하는 데이터만 합산하여 보이라
SELECT 직업, SUM(급여)
FROM tbl_급여
WHERE 직업 != '영업직' AND SUM(급여) >= 3000000
GROUP BY 직업;

-- 대여일이 2021-04-25 이전이고 아직 미납된 대이터
SELECT * FROM view_도서대여정보
WHERE 대여일 <= '2021-04-25' AND 반납일 IS NULL;

SELECT 대여일, 회원코드, 회원명, 연락처, 도서명
FROM view_도서대여정보
WHERE 대여일 < '2021-04-25' AND 반납일 IS NULL
GROUP BY 대여일, 회원코드, 회원명, 연락처, 도서명;

INSERT INTO tbl_book_rent(br_seq, br_sdate, br_bcode, br_isbn)
VALUES (se_book_rent.NEXTVAL, '2021-04-02', 'B0002', '9791188850365');

INSERT INTO tbl_book_rent(br_seq, br_sdate, br_bcode, br_isbn)
VALUES (se_book_rent.NEXTVAL, '2021-04-01', 'B0013', '9791188850327');

-- 회원코드 순으로
SELECT 대여일, 회원코드, 회원명, 연락처, 도서명
FROM view_도서대여정보
WHERE 대여일 < '2021-04-25' AND 반납일 IS NULL
GROUP BY 대여일, 회원코드, 회원명, 연락처, 도서명
ORDER BY 회원코드;