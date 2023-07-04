/*
    DML : Data Manipulation Language
    1. 데이터(행)을 조작(삽입, 수정, 삭제)
    2. 트랜잭션 대상(작업저장 COMMIT, 취소 ROLLBACK 가능)
        1) COMMIT : 작업을 저장, COMMIT 후 ROLLBACK으로 취소 불가
        2) ROLLBACK : 작업을 취소, COMMIT 이후 작업을 취소
    3. 종류 :
        1) 삽입 : INSERT INTO VALUES 
        2) 수정 : UPDATE SET WHERE
        3) 삭제 : DELETE FROM WHERE
*/

DROP SEQUENCE EMP_SEQ;

DROP SEQUENCE DEPT_SEQ;

DROP TABLE EMPLOYEE_T;

DROP TABLE DEPARTMENT_T;

CREATE TABLE DEPARTMENT_T (
    DEPT_NO   NUMBER,
    DEPT_NAME VARCHAR2(15) NOT NULL,
    LOCATION  VARCHAR2(15) NOT NULL,
    CONSTRAINT PK_DEPART PRIMARY KEY ( DEPT_NO )
);

CREATE TABLE EMPLOYEE_T (
    EMP_NO    NUMBER,
    NAME      VARCHAR2(20) NOT NULL,
    DEPART    NUMBER,
    POSITION  VARCHAR2(20),
    GENDER    CHAR(2),
    HIRE_DATE DATE,
    SALARY    NUMBER,
    CONSTRAINT PK_EMPLOYEE PRIMARY KEY ( EMP_NO ),
    CONSTRAINT FK_DEPART_EMP FOREIGN KEY ( DEPART )
        REFERENCES DEPARTMENT_T ( DEPT_NO ) ON DELETE SET NULL
);

CREATE SEQUENCE DEPT_SEQ -- 디폴트

 INCREMENT BY 1 START WITH 1 NOMAXVALUE NOMINVALUE NOCYCLE CACHE 20 NOORDER;

INSERT INTO DEPARTMENT_T (
    DEPT_NO,
    DEPT_NAME,
    LOCATION
) VALUES (
    DEPT_SEQ.NEXTVAL,
    '영업부',
    '대구'
);

INSERT INTO DEPARTMENT_T (
    DEPT_NO,
    DEPT_NAME,
    LOCATION
) VALUES (
    DEPT_SEQ.NEXTVAL,
    '인사부',
    '서울'
);

INSERT INTO DEPARTMENT_T (
    DEPT_NO,
    DEPT_NAME,
    LOCATION
) VALUES (
    DEPT_SEQ.NEXTVAL,
    '총무부',
    '대구'
);

INSERT INTO DEPARTMENT_T (
    DEPT_NO,
    DEPT_NAME,
    LOCATION
) VALUES (
    DEPT_SEQ.NEXTVAL,
    '기획부',
    '서울'
);

-- 사원 테이블에 삽입

CREATE SEQUENCE EMP_SEQ INCREMENT BY 1 START WITH 1001 ORDER;

INSERT INTO EMPLOYEE_T (
    EMP_NO,
    NAME,
    DEPART,
    POSITION,
    GENDER,
    HIRE_DATE,
    SALARY
) VALUES (
    EMP_SEQ.NEXTVAL,
    '구창민',
    1,
    '과장',
    'M',
    '95-05-01',
    5000000
);

INSERT INTO EMPLOYEE_T (
    EMP_NO,
    NAME,
    DEPART,
    POSITION,
    GENDER,
    HIRE_DATE,
    SALARY
) VALUES (
    EMP_SEQ.NEXTVAL,
    '김민서',
    1,
    '사원',
    'M',
    '17-09-01',
    2500000
);

INSERT INTO EMPLOYEE_T (
    EMP_NO,
    NAME,
    DEPART,
    POSITION,
    GENDER,
    HIRE_DATE,
    SALARY
) VALUES (
    EMP_SEQ.NEXTVAL,
    '이은영',
    2,
    '부장',
    'F',
    '90-09-01',
    5500000
);

INSERT INTO EMPLOYEE_T (
    EMP_NO,
    NAME,
    DEPART,
    POSITION,
    GENDER,
    HIRE_DATE,
    SALARY
) VALUES (
    EMP_SEQ.NEXTVAL,
    '한성일',
    2,
    '과장',
    'M',
    '93-04-01',
    5000000
);

COMMIT;

/*
    수정
    UPDATE [테이블명]
       SET [업데이트내용], ...
     WHERE 조건식
*/

-- 1. 부서번호가 3인 부서의 지역 -> '인천'
UPDATE DEPARTMENT_T
   SET LOCATION = '인천'
 WHERE DEPT_NO = 3;
 
 

-- 2. 부서번호가 2인 부서의 모든 사원의 연봉을 500000 인상
UPDATE EMPLOYEE_T
   SET SALARY = SALARY + 500000
 WHERE DEPART = 2;
 
/*
    삭제
    DELETE
      FROM [테이블명]
     WHERE 조건식
*/

-- 3. 지역이 인천인 부서 삭제 (사원 없음)
DELETE
  FROM DEPARTMENT_T
 WHERE LOCATION = '인천';
 
-- 4. 지역이 서울인 부서 삭제 (사원 있음 -> ON DELETE SET NULL)
DELETE
  FROM DEPARTMENT_T
 WHERE LOCATION = '서울';

-- 5. 