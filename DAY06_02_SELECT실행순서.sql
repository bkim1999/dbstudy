/*
    SELECT 실행 순서
    SELECT [컬럼]             5
      FROM [테이블명]         1 
     WHERE [조건]             2
     GROUP BY [그룹기준]      3
    HAVING [그룹조건]         4
     ORDER BY [정렬기준]      6
*/

-- 사원테이블: 부서별 평균연봉

SELECT DEPARTMENT_ID,
       ROUND(AVG(SALARY), 2)
  FROM EMPLOYEES E
 GROUP BY DEPARTMENT_ID;
 
-- 사원테이블: 부서별 평균연봉, 사원수 2명 이상
SELECT DEPARTMENT_ID AS DEPT_ID,
       ROUND(AVG(SALARY), 2),
       COUNT(*) 부서별사원수
  FROM EMPLOYEES E
 GROUP BY DEPARTMENT_ID
HAVING COUNT(*) >= 2
 ORDER BY DEPT_ID;