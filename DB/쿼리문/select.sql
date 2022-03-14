
-- 테이블 목록 확인 
-- '*' 은 전체를 뜻합니다
select * from tab;


-- 테이블 구조 확인
-- desc 테이블명
-- desc 명령어는 테이블의 컬럼이름, 데이터 형, 길이, NULL 허용 유무등과 같은 
-- 특정 테이블 정보를 알려줍니다

desc dept;  
-- DEPT 테이블 : 부서 정보
-- 칼럼 이름      의미
-- DEPTNO         부서번호
-- DNAME          부서명
-- LOC            지역명

DESC EMP;
-- EMP 테이블 : 직원 정보
-- 칼럼 이름      의미
-- EMPNO          사원번호
-- ENAME          사원이름
-- JOB            담당 업무   
-- MGR            해당 사원 상사 사원 번호
-- HIREDATE       입사일    
-- SAL            급여   
-- COMM           커미션  
-- DEPTNO         부서번호   



/*
오라클 자료형
- NUMBER : 숫자 데이터를 저장
  > NUMBER ( precision, scale )
    # precision 은 소수점 포함함 전체 자릿수를 의미하며, scale은 소수점 이하 자릿수를 지정합니다
    Ex) 정수 NUMBER(5)
        실수 NUMBER(10, 2) -> 10 : 소수점을 포함한 전체 자릿수
                               2 : 소수점 자릿수  
  DATE   : 날짜 및 시간
  
  CHAR   : 고정길이 문자 데이터 저장
  > CHAR ( 고정형 )
    # Ex) CHAR( 10 ) -> 10글자 확정
  
  VARCHAR2 : 가변길이 문자열 저장
  > VARCHAR2 ( 가변형 )
    # Ex) VARCHAR2( 10 ) -> 최대 10글자 가능하고, 저장되는 문자수 만크 공간 사용
 */


/*
< select 문 >
# select 문은 데이터를 조회하기 위한 SQL 명령어 입니다
  - 프로젝션 : query에 의해 반환되는 테이블의 열을 선택합니다. 
               필요한 수만큼 열을 선택 할 수 있습니다
    선택     : query에 의해 반환되는 테이블의 행을 선택합니다
               다양한 조건을 사용하여 검색되는 행을 제한할 수 있습니다
    조인     : 두 테이블 사이에 링크를 지정하여 서로 다른 테이블에 저장된 데이터를 함께 가져옵니다

# 형식
- SELELT [DISTINCT] { *, column[Alias], ... }
  FROM table_name;
  > SELECT 문은 반드시 SELECT 와 FROM 이라는 2개의 키워드로 구성되어야 합니다
    SELECT 절은 출력하고자 하는 칼럼 이름을 기술합니다
    특정 컬럼 이름 대신 * 을 기술할 수 있는데, * 은 테이블 내의 모는 컬럼을 출력하고자 할 경우에 사용합니다
    FROM 절 다음에는 조회하고자 하는 테이블 이름을 기술합니다
        
 */

-- 부서 테이블의 전체 목록
SELECT * FROM dept;

-- 특정 데이터만 보기
-- 부서 테이블의 부서번호, 부서이름 조회
SELECT deptno, dname 
FROM dept;

SELECT * FROM emp;

-- 산술 연산자
SELECT sal + comm FROM emp;
SELECT sal - 100 FROM emp;
SELECT sal * 12 FROM emp;
SELECT sal / 2 FROM emp;


/*
# NULL 
- 행의 특정 열에 데이터 값이 없는 경우 해당 값이 null 이거나 null을 포함한다고 합니다
- 모든 데이터 유형은 null을 포함 할 수 있습니다
- 0(zero)도 아니고, 빈 공간도 아닙니다
  미확정(해당 사항 없음), 알수 없는 값을 의미합니다
  어떤 값인지 알 수 없지만 어떤 값이 존재하고 있습니다
  ? 혹은 무한의 의미이므로 연산, 할당, 비교가 불가능 합니다  
 */

SELECT ename, sal, job, comm, sal*12, sal*12+comm
FROM emp;


/*
# NVL 함수
- 컬럼의 값이 null 값인 경우 지정한 값으로 출력하고, null 이 아니면 원래 값을 그대로 출력합니다
- NVL ( 컬럼명, 지정값 )
 */

SELECT ename, comm, sal*12+comm, NVL(comm, 0), sal*12+NVL(comm, 0)
FROM emp;


/*
# alias
- 열 머리글의 이름을 변경할 때 사용합니다
- 컬럼 이름 대신 별칭을 출력하고자 하면 컬럼을 기술한 바로 뒤에 AS 키워드를 사용한 후 별칭을 기술합니다
- 별칭을 부여할 때 대소문자를 섞어서 기술하면, 결과는 대문자로 출력됩니다
  이때, 대소문자를 구별하고 싶으면 " "을 사용합니다 
*/
SELECT ename, sal*12+NVL(comm, 0) as Annsal
FROM emp;

SELECT ename, sal*12+NVL(comm, 0) as "A n n s a l"
FROM emp;

-- 별칭으로 한글을 사용할 수 있습니다
SELECT ename, sal*12+NVL(comm, 0) as "연봉"
FROM emp;


/*
연결 연산자 ( concatenation ) - ||
- 여러개의 컬럼을 연결할 때 사용합니다
 */
SELECT ename, job
from emp; 

-- 리터럴은 SELECT 리스트에 포함된 문자, 숫자 또는 날짜입니다
-- 숫자 리터럴은 그냥 사용해도 되지만, 문자 및 날짜 리터럴은 외따옴표(' ')로 작성해야 합니다
SELECT ename || ' is a ' || job
from emp;

SELECT ename || ' 은(는) ' || job || ' 이다' as "업무"
from emp;

-- DISTINCT 
-- 기본적으로 쿼리 결과에는 중복 행을 포함한 모든 행이 표시됩니다
-- 이때 중복 행을 제거하려면 SELECT 키워드 바로 뒤에 DISTINCT 키워드를 사용합니다
SELECT deptno
FROM emp;

SELECT DISTINCT deptno
FROM emp;


/*- Quiz - */
SELECT * FROM emp;

-- 사원의 이름, 급여, 입사일자만 출력하는 쿼리문을 작성하세요
SELECT ename, sal, hiredate 
FROM emp;


-- 부서정보 테이블의 deptno 는 부서번호, dname 은 부서명으로 별칭을 부여한 쿼리문을 작성하세요
SELECT deptno as "부서번호", dname as "부서명"
FROM dept;


-- 사원정보 테이블의 직급이 중복되지 않고, 한번씩 나열되도록 하는 쿼리문을 작성하세요
SELECT DISTINCT job
FROM emp;


/*
# where 조건
- 원하는 행만 검색 할때는 행을 제한하는 조건을 SELECT 문에 WHERE 절을 추가합니다
- 형식
  SELECT * [ column, ...]
  FROM table_name
  WHERE 조건식 ;
- 비교연산자
  = 같다, > 크다 , < 작다 , >= 크거나 같다, <= 작거나 같다 , != 같지 않다
 */

SELECT * FROM emp;


-- 부서번호가 10 인 항목
SELECT * 
FROM emp
WHERE deptno = 10;

-- 이름이 ford인 사원의 사원번호, 사원이름, 급여 확인
-- sql에서 문자열이나 날짜는 반드시 외따옴표 안에 작성해야 합니다
-- 테이블 내에 저장된 값은 대소문자를 구분합니다
SELECT empno, ename, sal 
FROM emp
where ename='FORD';

-- 1982년 1월 1일 이전에 입사한 사원 확인
SELECT *
FROM emp
WHERE hiredate <= '1982/01/01';


/*
# 논리연산자
- and, or, not
 */
-- 10번 부서 소속이면서, 직급이 MANAGER 인 사람 확인
SELECT * 
FROM emp 
WHERE deptno=10 and job='MANAGER';

-- 10번 부서에 소속해 있거나, 직급이 MANAGER 인 직원 확인
SELECT * 
FROM emp 
WHERE deptno=10 or job='MANAGER';

-- 부서 번호가 10번이 아닌 직원 확인
SELECT * 
FROM emp 
WHERE not deptno=10;

SELECT * 
FROM emp 
WHERE deptno!=10;

-- 2000 ~ 3000 사이의 급여는 받는 사원 확인
SELECT *
FROM emp
WHERE sal>=2000 and sal<=3000;

-- BETWEEN AND 연산자
-- 특정범위의 값 확인
-- column_name BETWEEN a and b
SELECT *
FROM emp
WHERE sal BETWEEN 2000 AND 3000;

-- 1981년 3월 ~ 5월에 입사한 사원 확인
SELECT *
FROM emp
WHERE hiredate BETWEEN '1981/03/01' AND '1981/5/31';


/*
IN 연산자
- 테이블의 값을 확인합니다
- column_name IN( a, b, c )
**/
-- 커미션이 300 이거나, 500 이거나, 1400 인 사원 확인
SELECT *
FROM emp
WHERE comm in(300, 500, 1440);

/*
# LIKE 연산자와 와일드 카드
- 검색하는 값을 정확히 모를때에도 검색이 가능합니다
- column_name LIKE pattern
  > % : 0 개 이상의 문자
    _ : 임의의 단일문자
 */

-- emp 테이블에서 이름이 F로 시작하는 모든 항목 확인
SELECT *
FROM emp
WHERE ename LIKE 'F%';

-- emp 테이블에서 이름에 O가 들어가는 모든 항목 확인
SELECT *
FROM emp
WHERE ename LIKE '%O%';

-- emp 테이블에서 이름이 K로 시작하면서 4글자인 항목 확인
SELECT *
FROM emp
WHERE ename LIKE 'K___';

-- 이름에 A를 포함하지 않는 사람 검색
SELECT *
FROM emp
WHERE ename NOT LIKE '%A%';

-- emp 테이블에서 comm 컬럼의 값이 null인 항목 확인
SELECT *
FROM emp
WHERE comm is NULL;

-- emp 테이블에서 comm 컬럼의 값이 null값이 아닌 항목 확인
SELECT *
FROM emp
WHERE comm is NOT NULL;


/*
# ORDER BY 절 
- 데이터를 정렬할 때 사용합니다
- SELECT 문의 맨 마지막에 사용합니다
- 정렬방식을 지정하지 않으면, 기본적으로 오름차순 정렬합니다
-          ASC(오름차순)           DESC(내림차순)   
  숫자     작은값부터 정렬         큰값부터 정렬
  문자     사전순서로 정렬         사전 반대 순으로 정렬
  날짜     빠른 날짜 순서로 정렬   늦은 날짜 순서로 정렬
  NULL     가장 마지막에 나온다    가장 먼저 나온다
 */

-- emp 테이블의 급여를 기준으로 오름차순 정렬
SELECT *
FROM emp
ORDER BY sal;

-- emp 테이블의 급여를 기준으로 내림차순 정렬
SELECT *
FROM emp
ORDER BY sal DESC;

-- emp 테이블의 급여를 기준으로 내림차순 정렬 하고, 
-- 급여가 같으면 이름을 기준으로 오름차순 정렬
SELECT *
FROM emp
ORDER BY sal DESC, ename ASC;


/*- Quiz -*/

-- emp 테이블에서 급여가 3000 이상인 사원의 정보를 사원번호, 이름, 직급, 급여를 확인하는 쿼리문을 작성하세요
SELECT  empno, ename, job, sal
FROM emp
WHERE sal >= 3000;

-- emp 테이블에서 직급이 MANAGER인 사원의 정보를 사원번호, 성명, 담당업무, 급여, 부서번호를 확인하는 쿼리문을 작성하세요
SELECT empno, ename, job, sal, deptno
FROM emp
WHERE job="MANAGER";

-- emp 테이블에서 사원번호가 7902, 7788, 7566인 사원의 사원번호, 성명, 담당업무, 급여, 입사일자를 확인하는 쿼리문을 작성하세요
SELECT empno, ename, job, sal, hiredate
FROM emp
WHERE empno IN (7902, 7788, 7566);

select * from emp;


-- emp 테이블에서 job이 Manager, clerk 가 아닌 사원의 정보를 사원번호, 성명, 담당업무, 급여, 부서번호를 확인하는 쿼리문을 작성하세요
SELECT empno, ename, job, sal, deptno
FROM emp
WHERE job NOT IN ('MANAGER', 'Clerk');

-- emp 테이블에서 부서번호로 오름차순 정렬한 후에, 
-- 부서 번호가 같으면 급여가 많은 순으로 정렬하여 사원번호, 성명, 업무, 부서번호, 급여를 확인하는 쿼리문을 작성하세요
SELECT empno, ename, job, deptno, sal
FROM emp
ORDER BY deptno, sal DESC;



















