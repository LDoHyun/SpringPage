DROP TABLE userlogin;

CREATE TABLE userlogin(
	username VARCHAR(40) NOT NULL PRIMARY KEY,
	password VARCHAR(60) NOT NULL,
	enabled NUMBER(1) DEFAULT 1
); 

INSERT INTO userlogin(username, password, enabled)
VALUES ('java1234', '$2a$10$b2b9rB3xcZR.X/aqaE6XqOShJbDOCQUELvO8w09h3.f7R.XUbLf6e' , 1);

