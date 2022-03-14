
/*
Join
- 하나 이상의 테이블에서, 한번의 질의문으로 원하는 자료를 검색할 때 사용합니다
 */

 SELECT *
 FROM emp, dept;
 
/*
equi join
- 가장 많이 사용하는 조인 방식으로 조인 대상이 되는 두 테이블에서 
  공통적으로 존재하는 컬럼의 값이 일치되는 행을 연결해서 결과를 생성합니다
 */
 
select * from emp;
select * from dept;

-- 사원 정보 출력시에 각 사원들이 소속된 부서의 상세 정보 확인
SELECT *
FROM emp, dept
WHERE emp.deptno = dept.deptno;

-- 위 결과에서 특정 컬럼만 확인
SELECT ename, dname
FROM emp, dept
WHERE emp.deptno = dept.deptno;

-- 이름이 smith인 사람의 부서명 확인
SELECT ename, dname
FROM emp, dept
WHERE emp.deptno = dept.deptno 
AND ename='SMITH';

-- 두개의 테이블에서 동일하게 존재하는 컬럼을 확인할 때에는, 컴럼명 앞에 테이블 명을 명시합니다
SELECT ename, dname, emp.deptno
FROM emp, dept
WHERE emp.deptno = dept.deptno 
AND ename='SMITH';

-- 테이블에 별칭 부여
-- FROM 절 다음에 테이블 이름을 명시하고 공백을 작성한 다음에 별칭을 지정합니다
SELECT E.ename, E.dname, E.deptno
FROM emp E, dept D
WHERE E.deptno = D.deptno
AND E.ename='SMITH';


/*
Non-Equi Join
- 조인 조건에 특정 범위 내에 있는지를 where 절에 비교연산자를 사용해서 join 합니다
 */

desc salgrade;

-- 각 사원의 급여가 몇 등급인지 확인
SELECT ename, sal, grade
FROM emp, salgrade
WHERE sal between losal and hisal;


-- 사원 이름과 소속 부서, 급여의 등급 확인
-- 1. emp 테이블의 부서번호로 dept 테이블을 참조해서 부서이름 가져오고
-- 2. emp 테이블의 급여로 salgrade 테이블 참조해서 등급 가져오기
SELECT E.ename, D.dname, E.sal, S.grade
FROM emp E, dept D, salgrade S
WHERE E.deptno = D.deptno
AND E.sal BETWEEN S.losal AND S.hisal;


/*
Self Join
- 조인은 두개 이상의 서로 다른 테이블을 연결하는 것 뿐만 아니라,
  하나의 테이블 내에서 조인을 해서 원하는 결과를 얻을 수도 있습니다
  자기 자신과 조인을 맺는 것입니다
 */

SELECT * FROM emp;
SELECT ename, mgr FROM emp;
SELECT empno, ename FROM emp;

-- 사원의 담당 manager 확인
SELECT employee.ename || '의 매니저는 ' || manager.ename || ' 입니다'
FROM emp employee, emp manager  -- 자긴 자신의 테이블에 별칭 부여
WHERE employee.mgr = manager.empno; -- 같은 속성값으로 참조


/*
Outer Join
- 조인 조건에 만족하지 않는 행도 나타내는 조인입니다
- 2개 이상의 테이블이 조인될 때, 어느 한쪽의 테이블에는 해당하는 데이터가 있지만,
  다른쪽 테이블에는 데이터가 없을 경우 그 데이터가 출력되지 않는 것을 해결할 수 있습니다
- (+) 기호를 조인 조건에서 정보가 부족한 컬럼 이름 뒤에 붙입니다
 */

select * from emp;
SELECT employee.ename || '의 매니저는 ' || manager.ename || ' 입니다'
FROM emp employee, emp manager  -- 자긴 자신의 테이블에 별칭 부여
WHERE employee.mgr = manager.empno(+); -- 사원번호(empno)가 null 인 사원은 없음


--------------------------------------------------------------------

select * from dept;

-- 'new york' 에서 근무하는 사원의 이름과 급여를 출력하세요
SELECT ename, sal
FROM emp, dept
WHERE emp.deptno = dept.deptno
and dept.loc='NEW YORK';

-- 'smith' 와 동일한 근무지에서 근무하는 사원의 이름을 출력하세요
SELECT e.ename, e2.ename -- e.name (임의의 사원명), e2.enane(같은 사원명)
FROM emp E, emp E2
WHERE e.deptno = e2.deptno
AND e.ename = 'SMITH'
AND e.ename <> e2.ename; -- 왼쪽과 오른쪽에 같은 이름을 가진 컬럼 제거


-- 사원 테이블에는 부서 번호가 40인 사원이 없지만, 
-- 외부 조인(outer join)을 사용해서 부서 테이블에 있는 부서 번호가 40인 부서명 operation 이 출력되게 하세요 
SELECT E.ename, E.deptno, D.deptno, D.dname
FROM emp E, dept D
WHERE E.deptno(+) = D.deptno;











































