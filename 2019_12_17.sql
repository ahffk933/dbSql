--WITH
--WITH ����̸� AS (
--  subquery
-- )
--SELECT *
--FROM ����̸�

--deptno, avg(sal) avg_sal
--�ش� �μ��� �޿������ ��ü ������ �޿� ��պ��� ���� �μ��� ���� ��ȸ
SELECT deptno, avg(sal) avg_sal
FROM emp
GROUP BY deptno
HAVING avg(sal) > (SELECT AVG(sal) FROM emp);


--WITH���� ����Ͽ� ���� ������ �ۼ�
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

--��������
--�޷¸����
--CONNECT BY LEVEL <= N
--���̺��� ROW�Ǽ��� N��ŭ �ݺ��Ѵ�
--CONNECT BY LEVEL���� ����� ���������� 
--SELECT������ LEVEL�̶�� Ư�� �÷��� ����� �� �ִ�
--������ ǥ���ϴ� Ư�� �÷����� 1���� �����ϸ� ROWNUM�� �����ϳ�
--���� ���� �� START WITH, CONNECT BY������ �ٸ� ���� ���� �ȴ�


--2019�� 11���� 30�ϱ�����
--201911
--���� + ���� = ������ŭ �̷��� ����
--201911 -> �ش����� ��¥�� ���� ���� ���� �ϴ°�?
SELECT TO_DATE(:yyyymm, 'YYYYMM') + (LEVEL-1) dt
FROM dual
CONNECT BY LEVEL <= TO_CHAR(LAST_DAY(TO_DATE(:yyyymm, 'YYYYMM')), 'DD');

--201911 -> 30
--201912 -> 31
--202402 -> 29
--201902 -> 28
SELECT TO_CHAR(LAST_DAY(TO_DATE(:yyyymm, 'YYYYMM')), 'DD') --30
FROM DUAL;

SELECT /*�Ͽ����̸� ��¥,*/ /*ȭ�����̸� ��¥,....*//*..������̸� ��¥*/
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

SELECT /*�Ͽ����̸� ��¥,*/ /*ȭ�����̸� ��¥,....*//*..������̸� ��¥*/
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




--12�� 31�� �� 1/1����~���� �� �ְ�
SELECT /*�Ͽ����̸� ��¥,*/ /*ȭ�����̸� ��¥,....*//*..������̸� ��¥*/
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

insert into dept_h values ('dept0', 'XXȸ��', '');
insert into dept_h values ('dept0_00', '�����κ�', 'dept0');
insert into dept_h values ('dept0_01', '������ȹ��', 'dept0');
insert into dept_h values ('dept0_02', '�����ý��ۺ�', 'dept0');
insert into dept_h values ('dept0_00_0', '��������', 'dept0_00');
insert into dept_h values ('dept0_01_0', '��ȹ��', 'dept0_01');
insert into dept_h values ('dept0_02_0', '����1��', 'dept0_02');
insert into dept_h values ('dept0_02_1', '����2��', 'dept0_02');
insert into dept_h values ('dept0_00_0_0', '��ȹ��Ʈ', 'dept0_01_0');
commit;




SELECT dept_h.*, LEVEL
FROM dept_h
START WITH deptcd = 'dept0'    --�������� deptcd = 'dept0' ->  xxȸ��(�ֻ�������)
CONNECT BY PRIOR deptcd = p_deptcd
;
/*
    dept0 (xxȸ��)
        dept0_00(�����κ�)
            dept0_00_0(��������)
        dept0_01(������ȹ��)
            dept0_01_0(��ȹ��)
                dept0_00_0_0(��ȹ��Ʈ)
        dept0_02(�����ý��ۺ�)
            dept0_02_0(����1��)
            dept0_02_1(����2��)