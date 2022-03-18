

/*
인덱스 ( index )
- SQL 명령문의 처리 속도를 향상시키기 위해서 커럼에 대해서 생성하는 오라클 객체 입니다
- 기본키나, 유일키와 같은 제약 조건을 지정하면 따로 생성하지 않더라도 자동으로 생성해 줍니다
- CREATE INDEX index_name
  ON table_name (column_name);


 */

-- USER_IND_COLUMNS 딕셔너리 뷰로 인덱스 생성 유무 확인
SELECT INDEX_NAME, TABLE_NAME, COLUMN_NAME
FROM USER_IND_COLUMNS
WHERE TABLE_NAME IN('EMP', 'DEPT');


-- 연습용 테이블 생성
DROP TABLE EMP01;

CREATE TABLE EMP01
AS
SELECT * FROM EMP;

SELECT INDEX_NAME, TABLE_NAME, COLUMN_NAME
FROM USER_IND_COLUMNS
WHERE TABLE_NAME IN('EMP', 'EMP01');

-- 서브쿼리 문으로 INSERT 문 여러번 반복해서 테이블 데이터 여러번 추가
INSERT INTO EMP01 SELECT * FROM EMP01;

SELECT * FROM EMP01;

-- 검색용 데이터 추가
INSERT INTO EMP01(EMPNO, ENAME) VALUES(7777, 'INDEX');

-- 시간 체크 명령문
SET TIMING ON

-- 사원 이름이 'INDEX'행 검색
SELECT DISTINCT EMPNO, ENAME
FROM EMP01
WHERE ENAME='INDEX';

-- 시간 체크 명령문
SET TIMING ON


-- index 생성
CREATE INDEX IDX_TEST
ON EMP01(ENAME);

SELECT DISTINCT EMPNO, ENAME
FROM EMP01
WHERE ENAME='INDEX';

-- 시간 체크 명령문
SET TIMING ON













































