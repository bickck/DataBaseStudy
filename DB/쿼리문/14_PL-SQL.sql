

/*
PL/SQL (Oracles Procedural Language extension to SQL)
- SQL 문장에서 변수정의, 조건처리(IF), 반복처리(LOOP...) 등을 지원하며,
  오라클 자체에 내장되어 있는 절차적 언어로서 SQL 문의 단점을 보완해 줍니다
- DECLARE ~ BEGIN ~ EXCEPTION ~ END 순서를 갖습니다
  > 선언부 ( DECLARE SECTION )
    * PL/SQL 에서 사용하는 변수나 상수를 선언
  > 실행부 ( EXTCUTEABLE SECTION )
    * 절차적 형식으로 SQL문을 실행할 수 있도록 제어문, 반복문 등을 기술하는 부분으로
      BEGIN 으로 시작합니다
  > 예외처리 ( EXCEPTION SECTION )
    * PL/SQL 문이 실행되는 중에 에러가 발생할 수 있는데 이를 예외라고 합니다
      예외사항이 발생했을 때 이를 해결하기 위한 문장을 기술하는 부분으로 EXCEPTION 으로 시작합니다 
 */

/*
PL/SQL 프로그램 작성
- PL/SQL 블록 내에서는 한 문장이 종료할 때마다 세미콜론(;)을 사용합니다
- END 뒤에 ;을 사용하여 하나의 블록이 끝났다는 것을 명시합니다
- 주석은 oracle 에서 사용하는 것과 동일합니다
- 쿼리문을 수행하기 위해서 / 가 반드시 입력되어야 하며, 
  PL/SQL 블록은 행에 / 가 있으면 종결된 것으로 간주합니다
 */

-- 오라클에서 제공해주는 프로시저를 사용하여 출력해 주는 내용을 화면에 보여주도록 설정
SET SERVEROUTPUT ON

-- 메시지 출력
-- > 화면출력을 위해서 PUT_LINE 이란 프로시저를 이용합니다
--   오라클이 제공해주는 프로시저로 DBMS_OUTPUT 패키지에 묶여 있습니다
BEGIN
DBMS_OUTPUT.PUT_LINE('Hello oracle');
END;
/



/*
변수 선언
- 변수를 선언할 때에는 변수명 다음에 자료형을 기술합니다
- 자료형은 SQL에서 사용하던 자료형과 유사합니다
- identifier [CONSTANT] datatype [NOT NULL]
  [:= | DEFAULT expression ];
  > identifier      변수 이름
    CONSTANT        변수의 값을 변경할 수 없도록 제약
    datatype        자료형
    NOT NULL        값을 반드시 포함하도록 하위 위해 변수를 젝약
    expression      literal, 다른 변수, 연산자나 함수를 포함하는 표현식
    :=              변수의 값을 지정하거나 재지정 할 때 사용
 */

-- 변수 선언
VEMPNO NUMBER(4);
VENAME VARCHAR2(10);

-- 변수 값 지정
VEMPNO := 7890
VENAME := 'SCOTT'

-- 변수 선언하고 출력
DECLARE
	VEMPNO NUMBER(4);
	VENAME VARCHAR2(10);
BEGIN
	VEMPNO := 7890;
	VENAME := 'SCOTT';
	DBMS_OUTPUT.PUT_LINE('사번/이름');
	DBMS_OUTPUT.PUT_LINE('--------------');
	DBMS_OUTPUT.PUT_LINE(VEMPNO||'/'||VENAME);
END;
/

-- 변수를 선언하기 위해 사용하는 데이터 타입
-- 스칼라(scalar) : SQL 사용하는 자료형과 유사
VEMPNO NUMBER(4);
VENAME VARCHAR2(10);

-- 레퍼런스
-- 이전에 선언된 다른 변수 또는 데이터베이스 컬럼에 맞추어 변수를 선언
-- '%TYPE' 속성 사용
VEMPNO EMP.EMPNO%TYPE;
VENAME EMP.ENAME%TYPE;
-- VEMPNO, VENAME 변수는 해당 EMP 테이블의 해당 컬럼의 자료형과 크기를 그대로 참조


/*
PL/SQL 에서 SELECT
- 테이블의 행에서 질의된 값을 변수에 할당시키기 위해서 SELECT 문장을 사용합니다
  PL/SQL의 SELECT 문은 INTO 절이 필요한데, INTO 절에는 데이터를 저장할 변수를 작성합니다
- SELECT 절에 있는 컬럼은 INTO 절에 있는 벼수와 1:1 대응을 하기 때문에
  개수, 데이터형, 길이가 일치해야 합니다
- SELECT select_list
  INTO { variable_name,... | record_name |
  FROM table_name
  WHERE condition;
  > select_list       열 목록
    variable_name     읽어들인 값을 저장하기 위한 변수
    record_name       읽어들인 값을 저장하기 위한 PL/SQL RECORD 변수 
    condition         PL/SQL 변수와 상수를 포함하여 열명, 표현식, 상수로 구성
                      하나의 값만 RETURN 할 수 있는 조건
 */

SELECT * FROM EMP;

-- EMP 테이블의 사번, 이름 조회
DECLARE
	-- %TYPE 속성으로 컬럼 단위 레퍼런스 변수 선언
	VEMPNO EMP.EMPNO%TYPE;
	VENAME EMP.ENAME%TYPE;
BEGIN
	DBMS_OUTPUT.PUT_LINE('사번 / 이름');
	DBMS_OUTPUT.PUT_LINE('-------------');
	
	SELECT EMPNO, ENAME INTO VEMPNO, VENAME
	FROM EMP
	WHERE ENAME='SMITH';
	
	-- 레퍼런스 변수에 저장된 값을 출력
	DBMS_OUTPUT.PUT_LINE(VEMPNO || ' / ' || VENAME);
END ;
/



/*
ROWTYPE 레퍼런스 변수 
- 로우(행) 단위로 참조하는 자료형으로 만들어진 변수
- 특정 테이블의 컬럼의 개수와 데이터 형식을 모르더라도 지정할 수 있습니다

 * */

SELECT * FROM EMP;

DECLARE
	vemp EMP%ROWTYPE; -- 행단위 참조
BEGIN
	SELECT * INTO vemp
	FROM EMP
	WHERE ENAME='SMITH';
	
	DBMS_OUTPUT.PUT_LINE('사원번호 : ' || vemp.empno);
	DBMS_OUTPUT.PUT_LINE('이    름 : ' || vemp.ename);
	
END ;
/


/*
PL/SQL 테이블 변수
- 로우에 대해서 배열처럼 액세스하기 위해 BINARY_INTEGER 데이터형의 기본키를 사용
- TYPE table_type_name IS TABLE OF { column_type | variable%TYPE | table.column%TYPE | [NOT NULL]
  [INDEX BY BINARY_INTEGER ];
  identifier table_type_name;
  > table_type_name         테이블형 이름
    column_type             스칼라 데이터 형
    identifier              PL/SQL 테이블을 나타내는 식별자 이름
 */

/*
PL/SQL FOR LOOP
- FOR index IN 시작값..END값 LOOP
  	STATEMENT
  	.....
  END LOOP;
  > index 는 자동 선언되는 BINARY_INTEGER 형 변수. 1씩증가
    IN 다음에는 coursor, select 문 적용 가능
 */

-- 테이블 변수를 사용해서 EMP 테이블의 이름, 업무 출력

DECLARE
	-- 테이블 타입 정의
	TYPE ENAME_TABLE_TYPE IS TABLE OF EMP.ENAME%TYPE 
    INDEX BY BINARY_INTEGER;
	TYPE JOB_TABLE_TYPE IS TABLE OF EMP.JOB%TYPE 
    INDEX BY BINARY_INTEGER;
	
	-- 테이블 타입 변수 선언
	ENAME_TABLE ENAME_TABLE_TYPE;
	JOB_TABLE JOB_TABLE_TYPE;
	
	I BINARY_INTEGER := 0;
BEGIN
	-- EMP 테이블에서 이름, 업무 가져오기
	FOR K IN (SELECT ENAME, JOB FROM EMP) LOOP
		I := I + 1;                      -- INDEX 증가
		ENAME_TABLE(I) := K.ENAME;      -- 이름 저장
		JOB_TABLE(I) := K.JOB;          -- 업무 저장
	END LOOP;
	
	-- 테이블 변수에 저장된 내용 출력
	FOR J IN 1..I LOOP
		DBMS_OUTPUT.PUT_LINE(ENAME_TABLE(J) || ' / ' || JOB_TABLE(J));
	END LOOP;
END ;
/


/*
PL/SQL RECORD TYPE
- 여러개의 필드를 하나로 묶어서 레코드 타입으로 선언
- TYPE type_name IS RECORD (
  field_name { scalar_datatype | record_type } 
  [NOT NULL] [{ := | DEFAULT} expr ],
  .....
  );
  identifier table_type_name;

 */

-- emp 테이블의 SMITH 사원의 정보 출력
DECLARE
	-- 레코드 타입 정의
	TYPE emp_record_type IS RECORD(
	v_empno emp.empno%TYPE,
	v_ename emp.ename%TYPE,
	v_job emp.job%TYPE,
	v_deptno emp.deptno%TYPE
	);
	
	-- 레코드 변수 선언
	emp_record emp_record_type;
	
BEGIN
	-- SMITH 사원의 정보를 레코드 변수에 저장
	SELECT empno, ename, job, deptno
	INTO emp_record
	FROM emp
	WHERE ename='SMITH';
	
	-- 레코드 변수에 저장된 데이터 출력
	DBMS_OUTPUT.PUT_LINE('사원번호 : ' || emp_record.v_empno);
	DBMS_OUTPUT.PUT_LINE('이    름 : ' || emp_record.v_ename);
	DBMS_OUTPUT.PUT_LINE('담당업무 : ' || emp_record.v_job);
	DBMS_OUTPUT.PUT_LINE('부서번호 : ' || emp_record.v_deptno);
END ;
/


/*
IF-THEN-END IF
- IF condition THEN   -> 조건문
	statements;       -> 조건문이 참이면 실행
  END IF;

 */

SELECT * FROM DEPT;
SELECT * FROM EMP;

--10	ACCOUNTING
--20	RESEARCH
--30	SALES
--40	OPERATIONS

-- 부서번호를 사용해서 부서명 출력
DECLARE
	VEMPNO NUMBER(4);
	VENAME VARCHAR2(20);
	VDEPTNO EMP.DEPTNO%TYPE;
	VDNAME VARCHAR2(20) := NULL;

BEGIN
	SELECT empno, ename, deptno
	INTO VEMPNO, VENAME, VDEPTNO
	FROM EMP
	WHERE EMPNO = 7369;
	
	IF (VDEPTNO = 10) THEN
		VDNAME := 'ACCOUNTING';
	END IF;
	IF (VDEPTNO = 20) THEN
		VDNAME := 'RESEARCH';
	END IF;
	IF (VDEPTNO = 30) THEN
		VDNAME := 'SALES';
	END IF;
	IF (VDEPTNO = 40) THEN
		VDNAME := 'OPERATIONS';
	END IF;
	
	DBMS_OUTPUT.PUT_LINE('사원번호 / 사원이름 / 부서명');
	DBMS_OUTPUT.PUT_LINE(VEMPNO || ' / ' || VENAME || ' / ' || VDNAME);
	
END ;
/



/*
IF - THEN ~ ELSE ~ END IF
- IF condition THEN
  	statements;
  ELSE
  	statements;
  END IF;
 */

SELECT * FROM EMP;

-- 사원 연봉 계산

DECLARE
	vemp EMP%ROWTYPE;    -- 행단위 참조
	annsal NUMBER(7, 2); -- 연봉
BEGIN
	SELECT * INTO vemp
	FROM EMP
	WHERE ENAME='ALLEN';
	
	-- 연봉 계산
	IF (vemp.comm IS NULL) THEN --  커미션이 NULL 인지 확인
		annsal := vemp.sal * 12;
	ELSE
		annsal := vemp.sal * 12 + vemp.comm;
	END IF;
	
	DBMS_OUTPUT.PUT_LINE('사원번호 : ' || vemp.empno);
	DBMS_OUTPUT.PUT_LINE('이    름 : ' || vemp.ename);
	DBMS_OUTPUT.PUT_LINE('연    봉 : ' || annsal);
	
END ;
/



/*
IF THEN ~ ELSIF ~ ELSE ~ END IF
 */

-- 부서번호로 부서면 확인

DECLARE
	vemp EMP%ROWTYPE;
	vdname VARCHAR2(14);
BEGIN
	SELECT * INTO vemp
	FROM EMP
	WHERE ENAME='ALLEN';
	
	IF (vemp.deptno = 10) THEN
		vdname := 'ACCOUNTING';
	ELSIF (vemp.deptno = 20) THEN
		vdname := 'RESEARCH';
	ELSIF (vemp.deptno = 30) THEN
		vdname := 'SALES';
	ELSIF (vemp.deptno = 40) THEN
		vdname := 'OPERATIONS';
	END IF;
	
	DBMS_OUTPUT.PUT_LINE('사원번호 : ' || vemp.empno);
	DBMS_OUTPUT.PUT_LINE('이    름 : ' || vemp.ename);
	DBMS_OUTPUT.PUT_LINE('부서명   : ' || vdname);
	
END ;
/



/*
BASIC LOOP
- 조건없이 반복 작업 실행
- LOOP
	statement;
	.....
  	EXIT [WHERE condition];
  END LOOP;
 */

-- 1 ~ 5 까지 출력

DECLARE
	n NUMBER := 1;
BEGIN
    DBMS_OUTPUT.PUT_LINE('LOOP');
	LOOP
		DBMS_OUTPUT.PUT_LINE(n);
		n := n + 1;
		IF n > 5 THEN
			EXIT;
		END IF;
	END LOOP;
END ;
/


/*
PL/SQL FOR LOOP
- FOR index IN 시작값..END값 LOOP
  	STATEMENT
  	.....
  END LOOP;
  > index 는 자동 선언되는 BINARY_INTEGER 형 변수. 1씩증가
    IN 다음에는 coursor, select 문 적용 가능
 */

-- 1 ~ 5 까지 출력

DECLARE
BEGIN
    DBMS_OUTPUT.PUT_LINE('FOR LOOP');
	FOR n IN 1..5 LOOP
		DBMS_OUTPUT.PUT_LINE(n);
	END LOOP;
END ;
/


/*
WHILE LOOP
- WHILE condition LOOP
	statement;
	.....
  END LOOP;
 */

-- 1 ~ 5 까지 출력

DECLARE
	n NUMBER := 1;

BEGIN
    DBMS_OUTPUT.PUT_LINE('WHILE LOOP');
	WHILE n <= 5 LOOP
		DBMS_OUTPUT.PUT_LINE(n);
		n := n + 1;
	END LOOP;
END ;
/


--------------------------------------------------------------------------------------


-- EMP 테이블에 사원이름을 사용해서, 해당 사원의 연봉을 구하세요
-- 커미션이 없으면 0으로 변환해서 연봉을 구합니다
DECLARE
	vemp EMP%ROWTYPE;
	annsal NUMBER(7,2);
BEGIN
	-- 사원 정보를 행단위로 저장
	SELECT * INTO vemp
	FROM EMP
	WHERE ENAME='SMITH';
	
	-- 연봉계산
	IF (vemp.comm IS NULL) THEN
		vemp.comm := 0;
	END IF;
	annsal := vemp.sal * 12 + vemp.comm;
	
	DBMS_OUTPUT.PUT_LINE('사원번호 : ' || vemp.empno);
	DBMS_OUTPUT.PUT_LINE('이    름 : ' || vemp.ename);
	DBMS_OUTPUT.PUT_LINE('연    봉 : ' || annsal);
	
END ;
/


-- 구구단 7단의 값을 모두 출력하세요
DECLARE
	dan NUMBER := 7;
	i NUMBER := 1;
BEGIN
	LOOP
		DBMS_OUTPUT.PUT_LINE(dan || ' x ' || i || ' = ' || (dan*i));
		i := i + 1;
		IF i > 9 THEN
			EXIT;
		END IF;
	END LOOP;
	
END ;
/

-- FOR LOOP 를 사용해서 부서번호를 계산하고,
-- 이 값을 SELECT 문의 WHERE 절에 적용해서 부서정보를 출력하세요
-- 부서번호, 부서명, 지역

DECLARE
	vdept DEPT%ROWTYPE;
	
BEGIN
	DBMS_OUTPUT.PUT_LINE('부서번호 / 부서명 / 지역명');
	DBMS_OUTPUT.PUT_LINE('------------------------------');
	
	FOR CNT IN 1..4 LOOP
		SELECT * INTO vdept
		FROM DEPT
		WHERE deptno = 10 * CNT;
		DBMS_OUTPUT.PUT_LINE(vdept.deptno || ' / ' || vdept.dname || ' / ' || vdept.loc);
	END LOOP;
	
END ;
/

































