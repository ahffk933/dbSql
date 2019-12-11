--index만 조회하여 요구사항에 만족하는 데이터를 만들어 낼 수 있는 경우

SELECT rowid, emp.*
FROM emp;

SELECT empno, rowid
FROM emp
ORDER BY empno;

--emp table의 모든 컬럼을 조회\
EXPLAIN PLAN FOR
SELECT empno
FROM emp
WHERE empno = 7782;

SELECT *
FROM TABLE(dbms_xplan.display);


--기존 인덱스 제거
--pk_emp 제약조건 삭제 -> unique제약 삭제 -> pk_emp인덱스 삭제

--INDEX 종류 (컬럼중복 여부)
--UNIQUE INDEX : 인덱스 컬럼의 값이 중복될 수 없는 인덱스
--              (emp.empno, dept.deptno)
--NON-UNIUE INDEX : 인덱스 컬럼의 값이 중복 될 수 있는 인덱스
--                 (emp.job)
ALTER TABLE emp DROP CONSTRAINT pk_emp;
--CREATE UNIQUE INDEX idx_n_emp_01 ON emp (empno);

--위쪽 상황과 달라진 것은 empno컬럼으로 생성된 인덱스가
--UNIQUE -> NON UNIQUE 인덱스로 변경됨.
CREATE INDEX idx_n_emp_01 ON emp(empno);

EXPLAIN PLAN FOR
SELECT *
FROM emp
WHERE empno=7782;

SELECT *
FROM TABLE(dbms_xplan.display);



INSERT INTO emp (empno, ename) VALUES (7782, 'brown');
ROLLBACK;
COMMIT;



--DEPT TABLE에는 PK_DEPT ( PRIMARY KEY제약 조건이 설정됨)
--PK_DEPT : deptno
SELECT *
FROM dept;
INSERT INTO dept VALUES (20, 'ddit', '대전');

SELECT *
FROM USER_CONSTRAINTS
WHERE TABLE_NAME='DEPT';

SELECT *
FROM USER_CONS_COLUMNS
WHERE TABLE_NAME='DEPT';

CREATE INDEX idx_n_emp_01 ON emp (empno);

--emp테이블에 job컬럼으로 non-unique index 생성
--인덱스명 : idx_n_emp_02
CREATE INDEX idx_n_emp_02 ON emp (job);

SELECT job, rowid
FROM emp
ORDER BY job;

--emp table에는 인덱스 2개 존재
--1. empno
--2. job

SELECT *
FROM emp
WHERE job = 'MANAGER';

--IDX_02인덱스
--emp table에는 인덱스 2개 존재
--1. empno
--2. job
SELECT *
FROM emp
WHERE job = 'MANAGER'
AND ename LIKE 'C%';

--idx_n_emp_03
--emp table의 job, ename 컬럼으로 non-unique인덱스 생성
CREATE INDEX idx_n_emp_03 ON emp (job, ename);

SELECT ename, job, rowid
FROM emp
ORDER BY ename, job;

--idx_n_emp_04
--ename, job컬럼으로 emp 테이블에 non-unique인덱스 생성 --복합컬럼 순서 중요
CREATE INDEX idx_n_emp_04 ON emp (ename, job);
SELECT ename, job, rowid
FROM emp
WHERE job = 'MANAGER'
AND ename LIKE 'J%';

EXPLAIN PLAN FOR
SELECT *
FROM emp
WHERE job='MANAGER'
AND ename LIKE 'J%';

SELECT *
FROM TABLE(dbms_xplan.display);

--조인쿼리에서의 인덱스
--EMP 테이블은 EMPNO컬럼으로 PRIMARY KEY 제약조건이 존재
--DEPT 테이블은 DEPTNO컬럼으로 PRIMARY KEY 제약조건 존재
--emp table은 PRIMARY KEY제약을 삭제한 상태이므로 재생성
DELETE emp
WHERE ename = 'brown';
COMMIT;

ALTER TABLE emp ADD CONSTRAINT pk_emp PRIMARY KEY (empno);

EXPLAIN PLAN FOR
SELECT ename, dname, loc
FROM emp, dept
WHERE emp.deptno = dept.deptno
AND emp.empno=7788;

SELECT *
FROM TABLE(dbms_xplan.display);

-----------------------------------------
DROP TABLE dept_test;

CREATE TABLE dept_test AS
SELECT *
FROM DEPT
WHERE 1 = 1;

CREATE UNIQUE INDEX idx_u_dept_test_01 ON dept_test (deptno);
CREATE INDEX idx_n_dept_test_02 ON dept_test (dname);
CREATE INDEX idx_n_dept_test_03 ON dept_test (deptno, dname);


DROP INDEX idx_u_dept_test_01;
DROP INDEX idx_n_dept_test_02;
DROP INDEX idx_n_dept_test_03;

