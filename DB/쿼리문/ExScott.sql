
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
























