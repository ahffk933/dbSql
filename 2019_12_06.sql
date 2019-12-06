SELECT *
FROM dept;

--dept���̺� �μ���ȣ 99, �μ��� ddit, ��ġ daejeon
INSERT INTO dept VALUES (99, 'ddit', 'daejeon');
COMMIT;

--UPDATE : ���̺� ����� �ø��� ���� ����
--UPDATE ���̺�� SET �÷���1 = �����Ϸ��� �ϴ� ��1, �÷���2 = �����Ϸ��� �ϴ� ��2...
--[WHERE row ��ȸ ����]

--�μ���ȣ�� 99���� �ΰ��� �μ����� ���IT��, ������ ���κ������� ����

--���� QUERY�� �����ϸ� WHERE���� ROW ���� ������ ���� ������
--dept���̺��� ��� �࿡ ���� �μ���, ��ġ ������ �����Ѵ�
UPDATE dept SET dname = '���IT', loc = '���κ���'
WHERE deptno = 99;

SELECT *
FROM dept;
COMMIT;

--������Ʈ ���� ������Ʈ �Ϸ��� �ϴ� ���̺��� WHERE���� ����� �������� SELECT�� �Ͽ� ������Ʈ ��� ROW�� Ȯ���غ���
SELECT *
FROM dept
WHERE deptno = 99;

--SUBQUERY�� �̿��� UPDATE
--emp���̺� �ű� ������ �Է�
--�����ȣ 9999, ����̸� brown, ���� : null
INSERT INTO emp (empno, ename) VALUES (9999, 'brown');
SELECT *
FROM emp
WHERE empno = 9999;
COMMIT;

--�����ȣ�� 9999�� ����� �Ҽ� �μ��� �������� SMITH����� �μ�, ������ ������Ʈ
UPDATE emp SET deptno = (SELECT deptno FROM emp WHERE ename='SMITH'), 
                job = (SELECT job FROM emp WHERE ename='SMITH') 
WHERE empno = 9999;

SELECT *
FROM emp
WHERE empno=9999;

--DELETE : ���ǿ� �ش��ϴ� ROW�� ����
--�÷��� ���� ���� ? (NULL)������ �����Ϸ��� -> UPDATE

--DELETE ���̺��
--[WHERE ����]

--UPDATE QUERY�� ���������� DELETE QUERY ���� ������ �ش� ���̺��� WHERE ������ �����ϰ� �Ͽ�
--SELECT�� ����, ������ ROW�� ���� Ȯ���ض�

--emp���̺� �����ϴ� �����ȣ 9999�� ����� ����
DELETE emp
WHERE empno =9999;

SELECT *
FROM emp;
WHERE empno=9999;
COMMIT;

--�Ŵ����� 7698�� ��� ����� ����
--���������� ���
DELETE emp
WHERE empno IN (SELECT empno
                FROM emp
                WHERE mgr = 7698);
DELETE emp WHERE mgr = 7698; --���� ������ �����

SELECT *
FROM emp
WHERE mgr = 7698;  --Ȯ��~


--SERIALAZABLE READ
--Ʈ������� ������ ��ȸ ������ Ʈ����� ���� �������� ��������
--�� ���� Ʈ����ǿ��� �����͸� �Ž� �Է�, ����, ���� �� COMMIT�� �ϴ���
--����Ʈ����ǿ����� �ش� �����͸� �����ʴ´�

--Ʈ����� ���� ����(serializable read)
SET TRANSACTION isolation LEVEL SERIALIZABLE;
ROLLBACK;

--dept table�� synonym�� �����Ͽ� d


--DDL : TABLE ����
--CREATE TABEL [����ڸ�.]���̺��(
--    �÷���1 �÷�Ÿ��1,
--    �÷���1 �÷�Ÿ��2, ....
--    �÷���N �÷�Ÿ��N);
--ranger_no NUMBER          : ������ ��ȣ
--ranger_nm VARCHAR2(50)    : ������ �̸�
--reg_dt DATE               : ������ �������
--���̺� ���� DDL : Data Defination Language(������ ���Ǿ�
--DDL rollback�� ����(�ڵ�Ŀ�� �ǹǷ� rollback�� �� �� ����)
CREATE TABLE ranger(
    ranger_no NUMBER,
    ranger_nm VARCHAR2(50),
    reg_dt DATE );
    
DESC renger;

--DDL ������ ROLLBACKó�� �Ұ�!!!
ROLLBACK;

SELECT *
FROM user_tables
WHERE table_name = 'RANGER';
--WHERE table_name = 'ranger';
--����Ŭ������ ��ü ������ �ҹ��ڷ� �����ϴ��� ���������δ� �빮�ڷ� ������

INSERT INTO ranger VALUES(1, 'brown', sysdate);
--������ ��ȸ Ȯ������
SELECT *
FROM ranger;

--DML���� DDL�� �ٸ��� ROLLBACK�� �����ϴ�
ROLLBACK;

--ROLLBACK�߱� ������ DML������ ��ҵ�
SELECT *
FROM ranger;

--DATE Ÿ�Կ��� �ʵ� �����ϱ�
--EXTRACT (�ʵ�� FROM �÷�/expression)
SELECT TO_CHAR(SYSDATE, 'YYYY') yyyy,
       TO_CHAR(SYSDATE , 'mm') mm,
       EXTRACT(year FROM SYSDATE) ex_yyyy,
       EXTRACT(month FROM SYSDATE) ex_mm
FROM dual;

--DDL Table- PRIMARY KEY
--���̺� ������ �÷� ���� �������� ����
CREATE TABLE dept_test(
    deptno NUMBER(2) PRIMARY KEY,
    dname VARCHAR2(14),
    loc VARCHAR2(13));
    
DROP TABLE dept_teest;

--dept_test table�� deptno �÷���  PRIMARY KEY ���������� �ֱ� ������
--deptno�� ������ �����͸� �Է��ϰų� ���� �� �� ����
--���� ������ �̹Ƿ� �Է¼���
INSERT INTO dept_test VALUES(99, 'ddit', 'daejeon');

--dept_Test �����Ϳ� deptno�� 99���� �����Ͱ� �����Ƿ�
--primary  key �������ǿ� ���� �Էµ� �� ����
--ORA-00001: unique constraint (GOO.SYS_C007100) violated �������� ����
--����Ǵ� �������Ǹ� SYS-C007100�������� ����
--SYS-C007100 ���������� � ���� �������� �Ǵ��ϱ� ����Ƿ� 
--�������ǿ� �̸��� �ڵ� �꿡 ���� �ٿ��ִ� ���� ���������� ���ϴ�
INSERT INTO dept_test VALUES(99, '���', '����');  


--���̺� ���� �� �������� �̸��� �߰��Ͽ� �����
--primary key : pk_���̺��
DROP TABLE dept_test;

CREATE TABLE dept_test(
    deptno NUMBER(2) CONSTRAINT pk_dept_test PRIMARY KEY,
    dname VARCHAR2(14),
    loc VARCHAR2(13));
    
--INSERT ���� ����
INSERT INTO dept_test VALUES(99, 'ddit', 'daejeon');
INSERT INTO dept_test VALUES(99, '���', '����'); 
