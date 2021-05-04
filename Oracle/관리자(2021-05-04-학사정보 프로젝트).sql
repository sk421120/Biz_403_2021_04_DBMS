-- 관리자
CREATE TABLESPACE KschoolDB
DATAFILE 'C:/oraclexe/data/kschool.dbf'
SIZE 1M AUTOEXTEND ON NEXT 1K;

CREATE USER kscuser IDENTIFIED BY kscuser
DEFAULT TABLESPACE KschoolDB;

GRANT DBA TO kscuser;