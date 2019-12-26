--PL/SQL������ index�� ���ڰ� �ƴ� ���ڿ��� ����
--List<String> nameList = name ArrayList<String>();

--FOR LOOP���� ������ Ŀ�� ����ϱ�
--�μ����̺��� ��� ���� �μ��̒�, ��ġ ���� ������ ���(CORSOR�̿�)
SET SERVEROUTPUT ON;
DECLARE
    --Ŀ�� ����
    CURSOR dept_cursor IS 
        SELECT dname, loc
        FROM dept;
    v_dname dept.dname%TYPE;
    v_loc dept.loc%TYPE;
BEGIN
    FOR record_row IN dept_cursor LOOP
        DBMS_OUTPUT.PUT_LINE(record_row.dname || ',' || record_row.loc);
    END LOOP;
END;
/

--Ŀ������ ���ڰ� ���� ���
SET SERVEROUTPUT ON;
DECLARE
    --Ŀ�� ����
    CURSOR dept_cursor(p_deptno dept.deptno%TYPE) IS 
        SELECT dname, loc
        FROM dept
        WHERE p_deptno = deptno;
    v_dname dept.dname%TYPE;
    v_loc dept.loc%TYPE;
BEGIN
    FOR record_row IN dept_cursor(10) LOOP
        DBMS_OUTPUT.PUT_LINE(record_row.dname || ',' || record_row.loc);
    END LOOP;
END;
/


--FOR LOOP �ζ��� Ŀ��
--FOR LOOP �������� Ŀ���� ���� ����
SET SERVEROUTPUT ON;

--�������� test pro_3
CREATE OR REPLACE PROCEDURE AVGDT IS
    TYPE dt_tab IS TABLE OF dt%ROWTYPE INDEX BY BINARY_INTEGER;
    v_dt_tab dt_tab;
    v_sum NUMBER := 0;   

BEGIN
    SELECT *
    BULK COLLECT INTO v_dt_tab
    FROM dt
    ORDER BY dt;
    
    FOR i IN 1..(v_dt_tab.count-1) LOOP
    v_sum := v_sum + v_dt_tab(i+1).dt - v_dt_tab(i).dt;
    END LOOP;
    DBMS_OUTPUT.PUT_LINE(v_sum / (v_dt_tab.count -1));
    
END;
/
exec AVGDT;

--1 rownum
--2 �м��Լ�
--3 ??
SELECT AVG(sum_avg) sum_avg
FROM (SELECT LEAD(dt) OVER(ORDER BY dt) - dt sum_avg
FROM dt);

--test pro_4
CREATE OR REPLACE PROCEDURE CREATE_DAILY_SALES
(v_yyyymm IN VARCHAR2) IS    --��¥�� VARCHAR�� �Ǿ��ִ°� ����
    TYPE cal_row_type IS RECORD (
        dt VARCHAR2(8),
        day NUMBER);
    TYPE cal_tab IS TABLE OF cal_row_type INDEX BY BINARY_INTEGER;
    v_cal_tab cal_tab;
BEGIN
    --�����ϱ� �� �ش����� �ش��ϴ� �Ͻ��� �����͸� ����
    DELETE daily
    WHERE dt LIKE v_yyyymm || '%';
    
    --�޷������� table������ ����
    --�ݺ����� sql������ �����ϱ� ���� �ѹ��� �����ؼ� ������ ����
    SELECT TO_CHAR(TO_DATE(v_yyyymm, 'YYYYMM') + (LEVEL-1), 'YYYYMMDD') dt,  --��¥
           TO_CHAR(TO_DATE(v_yyyymm, 'YYYYMM') + (LEVEL-1), 'D') day  --����
    BULK COLLECT INTO v_cal_tab
    FROM dual
    CONNECT BY LEVEL <= TO_CHAR(LAST_DAY(TO_DATE(v_yyyymm, 'YYYYMM')), 'DD');
    
    --�����ֱ� ������ �д´�
    FOR daily IN (SELECT * FROM cycle) LOOP
        --12�� ���� �޷� : cycle row�Ǽ� ��ŭ �ݺ�
        FOR i IN 1..v_cal_tab.count LOOP
            IF daily.day = v_cal_tab(i).day THEN
                --cid, pid, ����, ����
                INSERT INTO daily VALUES 
                    (daily.cid, daily.pid, v_cal_tab(i).dt, daily.cnt);
            END IF;
        END LOOP;
        DBMS_OUTPUT.PUT_LINE(daily.cid || ',' || daily.day);
    END LOOP;
    

END;
/

exec create_daily_sales('201912');


SELECT *
FROM daily;


SELECT * 
FROM daily 
WHERE dt BETWEEN '201912' || '01' AND '2019' || '31';

SELECT * 
FROM daily 
WHERE dt LIKE '201912' || '%';


SELECT TO_CHAR(TO_DATE('201912', 'YYYYMM') + (LEVEL-1), 'YYYYMMDD') dt,  --��¥
       TO_CHAR(TO_DATE('201912', 'YYYYMM') + (LEVEL-1), 'D') day  --����
FROM dual
CONNECT BY LEVEL <= TO_CHAR(LAST_DAY(TO_DATE('201912', 'YYYYMM')), 'DD');





SELECT *
FROM DAILY;
--66�� ������
--1�� : 0.028��

INSERT INTO DAILY VALUES (1, 100, '20191201', 5);

INSERT INTO DAILY
SELECT cycle.cid, cycle.pid, cal.dt, cycle.cnt
FROM cycle,
    (SELECT TO_CHAR(TO_DATE(:v_yyyymm, 'YYYYMM') + (LEVEL-1), 'YYYYMMDD') dt,  --��¥
           TO_CHAR(TO_DATE(:v_yyyymm, 'YYYYMM') + (LEVEL-1), 'D') day  --����
    FROM dual
    CONNECT BY LEVEL <= TO_CHAR(LAST_DAY(TO_DATE(:v_yyyymm, 'YYYYMM')), 'DD')) cal
WHERE cycle.day = cal.day;
    