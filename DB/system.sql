
-- 한줄 주석


-- 실행 : Ctrl + Enter

-- 전체 계정 확인
select * from all_users;

-- system 계정 : 사용자 계정관리

-- system 계정 연결해서 scott 생성
create user scott identified by tiger;
--default tablespace users
--temporary tablespace temp;

-- 권한 부여
grant connect, resource, dba to scott;

-- scott 연결
conn scott/tiger

conn system/oracle

-- 계정 삭제
-- drop user 계정명;
drop user scott;

drop user scott cascade;

-- sql 파일 실행
-- sqlplus 에서 system 계정 연결
@C:\oraclexe\app\oracle\product\11.2.0\server\rdbms\admin\scott.sql

show user;

-- 계정 잠금(lock) 해제
-- ALTER USER 계정명 ACCOUNT UNLOCK; 
ALTER USER scott ACCOUNT UNLOCK;

conn scott/tiger


-- SYS, SYSTEM 의 비밀번호 변경
-- sqlplus
-- 사용자명 : sys as sysdba
-- PW : Enter
-- alter user system identified by 새암호


-- 사용자 계정 비밀번호 변경
-- system 계정 연결
-- alter user 사용자계정명 identified by 새암호














































