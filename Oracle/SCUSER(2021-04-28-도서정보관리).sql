-- scUser
CREATE TABLE tbl_books (
    bk_isbn	CHAR(13) PRIMARY KEY,
    bk_pub	nVARCHAR2(7) NOT NULL,	
    bk_name	nVARCHAR2(25) NOT NULL,
    bk_write nVARCHAR2(20) NOT NULL,	
    bk_trans nVARCHAR2(5),		
    bk_date	CHAR(10) NOT NULL,	
    bk_page	NUMBER NOT NULL,
    bk_price NUMBER	NOT NULL
);

DESC tbl_books;

INSERT ALL 
INTO tbl_books (bk_isbn, bk_pub, bk_name, bk_write, bk_trans, bk_date, bk_page, bk_price) 
    VALUES ('9791162540770', '비즈니스북스', '데스 바이 아마존', '시로타 마코토', '신희원', '2019-04-15', 272, 15000)
INTO tbl_books (bk_isbn, bk_pub, bk_name, bk_write, bk_trans, bk_date, bk_page, bk_price)
    VALUES ('9791188850549', '북라이프', '4주 만에 완성하는 레깅스핏 스트레칭', '모리 다쿠로', '김현정', '2019-04-11', 132, 13000)
INTO tbl_books (bk_isbn, bk_pub, bk_name, bk_write, bk_date, bk_page, bk_price)
    VALUES ('9791188850518', '북라이프', '왕이 된 남자 2', '김선덕', '2019-04-10', 388, 14000)
INTO tbl_books (bk_isbn, bk_pub, bk_name, bk_write, bk_date, bk_page, bk_price)
    VALUES ('9791188850501', '북라이프', '왕이 된 남자 1', '김선덕', '2019-04-10', 440, 14000)
INTO tbl_books (bk_isbn, bk_pub, bk_name, bk_write, bk_date, bk_page, bk_price)
    VALUES ('9791162540756', '비즈니스북스', '새벽에 읽는 유대인 인생 특강', '장대은', '2019-04-10', 280, 15000)
INTO tbl_books (bk_isbn, bk_pub, bk_name, bk_write, bk_date, bk_page, bk_price)
    VALUES ('97911888', '북라이프', '왕이 된 남자 포토에세이', '스튜디오 드래곤', '2019-04-10', 368, 25000)
SELECT * FROM DUAL;

DROP TABLE tbl_books CASCADE CONSTRAINTS;

CREATE TABLE tbl_books (
    bk_isbn	CHAR(13) PRIMARY KEY,
    bk_comp	nVARCHAR2(15) NOT NULL,	
    bk_title nVARCHAR2(125) NOT NULL,
    bk_author nVARCHAR2(50) NOT NULL,	
    bk_trans nVARCHAR2(20),		
    bk_date	VARCHAR2(10) NOT NULL,	
    bk_pages NUMBER NOT NULL,
    bk_price NUMBER	NOT NULL
);

-- ALTER TABLE : TABLE을 변경하는 명령
-- 만들어진 Table의 이름을 변경하기
ALTER TABLE tbl_books RENAME TO tbl_books_v2;

-- 이미 데이터가 담긴 테이블을 복제하기
-- 테이블 구조와 데이터를 복제하여 백업을 하는 용도
-- 일부 제약조건이 함께 복제되지 않는다
CREATE TABLE tbl_books AS SELECT * FROM tbl_books_v2;

-- TABLE을 복제한 후 오라클에서는 반드시 PK를 다시 설정해 주어야 한다.

-- TABLE을 생성하고 데이터가 잇는 상태에서 PK를 변경, 추가 하는 경우에는 PK로 설정하려고 하는 칼럼의 데이터가
-- PK조건(유일성, NOT NULL)을 만족하지 않는 데이터가 있으면 명령이 실패한다
-- 대량의 데이터가 저장된 TABLE을 변경할 경우는 매우 신중하게 실행을 해야 한다.
-- 또한 미리 데이터 검증을 통하여 제약 조건에 위배되는 데이터가 있는지 확인을 해야 한다.
ALTER TABLE tbl_books ADD CONSTRAINT PK_ISBN PRIMARY KEY(bk_isbn);
-- tbl_books table을 변경 / 제약조건을 추가하는데 이름을 PK_ISBN / bk_isbn 칼럼을 PK로 설정하겠다

-- 생성된 PK를 제거하기
ALTER TABLE tbl_books DROP PRIMARY KEY(bk_isbn);

/*
도서정보를 저장하기 위하여 tbl_books 테이블을 생성하고 도서정보를 import 했다
도서정보는 어플로 만들기전에 상요하던 데이터인 관계로 데이터베이스의 규칙에 다소 어긋난 데이터가 있다

저자 항목(칼럼)을 보면 저자가 2명 싱상인 데이터가 있고 또한 역자도 2명 이상인 경우가 있다

데이터를 저장할 칼럼을 크게 설정하여 입력(import)하는데는 문제가 없는데
저자나 역자를 기준으로 데이터를 여러가지 조건을 부여하여 조회를 하려고 하면 문제가 발생 할 수 있다
특히 저자이름으로 GROPPING 을 하여 데이터를 조회해 보려고 하면!
아니 넘어가버렸다
*/


DESC tbl_books;

ALTER TABLE tbl_books RENAME COLUMN bk_author TO bk_author1;
-- tbl_books 테이블을 변경하라 / bk_author 칼럼을 bk_author1으로 변경

ALTER TABLE tbl_books ADD bk_author2 nVARCHAR2(50) NOT NULL;
-- bk_author2라는 칼럼 생성 / 한글가변문자열2로 선언하고 NOT NULL로 설정하라

-- ALTER TABLE을 이용하여 칼럼을 추가하는 경우에는 사전에 제약조건 설정이 매우 까다롭다
-- 제약조건을 설정하려면
-- 1. 칼럼을 아무런 제약조건없이 추가한 후
-- 2. 제약조건에 맞는 데이터를 입력한 후
-- 3. 제약조건을 설정한다

ALTER TABLE tbl_books ADD bk_author2 nVARCHAR2(50);
-- bk_author2라는 칼럼 생성 / 한글가변문자열2로 선언하라

/*
데이터 베이스의 제 1정규화
한 칼럼의 저장되는 데이터는 원자성을 가져야 한다
한 칼럼에는 2개 이상의 데이터가 구분자(,)로 나뉘어 저장되는 것을 막는 조치

이미 2개 이상의 데이터가 저장된 경우 분리하여 원자성을 갖도록 하는 것이다
*/

/*
도서정보 데이터의 제1정규화를 수행하고 보니
저자 데이터를 저장할 칼럼이 이후에 또 변경해야하는 상황이 발생 할 수 있는 이슈가 발견되었다

제2정규화를 통하여 테이블 설계를 다시 해야 하겠다
1. 정규화를 수행할 칼럼이 무엇인가 파악(인식한다)
    저자 데이터를 저장할 칼럼
    복수의 데이터가 필요한 경우
2. 도서정보와 관련된 저자데이터를 저장할 Table 새로 생성한다
    tbl_author TABLE을 생성할 예정
    
    "도서의 ISBN"과 "저자 리스트"를 포함하는 형태의 데이터를 만든다
    
    ------------------------
    ISBN      저자
    ------------------------
    1       홍길동
    1       이몽룡
    2       성춘향
    3       임꺽정
    4       장영실
    5       장녹수
    ------------------------
*/

-- 도서의 저자 리스트를 저장할 TABLE 생성
CREATE TABLE tbl_book_author(
    ba_seq	NUMBER PRIMARY KEY,
    ba_isbn	CHAR(13) NOT NULL,
    ba_author nVARCHAR2(50) NOT NULL
);

-- tbl_books 테이블의 데이터를 삭제하고 제 1정규화가 완료된 데이터로 다시 import
DELETE FROM tbl_books;
COMMIT;
SELECT * FROM tbl_books;

-- 제 1정규화가 완료된 도서정보로 부터 저자리스트를 생성

-- 도서정보 테이블에서 저자이름들 목록을 추출하기
SELECT '(' || bk_isbn, bk_author1 FROM tbl_books
GROUP BY '(' || bk_isbn, bk_author1

UNION ALL 

SELECT '(' || bk_isbn, bk_author2 FROM tbl_books
WHERE bk_author2 IS NOT NULL
GROUP BY '(' || bk_isbn, bk_author2;
-- UNION ALL 두개 이상의 출력된 리스트를 합하여 1개의 리스트로 보여라
-- 각각의 조회 결과에서 나타나는 칼럼이 일치해야 한다.

-- 도서정보와 저자리스트를 JOIN하여 데이터 조회
-- 저자가 1명인 경우는 한개의 도서만 출력이 되고
-- 저자가 2명 이상인 경우는 같은 ISBN, 같은 도서명, 다른 저자 형식으로 저자 수 만큼 데이터가 출력된다
SELECT bk_isbn, bk_title, ba_author
FROM tbl_books
    LEFT JOIN tbl_book_author
        ON bk_isbn = ba_isbn;
        
-- 제 2정규화가 완료된 상태에서 도서정보를 입력하면서 저자정보를 추가하려면
-- 저자정보에는 ISBN 저자명을 포함한 데이터를 추가해 주면 된다.

SELECT ba_author, bk_isbn, bk_title
FROM tbl_books
    LEFT JOIN tbl_book_author
        ON bk_isbn = ba_isbn
ORDER BY ba_author;

-- 정보처리기사
-- 제 1정규화 : 원자성
-- 제 2정규화 : 완전함수 종속성
-- 제 3정규화 : 이행적함수 종속성

-- tbl_book_author에 데이터를 추가하려고 할 때
-- 9791162540619 이 도서에 저자를 추가 하고 싶을 때
-- 테이블의 ba_seq 칼럼에는 이미 등록된 값이 아닌 새로운 숫자를 사용하여 데이터를 추가해야한다
-- 데이터를 추가 할 때마다 새로운 값이 무엇인지 알아야 하는 매우 불편한 상황이 만들어지고 말았다..!
INSERT INTO tbl_book_author( ba_seq, ba_isbn, ba_author)
VALUES( 35, '9791162540619', '홍길동');

