CREATE DATABASE mybook;

USE mybook;

-- drop table tbl_company;

CREATE TABLE tbl_books (
	bk_isbn	CHAR(13)		PRIMARY KEY,
bk_ccode	CHAR(5)	NOT NULL	,
bk_acode	CHAR(5)	NOT NULL	,
bk_title	VARCHAR(125)	NOT NULL	,
bk_date	VARCHAR(10)		,
bk_pages	INT		,
bk_price	INT		
);

CREATE TABLE tbl_company (
cp_code	CHAR(5)		PRIMARY KEY,
cp_title	VARCHAR(125)	NOT NULL,	
cp_ceo	VARCHAR(30)	NOT NULL	,
cp_tel	VARCHAR(20)		,
cp_addr	VARCHAR(125)		,
cp_genre VARCHAR(30)
);

CREATE TABLE tbl_author(
au_code	CHAR(5)		PRIMARY KEY,
au_name	VARCHAR(125)	NOT NULL,	
au_tel	VARCHAR(20)		,
au_addr	VARCHAR(125)		
);