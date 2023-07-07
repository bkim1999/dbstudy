-- 1. LOCATION_ID가 1700인 부서에 근무하는 사원들의 EMPLOYEE_ID, FIRST_NAME, DEPARTMENT_NAME을 조회하시오.
-- 1) ANSI
SELECT E.EMPLOYEE_ID,
       E.FIRST_NAME,
       D.DEPARTMENT_NAME
  FROM DEPARTMENTS D INNER JOIN EMPLOYEES E
    ON D.DEPARTMENT_ID = E.DEPARTMENT_ID
 WHERE LOCATION_ID = 1700;

-- 2) 오라클
SELECT E.EMPLOYEE_ID,
       E.FIRST_NAME,
       D.DEPARTMENT_NAME
  FROM DEPARTMENTS D, EMPLOYEES E
 WHERE LOCATION_ID = 1700
   AND D.DEPARTMENT_ID = E.DEPARTMENT_ID;

-- 2. DEPARTMENT_NAME이 'Executive'인 부서에 근무하는 사원들의 EMPLOYEE_ID, FIRST_NAME을 조회하시오.
-- 1) ANSI
SELECT E.EMPLOYEE_ID,
       E.FIRST_NAME
  FROM DEPARTMENTS D INNER JOIN EMPLOYEES E
    ON D.DEPARTMENT_ID = E.DEPARTMENT_ID
 WHERE D.DEPARTMENT_NAME = 'Executive';
   
-- 2) 오라클
SELECT E.EMPLOYEE_ID,
       E.FIRST_NAME
  FROM DEPARTMENTS D, EMPLOYEES E
 WHERE D.DEPARTMENT_NAME = 'Executive'
   AND D.DEPARTMENT_ID = E.DEPARTMENT_ID;


-- 3. 모든 사원들의 EMPLOYEE_ID, FIRST_NAME, DEPARTMENT_NAME, STREET_ADDRESS, CITY를 조회하시오.
-- 1) ANSI
SELECT E.EMPLOYEE_ID,
       E.FIRST_NAME,
       D.DEPARTMENT_NAME,
       L.STREET_ADDRESS,
       L.CITY
  FROM LOCATIONS L INNER JOIN DEPARTMENTS D
    ON L.LOCATION_ID = D.LOCATION_ID INNER JOIN EMPLOYEES E
    ON D.DEPARTMENT_ID = E.DEPARTMENT_ID;

-- 2) 오라클
SELECT E.EMPLOYEE_ID,
       E.FIRST_NAME,
       D.DEPARTMENT_NAME,
       L.STREET_ADDRESS,
       L.CITY
  FROM LOCATIONS L, DEPARTMENTS D, EMPLOYEES E
 WHERE L.LOCATION_ID = D.LOCATION_ID
   AND D.DEPARTMENT_ID = E.DEPARTMENT_ID;


-- 4. 부서별 DEPARTMENT_NAME과 사원 수와 평균 연봉을 조회하시오.
-- 1) ANSI
SELECT D.DEPARTMENT_NAME,
       COUNT(*),
       AVG(E.SALARY)
  FROM DEPARTMENTS D INNER JOIN EMPLOYEES E
    ON D.DEPARTMENT_ID = E.DEPARTMENT_ID
 GROUP BY DEPARTMENT_ID, DEPARTMENT_NAME;

-- 2) 오라클
SELECT D.DEPARTMENT_NAME,
       COUNT(*),
       AVG(E.SALARY)
  FROM DEPARTMENTS D, EMPLOYEES E
 WHERE D.DEPARTMENT_ID = E.DEPARTMENT_ID
 GROUP BY D.DEPARTMENT_ID, DEPARTMENT_NAME;


-- 5. 모든 사원들의 EMPLOYEE_ID, FIRST_NAME, DEPARTMENT_NAME을 조회하시오. 부서가 없는 사원의 부서명은 'None'으로 조회되도록 처리하시오.
-- 1) ANSI
SELECT E.EMPLOYEE_ID, 
       E.FIRST_NAME, 
       NVL(D.DEPARTMENT_NAME, 'None')
  FROM DEPARTMENTS D RIGHT OUTER JOIN EMPLOYEES E
    ON D.DEPARTMENT_ID = E.DEPARTMENT_ID;
    
-- 2) 오라클
SELECT E.EMPLOYEE_ID, 
       E.FIRST_NAME, 
       NVL(D.DEPARTMENT_NAME, 'None')
  FROM DEPARTMENTS D, EMPLOYEES E
 WHERE D.DEPARTMENT_ID(+) = E.DEPARTMENT_ID;


-- 6. 모든 부서의 DEPARTMENT_NAME과 근무 중인 사원 수를 조회하시오. 근무하는 사원이 없으면 0으로 조회하시오.
-- 1) ANSI
SELECT D.DEPARTMENT_NAME,
       NVL(COUNT(E.EMPLOYEE_ID), 0)
  FROM DEPARTMENTS D LEFT OUTER JOIN EMPLOYEES E
    ON D.DEPARTMENT_ID = E.DEPARTMENT_ID
 GROUP BY DEPARTMENT_ID, DEPARTMENT_NAME;

-- 2) 오라클
SELECT D.DEPARTMENT_NAME,
       NVL(COUNT(E.EMPLOYEE_ID), 0) 
  FROM DEPARTMENTS D, EMPLOYEES E
 WHERE D.DEPARTMENT_ID = E.DEPARTMENT_ID(+)
 GROUP BY DEPARTMENT_ID, DEPARTMENT_NAME;


-- 7. 모든 부서의 DEPARTMENT_ID, DEPARTMENT_NAME, STATE_PROVINCE, COUNTRY_NAME, REGION_NAME을 조회하시오.
-- 1) ANSI
SELECT D.DEPARTMENT_ID,
       D.DEPARTMENT_NAME,
       L.STATE_PROVINCE,
       C.COUNTRY_NAME,
       R.REGION_NAME
  FROM REGIONS R INNER JOIN COUNTRIES C 
    ON R.REGION_ID = C.REGION_ID INNER JOIN LOCATIONS L 
    ON C.COUNTRY_ID = L.COUNTRY_ID INNER JOIN DEPARTMENTS D
    ON L.LOCATION_ID = D.LOCATION_ID;

-- 2) 오라클
SELECT D.DEPARTMENT_ID,
       D.DEPARTMENT_NAME,
       L.STATE_PROVINCE,
       C.COUNTRY_NAME,
       R.REGION_NAME
  FROM REGIONS R, COUNTRIES C, LOCATIONS L, DEPARTMENTS D
 WHERE R.REGION_ID = C.REGION_ID
   AND C.COUNTRY_ID = L.COUNTRY_ID
   AND L.LOCATION_ID = D.LOCATION_ID;


-- 8. 모든 사원들의 EMPLOYEE_ID, FIRST_NAME, LAST_NAME, MANAGER의 FIRST_NAME을 조회하시오. (SELF JOIN)
-- 1) ANSI
SELECT E.EMPLOYEE_ID,
       E.FIRST_NAME,
       E.LAST_NAME,
       M.FIRST_NAME AS 매니저이름
  FROM EMPLOYEES M RIGHT OUTER JOIN EMPLOYEES E
    ON M.EMPLOYEE_ID = E.MANAGER_ID
 ORDER BY EMPLOYEE_ID;

-- 2) 오라클
SELECT E.EMPLOYEE_ID,
       E.FIRST_NAME,
       E.LAST_NAME,
       M.FIRST_NAME AS 매니저이름
  FROM EMPLOYEES M, EMPLOYEES E
 WHERE M.EMPLOYEE_ID(+) = E.MANAGER_ID
 ORDER BY EMPLOYEE_ID;

-- 9. 각 사원 중에서 매니저보다 먼저 입사한 사원을 조회하시오. (SELF JOIN)
-- 1) ANSI
SELECT E.EMPLOYEE_ID,
       E.HIRE_DATE AS 사원입사일,
       M.HIRE_DATE AS 매니저입사일
  FROM EMPLOYEES M INNER JOIN EMPLOYEES E
    ON M.EMPLOYEE_ID = E.MANAGER_ID
 WHERE E.HIRE_DATE < M.HIRE_DATE
 ORDER BY EMPLOYEE_ID;

-- 2) 오라클
SELECT E.EMPLOYEE_ID,
       E.HIRE_DATE AS 사원입사일,
       M.HIRE_DATE AS 매니저입사일
  FROM EMPLOYEES M, EMPLOYEES E
 WHERE M.EMPLOYEE_ID = E.MANAGER_ID
   AND E.HIRE_DATE < M.HIRE_DATE
 ORDER BY EMPLOYEE_ID;

-- 10. 같은 부서에 근무하는 사원 중에서 나보다 SALARY가 높은 사원 정보를 조회하시오. (SELF JOIN)
-- 1) ANSI
SELECT ME.EMPLOYEE_ID AS 나,
       ME.SALARY AS 내연봉,
       E.EMPLOYEE_ID AS 높은연봉자,
       E.SALARY AS 높은연봉
  FROM EMPLOYEES E INNER JOIN EMPLOYEES ME 
    ON E.DEPARTMENT_ID = ME.DEPARTMENT_ID
   AND ME.SALARY < E.SALARY
 ORDER BY ME.EMPLOYEE_ID;
   
-- 2) 오라클
SELECT ME.EMPLOYEE_ID AS 나,
       ME.SALARY AS 내연봉,
       E.EMPLOYEE_ID AS 높은연봉자,
       E.SALARY AS 높은연봉
  FROM EMPLOYEES E, EMPLOYEES ME
 WHERE E.DEPARTMENT_ID = ME.DEPARTMENT_ID
   AND ME.SALARY < E.SALARY
 ORDER BY ME.EMPLOYEE_ID;