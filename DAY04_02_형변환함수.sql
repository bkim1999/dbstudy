/*
    DUAL 테이블
    1. DUMMY 칼럼 1개
    2. 'X'값을 가지고 있다.
    3. FROM절이 필요없는 SELECT문에 사용

    데이터타입 변환
    1. 문자 -> 숫자 : TO_NUMBER(문자)
    2. 숫자 -> 문자 : TO_CHAR(숫자, 형식)
    3. 날짜 -> 문자 : TO_CHAR(날짜, 형식) 년월일AM/PM시각분초 : YYYY, MM, DD, AM, HH, HH24, MI, SS
    4. 문자 -> 날짜 : TO_DATE(문자, 형식)
*/

SELECT * FROM DUAL;

SELECT TO_NUMBER('123') FROM DUAL;

SELECT TO_CHAR(1234)
     , TO_CHAR(1234, '999999')
     , TO_CHAR(1234, '000000')
     , TO_CHAR(1234, '9,999')
     , TO_CHAR(12345, '99,999')
FROM DUAL;

SELECT TO_CHAR(HIRE_DATE, 'YYYY-MM-DD') FROM EMPLOYEES;

SELECT SYSDATE, SYSTIMESTAMP FROM DUAL;

SELECT TO_CHAR(SYSDATE, 'YYYY-MM-DD AM HH:MI:SS')
     , TO_CHAR(SYSTIMESTAMP, 'YYYY-MM-DD HH24:MI:SS')
  FROM DUAL;

DROP TABLE EXAMPLE_TABLE;

CREATE TABLE EXAMPLE_TABLE (
    DT1 DATE,
    DT2 TIMESTAMP
);

INSERT INTO EXAMPLE_TABLE(DT1, DT2) VALUES(SYSDATE, SYSTIMESTAMP);
COMMIT;

SELECT * FROM EXAMPLE_TABLE;

SELECT TO_DATE('23/07/04')
     , TO_DATE('23/07/04', 'DD/MM/YY')
  FROM DUAL;

-- 특정 날짜 조회 안 됨
SELECT *
  FROM EXAMPLE_TABLE
 WHERE DT1 = '23/07/04';

SELECT *
  FROM EXAMPLE_TABLE
 WHERE DT1 = TO_DATE('23/07/04', 'YY/MM/DD');
 
-- 됨
SELECT *
  FROM EXAMPLE_TABLE
 WHERE TO_DATE(DT1, 'YY/MM/DD') = TO_DATE('23/07/04', 'YY/MM/DD');