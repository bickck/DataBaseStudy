

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













































































