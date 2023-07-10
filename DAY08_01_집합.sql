/*
    집합
    1. 2개 이상의 테이블을 한 번에 조회
    2. 모든 SELECT절의 칼럼 순서와 타입이 일치
    3. 종류
        1) UNION     : 합집합, 중복값 한 번만 조회
        2) UNION ALL : 합집합, 중복값 그대로 조회
        3) INTERSECT : 교집합, 중복값 한 번만 조회
        4) MINUS     : 차집합, (첫번째 SELECT) - (두번째 SELECT)

    4. 형식
        SELECT COLUMN1, ...
          FROM A_TABLE
         집합연산자
        SELECT COLUMN1, ...
          FROM B_TABLE
        [ORDER BY ...]
*/

/*
    결과 : 중복값 한 번만
    1   2
    3   4
*/
SELECT 1, 2
  FROM DUAL
 UNION
SELECT 1, 2
  FROM DUAL;
  
/*
    결과 : 중복값 그대로
    1   2
    1   2
*/
SELECT 1, 2
  FROM DUAL
 UNION ALL
SELECT 1, 2
  FROM DUAL;

-- 사원 테이블, 부서 테이블에 모두 존재하는 부서번호 = 사원들이 근무 중인 부서번호
SELECT DEPARTMENT_ID
  FROM DEPARTMENTS
INTERSECT
SELECT DEPARTMENT_ID
  FROM EMPLOYEES;
  
-- 부서테이블에는 존재, 사원테이블에는 존재 X 부서번호 = 유령부서
SELECT DEPARTMENT_ID
  FROM DEPARTMENTS
MINUS
SELECT DEPARTMENT_ID
  FROM EMPLOYEES;
  
-- 활용1. WITH문과 재귀쿼리
WITH
    MY_SUBQUERY(N, TOTAL) AS (
        SELECT 1, 1
          FROM DUAL
         UNION ALL
        SELECT N + 1, TOTAL + (N + 1)
          FROM MY_SUBQUERY
         WHERE N < 10
)

SELECT N, TOTAL FROM MY_SUBQUERY;

-- 활용2. WITH문과 재귀쿼리를 활용한 사원의 레벨 표시
-- MANGER 0명 -> 레벨1, 1명 -> 레벨2, ...
WITH
    MY_SUBQUERY(LV, EMPLOYEE_ID, FIRST_NAME, LAST_NAME, MANAGER_ID) AS (
        SELECT 1, EMPLOYEE_ID, FIRST_NAME, LAST_NAME, MANAGER_ID
          FROM EMPLOYEES
         WHERE MANAGER_ID IS NULL
         UNION ALL
        SELECT M.LV + 1,  E.EMPLOYEE_ID, E.FIRST_NAME, E.LAST_NAME, E.MANAGER_ID
          FROM EMPLOYEES E INNER JOIN MY_SUBQUERY M
            ON E.MANAGER_ID = M.EMPLOYEE_ID
)

SELECT LV, EMPLOYEE_ID, FIRST_NAME, LAST_NAME, MANAGER_ID FROM MY_SUBQUERY;