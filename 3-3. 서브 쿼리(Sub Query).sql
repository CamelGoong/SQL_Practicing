USE PRACTICE;


/***************SELECT절 서브 쿼리***************/
/* SELECT 명령문 안에 SELECT 명령문 */
SELECT *
		,(SELECT GENDER FROM CUSTOMER WHERE A.MEM_NO = MEM_NO) AS GENDER /*SALESW 테이블을 A라고 지정한뒤, CUSTOMER 테이블이 GENDER를 조회할 수 있도록 함*/
FROM SALES AS A;
/*이렇게 하면 JOIN을 사용하지 않고도, SALES 테이블에 GENDER열이 함께 조회되었음*/


/* 확인 */
SELECT *
FROM CUSTOMER
WHERE MEM_NO = "1000970";

/* SELECT절 서브 쿼리 vs 테이블 결합(JOIN) 처리 속도 비교 */
-- SELECT절 서브쿼리는 테이블 결합에 비해서 속도가 늦기 때문에 잘 사용하지는 않음
SELECT A.*
		,B.GENDER
FROM SALES AS A
LEFT
JOIN CUSTOMER AS B
ON A.MEM_NO = B.MEM_NO;


/***************FROM절 서브 쿼리***************/
/* FROM 명령문 안에 SELECT 명령문 */
-- FROM 절 안에는 테이블이 와야되고, 그 테이블을 GROUP BY를 통해서 만들어줄 수 있음

SELECT *
FROM (
		SELECT MEM_NO
				,COUNT(ORDER_NO) AS 주문횟수
		FROM SALES
        GROUP
        BY MEM_NO
	) AS A;
    
-- 위에서 주의할 점은 주문횟수는 테이블이기 때문에 반드시 열과 테이블명을 지정해주어야 함
/* FROM절 서브 쿼리: 열 및 테이블명 지정 */       

            
/***************WHERE절 서브 쿼리***************/
/* WHERE 명령문 안에 SELECT 명령문, SALES 테이블에서 CUSTOMER 테이블의 가입일자가 2019년인 사람의 주문횟수를 조회하는 것*/
SELECT COUNT(ORDER_NO) AS 주문횟수
FROM SALES
WHERE MEM_NO IN (SELECT MEM_NO FROM CUSTOMER WHERE YEAR(JOIN_DATE) = 2019); -- IN 연산자 뒤에는 LIST형태가 와야함
/* 2019년도에 가입한 회원의 주문 횟수 구하기 */

/* YEAR: 날짜형 함수 / 연도 변환 */    
SELECT *
		,YEAR(JOIN_DATE)
FROM CUSTOMER;

/* 리스트 */
SELECT MEM_NO FROM CUSTOMER WHERE YEAR(JOIN_DATE) = 2019;


/* WHERE절 서브 쿼리 vs 데이터 결합(JOIN) 결과 값 비교 */
SELECT COUNT(ORDER_NO) AS 주문횟수
FROM SALES AS A
INNER
JOIN CUSTOMER AS B
ON A.MEM_NO = B.MEM_NO
WHERE YEAR(B.JOIN_DATE) = 2019;
 
/***************서브 쿼리(Sub Query) + 테이블 결합(JOIN)***************/
/* 임시테이블 생성 */
CREATE TEMPORARY TABLE SALES_SUB_QUERY
SELECT A.구매횟수
		,B.*
FROM (
		SELECT MEM_NO
				,COUNT(ORDER_NO) AS 구매횟수
		FROM SALES
        GROUP
        BY MEM_NO
) AS A
INNER
JOIN CUSTOMER AS B
ON A.MEM_NO = B.MEM_NO;

/* 임시테이블 조회 */
SELECT * FROM SALES_SUB_QUERY;

/* 성별이 남성 조건으로 필터링하여 */
SELECT *
FROM SALES_SUB_QUERY
WHERE GENDER = "MAN";

/* 거주지역별로 구매횟수 집계 */
SELECT ADDR
		, SUM(구매횟수) AS 구매횟수
FROM SALES_SUB_QUERY
WHERE GENDER = 'MAN'
GROUP
BY ADDR;


/* 구매횟수 100회 미만 조건으로 필터링 */
SELECT ADDR
		, SUM(구매횟수) AS 구매횟수
FROM SALES_SUB_QUERY
WHERE GENDER = 'MAN'
GROUP
BY ADDR
HAVING SUM(구매횟수) < 100;

/* 모든 열 조회 */
/* 구매횟수가 낮은 순으로 */
SELECT ADDR
		, SUM(구매횟수) AS 구매횟수
FROM SALES_SUB_QUERY
WHERE GENDER = 'MAN'
GROUP
BY ADDR
HAVING SUM(구매횟수) < 100
ORDER
BY SUM(구매횟수) ASC;

 
 
/***************FROM절 서브 쿼리(Sub Query) 작성법***************/
SELECT	A.구매횟수
		,B.*
  FROM (
		SELECT  MEM_NO
				,COUNT(ORDER_NO) AS 구매횟수
		  FROM SALES
		  GROUP
			 BY MEM_NO
		) AS A
INNER
 JOIN CUSTOMER AS B
   ON A.MEM_NO = B.MEM_NO;






    