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
--GOO.fastfood -> fastfood synonym���� ����
--���� �� ���� sql�� ���������� �����ϴ��� Ȯ��
CREATE SYNONYM fastfood FOR goo.fastfood;
