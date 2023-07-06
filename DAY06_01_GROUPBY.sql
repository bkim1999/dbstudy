/*
    GROUP BY
    1. 특정 값을 가진 데이터들을 그룹화
    2. 통계 목적
    3. GROUP BY절에서 지정한 칼럼만 조회 가능
    
    HAVING
    1. GROUP BY 이후에 나타난다.
    2. GROUP BY의 조회 결과에 조건 지정
    3. GROUP BY가 필요 없는 조건은 WHERE로 지정
*/

-- 1. 사원테이블: 부서번호 기준 그룹화 -> 각 그룹 사원수
SELECT DEPARTMENT_ID,
       COUNT(*) AS 사원수
  FROM EMPLOYEES
 GROUP BY DEPARTMENT_ID; 
 
-- 2. 사원테이블: 직업 기준 그룹화 -> 각 그룹 연봉평균
SELECT JOB_ID,
       ROUND(AVG(SALARY), 2) AS 연봉평균
  FROM EMPLOYEES
 GROUP BY JOB_ID;
 
-- 3. 사원테이블: 전화번호 앞 3자리 기준 그룹화 -> 각 그룸 연봉합계
SELECT SUBSTR(PHONE_NUMBER, 1, 3) AS 번호앞자리,
       SUM(SALARY) AS 연봉합계
  FROM EMPLOYEES
 GROUP BY SUBSTR(PHONE_NUMBER, 1, 3);
 
-- 참고. GROUP BY 없이 통계내기
SELECT DISTINCT DEPARTMENT_ID,
       COUNT(*) OVER(PARTITION BY DEPARTMENT_ID),
       ROUND(AVG(SALARY) OVER(PARTITION BY DEPARTMENT_ID))
  FROM EMPLOYEES;

-- 4. 사원테이블: 사원수가 20명 이상인 부서 (HAVING으로 처리)
SELECT DEPARTMENT_ID,
       COUNT(*) AS 사원수
  FROM EMPLOYEES
 GROUP BY DEPARTMENT_ID
HAVING COUNT(*) >= 20;

-- 5. 사원테이블: 부서별 사원수, 부서번호 없는 사원 제외 (WHERE로 처리)
SELECT DEPARTMENT_ID,
       COUNT(*) AS 사원수
  FROM EMPLOYEES
 WHERE DEPARTMENT_ID IS NOT NULL
 GROUP BY DEPARTMENT_ID;