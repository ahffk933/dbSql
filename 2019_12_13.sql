SELECT *
FROM emp_test
ORDER BY empno;

--emp���̺� �����ϴ� �����͸� emp_test���̺�� ���� merge
--���� empno�� ������ �����Ͱ� �����ϸ� ename update : ename || '_merge'
--���� empno�� ������ �����Ͱ� �������� ���� ��� emp���̺��� empno, ename emp_test�����ͷ� insert

--emp_Test�����Ϳ��� ������ �����͸� ����
DELETE emp_test
WHERE empno >= 7788;
COMMIT;

--emp���̺��� 14���� ������ ����
--emp_test���̺��� ����� 7788���� ���� 7���� �����Ͱ� ����
--emp���̺��� �̿��Ͽ� emp_Test���̺��� �����ϰԵǸ�
--emp���̺��� �����ϴ� ���� (����� 7788���� ũ�ų� ����) 7��
--emp_test�� ���Ӱ� insert�� �ɰŰ�
--emp, emp_test�� �����ȣ�� �����ϰ� �����ϴ� 7���� �����ʹ� 
--(����� 7788���� ���� ����)ename�÷��� ename || '_modify'�� ������Ʈ�Ѵ�

/*
MERGE INTO ���̺��
USING ������� ���̺� |VIEW|SUBQUERY
ON (���̺��� ��������� �������
WHEN MATCHED THEN
    UPDATE....
WHEN NOT MATCHED THEN
    INSERT....
*/

MERGE INTO emp_test
USING emp
ON (emp.empno = emp_test.empno)
WHEN MATCHED THEN
    UPDATE SET ename = ename || '_mod'
WHEN NOT MATCHED THEN
    INSERT VALUES (emp.empno, emp.ename);
    
SELECT *
FROM emp_test;


-- emp_test���̺� ����� 9999�� �����Ͱ� �����ϸ�
-- ename�� 'brown'���� update
-- �������� ���� ��� empno, ename VALUES (9999, 'brown')���� insert
-- ���� �ó��̷θ� MERGE ������ Ȱ���Ͽ� �ѹ��� sql�� ����
-- :empno -> 9999, :ename -> 'brown'
MERGE INTO emp_test
USING dual
ON (emp_test.empno = :empno)
WHEN MATCHED THEN
    UPDATE SET ename = :ename || '_mod'
WHEN NOT MATCHED THEN 
    INSERT VALUES (:empno, :ename);
SELECT *
FROM emp_test
WHERE empno=9999;

--���� merge������ ���ٸ� (** 2���� SQL�� �ʿ�)
-- 1. empno = 9999�� �����Ͱ� �����ϴ��� Ȯ��
-- 2-1. 1�� ���׿��� �����Ͱ� �����ϸ� UPDATE
-- 2.2. 1�� ���׿��� �����Ͱ� �������� ������ INSERT


SELECT *
FROM emp;
--�μ��� �޿� ��
SELECT deptno, SUM(sal) sal
FROM emp
GROUP BY deptno
ORDER BY deptno;
--��ü ������ �޿� ��
SELECT SUM(sal) sal
FROM emp;

SELECT deptno, SUM(sal) sal
FROM emp
GROUP BY deptno
UNION ALL
SELECT NULL, SUM(sal) sal
FROM emp
ORDER BY deptno;
--���̺��� �ΰ� �������Ѵٴ°� ����

--JOIN ������� Ǯ��
--emp table�� 14���� �����͸� 28������ �����Ұ���
--������(1-14, 2-14)�� �������� group by
--������ 1 : �μ���ȣ �������� 14row
--������ 2 : ��ü 14 row
SELECT DECODE(b.rn, 1, emp.deptno, 2, null) deptno,
       SUM(emp.sal) sal
FROM emp,
    (SELECT ROWNUM rn
     FROM dept
     WHERE ROWNUM <= 2) b
GROUP BY DECODE(b.rn, 1, emp.deptno, 2, null);

--�Ǵ�

SELECT DECODE(b.rn, 1, emp.deptno, 2, null) deptno,
       SUM(emp.sal) sal
FROM emp,
    (SELECT LEVEL rn 
    FROM dual 
    CONNECT BY LEVEL <= 2) b
GROUP BY DECODE(b.rn, 1, emp.deptno, 2, null)
ORDER BY DECODE(b.rn, 1, emp.deptno, 2, null);

--�Ǵ� 

SELECT DECODE(b.rn, 1, emp.deptno, 2, null) deptno,
       SUM(emp.sal) sal
FROM emp,
    (SELECT 1 rn FROM dual UNION ALL
    ) b
GROUP BY DECODE(b.rn, 1, emp.deptno, 2, null)
ORDER BY DECODE(b.rn, 1, emp.deptno, 2, null);



--REOIRT GOUP BY
--ROLLUP
--GROUP BY ROLLUP(col1...)
--ROLLUP ���� ����� �÷��� �����ʿ������� �����
--SUB GROUP�� �����Ͽ� �������� GROUP BY���� �ϳ��� SQL���� ����ǵ��� �Ѵ�
GROUP BY ROLLUP(job, deptno)
--GROUP BY job, deptno
--GROUP BY job
--GROUP BY -> ��ü ���� ������� GROUP BY


--EMP���̺��� �̿��Ͽ� �μ���ȣ��, ��ü������ �޿����� ���ϴ� ������
--ROLLUP����� �̿��Ͽ� �ۼ�
SELECT deptno, SUM(sal)sal
FROM emp
GROUP BY ROLLUP(deptno);

--emp���̺��� �̿��Ͽ� job, deptno�� sal + comm �հ�
--                   job �� sal+comm
--                   ��ü������ sal+comm
--ROLLUP�� Ȱ���Ͽ� �ۼ�
SELECT job, deptno, SUM(sal+ NVL(comm, 0)) sal_sum
FROM emp
GROUP BY ROLLUP(job, deptno);
--GROUP BY job, deptno
--GROUP BY job
--GROUP BY -> ��ü ROW���

--ROLLUP�� �÷� ������ ��ȸ ����� ������ ��ģ��
GROUP BY ROLLUP(deptno, job);
--GROUP BY deptno, job
--GROUP BY deptno
--GROUP BY -> ��ü ROW���
--�����ʺ��� ������


SELECT job, deptno, SUM(sal+ NVL(comm, 0)) sal_sum
FROM emp
GROUP BY ROLLUP(job, deptno)
ORDER BY ;

--�հ� NULL->�հ� �� ����
SELECT NVL(job,'�Ѱ�'), deptno, SUM(sal+ NVL(comm, 0)) sal_sum
FROM emp
GROUP BY ROLLUP(job, deptno);
--�Ǵ�
SELECT DECODE(GROUPING (job), 1, '�Ѱ�', job) job, 
       deptno, SUM(sal+ NVL(comm, 0)) sal_sum
FROM emp
GROUP BY ROLLUP(job, deptno);


SELECT DECODE(GROUPING (job), 1, '��', job) job, 
       CASE
            WHEN deptno IS NULL AND job IS NULL THEN '��'
            WHEN deptno IS NULL AND job IS NOT NULL THEN '�Ұ�'
            ELSE '' || deptno
        END deptno,
        
       SUM(sal+ NVL(comm, 0)) sal_sum
FROM emp
GROUP BY ROLLUP(job, deptno);

--�Ǵ�
SELECT DECODE(GROUPING (job), 1, '��', job) job, 
       DECODE(GROUPING(deptno) + GROUPING(job), 2, '��', 1, '�Ұ�', deptno) deptno ,
       SUM(sal+ NVL(comm, 0)) sal_sum
FROM emp
GROUP BY ROLLUP(job, deptno);



SELECT *
FROM emp;

--AD3
SELECT deptno, job, SUM(sal+ NVL(comm, 0)) sal_sum
FROM emp
GROUP BY ROLLUP(deptno, job);
--�Ǵ� 
SELECT deptno,
       DECODE(GROUPING(job), 1, null, job) job,
       SUM(sal+ NVL(comm, 0)) sal
FROM emp
GROUP BY ROLLUP(deptno, job); 

--UNION ALL�� ��ȯ
SELECT deptno, job, SUM(sal + NVL(comm, 0)) sal_sum
FROM emp
GROUP BY deptno, job
UNION ALL
SELECT deptno, null, SUM(sal + NVL(comm, 0))sal_sum
FROM emp
GROUP BY deptno
UNION ALL
SELECT null, null, SUM(sal + NVL(comm, 0)) sal_sum
FROM emp;

--AD4
SELECT dname, job, SUM(sal+ NVL(comm, 0)) sal
FROM emp, dept
WHERE emp.deptno = dept.deptno
GROUP BY ROLLUP(dname, job)
ORDER BY dname;

SELECT dname, job, sal
FROM (SELECT deptno, job, SUM(sal + NVL(comm, 0) sal
      FROM emp
      GROUP BY ROLLUP(deptno, job))a, dept
WHERE a.deptno = dept.deptno
GROUP BY ROLLUP(dname, job); --�̿ϼ�

--AD5
SELECT DECODE(GROUPING (dname), 1, '����', dname) dname, job, SUM(sal+ NVL(comm, 0)) sal
FROM emp, dept
WHERE emp.deptno = dept.deptno
GROUP BY ROLLUP(dname, job)
ORDER BY dname;




SELECT *
FROM emp;
SELECT *
FROM dept;
DELETE dept
WHERE deptno=99; 
