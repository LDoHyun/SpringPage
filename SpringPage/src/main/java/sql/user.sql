/*회원정보*/
CREATE TABLE users (
  username VARCHAR(40) 			 /*아이디고유키(아이디)*/
  NOT NULL PRIMARY KEY, 
  passhint VARCHAR(10) NOT NULL, /*비밀번호 힌트*/
  passans VARCHAR(60) NOT NULL,  /*비밀번호 답변*/
  name VARCHAR(40) NOT NULL, 	 /*이름*/
  postcode VARCHAR(5) NOT NULL,  /*우편번호*/
  address VARCHAR(200) NOT NULL, /*주소 */
  address2 VARCHAR(200) NOT NULL,/*상세주소*/
  phone VARCHAR(3) NOT NULL, 	 /*핸드폰 번호*/
  phone2 VARCHAR(4) NOT NULL,
  phone3 VARCHAR(4) NOT NULL,
  email VARCHAR(20) NOT NULL,  	 /*이메일 아이디*/
  email2 VARCHAR(20) NOT NULL,	 /*이메일 주소*/
  joindate DATE DEFAULT SYSDATE NOT NULL, /*가입날짜 (현재날짜 입력)*/
  birthday DATE NOT NULL, 				 /*생일*/
  chemail NUMBER(1), 			 /*이메일 수신여부*/
  chphone NUMBER(1)  			 /*문자 순신여부*/
 );
/*회원구분 (회원, 운영자)*/
CREATE TABLE user_roles (
  user_role_id number(11) NOT NULL, /*회원번호*/
  username varchar(45) NOT NULL,	/*아이디*/
  role varchar(45) NOT NULL,		/*회원구분*/
  PRIMARY KEY (username),			/*고유키(아이디)*/
  CONSTRAINT fk_username FOREIGN KEY (username) 
     REFERENCES users (username)	/*회원정보 아이디와 연결*/
  on delete cascade
);
/*회원 로그인*/
CREATE TABLE userlogin(
	username VARCHAR(40) 
	NOT NULL PRIMARY KEY, 		  /*아이디*/
	password VARCHAR(60) NOT NULL,/*비밀번호*/ 			   
	enabled NUMBER(1) DEFAULT 1
); 

DROP TABLE users;
DROP TABLE user_roles;
DROP SEQUENCE user_roles_seq;

INSERT INTO users(username, passhint, passans, name, 
				  postcode, address, address2, phone, 
				  phone2, phone3, email, email2, joindate, birthday)
VALUES ('java1234', 'hint_01', 'asd', '홍길동', '07758', '서울 구로구 가마산로 87', 
		'한일유앤아이아파트 504호', '010','1234','5678', 'java1234', 'naver.com', SYSDATE, sysdate);

/*
CREATE TABLE user_roles (
  user_role_id number(11) NOT NULL,
  username varchar(45) NOT NULL,
  role varchar(45) NOT NULL,
  PRIMARY KEY (user_role_id),
  CONSTRAINT fk_username FOREIGN KEY (username) 
     REFERENCES users (username)
);
*/

INSERT INTO user_roles (user_role_id, username, ROLE)
VALUES (user_roles_seq.nextval, 'admin', 'ROLE_ADMIN');

INSERT INTO user_roles (user_role_id, username, ROLE)
VALUES (user_roles_seq.nextval, 'java1234', 'ROLE_USER');

CREATE SEQUENCE user_roles_seq
	start with 1
	increment by 1
	maxvalue 99999
    nocycle;
    
SELECT * FROM users WHERE username='java1234';
SELECT * FROM users;

DELETE FROM "OJ"."USER_ROLES"
WHERE ROWID = 'AAAFYxAABAAALGxAAB' 
AND ORA_ROWSCN = '3041324' 
and ( "USER_ROLE_ID" is null or "USER_ROLE_ID" is not null )

/*--------------------- 관리자 계정 ---------------------*/
INSERT INTO userlogin(username, password, enabled)
VALUES ('do5541hyun', '$2a$10$pg/Y4O3EeOipcUcjP2kWW.HBgAqenro8u6EBaAhQL/BthXR7KZquK' , 1);

INSERT INTO user_roles (user_role_id, username, ROLE)
VALUES (user_roles_seq.nextval, 'do5541hyun', 'ROLE_ADMIN');

INSERT INTO users(username, passhint, passans, name, 
				  postcode, address, address2, phone, 
				  phone2, phone3, email, email2, joindate, birthday)
VALUES ('do5541hyun', 'hint_01', 'asd', '이도현', '07758', '서울 구로구 가마산로 87', 
		'한일유앤아이아파트 504호', '010','1234','5678', 'do5541hyun', 'naver.com', SYSDATE, SYSDATE);