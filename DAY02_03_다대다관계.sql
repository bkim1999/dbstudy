/*
    M : N 관계
    1. 현실에서 빈번, 주의 필요
    2. 직접 관계 불가
    3. 관계를 위해 별도의 테이블 필요
    4. 1:M 두 개로 구현
*/

DROP TABLE ENROLL_T;

DROP TABLE SUBJECT_T;

DROP TABLE UNIV_STUDENT_T;

CREATE TABLE UNIV_STUDENT_T (
    STU_NO   NUMBER NOT NULL,
    STU_NAME VARCHAR2(10) NOT NULL,
    STU_AGE  NUMBER NULL,
    CONSTRAINT PK_UNIV_STU PRIMARY KEY ( STU_NO )
);

CREATE TABLE SUBJECT_T (
    SUB_CODE VARCHAR(5) NOT NULL,
    SUB_NAME VARCHAR2(10) NOT NULL UNIQUE,
    PRO_NAME VARCHAR2(10) NOT NULL,
    CONSTRAINT PK_SUB PRIMARY KEY ( SUB_CODE )
);

CREATE TABLE ENROLL_T (
    ENR_NO   NUMBER NOT NULL,
    STU_NO   NUMBER,
    SUB_CODE VARCHAR(5),
    CONSTRAINT PK_ENR PRIMARY KEY ( ENR_NO ),
    CONSTRAINT FK_UNIV_STU_ENR FOREIGN KEY ( STU_NO )
        REFERENCES UNIV_STUDENT_T ( STU_NO ),
    CONSTRAINT FK_SUB_ENR FOREIGN KEY ( SUB_CODE )
        REFERENCES SUBJECT_T ( SUB_CODE )
);