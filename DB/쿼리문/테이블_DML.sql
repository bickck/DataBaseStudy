

/*
INSERT
- 테이블에 새로운 내용을 추가할 때 사용합니다
- INSERT INTO table_name
  (column_name, .....)
  values(column_value, .....);
 */


/*
- 연습용 테이블 생성
CREATE TABLE dept01
AS
SELECT * FROM dept WHERE 1=0;

DESC dept01;
*/


-- 새로운 데이터를 추가하기 위해서 사용하는 명령어 INSERT INTO VALUES~ 는
-- 괄호안의 컬럼명에 있는 목록의 수와 VALUES 다음에 나오는 괄호에 기술한 값의 개수가 같아야 합니다
INSERT INTO dept01
(deptno, dname, loc)
VALUES(10, 'accounting', 'new york');

SELECT * FROM dept01;


-- 컬럼수와 VALUES 다음에 작성한 값의 수가 다르면 error
-- INSERT INTO dept01(deptno, dname, loc) VALUES(10, 'accounting');
-- INSERT INTO dept01(deptno, dname, loc) VALUES(10, 'accounting', 'loc', 1);

-- 컬럼명이 달라도 error
-- INSERT INTO dept01(deptno, name, loc) VALUES(10, 'accounting', 'kor');

-- 컬럼의 입력할 값의 데이터 타입이 달라도 error
-- INSERT INTO dept01(deptno, dname, loc) VALUES(10, accounting, 'kor');


-- 모든 컬럼에 데이터를 입력하는 경우에는 컬럼 목록을 기술하지 않아도 됩니다
-- 컬럼 목록이 생략되면 VALUES 절 다음의 값들이 테이블의 기본 컬럼 순대로 입력됩니다
DESC dept01;

INSERT INTO dept01 VALUES(50, 'programming', 'kor');


INSERT INTO dept01(deptno, dname) VALUES(60, 'AI');
INSERT INTO dept01(loc, deptno, dname) VALUES('서울', 70, '개발');


/*
NULL 값 추가
- NULL 또는 '' 사용
 */
INSERT INTO dept01 VALUES(40, 'operations', NULL);
SELECT * FROM dept01;


INSERT INTO dept01 VALUES(40, '', NULL);
SELECT * FROM dept01;


/*
서브 쿼리로 데이터 추가하기
 */

-- dept 테이블의 구조만 복사해서 dept02 테이블 생성
CREATE TABLE dept02
AS
SELECT * FROM dept WHERE 1=0;

SELECT * FROM dept02;


-- 서브 쿼리를 사용해서 로우 복사
INSERT INTO dept02
SELECT * FROM dept;

SELECT * FROM dept02;


/*
INSERT ALL 을 사용한 다중 행 입력
- 주의할 점은 서브 쿼리의 컬럼명과 데이터가 입력되는 테이블의 컬럼명이 동일해야 합니다
 */

-- 사원번호, 사원명, 입사일자를 관리하는 emp_hir 테이블 생성
CREATE TABLE  emp_hir
AS
SELECT empno, ename, hiredate FROM emp WHERE 1=0;

SELECT * FROM emp_hir;

-- 사원번호, 사원명, 해당관리자(상관)를 관리하는 emp_mgr 테이블 생성
CREATE TABLE  emp_mgr
AS
SELECT empno, ename, mgr FROM emp WHERE 1=0;

SELECT * FROM emp_mgr;

-- 20번 부서의 데이터를 emp_hir 테이블 추가
INSERT INTO emp_hir 
SELECT empno, ename, hiredate 
FROM emp 
WHERE deptno=20;

SELECT * FROM emp_hir;

-- 20번 부서의 데이터를 emp_mgr 테이블 추가
INSERT INTO emp_mgr 
SELECT empno, ename, mgr 
FROM emp 
WHERE deptno=20;

SELECT * FROM emp_mgr;


-- 데이터 삭제
DELETE FROM emp_hir;
SELECT * FROM emp_hir;

DELETE FROM emp_mgr;
SELECT * FROM emp_mgr;


-- INSERT ALL 명령문을 사용해서 하나의 쿼리문으로 두개의 테이블에 원하는 컬럼 값을 입력
INSERT ALL
INTO emp_hir VALUES( empno, ename, hiredate)
INTO emp_mgr VALUES( empno, ename, mgr)
SELECT empno, ename, hiredate, mgr
FROM emp
WHERE deptno=20;

SELECT * FROM emp_hir;
SELECT * FROM emp_mgr;


/*
INSERT ALL ~ 조건(WHEN) 으로 다중 테이블에 다중 행 입력
 */

-- 사원번호, 사원명, 입사일자를 관리하는 emp_hir01 테이블 생성
CREATE TABLE  emp_hir01
AS
SELECT empno, ename, hiredate FROM emp WHERE 1=0;

SELECT * FROM emp_hir01;

-- 사원번호, 사원명, 급여를 관리하는 emp_sal 테이블 생성
CREATE TABLE  emp_sal
AS
SELECT empno, ename, sal FROM emp WHERE 1=0;

SELECT * FROM emp_sal;


-- emp_hir01 테이블에는 1982년 1월 1일 이후에 입사한 사원들의 정보 추가
-- emp_sal 테이블에는 급여가 2000 이상인 사원들의 정보 추가
INSERT ALL
WHEN hiredate > '1982/01/01' THEN
INTO emp_hir01 VALUES(empno, ename, hiredate)
WHEN sal > 2000 THEN
INTO emp_sal VALUES(empno, ename, sal)
SELECT empno, ename, hiredate, sal
FROM emp;

SELECT * FROM emp_hir01;
SELECT * FROM emp_sal;


/*
UPDATE
- 테이블에 저장된 데이터를 수정할 때 사용합니다
  UPDATE table_name
  SET column_name = value, .....
  WHERE conditions;
- WHERE 절을 지정하면 특정 행의 값이 수정되고, 사용하지 않으면 모든 행이 수정됩니다
  
 */

-- 연습에 사용 할 테이블 생성
DROP TABLE emp01;

CREATE TABLE emp01 AS SELECT * FROM emp;

SELECT * FROM emp01;

-- 모든 사원의 부서번호를 30번으로 수정
UPDATE emp01
SET deptno=30;

SELECT * FROM emp01;


-- 모든 사원의 급여를 10% 인상
UPDATE emp01
SET sal = sal * 1.1;

SELECT * FROM emp01;


-- 모든 사원의 입사일을 오늘로 변경
UPDATE emp01
SET hiredate = SYSDATE;

SELECT * FROM emp01;


/*
특정 행만 수정
 */

-- 연습에 사용하는 테이블 생성
DROP TABLE emp01;

CREATE TABLE emp01 AS SELECT * FROM emp;

SELECT * FROM emp01;

-- 부서번호가 10번인 사원의 부서번호를 30번으로 수정
UPDATE emp01
SET deptno=30
WHERE deptno=10;

SELECT * FROM emp01;


-- 급여가 3000 이상인 사원의 급여만 10% 인상
UPDATE emp01
SET sal = sal * 1.1
WHERE sal >= 3000;

SELECT * FROM emp01;


-- 1982년도에 입사한 사원의 입사일을 오늘로 변경
UPDATE emp01
SET hiredate = SYSDATE
WHERE substr(hiredate, 1, 2)='82';

SELECT * FROM emp01;


/*
2개 이상의 컬럼 값 변경
- 기존 SET 절에 콤마(,)를 추가하고 '컬럼=값'을 추가하면 됩니다
 */

-- SMITH 사원의 부서번호는 40번으로, 직급은 MANAGER로 한번에 수정
UPDATE emp01
SET deptno=40, job='MANAGER'
WHERE ename='SMITH';

SELECT * FROM emp01;


-- SMITH 사원의 입사일자 오늘로, 급여를 100으로, 커미션을 4000으로 수정
UPDATE emp01
SET hiredate = SYSDATE, sal = 100, comm = 4000
WHERE ename = 'SMITH';

SELECT * FROM emp01;


/*
서브 쿼리를 이용한 데이터 수정
- UPDATE 문의 SET 절에서 서브 쿼리를 작성하면, 서브 쿼리를 실행한 결과로 내용이 변경됩니다
 */

-- 연습에 사용하는 테이블 생성
SELECT * FROM tab;

DROP TABLE dept01;

CREATE TABLE dept01 AS SELECT * FROM dept;

SELECT * FROM dept01;

-- 20번 부서의 지역명을 40번 부서의 지역명으로 변경
UPDATE dept01
SET loc=(SELECT loc
         FROM dept01
         WHERE deptno=40)
WHERE deptno=20;

SELECT * FROM dept01;


-- 부서번호가 20번인 부서의 부서명과 지역명 부서번호 30번과 동일하게 변경
UPDATE dept01
SET (dname, loc) = (SELECT dname, loc
                    FROM dept01
                    WHERE deptno=30)
WHERE deptno=20;                   

SELECT * FROM dept01;


/*
DELETE
- 테이블에 저장되어 있는 데이터를 삭제합니다
  DELETE FROM table_name
  WHERE conditions;
- 특정 로우(행)을 삭제하기 위해서는 WHERE 절을 이용해서 조건을 지정합니다
  만약, WHERE 절을 사용하지 않을 경우 모든 행이 삭제되기 때문에 주의해야 합니다
  
 */

-- 연습에 사용하는 테이블 생성
SELECT * FROM tab;

DROP TABLE dept01;

CREATE TABLE dept01 AS SELECT * FROM dept;

SELECT * FROM dept01;


-- dept01 테이블의 모든 데이터 삭제
DELETE FROM dept01;

SELECT * FROM dept01;


-- dept01 테이블의 부서번호 30번 삭제
DELETE FROM dept01
WHERE deptno=30;

SELECT * FROM dept01;


/*
서브 쿼리를 이용한 데이터 삭제
 */

-- 사원테이블(emp01)에서 부서명이 SALES인 사원을 모두 삭제
DELETE FROM emp01
WHERE deptno=(SELECT deptno
              FROM dept
              WHERE dname='SALES');

SELECT * FROM emp01;



/*
MERGE
- 구조가 같은 두개의 테이블을 하나의 테이블로 합치는 기능을 합니다
  > 기존에 존재하는 행이 있으면 새로은 값으로 갱신(update) 되고
    존재하지 않으면 새로운 행으로 추가(insert) 됩니다
 */

-- 연습에 사용 할 테이블 생성
DROP TABLE emp01;

CREATE TABLE emp01 AS SELECT * FROM emp;

SELECT * FROM emp01;


-- 직급이 MANAGER 인 사원들로만 구성된 emp02 테이블 생성
DROP TABLE emp02;

CREATE TABLE emp02 AS SELECT * FROM emp WHERE job='MANAGER';

SELECT * FROM emp02;


-- MERGE 문에 의해서 기존에 존재하는 행이 갱신(UPDATE) 되는지 보기 위해서
-- 새로 생성된 emp02 테이블의 job 을 'TEST'로 변경
UPDATE emp02 SET job='TEST';

SELECT * FROM emp02;


-- MERGE 문에 의해서 새로운 행이 추가(INSERT) 되지는 보기 위해서 새로운 로우(행)을 추가
-- empno, ename, job, mgr, hiredate, sal, comm, deptno
INSERT INTO emp02
VALUES(7000, 'who?', 'code', 7839, '2000/01/01', 1100, 70, 20);

SELECT * FROM emp02;


-- emp01 테이블에 emp02 테이블을 합병
MERGE INTO emp01
USING emp02
ON(emp01.empno=emp02.empno)
WHEN MATCHED THEN
UPDATE SET emp01.ename = emp02.ename,
           emp01.job = emp02.job,
           emp01.mgr = emp02.mgr,
           emp01.hiredate = emp02.hiredate,
           emp01.sal = emp02.sal,
           emp01.comm = emp02.comm,
           emp01.deptno = emp02.deptno
WHEN NOT MATCHED THEN
INSERT VALUES(emp02.empno, emp02.ename, emp02.job, emp02.mgr, 
              emp02.hiredate, emp02.sal, emp02.comm, emp02.deptno);

SELECT * FROM emp01;


-------------------------------------------------------------------------------

-- emp 테이블의 empno, ename, job, sal 컬럼 이름만 적용된 sam01 테이블을 생성하세요
-- 이미 있으면 테이블 삭제후에 생성하세요


-- sam01 테이블에 데이터 3개를 추가하세요
-- (1000, 'APPLE', 'POLICE', 10000);
-- (1010, 'BANANA', 'NURSE', 15000);
-- (1020, 'ORANGE', 'DOCTOR', 25000);


-- sam01 테이블에 job 은 null 인 데이터를 2개 추가하세요


-- sam01 테이블에 emp 테이블의 부서번호 10번의 사원 정보를 추가하세요


-- sam01 테이블의 사원 중 급여가 5000 이상인 사원들의 급여를 3000 씩 삭감하세요


-- 서브 쿼리문을 사용해서 emp 테이블에 저장된 ename, sal, hiredate, deptno 컬럼을 적용한
-- sam02 테이블을 생성하세요


-- sam02 테이블의 DALLAS 에 위치한 부서 소속의 사원들 급여를 1000 인상하세요


-- 서브 쿼리문을 사용해서 sam02 테이블의 모든 사원의 급여와 입사일을 
-- 이름이 KING 인 사원의 급여와 입사일로 변경하세요


-- sam01 테이블에서 직급이 정해지지 않은 사원을 삭제하세요


-- sam02 테이블에서 RESEARCH 부서 소속 사원들만 삭제하세요































































