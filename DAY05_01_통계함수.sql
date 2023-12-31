/* 
    통계 함수 : NULL 자동으로 제외
    1. SUM
    2. AVG
    3. MAX
    4. MIN
    5. COUNT : NOT NULL 칼럼 (PK) / 모든 칼럼 (*)
*/

SELECT SUM(SALARY) AS 연봉합계 FROM EMPLOYEES;
SELECT AVG(COMMISSION_PCT) AS 커미션퍼텐트평균 FROM EMPLOYEES;
SELECT MAX(SALARY) AS 최고연봉 FROM EMPLOYEES;
SELECT MAX(SALARY * COMMISSION_PCT) AS 최대커미션 FROM EMPLOYEES;
SELECT MAX(HIRE_DATE) AS 최근고용일 FROM EMPLOYEES;
SELECT COUNT(EMPLOYEE_ID) AS 전체사원수 FROM EMPLOYEES;
SELECT COUNT(*) AS 전체사원수 FROM EMPLOYEES;
SELECT COUNT(DISTINCT DEPARTMENT_ID) AS 부서수 FROM EMPLOYEES;