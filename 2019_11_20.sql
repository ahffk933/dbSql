--특정 테이블의 컬럼 조회
--1. DESC 테이블명
--2. SELECT * FROM user_tab_columns;

--prod 테이블의 컬럼조회
DESC prod;

VARCHAR2, CHAR -> 문자열 (Character)
NUMBER -> 숫자
CLOB -> Character Large OBject, 문자열 타입의 길이 제한을 피하는 타입
        -- 최대 사이즈 : VARCHAR2 (4000), CLOB : 4GB
DATE -> 날짜 (일시 = 년, 월, 일 + 시간, 분, 초)

--date 타입에 대한 연산의 결과는?
'2019/11/20 09:16:20' +1 = ?

--USER 테이블의 모든 컬럼을 조회해보셔

SELECT *
FROM users;

--userid, usernm, reg_dt 세가지 컬럼만 조회
--연산을 통해 새로운 컬럼을 생성 (reg_dt에 숫자 연산을 한 새로운 가공 컬럼)
--날짜 + 정수 연산은? -> 일자를 더한 날짜타입이 결과로 나옴
--별칭 : 기존 컬럼명이나 연산을 통해 생성된 가상 컬럼에 임읭의 컬럼이름을 부여
--      col | express [AS] 별칭명
SELECT userid, usernm, reg_dt reg_date, reg_dt+5 AS after5day 
FROM users;

-- 숫자 상수, 문자열 상수(Oracle : ' ', Java : ' ', " " 둘다 가능)
-- table에 없는 값을 임의로 컬럼으로 생성
-- 숫자에 대한 연산 ( +, -, /, *)
-- 문자에 대한 연산 ( +가 존재하지 않음, -> ||)
SELECT (10-2)*2,'DB SQL 수업', 
        /*userid,+ '_modified', 문자열 연산은 더하기 연산 x */
        usernm || '_modified', reg_dt
FROM users;

-- NULL : 아직 모르는 값
-- NULL에 대한 연산 결과는 항상 NULL **
-- DESC 테이블명 : NOT NULL로 설정되어있는 컬럼에는 값이 반드시 들어가야 함

--users 불필요한 데이터 삭제
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

-- null연산을 시험해보기 위해 moon의 reg-dt 컬럼을 null로 변경

UPDATE users SET reg_dt =NULL
WHERE userid = 'moon';

ROLLBACK;
COMMIT;

--users 테이블의 reg_dt컬럼값에 5일을 더한 새로운 컬럼을 생성
--NULL값에 대한 연산 결과는 NULL
SELECT userid, usernm, reg_dt, reg_dt +5
FROM users;

