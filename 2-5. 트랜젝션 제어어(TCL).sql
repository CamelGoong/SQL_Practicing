/* Practice 데이터베이스 사용*/
USE PRACTICE;

/***************테이블 생성(Create)***************/
/* (회원테이블 존재할 시, 회원테이블 삭제) */
DROP TABLE 회원테이블;
/* 회원테이블 생성 */
CREATE TABLE 회원테이블(
회원번호 INT PRIMARY KEY,
이름 VARCHAR(20),
가입일자 DATE NOT NULL,
수신동의 BIT
);

/* 회원테이블 조회 */
SELECT *
	FROM 회원테이블;


/***************BEGIN + 취소(ROLLBACK)*******************/  
/* 트랜젝션 시작 */
BEGIN;

/* 데이터 삽입 */
INSERT INTO 회원테이블 VALUES(1001, '홍길동', '2020-01-02', 1);

/* 회원테이블 조회 */
SELECT *
	FROM 회원테이블;

/* 취소 */
ROLLBACK;


/* 회원테이블 조회 */
SELECT *
	FROM 회원테이블;

/***************BEGIN + 실행(COMMIT)*******************/  
/* 트랜젝션 시작 */
BEGIN;

/* 데이터 삽입 */
INSERT INTO 회원테이블 VALUES(1005, '장보고', '2020-01-06',1);

/* 실행 */
COMMIT;

/* 회원테이블 조회 */
SELECT *
	FROM 회원테이블;


/***************임시 저장(SAVEPOINT)*******************/ 
/* (회원테이블에 데이터 존재할 시, 데이터 모두 삭제) */
DELETE FROM  회원테이블;
/* 회원테이블 조회 */
SELECT *
	FROM 회원테이블;

/* 트랜젝션 시작 */
BEGIN;

/* 데이터 삽입 */
INSERT INTO 회원테이블 VALUES(1005, '장보고', '2020-01-06', 1);
/* SAVEPOINT 지정 */
SAVEPOINT S1;

/* 1005 회원 이름 수정 */
UPDATE 회원테이블
	SET 이름 ="이순신";
 
/* SAVEPOINT 지정 */
SAVEPOINT S2;

/* 1005 회원 데이터 삭제 */
DELETE
	FROM 회원테이블;
 
/* SAVEPOINT 지정 */
SAVEPOINT S3;

/* 회원테이블 조회 */
SELECT *
	FROM 회원테이블;

/* SAVEPOINT S2 저장점으로 ROLLBACK */
ROLLBACK TO S2;
 
/* 회원테이블 조회 */
SELECT *
	FROM 회원테이블;

/* 실행 */
COMMIT;

/* 회원테이블 조회 */
SELECT *
	FROM 회원테이블;
