/*
    기타
    1. 랭킹 : RANK() OVER(ORDER BY ...) (중복 허용)
    2. 행 번호 : ROW_NUMBER() OVER(ORDER BY ...) (중복 무시)
    3. 암호화 함수 : STANDARD_HASH(대상, 알고리즘)
    4. 분기 처리 함수 : DECODE(이게, 이거면, 이거로, 이거면, 이거로, ...)
    5. 분기 처리 표현식 : 
*/

SELECT EMPLOYEE_ID,
       SALARY,
       RANK() OVER(ORDER BY SALARY DESC) AS 연봉순위,
       HIRE_DATE,
       RANK() OVER(ORDER BY HIRE_DATE) AS 입사순서
  FROM EMPLOYEES;

SELECT EMPLOYEE_ID,
       SALARY,
       ROW_NUMBER() OVER(ORDER BY SALARY DESC)
  FROM EMPLOYEES;
  
SELECT STANDARD_HASH('1111', 'SHA1'),
       STANDARD_HASH('1111', 'SHA256'),
       STANDARD_HASH('1111', 'SHA384'),
       STANDARD_HASH('1111', 'SHA512'),
       STANDARD_HASH('1111', 'MD5')
  FROM DUAL;

SELECT EMPLOYEE_ID,
       DEPARTMENT_ID,
       DECODE(DEPARTMENT_ID, 
            10, 'Administration',
            20, 'Marketing',
            30, 'Purchasing',
            40, 'human Resources',
            50, 'Shipping',
            60, 'IT') AS DEPARTMENT_NAME
   FROM EMPLOYEES;
   
SELECT EMPLOYEE_ID,
       DEPARTMENT_ID,
       CASE
        WHEN DEPARTMENT_ID = 10 THEN 'Administration'
        WHEN DEPARTMENT_ID = 20 THEN 'Marketing'
        WHEN DEPARTMENT_ID = 30 THEN 'Purchasing'
        WHEN DEPARTMENT_ID = 40 THEN 'human Resources'
        WHEN DEPARTMENT_ID = 50 THEN 'Shipping'
        WHEN DEPARTMENT_ID = 60 THEN 'IT'
        ELSE 'UNKNOWN'
       END AS DEPARTMENT_NAME
   FROM EMPLOYEES;