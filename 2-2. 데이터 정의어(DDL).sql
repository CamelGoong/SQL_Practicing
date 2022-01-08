/* Practice 이름으로 데이터베이스 생성*/
CREATE DATABASE Practice;

/* Practice 데이터베이스 사용*/
USE Practice;


/***************테이블 생성(Create)***************/
/* 회원테이블 생성 */
CREATE TABLE 회원테이블 (
회원번호 INT PRIMARY KEY,
이름 VARCHAR(20), /*최대 20바이트까지 저장가능*/
가입일자 DATE NOT NULL,
수신동의 BIT
);

/* 기본키(PRIMARY KEY): 중복되어 나타날 수 없는 단일 값 + NOT NULL */
/* NOT NULL: NULL 허용하지 않음 */

/* 회원테이블 조회 */
select * /*모든 열 조회*/
	from 회원테이블;
  
  
/***************테이블 열 추가*******************/  
/* 성별 열 추가 */  
ALTER TABLE 회원테이블 ADD 성별 VARCHAR(2); 
 
/* 회원테이블 조회 */
SELECT * FROM 회원테이블;
 
 
/***************테이블 열 데이터 타입 변경***************/  
/* 성별 열 타입 변경 */  
ALTER TABLE 회원테이블 MODIFY 성별 VARCHAR(20);
 
 
/***************테이블 열 이름 변경**************/  
/* 성별 -> 성 열 이름 변경 */  
ALTER TABLE 회원테이블 CHANGE 성별 성 VARCHAR(2);
 
/***************테이블명 변경**************/  
/* 테이블명 변경 */  
ALTER TABLE 회원테이블 RENAME 회원정보;
 
/* 회원테이블 조회 --> 이름이 변경되었기 때문에 조회되지 않음*/
SELECT * FROM 회원테이블;
  
/* 회원정보 조회 */
SELECT * FROM 회원정보;
  
  
/***************테이블 삭제**************/  
/* 테이블 삭제 */  
DROP TABLE 회원정보;
/* 회원정보 조회 --> 삭제되었기 때문에 조회되지 않음*/
SELECT * FROM 회원정보;