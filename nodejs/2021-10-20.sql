/*
DB의 3대 Schema

Schema - 외부, 개념, 내부

외부: 모든 데이터는 Table 형태로 되어있다.

내부: `DBMS 엔진(SW)이 자체적으로 OS와 함께 연동되어 Storage에 어떻게 데이터를 보관하는가`하는 관점
	데이터를 어떤 기준으로 저장할 것인가
    (Oracle: TableSpace, MySQL: DataBase.. ORACLE을 제외한 대부분은 DataBase라고 한다)
    
개념: 사용자의 SQL을 번역하여 실제 데이터에 어떻게 반영할 것인가
		조회된 데이터를 어떻게 하여 Table 모양으로 바꿀 것인가
*/

/*
RDBMS(Relation DataBase Management System) - 데이터베이스 관리 소프트웨어
	- Oracle, MySQL, MsSQL...

RDBMS 차원에서의 Schema
	Data를 보관, 관리하는 가장 큰 주체가 누구?
    
    일반 - DataBase를 기준으로 Schema 관리
		사용자는 login을 통한 권한을 획득한 사용자
        
    Oracle: User를 기준으로 Schema 관리
*/

-- naraDB Schema 생성하기
create database naraDB;

use naraDB;

desc tbl_buyer;
