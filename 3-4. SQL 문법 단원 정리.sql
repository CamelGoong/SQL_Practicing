USE PRACTICE;


/***************데이터 조회(SELECT)***************/

/* 1. CUSTOMER 테이블의 가입연도별 및 지역별 회원수를 조회하시오.*/
/* FROM절 / GROUP BY절 / SELECT절 / YEAR 및 COUNT 함수 활용 */
SELECT *
FROM CUSTOMER;

SELECT YEAR(JOIN_DATE) AS 가입연도
		,ADDR
        ,COUNT(MEM_NO) AS 회원수
FROM CUSTOMER
GROUP
   BY YEAR(JOIN_DATE)
			,ADDR;

  
  
/* 2. (1) 명령어에서 성별이 남성회원 조건을 추가한 뒤, 회원수가 50명 이상인 조건을 추가하시오.*/
/* WHERE절 / HAVING절 활용 */
SELECT *
FROM CUSTOMER;

SELECT YEAR(JOIN_DATE) AS 가입연도
		,ADDR
        ,COUNT(MEM_NO) AS 회원수
FROM CUSTOMER
WHERE GENDER ="MAN"
GROUP
   BY YEAR(JOIN_DATE)
			,ADDR
HAVING 회원수 >= 50;

/* 3. (2) 명령어에서 회원수를 내림차순으로 정렬하시오.*/
/* ORDER BY절 활용 */
SELECT *
FROM CUSTOMER;

SELECT YEAR(JOIN_DATE) AS 가입연도
		,ADDR
        ,COUNT(MEM_NO) AS 회원수
FROM CUSTOMER
WHERE GENDER ="MAN"
GROUP
   BY YEAR(JOIN_DATE)
			,ADDR
HAVING 회원수 >= 50
 ORDER
	BY 회원수 DESC;
    
    
    
/***************데이터 조회(SELECT) + 테이블 결합(JOIN)***************/

/* 1. SALES 테이블 기준으로 PRODUCT 테이블을 LEFT JOIN 하시오.*/
/* LEFT JOIN 활용 */
SELECT *
FROM SALES AS A
LEFT
JOIN PRODUCT AS B
ON A.PRODUCT_CODE = B.PRODUCT_CODE;

/* 2. (1)에서 결합된 테이블을 활용하여, 브랜드별 판매수량을 구하시오. */
/* GROUP BY절 / SUM 함수 활용*/
SELECT BRAND
	   ,SUM(SALES_QTY) AS 브랜드별_판매수량
FROM SALES AS A
LEFT
JOIN PRODUCT AS B
ON A.PRODUCT_CODE = B.PRODUCT_CODE
GROUP
   BY  B.BRAND;

    
/* 3. CUSTOMER 및 SALES 테이블을 활용하여, 회원가입만하고 주문이력이 없는 회원수를 구하시오.*/
/* LEFT JOIN 활용 */    
SELECT COUNT(A.MEM_NO) AS 주문이력이_없는_회원수
FROM CUSTOMER AS A
LEFT
JOIN SALES AS B
ON A.MEM_NO = B.MEM_NO
WHERE B.ORDER_NO IS NULL; /* = NULL이 아니라 IS NULL 이런식으로 커맨드를 주어야 함*/


/***************데이터 조회(SELECT) + 테이블 결합(JOIN) + 서브 쿼리(Sub Query)***************/

/* 1. FROM절 서브쿼리를 활용하여, SALES 테이블의 PRODUCT_CODE별 판매수량을 구하시오. 조금 어려움!!!*/
/* FROM절 서브쿼리 / SUM 함수 활용 */
SELECT *
FROM SALES;

-- FROM절 서브쿼리의 경우에는 서브쿼리 절에서 가져오는 집계함수로 가져오는 새로운 열에 AS로 새로운 열 이름을 만들어줘야 하고, 새로운 테이블이 되는 서브쿼리 전체에 AS A로 테이블 이름도 만들어줘야 함.
-- 코드를 작성할 때, 서브쿼리 절을 다 작성을 마치고 이름 한번에 FROM () 절 안으로 감싸주는 것이 바람직한 방법

SELECT *
  FROM(
		SELECT PRODUCT_CODE
			   ,SUM(SALES_QTY) AS 판매수량
		  FROM SALES
		  GROUP
			 BY PRODUCT_CODE
) AS A;


/* 2. (1) 명령어를 활용하여, PRODUCT 테이블과 LEFT JOIN 하시오.*/
/* LEFT JOIN 활용 */
SELECT *
  FROM(
		SELECT PRODUCT_CODE
			   ,SUM(SALES_QTY) AS 판매수량
		  FROM SALES
		  GROUP
			 BY PRODUCT_CODE
) AS A
LEFT
JOIN PRODUCT AS B
  ON A.PRODUCT_CODE = B.PRODUCT_CODE;
        

/* 3. (2) 명령어를 활용하여, 카테고리 및 브랜드별 판매수량을 구하시오.*/
/* GROUP BY절 / SUM 함수 활용*/
SELECT CATEGORY
      ,BRAND
      ,SUM(판매수량) AS 판매수량
  FROM(
		SELECT PRODUCT_CODE
			   ,SUM(SALES_QTY) AS 판매수량
		  FROM SALES
		  GROUP
			 BY PRODUCT_CODE
) AS A
LEFT
JOIN PRODUCT AS B
  ON A.PRODUCT_CODE = B.PRODUCT_CODE
GROUP
   BY CATEGORY
      ,BRAND;
  
        
