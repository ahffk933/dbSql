--��Ī : ���̺�, �÷��� �ٸ� �̸����� ��Ī
-- [AS] ��Ī��
-- SELECT empno [AS] eno
-- FROM emp e

-- SYNONYM (���Ǿ�)
--����Ŭ ��ü�� �ٸ��̸����� �θ� �� �ֵ��� �ϴ� ��
-- emp ���̺��� e��� �ϴ� synonym(���Ǿ�)�� �����ϸ�
--SELECT *
--FROM e;  <- �̷��� SQL�ۼ��� �� �ִ�
SELECT *
FROM employees;


--goo������ SYNONYM ���� ������ �ο� (SYSTEM��������)
GRANT CREATE SYNONYM TO GOO;

--emp���̺��� ����Ͽ� synonym e�� ����
--CREATE SYNONYM �ó�� �̸� FOR ����Ŭ��ü;
CREATE SYNONYM e FOR emp;

--emp��� ���̺� �� ��ſ� e��� �ϴ� �ó���� ����Ͽ� ������ �ۼ��� �� �ֵ�
SELECT *
FROM emp;

SELECT *
FROM e;

--GOO������ fastfood���̺��� hr���������� �� �� �ֵ��� ���̺� ��ȸ ������ �ο�
GRANT SELECT ON fastfood TO hr;

SELECT *
FROM DICTIONARY;

--������ SQL�� ���信 ������ �Ʒ� SQL���� �ٸ���
SELECT /* 201911_205 */ * FROM emp;
SELECT /* 201911_205 */ * FROM EMP;
SELECt /* 201911_205 */ * FROM EMP;

SELECT /* 201911_205 */ * FROM EMP WHERE empno=7369;
SELECT /* 201911_205 */ * FROM EMP WHERE empno=7499;
SELECT /* 201911_205 */ * FROM EMP WHERE empno=:empno;

SELECT *
FROM V$SQL;



--multiple insert
DROP TABLE emp_test;

--emp ���̺��� empno, ename �÷����� emp_test, emp_test2���̺� ���� (CTAS, �����͵� ����)
CREATE TABLE emp_test AS
SELECT empno, ename
FROM emp;

CREATE TABLE emp_test2 AS
SELECT empno, ename
FROM emp;

SELECT * 
FROM emp_test;

SELECT * 
FROM emp_test2;

--unconditional insert
--���� ���̺� �����͸� ���� �Է�
--'brown', 'cony'
INSERT ALL
    INTO emp_test
    INTO emp_test2
SELECT 9999, 'brown' FROM DUAL UNION ALL
SELECT 9998, 'cony' FROM DUAL;

SELECT *
FROM emp_test
WHERE empno > 9000;

SELECT *
FROM emp_test2
WHERE empno > 9000;

ROLLBACK;
--���̺� �� �ԷµǴ� �������� �÷��� ���� ����
INSERT ALL
    INTO emp_test (empno, ename) VALUES (eno, enm)
    INTO emp_test2 (empno) VALUES (eno)
SELECT 9999 eno, 'brown' enm FROM DUAL UNION ALL
SELECT 9998, 'cony' FROM DUAL;

SELECT *
FROM emp_test
WHERE empno > 9000

UNION ALL

SELECT *
FROM emp_test2
WHERE empno > 9000;

--CONDITIONAL INSERT
--���ǿ� ���� ���̺� �����͸� �Է�
ROLLBACK;

/*
    CASE
        WHEN ���� THEN ----  //IF
        WHEN ���� THEN ----  //ELSE IF
        ELSE ----           //ELSE
*/
INSERT ALL
    WHEN eno > 9000 THEN
        INTO emp_test (empno, ename) VALUES (eno, enm)
    WHEN eno > 9500 THEN
        INTO emp_test (empno, ename) VALUES (eno, enm)
    ELSE
        INTO emp_test2 (empno) VALUES (eno)
SELECT 9999 eno, 'brown' enm FROM DUAL UNION ALL
SELECT 8998, 'cony' FROM DUAL;

SELECT *
FROM emp_test
WHERE empno > 9000 

UNION ALL

SELECT *
FROM emp_test2
WHERE empno > 8000;

ROLLBACK;

INSERT FIRST
    WHEN eno > 9000 THEN
        INTO emp_test (empno, ename) VALUES (eno, enm)
    WHEN eno > 9500 THEN
        INTO emp_test (empno, ename) VALUES (eno, enm)
    ELSE
        INTO emp_test2 (empno) VALUES (eno)
SELECT 9999 eno, 'brown' enm FROM DUAL UNION ALL
SELECT 8998, 'cony' FROM DUAL;


        