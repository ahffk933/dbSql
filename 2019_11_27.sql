--GROUP FUNCTION
--Ư�� �÷��̳�, ǥ���� �������� �������� ���� ������ ����� ����
--COUNT-�Ǽ�, SUM-�հ� ,AVG-���, MAX-�ִ밪 ,MIN-�ּҰ�
--��ü ������ ������� (14���� ->1������)
--���� ���� �޿�

SELECT MAX(sal) max_sal, --���� ���� �޿�
       MIN(sal) min_sal, --���� ���� �޿�
       ROUND(AVG(sal),2) avg_sal, --�� ������ ��� �޿�
       SUM(sal) sum_sal, --�� ������ �޿� ���
       COUNT(sal) count_sal, --�޿� �Ǽ�(null�� �ƴ� ���̸� 1��)
       COUNT(mgr) count_mgr, --������ ������ �Ǽ�(KING�� ��� MGR�� ����)
       COUNT(*) count_row --Ư�� �÷��� �Ǽ��� �ƴ϶� ���� ������ �˰� ������

FROM emp;

--�μ���ȣ�� �׷��Լ� ����
SELECT deptno,
       MAX(sal) max_sal, --�μ����� ���� ���� �޿�
       MIN(sal) min_sal, --�μ����� ���� ���� �޿�
       ROUND(AVG(sal),2) avg_sal, --�μ� ������ ��� �޿�
       SUM(sal) sum_sal, --�μ� ������ �޿� �հ�
       COUNT(sal) count_sal, --�μ��� �޿� �Ǽ�(null�� �ƴ� ���̸� 1��)
       COUNT(mgr) count_mgr, --�μ������� ������ �Ǽ�(KING�� ��� MGR�� ����)
       COUNT(*) count_row  --�μ��� ������ ��
FROM emp
GROUP BY deptno;
--3��

SELECT deptno, ename,
       MAX(sal) max_sal, --�μ����� ���� ���� �޿�
       MIN(sal) min_sal, --�μ����� ���� ���� �޿�
       ROUND(AVG(sal),2) avg_sal, --�μ� ������ ��� �޿�
       SUM(sal) sum_sal, --�μ� ������ �޿� �հ�
       COUNT(sal) count_sal, --�μ��� �޿� �Ǽ�(null�� �ƴ� ���̸� 1��)
       COUNT(mgr) count_mgr, --�μ������� ������ �Ǽ�(KING�� ��� MGR�� ����)
       COUNT(*) count_row  --�μ��� ������ ��
FROM emp
GROUP BY deptno, ename;
--14��

--SELECT������ GROUP BY���� ǥ���� �÷� �̿��� �÷��� �� �� ����
--�������� ������ ���� ����(�������� ���� ������ �Ѱ��� �����ͷ� �׷���)
--�� ���������� ��������� SELECT���� ǥ�� ����
SELECT deptno, 1, '���ڿ�', SYSDATE,
       MAX(sal) max_sal, --�μ����� ���� ���� �޿�
       MIN(sal) min_sal, --�μ����� ���� ���� �޿�
       ROUND(AVG(sal),2) avg_sal, --�μ� ������ ��� �޿�
       SUM(sal) sum_sal, --�μ� ������ �޿� �հ�
       COUNT(sal) count_sal, --�μ��� �޿� �Ǽ�(null�� �ƴ� ���̸� 1��)
       COUNT(mgr) count_mgr, --�μ������� ������ �Ǽ�(KING�� ��� MGR�� ����)
       COUNT(*) count_row  --�μ��� ������ ��
FROM emp
GROUP BY deptno;

--�׷��Լ����� NULL�÷��� ��꿡�� ����
--EMP���̺��� comm�÷��� null�� �ƴ� �����ʹ� 4���� ����, 9���� NULL)
SELECT COUNT(comm) count_comm,  --NULL�� �ƴ� ���� ���� -> 4
       SUM(comm) sum_comm,      --NULL���� ����, 300+500+1400+0=2200
       SUM(sal) sum_sal,
       SUM(sal + comm) tot_sal_sum,
       SUM(sal + NVL(comm, 0)) tot_sal_sum
FROM emp;

--WHERE������ GROUP �Լ��� ǥ���� �� ����
--1. �μ��� �ִ� �޿� ���ϱ�
--2. �μ��� �ִ� �޿� ���� 3000�Ѵ� �ุ ���ϱ�
SELECT deptno,
       MAX(sal) max_sal > 3000 --ORA-00934���� WHERE���� GROUP�Լ��� �� �� ����
FROM emp
GROUP BY deptno;

SELECT deptno, MAX(sal) m_sal
FROM emp
GROUP BY deptno
HAVING MAX(sal) >= 3000;

SELECT 
       MAX(sal) max_sal,
       MIN(sal)min_sal,
       ROUND(AVG(sal),2)avg_sal,
       SUM(sal)sum_sal,
       COUNT(sal)count_sal,
       COUNT(comm)count_comm,
       COUNT(*)count_row
FROM emp;


SELECT deptno,
       MAX(sal) max_sal,
       MIN(sal)min_sal,
       ROUND(AVG(sal),2)avg_sal,
       SUM(sal)sum_sal,
       COUNT(sal)count_sal,
       COUNT(comm)count_comm,
       COUNT(*)count_row
FROM emp
GROUP BY deptno;

SELECT DECODE(deptno,10, 'ACCOUNTING', 20, 'RESEARCH', 30,'SALES') as DNAME,
       MAX(sal) max_sal,
       MIN(sal)min_sal,
       ROUND(AVG(sal),2)avg_sal,
       SUM(sal)sum_sal,
       COUNT(sal)count_sal,
       COUNT(comm)count_comm,
       COUNT(*)count_row
  
FROM emp
GROUP BY deptno
ORDER BY dname;


SELECT (TO_CHAR(hiredate, 'YYYYMM')) hired_yyyymm,
COUNT(*) cnt

FROM emp
GROUP BY TO_CHAR(hiredate, 'YYYYMM');


SELECT hire_yyyy, COUNT(*) cnt
FROM(
    SELECT TO_CHAR(hiredate, 'YYYY') as hire_yyyy
    FROM emp) hire_yyyy
    
GROUP BY hire_yyyy;


SELECT COUNT(deptno) as cnt
FROM dept;


--��ü ���� ��
SELECT COUNT(*), COUNT(empno), COUNT(mgr)
FROM emp;
--��ü �μ� ��(dept)
SELECT COUNT(*), COUNT(deptno), COUNT(loc)
FROM dept;

SELECT COUNT(COUNT(deptno)) cnt
FROM emp
GROUP BY deptno;


SELECT COUNT(DISTINCT deptno) deptno
FROM emp;

--JOIN
--1. ���̺� ��������(�÷� �߰�)
--2. �߰��� �÷��� ���� update
--dname �÷��� emp���̺� �߰�
DESC emp;

--�÷��߰�(dname, VARCHAR(14))

ALTER TABLE emp ADD (dname VARCHAR2(14));
DESC emp;

SELECT *
FROM emp;

UPDATE emp SET dname = CASE
                            WHEN deptno = 10 THEN 'ACCOUNTING'
                            WHEN deptno = 20 THEN 'RESEARCH'
                            WHEN deptno = 30 THEN 'SALES'
                        END;
COMMIT;

SELECT empno, ename, deptno, dname
FROM emp;

--SALES -> MARKET SALES
--�� 6���� ������ ������ �ʿ�
--���� �ߺ��� �ִ� ����(�� ������)
--��) UPDATE emp SET dname = 'MARKET SALES'
--    WHERE dname = 'SALES';

--emp���̺�, dept ���̺� ����
SELECT ename, emp.deptno, dept.dname
FROM emp, dept
WHERE emp.deptno = dept.deptno;
