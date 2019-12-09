--UNIQUE :�ش� �÷��� ������ ���� �ߺ��� �� ����
--eg) : emp table�� empno(���)
--     dept table�� emptno(�μ���ȣ)
--      �ش� �÷��� null���� �� �� ����

--NOT NULL : ������ �Է� �� �ش� �÷��� ���� �ݵ�� ���;� �Ѵ�

--�÷������� PRIMARY KEY ���� ����
--����Ŭ�� �������� �̸��� ���Ƿ� ���� (SYS-C000701)
CREATE TABLE dept_test(
        deptno NUMBER(2) PRIMARY KEY,

--����Ŭ ���������� �Ϲ��� ���Ƿ� ���
--PRIMARY KEY : pk_���̺��
CREATE TABLE dept_test(
        deptno NUMBER(2) COMSTRAINT pk_dept_test PRIMARY KEY;
        
        
--PAIWISE : ���� ����
--����� PRIMARY KEY ���������� ��� �ϳ��� �÷��� ���������� ����
--���� �÷��� �������� PRIMARY KEY �������� ������ �� �ֵ�
--�ش� ����� ���� �ΰ��� ���� ó�� �÷� ���������� ���� �� �� ����
--> TABLE LEVEL�������� ����

--������ ������ dept_test ���̺� ����(drop)
DROP TABLE dept_test;

--�÷������� �ƴ�, ���̺� ������ �������� ����
CREATE TABLE dept_test(
    deptno NUMBER(2),
    dname VARCHAR2(14),
    loc VARCHAR2(13)), --������ �÷� ���� �� �޸� ������ �ʱ�!!
    
  --deptno, dname�÷��� ���� �� ������(�ߺ���) �����ͷ� �ν�  
    CONSTRAINT pk_dept_test PRIMARY KEY (deptno, dname)
);

--�μ���ȣ, �μ��̸� ���������� �ߺ� �����͸� ����
--�Ʒ� �ΰ��� insert������ �μ���ȣ�� ������,
--�μ����� �ٸ��Ƿ� ���� �ٸ� �����ͷ� �ν� -> INSERT����
INSERT INTO dept_test VALUES(99, 'ddit', 'daejeon');
INSERT INTO dept_test VALUES(99, '���', '����');

SELECT *
FROM dept_test;

--�ι�° INSERT������ Ű���� �ߺ��ǹǷ� ����
INSERT INTO dept_test VALUES(99, '���', 'û��');

--NOT NULL ��������
--�ش��÷��� NULL���� ������ ���� ������ �� ���
--�����÷����� �Ÿ��� �ִ�

DROP TABLE dept_test;

--�÷������� �ƴ�, ���̺� ������ �������� ����
--dname �÷��� null���� ������ ���ϵ��� NOT NULL �������� ����
CREATE TABLE dept_test(
    deptno NUMBER(2) PRIMARY KEY,
    dname VARCHAR2(14) NOT NULL,
    loc VARCHAR2(13), --������ �÷� ���� �� �޸� ������ �ʱ�!!
    
  --deptno, dname�÷��� ���� �� ������(�ߺ���) �����ͷ� �ν�  
    CONSTRAINT pk_dept_test PRIMARY KEY (deptno, dname)
);

--deptno�÷��� primary key ���࿡ �ɸ��� �ʰ�
--loc�÷��� nullable�̱� ������ null���� �Էµ� �� �ִ�
INSERT INTO dept_test VALUES(99, 'ddit', 'null');

--deptno �÷��� primary key ���࿡ �ɸ��� �ʰ�(�ߺ��� ���� �ƴϴϱ�)
--dname�÷��� NOT NULL ���������� 
INSERT INTO dept_test VALUES(98, NULL, '����');


DROP TABLE dept_test;

CREATE TABLE dept_test(
    deptno NUMBER(2) PRIMARY KEY,
    --deptno NUMBER(2) CONSTRAINT pk_dept_test PRIMARY KEY,
    --dname BARCHAR2(14) NOT NULL,
    dname VARCHAR2(14) CONSTRAINT NN_dname NOT NULL,
    loc VARCHAR2(13)
);



DROP TABLE dept_test;

CREATE TABLE dept_test(
    deptno NUMBER(2) PRIMARY KEY,
    dname VARCHAR2(14),
    loc VARCHAR2(13),
    
    --CONSTRAINT pk_dept_test PRIMARY KEY (deptono, dname)
    --CONSTRAINT NN_dname NOT NULL (dname) --������ �ʴ´�
);


--1. �÷�����
--2.�÷����� �������� �̸� ���̱�
--3. ���̺� ����
--[4. ���̺� ���� �� �������� ����]

--UNIQUE ��������
--�ش� �÷��� ���� �ߺ��Ǵ� ���� ����
--�� null���� ���
--GLOBAL solution�� ��� ������ ���� ���� ������ �ٸ��� ������
--pk���ຸ�ٴ� UNIQUE������ ����ϴ� ���̸�, 
--������ ���� ������ APPLICATION LEVEL���� üũ�ϵ��� �����ϴ� ������ �ִ�

--�÷� ���� unique���� ����
CREATE TABLE dept_test(
    deptno NUMBER(2) PRIMARY KEY,
    dname VARCHAR2(14) UNIQUE,
    loc VARCHAR2(13)
);

--�ΰ��� insert������ ���� dname�� ���� ���� �Է��ϱ� ������
--dname�÷��� ����� UNIQUE���࿡ ���� �ι�° ������ ���������� ����� �� ����
INSERT INTO dept_test VALUES (99, 'ddit', 'daejeon');
INSERT INTO dept_test VALUES (98, 'ddit', '����');


DROP TABLE dept_test;

CREATE TABLE dept_test(
    deptno NUMBER(2) PRIMARY KEY,
    dname VARCHAR2(14),
    loc VARCHAR2(13),
    
    --CONSTRAINT pk_dept_test PRIMARY KEY (deptono, dname)
    --CONSTRAINT NN_dname NOT NULL (dname) --������ �ʴ´�
);

DROP TABLE dept_test;

--�÷� ���� unique���� ����
CREATE TABLE dept_test(
    deptno NUMBER(2) PRIMARY KEY,
    dname VARCHAR2(14) CONSTRAINT IDX_U_dept_test_01 UNIQUE,
    loc VARCHAR2(13)
);

--�ΰ��� insert������ ���� dname�� ���� ���� �Է��ϱ� ������
--dname�÷��� ����� UNIQUE���࿡ ���� �ι�° ������ ���������� ����� �� ����
INSERT INTO dept_test VALUES (99, 'ddit', 'daejeon');
INSERT INTO dept_test VALUES (98, 'ddit', '����');


DROP TABLE dept_test;

--���̺� ���� unique���� ����
CREATE TABLE dept_test(
    deptno NUMBER(2) PRIMARY KEY,
    dname VARCHAR2(14),
    loc VARCHAR2(13),
    
    CONSTRAINT IDX_U_dept_test_01 UNIQUE (dname)
);

--�ΰ��� insert������ ���� dname�� ���� ���� �Է��ϱ� ������
--dname�÷��� ����� UNIQUE���࿡ ���� �ι�° ������ ���������� ����� �� ����
INSERT INTO dept_test VALUES (99, 'ddit', 'daejeon');
INSERT INTO dept_test VALUES (98, 'ddit', '����');



--FOREIGN KEY ��������
--�ٸ� ���̺� �����ϴ� ���� �Է� �� �� �ֵ��� ����

--emp_test.deptno -> dept_test.deptno �÷��� �����ϵ���
--FOREIGN KEY �������� ����

--dept_test ���̺� ����(drop)
DROP TABLE dept_test;

--dept_test���̺� ���� (deptno �÷� PRIMARY KEY ����)
--DEPT ���̺�� �÷��̸�, Ÿ�� �����ϰ� ����
CREATE TABLE dept_test(
    deptno NUMBER(2,0) PRIMARY KEY,
    dname VARCHAR2(14),
    loc VARCHAR2(13)
);
INSERT INTO dept_test VALUES(99, 'ddit', 'daejeon');
COMMIT;

DESC emp;
--empno, ename, deptno : emp_test
--empno PRIMARY KEY
--deptno dept_test.deptno FOREIGN KEY

--�÷����� FOREIGN KEY
CREATE TABLE emp_test (
    empno NUMBER(4) PRIMARY KEY,
    ename VARCHAR2(10),
    deptno NUMBER(2) REFERENCES dept_test (deptno) );
    
--dept_test table�� �����ϴ� deptno�� ���� �Է�
INSERT INTO emp_test VALUES (9999, 'brown', 99);

--dept_test table�� �������� �ʴ� deptno�� ���� �Է�
INSERT INTO emp_test VALUES (9998, 'sally', 98); --error(violated - parent key not found)


--emp_test ����
DROP TABLE emp_test;

--�÷����� FOREIGN KEY(�������� �� �߰�)
CREATE TABLE emp_test (
    empno NUMBER(4) PRIMARY KEY,
    ename VARCHAR2(10),
    deptno NUMBER(2),
    
    CONSTRAINT FK_dept_test FOREIGN KEY (deptno) 
    REFERENCES dept_Test (deptno) );
    
--dept_test table�� �����ϴ� deptno�� ���� �Է�
INSERT INTO emp_test VALUES (9999, 'brown', 99);

--dept_test table�� �������� �ʴ� deptno�� ���� �Է�
INSERT INTO emp_test VALUES (9998, 'sally', 98);

SELECT *
FROM emp_test;

DELETE dept_test
WHERE deptno=99; --emp table�� ���������� �������� ��������

--�μ������� �������
--��������ϴ� �μ���ȣ�� �����ϴ� ���������� ���� �Ǵ� deptono�÷��� NULLó��
--EMP -> DEPT ������� default�� �� ����~~


--���� ���̺� ����(DROP)
DROP TABLE emp_test;
--FOREIGN KEY OPTION -SET DELETE CASCADE
CREATE TABLE emp_test (
    empno NUMBER(4) PRIMARY KEY,
    ename VARCHAR2(10),
    deptno NUMBER(2),
    
    CONSTRAINT FK_dept_test FOREIGN KEY (deptno) 
    REFERENCES dept_Test (deptno) ON DELETE CASCADE );
    
--dept_test table�� �����ϴ� deptno�� ���� �Է�
INSERT INTO emp_test VALUES (9999, 'brown', 99);
COMMIT;
--������ �Է� Ȯ��
SELECT *
FROM emp_test;

--ON DELETE CASCADE OPTION�� ���� DEPT �����͸� ������ ���
--�ش� �����͸� �����ϰ� �ִ� EMP TABLE�� ��� �����͵� �����ȴ�
DELETE dept_test
WHERE deptno=99;  --���農
ROLLBACK;



--���� ���̺� ����(DROP)
DROP TABLE emp_test;

--FOREIGN KEY OPTION -SET DELETE SET NULL

CREATE TABLE emp_test (
    empno NUMBER(4) PRIMARY KEY,
    ename VARCHAR2(10),
    deptno NUMBER(2),
    
    CONSTRAINT FK_dept_test FOREIGN KEY (deptno) 
    REFERENCES dept_Test (deptno) ON DELETE SET NULL );
    
--dept_test table�� �����ϴ� deptno�� ���� �Է�
INSERT INTO emp_test VALUES (9999, 'brown', 99);
COMMIT;
--������ �Է� Ȯ��
SELECT *
FROM emp_test;

--ON DELETE SET NULL OPTION�� ���� DEPT �����͸� ������ ���
--�ش� �����͸� �����ϰ� �ִ� EMP TABLE�� DETPNO �÷��� NULL�� ����
DELETE dept_test
WHERE deptno=99; 
ROLLBACK;



--CHECK ��������
--�÷��� ���� ���� ������ ��
--ex) �޿��÷����� ���� 0���� ū ���� ������ üũ
--    ���� �÷����� ��/�� Ȥ�� M/F���� ������ ����

--emp_test table drop(����)
DROP TABLE emp_test;

--emp_test ���̺� �÷�
--empno NUMBER(4)
--ename VARCHAR
--sal NUMBER(7,2)
--EMP_gb VARCHAR2(2) --���� ���� 01-������, 02-����
CREATE TABLE emp_test(
    empno NUMBER(4) PRIMARY KEY,
    ename VARCHAR2(10),
    sal NUMBER(7, 2) CHECK (sal > 0),
    emp_gb VARCHAR2(2) CHECK (emp_gb IN ('01', '02') ) );
    
--emp_test ������ �Է�
--sal column �������� (sal > 0)�� ���ؼ� ���� ���� �Է� �� �� ����
INSERT INTO emp_test VALUES (9999, 'brown', -1, '01');

--check �������� ������� �����Ƿ� ���� �Է� (sal, emp_gb)
INSERT INTO emp_test VALUES (9999, 'brown', 1000, '01');

--emp_gb check���ǿ� ���� (emp_gb IN ('01', '02') )
INSERT INTO emp_test VALUES (9998, 'sally', 1000, '03');

--check �������� ���� ���� �ʵ��� ���� �Է� (sal, emp_gb)
INSERT INTO emp_test VALUES (9998, 'sally', 1000, '02');

--���̺� ����
DROP TABLE emp_test;

--CHECK �������� �̸� ����
CREATE TABLE emp_test(
    empno NUMBER(4) PRIMARY KEY,
    --empno NUMBER(4) CONSTRAINT �������Ǹ� PRIMARY KEY,
    
    ename VARCHAR2(10),
    --sal NUMBER(7, 2) CHECK (sal > 0),
    sal NUMBER(7, 2) CHECK (sal > 0),
    
    --emp_gb VARCHAR(2) CHECK (emp_gb IN ('01', '02') )
    emp_gb VARCHAR2(2) CONSTRAINT C_EMP_GB
                                CHECK (emp_gb IN ('01', '02') ) 
    );
                            


--���̺� ����
DROP TABLE emp_test;

--table level CHECK �������� �̸� ����
CREATE TABLE emp_test(
    empno NUMBER(4) PRIMARY KEY,
    ename VARCHAR2(10),
    sal NUMBER(7, 2),
    emp_gb VARCHAR2(2),
    
    CONSTRAINT nn_ename CHECK (ename IS NOT NULL),
    CONSTRAINT C_SAL CHECK (sal > 0),
    CONSTRAINT C_EMP_GB CHECK (emp_gb IN ('01', '02') ) 
    );
    
    
--���̺� ���� : CREATE TABLE ���̺�� (
--                  �÷� �÷�Ÿ�� ....);

--���� ���̺��� Ȱ���ؼ� ���̺� �����ϱ�
-- Reate Table AS : CTAS (��Ÿ��)
--          CREATE TABLE ���̺�� [(�÷�1, �÷�2, �÷�3...)] AS
--          SELECT col1, col2, col3...
--          FROM �ٸ� ���̺��
--          WHERE ����

--emp_test ���̺� ����(drop)
DROP TABLE emp_test;

--emp table�� �����͸� �����ؼ� emp_test ���̺��� ����
CREATE TABLE emp_test AS
    SELECT *
    FROM emp;
    
    
SELECT *
FROM emp_test
MINUS
SELECT *
FROM emp;
    

SELECT *
FROM emp_test
INTERSECT
SELECT *
FROM emp;

emp_emp_test =������
emp_emp_test =������


--emp_test ���̺� ����(drop)
DROP TABLE emp_test;

--emp table�� �����͸� �����ؼ� emp_test ���̺� �÷����� �����Ͽ� ����
CREATE TABLE emp_test (c1, c2, c3, c4, c5, c6, c7, c8) AS
    SELECT *
    FROM emp;
    
SELECT *
FROM emp_test;

--emp_test ���̺� ����
DROP TABLE emp_test;

--�����ʹ� �����ϰ� ���̺��� ��ü(�÷�����)�� �����Ͽ� ���̺� ����
CREATE TABLE emp_test AS
    SELECT *
    FROM emp
    WHERE 1=2;
SELECT *
FROM emp_test;

CREATE TABLE emp_20191209 AS
SELECT *
FROM emp;

--emp_test ���̺� ����
DROP TABLE emp_test;

--empno, ename, deptno �÷����� emp_test����
CREATE TABLE emp_test AS
    SELECT empno, ename, deptno
    FROM emp
    WHERE 1=2;
    
SELECT *
FROM emp_test;

--emp_test ���̺� �ű� �÷� �߰�
--HP CARCHAR2(20) DEFAULT '010'
--ALTER TABLE ���̺�� ADD (�÷��� �÷� Ÿ�� [(default value)];
ALTER TABLE emp_test ADD (hp VARCHAR2(20) DEFAULT '010');

--���� �÷� ����
--ALTER TABLE ���̺�� MODIFY (�÷� �÷� Ÿ�� [default calue]);
--hp �÷��� Ÿ���� VARCHAR2(20) -> VARCHAR2(30)
ALTER TABLE emp_test MODIFY (hp VARCHAR2(30));

--���� emp_test���̺� �����Ͱ� ���� ������ �÷� Ÿ���� �����ϴ� ���� ����
--hp �÷��� Ÿ���� VARCHAR2(30) -> NUMBER
ALTER TABLE emp_test MODIFY (hp NUMBER);
DESC emp_test;

--�÷��� ����
--�ش��÷��� PK, UNIQUE, NOT NULL, CHECK���� ���� �� ����� �÷��� ���ؼ��� �ڵ��� ������ �ȴ�
--hp �÷� hp_n
--ALTER TABLE ���̺�� RENAME COLUMN ���� �÷��� TO �����÷���;
ALTER TABLE emp_test RENAME COLUMN hp TO hp_n;
DESC emp_test;

--�÷� ����
--ALTER TABLE ���̺�� DROP �÷�;
--ALTER TABLE ���̺�� DROP COLUMN �÷�;
ALTER TABLE emp_test DROP (hp_n);
ALTER TABLE emp_test DROP COLUMN hp;


--���� ���� �߰�
--ALTER TABLE ���̺�� ADD   --���̺� ���� �������� ��ũ��Ʈ
--emp_test ���̺��� empno�÷��� PK�������� �߰�
ALTER TABLE emp_test ADD CONSTRAINT pk_emp_test 
                                PRIMARY KEY(empno);
                                
--���� ���� ����
--ALTER TABLE ���̺�� DROP CONSTRAINT �������� �̸�;
--emp_test ���̺��� PRIMARY KEY ���������� pk_emp_test���� ����
ALTER TABLE emp_test DROP CONSTRAINT pk_emp_test;


--���̺� �÷�, Ÿ�� ������ ���������γ��� ����
--���̺��� �÷� ������ �����ϴ� ���� �Ұ����ϴ�
--empno, ename, job -> empno, job, ename