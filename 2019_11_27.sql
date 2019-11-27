--GROUP FUNCTION
--특정 컬럼이나, 표현을 기준으로 여러행의 값을 한행의 결과로 생성
--COUNT-건수, SUM-합계 ,AVG-평균, MAX-최대값 ,MIN-최소값
--전체 직원을 대상으로 (14건을 ->1건으로)
--가장 높은 급여

SELECT MAX(sal) max_sal, --가장 높은 급여
       MIN(sal) min_sal, --가장 낮은 급여
       ROUND(AVG(sal),2) avg_sal, --전 직원의 평균 급여
       SUM(sal) sum_sal, --전 직원의 급여 평균
       COUNT(sal) count_sal, --급여 건수(null이 아닌 값이면 1건)
       COUNT(mgr) count_mgr, --직원의 관리자 건수(KING의 경우 MGR가 없다)
       COUNT(*) count_row --특정 컬럼의 건수가 아니라 행의 개수를 알고 싶을때

FROM emp;

--부서번호별 그룹함수 적용
SELECT deptno,
       MAX(sal) max_sal, --부서에서 가장 높은 급여
       MIN(sal) min_sal, --부서에서 가장 낮은 급여
       ROUND(AVG(sal),2) avg_sal, --부서 직원의 평균 급여
       SUM(sal) sum_sal, --부서 직원의 급여 합계
       COUNT(sal) count_sal, --부서의 급여 건수(null이 아닌 값이면 1건)
       COUNT(mgr) count_mgr, --부서직원의 관리자 건수(KING의 경우 MGR가 없다)
       COUNT(*) count_row  --부서의 조직원 수
FROM emp
GROUP BY deptno;
--3건

SELECT deptno, ename,
       MAX(sal) max_sal, --부서에서 가장 높은 급여
       MIN(sal) min_sal, --부서에서 가장 낮은 급여
       ROUND(AVG(sal),2) avg_sal, --부서 직원의 평균 급여
       SUM(sal) sum_sal, --부서 직원의 급여 합계
       COUNT(sal) count_sal, --부서의 급여 건수(null이 아닌 값이면 1건)
       COUNT(mgr) count_mgr, --부서직원의 관리자 건수(KING의 경우 MGR가 없다)
       COUNT(*) count_row  --부서의 조직원 수
FROM emp
GROUP BY deptno, ename;
--14건

--SELECT절에는 GROUP BY절에 표현된 컬럼 이외의 컬럼이 올 수 없다
--논리적으로 성립이 되지 않음(여러명의 직원 정보로 한건의 데이터로 그루핑)
--단 예외적으로 상수값들은 SELECT절에 표현 가능
SELECT deptno, 1, '문자열', SYSDATE,
       MAX(sal) max_sal, --부서에서 가장 높은 급여
       MIN(sal) min_sal, --부서에서 가장 낮은 급여
       ROUND(AVG(sal),2) avg_sal, --부서 직원의 평균 급여
       SUM(sal) sum_sal, --부서 직원의 급여 합계
       COUNT(sal) count_sal, --부서의 급여 건수(null이 아닌 값이면 1건)
       COUNT(mgr) count_mgr, --부서직원의 관리자 건수(KING의 경우 MGR가 없다)
       COUNT(*) count_row  --부서의 조직원 수
FROM emp
GROUP BY deptno;

--그룹함수에서 NULL컬럼은 계산에서 제외
--EMP테이블에서 comm컬럼이 null이 아닌 데이터는 4건이 존재, 9건은 NULL)
SELECT COUNT(comm) count_comm,  --NULL이 아닌 값의 개수 -> 4
       SUM(comm) sum_comm,      --NULL값을 제외, 300+500+1400+0=2200
       SUM(sal) sum_sal,
       SUM(sal + comm) tot_sal_sum,
       SUM(sal + NVL(comm, 0)) tot_sal_sum
FROM emp;

--WHERE절에는 GROUP 함수를 표현할 수 없다
--1. 부서별 최대 급여 구하기
--2. 부서별 최대 급여 값이 3000넘는 행만 구하기
SELECT deptno,
       MAX(sal) max_sal > 3000 --ORA-00934에러 WHERE절에 GROUP함수가 올 수 없다
FROM emp
GROUP BY deptno;

SELECT deptno, MAX(sal) m_sal
FROM emp
GROUP BY deptno
HAVING MAX(sal) >= 3000;

SELECT 
       MAX(sal) max_sal,
       MIN(sal)min_sal,
       ROUND(AVG(sal),2)avg_sal,
       SUM(sal)sum_sal,
       COUNT(sal)count_sal,
       COUNT(comm)count_comm,
       COUNT(*)count_row
FROM emp;


SELECT deptno,
       MAX(sal) max_sal,
       MIN(sal)min_sal,
       ROUND(AVG(sal),2)avg_sal,
       SUM(sal)sum_sal,
       COUNT(sal)count_sal,
       COUNT(comm)count_comm,
       COUNT(*)count_row
FROM emp
GROUP BY deptno;

SELECT DECODE(deptno,10, 'ACCOUNTING', 20, 'RESEARCH', 30,'SALES') as DNAME,
       MAX(sal) max_sal,
       MIN(sal)min_sal,
       ROUND(AVG(sal),2)avg_sal,
       SUM(sal)sum_sal,
       COUNT(sal)count_sal,
       COUNT(comm)count_comm,
       COUNT(*)count_row
  
FROM emp
GROUP BY deptno
ORDER BY dname;


SELECT (TO_CHAR(hiredate, 'YYYYMM')) hired_yyyymm,
COUNT(*) cnt

FROM emp
GROUP BY TO_CHAR(hiredate, 'YYYYMM');


SELECT hire_yyyy, COUNT(*) cnt
FROM(
    SELECT TO_CHAR(hiredate, 'YYYY') as hire_yyyy
    FROM emp) hire_yyyy
    
GROUP BY hire_yyyy;


SELECT COUNT(deptno) as cnt
FROM dept;


--전체 직원 수
SELECT COUNT(*), COUNT(empno), COUNT(mgr)
FROM emp;
--전체 부서 수(dept)
SELECT COUNT(*), COUNT(deptno), COUNT(loc)
FROM dept;

SELECT COUNT(COUNT(deptno)) cnt
FROM emp
GROUP BY deptno;


SELECT COUNT(DISTINCT deptno) deptno
FROM emp;

--JOIN
--1. 테이블 구조변경(컬럼 추가)
--2. 추가된 컬럼에 값을 update
--dname 컬럼을 emp테이블에 추가
DESC emp;

--컬럼추가(dname, VARCHAR(14))

ALTER TABLE emp ADD (dname VARCHAR2(14));
DESC emp;

SELECT *
FROM emp;

UPDATE emp SET dname = CASE
                            WHEN deptno = 10 THEN 'ACCOUNTING'
                            WHEN deptno = 20 THEN 'RESEARCH'
                            WHEN deptno = 30 THEN 'SALES'
                        END;
COMMIT;

SELECT empno, ename, deptno, dname
FROM emp;

--SALES -> MARKET SALES
--총 6건의 데이터 변경이 필요
--값의 중복이 있는 형태(반 정규형)
--예) UPDATE emp SET dname = 'MARKET SALES'
--    WHERE dname = 'SALES';

--emp테이블, dept 테이블 조인
SELECT ename, emp.deptno, dept.dname
FROM emp, dept
WHERE emp.deptno = dept.deptno;
