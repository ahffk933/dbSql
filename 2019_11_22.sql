
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
    
    
   --���̺���  ename�÷� �������� �������� ���������� 11~14��° ���� �����͸� ��ȸ�ϴ� sql�� �ۼ��϶� 
    SELECT ROWNUM rn, empno, ename
    FROM (
    SELECT rn, a*
    FROM 
        (SELECT empno, ename
         FROM emp
         ORDER BY ename)a)
    WHERE rn BETWEEN 11 AND 20;
    
    SELECT empno, ename
    FROM emp
    WHERE ROWNM  BETWEEN 1 AND 10;
    
    --DUAL ���̺� : sys������ �ִ� ������ ��밡���� ���̺��̸� 
    --�����ʹ� �� �ุ ����, �÷�(dummy)�� �ϳ� ���� 'X')
    
    SELECT *
    FROM dual;
    
    --SINGLE FOW FUCTION : ��� �ѹ��� FUNCTION�� ����
    --1���� �� INPUT -> 1���� ������ OUTPUT (COLUM)
    -- 'Hello, World'
    --dual���̺��� �����Ͱ� �ϳ��� �ุ ������ ����� �ϳ��� ������ ����
    
    SELECT LOWER ('Hello, World') low, UPPER ('Hello, World') upper, INICAP ('Hello, World') ini
    FROM dual;
    --emp���̺��� �� 14���� ������(����)�� ����(14)
    --�Ʒ������� ����� 14���� ��
    SELECT LOWER ('Hello, World') low , UPPER ('Hello, World') upper , INICAP ('Hello, World') 
    FROM emp;
    
    --�÷��� function ����
    SELECT empno,LOWER (ename) low_enm
    FROM emp
    WHERE ename = UPPER('smith'); --���� �̸��� smith�� ����� ��ȸ�Ϸ��� �빮��/�ҹ���?
    --���̺� �÷��� �����ص� ������ ����� ���� ���� ������.
    --���̺� �÷����ٴ� ������� �����ϴ°� �ӵ��鿡�� ����
    --�ش� �÷��� �ε����� �����ϴ��� �Լ��� �����ϰԵǸ� ���� �޶����� �Ǿ�
    --�ε����� Ȱ�� �� �� ���� �ȴ�
    --���� : FBI(Function Based Index)
    
    SELECT UPPER('smith')
    FROM dual;
    
    --'HELLO'
    --','
    --'WORLD'
    --HELLO, WORLD (�� 3���� ���ڿ� ����� �̿�, CONCAT �Լ��� ����Ͽ� ���ڿ� ����)
    SELECT CONCAT(CONCAT('HELLO', ','), 'WORLD') c1,
          'HELLO' || ', ' || 'WORLD' c2,
        
    --�����ε����� 1���� �����ε��� ���ڿ����� ���Ե�
          SUBSTR ('HELLO, WORLD',1 ,5) s1, --SUBSTR(���ڿ�, �����ε���, �����ε���)
    
    --INSTR : ���ڿ��� Ư�� ���ڿ��� �����ϴ���, ������ ��� ������ �ε����� ����
    INSTR('HELLO, WORLD', 'O') i1,  --5, 9
    -- 'HELLO, WORLD' ���ڿ��� 6��° �ε��� ���Ŀ� �����ϴ� 'o'���ڿ��� �ε��� ����
    INSTR('HELLO, WORLD', 'O',6) i2,  --���ڿ��� Ư�� �ε��� ���ĺ��� �˻��ϵ��� �ɼ�
    INSTR ('HELLO, WORLD', 'O',INSTR('HELLO, WORLD', 'O') +1) i3,
    
    --L/RPAD Ư�� ���ڿ��� ����/�����ʿ� ������ ���ڿ� ���̺��� ������ ��ŭ ���ڿ��� ä�� �ִ´�
    LPAD('HELLO, WORLD', 15, '*')L1,
    RPAD('HELLO, WORLD', 15, '*')R1,
    
    --REPLACE (����ڿ�, �˻� ���ڿ�, ������ ���ڿ�)
    --����ڿ����� �˻� ���ڿ��� ������ ���ڿ��� ġȯ
    REPLACE ('HELLO, WORLD', 'HELLO', 'hello') repl,
    
    --���ڿ� ��, ���� ������ ����
    '   HELLO, WORLD   ' before_trim,
    TRIM('   HELLO, WORLD   ') after_trim,
    TRIM('H' FROM 'HELLO, WORLD') after_trim2

FROM dual;


--���� �����Լ�
--ROUND : �ݿø� - ROUND (����, �ݿø� �ڸ�)
--TRUNC : ���� - TRUNC (����, ���� �ڸ�)
--MOD : ������ ���� MOD (������, ����) // MOD(5, 2) : 1

SELECT --�ݿø������ �Ҽ��� ���ڸ����� �������(�Ҽ��� ��°�ڸ����� �ݿø�)
        ROUND(105.54,1) r1,
        ROUND(105.55,1) r2,
        ROUND(105.55,0) r3, --�Ҽ��� ù��° �ڸ����� �ݿø� 
        ROUND(105.55,-1) r4 --����ù��° �ڸ����� �ݿø�
FROM dual;

SELECT --�ݿø������ �Ҽ��� ���ڸ����� �������(�Ҽ��� ��°�ڸ����� �ݿø�)
        TRUNC(105.54,1) t1,
        TRUNC(105.55,1) t2,
        TRUNC(105.55,0) t3, --�Ҽ��� ù��° �ڸ����� ����
        TRUNC(105.55,-1) t4 --����ù��° �ڸ����� ����
FROM dual;

--MOD (������, ����) �������� ������ ���� ������ ��
--MOD(M, 2)�� ��� ���� : 0, 1 (0~����-1) 
SELECT MOD(5, 2) M1 -- 5/2 = : ���� 2, [�������� 1]
FROM dual;

--emp���̺��� sal�÷��� 1000���� �������� ����� ������ ���� ��ȸ�ϴ� sql�ۼ�
--ename, sal, sal/1000�� ���� ��, sal/1000�� ���� ������
--3500 : 3, 500
--5000 : 5, 0
--1600 : 1, 600
SELECT ename, sal, /*sal/1000���� ���� ��*/ TRUNC(sal/1000), MOD(sal, 1000)
        TRUNC(sal/1000) * 1000, MOD(sal, 1000) sal2
FROM emp;
--DATE : �����, �ð�, ��, ��
SELECT ename, TO_CHAR(hiredate, 'YYYY/MM/DD hh24:ss')  --YYYY/MM/DD
FROM emp;

--SYSCATE : *������ ����* DATE�� �����Ѵ� �����Լ�, Ư���� ���ڰ� ����
--DATE ���� DATE + ����N = DATE�� N���� ��ŭ ���Ѵ�
--DATE ���꿡 �־� ������ ����
--�Ϸ� =24�ð�
--DATE Ÿ�ӿ� �ð��� ���� �� �� �ִ� (1�ð�=1/24)
SELECT TO_CHAR(SYSDATE +5, 'YYYY-MM-DD hh24:mi:ss') AFTER_DAYS,
       TO_CHAR(SYSDATE +5/24, 'YYYY-MM-DD hh24:mi:ss') AFTER_HOURS,
       TO_CHAR(SYSDATE +5/24/60, 'YYYY-MM-DD hh24:mi:ss') AFTER_MINS
       
FROM dual;

SELECT TO_DATE(2019/12/31,'YYYY/MM/DD')LAST_DAY,
       TO_DATE(2019/12/31, 'YYYY/MM/DD') -5 LAST_DAY_BEFORE5,
       SYSDATE NOW,
       SYSDATE -3 NOW_BEFORE3 
       
FROM dual;

--YYYY, MM, DD, D(������ ���ڷ� : �Ͽ���1, ������ 2, ȭ���� 3....����� 7)
--IW(���� 1~53), HH, MI, SS
SELECT TO_CHAR(SYSDATE, 'YYYY')  --����⵵
    ,TO_CHAR(SYSDATE, 'MM') --�����
    ,TO_CHAR(SYSDATE, 'DD') --������
    ,TO_CHAR(SYSDATE, 'D')  --���� ����(�ְ�����1~7)
    ,TO_CHAR(SYSDATE, 'IW') --���� ������ ����(�ش� ���� ������� ������ ��������)
--2019�� 12�� 31���� ������?
    TO_CHAR(TO_DATE('20191231', 'YYYYMMDD'), 'IW') IW_20191231
FROM dual;

SELECT TO_CHAR(SYSDATE 'YYYYMMDD') dt_dash
       TO_CHAR(SYSDATE 'YYYYMMDD HH24:MI:SS') dt_dash_with_time
       TO_CHAR(SYSDATE,'DDMMYYYY') dt_dash_dd_mm_yy
FROM dual;

--DATEŸ���� ROUND, TRUNC ����
SELECT TO_CHAR(SYSDATE, 'YYYY-MM-DD hh24:mi:ss') now
        --MM���� �ݿø� (11�� -> 1��)
      ,TO_CHAR(ROUND(SYSDATE, 'YYYY'), 'YYYY-MM-DD hh24:mi:ss) now_YYYY
        --DD���� �ݿø� (25 -> 1����)
        ,TO_CHAR(ROUND(SYSDATE, 'MM'), 'YYYY-MM-DD hh24:mi:ss) now_MM
        --�ð����� ����(����ð� -> 0��) 
        ,TO_CHAR(ROUND(SYSDATE, 'DD'), 'YYYY-MM-DD hh24:mi:ss) now_DD
FROM dual;

--��¥ ���� �Լ�
--MONTH_BETWEEN(date1, date2) : date2�� date1 ������ ���� ��
--ADD_MONTHS(date, ������ ���� ��) : date���� Ư�� ���� ���� ���ϰų� �� ��¥
--NEXT_DAY(date, weekday(1~7) : date���� ù��° weekday ��¥
--LAST_DAY(date) : date�� ���� ���� ������ ��¥
  
--MONTHS_DETWEEN(date1, date2)
SELECT MONTHS_BETWEEN(TO_DATE('2019-11-25, 'YYYY-MM-DD'),
        TO_DATE('2019-03-31, 'YYYY-MM-DD')) m_bet,
        TO_DATE('2019-03-31', 'YYYY-MM-DD) d_m --�� ��¥ ������ ���ڼ�
FROM dual;

--ADD_MONTH(date, number(+,-) )
SELECT ADD_MONTH (TO_DATE('20191125', 'YYYYMMDD'), 5) NOW_AFTER5M
      ,ADD_MONTH (TO_DATE('20191125', 'YYYYMMDD'), -5) NOW_BEFORE5M
      , SYSDATE + 100 --100�� ���� ��¥ (�� ���� 3/31, 2/28 or 29)
FROM dual;

--NEXT_DAY(dawte, weekday number(1~7))
SELECT NEXT_DAY(SYSDATE, 1) --���ó�¥ (2019/11/25)�� ���� �����ϴ� ù��° �����
FROM dual;

    
    
    
    
    
    
    
    