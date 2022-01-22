USE PRACTICE;

/****************************************************************************/
/************************************VIEW************************************/
/****************************************************************************/

/***************테이블 결합***************/
/* 주문(Sales) 테이블 기준, 상품(Product) 테이블 LEFT JOIN 결합 */
SELECT A.*
	   ,A.SALES_QTY * B.PRICE AS 결제금액
FROM SALES AS A
LEFT
JOIN PRODUCT AS B
ON A.PRODUCT_CODE = B.PRODUCT_CODE;

/***************VIEW 생성***************/
CREATE VIEW SALES_PRODUCT AS /* 위의 기존 코드에 앞에 이것만 붙여주면 됨. */
SELECT A.*
	   ,A.SALES_QTY * B.PRICE AS 결제금액
FROM SALES AS A
LEFT
JOIN PRODUCT AS B
ON A.PRODUCT_CODE = B.PRODUCT_CODE;


/***************VIEW 실행***************/
SELECT *
  FROM SALES_PRODUCT;


/***************VIEW 수정***************/
ALTER VIEW SALES_PRODUCT AS /* 위의 VIEW를 생성할 때, CREATE VIEW -> ALTER VIEW로 한 단어만 바꿔주고, 밑에 VIEW로 만들 TABLE의 수정사항을 입력해주면 됨. */
SELECT A.*
	   ,A.SALES_QTY * B.PRICE * 1.1 AS 결제금액_수수료포함
FROM SALES AS A
LEFT
JOIN PRODUCT AS B
  ON A.PRODUCT_CODE = B.PRODUCT_CODE;

/* 확인 */
SELECT *
  FROM SALES_PRODUCT;

/***************VIEW 삭제***************/
DROP VIEW SALES_PRODUCT;

/***************VIEW 특징(중복되는 열 저장 안됨)***************/
/* VIEW가 생성되지 않음. A테이블과 B테이블에 PRODUCT_CODE열이 중복으로 존재하기 때문에, SELECT에서 하나의 열만 선택을 해줘야 문제가 발생하지 않음.*/
CREATE VIEW SALES_PRODUCT AS
SELECT *
  FROM SALES AS A
  LEFT
  JOIN PRODUCT AS B
    ON A.PRODUCT_CODE = B.PRODUCT_CODE;
    
/****************************************************************************/
/********************************PROCEDURE***********************************/
/****************************************************************************/

/***************IN 매개변수***************/    /* 매개변수를 프로시져로 전달. */
-- DELIMITER는 여려 명령어들을 하나로 묶어줄 때 사용.
DELIMITER //
CREATE PROCEDURE CST_GEN_ADDR_IN( IN INPUT_A VARCHAR(20), INPUT_B VARCHAR(20) ) -- IN 매개변수로써, INPUT_A와 INPUT_B라는 2개의 매개변수를 생성하였음. / VARCHAR(20)은 각 매개변수의 데이터타입임.
BEGIN  -- BEGIN하고 END 사이에 매개변수를 활용한 명령어들을 작성.
	SELECT *
      FROM CUSTOMER
	 WHERE GENDER = INPUT_A -- 조건1
     AND ADDR = INPUT_B;    -- 조건2
END // -- 여기서의 // 기호는 DELIMITER가 끝나는 지점을 가리킴.
DELIMITER ;

/* DELIMITER: 여러 명령어들을 하나로 묶어줄때 사용 */

/***************PROCEDURE 실행***************/
CALL CST_GEN_ADDR_IN('MAN', 'SEOUL');
CALL CST_GEN_ADDR_IN('WOMEN', 'INCHEON');

/***************PROCEDURE 삭제***************/
DROP PROCEDURE CST_GEN_ADDR_IN;

/**************OUT 매개변수***************/  /* 결괏값을 반환, 위의 IN 매개변수 코드에다가 괄호 안에 OUT매개변수만 추가적으로 작성한 것.*/  
DELIMITER //
CREATE PROCEDURE CST_GEN_ADDR_IN_CNT_MEM_OUT( IN INPUT_A VARCHAR(20), INPUT_B VARCHAR(20), OUT CNT_MEM INT)  -- OUT매개변수인 INT데이터타입의 CNT_MEM명 변수를 생성.
BEGIN
	SELECT COUNT(MEM_NO) /* 회원수 조회 */
      INTO CNT_MEM /* OUT매개변수인 CNT_MEM에 결괏값을 반환 */
	  FROM CUSTOMER
	WHERE GENDER = INPUT_A
      AND ADDR = INPUT_B;
END //
DELIMITER ;



/***************PROCEDURE 실행***************/
CALL CST_GEN_ADDR_IN_CNT_MEM_OUT('WOMEN', 'INCHEON', @NUMBER_OF_WOMEN_INCHEON); /* OUT매개변수는 이런식으로 앞에 @원하는이름 으로 작성. */
SELECT @NUMBER_OF_WOMEN_INCHEON;

/**************IN/OUT 매개변수***************/    /* IN/OUT매개변수의 성질을 모두 가지고 있는 매개변수*/
DELIMITER //
CREATE PROCEDURE IN_OUT_PARAMETER( INOUT COUNT INT) /* 매개변수 COUNT는 아래와 같이 IN매개변수이면서, 동시에 +10을 해서 반환하는 OUT매개변수의 성질도 갖추고 있음.*/
BEGIN
	SET COUNT = COUNT + 10;
END //
DELIMITER ;



/***************PROCEDURE 실행***************/
SET @COUNTER = 1; -- 변수 생성
CALL IN_OUT_PARAMETER(@COUNTER);
SELECT @COUNTER;