--PL/SQL에서는 index를 숫자가 아닌 문자열도 가능
--List<String> nameList = name ArrayList<String>();

--FOR LOOP에서 명시적 커서 사용하기
--부서테이블의 모든 행의 부서이믊, 위치 지역 정보를 출력(CORSOR이용)
SET SERVEROUTPUT ON;
DECLARE
    --커서 선언
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

--커서에서 인자가 들어가는 경우
SET SERVEROUTPUT ON;
DECLARE
    --커서 선언
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


--FOR LOOP 인라인 커서
--FOR LOOP 구문에서 커서를 직접 선언
SET SERVEROUTPUT ON;

--로직제어 test pro_3
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
--2 분석함수
--3 ??
SELECT AVG(sum_avg) sum_avg
FROM (SELECT LEAD(dt) OVER(ORDER BY dt) - dt sum_avg
FROM dt);

--test pro_4
CREATE OR REPLACE PROCEDURE CREATE_DAILY_SALES
(v_yyyymm IN VARCHAR2) IS    --날짜가 VARCHAR로 되어있는거 주의
    TYPE cal_row_type IS RECORD (
        dt VARCHAR2(8),
        day NUMBER);
    TYPE cal_tab IS TABLE OF cal_row_type INDEX BY BINARY_INTEGER;
    v_cal_tab cal_tab;
BEGIN
    --생성하기 전 해당년월에 해당하는 일시적 데이터를 삭제
    DELETE daily
    WHERE dt LIKE v_yyyymm || '%';
    
    --달력정보를 table변수에 저장
    --반복적인 sql실행을 방지하기 위해 한번만 실행해서 변수에 저장
    SELECT TO_CHAR(TO_DATE(v_yyyymm, 'YYYYMM') + (LEVEL-1), 'YYYYMMDD') dt,  --날짜
           TO_CHAR(TO_DATE(v_yyyymm, 'YYYYMM') + (LEVEL-1), 'D') day  --요일
    BULK COLLECT INTO v_cal_tab
    FROM dual
    CONNECT BY LEVEL <= TO_CHAR(LAST_DAY(TO_DATE(v_yyyymm, 'YYYYMM')), 'DD');
    
    --애음주기 정보를 읽는다
    FOR daily IN (SELECT * FROM cycle) LOOP
        --12월 일자 달력 : cycle row건수 만큼 반복
        FOR i IN 1..v_cal_tab.count LOOP
            IF daily.day = v_cal_tab(i).day THEN
                --cid, pid, 일자, 수량
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


SELECT TO_CHAR(TO_DATE('201912', 'YYYYMM') + (LEVEL-1), 'YYYYMMDD') dt,  --날짜
       TO_CHAR(TO_DATE('201912', 'YYYYMM') + (LEVEL-1), 'D') day  --요일
FROM dual
CONNECT BY LEVEL <= TO_CHAR(LAST_DAY(TO_DATE('201912', 'YYYYMM')), 'DD');





SELECT *
FROM DAILY;
--66건 데이터
--1건 : 0.028초

INSERT INTO DAILY VALUES (1, 100, '20191201', 5);

INSERT INTO DAILY
SELECT cycle.cid, cycle.pid, cal.dt, cycle.cnt
FROM cycle,
    (SELECT TO_CHAR(TO_DATE(:v_yyyymm, 'YYYYMM') + (LEVEL-1), 'YYYYMMDD') dt,  --날짜
           TO_CHAR(TO_DATE(:v_yyyymm, 'YYYYMM') + (LEVEL-1), 'D') day  --요일
    FROM dual
    CONNECT BY LEVEL <= TO_CHAR(LAST_DAY(TO_DATE(:v_yyyymm, 'YYYYMM')), 'DD')) cal
WHERE cycle.day = cal.day;
    
