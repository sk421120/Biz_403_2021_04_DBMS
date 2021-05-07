-- nhuser

 DROP TABLE tbl_iolist CASCADE CONSTRAINTS;
CREATE TABLE tbl_iolist (
    io_seq    NUMBER PRIMARY KEY,
    io_date   VARCHAR2(10) NOT NULL,
    io_time   VARCHAR2(10) NOT NULL,
    io_pname  NVARCHAR2(50) NOT NULL,
    io_dname  NVARCHAR2(50) NOT NULL,
    io_dceo   NVARCHAR2(20) NOT NULL,
    io_inout  VARCHAR2(1) NOT NULL,
    io_qty    NUMBER NOT NULL,
    io_price  NUMBER NOT NULL
);

DESC tbl_iolist;

SELECT * FROM tbl_iolist;

DELETE FROM tbl_iolist;

SELECT DECODE(io_inout, '1', '매입', '매출') AS 구분,
    COUNT (*)
FROM tbl_iolist
GROUP BY DECODE(io_inout,'1', '매입', '매출');

/*
매입매출 데이터를 DB import 한 후 테이블에서 상품정보와 거래처정보를 분리하여
제 3 정규화를 수행하기

현재 매입매출 테이블에 상품이름과 거래처명(대표포함)이 저장되어 있다
현재 테이블에서 만약 상품이름이나 거래처명이 변경되어야 하는 일이 발생한다면
다수의 데이터(레코드)에 변경(update)가 되는 상황이 만들어진다
다수의 데이터를 변경하는 명령은 데이터 무결성을 해치는 원인 중의 하나이다\

상품테이블을 별도로 분리하고 상품코드, 상품명 형식으로 저장한 후
매입매출 테이블에는 상품명 대신 상품코드를 포함하고 이후에 JOIN을 통해 데이터를 조회하는 것이 좋다
*/

-- 1. 매입매출 테이블에서 상품정보를 중복없이 추출하기
SELECT io_pname
FROM tbl_iolist
GROUP BY io_pname
ORDER BY io_pname;

-- 2. 매입매출 테이블에서 상품정보와 매입단가 매출단가도 같이 추출하기
--      전체 데이터에서 상품별로 가장 높은 가격을 가져와서 매입 매출 단가로 사용하자
SELECT io_pname,
    MAX( DECODE(io_inout, '1', io_price, 0 ) ) AS 매입단가,
    MAX( DECODE(io_inout, '2', io_price, 0 ) ) AS 매출단가
FROM tbl_iolist
GROUP BY io_pname
ORDER BY io_pname;

/*
상품 리스트를 추출했는데 매입단가가 0, 또는 매출단가가 0인 경우 매입단가와 매출단가를 계산하기

매입단가가 0인경우
매출단가에서 마진(20%)을 빼고, 다시 부가세(10%) 뺀 가격으로 계산
매입단가 = (매출단가 / 1.2) / 1.1

매출단가는 매입단가에 20% 마진 추가, 부가세 10% 추가
매출단가 = (매입단가 * 1.2) * 1.1

10원단위 절사
매출단가 = INT(매출단가 / 10) * 10
*/

-- 추출된 상품정보를 저장할 테이블 생성
CREATE TABLE tbl_product (
    p_code    CHAR(6) PRIMARY KEY,
    p_name    NVARCHAR2(50) NOT NULL,
    p_iprice  NUMBER NOT NULL,
    p_oprice  NUMBER NOT NULL,
    p_vat     VARCHAR2(1) DEFAULT 'Y'
);
DELETE FROM tbl_product;
-- INSERT INTO TBL_PRODUCT (P_CODE, P_NAME, P_IPRICE, P_OPRICE, P_VAT) VALUES ('P00001',N'(신)허쉬드링크',393,800,'800');

SELECT IO.io_pname, P.p_name
FROM tbl_iolist IO
    LEFT JOIN tbl_product P
        ON IO.io_pname = P.p_name;

-- 리스트가 너무 많아서 null을 찾기가 어려울 때
SELECT IO.io_pname, P.p_name
FROM tbl_iolist IO
    LEFT JOIN tbl_product P
        ON IO.io_pname = P.p_name
WHERE p.p_name IS NULL;