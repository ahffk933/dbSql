SELECT t.rn, t.sido, t.sigungu, han.���ù�������, t.people, t.sal, cal_sal
FROM

    (SELECT ROWNUM rn, sido, sigungu,���ù�������
    FROM
        (SELECT a.sido, a.sigungu, ROUND(a.cnt/han.cnt,1) as ���ù�������
        FROM
            (SELECT sido, sigungu, COUNT(*)cnt 
            FROM fastfood
            WHERE gb IN('����ŷ', 'KFC', '�Ƶ�����')
            GROUP BY sido, sigungu) a,

            (SELECT sido, sigungu, COUNT(*)cnt
            FROM fastfood
            WHERE gb IN ('�Ե�����')
            GROUP BY sido, sigungu) han,

    
    (SELECT ROWNUM rn, t.sido, t.sigungu, sal, people, ROUND(sal/people, 1) cal_sal
    FROM tax
    ORDER BY cal_sal DESC) t

WHERE t.sido = han.sido(+)
AND t.sigungu = han. sigungu(+)
ORDER BY rn DESC;





SELECT ROWNUM rn, sido, sigungu, �δ翬������Ű��
FROM
    (SELECT sido, sigungu, ROUND(sal/people, 2) as �δ翬������Ű��
     FROM tax
     ORDER BY �δ翬������Ű�� DESC);


SELECT ROWNUM rn, sido, sigungu, cal_sal
FROM 
(SELECT sido, sigungu, sal, people, ROUND(sal/people, 1) cal_sal
FROM tax
ORDER BY cal_sal DESC);

UPDATE tax SET PEOPLE = 70391
WHERE SIDO = '����������'
AND SIGUNGU = '����';
COMMIT;










SELECT *
FROM

(SELECT ROWNUM rn, sido, sigungu, ���ù�������
FROM
    (SELECT a.sido, a.sigungu, ROUND( a.cnt/ b.cnt, 1) as ���ù�������
    FROM
        (SELECT sido, sigungu, COUNT(*) cnt --����ŷ, KFC, �Ƶ����� �Ǽ�
        FROM fastfood
        WHERE gb IN ('����ŷ', 'KFC', '�Ƶ�����')
        GROUP BY sido, sigungu) a,


        (SELECT sido, sigungu, COUNT(*) cnt --�Ե����� �Ǽ�
        FROM fastfood
        WHERE gb = '�Ե�����'
        GROUP BY sido, sigungu) b
       
        WHERE a.sido = b.sido
        AND a.sigungu = b.sigungu
        ORDER BY ���ù������� DESC)) han,
        
        
        (SELECT ROWNUM rn, sido, sigungu, cal_sal as �δ翬������Ű��
        FROM 
            (SELECT sido, sigungu, sal, people, ROUND(sal/people, 1) cal_sal
            FROM tax
    ORDER BY cal_sal DESC)) na
   
    WHERE na.rn = han.rn(+)
    ORDER BY na.rn;
    
    

--���ù������� �õ�, �ñ����� �������� ���Աݾ��� �õ�, �ñ����� ���� ����� ����
--���ļ��� tax table�� id column������ ����
-- ����Ư����   ������  5.6  ����Ư����   ������  70.3
SELECT na.id, na.sido, na.sigungu, ���ù�������, han.sido, han.sigungu, �δ翬������Ű�� 
FROM

(SELECT ROWNUM rn, sido, sigungu, ���ù�������
FROM
    (SELECT a.sido, a.sigungu, ROUND( a.cnt/ b.cnt, 1) as ���ù�������
    FROM
        (SELECT sido, sigungu, COUNT(*) cnt --����ŷ, KFC, �Ƶ����� �Ǽ�
        FROM fastfood
        WHERE gb IN ('����ŷ', 'KFC', '�Ƶ�����')
        GROUP BY sido, sigungu) a,


        (SELECT sido, sigungu, COUNT(*) cnt --�Ե����� �Ǽ�
        FROM fastfood
        WHERE gb = '�Ե�����'
        GROUP BY sido, sigungu) b
       
        WHERE a.sido = b.sido
        AND a.sigungu = b.sigungu
        ORDER BY ���ù������� DESC)) han,
        
        
        (SELECT id, ROWNUM rn, sido, sigungu, cal_sal as �δ翬������Ű��
        FROM 
            (SELECT id, sido, sigungu, sal, people, ROUND(sal/people, 1) cal_sal
            FROM tax
    ORDER BY cal_sal DESC)) na
   
    WHERE han.sido(+) = na.sido
    AND han.sigungu(+) = na.sigungu
    ORDER BY na.id;
    
    
    
--SMITH�� ���� �μ� ã�� ->20
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
                WHERE ename = 'SMITH');  --��������
                
SELECT empno, ename, deptno, (SELECT dname FROM dept WHERE dept.deptno = emp.deptno) dname
FROM emp;

--SCALAR SUBQUERY
--SELECT ���� ǥ���� ��������
--�� ��, �� COLUMN�� ��ȸ�ؾ��Ѵ�
SELECT empno, ename, deptno, (SELECT dname FROM dept) dname
FROM emp;

--INLINE VIEW
--FROM���� ���Ǵ� ��������

--SUBQUERY
--WHERE���� ���Ǵ� ��������

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
--"IN"���

--SMITH�� WARD ���� �޿��� ���� �޴� ���� ��ȸ
SELECT *
FROM emp
WHERE sal <= ANY 
            (SELECT sal  --800, 1250 -> 1250���� �������
             FROM emp 
             WHERE ename IN('SMITH', 'WARD'));

SELECT *
FROM emp
WHERE sal < ALL 
            (SELECT sal  --800, 1250 -> 800���� ������� (��~ ����)
             FROM emp 
             WHERE ename IN('SMITH', 'WARD'));
             
--������ ������ ���� �ʴ� ��� ���� ��ȸ
--NOT IN������ ���� NULL�� �����Ϳ� �������� �ʾƾ� ������ �Ѵ�
SELECT *
FROM emp --������� ��ȸ -> �����ڿ����� ���� �ʴ�
WHERE empno NOT IN 
            (SELECT NVL(mgr, -1) --NULL���� �������� �������� �����ͷ� ġȯ
             FROM emp);

SELECT *
FROM emp --������� ��ȸ -> �����ڿ����� ���� �ʴ�
WHERE empno NOT IN 
            (SELECT mgr 
             FROM emp
             WHERE mgr IS NOT NULL); --WHERE���� IS NOT NULL�ε� ��밡��

--pairwise (���� �÷��� ���� ���ÿ� �����ؾ��ϴ� ���)             
--ALLEN, CLARK�� �Ŵ����� �μ���ȣ�� ���ÿ� ���� ��� ������ȸ
--(7698, 30)
--(7839, 10)
SELECT *
FROM emp
WHERE (mgr, deptno) IN (SELECT mgr, deptno
                        FROM emp
                        WHERE empno IN (7499, 7782));


--�Ŵ����� 7698�̰ų� 7839�̸鼭,
--�ҼӺμ��� 10���̰ų� 30���� ���� ������ȸ
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
               
--���ȣ ���� ���� ����
--���������� �÷��� ������������ ������� �ʴ� ������ ���� ����

--���ȣ ���� ���������� ��� ������������ ����ϴ� ���̺�, �������� ��ȸ������ ���������� ������ ������ �Ǵ��Ͽ� ������ �����Ѵ�
--���������� emp���̺��� ���� ���� ���� �ְ�, ���������� emp���̺��� ���� ���� ���� �ִ�

--���ȣ ���� ������������ ���������� ���̺��� ���� ���� ���� ���������� '�����ڿ���'�� �ߴ� ��� �� �������� ǥ��
--���ȣ ���� ������������ ���������� ���̺��� ���߿� ���� ���� ���������� 'Ȯ���� ����'�� �ߴ� ��� �� �������� ǥ��

--������ �޿� ��պ��� ���� �޿��� �޴� �������� ��ȸ
--������ �޿� ���
SELECT *
FROM emp
WHERE sal > (SELECT AVG(sal)
             FROM emp);
   
--��ȣ���� ��������
--�ش������� ���� �μ��� �޿���պ��� ���� �޿��� �޴� ���� ��ȸ
SELECT *
FROM emp m
WHERE sal > (SELECT AVG(sal)
             FROM emp
             WHERE deptno = m.deptno);

--10�� �μ��� �޿����
SELECT AVG(sal)
FROM emp
WHERE deptno = 10;

SELECT deptno, ROUND(AVG(sal), 2)
FROM emp
GROUP BY deptno
ORDER BY deptno;
