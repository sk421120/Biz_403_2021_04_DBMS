-- 관리자 접속

-- 1. TABLE SPACE 생성하기
CREATE TABLESPACE iolistDB
DATAFILE 'C:/oraclexe/data/iolist.dbf'
SIZE 1M AUTOEXTEND ON NEXT 1K;

-- TABLE SPACE 삭제하기
-- 반드시 옵션을 같이 작성하자
DROP TABLESPACE iolistDB -- 반드시
INCLUDING CONTENTS AND DATAFILES -- 옵션
CASCADE CONSTRAINTS; -- 옵션

-- 2. 새로운 사용자 등록
CREATE USER iouser IDENTIFIED BY iouser
DEFAULT TABLESPACE iolistDB;

-- 사용자 삭제
DROP USER iouser CASCADE;

-- 3. 사용자에게 권한 부여
GRANT DBA TO iouser;