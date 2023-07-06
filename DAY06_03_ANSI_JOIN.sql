/*
    JOIN
    1. 두 개 이상의 테이블을 한 번에 조회
    2. 각 테이블의 관계(1:다)를 이용, 조인 조건을 만든다.
    3. 조인 종류
        INNER JOIN : 2개 테이블에 모두 존재하는 데이터만 조회
        OUTER JOIN : 2개 테이블에 모두 존재하지 않아도 조회 (1, M 순서로)
    
    DRIVE TABLE VS DRIVEN TABLE
    
    DRIVE TABLE : JOIN 관계의 메인 테이블 (1, 데이터 적음,
        PK를 조인 조건으로 사용 -> INDEX 사용  -> 빠름)
    DRIVEN TABLE : JOIN 관계의 서브 테이블 (M, 데이터 많음,
        FK를 조인 조건으로 사용 -> INDEX 사용X -> 느림)
    * DRIVE TABLE을 DRIVEN TABLE보다 먼저 작성 -> 성능 UP
*/

-- 내부조인
-- 1. 사원번호, 사원명, 부서번호, 부서명 조회
SELECT E.EMPLOYEE_ID,
       E.FIRST_NAME,
       E.LAST_NAME,
       D.DEPARTMENT_ID, -- 공통, 동명 칼럼은 테이블(오너) 명시
       D.DEPARTMENT_NAME
  FROM DEPARTMENTS D INNER JOIN EMPLOYEES E
    ON D.DEPARTMENT_ID = E.DEPARTMENT_ID;

-- 2. 사원번호, 사원명, 직업, 직업별 최대연봉, 직업별 최소연봉 조회
SELECT E.EMPLOYEE_ID AS 사원번호,
       E.FIRST_NAME || ' ' || E.LAST_NAME AS 사원명,
       E.JOB_ID AS 직업,
       J.MAX_SALARY AS 직업별최대연봉,
       J.MIN_SALARY AS 직업별최소연봉
  FROM JOBS J INNER JOIN EMPLOYEES E
    ON J.JOB_ID = E.JOB_ID;

-- 외부조인
-- 3. 모든 사원의 사원번호, 사원명, 부서번호, 부서명 조회 (부서 없는 사원 포함)
SELECT E.EMPLOYEE_ID,
       E.FIRST_NAME,
       E.LAST_NAME,
       D.DEPARTMENT_ID, -- 공통, 동명 칼럼은 테이블(오너) 명시
       D.DEPARTMENT_NAME
  FROM DEPARTMENTS D RIGHT OUTER JOIN EMPLOYEES E
    ON D.DEPARTMENT_ID = E.DEPARTMENT_ID;

-- 4. 사원번호, 사원명, 부서번호, 부서명 조회 (사원 없는 부서 포함)
SELECT E.EMPLOYEE_ID,
       E.FIRST_NAME,
       E.LAST_NAME,
       D.DEPARTMENT_ID, -- 공통, 동명 칼럼은 테이블(오너) 명시
       D.DEPARTMENT_NAME
  FROM DEPARTMENTS D LEFT OUTER JOIN EMPLOYEES E
    ON D.DEPARTMENT_ID = E.DEPARTMENT_ID;
    
-- 3개 이상 테이블
-- 5. 사원번호, 사원명, 부서번호, 부서명, 근무지역 조회
SELECT E.EMPLOYEE_ID AS 사원번호,
       E.FIRST_NAME || ' ' || E.LAST_NAME AS 사원명,
       D.DEPARTMENT_ID AS 부서번호,
       D.DEPARTMENT_NAME AS 부서명,
       L.LOCATION_ID AS 근무지번호,
       L.CITY AS 근무지역
  FROM LOCATIONS L INNER JOIN DEPARTMENTS D
    ON L.LOCATION_ID = D.LOCATION_ID INNER JOIN EMPLOYEES E
    ON D.DEPARTMENT_ID = E.DEPARTMENT_ID;

-- 6. 부서번호, 부서명, 근무도시, 근무국가
SELECT D.DEPARTMENT_ID AS 부서번호,
       D.DEPARTMENT_NAME AS 부서명,
       L.CITY AS 근무도시,
       C.COUNTRY_NAME AS 근무국가
  FROM LOCATIONS L INNER JOIN DEPARTMENTS D
    ON L.LOCATION_ID = D.LOCATION_ID INNER JOIN COUNTRIES C
    ON L.COUNTRY_ID = C.COUNTRY_ID;
