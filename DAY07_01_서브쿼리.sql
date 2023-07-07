/*
    서브쿼리
    1. 메인쿼리에 포함됨
    2. 먼저 실행해 메인쿼리에 전달
    3. 종류
        1) SELECT 절 (스칼라)
        2) FROM 절 (인라인 뷰)
        3) WHERE 절 (단일/다중 행 서브쿼리)
    
    단일 행 서브쿼리
    1. 결과 = 1행
    2. 단일 행 서브쿼리인 경우
        1) WHERE 절에서 사용한 칼럼이 PK / UNIQUE 칼럼인 경우
        2) 통계 함수
    3. 단일 행 서브쿼리 연산자
        =   !=  >   ...
        
    다중 행 서브쿼리
    1. 결과 = N행
    2. 다중 행 서브쿼리 연산자
        IN  ANY ALL...
    
*/

-------------------------------------------------------------------------------
-- WHERE 절 서브쿼리
-------------------------------------------------------------------------------

/*
    1. 사원번호=101인 사원과 동일한 직업의 사원 조회 (단일 행)
    SELECT *
      FROM EMPLOYEES
     WHERE JOB_ID = (사원번호=101의 직업번호);
*/

SELECT * 
  FROM EMPLOYEES
 WHERE JOB_ID = (SELECT JOB_ID
                   FROM EMPLOYEES
                  WHERE EMPLOYEE_ID = 101);
                        
/*
    2. 부서명='IT' 근무하는 사원 조회 (다중 행)
    SELECT *
      FROM EMPLOYEES
     WHERE DEPARTMENT_ID = (부서명='IT'의 부서번호);
*/

SELECT * 
  FROM EMPLOYEES
 WHERE DEPARTMENT_ID IN (SELECT DEPARTMENT_ID
                   FROM DEPARTMENTS
                  WHERE DEPARTMENT_NAME = 'IT'); -- 부서명 중복 가능하므로 IN 사용 -> 다중 행 서브쿼리
          
/*
    3. 근무도시='Seattle' 근무하는 사원 조회 (다중 행)
    SELECT *
      FROM EMPLOYEES
     WHERE DEPARTMENT_ID = (위치번호=(근무도시='Seattle'의 위치번호)의 부서번호);
*/
SELECT *
  FROM EMPLOYEES
 WHERE DEPARTMENT_ID IN (SELECT DEPARTMENT_ID
                          FROM DEPARTMENTS
                         WHERE LOCATION_ID IN (SELECT LOCATION_ID
                                                 FROM LOCATIONS
                                                WHERE CITY = 'Seattle'));

-- 4. 최대연봉 조회
SELECT *
  FROM EMPLOYEES
 WHERE SALARY = (SELECT MAX(SALARY) FROM EMPLOYEES);

-- 5. 가장 먼저 입사한 사원
SELECT *
  FROM EMPLOYEES
 WHERE HIRE_DATE = (SELECT MIN(HIRE_DATE) FROM EMPLOYEES);

-- 6. 평균 연봉 이상 받는 사원
SELECT *
  FROM EMPLOYEES
 WHERE SALARY >= (SELECT AVG(SALARY) FROM EMPLOYEES);
 
-------------------------------------------------------------------------------
-- FROM 절 서브쿼리
-------------------------------------------------------------------------------

/*
    1. 연봉이 3번째로 높은 사원 조회
        1) 높은 연봉순 정렬
        2) 행번호 부여
        3) 행번호=3 행 조회
*/

SELECT EMPLOYEE_ID
  FROM (SELECT ROW_NUMBER() OVER(ORDER BY SALARY DESC) AS 행번호, EMPLOYEE_ID
          FROM EMPLOYEES)
 WHERE 행번호 = 3;
 
-- 2. 연봉서열 11 - 20위 사원 조회
SELECT EMPLOYEE_ID
  FROM (SELECT ROW_NUMBER() OVER(ORDER BY SALARY DESC) AS 행번호, EMPLOYEE_ID
          FROM EMPLOYEES)
 WHERE 행번호 BETWEEN 11 AND 20;

-- 3. 입사순서 21-30
SELECT EMPLOYEE_ID
  FROM (SELECT ROW_NUMBER() OVER(ORDER BY HIRE_DATE) AS 행번호, EMPLOYEE_ID
          FROM EMPLOYEES)
 WHERE 행번호 BETWEEN 21 AND 30;

-------------------------------------------------------------------------------
-- SELECT 절 서브쿼리
-------------------------------------------------------------------------------

-- 4. 부서번호=50인 부서의 사원: 사원번호, 사원명, 부서명 조회
-- 비상관 쿼리 (서브쿼리와 무관계)
SELECT EMPLOYEE_ID, 
       FIRST_NAME || ' ' || LAST_NAME,
       (SELECT DEPARTMENT_NAME
          FROM DEPARTMENTS
         WHERE DEPARTMENT_ID = 50) AS DEPT_NAME
  FROM EMPLOYEES
 WHERE DEPARTMENT_ID = 50;
 
-- 상관 쿼리 (서브쿼리와 관계)
SELECT E.EMPLOYEE_ID, 
       E.FIRST_NAME || ' ' || E.LAST_NAME,
       (SELECT D.DEPARTMENT_NAME
          FROM DEPARTMENTS D
         WHERE D.DEPARTMENT_ID = E.DEPARTMENT_ID
           AND D.DEPARTMENT_ID = 50) AS DEPT_NAME
  FROM EMPLOYEES E;    