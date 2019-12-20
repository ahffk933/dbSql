--분석함수 (window) -p98
--행 간의 연산을 도와줌
--사원이름, 사원번호, 전체직원 건수
SELECT a.ename, a.sal, a.deptno, b.rn
FROM
    (SELECT ename, sal, deptno, ROWNUM j_rn
    FROM 
        (SELECT ename, sal, deptno
        FROM emp
        ORDER BY deptno, sal DESC)) a,

(SELECT rn, ROWNUM j_rn    --J_RN은 가상컬럼 RN과 조인해주기 위해
FROM
    (SELECT b.*, a.rn
     FROM
    (SELECT ROWNUM rn
     FROM dual
     CONNECT BY level <= (SELECT COUNT(*) FROM emp)) a,
    
    (SELECT deptno, COUNT(*) cnt
     FROM emp
     GROUP BY deptno) b
     WHERE b.cnt >= a.rn
     ORDER BY b.deptno, a.rn )) b
WHERE a.j_rn = b.j_rn;






--ana0-을 분석함수로
SELECT ename, sal, deptno,
        RANK() OVER (PARTITION BY deptno ORDER BY sal) rank,
        DENSE_RANK() OVER (PARTITION BY deptno ORDER BY sal) dense_rank,
        ROW_NUMBER() OVER (PARTITION BY deptno ORDER BY sal) row_rank
FROM emp;


--ana test1
SELECT empno, ename, sal, deptno,
        RANK() OVER (ORDER BY sal desc, empno) sal_rank,
        DENSE_RANK() OVER (ORDER BY sal desc, empno) sal_dense_rank,
        ROW_NUMBER() OVER (ORDER BY sal desc, empno) sal_row_rank
FROM emp
ORDER BY sal DESC;


--no-ana test2
SELECT b.empno, b.ename, b.deptno, a.cnt
FROM 
(SELECT deptno, COUNT(deptno) cnt
FROM emp
GROUP BY deptno) a, emp b
WHERE a.deptno = b.deptno
ORDER BY deptno;

--사원번호, 사원이름, 부서번호, 부서의 직원 수
SELECT empno, ename, deptno,
        COUNT(*) OVER (PARTITION BY deptno) cnt   -- <-한 컬럼임
FROM emp;


--ana-test2
SELECT empno, ename, sal, deptno,
       ROUND(AVG(sal) OVER (PARTITION BY deptno), 2) avg 
FROM emp;

--test3
SELECT empno, ename, sal, deptno,
       MAX(sal) OVER (PARTITION BY deptno) max_sal,
       MIN(sal) OVER (PARTITION BY deptno) min_sal
FROM emp;

--test4
SELECT empno, ename, sal, deptno,
       MIN(sal) OVER (PARTITION BY deptno) min_sal  
FROM emp;


--전체사원을 대상으로 급여순위가 자신보다 한단계 낮은 사람의 급여
--(급여가 같은 경우 입사일자가 빠른 사람이 높은 순위)
SELECT empno, ename, hiredate, sal,
       LEAD(sal) OVER (ORDER BY sal DESC, hiredate) lead_sal
FROM emp;

--test5
SELECT empno, ename, hiredate, sal,
       LAG(sal) OVER (ORDER BY sal DESC, hiredate) lag_sal
FROM emp;

--test6
SELECT empno, ename, hiredate, job, sal,
       LAG(sal) OVER (PARTITION BY job ORDER BY sal DESC, hiredate) lag_sal
FROM emp;


SELECT emp.empno, emp.ename, emp.sal, a.sal(SUM(a.rn)) c_sum 
FROM emp, (SELECT sal, ROWNUM rn
      FROM emp
      ORDER BY sal ASC)a
      SELECT SUM(sal)    
      FROM emp
      WHERE emp.rn >= a.rn 
;


