--cross join
SELECT cid, cnm, pid, pnm
FROM customer CROSS JOIN product;

SELECT *
FROM fastfood;

--���ù�������
SELECT *
FROM FASTFOOD
WHERE sido = '����������'
GROUP BY gb;

--���ù��������� ���� ������ ����
--���ù������� = (����ŷ���� + KFC���� + �Ƶ����� ����) / �Ե����� ����
--���� / �õ� / �ñ��� / ���ù������� (�Ҽ��� �Ѥ� �ڸ����� �ݿø�)
--1 / ����Ư���� / ���ʱ� / 7.5
--2 / ����Ư���� / ������ / 7.2

--�ش� �õ�, �ñ����� ��������� �Ǽ� �ʿ�
SELECT ROWNUM rn, sido, sigungu, ���ù�������
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
        ORDER BY ���ù������� DESC);




--���� �ϴٸ��� ������������������������������������������
SELECT ROWNUM rank, SUM(a)gb, sido, sigungu, ROWNUM ���ù������� 
FROM fastfood
WHERE gb IN('����ŷ', 'KFC', '�Ƶ�����')  a;
 
ORDER BY rank





--������ ������
--������ �����
--������ ����
--������ �߱�
--������ ����
SELECT *
FROM fastfood
WHERE sido ='����������'
AND sigungu ='������'  
AND gb ='�Ե�����'; -- �Ե�����41, �Ƶ�����18, ����ŷ11, �ɞ���5
--�Ƶ����� �߱�4 ����3 �����2 ����2 ����7
--�ɞ��� ���� 0 ����4 �߱�1 ���0 ����0 
--����ŷ ����6 �߱�2 ������1 ���0 ����2

--�Ե� ����8 ����12 ��6 ���7 ����8

SELECT *
FROM tax;