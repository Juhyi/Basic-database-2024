-- P.555 부터 시작

/*  5. 현재의 날짜 타입을 날짜 함수를 통해서 확인
       2006년 5월 20일부터 2007년 5월 20일 사이에 고용된 사원의 이름 (FIRST + LAST), 사원번호, 고용일자
       단, 입사일 빠른 순으로 정렬하시오(18개행)  */
SELECT FIRST_NAME + ' ' + LAST_NAME AS [name]
     , EMPLOYEE_ID
     , HIRE_DATE
  FROM employees
 WHERE HIRE_DATE BETWEEN '2006/05/20' AND '2007/05/20' 
ORDER BY HIRE_DATE ASC;

/*  6. 급여와 수당율에 대한 지출보고서, 수당을 받는 모든 사원의 이름, 급여, 업무, 수당율을 출력 (35개행)*/
SELECT FIRST_NAME + ' ' + LAST_NAME AS [name]
     , SALARY
     , JOB_ID
     , COMMISSION_PCT
  FROM employees
 WHERE  COMMISSION_PCT IS NOT NULL
 ORDER BY SALARY DESC, COMMISSION_PCT DESC;

-- sample 문제 : 단일행 함수, 변환 함수
/* 60번 IT부서에 사원 급여를 12.3% 인상하기로 하였다. 정수만 반올림하여 보고서 작성.
   사번, 이름, 급여, 인상된 급여(Increased Salary)(5개행) */
SELECT EMPLOYEE_ID
     , FIRST_NAME + ' ' + LAST_NAME AS [name]
     , SALARY
     , CONVERT(INT,ROUND(SALARY * (1.123), -1))AS [Increased Salary]
  FROM employees
 WHERE department_id = 60 

/*  7. 각 사원의 성이 S로 끝나는 사원의 이름과 업무를 -- Michael Fogers is a ST_CRERK-- 처럼 출력하라 (18개행) */
SELECT FIRST_NAME + ' ' + LAST_NAME + ' is a ' + JOB_ID AS[NAME + JOB]
  FROM employees
 WHERE LAST_NAME LIKE '%s'


/*  8. 이름, 급여, 수당 여부에 따른 연봉을 포함하여 출력하라.
       Salary + Commission / Salary Only, 연봉이 높은 순 (107개행) */
SELECT FIRST_NAME + ' ' + LAST_NAME AS [name],
       SALARY,
       SUM(SALARY + COALESCE(COMMISSION_PCT, 0)) AS total_compensation
FROM employees
GROUP BY FIRST_NAME, LAST_NAME, SALARY, COMMISSION_PCT
ORDER BY total_compensation ASC;

/*  9. 이름, 입사일, 일사일의 요일 출력, 일요일부터 토요일 순으로 (107개행) */
SET datefirst 6
SELECT FIRST_NAME + ' ' + LAST_NAME AS [name]
     , HIRE_DATE
     , DATENAME(WEEKDAY, DATEPART(DW, HIRE_DATE)) AS [Day_of_the_name]
  FROM employees

-- 집계함수, SUM, COUNT, AVG, MAX, MIN...
/*  11. 사원들의 업뭅별 전체 급여 평균이 10,000$보다 큰 경우리 조회,
        업무, 급여평균을 출력하시오. 단, 사원(CLERK)이 포함된 경우는 제외, 전체 급여 내림차순 (7개행)*/
SELECT JOB_ID 
     , '$' + FORMAT(AVG(SALARY), '#,#') AS [AVG Salary]
  FROM employees
 WHERE JOB_ID NOT LIKE '%CLERK%'
GROUP BY JOB_ID
HAVING AVG(SALARY) > 10000
ORDER BY 2 DESC;

SELECT DATEPART(DW, GETDATE())
      , DATENAME(WEEKDAY, DATEPART(DW,GETDATE()))

-- JOIN
/* 12. Employees, Department 조인, 사원수가 5명 이상인 부서의 부서명, 사원수 출력 */
/* 13.도 풀 수 있음 */
SELECT d.department_name
     , COUNT(*) as [사원 수]
  FROM employees AS e, departments AS d
 WHERE e.DEPARTMENT_ID = d.department_id
 GROUP BY d.department_name
   HAVING COUNT(*) >= 5
 ORDER by COUNT(*) DESC;

-- 서브쿼리
/* 업무별 사원의 급여 정보중 최소 급여를 받는 사원의 이름, 업무, 급여, 입사일 출력 (21개행) */
SELECT FIRST_NAME + ' ' + LAST_NAME AS [name]
       , e.JOB_ID
       , e.SALARY
       , e.HIRE_DATE
  FROM employees AS e 
 WHERE e.SALARY  IN (SELECT MIN(SALARY) AS [SALARY]
                       FROM employees
                      WHERE JOB_ID = e.JOB_ID
                   GROUP BY JOB_ID);

-- CASE 연산자 ( 프로그래밍적 )
/* 107명의 직원 중 HR_REP(10%), MK_REP(12%), PR_REP(15%), SA_REP(18%), IT_PROG(20%) */
SELECT EMPLOYEE_ID
     , FIRST_NAME + ' ' + LAST_NAME AS [name]
     , JOB_ID
     ,SALARY
     ,CASE JOB_ID WHEN 'HR_REP' THEN SALARY * 1.10
                  WHEN 'MK_REP' THEN SALARY * 1.12
                  WHEN 'PR_REP' THEN SALARY * 1.15
                  WHEN 'SA_REP' THEN SALARY * 1.18
                  WHEN 'IT_PROG' THEN SALARY * 1.20
       ELSE SALARY END AS [NEW_SALARY]
  FROM employees;

-- ROLLUP, CUBE - GROUP BY 젤 마지막에 WITH ROLLUP
-- 부서와 업무별 급여합계를 구하여 신년 급여수준레벨을 지정하고자 한다.
-- 부서번호, 업무를 기준으로 그룹별로 나누고 급여합계와 인원수를 출력 (20개행)
-- CUBE보다 ROLLUP이 많이 사용됨.
SELECT DEPARTMENT_ID
     , JOB_ID
     , COUNT(EMPLOYEE_ID) AS [COUNT ENPs]
     , '$' + FORMAT(SUM(SALARY), '#.#') AS [SALARY SUM]
  FROM employees
GROUP BY DEPARTMENT_ID, JOB_ID
ORDER BY DEPARTMENT_ID;

SELECT DEPARTMENT_ID
     , JOB_ID
     , COUNT(EMPLOYEE_ID) AS [COUNT ENPs]
     , '$' + FORMAT(SUM(SALARY), '#.#') AS [SALARY SUM]
  FROM employees
GROUP BY DEPARTMENT_ID, JOB_ID WITH CUBE;

SELECT DEPARTMENT_ID
     , JOB_ID
     , COUNT(EMPLOYEE_ID) AS [COUNT ENPs]
     , '$' + FORMAT(SUM(SALARY), '#.#') AS [SALARY SUM]
  FROM employees
GROUP BY ROLLUP(DEPARTMENT_ID, JOB_ID);

-- RANK, ROW_NUMBER, FIRST_VALUE
-- 각 사원들의 부서별 급여 기준으로 내림차순으로 정렬. 순위를 같이 표시하시오. (107개행)
SELECT EMPLOYEE_ID
     , LAST_NAME
     , SALARY
     , DEPARTMENT_ID
     , RANK() OVER(ORDER BY SALARY DESC) AS [RANK_SAL]  -- 동등순위 중복증가 타입
     , DENSE_RANK() OVER(ORDER BY SALARY DESC) AS [DENSE_RANK_SAL] -- 동등순위 순차증가 타입
  FROM employees
ORDER BY SALARY DESC;

-- 각 행의 번호를 가져오는 함수
SELECT ROW_NUMBER() OVER(ORDER BY employee_id ASC)
       , *
  FROM employees
ORDER BY EMPLOYEE_ID ASC;

--
SELECT *