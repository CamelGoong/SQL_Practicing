USE PRACTICE;

/***************FROM***************/
/* Customer 테이블 모든 열 조회 */
SELECT *
	FROM CUSTOMER;

/***************WHERE***************/

/* 성별이 남성 조건으로 필터링 */
SELECT *
	FROM CUSTOMER
    WHERE GENDER = 'MAN';
 
 
/***************GROUP BY***************/

/* 지역별로 회원수 집계 */
SELECT ADDR
		, COUNT(MEM_NO) AS 회원수 /*MEM_NO라는 열을 기준으로 '회원수'라는 새 이름으로 COUNT해서 GROUP화*/
	FROM CUSTOMER
    WHERE GENDER = 'MAN'
    GROUP
	BY ADDR;
    
/* COUNT: 행들의 개수를 구하는 집계함수 */


/***************HAVING***************/

/* 집계 회원수 100명 미만 조건으로 필터링 */
SELECT ADDR
		, COUNT(MEM_NO) AS 회원수 /*MEM_NO라는 열을 기준으로 '회원수'라는 새 이름으로 COUNT해서 GROUP화*/
	FROM CUSTOMER
    WHERE GENDER = 'MAN'
    GROUP
	BY ADDR
    HAVING COUNT(MEM_NO) < 100;
    
/* < : 비교 연산자 / ~ 보다 작은*/


/***************ORDER BY***************/

/* 집계 회원수가 높은 순으로 */
SELECT ADDR
		, COUNT(MEM_NO) AS 회원수 /*MEM_NO라는 열을 기준으로 '회원수'라는 새 이름으로 COUNT해서 GROUP화*/
	FROM CUSTOMER
    WHERE GENDER = 'MAN'
    GROUP
	BY ADDR
    HAVING COUNT(MEM_NO) < 100
    ORDER
    BY COUNT(MEM_NO) DESC;
    
/* DESC : 내림차순 / ASC : 오름차순 */


/***************FROM -> (WHERE) -> GROUP BY***************/

/* FROM -> GROUP BY 순으로 작성해도 됩니다. */
SELECT ADDR
	,COUNT(MEM_NO) AS 회원수
FROM CUSTOMER

/*WHERE 생략가능*/
GROUP
	BY ADDR;


/***************GROUP BY + 집계함수***************/
/* 거주지역을 서울, 인천 조건으로 필터링 */
/* 거주지역 및 성별로 회원수 집계 */
SELECT ADDR
		,GENDER
		,COUNT(MEM_NO) AS 회원수
FROM CUSTOMER
WHERE ADDR IN ('SEOUL', 'INCHEON')
GROUP
	BY ADDR
		,GENDER;

/* IN : 특수 연산자 / IN (List) / 리스트 값만 */

/* GROUP BY에 있는 열들을 SELECT에도 작성해야 원하는 분석 결과를 확인할 수 있습니다. */


/***************SQL 명령어 작성법***************/
/* 회원테이블(Customer)을 */
/* 성별이 남성 조건으로 필터링하여 */
/* 거주지역별로 회원수 집계 */
/* 집계 회원수 100명 미만 조건으로 필터링 */
/* 모든 열 조회 */
/* 집계 회원수가 높은 순으로 */
SELECT ADDR
		,COUNT(MEM_NO) AS 회원수
FROM CUSTOMER
WHERE GENDER = 'MAN'
GROUP
	BY ADDR
HAVING COUNT(MEM_NO) < 100
ORDER
	BY 회원수 ASC;














