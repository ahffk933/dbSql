SELECT *
FROM GOO.users;


SELECT *
FROM USER_TABLES;

--78 ->79
SELECT *
FROM ALL_TABLES
WHERE OWNER = 'GOO';


SELECT *
FROM goo.fastfood;
--GOO.fastfood -> fastfood synonym으로 생성
--생성 후 다음 sql이 정상적으로 동작하는지 확인
CREATE SYNONYM fastfood FOR goo.fastfood;
