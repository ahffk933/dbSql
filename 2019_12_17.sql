--WITH
--WITH 블록이름 AS (
--  subquery
-- )
--SELECT *
--FROM 블록이름

--deptno, avg(sal) avg_sal
--해당 부서의 급여평균이 전체 직원의 급여 평균보다 높은 부서에 한해 조회
SELECT deptno, avg(sal) avg_sal
FROM emp
GROUP BY deptno
HAVING avg(sal) > (SELECT AVG(sal) FROM emp);


--WITH절을 사용하여 위의 쿼리를 작성
WITH dept_sal_avg AS (
    SELECT deptno, avg(sal) avg_sal
    FROM emp
    GROUP BY deptno),
    emp_sal_avg AS (
        SELECT AVG(sal) avg_sal FROM emp)
SELECT *
FROM dept_sal_avg
WHERE avg_sal > (SELECT avg_sal FROM emp_sal_avg);

WITH test AS(
    SELECT 1, 'TEST' FROM DUAL UNION ALL
    SELECT 2, 'TEST2' FROM DUAL UNION ALL
    SELECT 3, 'TEST3' FROM DUAL) 
SELECT *
FROM test;

--계층쿼리
--달력만들기
--CONNECT BY LEVEL <= N
--테이블의 ROW건수를 N만큼 반복한다
--CONNECT BY LEVEL절을 사용한 쿼리에서는 
--SELECT절에서 LEVEL이라는 특수 컬럼을 사용할 수 있다
--계층을 표현하는 특수 컬럼으로 1부터 증가하며 ROWNUM과 유사하나
--추후 배우게 될 START WITH, CONNECT BY절에서 다른 점을 배우게 된다


--2019년 11월은 30일까지임
--201911
--일자 + 정수 = 정수만큼 미래의 일자
--201911 -> 해당년월의 날짜가 몇일 까지 존재 하는가?
SELECT TO_DATE(:yyyymm, 'YYYYMM') + (LEVEL-1) dt
FROM dual
CONNECT BY LEVEL <= TO_CHAR(LAST_DAY(TO_DATE(:yyyymm, 'YYYYMM')), 'DD');

--201911 -> 30
--201912 -> 31
--202402 -> 29
--201902 -> 28
SELECT TO_CHAR(LAST_DAY(TO_DATE(:yyyymm, 'YYYYMM')), 'DD') --30
FROM DUAL;

SELECT /*일요일이면 날짜,*/ /*화요일이면 날짜,....*//*..토요일이면 날짜*/
        /*dt, d,*/ iw,
        MAX(DECODE(d, 1, dt)) sun, MAX(DECODE(d, 2, dt)) mon, MAX(DECODE(d, 3, dt)) tue,
        MAX(DECODE(d, 4, dt)) wed, MAX(DECODE(d, 5, dt)) thu, MAX(DECODE(d, 6, dt)) fri,
        MAX(DECODE(d, 7, dt)) sat
FROM
    (SELECT TO_DATE(:yyyymm, 'YYYYMM') + (LEVEL-1) dt,
           TO_CHAR(TO_DATE(:yyyymm, 'YYYYMM') + (LEVEL-1), 'D') d,
           TO_CHAR(TO_DATE(:yyyymm, 'YYYYMM') + (LEVEL-1), 'IW') iw
    FROM dual
    CONNECT BY LEVEL <= TO_CHAR(LAST_DAY(TO_DATE(:yyyymm, 'YYYYMM')), 'DD'))
GROUP BY iw
ORDER BY iw;




SELECT TO_CHAR(LAST_DAY(TO_DATE(:yyyymm, 'YYYYMM')), 'DD') --30
FROM DUAL;

SELECT /*일요일이면 날짜,*/ /*화요일이면 날짜,....*//*..토요일이면 날짜*/
        /*dt, d,*/ /*dt - (d-1),*//*iw,*/
        MAX(DECODE(d, 1, dt)) sun, MAX(DECODE(d, 2, dt)) mon, MAX(DECODE(d, 3, dt)) tue,
        MAX(DECODE(d, 4, dt)) wed, MAX(DECODE(d, 5, dt)) thu, MAX(DECODE(d, 6, dt)) fri,
        MAX(DECODE(d, 7, dt)) sat
FROM
    (SELECT TO_DATE(:yyyymm, 'YYYYMM') + (LEVEL-1) dt,
           TO_CHAR(TO_DATE(:yyyymm, 'YYYYMM') + (LEVEL-1), 'D') d,
           TO_CHAR(TO_DATE(:yyyymm, 'YYYYMM') + (LEVEL-1), 'IW') iw
    FROM dual
    CONNECT BY LEVEL <= TO_CHAR(LAST_DAY(TO_DATE(:yyyymm, 'YYYYMM')), 'DD'))
GROUP BY dt - (d-1)
ORDER BY dt - (d-1);
--GROUP BY iw
--ORDER BY sat;

create table sales as 
select to_date('2019-01-03', 'yyyy-MM-dd') dt, 500 sales from dual union all
select to_date('2019-01-15', 'yyyy-MM-dd') dt, 700 sales from dual union all
select to_date('2019-02-17', 'yyyy-MM-dd') dt, 300 sales from dual union all
select to_date('2019-02-28', 'yyyy-MM-dd') dt, 1000 sales from dual union all
select to_date('2019-04-05', 'yyyy-MM-dd') dt, 300 sales from dual union all
select to_date('2019-04-20', 'yyyy-MM-dd') dt, 900 sales from dual union all
select to_date('2019-05-11', 'yyyy-MM-dd') dt, 150 sales from dual union all
select to_date('2019-05-30', 'yyyy-MM-dd') dt, 100 sales from dual union all
select to_date('2019-06-22', 'yyyy-MM-dd') dt, 1400 sales from dual union all
select to_date('2019-06-27', 'yyyy-MM-dd') dt, 1300 sales from dual;

SELECT *
FROM sales;




--12월 31일 후 1/1부터~나올 수 있게
SELECT /*일요일이면 날짜,*/ /*화요일이면 날짜,....*//*..토요일이면 날짜*/
        /*dt, d,*/ /*dt - (d-1), iw,*/
        MAX(DECODE(d, 1, dt)) sun, MAX(DECODE(d, 2, dt)) mon, MAX(DECODE(d, 3, dt)) tue,
        MAX(DECODE(d, 4, dt)) wed, MAX(DECODE(d, 5, dt)) thu, MAX(DECODE(d, 6, dt)) fri,
        MAX(DECODE(d, 7, dt)) sat
FROM
    (SELECT TO_DATE(:yyyymm, 'YYYYMM') + (LEVEL-1) dt,
           TO_CHAR(TO_DATE(:yyyymm, 'YYYYMM') + (LEVEL-1), 'D') d,
           TO_CHAR(TO_DATE(:yyyymm, 'YYYYMM') + (LEVEL), 'IW') iw
    FROM dual
    CONNECT BY LEVEL <= TO_CHAR(LAST_DAY(TO_DATE(:yyyymm, 'YYYYMM')), 'DD'))
GROUP BY iw
ORDER BY sat;





SELECT
       NVL(MIN(DECODE(mm, '01', sales_sum)), 0) jan, NVL(MIN(DECODE(mm, '02', sales_sum)), 0) feb, NVL(MIN(DECODE(mm, '03', sales_sum)), 0) mar,
       NVL(MIN(DECODE(mm, '04', sales_sum)), 0) apr, NVL(MIN(DECODE(mm, '05', sales_sum)), 0) may, NVL(MIN(DECODE(mm, '06', sales_sum)), 0) jun
FROM 
    (SELECT TO_CHAR(dt, 'MM') mm, SUM(sales) sales_sum
      FROM sales
      GROUP by TO_CHAR(dt, 'MM'));
   
   
SELECT *
FROM SALES;






create table dept_h (
    deptcd varchar2(20) primary key ,
    deptnm varchar2(40) not null,
    p_deptcd varchar2(20),
    
    CONSTRAINT fk_dept_h_to_dept_h FOREIGN KEY
    (p_deptcd) REFERENCES  dept_h (deptcd) 
);

insert into dept_h values ('dept0', 'XX회사', '');
insert into dept_h values ('dept0_00', '디자인부', 'dept0');
insert into dept_h values ('dept0_01', '정보기획부', 'dept0');
insert into dept_h values ('dept0_02', '정보시스템부', 'dept0');
insert into dept_h values ('dept0_00_0', '디자인팀', 'dept0_00');
insert into dept_h values ('dept0_01_0', '기획팀', 'dept0_01');
insert into dept_h values ('dept0_02_0', '개발1팀', 'dept0_02');
insert into dept_h values ('dept0_02_1', '개발2팀', 'dept0_02');
insert into dept_h values ('dept0_00_0_0', '기획파트', 'dept0_01_0');
commit;




SELECT dept_h.*, LEVEL
FROM dept_h
START WITH deptcd = 'dept0'    --시작점은 deptcd = 'dept0' ->  xx회사(최상위조직)
CONNECT BY PRIOR deptcd = p_deptcd
;
/*
    dept0 (xx회사)
        dept0_00(디자인부)
            dept0_00_0(디자인팀)
        dept0_01(정보기획부)
            dept0_01_0(기획팀)
                dept0_00_0_0(기획파트)
        dept0_02(정보시스템부)
            dept0_02_0(개발1팀)
            dept0_02_1(개발2팀)