
SELECT *
FROM emp
WHERE DEPTNO <> 10  AND HIREDATE >= TO_DATE('19810601', 'YYYYMMDD');
-- <>, != :�ƴϴ�

SELECT *
FROM emp
WHERE DEPTNO NOT IN (10) 
AND HIREDATE > TO_DATE ('19810601', 'YYYYMMDD');

SELECT *
FROM emp
WHERE DEPTNO IN (20, 30) AND HIREDATE > TO_DATE ('19810601', 'YYYYMMDD');

SELECT *
FROM emp
WHERE JOB = 'SALESMAN' OR HIREDATE > TO_DATE ('19810601', 'YYYYMMDD');

SELECT *
FROM emp
WHERE JOB = 'SALESMAN' OR EMPNO LIKE '78%';

 --LIKE���� ��� X
 --�������� : EMPNO�� ���ڿ����� (DESC emp.empno NUMBER)
SELECT *
FROM emp
WHERE JOB = 'SALESMAN' OR EMPNO  BETWEEN 7800 AND 7899;

--������ �켱���� (AND > OR)
SELECT *
FROM emp
WHERE ename = 'SMITH' OR ename = 'ALLEN'
AND job = 'SLAESMAN';

SELECT *
FROM emp
WHERE ename = 'SMITH' 
OR (ename = 'ALLEN' AND job = 'SLAESMAN');

--���� �̸��� SMITH�̰ų� ALLEN�̸鼭 ������ SALESMAN�� ���
SELECT *
FROM emp
WHERE (ename = 'SMITH' OR ename = 'ALLEN') AND job = 'SALESMAN';

SELECT *
FROM emp
WHERE job = 'SALESMAN' OR (empno LIKE '78%' AND HIREDATE > TO_DATE('1981-06-01', 'YYYY-MM-DD'));

--������ ����
-- 10, 5, 3, 2, 1

--�������� : 1, 2, 3, 5, 10
--�������� : 10, 5, 3, 2, 1

--�������� : ASC (ǥ�⸦ ���Ұ�� �⺻��)
--�������� : DESC ( �ݵ�� ǥ��)

/* 
    SELECT col1, col2
    FROM ���̺��
    WHERE col1 - '��'
    ORDER BY ���ı����÷�1 [ASC / DESC], ���ı����÷�2... [ASC / DESC ]
    
    */
    
    SELECT *
    FROM emp
    ORDER BY ename ASC; --���ı���� �ۼ����� ���� �� �������� ����
    
    SELECT *
    FROM emp
    ORDER BY ename DESC;
    
    --���(emp) ���̺��� ������ ������ �μ���ȣ�� �������� ����,
    --�μ���ȣ�� ���� ���� sal ��������(DESC)���� ����
    --�޿�(sal)�� �������� �̸����� ��������(ASC) �����Ѵ�
    SELECT * 
    FROM emp
    ORDER BY deptno, sal DESC, ename;
    
    --���� �÷��� ALIAS�� ǥ��
    SELECT deptno, sal, ename nm
    FROM emp
    ORDER BY nm;
    
    --��ȸ�ϴ� �÷��� ��ġ �δ����� ǥ�� ����
    SELECT deptno, sal, ename nm
    FROM emp
    ORDER BY 3; --���� �ش������� �ٲ� ���ɼ� HIGH (�÷� �߰��� �ǵ����� ���� ��� �ʷ�)
    
    --�ǽ� 1 P74
    SELECT *
    FROM emp
    ORDER BY dname;
    
    SELECT *
    FROM emp
    ORDER BY loc DESC;
  
  
    SELECT *
    FROM emp
    WHERE comm IS NOT NULL AND comm != 0 
    ORDER BY comm DESC, empno;
    
    SELECT *
    FROM emp
    WHERE mgr IS NOT NULL
    ORDER BY job, empno DESC;
    
    SELECT *
    FROM emp
    WHERE deptno IN (10,30) AND sal > 1500 -- (deptno = 10 OR deptno = 30)
    ORDER BY ename DESC;
    
    SELECT ROWNUM, empno, ename
    FROM emp;
    
    SELECT ROWNUM, empno, ename
    FROM emp
    WHERE ROWNUM = 2;  -- ROWNUM�� 1���� ������ ��ȸ�ϴ� ���� ���� (<=, <)
    
    SELECT ROWNUM, empno, ename
    FROM emp
    WHERE ROWNUM BETWEEN 1 AND 20; -- 1���� �����ϴ� ��� ����
    
    --SELECT���� ORDER BY ������ �������
    --SELECT -> ROWNUM -> ORDER BY
    SELECT ROWNUM, empno, ename
    FROM emp
    ORDER BY ename;
    
    --INLINE VIEW�� ���� ���� ���� ���� -> �ش� ����� ROWNUM�� ����
    --*�� ǥ���ϰ�, �ٸ� �÷�|ǥ������ ���� ��� *�տ� ���̺���̳�, ���̺� ��Ī�� ����
    SELECT ROWNUM, a.*
    FROM (SELECT empno, ename
    FROM emp
    ORDER BY ename) a;
    
    SELECT e.*
    FROM emp e;
    
    SELECT rn, empno, ename
    FROM emp
    WHERE ROWNUM <= 10;
    
    --ROWNUM�� 11~14�� ������
    SELECT a.*
    FROM 
    (SELECT ROWNUM rn, empno, ename
    FROM emp
    WHERE ROWNUM  BETWEEN 1 AND 14) a
    WHERE rn BETWEEN 11 AND 20;
    
    --emp���̺��� ename ���� ������ ����� 11��°��� 14��°�ุ ��ȸ�ϴ� ������ �ۼ��϶�
    SELECT a.*, empno, ename
    FROM
    (SELECT ROWNUM rn, empno, ename
    FROM emp
    WHERE ROWNUM BETWEEN 1 AND 14
    ORDER BY ename) a
    WHERE rn BETWEEN 11 AND 20;
    
    
    
    SELECT ROWNUM rn, aa.*
    FROM (
    SELECT a.*
    FROM
    (SELECT empno, ename
    FROM emp
    ORDER BY ename)a
    WHERE ROWNUM BETWEEN 1 AND 14) aa
    WHERE ROWNUM BETWEEN 11 AND 20;
    

    
    
    
    
    
    
    
    