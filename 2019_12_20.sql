--hash join
SELECT *
FROM dept, emp  --사이즈가 작은 애들 먼저 읽음 오라클이
WHERE dept.deptno = emp.deptno;
--dept먼저 읽는 형태
--join컬럼을 hash함수로 돌려서 해당 해쉬 함수에 해당하는 bucket에 데이터를 넣는다
--10 -> ccc1122 (hashvalue)
--순차적인 hash값이 나온다는 보장이 읎슴
--보통 equal'='조인일 때 값이 나옴

--emp테이블에 대해 위의 진행을 동일하세 진행
--10 -> ccc1122 (hashvalue)


SELECT COUNT(*)  --emp table을 전부 다 스캔하기 전까진 결과를 알 수 없음 (sort merge)
FROM emp;



--사원번호, 사원이름, 부서번호, 급여, 부서원의 전체 급여합
SELECT empno, ename, deptno, sal,
       SUM(sal) OVER (ORDER BY sal 
       ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) c_sum, --가장처음부터 현재 행까지의 급여 합
       
       SUM(sal) OVER( ORDER BY sal
       ROWS BETWEEN 1 PRECEDING AND CURRENT ROW) c_sum2  --바로 이전 행이랑 현재 행까지의 급여 합
FROM emp
ORDER BY sal;

--TEST ana7
SELECT empno, ename, deptno, sal,
       SUM(sal) OVER (PARTITION BY DEPTNO ORDER BY sal ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) C_SUM  
FROM emp;


--ROWS vs RANGE 의 차이 확인
SELECT empno, ename, deptno, sal,
        SUM(sal) OVER (ORDER BY sal ROWS UNBOUNDED PRECEDING) row_sum,    --범위지정이 더 정확
        SUM(sal) OVER (ORDER BY sal RANGE UNBOUNDED PRECEDING) range_sum,   --컬럼값이 같은것 까지 계산을 해버림
        SUM(sal) OVER (ORDER BY sal) c_sum
FROM emp;


--PL/SQL
--PL/SQL기본 구조
--DECLARE : 선언부, 변수를 선언하는 부분
--BEGIN : PL/SQL의 로직이 들어가는 부분
--EXCEPTION : 예외처리부

--DBMS_OUTPUT.PUT_LINE함수가 출력하는 결과를 화면에 보여주도록 활성화
SET SERVEROUTPUT ON; 
DECLARE --선언부
    --java : 타입 변수명;
    --pl/sql : 변수명 타입;
   /* v_dname VARCHAR2(14);
    v_loc VARCHAR2(13); */
    --테이블 컬럼의 정의를 참조하여 데이터 타입을 선언한다
    v_dname dept.dname %TYPE;
    v_loc dept.loc %TYPE;
BEGIN
    --DEPT TABLE에서 10번 부서의 부서 이름, LOC정보를 조회
    SELECT dname, loc
    INTO v_dname, v_loc 
    FROM dept
    WHERE deptno = 10;
    --(java)
    --string a = "t";
    --String = "c";
    --sysout.out.println(a + b);
    DBMS_OUTPUT.PUT_LINE(v_dname || v_loc); 
    
END;
/  
-- / : PL/SQL블록을 실행

DESC dept;



--10번 부서의 부서이름, 위치지역을 조회해서 변수에 담고
--변수를 DBMS_OUTPUT.PUT_LINE함수를 이용하여 console에 출력
CREATE OR REPLACE PROCEDURE printdept IS
--선언부(옵션)
    dname dept.dname %TYPE;
    loc dept.loc %TYPE;
    
--실행부
BEGIN
    SELECT dname, loc
    INTO dname, loc   --into에 담아
    FROM dept
    WHERE deptno =10;
    
    DBMS_OUTPUT.PUT_LINE(dname || ' ' || loc);
--예외처리부(옵션)
END;
/

exec printdept;




CREATE OR REPLACE PROCEDURE printdept 
--파라미터명 IN/OUT 타입
--p_파라미터이름
( p_deptno IN dept.deptno %TYPE )
IS
--선언부(옵션)
    dname dept.dname %TYPE;
    loc dept.loc %TYPE;
    
--실행부
BEGIN
    SELECT dname, loc
    INTO dname, loc   --into에 담아
    FROM dept
    WHERE deptno = p_deptno;
    
    DBMS_OUTPUT.PUT_LINE(dname || ' ' || loc);
--예외처리부(옵션)
END;
/

exec printdept(30);


CREATE OR REPLACE PROCEDURE printemp
(p_empno IN emp.empno %TYPE)
IS
    ename emp.ename%TYPE;
    dname dept.dname%TYPE;
    
BEGIN
    SELECT ename, dname
    INTO ename, dname
    FROM emp, dept
    WHERE emp.empno = p_empno
    AND dept.deptno = emp.deptno;
        
    DBMS_OUTPUT.PUT_LINE(ename || ' ' || dname);
END;
/

exec printemp(7369);

SELECT *
FROM emp;

--test pro_2
CREATE OR REPLACE PROCEDURE registdept_test
(p_deptno IN dept_test.deptno%TYPE,  
 p_dname IN dept_test.dname%TYPE,
 p_loc IN dept_test.loc%TYPE)
IS 
    deptno dept_test.deptno%TYPE;
    dname dept_test.dname%TYPE;
    loc dept_test.loc%TYPE;
BEGIN 
    INSERT INTO dept_test VALUES (99, 'DDIT', 'Daejeon');
    
    DBMS_OUTPUT.PUT_LINE(deptno || ' ' || dname || ' ' || loc);
    
END;
/

exec registdept_test(99, 'ddit', 'daejeon');

SELECT *
FROM dept_test;