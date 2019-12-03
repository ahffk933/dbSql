--cross join
SELECT cid, cnm, pid, pnm
FROM customer CROSS JOIN product;

SELECT *
FROM fastfood;

--도시발전지수
SELECT *
FROM FASTFOOD
WHERE sido = '대전광역시'
GROUP BY gb;

--도시발전지수가 높은 순으로 나열
--도시발전지수 = (버거킹개수 + KFC개수 + 맥도날드 개수) / 롯데리아 개수
--순위 / 시도 / 시군구 / 도시발전지수 (소수점 둘쨰 자리에서 반올림)
--1 / 서울특벽시 / 서초구 / 7.5
--2 / 서울특별시 / 강남구 / 7.2

--해당 시도, 시군구별 프랜차이즈별 건수 필요
SELECT ROWNUM rn, sido, sigungu, 도시발전지수
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
        ORDER BY 도시발전지수 DESC);




--내가 하다만거 ㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋ
SELECT ROWNUM rank, SUM(a)gb, sido, sigungu, ROWNUM 도시발전지수 
FROM fastfood
WHERE gb IN('버거킹', 'KFC', '맥도날드')  a;
 
ORDER BY rank





--대전시 유성구
--대전시 대덕구
--대전시 서구
--대전시 중구
--대전시 동구
SELECT *
FROM fastfood
WHERE sido ='대전광역시'
AND sigungu ='유성구'  
AND gb ='롯데리아'; -- 롯데리아41, 맥도날드18, 버거킹11, 케엪씨5
--맥도날드 중구4 유성3 대덕구2 동구2 서구7
--케엪씨 유성 0 서구4 중구1 대덕0 동구0 
--버거킹 서구6 중구2 유성구1 대덕0 동구2

--롯데 동구8 서구12 중6 대덕7 유성8

SELECT *
FROM tax;