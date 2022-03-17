

/*
데이터 무결성 제약 조건 (Data Integrity Constranint Rule)
- 테이블에 부적절한 자료가 입력되는 것을 방지하기 위해 테이블을 생성할 때,
  각 컬럼에 대해서 정의하는 여러가지 규칙입니다
  > 무결성    : 데이터의 정확성 유지
    제약 조건 : 바람직하지 않은 데이터가 저장되는 것을 방지
 */


/*
무결성 제약 조건    
NOT NULL            
- NULL 을 허용하지 않습니다

UNIQUE
- 중복된 값을 허용하지 않고, 항상 유일한 값을 갖도록 합니다

PRIMARY KEY
- NULL을 허용하지 않고, 중복된 값도 허용하지 않습니다
  NOT NULL 과 UNIQUE 를 결합한 형태입니다

FOREIGN KEY
- 참조되는 테이블의 컬럼의 값이 있으면 허용합니다

CHECK
- 저장 가능한 데이터 값의 범위나 조건을 지정하여, 설정한 값만을 허용합니다
 */


/*
제약 조건 확인
- USER_CONSTRAINTS 데이터 딕셔너리 뷰로 제약 조건에 관한 정보를 확인할 수 있습니다
  > OWNER           : 제약 조건을 소유한 사용자명을 저장하는 컬럼
    CONSTRAINT_NAME : 제약 조건명을 저장하는 컬럼
    CONSTRAINT_TYPE : 제약 조건 유형을 저장하는 컬럼
                      P - PRIMARY KEY
                      R - FOREIGN KEY
                      U - UNIQUE
                      C - CHECK, NOT NULL

 */

-- 데이터 딕셔너리
DESC USER_CONSTRAINTS;

-- 현재 계정 소유의 테이블에 지정된 제약 조건 확인
SELECT CONSTRAINT_NAME, CONSTRAINT_TYPE, TABLE_NAME
FROM USER_CONSTRAINTS;


-- 제약 조건이 지정된 컬럼명 확인
SELECT * FROM USER_CONS_COLUMNS;


/*
NOT NULL
- 특정 컬럼은 반드시 값이 입력되도록 필수 입력 컬럼으로 지정하는 것입니다

 */

-- NOT NULL 제약 조건을 사용하지 않는 테이블 생성
SELECT * FROM tab;

DROP TABLE emp01;

CREATE TABLE emp01(
empno NUMBER(4),
ename VARCHAR2(10),
job VARCHAR2(9),
deptno NUMBER(2)
);

DESC emp01;

-- 테이터 추가
INSERT INTO emp01 VALUES(NULL, NULL, 'SALESMAN', 30);

SELECT * FROM emp01;


-- NOT NULL 제약 조건을 설정한 테이블 생성
SELECT * FROM tab;

DROP TABLE emp02;

CREATE TABLE emp02(
empno NUMBER(4) NOT NULL,
ename VARCHAR2(10) NOT NULL,
job VARCHAR2(9),
deptno NUMBER(2)
);

DESC emp02;

-- emp02 테이블은 사원번호, 사원명에 NOT NULL 조건을 지정하였기 때문에,
-- 해당 컬럼에는 NULL 값을 사용할 수 없습니다
INSERT INTO emp02 VALUES(NULL, NULL, 'SALESMAN', 30);



/*
UNIQUE 제약 조건
- 특정 컬럼에 대해 중복된 데이터가 저장되지 않게 합니다
  테이블안에 유일한 값만 저장할 수 있습니다
 
 */

-- UNIQUE 제약 조건을 설정한 테이블 생성
SELECT * FROM tab;

DROP TABLE emp03;

CREATE TABLE emp03(
empno NUMBER(4) UNIQUE,
ename VARCHAR2(10) NOT NULL,
job VARCHAR2(9),
deptno NUMBER(2)
);

DESC emp03;

-- 데이터 추가
INSERT INTO emp03 VALUES(1100, 'ORACLE', 'DB', 70);

SELECT * FROM emp03;


-- 사원번호를 UNIQUE 로 제약 조건 설정했기 때문에 동일한 사원번호가 들어가면 오류
INSERT INTO emp03 VALUES(1100, 'MARIA', 'DB', 70);


-- UNIQUE 제약 조건 설정된 컬럼에 NULL 값을 사용할 수 있습니다
-- NULL 값은 중복 저장이 가능합니다
INSERT INTO emp03 VALUES(NULL, 'MARIA', 'DB', 70);
INSERT INTO emp03 VALUES(NULL, 'JAVA', 'PROGRAM', 80);

SELECT * FROM emp03;



/*
PRIMARY KEY
- NOT NULL 과 UNIQUE 조건을 결합한 제약 조건입니다
 */

-- PRIMARY KEY 제약 조건을 설정한 테이블 생성
SELECT * FROM tab;

DROP TABLE emp04;

CREATE TABLE emp04(
empno NUMBER(4) PRIMARY KEY,
ename VARCHAR2(10) NOT NULL,
job VARCHAR2(9),
deptno NUMBER(2)
);

DESC emp03;

-- 데이터 추가
INSERT INTO emp04 VALUES(1100, 'ORACLE', 'DB', 70);

SELECT * FROM emp04;


-- 사원번호를 PRIMARY KEY 로 제약 조건 설정했기 때문에 
-- 동일한 사원번호, NULL 값이 들어가면 오류
INSERT INTO emp04 VALUES(1100, 'MARIA', 'DB', 70);
INSERT INTO emp04 VALUES(NULL, 'MARIA', 'DB', 70);


/*
참조 무결성
- 테이블과 테이블 사이에서 발생하는 개념입니다
- 두 테이블 사이의 주종 관계가 종속되는 테이블, 즉 부모테이블과 자식테이블에 의해서 결정 됩니다

 */

/*
FOREIGN KEY
- 사원 테이블의 부서 번호는 반드시 부서 테이블에 존재하는 부서 번호만 입력되어야 합니다
  사원 테이블이 부서 테이블의 부서 번호를 참조 가능하도록 하는 것입니다
- 부모 키가 되기 위한 컬럼은 반드시 부모 테이블의 PRIMARY KEY(기본키) 또는 
  UNIQUE(유일키)로 설정되어 있어야 합니다
 */

-- 기본키, 외래키 제약 조건을 설정한 테이블 생성
SELECT * FROM tab;

DROP TABLE emp05;

CREATE TABLE emp05(
empno NUMBER(4) PRIMARY KEY,
ename VARCHAR2(10) NOT NULL,
job VARCHAR2(9),
deptno NUMBER(2) REFERENCES dept(deptno)
);

SELECT * FROM emp05;
SELECT * FROM dept;

-- 부서 테이블에 존재하지 않는 부서번호를 갖는 사원정보 추가하면 error
INSERT INTO emp05 VALUES(1300, 'ORACLE', 'DB', 50);


-- 부서 테이블에 부서번호 50번으로 데이터 추가
INSERT INTO dept VALUES(50, 'DATABASE', 'KOR');

SELECT * FROM dept;

INSERT INTO emp05 VALUES(1300, 'ORACLE', 'DB', 50);

SELECT * FROM emp05;


/*
CHECK 제약 조건
- 입력되는 값을 체크하여 설정된 값 이외의 값이 들어오면 명령이 수행되지 않습니다
- 조건으로 데이터의 값의 범위나 특정 패턴의 숫자나 문자 값을 설정할 수 있습니다
 */

-- 체크 제약 조건을 설정한 테이블 생성
SELECT * FROM tab;

DROP TABLE emp06;

CREATE TABLE emp06(
empno NUMBER(4) PRIMARY KEY,
ename VARCHAR2(10) NOT NULL,
sal NUMBER(7, 2) CHECK(sal BETWEEN 500 AND 10000), -- 급여는 500 ~ 10000 사이 가능
gender VARCHAR2(1) CHECK(gender IN('M', 'F')) -- 성별은 M, F 가능
);

SELECT * FROM emp06;

-- 급여가 300인 데이터 추가하면 error
INSERT INTO emp06 VALUES(1300, 'JAVA', 300, 'M');


-- 성별이 f인 데이터 추가하면 error
INSERT INTO emp06 VALUES(1300, 'JAVA', 300, 'f');


-- 급여 1000, 성별이 F 인 데이터 추가
INSERT INTO emp06 VALUES(1300, 'JAVA', 1000, 'F');

SELECT * FROM emp06;


/*
DEFAULT 제약 조건
- 아무런 값을 입력하지 않았을 때 DEFAULT 설정한 값이 들어갑니다
 */

-- DEFAULT 설정한 테이블 생성
SELECT * FROM tab;

DROP TABLE dept01;

CREATE TABLE dept01(
deptno NUMBER(2) PRIMARY KEY,
dname VARCHAR2(14) NOT NULL,
loc VARCHAR2(13) DEFAULT 'SEOUL'
);

SELECT * FROM dept01;

-- 지역을 작성하지 않은 데이터 추가
INSERT INTO dept01(deptno, dname) VALUES(10, 'ACCOUNTING');

SELECT * FROM dept01;


/*
제약 조건명을 명시해서 제약 조건 설정
-- 제약 조건을 명시할 때 제약 조건명을 설정할 수 있습니다
   제약 조건명을 명시하지 않으면 오라클이 자동으로 제약 조건명을 부여합니다
-- 오라클이 부여하는 제약 조건명은 SYS_ 다음에 숫자를 나열합니다
-- 사용자가 의미 있게 제약 조건명을 명시하면, 
   제약 조건명 만으로도 어떤 제약 조건을 위배했는지 알 수 있게 됩니다
-- 제약 조건명 지정 방법
   column_name data_type CONSTRAINT
   constraint_name constraint_type
-- 제약 조건명 명명 규칙
   테이블명_컬럼명_제약 조건 유형
 */

-- 제약 조건명을 설정한 테이블 생성
SELECT * FROM tab;

DROP TABLE emp07;

CREATE TABLE emp07(
empno NUMBER(4) CONSTRAINT emp07_empno_PK PRIMARY KEY,
ename VARCHAR2(10) CONSTRAINT emp07_ename_NN NOT NULL,
job VARCHAR2(9),
deptno NUMBER(2) 
);

SELECT * FROM emp07;

-- 생성된 제약 조건명을 확인하기 위해서 USER_CONSTRAINTS 데이터 딕셔너리 뷰 검색
SELECT TABLE_NAME, CONSTRAINT_NAME
FROM USER_CONSTRAINTS
WHERE TABLE_NAME IN('EMP07'); -- 테이블명 대문자

-- 데이터 추가
INSERT INTO emp07 VALUES(NULL, 'ORACLE', 'ACCOUNTING', 10);
INSERT INTO emp07 VALUES(1500, NULL, 'ACCOUNTING', 10);











































