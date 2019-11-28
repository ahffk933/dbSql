--emp���̺�, dept ���̺� ����
EXPLAIN PLAN FOR
SELECT ename, emp.deptno, dept.dname
FROM emp, dept
WHERE emp.deptno = dept.deptno
AND emp.deptno =10;

SELECT *
FROM TABLE(DBMS_XPLAN.DISPLAY);
Plan hash value: 615168685
 
---------------------------------------------------------------------------
| Id  | Operation          | Name | Rows  | Bytes | Cost (%CPU)| Time     |
---------------------------------------------------------------------------
|   0 | SELECT STATEMENT   |      |    14 |   308 |     7  (15)| 00:00:01 |
|*  1 |  HASH JOIN         |      |    14 |   308 |     7  (15)| 00:00:01 |
|   2 |   TABLE ACCESS FULL| DEPT |     4 |    52 |     3   (0)| 00:00:01 |
|   3 |   TABLE ACCESS FULL| EMP  |    14 |   126 |     3   (0)| 00:00:01 |
---------------------------------------------------------------------------
 2-3-1-0 ���� -> 0(1(2,3))
Predicate Information (identified by operation id):
---------------------------------------------------
 
   1 - access("EMP"."DEPTNO"="DEPT"."DEPTNO")
   2 - filter("DEPT"."DEPTNO"=10)
   3 - filter("EMP"."DEPTNO"=10)
   
SELECT ename, emp.deptno, dept.dname
FROM emp, dept
WHERE emp.deptno != dept.deptno --empdept�� 10������ dept.deptno�� 10 ������ 20, 30, 40�� DNAME
AND emp.deptno =10;

--natural join : ���� ���̺� ���� Ÿ��, ���� �̸��� �÷����� ���� ���� ���� ��� ����

DESC emp;
DESC dept;

--ANSI SQL
SELECT deptno, a.empno, ename
FROM emp a NATURAL JOIN dept b;

ALTER TABLE emp DROP COLUMN dname;

--Oracle ����
SELECT a.deptno, a.empno, ename
FROM emp a, dept b
WHERE a.deptno = b.deptno;
--column ambiguously define ��Ī�̳� ?�� ��ȣ�ϰ� �Ǿ������� ��Ÿ���� ���� ����

--JOIN USING
--join �Ϸ��� �ϴ� ���̺� ������ �̸��� �÷��� �ΰ� �̻��϶�
--join �÷��� �ϳ��� ����ϰ� ���� ��

--ANSI SQL
SELECT
FROM emp JOIN dept USING (deptno);

--Oracle SQL
SELECT *
FROM emp, dept
WHERE emp.deptno = dept.deptno;

SELECT *
FROM emp, dept;

SELECT *
FROM emp, dept
WHERE emp.deptno = dept.deptno;

--ANSI JOIN with ON
--���� �ϰ��� �ϴ� ���̺��� �÷� �̸��� �ٸ���
--�����ڰ� ���� ������ ���� ������ ��

SELECT *
FROM emp JOIN dept ON (emp.deptno = dept.deptno)
WHERE emp.deptno = 10;

--Oracle
SELECT *
FROM emp, dept
WHERE emp.deptno = dept.deptno;

--SELF JOIN : ���� ���̺� ����
--emp ���̺� ���� �Ҹ��� ���� : ������ ������ ���� ��ȸ
--������ ������ ������ ��ȸ
--�����̸�, ������ �̸�

--ANSI
SELECT e.ename, m.ename 
FROM emp e JOIN emp m ON(e.mgr = m.empno);

--Oracle
SELECT e.ename, m.ename
FROM emp e, emp m
WHERE e.mgr = m.empno;

----���� �̸�, ������ ������ �̸�, ������ �������� ����� �̸�
SELECT e.ename, m.ename, t.ename
FROM emp e, emp m , emp t
WHERE e.mgr = m.empno
AND m.mgr = t.empno;

--���� �̸�, ������ ����� �̸�, ������ ������� ����� �̸�, ���� �������� �������� �������� �̸�
SELECT e.ename, m.ename, t.ename, p.ename
FROM emp e, emp m , emp t, emp p
WHERE e.mgr = m.empno
AND m.mgr = t.empno
AND t.mgr = p.empno;

--�������̺��� ANSI JOIN�� �̿��� JOIN
SELECT e.ename, m.ename, t.ename, p.ename
FROM emp e JOIN emp m ON (e.mgr = m.empno)
    JOIN emp t ON (m.mgr = t.empno)
        JOIN emp p ON (t.mgr = p.empno);
        
--������ �̸��� �ش� ������ ��� �̸��� ��ȸ
--��, ������ ����� 7369~7698�� ���� ������� ��ȸ

--Oracle
SELECT a.ename, b.ename
FROM emp a, emp b
WHERE a.mgr = b.empno
AND a.empno BETWEEN 7369 AND 7698;

--ANSI
SELECT s.ename, m.ename
FROM emp s JOIN emp m ON(s.mgr = m.empno)
WHERE s.empno BETWEEN 7369 AND 7698;

--NON-EQUI JOIN : ���� ������ =(equal)�� �ƴ� JOIN
--!=, BETWEEN___ AND___

SELECT *
FROM salgrade;

SELECT empno, ename, sal /* �޿� grade */
FORM emp;

SELECT empno, ename, sal, grade
FROM emp, salgrade

WHERE emp.sal BETWEEN salgrade.losal AND salgrade.hisal;

WHERE emp.sal>= salgrade.losal 
AND emp.sal <= salgrade.hisal;

--ANSI
SELECT empno, ename, sal, grade
FROM emp JOIN salgrade ON emp.sal BETWEEN salgrade.losal AND salgrade.hisal;

--test1
SELECT empno, ename, deptno
FROM emp;
SELECT *
FROM dept;

SELECT emp.empno, emp.ename, emp.deptno, dept.dname
FROM emp, dept
WHERE emp.deptno = dept.deptno
ORDER BY deptno;

--test2
SELECT x.*
FROM
(SELECT empno, ename, sal, emp.deptno, dept.dname
FROM emp, dept
WHERE emp.deptno = dept.deptno) x
WHERE x.deptno = 10 OR x.deptno = 30;

SELECT empno, ename, sal, emp.deptno, dept.dname
FROM emp, dept
WHERE emp.deptno = dept.deptno
AND emp.deptno IN (10, 30);

--test3
SELECT empno, ename, sal, emp.deptno, dept.dname
FROM emp, dept
WHERE sal >= 2500;

SELECT empno, ename, sal, emp.deptno, dept.dname
FROM emp JOIN dept ON emp.sal >= 2500;

--test4
SELECT empno, ename, sal, emp.deptno, dept.dname
FROM emp, dept
WHERE sal >=2500 AND empno > 7600;

SELECT empno, ename, sal, emp.deptno, dept.dname
FROM emp JOIN dept ON emp.sal >= 2500 AND empno > 7600;
        


