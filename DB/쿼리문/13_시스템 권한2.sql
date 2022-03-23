

/*
데이터베이스 보안을 위한 권한
- 시스템 권한, 객체 권한으로 나누어 집니다

시스템 권한 
- 사용자 생성과 제거, DB 접근 및 각종 객체를 생성할 수 있는 권한 등
  주로 DBA에 의해 부여됩니다
  
객체 권한
- 테이블, 뷰, 시퀀스등 의 객체  
 */

/*
사용자 생성
- 사용자 계정을 생성하기 위해서는 시스템 권한을 가진 SYSTEM 으로 접속해야 합니다
- CREATE USER '사용자 이름'
  INDENTIFIED BY '사용자 암호'
  [ WITH ADMIN OPTION ];
 */

-- system 계정 연결
conn system/oracle;


-- 연결 계정 확인
SHOW user;


-- test 계정 생성
CREATE USER test
IDENTIFIED BY test;
                

-- 생성된 계정 목록 확인
SELECT * FROM ALL_USERS;


-- test 계정 연결
-- 연결 권한이 없어서 error
CONN test/test;


/*
GRANT 
- 사용자에게 시스템 권한 부여할 때 사용하는 명령어 입니다
- GRANT privilege_name, .....
  TO user_name;
 */

-- system 계정 연결
conn system/oracle;


-- CREATE SESSION : 데이터베이스에 접속할 수 있는 권한 부여 
--                  DBA만 부여 가능
GRANT CREATE SESSION TO test;


-- test 계정 연결
-- > SQL DEVELOPER 로 확인시 새로운 접속 정보 생성해서 TEST
CONN test/test;


/*
WITH ADMIN OPTION 
- 사용자에게 시스템 권한을 WITH ADMIN OPTION 과 함께 부여하면,
  시스템 권한을 다른 사용자에게도 부여할 수 있습니다
 */

-- user02 계정 생성
CREATE USER user02 IDENTIFIED BY user02;

-- user02 에게 연결 권한 부여
GRANT CREATE SESSION TO user02 WITH ADMIN OPTION;

-- user02 계정 연결
CONN user02/user02;

-- user01 계정 생성
CREATE USER user01 IDENTIFIED BY user01;

-- user02 계정으로 user01 에게 연결 권한 부여
GRANT CREATE SESSION TO user01;

-- user01 계정 연결
CONN user01/user01;


-- user03 계정 생성
CREATE USER user03 IDENTIFIED BY user03;

-- user03 에게 연결 권한 부여
GRANT CREATE SESSION TO user03;

-- user03 계정 연결
CONN user03/user03;

-- user03 사용자는 자기가 받은 권한을 다른 사용자에게 부여할 수 없습니다
GRANT CREATE SESSION TO user01; -- error


/*
객체 권한
- 특정 객체에 조작을 할 수 있는 권한입니다. 객체의 소유자는 객체에 대한 모든 권한을 가집니다
- GRANT privilege_name [column_name] | ALL  -> 권한
  ON object_name | role_name | public       -> 객체 선택
  TO user_name;                             -> 사용자
 * */

-- user01 계정 연결
CONN user01/user01;

-- EMP 테이블 조회
-- > emp 테이블은 scott 소유자의 테이블 이여서 접근 불가
SELECT * FROM emp; -- error

-- scott 계정 연결
CONN scott/tiger;

-- scott 계정 소유의 emp 테이블을 조회(select)할 수 있는 권한을 user01 계정에 부여
GRANT SELECT ON EMP TO user01;

-- user01 계정 연결
CONN user01/user01;

-- user01 계정에서 emp 테이블 조회
SELECT * FROM EMP; -- error

-- 자신이 소유한 객체가 아닌 경우에는 그 객체를 소유한 사용자명(스키마)를 반드시 기술해야 합니다
-- > 스키마(sehema) : 객체를 소유한 사용자명
SELECT * FROM SCOTT.EMP;


/*
사용자에게 부여된 권한 조회
- 다른 사용자에게 부여한 권한 정보 조회
  SELECT * FROM USER_TAB_PRIVS_MADE;
- 자신에게 부여된 사용자 권한 정보 조회
  SELECT * FROM USER_TAB_PRIVS_RECD;
 */

SELECT * FROM USER_TAB_PRIVS_MADE;

SELECT * FROM USER_TAB_PRIVS_RECD;


/*
REVOKE
- 사용자에게 부여한 객체 권한을 데이터베이스 관리자나 객체 소유자로부터 철회할 때에는
  REVOKE 명령어를 사용합니다
- REVOKE privilege_name | all            -> 철회하는 객체 권한
  ON object_name                         -> 객체 지정
  FROM user_name | role_name | public;   -> 부여한 사용자명
 */

-- scott 계정 연결
CONN scott/tiger;

-- 부여한 권한 확인
SELECT * FROM USER_TAB_PRIVS_MADE;

-- user01 사용자에게서 emp 테이블에 대한 select 권한 철회
REVOKE SELECT ON EMP FROM user01;

-- 부여한 권한 확인
SELECT * FROM USER_TAB_PRIVS_MADE;

-- user01 계정 연결
CONN user01/user01;

-- user01 계정에서 emp 테이블 조회
-- > 권한이 철회되었기 때문에 조회 불가
SELECT * FROM SCOTT.EMP; -- error


/*
WITH GRANT OPTION
- 사용자에게 객체 권한을 WITH GRANT OPTION 과 함께 부여하면,
  해당 사용자는 그 객체에 접근할 수 있는 권한을 부여 받으면서,
  그 권한을 다른 사용자에게 부여할 수 있는 권한도 부여 받게 됩니다
 */

-- scott 계정 연결
CONN scott/tiger;

-- user02 에게 scott.emp 테이블을 select 하는 권한을 WITH GRANT OPTION 으로 부여
GRANT SELECT ON SCOTT.EMP TO USER02
WITH GRANT OPTION;

-- user02 계정 연결
CONN user02/user02;

-- user02 가 받은 권한을 user01에게도 부여
GRANT SELECT ON SCOTT.EMP TO USER01;


-- scott 계정 연결
CONN scott/tiger;

-- user03 에게 scott.emp 테이블을 select 하는 권한 부여
GRANT SELECT ON SCOTT.EMP TO USER03;

-- user03 계정 연결
CONN user03/user03;

-- user03 이 받은 권한을 user01에게도 부여하면 error 
GRANT SELECT ON SCOTT.EMP TO USER01; -- error


/*============================================================================*/


/*
롤 (role)
- 사용자에 보다 효율적으로 권한을 부여할 수 있도록 여러개의 권한을 묶어놓은 것입니다
- 다수의 사용자에게 공통적으로 필요한 권한들을 롤을 사용해서 하나의 그룹으로 묶어두고,
  사용자에게 롤에 대한 권한을 부여 함으로 해서 간단하게 권한을 부여할 수 있습니다
- CONNECT 롤
  > 사용자가 데이터베이스에 접속 가능하도록 하는 시스템 권한 8가지를 묶어 놓았습니다
  RESOURCE 롤
  > 사용자가 객체(테이블, 뷰, 인덱스)를 생성할 수 있도록 하는 권한을 묶어 놓았습니다
  DBA 롤
  > 사용자들이 소유한 데이터베이스 객체를 관리하고, 사용자들을 생성, 변경, 제거할 수 있는
    모든 권한을 가집니다  
 */

-- 관리자 계정 연결
CONN SYSTEM/oracle;

-- user04 계정 생성
CREATE USER user04 IDENTIFIED BY user04;

-- user04 계정 연결
CONN user04/user04; -- error

-- 관리자 계정에서 user04 계정에게 CONNECT, RESOURCE 롤 부여
GRANT CONNECT, RESOURCE TO USER04;

-- user04 계정 연결
CONN user04/user04;


/*
사용자 롤 정의
- CREATE ROLE 명령어로 사용자 정의 롤을 생성할 수 있습니다
- CREATE ROLE role_name;
  GRANT privilege_name TO role_name;
- 롤 생성, 시스템 권한일 경우에는 DBA에서 작업
  객체 권한일 경우에는 특정 객체로 접근해서 작업
- 롤 작업 순서
  1. 롤을 생성 ( 관리자 계정 )
  2. 롤에 권한 부여 ( 관리자 계정 or 사용자 계정 )
  3. 사용자에게 롤 부여( 관리자 계정 )
 */

-- 시스템 권한 롤
-- 롤 생성전에 system 계정 연결
CONN system/oracle;

-- 사용자 롤 생성
CREATE ROLE MYROLE;

-- 생성된 롤에 권한 부여
GRANT CREATE SESSION, CREATE TABLE, CREATE VIEW TO MYROLE;

-- user05 계정 생성해서 롤 부여
CREATE USER user05 IDENTIFIED BY user05;
GRANT MYROLE TO user05;


-- 객체 권한 롤
-- 관리자 계정 연결
CONN system/oracle;

-- 객체 권한을 가질 롤 생성
CREATE ROLE SELROLE;

-- scott 계정 연결
CONN SCOTT/tiger;

-- SELROLE 에게 EMP 테이블 객체를 조회할 수 있는 SELECT 권한 부여
GRANT SELECT ON EMP TO SELROLE;

-- 관리자 계정 연결
CONN system/oracle;

-- 관리자 계정에서 user05 계정에게 SELROLE 권한 부여
GRANT SELROLE TO user05;

-- user05 계정 연결
CONN user05/user05;

-- SELROLE 권한 부여 확인
SELECT * FROM USER_ROLE_PRIVS;
SELECT * FROM SCOTT.EMP;


/*
롤 회수
- REVOKE role_name FROM user_name;

롤 제거
- 사용하지 않는 롤은 DROP ROLE 명령어를 사용해서 제거 합니다
- DROP ROLE role_name;
 */

-- 관리자 계정 연결해서 롤 회수
REVOKE MYROLE FROM user05;
REVOKE SELROLE FROM user05;

-- user05 계정 연결
CONN user05/user05;

-- 권한 부여 확인
SELECT * FROM USER_ROLE_PRIVS;

-- system 계정 연결

-- system 권한 부여 확인
-- 앞에서 삭제 한건 user05 의 MYROLE 권한을 삭제 한 것입니다
SELECT * FROM USER_ROLE_PRIVS;

-- system MYROLR 제거
DROP ROLE MYROLE;
DROP ROLE SELROLE;

-- 권한 부여 확인
SELECT * FROM USER_ROLE_PRIVS;



/*
동의어 ( synonym )
- 다른 데이터베이스 객체에 대한 별명입니다
- 데이터베이스에서는 여러 사용자들이 테이블을 서로 공유하는데,
  다른 사용자의 테이블에 접근할 때 '사용자명.테이블명'으로 표현합니다
  이때 동의어를 적용하면 간단하게 요약해서 접근할 수 있습니다
- CREATE [PUBLIC] SYNONYM synonym_name
  FOR user_name.object_name;
  > synonym_name 은 user_name.object_name 에 대한 별칭
    user_name 은 객체를 소유한 사용자명이고, object_name 은 동의어를 만들려는 객체 이름입니다
 */

-- system 계정 연결
CONN system/oracle;

-- 연습용 테이블 생성
CREATE TABLE SYSTBL(
name VARCHAR2(20)
);

-- 데이터 추가
INSERT INTO SYSTBL VALUES('userA');
INSERT INTO SYSTBL VALUES('userB');

-- scott 사용자에게 SYSTBL 테이블에 SELECT 할 권한 부여
GRANT SELECT ON SYSTBL TO scott;

-- scott 계정 연결
CONN scott/tiger;

-- SYSTBL 테이블 조회
SELECT * FROM system.SYSTBL;


-- 동의어 생성
-- 관리자 계정에 연결해서 synonym 생성 권한 부여
CONN system/oracle;

GRANT CREATE SYNONYM TO scott;

-- 비공개 동의어는 권한을 부여받는 사용자에서 정의
-- scott 계정 연결
CONN scott/tiger;

-- 비공개 동의어 생성
CREATE SYNONYM PriSYSTBL FOR system.SYSTBL;

SELECT * FROM PriSYSTBL;

-- 비공개 동의어 삭제
DROP SYNONYM PriSYSTBL;



-- 공개 동의어
-- system 계정 연결
CONN system/oracle;

-- 사용자 정의 롤 생성
CREATE ROLE TEST_ROLE;

-- 사용자 정의 롤에 CONNECT, RESOURCE, SYNONYM 권한 부여
GRANT CONNECT, RESOURCE, CREATE SYNONYM TO TEST_ROLE;

-- scott 사용자의 emp, dept 테이블 select 권한 부여
GRANT SELECT ON scott.DEPT TO TEST_ROLE;
GRANT SELECT ON scott.EMP TO TEST_ROLE;

-- USERA, USERB 사용자 생성
CREATE USER usera IDENTIFIED BY usera;
CREATE USER userb IDENTIFIED BY userb;

-- 생성된 사용자에게 롤 부여
GRANT TEST_ROLE TO usera;
GRANT TEST_ROLE TO userb;

-- 공개 동의어 생성
-- > DBA 롤이 부여된 사용자만 생성 가능
CREATE PUBLIC SYNONYM PubDEPT FOR scott.DEPT;

-- usera 계정 연결
CONN usera/usera;

-- dept 테이블 조회
SELECT * FROM PubDEPT;

-- userb 계정 연결
CONN userb/userb;

-- dept 테이블 조회
SELECT * FROM PubDEPT;


-- 공개 동의어 제거
-- > 'PUBLIC' 붙여야 삭제 가능
DROP PUBLIC SYNONYM PubDEPT;


------------------------------------------------------------------------------


-- DBTEST 계정을 생성하고, 기본 2개의 롤 권한을 부여합니다
-- > 1. 계정 생성
--   2. 생성된 계정에 롤 부여
--   3. alter user 계정명 default tablespace users; -> 데이터베이스 저장되는 공간 users 지정
--   4. alter user 계정명 quota unlimited on users; -> tablespace 용량 지정


-- DBTEST 계정에 회원 정보를 관리하는 table을 생성합니다
-- 회원수 - 시퀀스 적용
-- 회원 ID - (중복 X, 유일키)
-- 회원이름 - null 값 사용불가
-- 회원나이
-- 회원키 - 전체 10자리, 소수점 2번째 자리까지
-- 생성일자


-- 생성된 테이블 확인

-- 테이블 항목 확인

-- 데이터 추가

-- 테이블 삭제

-- 계정 삭제

-- 현재 생성된 계정 목록 확인


















