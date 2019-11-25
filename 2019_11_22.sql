
SELECT *
FROM emp
WHERE DEPTNO <> 10  AND HIREDATE >= TO_DATE('19810601', 'YYYYMMDD');
-- <>, != :아니다

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

 --LIKE연산 사용 X
 --전제조건 : EMPNO가 숫자여야함 (DESC emp.empno NUMBER)
SELECT *
FROM emp
WHERE JOB = 'SALESMAN' OR EMPNO  BETWEEN 7800 AND 7899;

--연산자 우선순위 (AND > OR)
SELECT *
FROM emp
WHERE ename = 'SMITH' OR ename = 'ALLEN'
AND job = 'SLAESMAN';

SELECT *
FROM emp
WHERE ename = 'SMITH' 
OR (ename = 'ALLEN' AND job = 'SLAESMAN');

--직원 이름이 SMITH이거나 ALLEN이면서 역할이 SALESMAN인 사람
SELECT *
FROM emp
WHERE (ename = 'SMITH' OR ename = 'ALLEN') AND job = 'SALESMAN';

SELECT *
FROM emp
WHERE job = 'SALESMAN' OR (empno LIKE '78%' AND HIREDATE > TO_DATE('1981-06-01', 'YYYY-MM-DD'));

--데이터 정렬
-- 10, 5, 3, 2, 1

--오름차순 : 1, 2, 3, 5, 10
--내림차순 : 10, 5, 3, 2, 1

--오름차순 : ASC (표기를 안할경우 기본값)
--내림차순 : DESC ( 반드시 표기)

/* 
    SELECT col1, col2
    FROM 테이블명
    WHERE col1 - '값'
    ORDER BY 정렬기준컬럼1 [ASC / DESC], 정렬기준컬럼2... [ASC / DESC ]
    
    */
    
    SELECT *
    FROM emp
    ORDER BY ename ASC; --정렬기분을 작성하지 않을 시 오름차순 적용
    
    SELECT *
    FROM emp
    ORDER BY ename DESC;
    
    --사원(emp) 테이블에서 직원의 정보를 부서번호로 오름차순 정렬,
    --부서번호가 같은 떄는 sal 내림차순(DESC)으로 정렬
    --급여(sal)가 같을때는 이름으로 오름차순(ASC) 정렬한다
    SELECT * 
    FROM emp
    ORDER BY deptno, sal DESC, ename;
    
    --정렬 컬럼을 ALIAS로 표현
    SELECT deptno, sal, ename nm
    FROM emp
    ORDER BY nm;
    
    --조회하는 컬럼의 위치 인덕스로 표현 가능
    SELECT deptno, sal, ename nm
    FROM emp
    ORDER BY 3; --비추 해당쿼리가 바뀔 가능성 HIGH (컬럼 추가시 의도하지 않은 결과 초래)
    
    --실습 1 P74
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
    WHERE ROWNUM = 2;  -- ROWNUM을 1부터 순차적 조회하는 경우는 가능 (<=, <)
    
    SELECT ROWNUM, empno, ename
    FROM emp
    WHERE ROWNUM BETWEEN 1 AND 20; -- 1부터 시작하는 경우 가능
    
    --SELECT절과 ORDER BY 구문의 실행순서
    --SELECT -> ROWNUM -> ORDER BY
    SELECT ROWNUM, empno, ename
    FROM emp
    ORDER BY ename;
    
    --INLINE VIEW를 통해 정렬 먼저 실행 -> 해당 결과에 ROWNUM을 적용
    --*를 표현하고, 다른 컬럼|표현식을 썼을 경우 *앞에 테이블명이나, 테이블 별칭을 적용
    SELECT ROWNUM, a.*
    FROM (SELECT empno, ename
    FROM emp
    ORDER BY ename) a;
    
    SELECT e.*
    FROM emp e;
    
    SELECT rn, empno, ename
    FROM emp
    WHERE ROWNUM <= 10;
    
    --ROWNUM이 11~14인 데이터
    SELECT a.*
    FROM 
    (SELECT ROWNUM rn, empno, ename
    FROM emp
    WHERE ROWNUM  BETWEEN 1 AND 14) a
    WHERE rn BETWEEN 11 AND 20;
    
    --emp테이블에서 ename 으로 정렬한 결과에 11번째행과 14번째행만 조회하는 쿼리를 작성하라
    SELECT a.*, empno, ename
    FROM
    (SELECT ROWNUM rn, empno, ename
    FROM emp
    WHERE ROWNUM BETWEEN 1 AND 14
    ORDER BY ename) a
    WHERE rn BETWEEN 11 AND 20;
    
    
    
    SELECT ROWNUM rn, aa.*
    FROM (
    SELECT a.*
    FROM
    (SELECT empno, ename
    FROM emp
    ORDER BY ename)a
    WHERE ROWNUM BETWEEN 1 AND 14) aa
    WHERE ROWNUM BETWEEN 11 AND 20;
    

    
    
    
    
    
    
    
    