
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
    
    
   --테이블에서  ename컬럼 기준으로 오름차순 정렬했을때 11~14번째 행의 데이터만 조회하는 sql을 작성하라 
    SELECT ROWNUM rn, empno, ename
    FROM (
    SELECT rn, a*
    FROM 
        (SELECT empno, ename
         FROM emp
         ORDER BY ename)a)
    WHERE rn BETWEEN 11 AND 20;
    
    SELECT empno, ename
    FROM emp
    WHERE ROWNM  BETWEEN 1 AND 10;
    
    --DUAL 테이블 : sys계정에 있는 누구나 사용가능한 테이블이며 
    --데이터는 한 행만 존재, 컬럼(dummy)도 하나 존재 'X')
    
    SELECT *
    FROM dual;
    
    --SINGLE FOW FUCTION : 행당 한번의 FUNCTION이 실행
    --1개의 행 INPUT -> 1개의 행으로 OUTPUT (COLUM)
    -- 'Hello, World'
    --dual테이블에는 데이터가 하나의 행만 존재함 결과도 하나의 행으로 나옴
    
    SELECT LOWER ('Hello, World') low, UPPER ('Hello, World') upper, INICAP ('Hello, World') ini
    FROM dual;
    --emp테이블에는 총 14건의 데이터(직원)가 존재(14)
    --아래쿼리는 결과도 14개의 행
    SELECT LOWER ('Hello, World') low , UPPER ('Hello, World') upper , INICAP ('Hello, World') 
    FROM emp;
    
    --컬럼에 function 적용
    SELECT empno,LOWER (ename) low_enm
    FROM emp
    WHERE ename = UPPER('smith'); --직원 이름이 smith인 사람을 조회하려면 대문자/소문자?
    --테이블 컬럼을 가공해도 동일한 결과를 얻을 수는 있지만.
    --테이블 컬럼보다는 상수쪽을 가공하는게 속도면에서 유리
    --해당 컬럼에 인덱스가 존재하더라도 함수를 적용하게되면 값이 달라지게 되어
    --인덱스를 활용 할 수 없게 된다
    --예외 : FBI(Function Based Index)
    
    SELECT UPPER('smith')
    FROM dual;
    
    --'HELLO'
    --','
    --'WORLD'
    --HELLO, WORLD (위 3가지 문자열 상수를 이용, CONCAT 함수를 사용하여 문자열 결합)
    SELECT CONCAT(CONCAT('HELLO', ','), 'WORLD') c1,
          'HELLO' || ', ' || 'WORLD' c2,
        
    --시작인덱스는 1부터 종료인덱스 문자열까지 포함됨
          SUBSTR ('HELLO, WORLD',1 ,5) s1, --SUBSTR(문자열, 시작인덱스, 종료인덱스)
    
    --INSTR : 문자열에 특정 문자열이 존재하는지, 존재할 경우 문자의 인덱스를 리턴
    INSTR('HELLO, WORLD', 'O') i1,  --5, 9
    -- 'HELLO, WORLD' 문자열의 6번째 인덱스 이후에 등장하는 'o'문자열의 인덱스 리턴
    INSTR('HELLO, WORLD', 'O',6) i2,  --문자열의 특정 인덱스 이후부터 검색하도록 옵션
    INSTR ('HELLO, WORLD', 'O',INSTR('HELLO, WORLD', 'O') +1) i3,
    
    --L/RPAD 특정 문자열의 왼쪽/오른쪽에 설정한 문자열 길이보다 부족한 만큼 문자열을 채워 넣는다
    LPAD('HELLO, WORLD', 15, '*')L1,
    RPAD('HELLO, WORLD', 15, '*')R1,
    
    --REPLACE (대상문자열, 검색 문자열, 변경할 문자열)
    --대상문자열에서 검색 문자열을 변경할 문자열로 치환
    REPLACE ('HELLO, WORLD', 'HELLO', 'hello') repl,
    
    --문자열 앞, 뒤의 공백을 제거
    '   HELLO, WORLD   ' before_trim,
    TRIM('   HELLO, WORLD   ') after_trim,
    TRIM('H' FROM 'HELLO, WORLD') after_trim2

FROM dual;


--숫자 조작함수
--ROUND : 반올림 - ROUND (숫자, 반올림 자리)
--TRUNC : 절삭 - TRUNC (숫자, 절삭 자리)
--MOD : 나머지 연산 MOD (피제수, 제수) // MOD(5, 2) : 1

SELECT --반올림결과가 소수점 한자리까지 노오도록(소수점 둘째자리에서 반올림)
        ROUND(105.54,1) r1,
        ROUND(105.55,1) r2,
        ROUND(105.55,0) r3, --소수점 첫번째 자리에서 반올림 
        ROUND(105.55,-1) r4 --정수첫번째 자리에서 반올림
FROM dual;

SELECT --반올림결과가 소수점 한자리까지 노오도록(소수점 둘째자리에서 반올림)
        TRUNC(105.54,1) t1,
        TRUNC(105.55,1) t2,
        TRUNC(105.55,0) t3, --소수점 첫번째 자리에서 절삭
        TRUNC(105.55,-1) t4 --정수첫번째 자리에서 절삭
FROM dual;

--MOD (피제수, 제수) 피제수를 제수로 나눈 나머지 값
--MOD(M, 2)의 결과 종류 : 0, 1 (0~제수-1) 
SELECT MOD(5, 2) M1 -- 5/2 = : 몫이 2, [나머지가 1]
FROM dual;

--emp테이블의 sal컬럼을 1000으로 나눴을때 사원별 나머지 값을 조회하는 sql작성
--ename, sal, sal/1000을 때의 몫, sal/1000을 때의 나머지
--3500 : 3, 500
--5000 : 5, 0
--1600 : 1, 600
SELECT ename, sal, /*sal/1000으로 나눈 몫*/ TRUNC(sal/1000), MOD(sal, 1000)
        TRUNC(sal/1000) * 1000, MOD(sal, 1000) sal2
FROM emp;
--DATE : 년월일, 시간, 분, 초
SELECT ename, TO_CHAR(hiredate, 'YYYY/MM/DD hh24:ss')  --YYYY/MM/DD
FROM emp;

--SYSCATE : *서버의 현재* DATE를 리턴한느 내장함수, 특별한 인자가 없다
--DATE 연산 DATE + 정수N = DATE에 N일자 만큼 더한다
--DATE 연산에 있어 정수는 일자
--하루 =24시간
--DATE 타임에 시간을 더할 수 도 있다 (1시간=1/24)
SELECT TO_CHAR(SYSDATE +5, 'YYYY-MM-DD hh24:mi:ss') AFTER_DAYS,
       TO_CHAR(SYSDATE +5/24, 'YYYY-MM-DD hh24:mi:ss') AFTER_HOURS,
       TO_CHAR(SYSDATE +5/24/60, 'YYYY-MM-DD hh24:mi:ss') AFTER_MINS
       
FROM dual;

SELECT TO_DATE(2019/12/31,'YYYY/MM/DD')LAST_DAY,
       TO_DATE(2019/12/31, 'YYYY/MM/DD') -5 LAST_DAY_BEFORE5,
       SYSDATE NOW,
       SYSDATE -3 NOW_BEFORE3 
       
FROM dual;

--YYYY, MM, DD, D(요일을 숫자로 : 일요일1, 월요일 2, 화요일 3....토요일 7)
--IW(주차 1~53), HH, MI, SS
SELECT TO_CHAR(SYSDATE, 'YYYY')  --현재년도
    ,TO_CHAR(SYSDATE, 'MM') --현재월
    ,TO_CHAR(SYSDATE, 'DD') --현재일
    ,TO_CHAR(SYSDATE, 'D')  --현재 요일(주간일자1~7)
    ,TO_CHAR(SYSDATE, 'IW') --현재 일자의 주차(해당 주의 목요일을 주차의 기준으로)
--2019년 12월 31일은 몇주차?
    TO_CHAR(TO_DATE('20191231', 'YYYYMMDD'), 'IW') IW_20191231
FROM dual;

SELECT TO_CHAR(SYSDATE 'YYYYMMDD') dt_dash
       TO_CHAR(SYSDATE 'YYYYMMDD HH24:MI:SS') dt_dash_with_time
       TO_CHAR(SYSDATE,'DDMMYYYY') dt_dash_dd_mm_yy
FROM dual;

--DATE타입의 ROUND, TRUNC 적용
SELECT TO_CHAR(SYSDATE, 'YYYY-MM-DD hh24:mi:ss') now
        --MM에서 반올림 (11월 -> 1년)
      ,TO_CHAR(ROUND(SYSDATE, 'YYYY'), 'YYYY-MM-DD hh24:mi:ss) now_YYYY
        --DD에서 반올림 (25 -> 1개월)
        ,TO_CHAR(ROUND(SYSDATE, 'MM'), 'YYYY-MM-DD hh24:mi:ss) now_MM
        --시간에서 절삭(현재시간 -> 0시) 
        ,TO_CHAR(ROUND(SYSDATE, 'DD'), 'YYYY-MM-DD hh24:mi:ss) now_DD
FROM dual;

--날짜 조작 함수
--MONTH_BETWEEN(date1, date2) : date2와 date1 사이의 개월 수
--ADD_MONTHS(date, 가감할 개월 수) : date에서 특정 개월 수를 더하거나 뺀 날짜
--NEXT_DAY(date, weekday(1~7) : date이후 첫번째 weekday 날짜
--LAST_DAY(date) : date가 속한 월의 마지막 날짜
  
--MONTHS_DETWEEN(date1, date2)
SELECT MONTHS_BETWEEN(TO_DATE('2019-11-25, 'YYYY-MM-DD'),
        TO_DATE('2019-03-31, 'YYYY-MM-DD')) m_bet,
        TO_DATE('2019-03-31', 'YYYY-MM-DD) d_m --두 날짜 사이의 일자수
FROM dual;

--ADD_MONTH(date, number(+,-) )
SELECT ADD_MONTH (TO_DATE('20191125', 'YYYYMMDD'), 5) NOW_AFTER5M
      ,ADD_MONTH (TO_DATE('20191125', 'YYYYMMDD'), -5) NOW_BEFORE5M
      , SYSDATE + 100 --100일 뒤의 날짜 (월 개념 3/31, 2/28 or 29)
FROM dual;

--NEXT_DAY(dawte, weekday number(1~7))
SELECT NEXT_DAY(SYSDATE, 1) --오늘날짜 (2019/11/25)일 이후 등장하는 첫번째 토요일
FROM dual;

    
    
    
    
    
    
    
    