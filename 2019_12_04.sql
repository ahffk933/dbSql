SELECT t.rn, t.sido, t.sigungu, han.도시발전지수, t.people, t.sal, cal_sal
FROM

    (SELECT ROWNUM rn, sido, sigungu,도시발전지수
    FROM
        (SELECT a.sido, a.sigungu, ROUND(a.cnt/han.cnt,1) as 도시발전지수
        FROM
            (SELECT sido, sigungu, COUNT(*)cnt 
            FROM fastfood
            WHERE gb IN('버거킹', 'KFC', '맥도날드')
            GROUP BY sido, sigungu) a,

            (SELECT sido, sigungu, COUNT(*)cnt
            FROM fastfood
            WHERE gb IN ('롯데리아')
            GROUP BY sido, sigungu) han,

    
    (SELECT ROWNUM rn, t.sido, t.sigungu, sal, people, ROUND(sal/people, 1) cal_sal
    FROM tax
    ORDER BY cal_sal DESC) t

WHERE t.sido = han.sido(+)
AND t.sigungu = han. sigungu(+)
ORDER BY rn DESC;





SELECT ROWNUM rn, sido, sigungu, 인당연말정산신고액
FROM
    (SELECT sido, sigungu, ROUND(sal/people, 2) as 인당연말정산신고액
     FROM tax
     ORDER BY 인당연말정산신고액 DESC);


SELECT ROWNUM rn, sido, sigungu, cal_sal
FROM 
(SELECT sido, sigungu, sal, people, ROUND(sal/people, 1) cal_sal
FROM tax
ORDER BY cal_sal DESC);

UPDATE tax SET PEOPLE = 70391
WHERE SIDO = '대전광역시'
AND SIGUNGU = '동구';
COMMIT;










SELECT *
FROM

(SELECT ROWNUM rn, sido, sigungu, 도시발전지수
FROM
    (SELECT a.sido, a.sigungu, ROUND( a.cnt/ b.cnt, 1) as 도시발전지수
    FROM
        (SELECT sido, sigungu, COUNT(*) cnt --버거킹, KFC, 맥도날드 건수
        FROM fastfood
        WHERE gb IN ('버거킹', 'KFC', '맥도날드')
        GROUP BY sido, sigungu) a,


        (SELECT sido, sigungu, COUNT(*) cnt --롯데리아 건수
        FROM fastfood
        WHERE gb = '롯데리아'
        GROUP BY sido, sigungu) b
       
        WHERE a.sido = b.sido
        AND a.sigungu = b.sigungu
        ORDER BY 도시발전지수 DESC)) han,
        
        
        (SELECT ROWNUM rn, sido, sigungu, cal_sal as 인당연말정산신고액
        FROM 
            (SELECT sido, sigungu, sal, people, ROUND(sal/people, 1) cal_sal
            FROM tax
    ORDER BY cal_sal DESC)) na
   
    WHERE na.rn = han.rn(+)
    ORDER BY na.rn;
    
    

--도시발전지수 시도, 시군구와 연말정산 납입금액의 시도, 시군구가 같은 지역까리 조인
--정렬순서 tax table의 id column순으로 정렬
-- 서울특별시   강남구  5.6  서울특별시   강남구  70.3
SELECT na.id, na.sido, na.sigungu, 도시발전지수, han.sido, han.sigungu, 인당연말정산신고액 
FROM

(SELECT ROWNUM rn, sido, sigungu, 도시발전지수
FROM
    (SELECT a.sido, a.sigungu, ROUND( a.cnt/ b.cnt, 1) as 도시발전지수
    FROM
        (SELECT sido, sigungu, COUNT(*) cnt --버거킹, KFC, 맥도날드 건수
        FROM fastfood
        WHERE gb IN ('버거킹', 'KFC', '맥도날드')
        GROUP BY sido, sigungu) a,


        (SELECT sido, sigungu, COUNT(*) cnt --롯데리아 건수
        FROM fastfood
        WHERE gb = '롯데리아'
        GROUP BY sido, sigungu) b
       
        WHERE a.sido = b.sido
        AND a.sigungu = b.sigungu
        ORDER BY 도시발전지수 DESC)) han,
        
        
        (SELECT id, ROWNUM rn, sido, sigungu, cal_sal as 인당연말정산신고액
        FROM 
            (SELECT id, sido, sigungu, sal, people, ROUND(sal/people, 1) cal_sal
            FROM tax
    ORDER BY cal_sal DESC)) na
   
    WHERE han.sido(+) = na.sido
    AND han.sigungu(+) = na.sigungu
    ORDER BY na.id;
    
    
    
--SMITH가 속한 부서 찾기 ->20
SELECT deptno
FROM emp
WHERE ename = 'SMITH';

SELECT *
FROM emp
WHERE deptno = 20; 

SELECT *
FROM emp
WHERE deptno = (SELECT deptno
                FROM emp
                WHERE ename = 'SMITH');  --서브쿼리
                
SELECT empno, ename, deptno, (SELECT dname FROM dept WHERE dept.deptno = emp.deptno) dname
FROM emp;

--SCALAR SUBQUERY
--SELECT 절에 표현된 서브쿼리
--한 행, 한 COLUMN을 조회해야한다
SELECT empno, ename, deptno, (SELECT dname FROM dept) dname
FROM emp;

--INLINE VIEW
--FROM절에 사용되는 서브쿼리

--SUBQUERY
--WHERE절에 사용되는 서브쿼리

--test1
SELECT COUNT(*) cnt
FROM emp
WHERE sal > (SELECT AVG(sal)
             FROM emp);

--test2
SELECT *
FROM emp
WHERE sal > (SELECT AVG(sal) FROM emp); 

SELECT *
FROM emp
WHERE deptno IN (SELECT deptno FROM emp WHERE ename IN ('SMITH', 'WARD')); 
--"IN"사용

--SMITH나 WARD 보다 급여을 적게 받는 직원 조회
SELECT *
FROM emp
WHERE sal <= ANY 
            (SELECT sal  --800, 1250 -> 1250보다 작은사람
             FROM emp 
             WHERE ename IN('SMITH', 'WARD'));

SELECT *
FROM emp
WHERE sal < ALL 
            (SELECT sal  --800, 1250 -> 800보다 작은사람 (응~ 없오)
             FROM emp 
             WHERE ename IN('SMITH', 'WARD'));
             
--관리자 역할을 하지 않는 사원 정보 조회
--NOT IN연산자 사용시 NULL이 데이터에 존재하지 않아야 정상동작 한다
SELECT *
FROM emp --사원정보 조회 -> 관리자역할을 하지 않는
WHERE empno NOT IN 
            (SELECT NVL(mgr, -1) --NULL값을 존재하지 않을만한 데이터로 치환
             FROM emp);

SELECT *
FROM emp --사원정보 조회 -> 관리자역할을 하지 않는
WHERE empno NOT IN 
            (SELECT mgr 
             FROM emp
             WHERE mgr IS NOT NULL); --WHERE절에 IS NOT NULL로도 사용가능

--pairwise (여러 컬럼의 값을 동시에 만족해야하는 경우)             
--ALLEN, CLARK의 매니저와 부서번호가 동시에 같은 사원 정보조회
--(7698, 30)
--(7839, 10)
SELECT *
FROM emp
WHERE (mgr, deptno) IN (SELECT mgr, deptno
                        FROM emp
                        WHERE empno IN (7499, 7782));


--매니저가 7698이거나 7839이면서,
--소속부서가 10번이거나 30번인 직원 정보조회
--7698, 10
--7698, 30
--7839, 10
--7839, 30
--non pairwise--
SELECT *
FROM emp
WHERE mgr IN (SELECT mgr
                        FROM emp
                        WHERE empno IN (7499, 7782))   
AND deptno IN (SELECT deptno
               FROM emp
               WHERE empno IN (7699,7782));
               
--비상호 연관 서브 쿼리
--메인쿼리의 컬럼을 서브쿼리에서 사용하지 않는 형태의 서브 쿼리

--비상호 연관 서브쿼리의 경우 메인쿼리에서 사용하는 테이블, 서브쿼리 조회순서를 성능적으로 유리한 쪽으로 판단하여 순서를 결정한다
--메인쿼리의 emp테이블을 먼저 읽을 수도 있고, 서브쿼리의 emp테이블을 먼저 읽을 수도 있다

--비상호 연관 서브쿼리에서 서브쿼리쪽 테이블을 먼저 읽을 때는 서브쿼리가 '제공자역할'을 했다 라고 모 도서에서 표현
--비상호 연관 서브쿼리에서 서브쿼리쪽 테이블을 나중에 읽을 때는 서브쿼리가 '확인자 역할'을 했다 라고 모 도서에서 표현

--직원의 급여 평균보다 높은 급여를 받는 직원정보 조회
--직원의 급여 평균
SELECT *
FROM emp
WHERE sal > (SELECT AVG(sal)
             FROM emp);
   
--상호연관 서브쿼리
--해당직원이 속한 부서의 급여평균보다 높은 급여를 받는 직원 조회
SELECT *
FROM emp m
WHERE sal > (SELECT AVG(sal)
             FROM emp
             WHERE deptno = m.deptno);

--10번 부서의 급여평균
SELECT AVG(sal)
FROM emp
WHERE deptno = 10;

SELECT deptno, ROUND(AVG(sal), 2)
FROM emp
GROUP BY deptno
ORDER BY deptno;
