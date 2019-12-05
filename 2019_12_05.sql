
SELECT deptno, dname, loc
FROM dept
WHERE deptno IN (99, 40);

--������ �����ϴ� �μ�����
SELECT *
FROM dept
WHERE deptno NOT IN (SELECT deptno
                     FROM emp);

--1������ ���� �ʴ� ��ǰ ã��
SELECT pid, pnm
FROM product
WHERE pid NOT IN (SELECT pid
                  FROM cycle
                  WHERE cid = 1);

--cid =2�� ���� �����ϴ� ��ǰ �� cid=1���� �����ϴ� ��ǰ ��ȸ                  
SELECT *
FROM cycle
WHERE cid = 1
AND pid IN (SELECT pid
            FROM cycle
            WHERE cid = 2);

SELECT *
FROM customer;
SELECT *
FROM cycle;
SELECT *
FROM product;

--
SELECT customer.cnm, c.pid, product.pnm, day, cnt
FROM customer, product,(
        SELECT *
        FROM cycle
        WHERE cid = 1
        AND cycle.pid IN (SELECT pid
                          FROM cycle 
                          WHERE cid = 2)) c
WHERE customer.cid = c.cid
AND c.pid = product.pid;

SELECT cnm, cycle.pid, pnm, day, cnt
FROM cycle, customer, product
WHERE cycle.cid =1
AND cycle.cid = customer.cid
AND cycle.pid = product.pid
AND cycle.pid IN(SELECT * FROM cycle
WHERE cid =2);

--�Ŵ����� �����ϴ� ����
SELECT *
FROM emp e
WHERE EXISTS ( SELECT 1 FROM emp m WHERE m.empno = e.mgr);

SELECT *
FROM emp 
WHERE mgr IS NOT NULL;

SELECT e.*
FROM emp e, emp m
WHERE m.empno = e.mgr;

--cid=1�� �����ϴ� ��ǰ
SELECT pid, pnm
FROM product
WHERE EXISTS (SELECT 'x' 
              FROM cycle 
              WHERE cid =1 
              AND product.pid = cycle.pid); 
--cid=1�� �������� �ʴ� ��ǰ
SELECT pid, pnm
FROM product
WHERE NOT EXISTS (SELECT 'x' 
                  FROM cycle 
                  WHERE cid = 1 
                  AND product.pid = cycle.pid);


--���տ���
--UNION:������, �� ������ �ߺ����� �����Ѵ�
--�������� SALESMAN�� ������ ������ȣ, ���� �̸� ��ȸ
--���Ʒ� ������� �����ϱ� ������ ������ ������ �ϰ� �� ��� �ߺ��Ǵ� �����ʹ� �ѹ��� ǥ���Ѵ�
SELECT empno, ename
FROM emp
WHERE job = 'SALESMAN'

UNION

SELECT empno, ename
FROM emp
WHERE job = 'SALESMAN';

--���� �ٸ� ������ ������
SELECT empno, ename
FROM emp
WHERE job = 'SALESMAN'

UNION

SELECT empno, ename
FROM emp
WHERE job = 'CLERK';

--UNOIN ALL
--������ ����� �ߺ� ���Ÿ� ���� �ʴ´�
--���Ʒ� ��� ���� �ٿ� �ֱ⸸ �Ѵ�
SELECT empno, ename
FROM emp
WHERE job = 'SALESMAN'

UNION ALL

SELECT empno, ename
FROM emp
WHERE job = 'SALESMAN';

--���տ���� ���ռ��� �÷��� ���� �ؾ��Ѵ�
--�÷��� ������ �ٸ� ��� ������ ���� �ִ� ������� ������ �����ش�
SELECT empno, ename, ''
FROM emp
WHERE job = 'SALESMAN'

UNION ALL

SELECT empno, ename, job
FROM emp
WHERE job = 'SALESMAN';

--INTERSECT : ������
--�� ���հ� �������� �����͸� ��ȸ
SELECT empno, ename
FROM emp
WHERE job IN ('SALESMAN', 'CLERK')

INTERSECT

SELECT empno, ename
FROM emp
WHERE job IN ('SALESMAN');

--MINUS
--������ : ��, �Ʒ� ������ �������� �� ���տ��� ������ ������ ��ȸ
--�������� ��� ������, �����հ� �ٸ��� ������ ���� ������ ��� ���տ� ������ �ش�
SELECT empno, ename
FROM emp
WHERE job IN ('SALESMAN', 'CLERK')

MINUS

SELECT empno, ename
FROM emp
WHERE job IN ('SALESMAN');


--���տ��� �� UNION ALL�� �ߺ��� ����~ 
SELECT empno, ename
FROM
(SELECT empno, ename
FROM emp
WHERE job IN ('SALESMAN', 'CLERK')
ORDER BY job)

UNION ALL

SELECT empno, ename 
FROM emp
WHERE job IN ('SALESMAN')
ORDER BY ename;

--DML
--INSERT : ���̺� ���ο� �����͸� �Է�
SELECT *
FROM dept;

DELETE dept
WHERE deptno=99;
COMMIT;

--INSERT �� �÷��� ������ ���
--������ �÷��� ���� �Է��� ���� ������ ������ ����Ѵ�
--INSERT INTO ���̺�� (�÷�1, �÷�2...)
--              VALUES (��1, ��2...)
--dept���̺� 99�� �μ���ȣ, ddit ������, daejeon �������� ���� ������ �Է�
INSERT INTO dept (deptno, dname, loc)
            VALUES (99, 'ddit', 'daejeon');

ROLLBACK;

SELECT *
FROM dept;
--�÷��� ����� ��� ���̺��� �÷� ���� ������ �ٸ��� �����ص� ����� ����
--dept���̺��� �÷� ���� : deptno, dname, location
INSERT INTO dept (loc, deptno, dname)
            VALUES ('daejeon', 99, 'ddit');
            ROLLBACK;
            
--�÷��� ������� �ʴ� ��� : ���̺��� �÷� ���� ������ ���� ���� ����Ѵ�
INSERT INTO dept VALUES (99, 'ddit', 'daejeon'); -- =DESC dept;

--��¥ �� �Է��ϱ�
--1. SYSDATE
--2. ����ڷ� ���� ���� ���ڿ��� DATE Ÿ������ �����Ͽ� �Է�
DESC emp;
INSERT INTO emp VALUES (9998, 'sally', 'SALESMAN', NULL, SYSDATE, 500, NULL, NULL);

SELECT *
FROM emp;

--2019�� 12�� 2�� �Ի�
INSERT INTO emp VALUES (9997, 'james', 'CLERK', NULL, TO_DATE('20191202', 'YYYYMMDD'), 500, NULL, NULL);
ROLLBACK;

--�������� �����͸� �ѹ��� �Է�
--SELECT ����� ���̺� �Է� �� �� �ִ�
INSERT INTO emp 
SELECT 9998, 'sally', 'SALESMAN', NULL, SYSDATE, 500, NULL, NULL
FROM dual
UNION ALL
SELECT 9997, 'james', 'CLERK', NULL, TO_DATE('20191202', 'YYYYMMDD'), 500, NULL, NULL
FROM dual;

ROLLBACK;