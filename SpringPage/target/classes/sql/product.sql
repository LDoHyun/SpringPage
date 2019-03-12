/*운영자 상품추가*/
CREATE TABLE product(
	pnum NUMBER(5) NOT NULL,	  /*상품번호*/
	pname VARCHAR(40) NOT NULL,	  /*상품이름*/
	pkind VARCHAR(20) NOT NULL,   /*상품종류*/
	price NUMBER(5) NOT NULL,	  /*가격*/
	pfile VARCHAR(40) NOT NULL, 	  /*사진*/
	country VARCHAR(20) NOT NULL, /*원산지*/
	hardgrove VARCHAR(20),		  /*원두분쇄율*/
	capacity VARCHAR(10),         /*용량*/
	pcount NUMBER(2),	          /*구입갯수*/
	PRIMARY KEY(pnum)			  /*고유키(상품번호)*/
);

/* 가입자 상품구매 */
CREATE TABLE order_tbl(
	order_seq NUMBER(5) NOT NULL PRIMARY KEY,
	pnum NUMBER(5) NOT NULL,	  /*상품번호*/
	pname VARCHAR(40) NOT NULL,	  /*상품이름*/
	price NUMBER(5) NOT NULL,	  /*가격*/
    totprice NUMBER(5) NOT NULL,
    totshipprice NUMBER(5) NOT NULL,
	pfile VARCHAR(40) NOT NULL, 	  /*사진*/
	hardgrove VARCHAR(20),		  /*원두분쇄율*/
	capacity VARCHAR(10),         /*용량*/
	pcount NUMBER(2),
	
    /*받는 사람*/
    username VARCHAR(40) NOT NULL, /*아이디*/
	name VARCHAR(40) NOT NULL, 	  /*이름*/
    postcode VARCHAR(5) NOT NULL,  /*우편번호*/
    address VARCHAR(200) NOT NULL, /*주소 */
    address2 VARCHAR(200) NOT NULL,/*상세주소*/
    phone VARCHAR(3) NOT NULL, 	   /*핸드폰 번호*/
    phone2 VARCHAR(4) NOT NULL,
    phone3 VARCHAR(4) NOT NULL,
    email VARCHAR(20) NOT NULL,  	 /*이메일 아이디*/
    email2 VARCHAR(20) NOT NULL,	 /*이메일 주소*/
    memo VARCHAR(255)	 /*메모*/
);

/* 관싱상품 */
CREATE TABLE wishlist(
	pnum NUMBER(5) NOT NULL,	  /*상품번호*/
	pname VARCHAR(40) NOT NULL,   /*상품이름*/
	pkind VARCHAR(20) NOT NULL,   /*상품종류*/
	price NUMBER(5) NOT NULL,	  /*가격*/
	pfile VARCHAR(40) NOT NULL,   /*사진*/
	country VARCHAR(20) NOT NULL, /*원산지*/
	hardgrove VARCHAR(20),		  /*원두분쇄율*/
	capacity VARCHAR(10) NOT NULL,/*용량*/
	pcount NUMBER(2) NOT NULL,	  /*구입갯수*/
	PRIMARY KEY(pnum)			  /*고유키(상품번호)*/
);

DROP TABLE product;

CREATE SEQUENCE order_seq
START WITH 1
INCREMENT BY 1
MAXVALUE 99999
NOCYCLE;

CREATE SEQUENCE product_seq
START WITH 1
INCREMENT BY 1
MAXVALUE 99999
NOCYCLE;

INSERT INTO product(pnum, pname, pkind, price, pfile, country)
VALUES (product_seq.nextval, '탄자니아AA', 'coffee', '9000', 'coffee_01' ,'탄자니아');

INSERT INTO product(pnum, pname, pkind, price, pfile, country)
VALUES (product_seq.nextval, '인도네시아 만델링', 'coffee', '10000', 'coffee_02' ,'인도네시아');

INSERT INTO product(pnum, pname, pkind, price, pfile, country)
VALUES (product_seq.nextval, '에티오피아 시다모', 'coffee', '9000', 'coffee_03' ,'에티오피아');

INSERT INTO product(pnum, pname, pkind, price, pfile, country)
VALUES (product_seq.nextval, '과테말라 안티구아 SHB', 'coffee', '9000', 'coffee_04' ,'과테말라');

INSERT INTO product(pnum, pname, pkind, price, pfile, country)
VALUES (product_seq.nextval, '콜롬비아 슈프리모', 'coffee', '9000', 'coffee_05' ,'콜롬비아');

INSERT INTO product(pnum, pname, pkind, price, pfile, country)
VALUES (product_seq.nextval, '케냐AA', 'coffee', '10000', 'coffee_06' ,'케냐');

INSERT INTO product(pnum, pname, pkind, price, pfile, country)
VALUES (product_seq.nextval, 'JC 하우스 블랜드', 'coffee', '11000', 'coffee_07' ,'에티오피아');

INSERT INTO product(pnum, pname, pkind, price, pfile, country)
VALUES (product_seq.nextval, '달님커피', 'coffee', '11000', 'coffee_08' ,'베트남');

INSERT INTO product(pnum, pname, pkind, price, pfile, country)
VALUES (product_seq.nextval, '아라비카 위드 커피', 'coffee', '11000', 'coffee_09' ,'탄자니아');

/*---------------------------------------------------*/
INSERT INTO product(pnum, pname, pkind, price, pfile, country)
VALUES (product_seq.nextval, '산타 클라라 (PET)', 'dutch_coffee', '22000', 'dutch_01', '파나마');

INSERT INTO product(pnum, pname, pkind, price, pfile, country)
VALUES (product_seq.nextval, '수프리모 메델린 (PET)', 'dutch_coffee', '22000',  'dutch_02','콜롬비아');

INSERT INTO product(pnum, pname, pkind, price, pfile, country)
VALUES (product_seq.nextval, '파젠다 산타 루시아 (PET)', 'dutch_coffee', '22000',  'dutch_03','브라질');

INSERT INTO product(pnum, pname, pkind, price, pfile, country)
VALUES (product_seq.nextval, '수마트라 만델링 (PET)', 'dutch_coffee', '22000',  'dutch_04','인도네시아');

INSERT INTO product(pnum, pname, pkind, price, pfile, country)
VALUES (product_seq.nextval, '이르가체페(PET)', 'dutch_coffee', '22000',  'dutch_05','에티오피아');

INSERT INTO product(pnum, pname, pkind, price, pfile, country)
VALUES (product_seq.nextval, '비비드 더치커피 250ml', 'dutch_coffee', '6500',  'dutch_06','탄자니아');

INSERT INTO product(pnum, pname, pkind, price, pfile, country)
VALUES (product_seq.nextval, '수마트라 만델링', 'dutch_coffee', '26000',  'dutch_07','인도네시아');

INSERT INTO product(pnum, pname, pkind, price, pfile, country)
VALUES (product_seq.nextval, '파젠다 산타 루시아', 'dutch_coffee', '26000',  'dutch_08','브라질');

INSERT INTO product(pnum, pname, pkind, price, pfile, country)
VALUES (product_seq.nextval, '수프리모 메델린', 'dutch_coffee', '26000',  'dutch_09','콜롬비아');

INSERT INTO product(pnum, pname, pkind, price, pfile, country)
VALUES (product_seq.nextval, '산타 클라라', 'dutch_coffee', '26000',  'dutch_10','파나마');

INSERT INTO product(pnum, pname, pkind, price, pfile, country)
VALUES (product_seq.nextval, '이르가체페', 'dutch_coffee', '26000',  'dutch_11','에티오피아');

/*-------------------------------------------*/
INSERT INTO product(pnum, pname, pkind, price, pfile, country)
VALUES (product_seq.nextval, 'YELLOW MED 500ml', 'event', '12000', 'event_01', '브라질');

INSERT INTO product(pnum, pname, pkind, price, pfile, country)
VALUES (product_seq.nextval, 'COBALT BLUE 500ml', 'event', '12000', 'event_02', '콜롬비아');

INSERT INTO product(pnum, pname, pkind, price, pfile, country)
VALUES (product_seq.nextval, 'RED DEEP 500ml', 'event', '12000', 'event_03', '파나마');

INSERT INTO product(pnum, pname, pkind, price, pfile, country)
VALUES (product_seq.nextval, '블렌딩 500ml 3종 세트', 'event', '30000', 'event_04', '에티오피아');

DROP TABLE product;

/*INSERT INTO order_tbl(pnum, pname, pkind, price, 
				  	  country, hardgrove, capacity, pcount)
VALUES (product_seq.nextval, 'hint_01', 'asd', '홍길동', '07758', '서울 구로구 가마산로 87', 
		'한일유앤아이아파트 504호', '010','1234','5678', 'java1234', 'naver.com');*/

/*coffee
dutch_coffee
event*/