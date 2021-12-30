use db_school;

/*
tbl_subject, tbl_score table을 가지고
각 학생의 성적 리스트를 출력해보기
과목 리스트를 출력하고, 각 과목의 성적이 입력된 학생의 리스트를 확인하기
학번을 조건으로하여 한 학생의 성적입력 여부를 확인하기
학생의 점수가 입력된 과목과 입력되지 않은 과목을 확인하고 싶다
*/

-- subquery 
select SB.sb_code, SB.sb_name, SB.sb_prof, SC.sc_stnum, SC.sc_score
FROM tbl_subject SB
	LEFT JOIN (select *  from tbl_score WHERE sc_stnum = '12345678') SC
		ON SC.sc_sbcode = SB.sb_code;
        
select SB.sb_code, SB.sb_name, SB.sb_prof, SC.sc_stnum, SC.sc_score
FROM tbl_subject SB
	LEFT JOIN tbl_score SC
		ON SC.sc_sbcode = SB.sb_code
        AND SC.sc_stnum = '12345678' LIMIT 5;
/*
과목리스트를 전체를 보여주고, 학생의 성적 table을 JOIN하여
학생의 점수가 있으면 점수를 보이고 없으면 null로 보여주는 JOIN SQL문

이 JOIN 명령문에 특정한 학번을 조건으로 부여하여
한 학생의 성적여부를 조회하는 SQL만들기

순수한 JOIN을 사용하여 한 학생의 성적을 조회하는데학생의 성적이 tbl_score table에 있으면
점수를 보이고 없으면 NULL로 표현하기 위하여 WHERE 절에서
학번을 조건으로 부여하지 않고 JOIN문에 ON 절에서 학번을 조건으로 부여를 한다
*/
select SB.sb_code, SB.sb_name, SB.sb_prof, SC.sc_stnum, SC.sc_score
FROM tbl_subject SB
	LEFT JOIN tbl_score SC
		ON SC.sc_sbcode = SB.sb_code;
SELECT COUNT(*) FROM tbl_score
   	WHERE sc_stnum = '1234567';
SELECT SUM(sc_score) FROM tbl_score
   	WHERE sc_stnum = '123';
    -- group by sc_stnum
    
    
use db_school;
drop table tbl_score;
/*
TABLE에 INSERT INTO ON DUPLICATE KEY UPDATE를 실행하기 위해서는 PK 설정을 변경해야 한다
tbl_score는 두개의 칼럼을 기준으로 UPDATE, DELETE를 수행하는 문제가 발생한다
가장 좋은 설계는 UPDATE, DELETE를 수행할 때 한개의 칼럼으로 구성죈 PK를 기준으로 수행하는 것이다.
*/
CREATE TABLE tbl_score (
	sc_seq	BIGINT	AUTO_INCREMENT	PRIMARY KEY,
	sc_stnum	char(8)	NOT NULL,	
	sc_sbcode	char(4)	NOT NULL,	
	sc_score	INT	NOT NULL,
    PRIMARY KEY(sc_stnum, sb_code)
);

/*
PK는 그대로 살려두고 두개의 칼럼을 묶어 UNIQUE로 설정
두개의 칼럼의 값이 동시에 같은 경우는 추가하지 말라는 제약조건 설정
*/
CREATE TABLE tbl_score (
	sc_seq	BIGINT	AUTO_INCREMENT	PRIMARY KEY,
	sc_stnum	char(8)	NOT NULL,	
	sc_sbcode	char(4)	NOT NULL,	
	sc_score	INT	NOT NULL,
    UNIQUE(sc_stnum, sc_sbcode)
);

select * from tbl_score;