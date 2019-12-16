--GROUPINT SETS(col1, col2)
--다음과 결과가 동일
--개발자가 GTOUP BY의 기준을 직접 명시한다
--ROLL UP과 달리 방향성을 가지 않는다
--GROUPING SET(col1, col2) = GROUPTING SETS(col2, col1)


--GROUP BY col1
--UNION ALL
--GOUP BY col2

--emp테이블에서 직원의 job별 급여(sal) + 상여(comm)합,
--                   dept(부서)별 급여(sal) + 상여(comm)합 구하기
--기존 방식(GROUP FUNCTION) : 2번의 SQL작성 필요(UNION / UNION ALL)

SELECT job, null deptno, SUM(sal + NVL(comm, 0)) sal_comm_sum
FROM emp
GROUP BY job
UNION ALL
SELECT '', deptno, SUM(sal + NVL(comm, 0)) sal_comm_sum
FROM emp
GROUP BY deptno; 

--GROUPING SETS구문을 이용하여 위의 SQL을 집합연산을 사용하지 않고 테이블을 한번 읽어서 처리
SELECT job, deptno, SUM(sal + NVL(comm, 0 )) sal_comm_sum
FROM emp
GROUP BY GROUPING SETS (job, deptno);

--job, deptno를 그룹으로 한 sal+comm 합
--mgr를 그룹으로 한 sal+comm 합
--GROUP BY job, deptno
--UNION ALL
--GROUP BY mgr
-- -> GROUPING SETS((job, deptno), mgr)
--null값 주의~!
SELECT job, deptno, mgr, SUM(sal + NVL(comm, 0)) sal_comm_sum,
       GROUPING(job), GROUPING(deptno), GROUPING(mgr)
FROM emp
GROUP BY GROUPING SETS ((job, deptno), mgr);

--CUBE (col1, col2 ...)
--나열된 컬럼의 모든 가능한 조합으로 GROUP BY subset을 만든다
--CUBE에 나열된 컬럼이 2개인 경우 : 가능한 조합 4개
--CUBE에 나열된 컬럼이 2개인 경우 : 가능한 조합 8개
--CUBE에 나열된 컬럼 수를 2의 제곱승 한 결과가 가능한 조합 개수가 된다 (2^n)
--컬럼이 조금만 많아져도 가능한 조합이 기하급수적으로 늘어나기 때문에 많이 사용하지 않는다

--job, deptno를 이용하여 CUBE적용
SELECT job, deptno, SUM(sal + NVL(comm, 0 )) sal_comm_sum
FROM emp
GROUP BY CUBE(job, deptno);
--job, deptno
--1, 1 -> GROUP BY job, deptno
--1, 0 -> GROUP BY job
--0, 1 -> GROUP BY deptno
--0, 0 -> GROUP BY --emp테이블의 모든행에 대해 GROUP BY

--GROUP BY 응용
--GROUP BY, ROLLUP, CUBE를 섞어 사용하기
--가능한 조합을 생각해보면 쉽게 결과를 예측할 수 있다
--GROUP BY job, rollup(deptno), cube(mgr)

SELECT job, deptno, mgr, SUM(sal + NVL(comm, 0)) sal_comm_sum
FROM emp
GROUP BY job, ROLLUP(deptno), CUBE(mgr);

SELECT job, SUM(sal)
FROM emp
GROUP BY job;


--test1
DROP TABLE dept_test;

CREATE TABLE dept_test AS               --테이블 생성
SELECT *
FROM emp;

ALTER TABLE dept_test ADD(empcnt NUMBER(6));   --컬럼추가

UPDATE dept_test SET empcnt = (SELECT count(*)     --업데이트 --(eg.부서별 인원수..서브쿼리 WHERE ??)
                              FROM emp
                              WHERE emp.deptno = dept_test.deptno);
                            --GROUP BY deptno); 생략가능
SELECT *
FROM dept_test;

--test2 
CREATE TABLE dept_test AS               --테이블 생성
SELECT *
FROM dept;

INSERT INTO dept_test VALUES (99, 'IT1', 'daejeon');
INSERT INTO dept_test VALUES (98, 'IT2', 'daejeon');

SELECT *
FROM dept_test
WHERE deptno NOT IN ( SELECT deptno
                      FROM emp);
--또는
DELETE dept_test
WHERE deptno IN ( SELECT deptno
                  FROM emp);
SELECT *
FROM dept_test;

--test3
DROP TABLE emp_test;

CREATE TABLE emp_test AS
SELECT *
FROM emp;

UPDATE emp_test SET sal = sal + 200
WHERE sal <(SELECT ROUND (AVG(sal), 2)
            FROM emp
            WHERE deptno = emp_test.deptno
            );
ROLLBACK;

SELECT empno, ename, deptno, sal
FROM emp_test
ORDER BY deptno;

SELECT deptno, ROUND(AVG(sal), 2)
FROM emp
GROUP BY deptno
ORDER BY deptno;

SELECT deptno, AVG(sal)
FROM emp_test
GROUP BY deptno;

--MERGE구문을 이용한 업데이트
MERGE INTO emp_test a
USING (SELECT deptno, AVG(sal) avg_sal
FROM emp_test
GROUP BY deptno) b 
ON (a.deptno = b.deptno) 
--    AND a.sal < avg_sal)  -- ON절에 기입된 update사항 실행안됨ㅎㅎㅎ
WHEN MATCHED THEN 
    UPDATE SET sal = sal + 200
    WHERE a.sal < b.avg_sal;


ROLLBACK;

--MERGE + CASE(IF)                     
MERGE INTO emp_test a
USING (SELECT deptno, AVG(sal) avg_sal
        FROM emp_test
        GROUP BY deptno) b 
ON (a.deptno = b.deptno) 

WHEN MATCHED THEN 
    UPDATE SET sal = CASE
                        WHEN a.sal < b.avg_sal THEN sal + 200
                        ELSE sal
                        END;   