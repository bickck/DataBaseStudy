

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
















































