SELECT *
FROM emp_test
ORDER BY empno;

--emp테이블에 존재하는 데이터를 emp_test테이블로 머지 merge
--만약 empno가 동일한 데이터가 존재하면 ename update : ename || '_merge'
--만약 empno에 동일한 데이터가 존재하지 않을 경우 emp테이블의 empno, ename emp_test데이터로 insert

--emp_Test데이터에서 절반의 데이터를 삭제
DELETE emp_test
WHERE empno >= 7788;
COMMIT;

--emp테이블에는 14건의 데이터 존재
--emp_test테이블에는 사번이 7788보다 작은 7명의 데이터가 존재
--emp테이블을 이용하여 emp_Test테이블을 머지하게되면
--emp테이블에만 존재하는 직원 (사번이 7788보다 크거나 같은) 7명
--emp_test로 새롭게 insert가 될거고
--emp, emp_test에 사원번호가 동일하게 존재하는 7명의 데이터는 
--(사번이 7788보다 작은 직원)ename컬럼은 ename || '_modify'로 업데이트한다

/*
MERGE INTO 테이블명
USING 머지대상 테이블 |VIEW|SUBQUERY
ON (테이블명과 머지대상의 연결관계
WHEN MATCHED THEN
    UPDATE....
WHEN NOT MATCHED THEN
    INSERT....
*/

MERGE INTO emp_test
USING emp
ON (emp.empno = emp_test.empno)
WHEN MATCHED THEN
    UPDATE SET ename = ename || '_mod'
WHEN NOT MATCHED THEN
    INSERT VALUES (emp.empno, emp.ename);
    
SELECT *
FROM emp_test;


-- emp_test테이블에 사번이 9999인 데이터가 존재하면
-- ename을 'brown'으로 update
-- 존재하지 않을 경우 empno, ename VALUES (9999, 'brown')으로 insert
-- 위의 시나이로를 MERGE 구문을 활용하여 한번의 sql로 구현
-- :empno -> 9999, :ename -> 'brown'
MERGE INTO emp_test
USING dual
ON (emp_test.empno = :empno)
WHEN MATCHED THEN
    UPDATE SET ename = :ename || '_mod'
WHEN NOT MATCHED THEN 
    INSERT VALUES (:empno, :ename);
SELECT *
FROM emp_test
WHERE empno=9999;

--만약 merge구문이 없다면 (** 2번의 SQL이 필요)
-- 1. empno = 9999인 데이터가 존재하는지 확인
-- 2-1. 1번 사항에서 데이터가 존재하면 UPDATE
-- 2.2. 1번 사항에서 데이터가 존재하지 않으면 INSERT


SELECT *
FROM emp;
--부서별 급여 합
SELECT deptno, SUM(sal) sal
FROM emp
GROUP BY deptno
ORDER BY deptno;
--전체 직원의 급여 합
SELECT SUM(sal) sal
FROM emp;

SELECT deptno, SUM(sal) sal
FROM emp
GROUP BY deptno
UNION ALL
SELECT NULL, SUM(sal) sal
FROM emp
ORDER BY deptno;
--테이블을 두개 만들어야한다는게 단점

--JOIN 방식으로 풀이
--emp table의 14건의 데이터를 28건으로 생성할거임
--구분자(1-14, 2-14)를 기준으로 group by
--구분자 1 : 부서번호 기준으로 14row
--구분자 2 : 전체 14 row
SELECT DECODE(b.rn, 1, emp.deptno, 2, null) deptno,
       SUM(emp.sal) sal
FROM emp,
    (SELECT ROWNUM rn
     FROM dept
     WHERE ROWNUM <= 2) b
GROUP BY DECODE(b.rn, 1, emp.deptno, 2, null);

--또는

SELECT DECODE(b.rn, 1, emp.deptno, 2, null) deptno,
       SUM(emp.sal) sal
FROM emp,
    (SELECT LEVEL rn 
    FROM dual 
    CONNECT BY LEVEL <= 2) b
GROUP BY DECODE(b.rn, 1, emp.deptno, 2, null)
ORDER BY DECODE(b.rn, 1, emp.deptno, 2, null);

--또는 

SELECT DECODE(b.rn, 1, emp.deptno, 2, null) deptno,
       SUM(emp.sal) sal
FROM emp,
    (SELECT 1 rn FROM dual UNION ALL
    ) b
GROUP BY DECODE(b.rn, 1, emp.deptno, 2, null)
ORDER BY DECODE(b.rn, 1, emp.deptno, 2, null);



--REOIRT GOUP BY
--ROLLUP
--GROUP BY ROLLUP(col1...)
--ROLLUP 전에 기술된 컬럼을 오른쪽에서부터 결과로
--SUB GROUP을 생성하여 여러개의 GROUP BY절을 하나의 SQL에서 실행되도록 한다
GROUP BY ROLLUP(job, deptno)
--GROUP BY job, deptno
--GROUP BY job
--GROUP BY -> 전체 행을 대상으로 GROUP BY


--EMP테이블을 이용하여 부서번호별, 전체직원별 급여합을 구하는 쿼리를
--ROLLUP기능을 이용하여 작성
SELECT deptno, SUM(sal)sal
FROM emp
GROUP BY ROLLUP(deptno);

--emp테이블을 이용하여 job, deptno별 sal + comm 합계
--                   job 별 sal+comm
--                   전체직원의 sal+comm
--ROLLUP을 활용하여 작성
SELECT job, deptno, SUM(sal+ NVL(comm, 0)) sal_sum
FROM emp
GROUP BY ROLLUP(job, deptno);
--GROUP BY job, deptno
--GROUP BY job
--GROUP BY -> 전체 ROW대상

--ROLLUP은 컬럼 순서가 조회 결과에 영향을 미친다
GROUP BY ROLLUP(deptno, job);
--GROUP BY deptno, job
--GROUP BY deptno
--GROUP BY -> 전체 ROW대상
--오른쪽부터 지워감


SELECT job, deptno, SUM(sal+ NVL(comm, 0)) sal_sum
FROM emp
GROUP BY ROLLUP(job, deptno)
ORDER BY ;

--합계 NULL->합계 로 정정
SELECT NVL(job,'총계'), deptno, SUM(sal+ NVL(comm, 0)) sal_sum
FROM emp
GROUP BY ROLLUP(job, deptno);
--또는
SELECT DECODE(GROUPING (job), 1, '총계', job) job, 
       deptno, SUM(sal+ NVL(comm, 0)) sal_sum
FROM emp
GROUP BY ROLLUP(job, deptno);


SELECT DECODE(GROUPING (job), 1, '총', job) job, 
       CASE
            WHEN deptno IS NULL AND job IS NULL THEN '계'
            WHEN deptno IS NULL AND job IS NOT NULL THEN '소계'
            ELSE '' || deptno
        END deptno,
        
       SUM(sal+ NVL(comm, 0)) sal_sum
FROM emp
GROUP BY ROLLUP(job, deptno);

--또는
SELECT DECODE(GROUPING (job), 1, '총', job) job, 
       DECODE(GROUPING(deptno) + GROUPING(job), 2, '계', 1, '소계', deptno) deptno ,
       SUM(sal+ NVL(comm, 0)) sal_sum
FROM emp
GROUP BY ROLLUP(job, deptno);



SELECT *
FROM emp;

--AD3
SELECT deptno, job, SUM(sal+ NVL(comm, 0)) sal_sum
FROM emp
GROUP BY ROLLUP(deptno, job);
--또는 
SELECT deptno,
       DECODE(GROUPING(job), 1, null, job) job,
       SUM(sal+ NVL(comm, 0)) sal
FROM emp
GROUP BY ROLLUP(deptno, job); 

--UNION ALL로 전환
SELECT deptno, job, SUM(sal + NVL(comm, 0)) sal_sum
FROM emp
GROUP BY deptno, job
UNION ALL
SELECT deptno, null, SUM(sal + NVL(comm, 0))sal_sum
FROM emp
GROUP BY deptno
UNION ALL
SELECT null, null, SUM(sal + NVL(comm, 0)) sal_sum
FROM emp;

--AD4
SELECT dname, job, SUM(sal+ NVL(comm, 0)) sal
FROM emp, dept
WHERE emp.deptno = dept.deptno
GROUP BY ROLLUP(dname, job)
ORDER BY dname;

SELECT dname, job, sal
FROM (SELECT deptno, job, SUM(sal + NVL(comm, 0) sal
      FROM emp
      GROUP BY ROLLUP(deptno, job))a, dept
WHERE a.deptno = dept.deptno
GROUP BY ROLLUP(dname, job); --미완성

--AD5
SELECT DECODE(GROUPING (dname), 1, '총합', dname) dname, job, SUM(sal+ NVL(comm, 0)) sal
FROM emp, dept
WHERE emp.deptno = dept.deptno
GROUP BY ROLLUP(dname, job)
ORDER BY dname;




SELECT *
FROM emp;
SELECT *
FROM dept;
DELETE dept
WHERE deptno=99; 
