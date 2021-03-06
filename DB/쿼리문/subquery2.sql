

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


------------------------------------------------------------------------------

/* Quiz */
              
select * from emp;
select * from dept;

-- DALLAS 에서 근무하는 사원의 이름, 부서번호를 출력하세요
SELECT ename, deptno
FROM emp
WHERE deptno=(SELECT deptno
              FROM dept
              WHERE loc='DALLAS');


-- SALES 부서에서 근무하는 모든 사원의 이름과 급여를 출력하세요
SELECT ename, sal
FROM emp
WHERE deptno=(SELECT deptno
              FROM dept
              WHERE dname='SALES');
              

-- 직속상관이 KING 인 사원의 이름과 급여를 출력하세요
SELECT ename, sal
FROM emp
WHERE mgr=(SELECT empno
           FROM emp
           WHERE ename='KING');
           

-- 사원테이블에서 최대 급여액과 최대 급여를 받는 사원을 출력하세요
SELECT ename, sal
FROM emp
WHERE sal=(SELECT MAX(sal)
           FROM emp);
           

-- emp 테이블에서 20번 부서의 최소 급여보다 많은 모든 부서를 출력하세요
SELECT deptno, MIN(sal)
FROM emp
GROUP BY deptno
HAVING MIN(sal) > (SELECT MIN(sal)
                   FROM emp
                   WHERE deptno=20);


--=============================================================================

                   
/*
다중 행 서브 쿼리
- 서브쿼리에서 반환되는 결과가 하나 이상일 때 사용하는 서브퀄리 입니다
- 다중 행 서브쿼리는 반드시 다중 행 연산자와 함께 사용해야 합니다
  > IN, ANY, ALL, EXIST
 */

/*
IN
- 메인 쿼리의 비교 조건이 서브 쿼리 결과 중에서 하나라도 일치하면 참입니다
 */

-- 연봉을 3000이상 받는 사원이 소속된 부서와 동일한 부서에서 근무하는 사원의 정보 출력
SELECT ename, sal, deptno
FROM emp
WHERE deptno IN (SELECT DISTINCT deptno
                 FROM emp
                 WHERE sal >= 3000);


/*
ANY, SOME
- 메인 쿼리의 비교 조건이 서브 쿼리의 검색 결과와 하나 이상이 일치하면 참입니다
- ANY는 찾아진 값에 대해서 하나라도 크면 참이 됩니다
  그러므로, 찾아진 값 중에서 가장 작은 값 즉, 최소값 보다 크면 참입니다
  > ANY : 찾아진 값에 대해서 하나라도 크면 참 -> 최소값 반환
  < ANY : 찾아진 값에 대해서 하나라도 작으면 참 -> 최대값 반환
 */

-- 부서번호가 30번인 사원들의 급여 중 가장 작은 값보다 많은 급여를 받는 사원의 이름, 급여 출력
SELECT ename, sal
FROM emp
WHERE sal > ANY(SELECT sal
                FROM emp
                WHERE deptno=30);


/*
ALL
- ALL 조건은 메인 쿼리의 비교 조건이 서브 쿼리의 검색 결과와 모든 값이 일치하면 참입니다
- 검색한 값에 AND 연산을 해서 모두 참이면 참이 되는 것입니다
 */

-- 30번 소속 사원들 중에서 급여를 가장 많이 받은 사원보다 더 많은 급여를 받는 사람의 이름, 급여를 출력
SELECT ename, sal
FROM emp
WHERE sal > ALL (SELECT sal
                 FROM emp
                 WHERE deptno=30);


/*
EXISTS
- 메인 쿼리의 비교 조건이 서브 쿼리의 결과 중에서 만족하는 값이 하나라도 존재하면 참입니다
- IN 과의 차이점 : IN 연산자는 실제 존재하는 데이터들의 모든 값까지 확인하지만,
                   EXISTS 연산자는 해당 행이 존재하는지의 여부만 확인하는 연산자 입니다
- EXITSTS 의 부정은 NOT EXITSTS 를 사용합니다                   
 */

-- emp 테이블에 있는 deptno 와 서브 쿼리문에 있는 dept 테이블의 deptno를 조인해서,
-- deptno가 10, 20 이 있으면 emp 테이블 내에 있는 이름, 부서번호, 급여를 출력
SELECT ename, deptno, sal
FROM emp E
WHERE EXISTS (SELECT 1 -- 해당 테이블의 행의 갯수 만큼 1로 된 행을 출력
              FROM dept D
              WHERE D.deptno IN (10, 20)
              AND E.deptno = D.deptno);

-- NOT EXISTS 연산자는 메인 쿼리문의 컬럼명과 서브 쿼리문의 컬럼명을 비교해서 일치하지 않으면,
-- 메인 쿼리 테이블의 모든 행을 반환 합니다              
SELECT ename, deptno, sal
FROM emp E
WHERE NOT EXISTS (SELECT 1 -- 해당 테이블의 행의 갯수 만큼 1로 된 행을 출력
                  FROM dept D
                  WHERE D.deptno = 40
                  AND E.deptno = D.deptno);


-----------------------------------------------------------------------------

select * from emp;

-- 부서별로 가장 급여를 많이 받는 사원의 정보(사원번호, 사원이름, 급여, 부서번호)를 출력하세요
SELECT empno, ename, sal, deptno
FROM emp
WHERE sal IN(SELECT MAX(sal)
             FROM emp 
             GROUP BY deptno);
             
                  
-- 직급(job)이 MANAGER 인 사람이 속한 부서의 부서번호, 부서명, 지역을 출력하세요
SELECT deptno, dname, loc
FROM dept
WHERE deptno IN (SELECT deptno
                 FROM emp
                 WHERE job='MANAGER');
             
                  
-- 영업 사원들의 최소 급여보다 많이 받는 사원들의 이름, 급여, 직급을 출력하세요
-- 영업 사원은 출력하지 않습니다
SELECT ename, sal, job
FROM emp
WHERE sal > ANY (SELECT MIN(sal)
                 FROM emp
                 WHERE job='SALESMAN')
AND job <> 'SALESMAN';


-- 영업 사원들 보다 급여를 많이 받는 사원들의 이름, 급여, 직급을 출력하세요
SELECT ename, sal, job
FROM emp
WHERE sal > ALL(SELECT sal
                FROM emp
                WHERE job='SALESMAN');
                

-- emp 테이블에서 30번 부서의 최고 급여를 받는 사원 보다 많은 급여를 받는 사원의 정보
-- 사원번호, 이름, 업무, 입사일자, 급여, 부서번호를 출력하세요. 30번은 제외
SELECT empno, ename, job, hiredate, sal, deptno
FROM emp
WHERE deptno != 30 
AND sal > ALL(SELECT sal
              FROM emp
              WHERE deptno=30);
              

-- emp 테이블에서 적어도 한명의 사원으로부터 보고를 받을 수 있는 사원의 정보
-- 사원번호, 이름, 업무, 입사일자, 급여를 출력하세요
-- 사원번호 순으로 내림차순 정렬합니다                  
SELECT empno, ename, job, hiredate, sal
FROM emp E
WHERE EXISTS (SELECT * 
              FROM emp
              WHERE E.empno = mgr)
ORDER BY empno;

                  
                  
                  
                  
                  
                  
                  
                  
                  
                  
                  
                  
                  
                  
                  
                  
                  
                  
                  
                  
                  
                  
                  




