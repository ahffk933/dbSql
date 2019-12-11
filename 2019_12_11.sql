--index�� ��ȸ�Ͽ� �䱸���׿� �����ϴ� �����͸� ����� �� �� �ִ� ���

SELECT rowid, emp.*
FROM emp;

SELECT empno, rowid
FROM emp
ORDER BY empno;

--emp table�� ��� �÷��� ��ȸ\
EXPLAIN PLAN FOR
SELECT empno
FROM emp
WHERE empno = 7782;

SELECT *
FROM TABLE(dbms_xplan.display);


--���� �ε��� ����
--pk_emp �������� ���� -> unique���� ���� -> pk_emp�ε��� ����

--INDEX ���� (�÷��ߺ� ����)
--UNIQUE INDEX : �ε��� �÷��� ���� �ߺ��� �� ���� �ε���
--              (emp.empno, dept.deptno)
--NON-UNIUE INDEX : �ε��� �÷��� ���� �ߺ� �� �� �ִ� �ε���
--                 (emp.job)
ALTER TABLE emp DROP CONSTRAINT pk_emp;
--CREATE UNIQUE INDEX idx_n_emp_01 ON emp (empno);

--���� ��Ȳ�� �޶��� ���� empno�÷����� ������ �ε�����
--UNIQUE -> NON UNIQUE �ε����� �����.
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



--DEPT TABLE���� PK_DEPT ( PRIMARY KEY���� ������ ������)
--PK_DEPT : deptno
SELECT *
FROM dept;
INSERT INTO dept VALUES (20, 'ddit', '����');

SELECT *
FROM USER_CONSTRAINTS
WHERE TABLE_NAME='DEPT';

SELECT *
FROM USER_CONS_COLUMNS
WHERE TABLE_NAME='DEPT';

CREATE INDEX idx_n_emp_01 ON emp (empno);

--emp���̺� job�÷����� non-unique index ����
--�ε����� : idx_n_emp_02
CREATE INDEX idx_n_emp_02 ON emp (job);

SELECT job, rowid
FROM emp
ORDER BY job;

--emp table���� �ε��� 2�� ����
--1. empno
--2. job

SELECT *
FROM emp
WHERE job = 'MANAGER';

--IDX_02�ε���
--emp table���� �ε��� 2�� ����
--1. empno
--2. job
SELECT *
FROM emp
WHERE job = 'MANAGER'
AND ename LIKE 'C%';

--idx_n_emp_03
--emp table�� job, ename �÷����� non-unique�ε��� ����
CREATE INDEX idx_n_emp_03 ON emp (job, ename);

SELECT ename, job, rowid
FROM emp
ORDER BY ename, job;

--idx_n_emp_04
--ename, job�÷����� emp ���̺� non-unique�ε��� ���� --�����÷� ���� �߿�
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

--�������������� �ε���
--EMP ���̺��� EMPNO�÷����� PRIMARY KEY ���������� ����
--DEPT ���̺��� DEPTNO�÷����� PRIMARY KEY �������� ����
--emp table�� PRIMARY KEY������ ������ �����̹Ƿ� �����
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

