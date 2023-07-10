/*
    ROWID
    1. 오라클에서 제공하는 가상 칼럼(PSEUDO COLUMN)
    2. 어떤 행이 어디에 저장되어 있는지 알고있는 칼럼
    3. 실제로 저장된 물리적 저장위치를 확인할 수 있다.
    
    ROWID를 이용한 조회 = 오라클에서 가장 빠른 조회
    실제 사용 불가, 대신 인덱스 사용
    
    INDEX
    1. 빠른 조회를 지원하는 데이터베이스 객체
    2. 어떤 데이터가 어떤 ROWID를 가지고 있는지 알고 있다.
    3. PK, UNIQUE 칼럼은 자동으로 인덱스 생성
    4. 데이터의 삽입/수정/삭제 시 인덱스도 함께 갱신
    -> 성능 저하
    
    DATA DICTIONARY
    1. 특정 데이터의 정보를 담은 객체
    2. 시스템 카탈로그, 메타 데이터
    3. 계정 유형별로 관리한다. (DBA_, USER_, ALL_)
    
*/

SELECT ROWID FROM EMPLOYEES;

SELECT * FROM EMPLOYEES WHERE ROWID = 'AAAR+IAAHAAAADNAAV';

-- 인덱스 데이터 사전
SELECT * FROM USER_INDEXES;

-- 인덱스가 설정된 칼럼 정보가 저장된 데이터사전
-- DBA_IND_COLUMNS, USER_IND_COLUMNS, ALL_IND_COLUMNS
SELECT * FROM USER_IND_COLUMNS;
SELECT * FROM USER_IND_COLUMNS WHERE TABLE_NAME = 'EMPLOYEES';

CREATE INDEX DEPT_NAME_IX
    ON DEPARTMENTS(DEPARTMENT_NAME);
    
DROP INDEX DEPT_NAME_IX;

-- 인덱스 타는 조회 
SELECT *
  FROM EMPLOYEES
 WHERE EMPLOYEE_ID = 150;

-- 인덱스 안타는 조회 (인덱스 칼럼에 함수 사용)
SELECT *
  FROM EMPLOYEES
 WHERE TO_CHAR(EMPLOYEE_ID) = '150';