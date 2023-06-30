/*
    TABLE
    1. 데이터를 저장하는 객체
    2. 행과 열의 집합
    
    DATA TYPE
    1. NUMBER(p, s) : p - 정밀도(유효숫자 갯수), s - 스케일(소수부 유효숫자 갯수)
    2. CHAR(size) : 고정 문자, size <= 2000 BYTE
    3. VARCHAR(size) : 가변문자, size <= 4000 BYTE
    4. CLOB : 큰 텍스트
    5. DATE : 년월일시분초
    6. TIMESTAMP : 년월일시분초ms
    
    제약조건
    1. NOT NULL
    2. UNIQUE
    3. PRIMARY KEY
    4. FORIEGN KEY
    5. CHECK : 값의 제한
*/

DROP TABLE CUSTOMER_T;
CREATE TABLE CUSTOMER_T (
    NO             NUMBER NOT NULL PRIMARY KEY
  , ID             VARCHAR(32) NOT NULL UNIQUE
  , NAME           VARCHAR(32) NOT NULL
  , JOB            VARCHAR(32) NULL
  , PHONE          CHAR(13) NULL UNIQUE
  , JUBUN          CHAR(14) NULL UNIQUE
);


/*
CREATE TABLE SCHOOL_T(
    학교코드 NUMBER PRIMARY KEY,
    학교명   VARCHAR2(32 BYTE)
);

CREATE TABLE STUDENT_T(
    
*/