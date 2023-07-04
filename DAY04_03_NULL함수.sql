/*
    NULL 처리 함수
    1. NVL(표현식, NULL의 경우 값)
    2. NVL2(표현식, NOT NULL의 경우, NULL의 경우)
    
*/

-- 1. 사원테이블 : 사원번호, 부서번호 조회
SELECT EMPLOYEE_ID, NVL(DEPARTMENT_ID, 0)
  FROM EMPLOYEES;

-- 2. 사원테이블 : 실제 커미션 조회
SELECT EMPLOYEE_ID,
       NVL(SALARY * COMMISSION_PCT, 0) AS COMMISSION1,
       SALARY * NVL(COMMISSION_PCT, 0) AS COMMISSION2
  FROM EMPLOYEES;
