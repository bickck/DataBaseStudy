
/*
그룹 함수
- 하나 이상의 행을 그룹으로 묶어서 하나의 결과로 나타냅니다
- SUM(누적 합계), AVG(평균), COUNT(총 개수), 
  MAX(최대값), MIN(최소값), STDDEV(표준편차), VARIANCE(분산)
- SELECT 문뒤에 작성하고, 여러 그룹 함수를 쉼표로 구분하여 함께 사용할 수 있습니다
  Ex) SELECT  group_function( column ), .....
      FROM table
- 그룹 함수는 다른 연산자와 달리 해달 컬럼 값이 NULL 인 것을 제외하고 계산합니다
 */

/*
SUM
- SUM 함수는 해당 컬럼 값들에 대한 총합을 구합니다
*/

-- 급여 총액
SELECT SUM(sal)
FROM emp;

-- 커미션 총액
SELECT SUM(comm)
FROM emp;


/*
AVG
- AVG 함수는 해당 커럼 값들에 대한 평균을 구합니다
*/
-- 급여 평균
SELECT AVG(sal)
FROM emp;


/*
MAX, MIN
- 지정한 컬럼 값 중에서 최대값, 최소값을 구합니다
 */
-- 가장 높은 급여와 낮은 급여
SELECT MAX(sal), MIN(sal)
FROM emp;


/*
COUNT
- 행의 개수를 반환합니다. 특정 컬럼을 지정하면, 해당 컬럼 값을 갖고 있는 행의 갯수를 계산합니다
 */
-- 커미션 받는 사원수
SELECT COUNT(comm)
FROM emp;


-- 전체 사원수와 커미션 받는 사원수
SELECT COUNT(*), COUNT(comm)
FROM emp;

-- 직업의 갯수
SELECT COUNT(job) "업무수"
FROM emp;

SELECT COUNT(DISTINCT job) "업무수"
FROM emp;


/*
GROUP BY 절
- 그룹함수를 사용하되 어떤 컬럼 값을 기준으로 그룹 함수를 적용할 수 있습니다
  Ex) SELECT 컬럼명, 그룹함수
      FROM 테이블명
      WHERE 조건
      GROUP BY 컬럼명;
- 합계, 평균등을 어떠한 컬럼을 기준으로 그 컬럼의 값 별로 보고자 할 때 
  GROUP BY 절 뒤에 해당 컬럼을 작성하면 됩니다
- GROUP BY 절 다음에는 컬럼의 별칭을 사용할 수 없고, 반드시 컬럼명을 사용해야 합니다  
 */

-- 사원 테이블을 부서번호로 그룹
SELECT deptno
FROM emp
GROUP BY deptno;

-- 부서별 평균 급여
SELECT deptno, AVG(sal)
FROM emp
GROUP BY deptno;

-- 부서별 최대 여, 최소 급여
SELECT deptno, MAX(sal), MIN(sal)
FROM emp
GROUP BY deptno;

-- 부서별 사원수와 커미션을 받는 사원수
SELECT deptno, COUNT(*), COUNT(comm)
FROM emp
GROUP BY deptno;

-- ORDER BY 는 항상 맨 마지막에 작성합니다
SELECT deptno, COUNT(*), COUNT(comm)
FROM emp
GROUP BY deptno
ORDER BY deptno asc;


/*
HAVING
- 조건을 사용해서 결과를 제한할 때에는 WHERE 절을 사용하지만,
  그룹의 결과를 제한할 때에는 HAVING 절을 사용합니다
  
 */
--Error
--SELECT deptno, AVG(sal)
--FROM emp
--WHERE AVG(sal) >= 2000
--GROUP BY deptno;

SELECT deptno, AVG(sal)
FROM emp
GROUP BY deptno
HAVING AVG(sal) >= 2000;


-- 최고 평균 급여
SELECT MAX(AVG(sal))
FROM emp
GROUP BY deptno;


--------------------------------------------------------------------

-- 가장 최근에 입사한 사원의 입사일과 가장 오래된 사원의 입사일을 출력하는 쿼리문을 작성하세요
SELECT MAX(hiredate) as "최근 입사한 사원", MIN(hiredate) as "오랜된 사원"
FROM emp;


-- 부서별 커미션 받는 사원의 수를 출력하세요
SELECT deptno, COUNT(comm)
FROM emp
GROUP BY deptno;

-- salesman 대한 급여의 평균, 최고액, 최저액, 합계를 출력하세요
SELECT AVG(sal), MAX(sal), MIN(sal), SUM(sal)
FROM emp
WHERE job LIKE 'SAL%';

SELECT AVG(sal), MAX(sal), MIN(sal), SUM(sal)
FROM emp
WHERE job LIKE 'SALESMAN';


-- 각 부서별로 인원수, 급여의 평균, 최저 급여, 최고 급여, 급여의 합을 구하고,
-- 급여의 합이 많은 순으로 출력하세요
SELECT deptno, COUNT(*), AVG(sal), MIN(sal), MAX(sal), SUM(sal)
FROM emp
GROUP BY deptno
ORDER BY SUM(sal) desc;

-- 업무별 급여의 평균이 3000 이상인 업무에 대해서 업무명, 평균 급여, 급여의 합을 출력하세요
SELECT job, AVG(sal), SUM(sal)
FROM emp
GROUP BY job
HAVING AVG(sal) >= 3000;

-- 전체 월급이 4000을 초과하는 각 업무에 대해서 업무와 월급여 합계를 출력하세요
-- 단 판매원은 제외하고 월급여 합계로 내림차순 정렬합니다
SELECT job, SUM(sal) 
FROM emp
WHERE job NOT LIKE 'SALE%'
GROUP BY job
HAVING SUM(sal) > 4000
ORDER BY SUM(sal) desc;



























