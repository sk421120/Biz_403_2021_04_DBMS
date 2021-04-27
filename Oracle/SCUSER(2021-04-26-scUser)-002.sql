-- 두개 이상의 칼럼을 묶어서 PK로 선언하는 경우
-- 삭제나, 갱신을 할 때 다음과 같은 코드를 사용해야 하는데 코드 사용중에 실수를 많이 일으킬 수 있다
-- 삭제나 갱신할 때는 WHERE 조건문에 PK를 대상으로 실행하는 것이 좋은데, 아래와 같은 코드를 사용하면 잦은 실수를 반복할 수 있다.
-- 때문에 tbl_score_V2 테이블에는 별도로 SEQ 칼럼을 만들고 PK로 설정을 한다
UPDATE tbl_score_V2 SET sc_score = 90
WHERE sc_num = ?? AND sc_subject = ??;

-- 정규화가 된 테이블에서 학생별 총점과 평균 계산
SELECT sc_num, SUM(sc_score), ROUND(AVG(sc_score),0)
FROM tbl_score_V2
GROUP BY sc_num
ORDER BY sc_num;

-- 전체학생의 과목별 총점
SELECT sc_subject, SUM(sc_score), ROUND(AVG(sc_score),0)
FROM tbl_score_V2
GROUP BY sc_subject
ORDER BY sc_subject;

