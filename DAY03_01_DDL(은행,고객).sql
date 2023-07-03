/*
    DDL
    1. DATA DEFINITION LANGUAGE
    2. 데이터베이스 객체를 다루는 단어
    3. 트랜잭션 대상 아님 (작업 취소 불가)
    4. 종류 : 생성 CREATE, 수정 ALTER, 삭제 DROP, 내용만 삭제 TRUNCATE
    
    테이블 수정
    1. 칼럽 추가 :   ALTER TABLE [테이블명] ADD           [칼럼명] [데이터타입] [제약조건]
    2. 칼럼 수정 :   ALTER TABLE [테이블명] MODIFY        [칼럼명] [데이터타입] [제약조건]
    3. 칼럼 삭제 :   ALTER TABLE [테이블명] DROP COLUMN   [칼럼명]
    4. 칼럼 이름 :   ALTER TABLE [테이블명] RENAME COLUMN [기존칼럼명] TO [신규칼럼명]
    5. 테이블 이름 : ALTER TABLE [테이블명] RENAME TO     [신규테이블명]
    6. PK/FK 제약조건 : 
        1) PK : 추가 ALTER TABLE [테이블명] ADD CONSTRAINT  [제약조건명] PRIMARY KEY([칼럼명])
                삭제 ALTER TABLE [테이블명] DROP CONSTRAINT [제약조건명]
                                                 PRIMARY KEY
        2) FK : 추가 ALTER TABLE [자식테이블명] ADD CONSTRAINT  [제약조건명] FOREIGN KEY([칼럼명]) REFERENCES [부모테이블명]([참조할칼럼])
                삭제 ALTER TABLE [자식테이블명] DROP CONSTRAINT [제약조건명]
                일시중지 ALTER TABLE [테이블명] DISABLE CONSTRAINT [제약조건명]
                활성화 ALTER TABLE [테이블명] ENABLE CONSTRAINT [제약조건명]
*/

DROP TABLE CUSTOMER_TBL;

DROP TABLE BANK_TBL;

CREATE TABLE BANK_TBL (
    BANK_CODE VARCHAR2(20),
    BANK_NAME VARCHAR2(30),
    CONSTRAINT PK_BANK PRIMARY KEY ( BANK_CODE )
);

CREATE TABLE CUSTOMER_TBL (
    NO        NUMBER NOT NULL,
    NAME      VARCHAR2(30) NOT NULL,
    PHONE     VARCHAR2(30) UNIQUE,
    AGE       NUMBER CHECK ( AGE BETWEEN 0 AND 100 ),
    BANK_CODE VARCHAR2(20),
    CONSTRAINT PK_CUST PRIMARY KEY ( NO ),
    CONSTRAINT FK_BANK_CUST FOREIGN KEY ( BANK_CODE )
        REFERENCES BANK_TBL ( BANK_CODE )
);

--------------------------------------------------------------------------------

-- 1. BANK_TBL에 칼럼 BANK_TEL 추가
ALTER TABLE BANK_TBL ADD BANK_TEL VARCHAR2(15) NOT NULL;

-- 2. BANK_TBL의 칼럼 BANK_NAME의 데이터타입을 VARCHAR2(15)로 변경
ALTER TABLE BANK_TBL MODIFY
    BANK_NAME VARCHAR2(15);

-- 3. CUSTOMER_TBL에 칼럼 AGE 삭제
ALTER TABLE CUSTOMER_TBL DROP COLUMN AGE;

-- 4. CUSTOMER_TBL의 칼럼명 NO를 CUST_NO로 변경
ALTER TABLE CUSTOMER_TBL RENAME COLUMN NO TO CUSTOMER_NAME;

-- 5. CUSTOMER_TBL에 칼럼 GRADE 추가 ('VIP', 'GOLD', 'SILVER', 'BRONZE' 중 하나의 값을 가짐)
-- ALTER TABLE CUSTOMER_TBL ADD GRADE VARCHAR2(6) CHECK ( GRADE = 'VIP' OR GRADE = 'GOLD' OR GRADE = 'SILVER' OR GRADE = 'BRONZE' );

ALTER TABLE CUSTOMER_TBL ADD GRADE VARCHAR2(6) CHECK ( GRADE IN ( 'VIP', 'GOLD', 'SILVER', 'BRONZE' ) );                                                 

-- 6. CUSTOMER_TBL에 칼럼명 NAME, PHONE을 CUST_NAME, CUST_PHONE으로 변경
ALTER TABLE CUSTOMER_TBL RENAME COLUMN NAME TO CUST_NAME;

ALTER TABLE CUSTOMER_TBL RENAME COLUMN PHONE TO CUST_PHONE;

-- 7. CUSTOMER_TBL에 칼럼 CUST_PHONE을 필수로 설정
ALTER TABLE CUSTOMER_TBL MODIFY
    CUST_PHONE VARCHAR2(30) NOT NULL;

-- 8. CUSTOMER_TBL에 칼럼 CUST_NAME을 NULL로 설정
ALTER TABLE CUSTOMER_TBL MODIFY
    CUST_NAME VARCHAR(30) NULL;
    
-- 테이블 구조 확인
DESCRIBE BANK_TBL;

DESCRIBE CUSTOMER_TBL;