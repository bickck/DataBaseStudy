

/*
시퀀스 ( sequence )
- 테이블 내의 유일한 숫자를 자동으로 생성하는 자동 번호 생성기 입니다
- 행을 구분하는 기본키가 유일한 값을 갖도록 테이블 내의 유일한 숫자를 자동으로 생성할 수 있습니다
- CREATE SEQUENCE sequence_name
                  START WITH  -> 시퀀스 번호의 시작값 지정
                  INCREMENT BY -> 연속적인 시퀀스 번호의 증가치
                  MAXVALUE | NOMAXVALUE -> 최대값 지정
                  MINVALUE | NOMINVALUE -> 최소값 지정
                  CICLE | NOCYCLE -> 시퀀스가 최대값까지 완료되면 시자값에서 다시 시작
                                     NOCYCLE 은 증가가 완료되면 error
                  CACHE | NOCACHE -> 메모리상의 시퀀스 값 관리
- CURRVAL : 현재값 반환
  NEXTVAL : 현재 시퀀스값의 다름 값 반환      
  > CURRVAL 에 새로운 값이 할당되기 위해서는 NEXTVAL 로 새로운 값을 생성해야 합니다
        
 */


-- 시퀀스 객체 생성
CREATE SEQUENCE deptno_seq
START WITH 1
INCREMENT BY 1;

-- NEXTVAL 로 새로운 값을 생성
SELECT deptno_seq.nextval FROM DUAL;

-- 시퀀스의 현재값
SELECT deptno_seq.currval FROM DUAL;

-- 시퀀스 객체 삭제
-- DROP SEQUENCE 삭제 시퀀스명;
DROP SEQUENCE deptno_seq;


-- 연습용 테이블 생성
DROP TABLE emp01;

CREATE TABLE emp01(
empno NUMBER(4) PRIMARY KEY,
ename VARCHAR2(10),
hiredate DATE
);

-- emp01 테이블의 사원번호에 적용하는 sequence 객체 생성
CREATE SEQUENCE emp01_empno_seq START WITH 1 INCREMENT BY 1 MAXVALUE 10000;

-- 데이터 추가
INSERT INTO emp01 VALUES(emp01_empno_seq.nextval, 'manA', SYSDATE);

SELECT * FROM emp01;

DROP SEQUENCE emp01_empno_seq;

/*
시퀀스 수정
- ALTER SEQUENCE 는 START WITH 절 빼고, CREATE SEQUENCE 와 구조가 동일합니다
  > START WITH 옵션은 변경할 수 없고, 다시 시작하려면 시퀀스를 삭제하고 다시 생성해야 합니다
- ALTER SEQUENCE sequence_name
                 INCREMENT BY 
                 MAXVALUE | NOMAXVALUE 
                 MINVALUE | NOMINVALUE 
                 CYCLE | NOCYCLE 
                 CACHE | NOCACHE 
                 
 */

-- 연습용 테이블 생성
CREATE TABLE stest(
sno NUMBER(2) PRIMARY KEY
);

-- stest 테이블 sno 컬럼에 적용할 시퀀스 객체 생성
CREATE SEQUENCE stest_sno_seq START WITH 1 INCREMENT BY 1 MAXVALUE 3;

-- 데이터 추가
INSERT INTO stest VALUES(stest_sno_seq.nextval);
INSERT INTO stest VALUES(stest_sno_seq.nextval);
INSERT INTO stest VALUES(stest_sno_seq.nextval);
INSERT INTO stest VALUES(stest_sno_seq.nextval); -- error

SELECT * FROM stest;

SELECT stest_sno_seq.currval FROM dual;

-- 시퀀스 최대값 수정
ALTER SEQUENCE stest_sno_seq MAXVALUE 10;

INSERT INTO stest VALUES(stest_sno_seq.nextval);

SELECT * FROM stest;

DROP SEQUENCE stest_sno_seq;

------------------------------------------------------------------------------------


-- 부서정보를 가지는 테이블을 생성하세요
-- > 부서번호, 부서명, 지역
-- 부서번호에는 sequence 를 사용해서 적용합니다. ( 초기값 10, 10씩 증가 )

CREATE TABLE qdept(
deptno NUMBER(2) PRIMARY KEY,
dname VARCHAR2(14),
loc VARCHAR2(13)
);

SELECT * FROM qdept;

CREATE SEQUENCE qdept_deptno_seq START WITH 10 INCREMENT BY 10;

INSERT INTO qdept VALUES(qdept_deptno_seq.nextval, '부서A',  '지역A');
INSERT INTO qdept VALUES(qdept_deptno_seq.nextval, '부서B',  '지역B');
INSERT INTO qdept VALUES(qdept_deptno_seq.nextval, '부서C',  '지역C');

SELECT * FROM qdept;

DROP SEQUENCE qdept_deptno_seq;














































