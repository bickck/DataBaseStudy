

/*
트랜잭션( transaction )
- 데이터 베이스 내에서 하나의 그룹으로 처리되어야 하는 명령문들을 모아 놓은 작업 단위 입니다
- 여러개의 명령어의 집합이 정상적으로 처리되면 정상 종료하도록 하고,
  여러개의 명령어 중에서 하나의 명령어라도 잘못되었다면 전체를 취소해 버립니다
- 데이터의 일관성을 유지하면서 안정적으로 데이터를 복구시키기 위해서 입니다 

트랜잭션 명령어
- COMMIT
  ROLLBACK
  SAVEPOINT 
 
 */

/*
COMMIT
- 모든 작업을 정상적으로 처리하겠다고 확정하는 명령어 입니다
- 트랜잭션의 처리 과정을 데이터베이스에 반영하기 위해서, 변경된 내용을 모두 영구 저장합니다
- COMMIT 을 수행하면 하나의 트랜잭션 과정을 종료하게 됩니다
- Transaction(INSERT, UPDATE, DELETE) 작업 내용을 실제 DB에 저장합니다
 */

/*
ROLLBACK
- 작업중 문제가 발생했을 때, 트랜잭션의 처리 과정에서 발생한 변경 사항을 취소하고,
  트랜잭션 과정을 종료합니다
- 트랜잭션으로 인한 하나의 묶음 처리가 시작되기 이전의 상태로 되돌립니다
- Transaction(INSERT, UPDATE, DELETE) 작업 내용을 취소합니다
- 이전 COMMIT 한 곳까지만 복구됩니다
 */

/*
COMMIT 과 ROLLBACK 의 장점
- 데이터 무결성이 보장됩니다
- 영구적으로 변경하기 전에 데이터의 변경사항을 확인할 수 있습니다
- 논리적으로 연관된 작업을 그룹화할 수 있습니다
 */

-- 연습용 테이블 생성
SELECT * FROM tab;
DROP TABLE dept01;
CREATE TABLE dept01 AS SELECT * FROM dept;
SELECT * FROM dept01;

-- DELETE 문으로 테이블 내용 삭제
DELETE FROM dept01;

SELECT * FROM dept01;


-- ROLLBACK 을 수행해서 데이터 복구
ROLLBACK;

SELECT * FROM dept01;


-- 부서번호 20번 삭제
DELETE FROM dept01
WHERE deptno=20;

SELECT * FROM dept01;

ROLLBACK;


-- 데이터를 삭제한 결과를 물리적으로 영구히 저장하기 위해서 COMMIT 수행
COMMIT;

SELECT * FROM dept01;

-- COMMIT 을 수행해서 영구저장 했기 때문에 ROLLBACK을 해도 삭제 이전의 상태로 되돌릴 수 없습니다
ROLLBACK;

SELECT * FROM dept01;



/*
AUTO COMMIT
- DDL 문(REATE, ALTER, DROP, RENAME, TRUNCATE 등)은 자동으로 COMMIT 을 실행합니다
 */

-- 연습용 테이블 생성
SELECT * FROM tab;
DROP TABLE dept02;
CREATE TABLE dept02 AS SELECT * FROM dept;
SELECT * FROM dept02;


-- 부서번호 40번 삭제
DELETE FROM dept02
WHERE deptno= 40;

SELECT * FROM dept02;


-- dept 테이블과 동일한 내용을 갖는 dept03 테이블 생성
CREATE TABLE dept03 AS SELECT * FROM dept;

ROLLBACK;


-- ROLLBACK 명령문을 수행하였지만, 이미 수행한 CREATE 문 때문에 
-- 자동 커밋이 발생해서 복구 되지 않습니다
SELECT * FROM dept02;

----------------------------------------------------

-- dept03 테이블에서 부서번호 10번 삭제
DELETE FROM dept03 WHERE deptno=10;

SELECT * FROM dept03;


-- 잘못된 테이블명으로 TRUNCATE 문 실행
TRUNCATE TABLE dept00;

ROLLBACK;

-- TRUNCATE 문이 실행되면서 자동 커밋 발생하면서 복구 되지 않습니다
SELECT * FROM dept03;


/*
SAVEPOINT
- 현재의 트랜잭션을 작게 분할하는 명령어 입니다
- 저장된 SAVEPOINT 는 ROLLBACK TO SAVEPOINT 문을 사용해서 표시한 곳까지 ROLLBACK 할 수 있습니다
- 여러개의 SQL문의 실행을 진행하는 트랜잭션의 경우,
  사용자가 중간 단계에서 SAVEPOINT 를 지정할 수 있습니다
  이 SAVEPOINT는 차후 롤백과 함께 사용해서 현재 트랜잭션 내의 특정 SAVEPOINT 까지 롤백할 수 있습니다
**/

-- 연습용 테이블 생성
SELECT * FROM tab;
DROP TABLE dept01;
CREATE TABLE dept01 AS SELECT * FROM dept;
SELECT * FROM dept01;

-- 트랜잭션 중간 단계에서 SAVEPOINT 지정하기
-- 40번 부서 삭제
-- COMMIT
-- 30번 부서 삭제
-- SAVAPOINT S1
-- 20번 부서 삭제
-- SAVEPOINT S2
-- 10번 부서 삭제

-- 40번 부서 삭제후 COMMIT
DELETE FROM dept01 WHERE deptno=40;

COMMIT;

SELECT * FROM dept01;


-- 30번 부서 삭제후 SAVEPOINT S1 설정
DELETE FROM dept01 WHERE deptno=30;

SELECT * FROM dept01;

SAVEPOINT S1;


-- 20번 부서 삭제후 SAVEPOINT S2 설정
DELETE FROM dept01 WHERE deptno=20;

SELECT * FROM dept01;

SAVEPOINT S2;


-- 10번 부서 삭제
DELETE FROM dept01 WHERE deptno=10;

SELECT * FROM dept01;


-- SAVEPOINT S1 까지 ROLLBACK 수행
ROLLBACK TO S1;

SELECT * FROM dept01;


-- SAVEPOINT S2 까지 ROLLBACK 수행
ROLLBACK TO S2;

SELECT * FROM dept01;











