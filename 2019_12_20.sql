--hash join
SELECT *
FROM dept, emp  --����� ���� �ֵ� ���� ���� ����Ŭ��
WHERE dept.deptno = emp.deptno;
--dept���� �д� ����
--join�÷��� hash�Լ��� ������ �ش� �ؽ� �Լ��� �ش��ϴ� bucket�� �����͸� �ִ´�
--10 -> ccc1122 (hashvalue)
--�������� hash���� ���´ٴ� ������ ����
--���� equal'='������ �� ���� ����

--emp���̺� ���� ���� ������ �����ϼ� ����
--10 -> ccc1122 (hashvalue)


SELECT COUNT(*)  --emp table�� ���� �� ��ĵ�ϱ� ������ ����� �� �� ���� (sort merge)
FROM emp;



--�����ȣ, ����̸�, �μ���ȣ, �޿�, �μ����� ��ü �޿���
SELECT empno, ename, deptno, sal,
       SUM(sal) OVER (ORDER BY sal 
       ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) c_sum, --����ó������ ���� ������� �޿� ��
       
       SUM(sal) OVER( ORDER BY sal
       ROWS BETWEEN 1 PRECEDING AND CURRENT ROW) c_sum2  --�ٷ� ���� ���̶� ���� ������� �޿� ��
FROM emp
ORDER BY sal;

--TEST ana7
SELECT empno, ename, deptno, sal,
       SUM(sal) OVER (PARTITION BY DEPTNO ORDER BY sal ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) C_SUM  
FROM emp;


--ROWS vs RANGE �� ���� Ȯ��
SELECT empno, ename, deptno, sal,
        SUM(sal) OVER (ORDER BY sal ROWS UNBOUNDED PRECEDING) row_sum,    --���������� �� ��Ȯ
        SUM(sal) OVER (ORDER BY sal RANGE UNBOUNDED PRECEDING) range_sum,   --�÷����� ������ ���� ����� �ع���
        SUM(sal) OVER (ORDER BY sal) c_sum
FROM emp;


--PL/SQL
--PL/SQL�⺻ ����
--DECLARE : �����, ������ �����ϴ� �κ�
--BEGIN : PL/SQL�� ������ ���� �κ�
--EXCEPTION : ����ó����

--DBMS_OUTPUT.PUT_LINE�Լ��� ����ϴ� ����� ȭ�鿡 �����ֵ��� Ȱ��ȭ
SET SERVEROUTPUT ON; 
DECLARE --�����
    --java : Ÿ�� ������;
    --pl/sql : ������ Ÿ��;
   /* v_dname VARCHAR2(14);
    v_loc VARCHAR2(13); */
    --���̺� �÷��� ���Ǹ� �����Ͽ� ������ Ÿ���� �����Ѵ�
    v_dname dept.dname %TYPE;
    v_loc dept.loc %TYPE;
BEGIN
    --DEPT TABLE���� 10�� �μ��� �μ� �̸�, LOC������ ��ȸ
    SELECT dname, loc
    INTO v_dname, v_loc 
    FROM dept
    WHERE deptno = 10;
    --(java)
    --string a = "t";
    --String = "c";
    --sysout.out.println(a + b);
    DBMS_OUTPUT.PUT_LINE(v_dname || v_loc); 
    
END;
/  
-- / : PL/SQL����� ����

DESC dept;



--10�� �μ��� �μ��̸�, ��ġ������ ��ȸ�ؼ� ������ ���
--������ DBMS_OUTPUT.PUT_LINE�Լ��� �̿��Ͽ� console�� ���
CREATE OR REPLACE PROCEDURE printdept IS
--�����(�ɼ�)
    dname dept.dname %TYPE;
    loc dept.loc %TYPE;
    
--�����
BEGIN
    SELECT dname, loc
    INTO dname, loc   --into�� ���
    FROM dept
    WHERE deptno =10;
    
    DBMS_OUTPUT.PUT_LINE(dname || ' ' || loc);
--����ó����(�ɼ�)
END;
/

exec printdept;




CREATE OR REPLACE PROCEDURE printdept 
--�Ķ���͸� IN/OUT Ÿ��
--p_�Ķ�����̸�
( p_deptno IN dept.deptno %TYPE )
IS
--�����(�ɼ�)
    dname dept.dname %TYPE;
    loc dept.loc %TYPE;
    
--�����
BEGIN
    SELECT dname, loc
    INTO dname, loc   --into�� ���
    FROM dept
    WHERE deptno = p_deptno;
    
    DBMS_OUTPUT.PUT_LINE(dname || ' ' || loc);
--����ó����(�ɼ�)
END;
/

exec printdept(30);


CREATE OR REPLACE PROCEDURE printemp
(p_empno IN emp.empno %TYPE)
IS
    ename emp.ename%TYPE;
    dname dept.dname%TYPE;
    
BEGIN
    SELECT ename, dname
    INTO ename, dname
    FROM emp, dept
    WHERE emp.empno = p_empno
    AND dept.deptno = emp.deptno;
        
    DBMS_OUTPUT.PUT_LINE(ename || ' ' || dname);
END;
/

exec printemp(7369);

SELECT *
FROM emp;

--test pro_2
CREATE OR REPLACE PROCEDURE registdept_test
(p_deptno IN dept_test.deptno%TYPE,  
 p_dname IN dept_test.dname%TYPE,
 p_loc IN dept_test.loc%TYPE)
IS 
    deptno dept_test.deptno%TYPE;
    dname dept_test.dname%TYPE;
    loc dept_test.loc%TYPE;
BEGIN 
    INSERT INTO dept_test VALUES (99, 'DDIT', 'Daejeon');
    
    DBMS_OUTPUT.PUT_LINE(deptno || ' ' || dname || ' ' || loc);
    
END;
/

exec registdept_test(99, 'ddit', 'daejeon');

SELECT *
FROM dept_test;