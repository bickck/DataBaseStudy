

/*
VIEW
- 물리적인 테이블을 이용한 논리적인 가상 테이블이라고 할 수 있습니다..
- 실질적으로 데이터를 저장하고 있지는 않더라도 사용자는 마치 테이블을 사용것과 동일하게
  view 를 사용할 수 있습니다
- view는 기본 테이블에 대한 하나의 쿼리문이고, 
  실제 테이블에 저장된 데이터를 뷰를 통해서 볼수 있습니다
- view 를 생성하기 위해서는 실질적으로 데이터를 저장하고 있는 
  물리적인 테이블이 존재해야 하는데 이 테이블을 기본 테이블이라고 합니다
 */

/*
단순뷰                     복합뷰
하나의 테이블로 생성       여러개의 테이블로 생성
그룹 함수의 사용 불가      그룹 함수의 사용 가능
DISTINCT 사용 불가         DISTINCT 사용 가능
DML 사용이 가능            DML 사용 불가
 */

/*
VIEW 정의
- CREATE VIEW veiw_name [(alias, .....)]
  AS 
  subquery;
  
  > subquery 에는 SELECT 문을 기술하면 됩니다
 */

-- view 생성 권한 부여
-- conn system/사용자 암호
-- GRANT CREATE VIEW TO 계정명
GRANT CREATE VIEW TO scott;


-- 연습용 테이블 생성
CREATE TABLE dept_copy AS SELECT * FROM dept;
CREATE TABLE emp_copy AS SELECT * FROM emp;

SELECT * FROM dept_copy;
SELECT * FROM emp_copy;


-- 부서번호 30번에 소속된 사원들의 사원번호, 이름, 부서번호 확인
SELECT empno, ename, deptno
FROM emp_copy
WHERE deptno=30;


-- 자주 사용되는 30번 부서에 소속된 사원들의 사원번호, 이름, 부서번호를 출력하기 위한
-- SELECT 문을 하나의 뷰로 정의
CREATE VIEW emp_view30
AS
SELECT empno, ename, deptno
FROM emp_copy
WHERE deptno=30;

SELECT * FROM emp_view30;


-- 단순 뷰를 이용한 데이터 조작
-- emp_view30 뷰를 이용한 데이터 조작
INSERT INTO emp_view30
VALUES(5000, 'view', 30);

SELECT * FROM emp_view30;

SELECT * FROM emp_copy;


-- 그룹 함수를 사용한 단수 뷰
-- 부서별 급여 총액과 평균
CREATE VIEW view_sal
AS
SELECT deptno, SUM(sal) AS "SalSum", AVG(sal) AS "SalAvg"
FROM emp_copy
GROUP BY deptno;

SELECT * FROM view_sal;


/*
복합 뷰
 */

-- 사원 테이블과 부서 테이블을 조인한 복합뷰 생성
-- 사원번호, 이름, 급여, 부서번호, 부서명, 지역명 출력하는 복합 뷰
CREATE VIEW emp_view_dept
AS
SELECT E.empno, E.ename, E.sal, E.deptno, D.dname, D.loc
FROM emp E, dept D
WHERE E.deptno = D.deptno
ORDER BY empno DESC;

SELECT * FROM emp_view_dept;


-- 뷰 삭제
DROP VIEW emp_view30;


/*
뷰 수정
- CREATE OR REPLACE VIEW 를 사용하면 존재하지 않는 뷰이면 새로운 뷰를 생성하고,
  기존에 존재하는 뷰이면 그 내용을 변경합니다
 */

-- emp_view30에 급여, 커미션 추가
CREATE OR REPLACE VIEW emp_view30
AS
SELECT empno, ename, sal, comm, deptno
FROM emp_copy
WHERE deptno=30;

SELECT * FROM emp_view30;


/*
ROWNUM 컬럼
- 조회된 값에 번호를 부여할 때 사용합니다
 */

SELECT ROWNUM, E.*
FROM emp_copy E;


SELECT ROWNUM, empno, ename, hiredate
FROM emp;


SELECT ROWNUM, empno, ename, hiredate
FROM emp
ORDER BY hiredate;


-- 뷰와 ROWNUM 컬럼으로 TOP-N 구하기
-- TOP-N 은 일련의 출력데이터를 임의의 순서로 정렬한 후에 
-- 그중 일부의 데이터만 출력해서 구합니다

-- 일사일을 기준으로 오름차순 정렬한 뷰 생성
CREATE OR REPLACE VIEW view_hire
AS
SELECT empno, ename, hiredate
FROM emp
ORDER BY hiredate;

-- 입사일이 빠른 사람 순서로 5명 조회
SELECT ROWNUM, empno, ename, hiredate
FROM view_hire
WHERE ROWNUM <= 5;


/*
인라인 뷰
- 메인 쿼리의 SELECT 문의 FROM 절 내부에 사용된 서브 쿼리문 입니다
- SELECT ...
  FROM ... ( SELECT ...);
 */

-- 인라뷰를 사용해서 입사일이 빠른 사람 10명 조회
SELECT ROWNUM, empno, ename, hiredate
FROM (SELECT empno, ename, hiredate
      FROM emp
      ORDER BY hiredate)
WHERE ROWNUM<=10;


-----------------------------------------------------------------------------


-- 각 부서별 최대 급여와 최소 급여를 출력하는 sal_view 를 작성하세요
CREATE VIEW sal_view
AS
SELECT D.dname AS "부서명", MAX(E.sal) AS "최대급여", MIN(E.sal) AS "최소급여"
FROM emp_copy E, dept_copy D
WHERE E.deptno = D.deptno
GROUP BY D.dname;

SELECT * FROM sal_view;


-- 인라인뷰를 사용해서 급여를 많이 받는 순서대로 5명을 출력하세요
SELECT ROWNUM, empno, ename, sal
FROM (SELECT empno, ename, sal
      FROM emp
      ORDER BY sal DESC) -- 급여를 내림 차순 정렬한 인라인 뷰
WHERE ROWNUM <= 5;











































