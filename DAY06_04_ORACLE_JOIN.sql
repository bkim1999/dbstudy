-- 오라클 문법 조인

-- 내부조인
-- 1. 사원번호, 사원명, 부서번호, 부서명 조회
SELECT E.EMPLOYEE_ID,
       E.FIRST_NAME,
       E.LAST_NAME,
       D.DEPARTMENT_ID, -- 공통, 동명 칼럼은 테이블(오너) 명시
       D.DEPARTMENT_NAME
  FROM DEPARTMENTS D, EMPLOYEES E
 WHERE D.DEPARTMENT_ID = E.DEPARTMENT_ID;

-- 2. 사원번호, 사원명, 직업, 직업별 최대연봉, 직업별 최소연봉 조회
SELECT E.EMPLOYEE_ID AS 사원번호,
       E.FIRST_NAME || ' ' || E.LAST_NAME AS 사원명,
       E.JOB_ID AS 직업,
       J.MAX_SALARY AS 직업별최대연봉,
       J.MIN_SALARY AS 직업별최소연봉
  FROM JOBS J, EMPLOYEES E
 WHERE J.JOB_ID = E.JOB_ID;

-- 외부조인
-- 3. 모든 사원의 사원번호, 사원명, 부서번호, 부서명 조회 (부서 없는 사원 포함)
SELECT E.EMPLOYEE_ID,
       E.FIRST_NAME,
       E.LAST_NAME,
       D.DEPARTMENT_ID, -- 공통, 동명 칼럼은 테이블(오너) 명시
       D.DEPARTMENT_NAME
  FROM DEPARTMENTS D, EMPLOYEES E
 WHERE D.DEPARTMENT_ID(+) = E.DEPARTMENT_ID;

-- 4. 사원번호, 사원명, 부서번호, 부서명 조회 (사원 없는 부서 포함)
SELECT E.EMPLOYEE_ID,
       E.FIRST_NAME,
       E.LAST_NAME,
       D.DEPARTMENT_ID, -- 공통, 동명 칼럼은 테이블(오너) 명시
       D.DEPARTMENT_NAME
  FROM DEPARTMENTS D, EMPLOYEES E
 WHERE D.DEPARTMENT_ID = E.DEPARTMENT_ID(+);
    
-- 3개 이상 테이블
-- 5. 사원번호, 사원명, 부서번호, 부서명, 근무지역 조회
SELECT E.EMPLOYEE_ID AS 사원번호,
       E.FIRST_NAME || ' ' || E.LAST_NAME AS 사원명,
       D.DEPARTMENT_ID AS 부서번호,
       D.DEPARTMENT_NAME AS 부서명,
       L.LOCATION_ID AS 근무지번호,
       L.CITY AS 근무지역
  FROM LOCATIONS L, DEPARTMENTS D, EMPLOYEES E
 WHERE L.LOCATION_ID = D.LOCATION_ID
   AND D.DEPARTMENT_ID = E.DEPARTMENT_ID;

-- 6. 부서번호, 부서명, 근무도시, 근무국가
SELECT D.DEPARTMENT_ID AS 부서번호,
       D.DEPARTMENT_NAME AS 부서명,
       L.CITY AS 근무도시,
       C.COUNTRY_NAME AS 근무국가
  FROM COUNTRIES C, LOCATIONS L, DEPARTMENTS D
 WHERE C.COUNTRY_ID = L.COUNTRY_ID
   AND L.LOCATION_ID = D.LOCATION_ID;