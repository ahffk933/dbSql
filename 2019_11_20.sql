--Ư�� ���̺��� �÷� ��ȸ
--1. DESC ���̺��
--2. SELECT * FROM user_tab_columns;

--prod ���̺��� �÷���ȸ
DESC prod;

VARCHAR2, CHAR -> ���ڿ� (Character)
NUMBER -> ����
CLOB -> Character Large OBject, ���ڿ� Ÿ���� ���� ������ ���ϴ� Ÿ��
        -- �ִ� ������ : VARCHAR2 (4000), CLOB : 4GB
DATE -> ��¥ (�Ͻ� = ��, ��, �� + �ð�, ��, ��)

--date Ÿ�Կ� ���� ������ �����?
'2019/11/20 09:16:20' +1 = ?

--USER ���̺��� ��� �÷��� ��ȸ�غ���

SELECT *
FROM users;

--userid, usernm, reg_dt ������ �÷��� ��ȸ
--������ ���� ���ο� �÷��� ���� (reg_dt�� ���� ������ �� ���ο� ���� �÷�)
--��¥ + ���� ������? -> ���ڸ� ���� ��¥Ÿ���� ����� ����
--��Ī : ���� �÷����̳� ������ ���� ������ ���� �÷��� �ӟ��� �÷��̸��� �ο�
--      col | express [AS] ��Ī��
SELECT userid, usernm, reg_dt reg_date, reg_dt+5 AS after5day 
FROM users;

-- ���� ���, ���ڿ� ���(Oracle : ' ', Java : ' ', " " �Ѵ� ����)
-- table�� ���� ���� ���Ƿ� �÷����� ����
-- ���ڿ� ���� ���� ( +, -, /, *)
-- ���ڿ� ���� ���� ( +�� �������� ����, -> ||)
SELECT (10-2)*2,'DB SQL ����', 
        /*userid,+ '_modified', ���ڿ� ������ ���ϱ� ���� x */
        usernm || '_modified', reg_dt
FROM users;

-- NULL : ���� �𸣴� ��
-- NULL�� ���� ���� ����� �׻� NULL **
-- DESC ���̺�� : NOT NULL�� �����Ǿ��ִ� �÷����� ���� �ݵ�� ���� ��

--users ���ʿ��� ������ ����
SELECT *
FROM users;

DELETE users 
WHERE userid NOT IN ('brown', 'sally', 'cony', 'moon', 'james');


SELECT *
FROM users;

DELETE users
WHERE userid NOT IN ('brown', 'sally', 'cony', 'moon', 'james');

commit;

SELECT userid, usernm, reg_dt
FROM users;

-- null������ �����غ��� ���� moon�� reg-dt �÷��� null�� ����

UPDATE users SET reg_dt =NULL
WHERE userid = 'moon';

ROLLBACK;
COMMIT;

--users ���̺��� reg_dt�÷����� 5���� ���� ���ο� �÷��� ����
--NULL���� ���� ���� ����� NULL
SELECT userid, usernm, reg_dt, reg_dt +5
FROM users;

