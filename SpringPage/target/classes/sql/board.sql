/*게시글 정보*/
CREATE TABLE board (
	boardNum NUMBER(5) default 0,		/*게시글 번호*/
	boardName VARCHAR(30) NOT NULL,		/*작성자 이름*/
	boardPass VARCHAR(20) NOT NULL,		/*게시글 비밀번호*/
	boardSub VARCHAR(50) NOT NULL,		/*게시글 제목*/
	boardContent VARCHAR(2000) NOT NULL,/*게시글 내용*/
	boardFile VARCHAR(50),				/*첨부파일*/
	boardReRef INT NOT NULL,			/*답글참조번호*/
	boardReLev INT NOT NULL,			/*답글 레벨*/
	boardReSeq INT NOT NULL,			/*답글 시퀀스*/
	boardReadCount INT DEFAULT 0,		/*게시글 조회수*/
	boardDate DATE DEFAULT SYSDATE,		/*게시글 날짜*/
	PRIMARY KEY(boardNum)				/*고유키(게시글번호)*/
);

DROP TABLE board;
DROP SEQUENCE board_seq;

CREATE SEQUENCE board_seq
START WITH 1
INCREMENT BY 1
MAXVALUE 99999
NOCYCLE;

/*공지사항 정보*/
CREATE SEQUENCE notice_seq
START WITH 1
INCREMENT BY 1
MAXVALUE 99999
NOCYCLE;

CREATE TABLE notice (
	boardNum NUMBER(5) default 0,		/*게시글 번호*/
	boardName VARCHAR(30) NOT NULL,		/*작성자 이름*/
	boardPass VARCHAR(20) NOT NULL,		/*게시글 비밀번호*/
	boardSub VARCHAR(50) NOT NULL,		/*게시글 제목*/
	boardContent VARCHAR(2000) NOT NULL,/*게시글 내용*/
	boardFile VARCHAR(50),				/*첨부파일*/
	boardReRef INT NOT NULL,			/*답글참조번호*/
	boardReLev INT NOT NULL,			/*답글 레벨*/
	boardReSeq INT NOT NULL,			/*답글 시퀀스*/
	boardReadCount INT DEFAULT 0,		/*게시글 조회수*/
	boardDate DATE DEFAULT SYSDATE,		/*게시글 날짜*/
	PRIMARY KEY(boardNum)				/*고유키(게시글번호)*/
);

INSERT INTO notice(boardNum, boardName, boardPass, 
				  boardSub, boardContent, boardFile, boardReRef, boardReLev, boardReSeq, boardDate)
VALUES (notice_seq.nextval ,'운영자', '12345678', '주요 공지사항', '안녕하세요', 0,0,0,0, SYSDATE);

INSERT INTO board(boardNum, boardName, boardPass, 
				  boardSub, boardContent, boardFile, boardReRef, boardReLev, boardReSeq, boardDate)
VALUES (board_seq.nextval ,'홍길동', 'abcd1234', '커피 후기', '케냐AA 구입', 0,0,0,0, SYSDATE);

CREATE OR REPLACE PROCEDURE spring_board_dummy_gen_proc
IS
BEGIN
 
    FOR i IN 1..100 LOOP
        INSERT INTO board VALUES
        (
            board_seq.NEXTVAL,
            '글쓴이' || i,
            '12345678',
            '글쓴이의 글 제목' || i,
            5,
            '글쓴이의 글 내용' || i,
            null,
            board_seq.NEXTVAL,
            0,
            0,
            0,
            sysdate
        );
     END LOOP;
 
    COMMIT;    
END;
/
 
EXECUTE spring_board_dummy_gen_proc;