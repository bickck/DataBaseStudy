
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

SELECT * FROM emp;

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
















