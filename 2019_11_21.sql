-- col IN (value1, value2...)
-- col�� ���� IN ������ �ȿ� ������ ���߿� ���Ե� �� ������ ����

--RDBMS - ���հ���
--1. ���տ��� ������ ����
-- {1, 5, 7}, {1, 5, 7}
--2. ���տ��� �ߺ��� ����
-- {1, 1, 5, 7}, {5, 1, 7}
SELECT *
FROM emp
WHERE deptno IN (10, 20); --emp ���̺� ������ �Ҽ� �μ��� 10�� �̰ų� 20���� ���� ������ ��ȸ

--�̰ų� -> OR(�Ǵ�)
--�̰� -> AND(�׸���)

-- IN -> OR
-- BETWEEN AND -> AND + �����

SELECT *
FROM emp
WHERE deptno = 10 OR deptno = 20;

SELECT userid AS "���̵�", usernm AS "�̸�", ALIAS AS "����" 
FROM users
WHERE userid IN ('brown', 'cony', 'sally');

--where3
SELECT userid ���̵�, usernm �̸�, alias ����
FROM users
WHERE userid IN ('brown', 'cony', 'sally');

-- LIKE ������ : ���ڿ� ��Ī ����
-- % : ���� ���� (Ȥ�� ���ڰ� ���� ���� �ִ�)
-- _ : �ϳ��� ����

--EMP ���̺��� ����̸�(ename)�� s�� �����ϴ� ��� ������ ��ȸ
SELECT *
FROM emp
WHERE ename LIKE 'S%';
--SMITH
--SCOTT
--ù���ڴ� S�� �����ϰ� 4��° ������ T
--�ι�°, ������, �ټ���° ���ڴ� � ���ڵ� �� �� �ִ�

SELECT *
FROM emp
WHERE ename LIKE 'S__T_';
WHERE ename LIKE 'S%T_'; -- 'STE', 'STTTT', 'STESTS'

SELECT MEM_ID, MEM_NAME
FROM member
WHERE MEM_NAME LIKE '��%';

--WHERE5
--member ���̺��� �̸��� [��]���ڰ� ���ԵǴ� ȸ�� ���� ��ȸ
SELECT MEM_ID, MEM_NAME
FROM member
WHERE MEM_NAME LIKE '��%';

--�÷� ���� NULL�� ������ ã��
--emp ���̺� ���� MGR �÷��� NULL �����Ͱ� ����

SELECT *
FROM emp
WHERE MGR = 7698;  --MGR �÷� ���� 7698�� ��� ������ȸ
WHERE MGR = IS NULL;  --NULL�� Ȯ�ο��� IS NULL �����ڸ� ���
WHERE MGR = NULL;  --MGR �÷� ���� NULL�� ��� ������ȸ



SELECT *
FROM emp
WHERE comm IS NOT NULL;

--AND : ������ ���ÿ� ����
--OR : ������ �Ѱ��� �����ϸ� ����

--emp ���̺��� mgr�� 7698 �̰ų�(OR), �޿��� 1000���� ū ���
SELECT *
FROM emp
WHERE mgr=7698
AND sal > 1000;

--emp���̺��� ������ ����� 7698, 7839�� �ƴ� ���� ������ȸ
SELECT *
FROM emp
WHERE mgr NOT IN (7698, 7839)
OR mgr IS NOT NULL;

SELECT *
FROM emp
WHERE JOB = 'SALESMAN'
AND HIREDATE >= TO_DATE('1981/06/01', 'YYYY/MM/DD');


SELECT *
FROM emp
WHERE DEPTNO <> 10  AND HIREDATE >= TO_DATE('19810601', 'YYYYMMDD');
-- <>, != :�ƴϴ�
SELECT *
FROM emp
WHERE DEPNO NOT IN 10 AND HIREDATE >= TO_DATE('19810601, 'YYYYMMDD');


