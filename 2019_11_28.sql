--emp테이블, dept 테이블 조인
EXPLAIN PLAN FOR
SELECT ename, emp.deptno, dept.dname
FROM emp, dept
WHERE emp.deptno = dept.deptno
AND emp.deptno =10;

SELECT *
FROM TABLE(DBMS_XPLAN.DISPLAY);
Plan hash value: 615168685
 
---------------------------------------------------------------------------
| Id  | Operation          | Name | Rows  | Bytes | Cost (%CPU)| Time     |
---------------------------------------------------------------------------
|   0 | SELECT STATEMENT   |      |    14 |   308 |     7  (15)| 00:00:01 |
|*  1 |  HASH JOIN         |      |    14 |   308 |     7  (15)| 00:00:01 |
|   2 |   TABLE ACCESS FULL| DEPT |     4 |    52 |     3   (0)| 00:00:01 |
|   3 |   TABLE ACCESS FULL| EMP  |    14 |   126 |     3   (0)| 00:00:01 |
---------------------------------------------------------------------------
 2-3-1-0 순서 -> 0(1(2,3))
Predicate Information (identified by operation id):
---------------------------------------------------
 
   1 - access("EMP"."DEPTNO"="DEPT"."DEPTNO")
   2 - filter("DEPT"."DEPTNO"=10)
   3 - filter("EMP"."DEPTNO"=10)
   
SELECT ename, emp.deptno, dept.dname
FROM emp, dept
WHERE emp.deptno != dept.deptno --empdept은 10이지만 dept.deptno는 10 제외한 20, 30, 40의 DNAME
AND emp.deptno =10;

--natural join : 조인 테이블간 같은 타입, 같은 이름의 컬럼으로 같은 값을 갖을 경우 조인

DESC emp;
DESC dept;

--ANSI SQL
SELECT deptno, a.empno, ename
FROM emp a NATURAL JOIN dept b;

ALTER TABLE emp DROP COLUMN dname;

--Oracle 문법
SELECT a.deptno, a.empno, ename
FROM emp a, dept b
WHERE a.deptno = b.deptno;
--column ambiguously define 별칭이나 ?가 모호하게 되어있을때 나타나는 에러 문구

--JOIN USING
--join 하려고 하는 테이블간 동일한 이름의 컬럼이 두개 이상일때
--join 컬럼을 하나만 사용하고 싶을 때

--ANSI SQL
SELECT
FROM emp JOIN dept USING (deptno);

--Oracle SQL
SELECT *
FROM emp, dept
WHERE emp.deptno = dept.deptno;

SELECT *
FROM emp, dept;

SELECT *
FROM emp, dept
WHERE emp.deptno = dept.deptno;

--ANSI JOIN with ON
--조인 하고자 하는 테이블의 컬럼 이름이 다를때
--개발자가 조인 조건을 직접 제어할 때

SELECT *
FROM emp JOIN dept ON (emp.deptno = dept.deptno)
WHERE emp.deptno = 10;

--Oracle
SELECT *
FROM emp, dept
WHERE emp.deptno = dept.deptno;

--SELF JOIN : 같은 테이블간 조인
--emp 테이블간 조인 할만한 사항 : 직원의 관리자 정보 조회
--직원의 관리자 정보를 조회
--직원이름, 관리자 이름

--ANSI
SELECT e.ename, m.ename 
FROM emp e JOIN emp m ON(e.mgr = m.empno);

--Oracle
SELECT e.ename, m.ename
FROM emp e, emp m
WHERE e.mgr = m.empno;

----직원 이름, 직원의 관리자 이름, 직원의 관리자의 상급자 이름
SELECT e.ename, m.ename, t.ename
FROM emp e, emp m , emp t
WHERE e.mgr = m.empno
AND m.mgr = t.empno;

--직원 이름, 직원의 상급자 이름, 직원의 상급자의 상급자 이름, 직원 관리자의 관리자의 관리자의 이름
SELECT e.ename, m.ename, t.ename, p.ename
FROM emp e, emp m , emp t, emp p
WHERE e.mgr = m.empno
AND m.mgr = t.empno
AND t.mgr = p.empno;

--여러테이블을 ANSI JOIN을 이용한 JOIN
SELECT e.ename, m.ename, t.ename, p.ename
FROM emp e JOIN emp m ON (e.mgr = m.empno)
    JOIN emp t ON (m.mgr = t.empno)
        JOIN emp p ON (t.mgr = p.empno);
        
--직원의 이름과 해당 직원의 상사 이름을 조회
--단, 직원의 사번이 7369~7698인 직원 대상으로 조회

--Oracle
SELECT a.ename, b.ename
FROM emp a, emp b
WHERE a.mgr = b.empno
AND a.empno BETWEEN 7369 AND 7698;

--ANSI
SELECT s.ename, m.ename
FROM emp s JOIN emp m ON(s.mgr = m.empno)
WHERE s.empno BETWEEN 7369 AND 7698;

--NON-EQUI JOIN : 조인 조건이 =(equal)이 아닌 JOIN
--!=, BETWEEN___ AND___

SELECT *
FROM salgrade;

SELECT empno, ename, sal /* 급여 grade */
FORM emp;

SELECT empno, ename, sal, grade
FROM emp, salgrade

WHERE emp.sal BETWEEN salgrade.losal AND salgrade.hisal;

WHERE emp.sal>= salgrade.losal 
AND emp.sal <= salgrade.hisal;

--ANSI
SELECT empno, ename, sal, grade
FROM emp JOIN salgrade ON emp.sal BETWEEN salgrade.losal AND salgrade.hisal;

--test1
SELECT empno, ename, deptno
FROM emp;
SELECT *
FROM dept;

SELECT emp.empno, emp.ename, emp.deptno, dept.dname
FROM emp, dept
WHERE emp.deptno = dept.deptno
ORDER BY deptno;

--test2
SELECT x.*
FROM
(SELECT empno, ename, sal, emp.deptno, dept.dname
FROM emp, dept
WHERE emp.deptno = dept.deptno) x
WHERE x.deptno = 10 OR x.deptno = 30;

SELECT empno, ename, sal, emp.deptno, dept.dname
FROM emp, dept
WHERE emp.deptno = dept.deptno
AND emp.deptno IN (10, 30);

--test3
SELECT empno, ename, sal, emp.deptno, dept.dname
FROM emp, dept
WHERE sal >= 2500;

SELECT empno, ename, sal, emp.deptno, dept.dname
FROM emp JOIN dept ON emp.sal >= 2500;

--test4
SELECT empno, ename, sal, emp.deptno, dept.dname
FROM emp, dept
WHERE sal >=2500 AND empno > 7600;

SELECT empno, ename, sal, emp.deptno, dept.dname
FROM emp JOIN dept ON emp.sal >= 2500 AND empno > 7600;
        


