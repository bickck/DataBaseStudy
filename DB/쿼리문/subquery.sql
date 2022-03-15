

/*
서브쿼리 ( subquery )
- 서브쿼리는 하나의 select 문장 안에 또 하나의 select 문을 사용하는 것입니다
  그렇기 때문에 서브쿼리를 포함하고 있는 쿼리문을 메인 쿼리, 
  포함된 또 하나의 쿼리를 서브 쿼리라고도 합니다
- 서브 쿼리는 비교 연산자의 오른쪽에 작성해야 하고, 반드시 괄호로 묶어줘야 합니다
- 서브 쿼리는 메인 쿼리가 실행되기 전에 한번만 실행 됩니다
- 하나의 테이블에서 검색한 결과를 다른 테이블에 전달하여 새로운 결과를 검색합니다
 */

/*
단일행 서브 쿼리
- 결과를 하나의 행으로 반환 합니다
 */

-- s1
SELECT deptno
FROM emp
WHERE ename='SMITH';

-- s2
SELECT depeno
FROM dept
WHERE deptno=20;

-- 서브쿼리(s1)의 실행결과를 메인쿼리(s2)에게 리턴
-- 메인쿼리가 최종 실행결과(research)를 사용자에게 리턴
-- 서브쿼리는 메인쿼리가 필요한 값을 제공
-- 서브쿼리 : 테이블을 결합하는 방식이 아닌 쿼리 결합

-- smith 사원의 부서
SELECT dname
FROM dept
WHERE deptno = (SELECT deptno
                FROM emp
                WHERE ename='SMITH');

-- smith 와 같은 부서에 근무하는 사원의 이름과 부서 번호를 출력
SELECT ename, deptno
FROM emp
WHERE deptno = (SELECT deptno
                FROM emp
                WHERE ename='SMITH')
AND ename<>'SMITH';


-- 서브 쿼리에서 그룹 함수 사용
-- 평균 급여를 구하는 쿼리문을 서브 쿼리로 사용해서,
-- 사원들의 평균 급여보다 더 많은 급여을 받는 사원 검색
SELECT ename, sal
FROM emp
WHERE sal > (SELECT AVG(sal)
             FROM emp);


-- smith의 급여와 동일하거나 더 많이 받는 사원의 이름과 급여 확인
SELECT ename, sal
FROM emp
WHERE sal >= (SELECT sal
              FROM emp
              WHERE ename='SMITH');













































