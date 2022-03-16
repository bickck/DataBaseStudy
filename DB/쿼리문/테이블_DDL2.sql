

/*
DDL (Data Definition Language) : 테이블 생성, 수정, 삭제


create table
- 데이터를 저장하는 새로운 테이블을 생성합니다
  Ex) CREATE TABLE table_name (
      column_name, data_type expr,
      ..... 
      );
- 테이블 이름, 열 이름, 열 데이터 타입 및 크기를 지정합니다
 */

/*
데이터 타입
CHAR( size )
- 고정 길이 문자 데이터. 
  입력된 자료의 크기와 상관없이 정해진 크기만큼 저장 영역 차지. 최소 크기 1
  
VACHAR2( size )
- 가변 길이 문자 데이터
  입력된 자료의 크기만큼 저장 영역을 차지. 최대 크기는 명시해야 하며, 최소 크기 1
  
NUMBER
- 최고 40자리 까지의 숫자를 저장

NUMBER( w )
- w 자리까지의 수치로 최대 38자리가 유효 숫자 입니다

NUMBER( w, d )
- w 전체 길이, d 는 소수점 이하 자릿수입니다.
  소수점은 자릿수에 포함되지 않습니다
  
DATE 
- BC 4712년 1월 1일 ~ AD 4712년 12월 31일까지의 날짜

LONG
- 가변 길이의 문자형 데이터 타입. 최대 크기 2GB

LOB
- 2GB 까지의 가변 길이 바이너리 데이터를 저장시킬수 있습니다
  이미지 문서, 실행 파일을 저장할 수 있습니다
  
BFILE
- 대용량의 바이너리 데이터를 파일 형태로 저장. 최대 4GB  
*/

desc emp;

-- 사원테이블과 유사한 구조의 사원번호, 사원이름, 급여 3개의 컬럼으로 구성된 emp01 테이블 생성
CREATE TABLE emp01 (
empno NUMBER(4),
ename VARCHAR2(10),
sal NUMBER(7, 2)
);

DESC emp01;
DESCRIBE emp01;


-- CREATE TABLE 문에서 서브 쿼리를 사용하여 이미 있는 테이블과 동일한 구조와 내용을 갖는 
-- 새로운 테이블을 생성할 수 있습니다
CREATE TABLE emp02
AS 
SELECT * FROM emp;

DESC emp02;


-- 기존 테이블에서 원하는 컬럼만 선택적으로 복사해서 생성할 수도 있습니다
CREATE TABLE emp03
AS
SELECT empno, ename FROM emp;

DESC emp03;


-- 기존 테이블의 구조만 복사
-- WHERE 조건 절에 항상 거짓이 되는 조건을 지정하게 되면,
-- 테이블에서 얻어질 수 있는 행이 없게 되므로 빈 테이블이 생성되게 됩니다
CREATE TABLE emp04
AS
SELECT * FROM emp WHERE 1=0;

DESC emp04;


/*
ALTER TABLE
- 기존 테이블의 구조를 변경하기 위해서 사용되는 DDL 명령문 입니다
- 컬럼의 추가, 삭제, 컬럼의 타입이나 길이를 변경할 때 사용합니다
- 테이블의 구조를 변경하게 되면 기존에 저장되어 있던 데이터에 영향을 줍니다
- ADD COLUMN    : 새로운 컬럼 추가
  MODIFY COLUMN : 기존 컬럼 수정
  DROP COLUMN   : 기존 컬럼 삭제
 */

/*
ALTER TABLE ADD
- 기존 테이블에 새로운 컬럼을 추가합니다
- 새로운 컬럼은 테이블의 맨 마지막에 추가되므로, 자신이 원하는 위치에 만들어 넣을 수 없습니다
- ALTER TABLE table_name
  ADD ( column_name, data_type, ..... )
 */

SELECT * FROM tab;

-- emp01 테이블에 문자 타입의 직급(job) 컬럼 추가
ALTER TABLE emp01
ADD(job varchar2(9));

DESC emp01;
SELECT * FROM emp01;


-- 컬럼 이름 수정
-- ALTER TABLE 'table_name' RENAME COLUMN '컬럼명' to '수정 컬럼명';
ALTER TABLE emp04
RENAME COLUMN mgr to mgrno;

DESC emp04;


/*
ALTER TABLE MODIFY
- 기존 컬럼의 속성을 변경합니다
- 컬럼을 변경한다는 것은 컬럼에 대한 데이터 타입이나 크기 등을 변경하는 의미 입니다
- ALTER TABLE table_name
  MODIFY ( column_name, data_type, ..... );
 */

-- 직급(job) 컬럼을 최대 30글자까지 저장할 수 있게 변경
ALTER TABLE emp01
MODIFY(job VARCHAR2(30));

DESC emp01;


/*
ALTER TABLE ~ DROP COLUMN
- 테이블에 이미 사용중인 컬럼을 삭제 합니다
- ALTER TABLE table_name
  DROP COLUMN column_name;
 */

-- emp01 테이블의 직급 컬럼 삭제
ALTER TABLE emp01
DROP COLUMN job;

DESC emp01;


-- SET UNUSED 옵션
-- 컬럼을 삭제하는 것은 아니지만 컬럼의 사용을 논리적으로 제한하게 됩니다
-- UNUSECD 실행후에 다시 사용할 수 없습니다
ALTER TABLE emp02
SET UNUSED(job);

ALTER TABLE emp02
DROP UNUSED columns;

DESC emp02;


/*
테이블 삭제
- DROP TALBE '삭제 테이블';
 */

SELECT * FROM tab;

-- emp01 테이블 삭제( 휴지통 보관 )
-- DROP TABLE '삭제 테이블명';
DROP TABLE emp01;


-- 휴지통 데이터 조회
SELECT * FROM RECYCLEBIN;


-- 휴지통에 있는 테이블 복구
-- LASHBACK TABLE '복구 테이블명' TO BEFORE DROP;
FLASHBACK TABLE emp01 TO BEFORE DROP;


-- 휴지통 거치지 않고 삭제
-- DROP TABLE '삭제 테이블명' PURGE;
DROP TABLE emp01 PURGE;


-- PURGE 없이 삭제한 테이블 완전히 지우기
-- PURGE TABLE '삭제 테이블명';

/*
테이블의 모든 row(행) 삭제
- TRUNCATE TABLE table_name 
 */

SELECT * FROM emp02;

-- emp02 테이블의 모든 로우 삭제
TRUNCATE TABLE emp02;


/*
테이블 이름 변경
- RENAME '테이블명' TO '새로운 테이블명'
*/

-- emp02 테이블명 변경
RENAME emp02 TO newemp;

SELECT * FROM tab;


--------------------------------------------------------------------------------

-- 아래와 같은 구조를 가진 dept01 테이블을 생성하세요
-- 이름             유형
-- DEPTNO           NUMBER(2)
-- DNAME            VARCHAR(14)
-- LOC              VARCHAR(13)
CREATE TABLE dept01(
deptno NUMBER(2),
dname  VARCHAR2(14),
loc VARCHAR2(13)
);

DESC dept01;


-- emp 테이블을 복사하되 사원번호, 사원이름, 급여 컬럼으로 구성된 테이블을 생성하세요
CREATE TABLE empc
AS
SELECT deptno, ename, sal FROM emp;

SELECT * FROM empc;


-- dept 테이블과 동일한 구조의 빈 테이블 dept02 를 생성하세요
CREATE TABLE dept02
AS
SELECT * FROM dept WHERE 1=0;

DESC dept02;


-- dept02 테이블을 삭제하세요
DROP TABLE dept02;

SELECT * FROM tab;


-- dept 테이블과 동일한 구조의 빈 테이블 dept03 을 생성하세요
-- dept03 테입블에 문자 타입의 부서장(dmgr) 컬럼을 추가하세요( 크기 자유 )
CREATE TABLE dept03
AS
SELECT * FROM dept WHERE 1=0;

ALTER TABLE dept03
ADD(dmgr VARCHAR2(10));


-- dept03 테이블의 부서장 컬럼을 삭제하세요
ALTER TABLE dept03
DROP COLUMN dmgr;

DESC dept03;
































