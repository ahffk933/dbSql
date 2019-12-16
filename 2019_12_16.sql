--GROUPINT SETS(col1, col2)
--������ ����� ����
--�����ڰ� GTOUP BY�� ������ ���� ����Ѵ�
--ROLL UP�� �޸� ���⼺�� ���� �ʴ´�
--GROUPING SET(col1, col2) = GROUPTING SETS(col2, col1)


--GROUP BY col1
--UNION ALL
--GOUP BY col2

--emp���̺��� ������ job�� �޿�(sal) + ��(comm)��,
--                   dept(�μ�)�� �޿�(sal) + ��(comm)�� ���ϱ�
--���� ���(GROUP FUNCTION) : 2���� SQL�ۼ� �ʿ�(UNION / UNION ALL)

SELECT job, null deptno, SUM(sal + NVL(comm, 0)) sal_comm_sum
FROM emp
GROUP BY job
UNION ALL
SELECT '', deptno, SUM(sal + NVL(comm, 0)) sal_comm_sum
FROM emp
GROUP BY deptno; 

--GROUPING SETS������ �̿��Ͽ� ���� SQL�� ���տ����� ������� �ʰ� ���̺��� �ѹ� �о ó��
SELECT job, deptno, SUM(sal + NVL(comm, 0 )) sal_comm_sum
FROM emp
GROUP BY GROUPING SETS (job, deptno);

--job, deptno�� �׷����� �� sal+comm ��
--mgr�� �׷����� �� sal+comm ��
--GROUP BY job, deptno
--UNION ALL
--GROUP BY mgr
-- -> GROUPING SETS((job, deptno), mgr)
--null�� ����~!
SELECT job, deptno, mgr, SUM(sal + NVL(comm, 0)) sal_comm_sum,
       GROUPING(job), GROUPING(deptno), GROUPING(mgr)
FROM emp
GROUP BY GROUPING SETS ((job, deptno), mgr);

--CUBE (col1, col2 ...)
--������ �÷��� ��� ������ �������� GROUP BY subset�� �����
--CUBE�� ������ �÷��� 2���� ��� : ������ ���� 4��
--CUBE�� ������ �÷��� 2���� ��� : ������ ���� 8��
--CUBE�� ������ �÷� ���� 2�� ������ �� ����� ������ ���� ������ �ȴ� (2^n)
--�÷��� ���ݸ� �������� ������ ������ ���ϱ޼������� �þ�� ������ ���� ������� �ʴ´�

--job, deptno�� �̿��Ͽ� CUBE����
SELECT job, deptno, SUM(sal + NVL(comm, 0 )) sal_comm_sum
FROM emp
GROUP BY CUBE(job, deptno);
--job, deptno
--1, 1 -> GROUP BY job, deptno
--1, 0 -> GROUP BY job
--0, 1 -> GROUP BY deptno
--0, 0 -> GROUP BY --emp���̺��� ����࿡ ���� GROUP BY

--GROUP BY ����
--GROUP BY, ROLLUP, CUBE�� ���� ����ϱ�
--������ ������ �����غ��� ���� ����� ������ �� �ִ�
--GROUP BY job, rollup(deptno), cube(mgr)

SELECT job, deptno, mgr, SUM(sal + NVL(comm, 0)) sal_comm_sum
FROM emp
GROUP BY job, ROLLUP(deptno), CUBE(mgr);

SELECT job, SUM(sal)
FROM emp
GROUP BY job;


--test1
DROP TABLE dept_test;

CREATE TABLE dept_test AS               --���̺� ����
SELECT *
FROM emp;

ALTER TABLE dept_test ADD(empcnt NUMBER(6));   --�÷��߰�

UPDATE dept_test SET empcnt = (SELECT count(*)     --������Ʈ --(eg.�μ��� �ο���..�������� WHERE ??)
                              FROM emp
                              WHERE emp.deptno = dept_test.deptno);
                            --GROUP BY deptno); ��������
SELECT *
FROM dept_test;

--test2 
CREATE TABLE dept_test AS               --���̺� ����
SELECT *
FROM dept;

INSERT INTO dept_test VALUES (99, 'IT1', 'daejeon');
INSERT INTO dept_test VALUES (98, 'IT2', 'daejeon');

SELECT *
FROM dept_test
WHERE deptno NOT IN ( SELECT deptno
                      FROM emp);
--�Ǵ�
DELETE dept_test
WHERE deptno IN ( SELECT deptno
                  FROM emp);
SELECT *
FROM dept_test;

--test3
DROP TABLE emp_test;

CREATE TABLE emp_test AS
SELECT *
FROM emp;

UPDATE emp_test SET sal = sal + 200
WHERE sal <(SELECT ROUND (AVG(sal), 2)
            FROM emp
            WHERE deptno = emp_test.deptno
            );
ROLLBACK;

SELECT empno, ename, deptno, sal
FROM emp_test
ORDER BY deptno;

SELECT deptno, ROUND(AVG(sal), 2)
FROM emp
GROUP BY deptno
ORDER BY deptno;

SELECT deptno, AVG(sal)
FROM emp_test
GROUP BY deptno;

--MERGE������ �̿��� ������Ʈ
MERGE INTO emp_test a
USING (SELECT deptno, AVG(sal) avg_sal
FROM emp_test
GROUP BY deptno) b 
ON (a.deptno = b.deptno) 
--    AND a.sal < avg_sal)  -- ON���� ���Ե� update���� ����ȵʤ�����
WHEN MATCHED THEN 
    UPDATE SET sal = sal + 200
    WHERE a.sal < b.avg_sal;


ROLLBACK;

--MERGE + CASE(IF)                     
MERGE INTO emp_test a
USING (SELECT deptno, AVG(sal) avg_sal
        FROM emp_test
        GROUP BY deptno) b 
ON (a.deptno = b.deptno) 

WHEN MATCHED THEN 
    UPDATE SET sal = CASE
                        WHEN a.sal < b.avg_sal THEN sal + 200
                        ELSE sal
                        END;   