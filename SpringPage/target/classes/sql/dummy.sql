-- dummy member generator

DELETE users; 

CREATE OR REPLACE PROCEDURE dummy_gen_proc
IS
BEGIN
    FOR i IN 1..100 LOOP   
        INSERT INTO users VALUES
        ('servlet' || (1110+i),
         'hint01', 'fsdfsfg',
         '서블릿' || (1110+i),
          '12345',  '부천*학교',  
          '서울 구로*학원',  
          '010', '1234', '5678',
          'servlet' || (110+i), 'naver.com',
          SYSDATE, '1990-01-01', 0, 0);   
         
       INSERT INTO USER_ROLES VALUES
         (user_roles_seq.nextval,
         'servlet' || (1110+i),
         'ROLE_USER');
     END LOOP;
 
    COMMIT;    
END;
/
EXECUTE dummy_gen_proc; 
/*-----------------------------------------------------*/
CREATE OR REPLACE PROCEDURE dummy_gen_proc2
IS
BEGIN
 
    FOR i IN 1..100 LOOP
        INSERT INTO userlogin VALUES
        ('servlet' || (1110+i),
         '$2a$10$pg/Y4O3EeOipcUcjP2kWW.HBgAqenro8u6EBaAhQL/BthXR7KZquK', /*비번:#abcd1234*/
          1);
     END LOOP;
 
    COMMIT;    
END;
/
EXECUTE dummy_gen_proc2; 
/*------------------------------------------*/
CREATE OR REPLACE PROCEDURE dummy_gen_proc3
IS
BEGIN
 
    FOR i IN 1..100 LOOP
        INSERT INTO board VALUES
        (board_seq.nextval ,'글쓴이' || (1110+i) , 'abcd1234', '스프링' || (1110+i) , 5, '스프링프레임워크', SYSDATE);
     END LOOP;
 
    COMMIT;    
END;
/
EXECUTE dummy_gen_proc3; 
/*------------------------------------------*/
CREATE OR REPLACE PROCEDURE dummy_gen_proc4
IS
BEGIN
 
    FOR i IN 1..100 LOOP
        INSERT INTO board(boardNum, boardName, boardPass, 
				  		  boardSub, boardContent, boardFile, boardReRef, 
				  		  boardReLev, boardReSeq, boardDate) VALUES
        (board_seq.nextval ,'servlet' || (1110+i) , 
        'abcd1234', '커피 후기' || (0+i) , 
        '원두 구입 만족', 0,0,0,0, SYSDATE);
     END LOOP;
 
    COMMIT;    
END;
/
EXECUTE dummy_gen_proc4; 
