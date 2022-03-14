
/*
# 함수
- 단일행 함수 : 여러건의 데이터를 한번에 하나씩만 처리하는 함수입니다
- 여러행 함수 : 여러건의 데이터 동시에 입력받아서 결과값 한건을 만들어는 주는 함수 입니다
*/

-- DUAL 테이블
-- 한행으로 결과를 출력하기 위한 테이블 입니다

-- 연산 결과를 한줄로 얻기 위해서 오라클에서 제공하는 테이블 입니다
SELECT 24*12 FROM DUAL;

-- DUAL 테이블은 DUMMY라는 하나의 컬럼으로 구성되어 있습니다
DESC DUAL;

-- DUAL 테이블은 DUMMY라는 하나의 컬럼에 X라는 단 하나의 로우만을 저장하고 있지만, 의미없는 값입니다
-- 쿼리문의 수행 결과를 하나의 로우로 출력되게 하기 위해서 하나의 로우를 구성하고 있는 것입니다
SELECT * FROM DUAL;


/*
숫자 함수 
*/

-- ABS
-- 절대값을 구하는 함수입니다
SELECT -10, ABS(-10) 
FROM DUAL;


-- FLOOR
-- 소수점 아래를 버리는 함수입니다
SELECT 12.1234, FLOOR(12.1234)
FROM DUAL;


-- ROUND
-- 반올림하는 함수입니다
SELECT 34.5678, ROUND(34.5678)
FROM DUAL;

-- ROUND 함수는 지정한 자릿수에서 반올림이 가능합니다
-- ROUND ( 대상, 자릿수 )
SELECT 34.5678, ROUND(34.5678, 2)
FROM DUAL;


-- TRUNC
-- 지정한 자릿수 이하를 버린 결과입니다
-- 함수의 2번째 인자값이 2이면, 소주점 이하 세번째 자리에서 버림연산을 합니다
SELECT TRUNC(34.5678, 2), TRUNC(34.5678)
FROM DUAL;


 -- MOD
 -- 나눗셈 연산을 한후에 나온 나머지를 구하는 함수 입니다
 SELECT MOD(10, 3), MOD(10, 4)
 FROM DUAL;



/*
문자 함수 
*/

-- UPPER
-- 대문자로 변환하는 함수입니다
SELECT 'Hello Oracle', UPPER('Hello Oracle')
FROM DUAL;


-- LOWER
-- 소문자로 변환하는 함수입니다
SELECT 'Hello Oracle', LOWER('Hello Oracle')
FROM DUAL;


-- INITCAP
-- 문자열의 이니셜만 대문자로 변경합니다
SELECT 'HELLO ORACLE', INITCAP('HELLO ORACLE')
FROM DUAL;


-- LENGTH
-- 컬럼에 저장된 데이터의 값이 몇개의 문자로 되어있는지 계산합니다
SELECT LENGTH('ORALCE'), LENGTH('오라클')
FROM DUAL;

SELECT LENGTHB('ORALCE'), LENGTHB('오라클')
FROM DUAL;


-- SUBSTR
-- 문자열의 시작위치부터 선택 개수만큼의 문자를 추출합니다
-- SUBSTR( 대상, 시작위치, 추출할 갯수 )
-- > 오라클에서 index는 1부터 시작
SELECT SUBSTR('oracle string test', 8, 6)
FROM DUAL;

-- 시작위치 인자값에 음수를 적용할 수 있는데, 이때는 문자열의 뒤에서부터 시작위치가 적용됩니다
SELECT SUBSTR('oracle string test', -4, 4)
FROM DUAL;

SELECT hiredate FROM emp;

-- EMP 테이블에서 입사년도, 달만 출력
SELECT SUBSTR(hiredate, 1, 2) 년도, SUBSTR(hiredate, 4, 2) 달
FROM emp;

-- 12월에 입사한 사원을 출력
SELECT *
FROM emp
WHERE SUBSTR(hiredate, 4, 2)='12';


-- INSTR
-- 특정 문자가 있는 위치를 알려줍니다
-- INSTR( 대상, 검색글자, 시작위치, 몇번째 검색 )
SELECT INSTR('step by step', 't')
FROM DUAL;

SELECT INSTR('step by step', 'e', 2)
FROM DUAL;

SELECT INSTR('step by step', 'e', 2, 2)
FROM DUAL;

SELECT INSTR('데이터베이스', '이')
FROM DUAL;


-- LPAD
-- 대상 문자열을 명시된 자릿수에서 오른쪽에 표시하고, 남은 왼쪽 자리들은 기호로 채웁니다
-- LPAD( 대상, 자릿수, 기호 )
SELECT LPAD('padding', 10, '#')
FROM DUAL;

SELECT RPAD('padding', 10, '#')
FROM DUAL;

-- LTRIM
-- 문자열의 왼쪽(앞)의 공백 문자들을 제거합니다
SELECT LTRIM('   trim test   ')
FROM DUAL;


-- RTRIM
-- 문자열의 오른쪽(뒤)의 공백 문자들을 제거합니다
SELECT RTRIM('   trim test   ')
FROM DUAL;


SELECT TRIM('   trim test   ')
FROM DUAL;


-- 특정 문자가 첫번째 문자이거나 마지막 글자이면 해당 문자들은 잘라내고 남은 문자열만 반환합니다
SELECT TRIM('a' FROM 'aaaOracleaa')
FROM DUAL;



/*
날짜 함수
 */

-- SYSDATE
-- 시스템의 현재 날짜를 반환하는 함수입니다
SELECT SYSDATE
FROM DUAL;


-- 날짜 연산
-- 날짜 + 숫자 : 그 날짜부터 그 기간만큼 지난 날짜를 계산
-- 날짜 - 숫자 : 그 날짜부터 그 기간만큼 이전 날짜를 계산
-- 날짜 - 날짜 : 두 날짜 사이의 기간을 계산
SELECT SYSDATE-1 어제, SYSDATE 오늘, SYSDATE+1 내일
FROM DUAL;


/*
ROUND 를 사용해서 포멧 모델 날짜를 반올림 할 수 있습니다
- 포멧 모델     단위
  DDD           일을 기준
  HH            시를 기준
  MONTH         월(16일을 기준)
*/

-- emp 테이블의 입사일자를 월을 기준으로 반올림
SELECT ename, hiredate, ROUND(hiredate , 'MONTH')
FROM emp;


-- TRUNC 함수에 포맷 형식을 적용해서 날짜를 잘라낼 수 있습니다
-- TRUNC( date, format )
-- emp 테이블의 입사일의 달을 기준으로 날짜 자르기
SELECT ename, hiredate, TRUNC(hiredate, 'MONTH')
FROM emp;


-- MONTHS_BETWEEN
-- 날짜와 날짜 사이의 개월수를 구합니다
-- MONTHS_BETWEEN( date1, date2 )
-- 각 직원들의 근무한 개월 수
SELECT ename, sysdate, hiredate, 
        MONTHS_BETWEEN(sysdate, hiredate)
FROM emp;

SELECT ename, sysdate, hiredate, 
        TRUNC( MONTHS_BETWEEN(sysdate, hiredate) )
FROM emp;


-- ADD_MONTHS
-- 특정 개월수를 더한 날짜를 구하는 함수입니다
-- ADD_MONTHS( date, number )

-- 입사일에서 6개월을 더한 날짜
SELECT ename, hiredate, ADD_MONTHS(hiredate, 6)
FROM emp;


-- NEXT_DAY
-- 날짜를 기준으로 최초로 돌아오는 요일에 해당하는 날짜를 반환하는 함수입니다
-- NEXT_DAY( date, 요일 )

-- 오늘을 기준으로 최초로 돌아오는 화요일
SELECT SYSDATE, NEXT_DAY(SYSDATE, '화요일')
FROM DUAL;


-- LAST_DAY
-- 해당 날짜가 속한 달의 마지막 날짜를 반화하는 날짜입니다

-- emp 테이블의 입사한 달의 마지막 날
SELECT hiredate, LAST_DAY(hiredate)
FROM emp;



/*
형변환 함수
- 숫자, 문자, 날짜의 데이터 타입을 다른 데이터 타입으로의 변환이 가능합니다
- TO_CHAR : 날짜 or 숫자 타입을 문자형으로 변환
  TO_DATE : 문자 타입을 날짜 타입으로 변환
  TO_NUMBER : 문자 타입을 숫자 타입으로 변환
 */

/*
TO_CHAR ( 날짜 데이터, '출력형식' )
- 출력형식 종류         의미
  YYYY                  년도(4자리)
  YY                    년도(2자리)
  MM                    월을 숫자로 표현
  MON                   월을 알파벳으로 표현
  DAY                   요일 표현
  DY                    요일을 약어로 표현
 */

-- 현재 날짜를 다른 형태로 출력
SELECT SYSDATE, TO_CHAR(SYSDATE, 'YYYY-MM-DD')
FROM DUAL;

-- emp 테이블의 사원 입사일에 요일 출력
SELECT hiredate, TO_CHAR(hiredate, 'YYYY.MM.DD DAY')
FROM emp;


/*
시간출력종류       의미
AM 또는 PM         오전(AM), 오후(PM)
HH 또는 HH12       시간(1 ~ 12)
HH24               24시간(0 ~ 23)
MI                 분
SS                 초
 */

-- 현재 날짜와 시간을 출력
SELECT TO_CHAR( SYSDATE, 'YYYY-MM-DD HH24:MI:SS') "현재 시간"
FROM DUAL;


/*
숫자 출력 형식
구분     의미
0        자릿수를 나타내며, 자릿수가 맞지 않을 경우 0으로 채운다
9        자릿수를 나타내며, 자릿수가 맞지 않을 경우 채우지 않는다
L        통화 기호를 앞에 표시
.        소수점
,        천단위 자리 구분 
 */

-- 숫자 12300을 문자 형태로 변환
SELECT TO_CHAR(12300)
FROM DUAL;

-- 자리 채우기
SELECT TO_CHAR(123456, '000000000'), TO_CHAR(123456, '999,999,999')
FROM DUAL;

-- 통화기호를 붙이면서, 천단위마다 , 출력
SELECT ename, sal, TO_CHAR(sal, 'L999,999')
FROM emp;

SELECT ename, sal, TO_CHAR(sal, '$999,999')
FROM emp;




-- TO_DATE
-- 문자열을 날짜 형식으로 변환합니다
-- TO_DATE( '문자', 'format' )

SELECT * FROM emp;


-- 숫자를 TO_DATE 함수를 사용해서 날짜형으로 변환
SELECT ename, hiredate 
FROM emp
WHERE hiredate = TO_DATE(19801217, 'YYYYMMDD');

-- 몇일이 지났는지 계산
SELECT TRUNC(SYSDATE - TO_DATE('2022/01/01', 'YYYY/MM/DD'))
FROM DUAL;


-- TO_NUMBER
-- 데이터를 숫자형으로 변환
-- 문자 '20,000' - '10,000' 숫자로 변환해서 계산
SELECT TO_NUMBER('20,000', '99,999') - TO_NUMBER('10,000', '99,999')
FROM DUAL;


---------------------------------------------------------------------

-- emp 테이블에서 사번이 홀수인 사람들을 검색해 보십시오
SELECT *
FROM emp
WHERE MOD(empno, 2)=1;


-- emp 테이블에서 이름을 소문자로 사용해서, 사원번호, 성명, 담당업무(소문자), 부서번호를 출력하세요
SELECT empno, ename, LOWER(job), deptno
FROM emp
WHERE LOWER(ename)='smith';


-- dept 테이블에서 첫글자만 대문자로 변환하여 모든 정보를 출력하세요
SELECT deptno, INITCAP(dname), INITCAP(loc)
FROM dept;


-- substr 함수를 이용해서 emp 테이블의 ename 컬럼의 마지막 문자 한개만 추출해서 
-- 이름이 E로 끝나는 사원을 출력하세요
SELECT * 
FROM emp
WHERE SUBSTR(ename, -1, 1)='E';

SELECT *
FROM emp
WHERE ename LIKE '%E';


-- emp 테이블에서 이름의 세번째 자리가 R인 사원을 검색해서 출력하세요
SELECT *
FROM emp
WHERE SUBSTR(ename, 3, 1)='R';

SELECT *
FROM emp
WHERE ename LIKE '__R%';


-- emp 테이블에서 20번 부서중 이름의 길이 및 급여의 자릿수를 
-- 사원번호, 이름, 이름의 자릿수, 급여, 급여의 자릿수를 출력하세요
SELECT empno, ename, LENGTH(ename), sal, LENGTH(sal)
FROM emp
WHERE deptno=20;


-- emp 테이블에서 현재까지 근무일 수가 몇일인지를, 근무일수가 많은 순서로 출력하세요
SELECT ename, hiredate, sysdate, TRUNC(sysdate-hiredate) "근무일수"
FROM emp
ORDER BY TRUNC(sysdate-hiredate) DESC;

SELECT ename, hiredate, sysdate, TRUNC(sysdate-hiredate) "근무일수"
FROM emp
ORDER BY "근무일수" DESC;



/*
DECODE 
- switch case 문과 같은 기능을 합니다
- DECODE (
      표현식, 조건1, 결과1,
              조건2, 결과3,
              기본결과
  )
 */

select deptno from emp;

-- emp 테이블에서 부서번호에 해당되는 부서명을 구하기
SELECT ename, deptno,
	DECODE(deptno, 10, 'ACCOUNTING',
	               20, 'RESEARCH',
	               30, 'SALES')
	as "부서명"
FROM emp
ORDER BY "부서명";


SELECT ename, deptno,
	DECODE(deptno, 10, 'ACCOUNTING',
	               20, 'RESEARCH',
	               '기타')
	as "부서명"
FROM emp
ORDER BY "부서명";



/*
CASE
- 여러가지 경우에 대해서 하나를 선택하는 함수입니다
  다양한 비교 연산자를 이용해서 조건을 적용할 수 있습니다
  if ~ else if 와 유사합니다
- CASE 표현식 WHEN 조건1 THEN 결과1
              WHEN 조건2 THEN 결과2
              ELSE 결과n
  END     
 */

SELECT ename, deptno,
		CASE WHEN deptno<=10 THEN 'ACCOUNTING'
			 WHEN deptno<=20 THEN 'RESEARCH'
			 ELSE 'SALES'
		END as "부서명"
FROM emp; 










































