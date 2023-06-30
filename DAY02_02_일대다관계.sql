/*
    1:M 관계
    1. 대표적인 두 개의 테이블 관계
    2. 1 : M = PK : FM = 부모 : 자식
    3. 반드시 부모 먼저 생성
    4. 반드시 자식 먼저 삭제
    
    삭제 옵션
    1. ON DELETE CASCADE: 
        외래키가 참조하는 기본키 값이 삭제되면 외래키도 함께 삭제
    2. ON DELETE SET NULL:
        ~ 외래키를 NULL로 설정
*/

DROP TABLE STUDENT_T;

DROP TABLE SCHOOL_T;

CREATE TABLE SCHOOL_T (
    SCH_CODE NUMBER NOT NULL,
    SCH_NAME VARCHAR2(10) NOT NULL,
    CONSTRAINT PK_SCH PRIMARY KEY ( SCH_CODE )
);

CREATE TABLE STUDENT_T (
    STU_NUMBER NUMBER NOT NULL,
    SCH_CODE   NUMBER,
    STU_NAME   VARCHAR2(10) NOT NULL,
    CONSTRAINT PK_STU PRIMARY KEY ( STU_NUMBER ),
    CONSTRAINT FK_SCH_STU FOREIGN KEY ( SCH_CODE )
        REFERENCES SCHOOL_T ( SCH_CODE )
            ON DELETE CASCADE
);