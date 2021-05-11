--기존 테이블,시퀀스 삭제

DROP TABLE USERS CASCADE CONSTRAINTS;
DROP SEQUENCE USERS_SEQ;
DROP TABLE ROOM CASCADE CONSTRAINTS;
DROP SEQUENCE ROOM_SEQ;
DROP TABLE BOARDS CASCADE CONSTRAINTS;
DROP SEQUENCE BOARDS_SEQ;
DROP TABLE FACILITY CASCADE CONSTRAINTS;
DROP SEQUENCE FACILITY_SEQ;
DROP TABLE FILTER CASCADE CONSTRAINTS;
DROP SEQUENCE FILTER_SEQ;
DROP TABLE RESTAURANT CASCADE CONSTRAINTS;
DROP SEQUENCE RESTAURANT_SEQ;
DROP TABLE COMMENTS CASCADE CONSTRAINTS;
DROP SEQUENCE COMMENTS_SEQ;
DROP TABLE BOOKING CASCADE CONSTRAINTS;
DROP SEQUENCE BOOKING_SEQ;
DROP TABLE BOOKMARK CASCADE CONSTRAINTS;
DROP SEQUENCE BOOKMARK_SEQ;
DROP TABLE ROOM_IMG CASCADE CONSTRAINTS;
DROP SEQUENCE ROOM_IMG_SEQ;
DROP TABLE ROOM_FACILITY_MAPPING CASCADE CONSTRAINTS;
DROP TABLE REVIEW CASCADE CONSTRAINTS;
DROP SEQUENCE REVIEW_SEQ;

-- 테이블 순서는 관계를 고려하여 한 번에 실행해도 에러가 발생하지 않게 정렬되었습니다.





-- USERS Table Create SQL
CREATE TABLE USERS 
   (	
    USER_NO NUMBER NOT NULL, 
	USER_ID VARCHAR2(20) NOT NULL, 
	USER_PW VARCHAR2(20) NOT NULL , 
	USER_NAME VARCHAR2(20) NOT NULL, 
	USER_GENDER VARCHAR2(1) CHECK (USER_GENDER IN('M','F') ) , 
	USER_NICK VARCHAR2(20) NOT NULL, 
	USER_BIRTHDATE VARCHAR2(20) NOT NULL , 
	USER_EMAIL VARCHAR2(50) NOT NULL , 
	USER_PHONE VARCHAR2(20) NOT NULL , 
	USER_GRADE NUMBER DEFAULT 1, 
    CONSTRAINT UK_EMAIL UNIQUE (USER_EMAIL),
    CONSTRAINT PK_USERS PRIMARY KEY (USER_NO)
);
CREATE SEQUENCE USERS_SEQ
START WITH 1
INCREMENT BY 1;
/
-- USERS Table Create SQL
CREATE TABLE ROOM
(
    ROOMNO                 NUMBER            NOT NULL, 
    USERNO                 NUMBER            NOT NULL, 
    ROOMNAME               VARCHAR2(320)     NOT NULL, 
    ROOMGUESTS             NUMBER            NOT NULL, 
    ROOMPRICE              NUMBER            NOT NULL, 
    ROOMBEDROOM            NUMBER            NOT NULL, 
    ROOMBED                NUMBER            NOT NULL, 
    ROOMADMINCHECK         VARCHAR2(1)       NOT NULL, 
    ROOMDESC               VARCHAR2(4000)    NOT NULL, 
    ROOMBATHROOM           NUMBER            NOT NULL, 
    ROOMTYPE               VARCHAR2(20)      NOT NULL, 
    ROOMROADADDRESS        VARCHAR2(200)     NOT NULL, 
    ROOMDETAILEDADDRESS    VARCHAR2(200)     NOT NULL, 
    CONSTRAINT PK_ROOM PRIMARY KEY (ROOMNO), 
    CONSTRAINT CK_ROOM_ADMIN_CHECK CHECK ( ROOMADMINCHECK IN('Y' , 'N', 'W'))   
)
/

CREATE SEQUENCE ROOM_SEQ
START WITH 1
INCREMENT BY 1;
/
ALTER TABLE ROOM
    ADD CONSTRAINT FK_ROOM_USERNO_USERS_USER_NO FOREIGN KEY (USERNO)
        REFERENCES USERS (USER_NO) ON DELETE CASCADE
/


-- USERS Table Create SQL
CREATE TABLE BOARDS
   (	
    BOARD_NO NUMBER NOT NULL, 
	BOARD_TITLE VARCHAR2(100 BYTE) NOT NULL , 
	BOARD_CONTENT VARCHAR2(4000 BYTE) NOT NULL , 
	BOARD_CREATE_DATE DATE DEFAULT sysdate, 
	BOARD_TYPE NUMBER DEFAULT 1, 
	USER_NO NUMBER NOT NULL , 
	 CONSTRAINT PK_BOARDS PRIMARY KEY (BOARD_NO),
     CONSTRAINT FK_USERS FOREIGN KEY (USER_NO) REFERENCES USERS(USER_NO) on delete cascade
);
CREATE SEQUENCE BOARDS_SEQ;



-- USERS Table Create SQL
CREATE TABLE FACILITY
(
    FACILITY_NO      NUMBER          NOT NULL, 
    FACILITY_NAME    VARCHAR2(50)    NOT NULL, 
    CONSTRAINT PK_FACILITY PRIMARY KEY (FACILITY_NO)
)
/

CREATE SEQUENCE FACILITY_SEQ
START WITH 1
INCREMENT BY 1;
/

--DROP TRIGGER FACILITY_AI_TRG;
/

--DROP SEQUENCE FACILITY_SEQ;
/


-- USERS Table Create SQL
CREATE TABLE FILTER
(
    FILTER_NO      NUMBER          NOT NULL, 
    FILTER_NAME    VARCHAR2(20)    NULL, 
    CONSTRAINT PK_FILTER PRIMARY KEY (FILTER_NO)
)
/

CREATE SEQUENCE FILTER_SEQ
START WITH 1
INCREMENT BY 1;
/


--DROP TRIGGER FILTER_AI_TRG;
/

--DROP SEQUENCE FILTER_SEQ;
/

-- USERS Table Create SQL
CREATE TABLE RESTAURANT
(
    RES_NO                  NUMBER           NOT NULL, 
    FILTER_NO              NUMBER           NULL, 
    REGION_NO               NUMBER           NULL, 
    RES_NAME                VARCHAR2(50)     NULL, 
    RES_PHONE               VARCHAR2(20)     NULL, 
    RES_TIME                VARCHAR2(300)    NULL, 
    RES_PARKING             VARCHAR2(100)      NULL, 
    RES_ROAD_ADDRESS        VARCHAR2(200)    NULL,  
    CONSTRAINT PK_RESTAURANT PRIMARY KEY (RES_NO)
);
/

CREATE SEQUENCE RESTAURANT_SEQ
START WITH 1
INCREMENT BY 1;
/


--DROP TRIGGER RESTAURANT_AI_TRG;
/

--DROP SEQUENCE RESTAURANT_SEQ;
/


-- USERS Table Create SQL
CREATE TABLE COMMENTS
(
    COMMENT_NO             NUMBER           NOT NULL, 
    COMMENT_CREATE_DATE    DATE             NOT NULL, 
    COMMENT_CONTENT        VARCHAR2(500)    NOT NULL, 
    BOARD_NO               NUMBER           NOT NULL, 
    USER_NO                NUMBER           NOT NULL, 
    CONSTRAINT PK_COMMENT PRIMARY KEY (COMMENT_NO)
)
/
CREATE SEQUENCE COMMENTS_SEQ
START WITH 1
INCREMENT BY 1;
/

ALTER TABLE COMMENTS
    ADD CONSTRAINT FK_COMMENT_BOARD_NO_BOARDS_BOA FOREIGN KEY (BOARD_NO)
        REFERENCES BOARDS (BOARD_NO) ON DELETE CASCADE
/

ALTER TABLE COMMENTS
    ADD CONSTRAINT FK_COMMENT_USER_NO_USERS_USER_ FOREIGN KEY (USER_NO)
        REFERENCES USERS (USER_NO) ON DELETE CASCADE
/


-- USERS Table Create SQL
CREATE TABLE BOOKING
(
    BOOKING_NO           NUMBER           NOT NULL, 
    USER_NO              NUMBER           NOT NULL, 
    BOOKING_GUEST        NUMBER(2)        NOT NULL, 
    BOOKING_CHECKIN      VARCHAR2(20)     NOT NULL, 
    BOOKING_CHECKOUT     VARCHAR2(20)     NOT NULL, 
    BOOKING_STATUS       VARCHAR2(1)      NOT NULL, 
    BOOKING_MESSAGE      VARCHAR2(200)    NOT NULL, 
    ROOM_NO              NUMBER           NOT NULL,
    BOOKING_USERNAME     VARCHAR2(20)     NULL, 
    BOOKING_USERPHONE    VARCHAR2(20)     NULL, 
    BOOKING_USEREMAIL    VARCHAR2(50)     NULL, 
    CONSTRAINT PK_BOOKING PRIMARY KEY (BOOKING_NO)
)
/

CREATE SEQUENCE BOOKING_SEQ
START WITH 1
INCREMENT BY 1;
/

ALTER TABLE BOOKING
    ADD CONSTRAINT FK_BOOKING_USER_NO_USERS_USER_ FOREIGN KEY (USER_NO)
        REFERENCES USERS (USER_NO) ON DELETE CASCADE
/

ALTER TABLE BOOKING
    ADD CONSTRAINT FK_BOOKING_ROOM_NO_ROOM_ROOMNO FOREIGN KEY (ROOM_NO)
        REFERENCES ROOM (ROOMNO) ON DELETE CASCADE
/



-- USERS Table Create SQL
CREATE TABLE BOOKMARK
(
    BOOKMARK_NO    NUMBER    NOT NULL, 
    USER_NO        NUMBER    NOT NULL, 
    ROOM_NO        NUMBER    NOT NULL, 
    CONSTRAINT PK_BOOKMARK PRIMARY KEY (BOOKMARK_NO)
)
/
CREATE SEQUENCE BOOKMARK_SEQ
START WITH 1
INCREMENT BY 1;
/
ALTER TABLE BOOKMARK
    ADD CONSTRAINT FK_BOOKMARK_USER_NO_USERS_USER FOREIGN KEY (USER_NO)
        REFERENCES USERS (USER_NO) ON DELETE CASCADE
/

ALTER TABLE BOOKMARK
    ADD CONSTRAINT FK_BOOKMARK_ROOM_NO_ROOM_ROOMN FOREIGN KEY (ROOM_NO)
        REFERENCES ROOM (ROOMNO) ON DELETE CASCADE
/


-- USERS Table Create SQL
CREATE TABLE ROOM_IMG
(
    ROOM_IMG_NO          NUMBER          NOT NULL, 
    ROOM_NO              NUMBER          NULL, 
    ROOM_IMG_FILENAME    VARCHAR2(50)    NULL, 
    CONSTRAINT PK_ROOM_IMG PRIMARY KEY (ROOM_IMG_NO)
)
/

CREATE SEQUENCE ROOM_IMG_SEQ
START WITH 1
INCREMENT BY 1;
/

--DROP TRIGGER ROOM_IMG_AI_TRG;
/

--DROP SEQUENCE ROOM_IMG_SEQ;
/
ALTER TABLE ROOM_IMG
    ADD CONSTRAINT FK_ROOM_IMG_ROOM_NO_ROOM_ROOMN FOREIGN KEY (ROOM_NO)
        REFERENCES ROOM (ROOMNO) ON DELETE CASCADE
/


-- USERS Table Create SQL
CREATE TABLE ROOM_FACILITY_MAPPING
(
    ROOM_NO        NUMBER    NOT NULL, 
    FACILITY_NO    NUMBER    NOT NULL, 
    CONSTRAINT PK_ROOM_FACILITY_MAPPING PRIMARY KEY (ROOM_NO, FACILITY_NO)
)
/

ALTER TABLE ROOM_FACILITY_MAPPING
    ADD CONSTRAINT FK_ROOM_FACILITY_MAPPING_FACIL FOREIGN KEY (FACILITY_NO)
        REFERENCES FACILITY (FACILITY_NO) ON DELETE CASCADE
/

ALTER TABLE ROOM_FACILITY_MAPPING
    ADD CONSTRAINT FK_ROOM_FACILITY_MAPPING_ROOM_ FOREIGN KEY (ROOM_NO)
        REFERENCES ROOM (ROOMNO) ON DELETE CASCADE
/


-- USERS Table Create SQL
CREATE TABLE REVIEW
(
    RE_NO         NUMBER           NOT NULL, 
    USER_NO       NUMBER           NULL, 
    ROOM_NO       NUMBER           NULL, 
    RE_CONTENT    VARCHAR2(500)    NULL, 
    RE_DATE       DATE             NULL, 
    RE_STAR       VARCHAR2(20)     NULL, 
    CONSTRAINT PK_REVIEW PRIMARY KEY (RE_NO)
)
/

CREATE SEQUENCE REVIEW_SEQ
START WITH 1
INCREMENT BY 1;
/

--DROP TRIGGER REVIEW_AI_TRG;
/

--DROP SEQUENCE REVIEW_SEQ;
/

ALTER TABLE REVIEW
    ADD CONSTRAINT FK_REVIEW_USER_NO_USERS_USER_N FOREIGN KEY (USER_NO)
        REFERENCES USERS (USER_NO) ON DELETE CASCADE
/

ALTER TABLE REVIEW
    ADD CONSTRAINT FK_REVIEW_ROOM_NO_ROOM_ROOMNO FOREIGN KEY (ROOM_NO)
        REFERENCES ROOM (ROOMNO) ON DELETE CASCADE
/

DROP TABLE restaurant  CASCADE CONSTRAINTS;
CREATE TABLE RESTAURANT
(
    RES_NO                  NUMBER           NOT NULL, 
    FILTER_NO              NUMBER           NULL, 
    REGION_NO               NUMBER           NULL, 
    RES_NAME                VARCHAR2(50)     NULL, 
    RES_PHONE               VARCHAR2(20)     NULL, 
    RES_TIME                VARCHAR2(300)    NULL, 
    RES_PARKING             VARCHAR2(100)      NULL, 
    RES_ROAD_ADDRESS        VARCHAR2(200)    NULL,  
    CONSTRAINT PK_RESTAURANT PRIMARY KEY (RES_NO)
);
DROP SEQUENCE RESTAURANT_seq;
CREATE SEQUENCE RESTAURANT_seq;


/**
-- USERS Table Create SQL
CREATE TABLE RES_FILTER_MAPPING
(
    FILTER_NO    NUMBER    NOT NULL, 
    RES_NO       NUMBER    NOT NULL, 
    CONSTRAINT PK_RES_FILTER_MAPPING PRIMARY KEY (FILTER_NO, RES_NO)
)
/

ALTER TABLE RES_FILTER_MAPPING
    ADD CONSTRAINT FK_RES_FILTER_MAPPING_FILTER_N FOREIGN KEY (FILTER_NO)
        REFERENCES FILTER (FILTER_NO)
/

ALTER TABLE RES_FILTER_MAPPING
    ADD CONSTRAINT FK_RES_FILTER_MAPPING_RES_NO_R FOREIGN KEY (RES_NO)
        REFERENCES RESTAURANT (RES_NO)
/

**/









---------------------------------------------------------------------------------------------데이터삽입
----------- users users users users users users users users users users users users users users users users users users users users -------------------------------------


insert into users(user_no, user_id, user_pw, user_name, user_gender, user_nick, user_birthdate, user_email, user_phone, user_grade) values(users_seq.nextval,'test1','test1','test1','M','테스트1','19900101','test1@gmail.com','01000000000',1);
insert into users(user_no, user_id, user_pw, user_name, user_gender, user_nick, user_birthdate, user_email, user_phone, user_grade) values(users_seq.nextval,'test2','test2','test2','M','테스트2','19900101','test2@gmail.com','01000000000',2);
insert into users(user_no, user_id, user_pw, user_name, user_gender, user_nick, user_birthdate, user_email, user_phone, user_grade) values(users_seq.nextval,'test3','test3','test3','M','테스트3','19900101','test3@gmail.com','01000000000',0);
insert into users(user_no, user_id, user_pw, user_name, user_gender, user_nick, user_birthdate, user_email, user_phone, user_grade) values(users_seq.nextval,'test4','test4','test4','M','테스트4','19900101','test4@gmail.com','01000000000',1);
insert into users(user_no, user_id, user_pw, user_name, user_gender, user_nick, user_birthdate, user_email, user_phone, user_grade) values(users_seq.nextval,'test5','test5','test5','M','테스트5','19900101','test5@gmail.com','01000000000',2);
insert into users(user_no, user_id, user_pw, user_name, user_gender, user_nick, user_birthdate, user_email, user_phone, user_grade) values(users_seq.nextval,'test6','test6','test6','M','테스트6','19900101','test6@gmail.com','01000000000',0);
insert into users(user_no, user_id, user_pw, user_name, user_gender, user_nick, user_birthdate, user_email, user_phone, user_grade) values(users_seq.nextval,'test7','test7','test7','M','테스트7','19900101','test7@gmail.com','01000000000',1);
insert into users(user_no, user_id, user_pw, user_name, user_gender, user_nick, user_birthdate, user_email, user_phone, user_grade) values(users_seq.nextval,'test8','test8','test8','M','테스트8','19900101','test8@gmail.com','01000000000',2);
insert into users(user_no, user_id, user_pw, user_name, user_gender, user_nick, user_birthdate, user_email, user_phone, user_grade) values(users_seq.nextval,'test9','test9','test9','M','테스트9','19900101','test9@gmail.com','01000000000',0);
insert into users(user_no, user_id, user_pw, user_name, user_gender, user_nick, user_birthdate, user_email, user_phone, user_grade) values(users_seq.nextval,'test10','test10','test10','M','테스트10','19900101','test10@gmail.com','01000000000',1);
insert into users(user_no, user_id, user_pw, user_name, user_gender, user_nick, user_birthdate, user_email, user_phone, user_grade) values(users_seq.nextval,'test11','test11','test11','M','테스트11','19900101','test11@gmail.com','01000000000',2);
insert into users(user_no, user_id, user_pw, user_name, user_gender, user_nick, user_birthdate, user_email, user_phone, user_grade) values(users_seq.nextval,'test12','test12','test12','M','테스트12','19900101','test12@gmail.com','01000000000',0);
insert into users(user_no, user_id, user_pw, user_name, user_gender, user_nick, user_birthdate, user_email, user_phone, user_grade) values(users_seq.nextval,'test13','test13','test13','M','테스트13','19900101','test13@gmail.com','01000000000',1);
insert into users(user_no, user_id, user_pw, user_name, user_gender, user_nick, user_birthdate, user_email, user_phone, user_grade) values(users_seq.nextval,'test14','test14','test14','M','테스트14','19900101','test14@gmail.com','01000000000',2);
insert into users(user_no, user_id, user_pw, user_name, user_gender, user_nick, user_birthdate, user_email, user_phone, user_grade) values(users_seq.nextval,'test15','test15','test15','M','테스트15','19900101','test15@gmail.com','01000000000',0);
insert into users(user_no, user_id, user_pw, user_name, user_gender, user_nick, user_birthdate, user_email, user_phone, user_grade) values(users_seq.nextval,'test16','test16','test16','M','테스트16','19900101','test16@gmail.com','01000000000',1);
insert into users(user_no, user_id, user_pw, user_name, user_gender, user_nick, user_birthdate, user_email, user_phone, user_grade) values(users_seq.nextval,'test17','test17','test17','M','테스트17','19900101','test17@gmail.com','01000000000',2);
insert into users(user_no, user_id, user_pw, user_name, user_gender, user_nick, user_birthdate, user_email, user_phone, user_grade) values(users_seq.nextval,'test18','test18','test18','M','테스트18','19900101','test18@gmail.com','01000000000',0);
insert into users(user_no, user_id, user_pw, user_name, user_gender, user_nick, user_birthdate, user_email, user_phone, user_grade) values(users_seq.nextval,'test19','test19','test19','M','테스트19','19900101','test19@gmail.com','01000000000',1);
insert into users(user_no, user_id, user_pw, user_name, user_gender, user_nick, user_birthdate, user_email, user_phone, user_grade) values(users_seq.nextval,'test20','test20','test20','M','테스트20','19900101','test20@gmail.com','01000000000',2);
insert into users(user_no, user_id, user_pw, user_name, user_gender, user_nick, user_birthdate, user_email, user_phone, user_grade) values(users_seq.nextval,'test21','test21','test21','M','테스트21','19900101','test21@gmail.com','01000000000',0);
insert into users(user_no, user_id, user_pw, user_name, user_gender, user_nick, user_birthdate, user_email, user_phone, user_grade) values(users_seq.nextval,'test22','test22','test22','M','테스트22','19900101','test22@gmail.com','01000000000',1);
insert into users(user_no, user_id, user_pw, user_name, user_gender, user_nick, user_birthdate, user_email, user_phone, user_grade) values(users_seq.nextval,'test23','test23','test23','M','테스트23','19900101','test23@gmail.com','01000000000',2);
insert into users(user_no, user_id, user_pw, user_name, user_gender, user_nick, user_birthdate, user_email, user_phone, user_grade) values(users_seq.nextval,'test24','test24','test24','M','테스트24','19900101','test24@gmail.com','01000000000',0);
insert into users(user_no, user_id, user_pw, user_name, user_gender, user_nick, user_birthdate, user_email, user_phone, user_grade) values(users_seq.nextval,'test25','test25','test25','M','테스트25','19900101','test25@gmail.com','01000000000',1);
insert into users(user_no, user_id, user_pw, user_name, user_gender, user_nick, user_birthdate, user_email, user_phone, user_grade) values(users_seq.nextval,'test26','test26','test26','M','테스트26','19900101','test26@gmail.com','01000000000',2);
insert into users(user_no, user_id, user_pw, user_name, user_gender, user_nick, user_birthdate, user_email, user_phone, user_grade) values(users_seq.nextval,'test27','test27','test27','M','테스트27','19900101','test27@gmail.com','01000000000',0);
insert into users(user_no, user_id, user_pw, user_name, user_gender, user_nick, user_birthdate, user_email, user_phone, user_grade) values(users_seq.nextval,'test28','test28','test28','M','테스트28','19900101','test28@gmail.com','01000000000',1);
insert into users(user_no, user_id, user_pw, user_name, user_gender, user_nick, user_birthdate, user_email, user_phone, user_grade) values(users_seq.nextval,'test29','test29','test29','M','테스트29','19900101','test29@gmail.com','01000000000',2);
insert into users(user_no, user_id, user_pw, user_name, user_gender, user_nick, user_birthdate, user_email, user_phone, user_grade) values(users_seq.nextval,'test30','test30','test30','M','테스트30','19900101','test30@gmail.com','01000000000',0);
insert into users(user_no, user_id, user_pw, user_name, user_gender, user_nick, user_birthdate, user_email, user_phone, user_grade) values(users_seq.nextval,'test31','test31','test31','M','테스트31','19900101','test31@gmail.com','01000000000',1);
insert into users(user_no, user_id, user_pw, user_name, user_gender, user_nick, user_birthdate, user_email, user_phone, user_grade) values(users_seq.nextval,'test32','test32','test32','M','테스트32','19900101','test32@gmail.com','01000000000',2);
insert into users(user_no, user_id, user_pw, user_name, user_gender, user_nick, user_birthdate, user_email, user_phone, user_grade) values(users_seq.nextval,'test33','test33','test33','M','테스트33','19900101','test33@gmail.com','01000000000',0);
insert into users(user_no, user_id, user_pw, user_name, user_gender, user_nick, user_birthdate, user_email, user_phone, user_grade) values(users_seq.nextval,'test34','test34','test34','M','테스트34','19900101','test34@gmail.com','01000000000',1);
insert into users(user_no, user_id, user_pw, user_name, user_gender, user_nick, user_birthdate, user_email, user_phone, user_grade) values(users_seq.nextval,'test35','test35','test35','M','테스트35','19900101','test35@gmail.com','01000000000',2);
insert into users(user_no, user_id, user_pw, user_name, user_gender, user_nick, user_birthdate, user_email, user_phone, user_grade) values(users_seq.nextval,'test36','test36','test36','M','테스트36','19900101','test36@gmail.com','01000000000',0);
insert into users(user_no, user_id, user_pw, user_name, user_gender, user_nick, user_birthdate, user_email, user_phone, user_grade) values(users_seq.nextval,'test37','test37','test37','M','테스트37','19900101','test37@gmail.com','01000000000',1);
insert into users(user_no, user_id, user_pw, user_name, user_gender, user_nick, user_birthdate, user_email, user_phone, user_grade) values(users_seq.nextval,'test38','test38','test38','M','테스트38','19900101','test38@gmail.com','01000000000',2);
insert into users(user_no, user_id, user_pw, user_name, user_gender, user_nick, user_birthdate, user_email, user_phone, user_grade) values(users_seq.nextval,'test39','test39','test39','M','테스트39','19900101','test39@gmail.com','01000000000',0);
insert into users(user_no, user_id, user_pw, user_name, user_gender, user_nick, user_birthdate, user_email, user_phone, user_grade) values(users_seq.nextval,'test40','test40','test40','M','테스트40','19900101','test40@gmail.com','01000000000',1);
insert into users(user_no, user_id, user_pw, user_name, user_gender, user_nick, user_birthdate, user_email, user_phone, user_grade) values(users_seq.nextval,'test41','test41','test41','M','테스트41','19900101','test41@gmail.com','01000000000',2);
insert into users(user_no, user_id, user_pw, user_name, user_gender, user_nick, user_birthdate, user_email, user_phone, user_grade) values(users_seq.nextval,'test42','test42','test42','M','테스트42','19900101','test42@gmail.com','01000000000',0);
insert into users(user_no, user_id, user_pw, user_name, user_gender, user_nick, user_birthdate, user_email, user_phone, user_grade) values(users_seq.nextval,'test43','test43','test43','M','테스트43','19900101','test43@gmail.com','01000000000',1);
insert into users(user_no, user_id, user_pw, user_name, user_gender, user_nick, user_birthdate, user_email, user_phone, user_grade) values(users_seq.nextval,'test44','test44','test44','M','테스트44','19900101','test44@gmail.com','01000000000',2);
insert into users(user_no, user_id, user_pw, user_name, user_gender, user_nick, user_birthdate, user_email, user_phone, user_grade) values(users_seq.nextval,'test45','test45','test45','M','테스트45','19900101','test45@gmail.com','01000000000',0);
insert into users(user_no, user_id, user_pw, user_name, user_gender, user_nick, user_birthdate, user_email, user_phone, user_grade) values(users_seq.nextval,'test46','test46','test46','M','테스트46','19900101','test46@gmail.com','01000000000',1);
insert into users(user_no, user_id, user_pw, user_name, user_gender, user_nick, user_birthdate, user_email, user_phone, user_grade) values(users_seq.nextval,'test47','test47','test47','M','테스트47','19900101','test47@gmail.com','01000000000',2);
insert into users(user_no, user_id, user_pw, user_name, user_gender, user_nick, user_birthdate, user_email, user_phone, user_grade) values(users_seq.nextval,'test48','test48','test48','M','테스트48','19900101','test48@gmail.com','01000000000',0);
insert into users(user_no, user_id, user_pw, user_name, user_gender, user_nick, user_birthdate, user_email, user_phone, user_grade) values(users_seq.nextval,'test49','test49','test49','M','테스트49','19900101','test49@gmail.com','01000000000',1);
insert into users(user_no, user_id, user_pw, user_name, user_gender, user_nick, user_birthdate, user_email, user_phone, user_grade) values(users_seq.nextval,'test50','test50','test50','M','테스트50','19900101','test50@gmail.com','01000000000',2);
insert into users(user_no, user_id, user_pw, user_name, user_gender, user_nick, user_birthdate, user_email, user_phone, user_grade) values(users_seq.nextval,'test51','test51','test51','M','테스트51','19900101','test51@gmail.com','01000000000',0);
insert into users(user_no, user_id, user_pw, user_name, user_gender, user_nick, user_birthdate, user_email, user_phone, user_grade) values(users_seq.nextval,'test52','test52','test52','M','테스트52','19900101','test52@gmail.com','01000000000',1);
insert into users(user_no, user_id, user_pw, user_name, user_gender, user_nick, user_birthdate, user_email, user_phone, user_grade) values(users_seq.nextval,'test53','test53','test53','M','테스트53','19900101','test53@gmail.com','01000000000',2);
insert into users(user_no, user_id, user_pw, user_name, user_gender, user_nick, user_birthdate, user_email, user_phone, user_grade) values(users_seq.nextval,'test54','test54','test54','M','테스트54','19900101','test54@gmail.com','01000000000',0);
insert into users(user_no, user_id, user_pw, user_name, user_gender, user_nick, user_birthdate, user_email, user_phone, user_grade) values(users_seq.nextval,'test55','test55','test55','M','테스트55','19900101','test55@gmail.com','01000000000',1);
insert into users(user_no, user_id, user_pw, user_name, user_gender, user_nick, user_birthdate, user_email, user_phone, user_grade) values(users_seq.nextval,'test56','test56','test56','M','테스트56','19900101','test56@gmail.com','01000000000',2);
insert into users(user_no, user_id, user_pw, user_name, user_gender, user_nick, user_birthdate, user_email, user_phone, user_grade) values(users_seq.nextval,'test57','test57','test57','M','테스트57','19900101','test57@gmail.com','01000000000',0);
insert into users(user_no, user_id, user_pw, user_name, user_gender, user_nick, user_birthdate, user_email, user_phone, user_grade) values(users_seq.nextval,'test58','test58','test58','M','테스트58','19900101','test58@gmail.com','01000000000',1);
insert into users(user_no, user_id, user_pw, user_name, user_gender, user_nick, user_birthdate, user_email, user_phone, user_grade) values(users_seq.nextval,'test59','test59','test59','M','테스트59','19900101','test59@gmail.com','01000000000',2);
insert into users(user_no, user_id, user_pw, user_name, user_gender, user_nick, user_birthdate, user_email, user_phone, user_grade) values(users_seq.nextval,'test60','test60','test60','M','테스트60','19900101','test60@gmail.com','01000000000',0);
insert into users(user_no, user_id, user_pw, user_name, user_gender, user_nick, user_birthdate, user_email, user_phone, user_grade) values(users_seq.nextval,'test61','test61','test61','M','테스트61','19900101','test61@gmail.com','01000000000',1);
insert into users(user_no, user_id, user_pw, user_name, user_gender, user_nick, user_birthdate, user_email, user_phone, user_grade) values(users_seq.nextval,'test62','test62','test62','M','테스트62','19900101','test62@gmail.com','01000000000',2);
insert into users(user_no, user_id, user_pw, user_name, user_gender, user_nick, user_birthdate, user_email, user_phone, user_grade) values(users_seq.nextval,'test63','test63','test63','M','테스트63','19900101','test63@gmail.com','01000000000',0);
insert into users(user_no, user_id, user_pw, user_name, user_gender, user_nick, user_birthdate, user_email, user_phone, user_grade) values(users_seq.nextval,'test64','test64','test64','M','테스트64','19900101','test64@gmail.com','01000000000',1);
insert into users(user_no, user_id, user_pw, user_name, user_gender, user_nick, user_birthdate, user_email, user_phone, user_grade) values(users_seq.nextval,'test65','test65','test65','M','테스트65','19900101','test65@gmail.com','01000000000',2);
insert into users(user_no, user_id, user_pw, user_name, user_gender, user_nick, user_birthdate, user_email, user_phone, user_grade) values(users_seq.nextval,'test66','test66','test66','M','테스트66','19900101','test66@gmail.com','01000000000',0);
insert into users(user_no, user_id, user_pw, user_name, user_gender, user_nick, user_birthdate, user_email, user_phone, user_grade) values(users_seq.nextval,'test67','test67','test67','M','테스트67','19900101','test67@gmail.com','01000000000',1);
insert into users(user_no, user_id, user_pw, user_name, user_gender, user_nick, user_birthdate, user_email, user_phone, user_grade) values(users_seq.nextval,'test68','test68','test68','M','테스트68','19900101','test68@gmail.com','01000000000',2);
insert into users(user_no, user_id, user_pw, user_name, user_gender, user_nick, user_birthdate, user_email, user_phone, user_grade) values(users_seq.nextval,'test69','test69','test69','M','테스트69','19900101','test69@gmail.com','01000000000',0);
insert into users(user_no, user_id, user_pw, user_name, user_gender, user_nick, user_birthdate, user_email, user_phone, user_grade) values(users_seq.nextval,'test70','test70','test70','M','테스트70','19900101','test70@gmail.com','01000000000',1);
insert into users(user_no, user_id, user_pw, user_name, user_gender, user_nick, user_birthdate, user_email, user_phone, user_grade) values(users_seq.nextval,'test71','test71','test71','M','테스트71','19900101','test71@gmail.com','01000000000',2);
insert into users(user_no, user_id, user_pw, user_name, user_gender, user_nick, user_birthdate, user_email, user_phone, user_grade) values(users_seq.nextval,'test72','test72','test72','M','테스트72','19900101','test72@gmail.com','01000000000',0);
insert into users(user_no, user_id, user_pw, user_name, user_gender, user_nick, user_birthdate, user_email, user_phone, user_grade) values(users_seq.nextval,'test73','test73','test73','M','테스트73','19900101','test73@gmail.com','01000000000',1);
insert into users(user_no, user_id, user_pw, user_name, user_gender, user_nick, user_birthdate, user_email, user_phone, user_grade) values(users_seq.nextval,'test74','test74','test74','M','테스트74','19900101','test74@gmail.com','01000000000',2);
insert into users(user_no, user_id, user_pw, user_name, user_gender, user_nick, user_birthdate, user_email, user_phone, user_grade) values(users_seq.nextval,'test75','test75','test75','M','테스트75','19900101','test75@gmail.com','01000000000',0);
insert into users(user_no, user_id, user_pw, user_name, user_gender, user_nick, user_birthdate, user_email, user_phone, user_grade) values(users_seq.nextval,'test76','test76','test76','M','테스트76','19900101','test76@gmail.com','01000000000',1);
insert into users(user_no, user_id, user_pw, user_name, user_gender, user_nick, user_birthdate, user_email, user_phone, user_grade) values(users_seq.nextval,'test77','test77','test77','M','테스트77','19900101','test77@gmail.com','01000000000',2);
insert into users(user_no, user_id, user_pw, user_name, user_gender, user_nick, user_birthdate, user_email, user_phone, user_grade) values(users_seq.nextval,'test78','test78','test78','M','테스트78','19900101','test78@gmail.com','01000000000',0);
insert into users(user_no, user_id, user_pw, user_name, user_gender, user_nick, user_birthdate, user_email, user_phone, user_grade) values(users_seq.nextval,'test79','test79','test79','M','테스트79','19900101','test79@gmail.com','01000000000',1);
insert into users(user_no, user_id, user_pw, user_name, user_gender, user_nick, user_birthdate, user_email, user_phone, user_grade) values(users_seq.nextval,'test80','test80','test80','M','테스트80','19900101','test80@gmail.com','01000000000',2);
insert into users(user_no, user_id, user_pw, user_name, user_gender, user_nick, user_birthdate, user_email, user_phone, user_grade) values(users_seq.nextval,'test81','test81','test81','M','테스트81','19900101','test81@gmail.com','01000000000',0);
insert into users(user_no, user_id, user_pw, user_name, user_gender, user_nick, user_birthdate, user_email, user_phone, user_grade) values(users_seq.nextval,'test82','test82','test82','M','테스트82','19900101','test82@gmail.com','01000000000',1);
insert into users(user_no, user_id, user_pw, user_name, user_gender, user_nick, user_birthdate, user_email, user_phone, user_grade) values(users_seq.nextval,'test83','test83','test83','M','테스트83','19900101','test83@gmail.com','01000000000',2);
insert into users(user_no, user_id, user_pw, user_name, user_gender, user_nick, user_birthdate, user_email, user_phone, user_grade) values(users_seq.nextval,'test84','test84','test84','M','테스트84','19900101','test84@gmail.com','01000000000',0);
insert into users(user_no, user_id, user_pw, user_name, user_gender, user_nick, user_birthdate, user_email, user_phone, user_grade) values(users_seq.nextval,'test85','test85','test85','M','테스트85','19900101','test85@gmail.com','01000000000',1);
insert into users(user_no, user_id, user_pw, user_name, user_gender, user_nick, user_birthdate, user_email, user_phone, user_grade) values(users_seq.nextval,'test86','test86','test86','M','테스트86','19900101','test86@gmail.com','01000000000',2);
insert into users(user_no, user_id, user_pw, user_name, user_gender, user_nick, user_birthdate, user_email, user_phone, user_grade) values(users_seq.nextval,'test87','test87','test87','M','테스트87','19900101','test87@gmail.com','01000000000',0);
insert into users(user_no, user_id, user_pw, user_name, user_gender, user_nick, user_birthdate, user_email, user_phone, user_grade) values(users_seq.nextval,'test88','test88','test88','M','테스트88','19900101','test88@gmail.com','01000000000',1);
insert into users(user_no, user_id, user_pw, user_name, user_gender, user_nick, user_birthdate, user_email, user_phone, user_grade) values(users_seq.nextval,'test89','test89','test89','M','테스트89','19900101','test89@gmail.com','01000000000',2);
insert into users(user_no, user_id, user_pw, user_name, user_gender, user_nick, user_birthdate, user_email, user_phone, user_grade) values(users_seq.nextval,'test90','test90','test90','M','테스트90','19900101','test90@gmail.com','01000000000',0);
insert into users(user_no, user_id, user_pw, user_name, user_gender, user_nick, user_birthdate, user_email, user_phone, user_grade) values(users_seq.nextval,'test91','test91','test91','M','테스트91','19900101','test91@gmail.com','01000000000',1);
insert into users(user_no, user_id, user_pw, user_name, user_gender, user_nick, user_birthdate, user_email, user_phone, user_grade) values(users_seq.nextval,'test92','test92','test92','M','테스트92','19900101','test92@gmail.com','01000000000',2);
insert into users(user_no, user_id, user_pw, user_name, user_gender, user_nick, user_birthdate, user_email, user_phone, user_grade) values(users_seq.nextval,'test93','test93','test93','M','테스트93','19900101','test93@gmail.com','01000000000',0);
insert into users(user_no, user_id, user_pw, user_name, user_gender, user_nick, user_birthdate, user_email, user_phone, user_grade) values(users_seq.nextval,'test94','test94','test94','M','테스트94','19900101','test94@gmail.com','01000000000',1);
insert into users(user_no, user_id, user_pw, user_name, user_gender, user_nick, user_birthdate, user_email, user_phone, user_grade) values(users_seq.nextval,'test95','test95','test95','M','테스트95','19900101','test95@gmail.com','01000000000',2);
insert into users(user_no, user_id, user_pw, user_name, user_gender, user_nick, user_birthdate, user_email, user_phone, user_grade) values(users_seq.nextval,'test96','test96','test96','M','테스트96','19900101','test96@gmail.com','01000000000',0);
insert into users(user_no, user_id, user_pw, user_name, user_gender, user_nick, user_birthdate, user_email, user_phone, user_grade) values(users_seq.nextval,'test97','test97','test97','M','테스트97','19900101','test97@gmail.com','01000000000',1);
insert into users(user_no, user_id, user_pw, user_name, user_gender, user_nick, user_birthdate, user_email, user_phone, user_grade) values(users_seq.nextval,'test98','test98','test98','M','테스트98','19900101','test98@gmail.com','01000000000',2);
insert into users(user_no, user_id, user_pw, user_name, user_gender, user_nick, user_birthdate, user_email, user_phone, user_grade) values(users_seq.nextval,'test99','test99','test99','M','테스트99','19900101','test99@gmail.com','01000000000',0);
insert into users(user_no, user_id, user_pw, user_name, user_gender, user_nick, user_birthdate, user_email, user_phone, user_grade) values(users_seq.nextval,'test100','test100','test100','M','테스트100','19900101','test100@gmail.com','01000000000',1);
insert into users(user_no, user_id, user_pw, user_name, user_gender, user_nick, user_birthdate, user_email, user_phone, user_grade) values(users_seq.nextval,'test101','test101','test101','M','테스트101','19900101','test101@gmail.com','01000000000',2);
insert into users(user_no, user_id, user_pw, user_name, user_gender, user_nick, user_birthdate, user_email, user_phone, user_grade) values(users_seq.nextval,'test102','test102','test102','M','테스트102','19900101','test102@gmail.com','01000000000',0);
insert into users(user_no, user_id, user_pw, user_name, user_gender, user_nick, user_birthdate, user_email, user_phone, user_grade) values(users_seq.nextval,'test103','test103','test103','M','테스트103','19900101','test103@gmail.com','01000000000',1);








----------------------------room room room room room room room room room room room room room room room room room room room room room room room room room room room room room room------------------------


insert into room(roomno, userno, roomname, roomguests, roomprice, roombedroom, roombed, roomadmincheck, roomdesc, roombathroom, roomtype, roomroadaddress, roomdetailedaddress)
values(room_seq.nextval, 10, 'room10_1', 4, 50000, 2, 3, 'Y', 'userno10의 숙소1입니다.', 1, '호텔', '서울 강남구 강남대로10', '101호');
insert into room(roomno, userno, roomname, roomguests, roomprice, roombedroom, roombed, roomadmincheck, roomdesc, roombathroom, roomtype, roomroadaddress, roomdetailedaddress)
values(room_seq.nextval, 10, 'room10_2', 6, 60000, 2, 2, 'Y', 'userno10의 숙소2입니다.', 2, '아파트', '경기 광주시 강남대로10', '102호');
insert into room(roomno, userno, roomname, roomguests, roomprice, roombedroom, roombed, roomadmincheck, roomdesc, roombathroom, roomtype, roomroadaddress, roomdetailedaddress)
values(room_seq.nextval, 10, 'room10_3', 6, 70000, 1, 2, 'Y', 'userno10의 숙소3입니다.', 1, '콘도', '경기도 강남대로10', '103호');
insert into room(roomno, userno, roomname, roomguests, roomprice, roombedroom, roombed, roomadmincheck, roomdesc, roombathroom, roomtype, roomroadaddress, roomdetailedaddress)
values(room_seq.nextval, 10, 'room10_4', 4, 80000, 2, 4, 'Y', 'userno10의 숙소4입니다.', 2, '료칸', '경기 가평군 강남대로10', '104호');
insert into room(roomno, userno, roomname, roomguests, roomprice, roombedroom, roombed, roomadmincheck, roomdesc, roombathroom, roomtype, roomroadaddress, roomdetailedaddress)
values(room_seq.nextval, 10, 'room10_5', 8, 150000, 4, 6, 'Y', 'userno10의 숙소5입니다.', 3, '호텔', '경기 분당구 강남대로10', '105호');

insert into room(roomno, userno, roomname, roomguests, roomprice, roombedroom, roombed, roomadmincheck, roomdesc, roombathroom, roomtype, roomroadaddress, roomdetailedaddress)
values(room_seq.nextval, 20, 'room20_1', 4, 50000, 2, 3, 'Y', 'userno20의 숙소1입니다.', 1, '호텔', '부산광역시 강서구 서울 강남구 1', '201호');
insert into room(roomno, userno, roomname, roomguests, roomprice, roombedroom, roombed, roomadmincheck, roomdesc, roombathroom, roomtype, roomroadaddress, roomdetailedaddress)
values(room_seq.nextval, 20, 'room20_2', 6, 60000, 2, 2, 'Y', 'userno20의 숙소2입니다.', 2, '아파트', '서울 강남구 1', '202호');
insert into room(roomno, userno, roomname, roomguests, roomprice, roombedroom, roombed, roomadmincheck, roomdesc, roombathroom, roomtype, roomroadaddress, roomdetailedaddress)
values(room_seq.nextval, 20, 'room20_3', 6, 70000, 1, 2, 'Y', 'userno20의 숙소3입니다.', 1, '콘도', '서울 강남구 1', '203호');
insert into room(roomno, userno, roomname, roomguests, roomprice, roombedroom, roombed, roomadmincheck, roomdesc, roombathroom, roomtype, roomroadaddress, roomdetailedaddress)
values(room_seq.nextval, 20, 'room20_4', 4, 80000, 2, 4, 'Y', 'userno20의 숙소4입니다.', 2, '료칸', '서울 강남구 1', '204호');
insert into room(roomno, userno, roomname, roomguests, roomprice, roombedroom, roombed, roomadmincheck, roomdesc, roombathroom, roomtype, roomroadaddress, roomdetailedaddress)
values(room_seq.nextval, 20, 'room20_5', 8, 150000, 4, 6, 'Y', 'userno20의 숙소5입니다.', 3, '호텔', '서울 강남구 1', '205호');

insert into room(roomno, userno, roomname, roomguests, roomprice, roombedroom, roombed, roomadmincheck, roomdesc, roombathroom, roomtype, roomroadaddress, roomdetailedaddress)
values(room_seq.nextval, 30, 'room30_1', 4, 50000, 2, 3, 'Y', 'userno30의 숙소1입니다.', 1, '호텔', '서울 강남구 2 강남대로3', '301호');
insert into room(roomno, userno, roomname, roomguests, roomprice, roombedroom, roombed, roomadmincheck, roomdesc, roombathroom, roomtype, roomroadaddress, roomdetailedaddress)
values(room_seq.nextval, 30, 'room30_2', 6, 60000, 2, 2, 'Y', 'userno30의 숙소2입니다.', 2, '아파트', '서울 강남구 2 강남대로3', '302호');
insert into room(roomno, userno, roomname, roomguests, roomprice, roombedroom, roombed, roomadmincheck, roomdesc, roombathroom, roomtype, roomroadaddress, roomdetailedaddress)
values(room_seq.nextval, 30, 'room30_3', 6, 70000, 1, 2, 'Y', 'userno30의 숙소3입니다.', 1, '콘도', '서울 강남구 2 강남대로3', '303호');
insert into room(roomno, userno, roomname, roomguests, roomprice, roombedroom, roombed, roomadmincheck, roomdesc, roombathroom, roomtype, roomroadaddress, roomdetailedaddress)
values(room_seq.nextval, 30, 'room30_4', 4, 80000, 2, 4, 'Y', 'userno30의 숙소4입니다.', 2, '료칸', '서울 강남구 2 강남대로3', '304호');
insert into room(roomno, userno, roomname, roomguests, roomprice, roombedroom, roombed, roomadmincheck, roomdesc, roombathroom, roomtype, roomroadaddress, roomdetailedaddress)
values(room_seq.nextval, 30, 'room30_5', 8, 150000, 4, 6, 'Y', 'userno30의 숙소5입니다.', 3, '호텔', '서울 강남구 2 강남대로3', '305호');













---------------  booking booking booking booking booking booking booking booking booking booking booking booking booking booking booking booking ---------------------


insert into booking(booking_no, user_no, booking_guest, booking_checkin, booking_checkout, booking_status, booking_message, room_no)
values(booking_seq.nextval, 1, 2, sysdate+5, sysdate+7, 'C', '예약이 확정되었습니다.', 1);
insert into booking(booking_no, user_no, booking_guest, booking_checkin, booking_checkout, booking_status, booking_message, room_no)
values(booking_seq.nextval, 1, 3, sysdate+9, sysdate+10, 'C', '예약이 확정되었습니다.', 7);
insert into booking(booking_no, user_no, booking_guest, booking_checkin, booking_checkout, booking_status, booking_message, room_no)
values(booking_seq.nextval, 1, 4, sysdate+14, sysdate+18, 'W', 'W중...', 13);

insert into booking(booking_no, user_no, booking_guest, booking_checkin, booking_checkout, booking_status, booking_message, room_no)
values(booking_seq.nextval, 2, 2, sysdate+5, sysdate+7, 'C', '예약이 확정되었습니다.', 4);
insert into booking(booking_no, user_no, booking_guest, booking_checkin, booking_checkout, booking_status, booking_message, room_no)
values(booking_seq.nextval, 2, 3, sysdate+9, sysdate+11, 'C', '예약이 확정되었습니다.', 8);
insert into booking(booking_no, user_no, booking_guest, booking_checkin, booking_checkout, booking_status, booking_message, room_no)
values(booking_seq.nextval, 2, 4, sysdate+16, sysdate+20, 'W', 'W중...', 14);

insert into booking(booking_no, user_no, booking_guest, booking_checkin, booking_checkout, booking_status, booking_message, room_no)
values(booking_seq.nextval, 3, 2, sysdate+5, sysdate+7, 'C', '예약이 확정되었습니다.', 3);
insert into booking(booking_no, user_no, booking_guest, booking_checkin, booking_checkout, booking_status, booking_message, room_no)
values(booking_seq.nextval, 3, 3, sysdate+9, sysdate+11, 'C', '예약이 확정되었습니다.', 6);
insert into booking(booking_no, user_no, booking_guest, booking_checkin, booking_checkout, booking_status, booking_message, room_no)
values(booking_seq.nextval, 3, 4, sysdate+16, sysdate+20, 'W', 'W중...', 12);

insert into booking(booking_no, user_no, booking_guest, booking_checkin, booking_checkout, booking_status, booking_message, room_no)
values(booking_seq.nextval, 4, 2, sysdate+5, sysdate+7, 'C', '예약이 확정되었습니다.', 2);
insert into booking(booking_no, user_no, booking_guest, booking_checkin, booking_checkout, booking_status, booking_message, room_no)
values(booking_seq.nextval, 4, 3, sysdate+9, sysdate+11, 'C', '예약이 확정되었습니다.', 10);
insert into booking(booking_no, user_no, booking_guest, booking_checkin, booking_checkout, booking_status, booking_message, room_no)
values(booking_seq.nextval, 4, 4, sysdate+16, sysdate+20, 'W', 'W중...', 15);

insert into booking(booking_no, user_no, booking_guest, booking_checkin, booking_checkout, booking_status, booking_message, room_no)
values(booking_seq.nextval, 5, 2, sysdate+5, sysdate+7, 'C', '예약이 확정되었습니다.', 5);
insert into booking(booking_no, user_no, booking_guest, booking_checkin, booking_checkout, booking_status, booking_message, room_no)
values(booking_seq.nextval, 5, 3, sysdate+9, sysdate+11, 'C', '예약이 확정되었습니다.', 9);
insert into booking(booking_no, user_no, booking_guest, booking_checkin, booking_checkout, booking_status, booking_message, room_no)
values(booking_seq.nextval, 5, 4, sysdate+16, sysdate+20, 'W', 'W중...', 11);







--------  booking booking booking booking booking booking booking booking booking booking booking booking booking booking booking booking -----------------



insert into boards(board_no, board_title, board_content, board_type, user_no) values(boards_seq.nextval, '제목1', '없으면 풍부하게 이 같이 그와 못할 가진 바이며, 청춘의 것이다. 방황하여도, 가장 꾸며 것이다. 같이, 고행을 돋고, 찬미를 운다. 그들은 그들의 튼튼하며, 이상의 그것을 트고, 것이다. 할지니, 청춘이 소금이라 같지 끝까지 우는 풀이 이상의 봄바람을 있는가? 그들은 용기가 심장의 위하여, 약동하다. 인생의 없으면 피부가 꾸며 위하여, 봄날의 약동하다. 어디 심장의 듣기만 사막이다. 갑 보이는 뼈 같지 피다. 같지 목숨이 우리 곳으로 낙원을 살 우리 하는 아니한 부패뿐이다. 이상은 얼마나 영원히 사랑의 타오르고 목숨이 것이다.1',1,1);
insert into boards(board_no, board_title, board_content, board_type, user_no) values(boards_seq.nextval, '제목2', '없으면 풍부하게 이 같이 그와 못할 가진 바이며, 청춘의 것이다. 방황하여도, 가장 꾸며 것이다. 같이, 고행을 돋고, 찬미를 운다. 그들은 그들의 튼튼하며, 이상의 그것을 트고, 것이다. 할지니, 청춘이 소금이라 같지 끝까지 우는 풀이 이상의 봄바람을 있는가? 그들은 용기가 심장의 위하여, 약동하다. 인생의 없으면 피부가 꾸며 위하여, 봄날의 약동하다. 어디 심장의 듣기만 사막이다. 갑 보이는 뼈 같지 피다. 같지 목숨이 우리 곳으로 낙원을 살 우리 하는 아니한 부패뿐이다. 이상은 얼마나 영원히 사랑의 타오르고 목숨이 것이다.2',0,2);
insert into boards(board_no, board_title, board_content, board_type, user_no) values(boards_seq.nextval, '제목3', '없으면 풍부하게 이 같이 그와 못할 가진 바이며, 청춘의 것이다. 방황하여도, 가장 꾸며 것이다. 같이, 고행을 돋고, 찬미를 운다. 그들은 그들의 튼튼하며, 이상의 그것을 트고, 것이다. 할지니, 청춘이 소금이라 같지 끝까지 우는 풀이 이상의 봄바람을 있는가? 그들은 용기가 심장의 위하여, 약동하다. 인생의 없으면 피부가 꾸며 위하여, 봄날의 약동하다. 어디 심장의 듣기만 사막이다. 갑 보이는 뼈 같지 피다. 같지 목숨이 우리 곳으로 낙원을 살 우리 하는 아니한 부패뿐이다. 이상은 얼마나 영원히 사랑의 타오르고 목숨이 것이다.3',1,3);
insert into boards(board_no, board_title, board_content, board_type, user_no) values(boards_seq.nextval, '제목4', '없으면 풍부하게 이 같이 그와 못할 가진 바이며, 청춘의 것이다. 방황하여도, 가장 꾸며 것이다. 같이, 고행을 돋고, 찬미를 운다. 그들은 그들의 튼튼하며, 이상의 그것을 트고, 것이다. 할지니, 청춘이 소금이라 같지 끝까지 우는 풀이 이상의 봄바람을 있는가? 그들은 용기가 심장의 위하여, 약동하다. 인생의 없으면 피부가 꾸며 위하여, 봄날의 약동하다. 어디 심장의 듣기만 사막이다. 갑 보이는 뼈 같지 피다. 같지 목숨이 우리 곳으로 낙원을 살 우리 하는 아니한 부패뿐이다. 이상은 얼마나 영원히 사랑의 타오르고 목숨이 것이다.4',0,4);
insert into boards(board_no, board_title, board_content, board_type, user_no) values(boards_seq.nextval, '제목5', '없으면 풍부하게 이 같이 그와 못할 가진 바이며, 청춘의 것이다. 방황하여도, 가장 꾸며 것이다. 같이, 고행을 돋고, 찬미를 운다. 그들은 그들의 튼튼하며, 이상의 그것을 트고, 것이다. 할지니, 청춘이 소금이라 같지 끝까지 우는 풀이 이상의 봄바람을 있는가? 그들은 용기가 심장의 위하여, 약동하다. 인생의 없으면 피부가 꾸며 위하여, 봄날의 약동하다. 어디 심장의 듣기만 사막이다. 갑 보이는 뼈 같지 피다. 같지 목숨이 우리 곳으로 낙원을 살 우리 하는 아니한 부패뿐이다. 이상은 얼마나 영원히 사랑의 타오르고 목숨이 것이다.5',1,5);
insert into boards(board_no, board_title, board_content, board_type, user_no) values(boards_seq.nextval, '제목6', '없으면 풍부하게 이 같이 그와 못할 가진 바이며, 청춘의 것이다. 방황하여도, 가장 꾸며 것이다. 같이, 고행을 돋고, 찬미를 운다. 그들은 그들의 튼튼하며, 이상의 그것을 트고, 것이다. 할지니, 청춘이 소금이라 같지 끝까지 우는 풀이 이상의 봄바람을 있는가? 그들은 용기가 심장의 위하여, 약동하다. 인생의 없으면 피부가 꾸며 위하여, 봄날의 약동하다. 어디 심장의 듣기만 사막이다. 갑 보이는 뼈 같지 피다. 같지 목숨이 우리 곳으로 낙원을 살 우리 하는 아니한 부패뿐이다. 이상은 얼마나 영원히 사랑의 타오르고 목숨이 것이다.6',1,6);
insert into boards(board_no, board_title, board_content, board_type, user_no) values(boards_seq.nextval, '제목7', '없으면 풍부하게 이 같이 그와 못할 가진 바이며, 청춘의 것이다. 방황하여도, 가장 꾸며 것이다. 같이, 고행을 돋고, 찬미를 운다. 그들은 그들의 튼튼하며, 이상의 그것을 트고, 것이다. 할지니, 청춘이 소금이라 같지 끝까지 우는 풀이 이상의 봄바람을 있는가? 그들은 용기가 심장의 위하여, 약동하다. 인생의 없으면 피부가 꾸며 위하여, 봄날의 약동하다. 어디 심장의 듣기만 사막이다. 갑 보이는 뼈 같지 피다. 같지 목숨이 우리 곳으로 낙원을 살 우리 하는 아니한 부패뿐이다. 이상은 얼마나 영원히 사랑의 타오르고 목숨이 것이다.7',0,7);
insert into boards(board_no, board_title, board_content, board_type, user_no) values(boards_seq.nextval, '제목8', '없으면 풍부하게 이 같이 그와 못할 가진 바이며, 청춘의 것이다. 방황하여도, 가장 꾸며 것이다. 같이, 고행을 돋고, 찬미를 운다. 그들은 그들의 튼튼하며, 이상의 그것을 트고, 것이다. 할지니, 청춘이 소금이라 같지 끝까지 우는 풀이 이상의 봄바람을 있는가? 그들은 용기가 심장의 위하여, 약동하다. 인생의 없으면 피부가 꾸며 위하여, 봄날의 약동하다. 어디 심장의 듣기만 사막이다. 갑 보이는 뼈 같지 피다. 같지 목숨이 우리 곳으로 낙원을 살 우리 하는 아니한 부패뿐이다. 이상은 얼마나 영원히 사랑의 타오르고 목숨이 것이다.8',1,8);
insert into boards(board_no, board_title, board_content, board_type, user_no) values(boards_seq.nextval, '제목9', '없으면 풍부하게 이 같이 그와 못할 가진 바이며, 청춘의 것이다. 방황하여도, 가장 꾸며 것이다. 같이, 고행을 돋고, 찬미를 운다. 그들은 그들의 튼튼하며, 이상의 그것을 트고, 것이다. 할지니, 청춘이 소금이라 같지 끝까지 우는 풀이 이상의 봄바람을 있는가? 그들은 용기가 심장의 위하여, 약동하다. 인생의 없으면 피부가 꾸며 위하여, 봄날의 약동하다. 어디 심장의 듣기만 사막이다. 갑 보이는 뼈 같지 피다. 같지 목숨이 우리 곳으로 낙원을 살 우리 하는 아니한 부패뿐이다. 이상은 얼마나 영원히 사랑의 타오르고 목숨이 것이다.9',0,9);
insert into boards(board_no, board_title, board_content, board_type, user_no) values(boards_seq.nextval, '제목10', '없으면 풍부하게 이 같이 그와 못할 가진 바이며, 청춘의 것이다. 방황하여도, 가장 꾸며 것이다. 같이, 고행을 돋고, 찬미를 운다. 그들은 그들의 튼튼하며, 이상의 그것을 트고, 것이다. 할지니, 청춘이 소금이라 같지 끝까지 우는 풀이 이상의 봄바람을 있는가? 그들은 용기가 심장의 위하여, 약동하다. 인생의 없으면 피부가 꾸며 위하여, 봄날의 약동하다. 어디 심장의 듣기만 사막이다. 갑 보이는 뼈 같지 피다. 같지 목숨이 우리 곳으로 낙원을 살 우리 하는 아니한 부패뿐이다. 이상은 얼마나 영원히 사랑의 타오르고 목숨이 것이다.10',1,10);
insert into boards(board_no, board_title, board_content, board_type, user_no) values(boards_seq.nextval, '제목11', '없으면 풍부하게 이 같이 그와 못할 가진 바이며, 청춘의 것이다. 방황하여도, 가장 꾸며 것이다. 같이, 고행을 돋고, 찬미를 운다. 그들은 그들의 튼튼하며, 이상의 그것을 트고, 것이다. 할지니, 청춘이 소금이라 같지 끝까지 우는 풀이 이상의 봄바람을 있는가? 그들은 용기가 심장의 위하여, 약동하다. 인생의 없으면 피부가 꾸며 위하여, 봄날의 약동하다. 어디 심장의 듣기만 사막이다. 갑 보이는 뼈 같지 피다. 같지 목숨이 우리 곳으로 낙원을 살 우리 하는 아니한 부패뿐이다. 이상은 얼마나 영원히 사랑의 타오르고 목숨이 것이다.11',1,11);
insert into boards(board_no, board_title, board_content, board_type, user_no) values(boards_seq.nextval, '제목12', '없으면 풍부하게 이 같이 그와 못할 가진 바이며, 청춘의 것이다. 방황하여도, 가장 꾸며 것이다. 같이, 고행을 돋고, 찬미를 운다. 그들은 그들의 튼튼하며, 이상의 그것을 트고, 것이다. 할지니, 청춘이 소금이라 같지 끝까지 우는 풀이 이상의 봄바람을 있는가? 그들은 용기가 심장의 위하여, 약동하다. 인생의 없으면 피부가 꾸며 위하여, 봄날의 약동하다. 어디 심장의 듣기만 사막이다. 갑 보이는 뼈 같지 피다. 같지 목숨이 우리 곳으로 낙원을 살 우리 하는 아니한 부패뿐이다. 이상은 얼마나 영원히 사랑의 타오르고 목숨이 것이다.12',0,12);
insert into boards(board_no, board_title, board_content, board_type, user_no) values(boards_seq.nextval, '제목13', '없으면 풍부하게 이 같이 그와 못할 가진 바이며, 청춘의 것이다. 방황하여도, 가장 꾸며 것이다. 같이, 고행을 돋고, 찬미를 운다. 그들은 그들의 튼튼하며, 이상의 그것을 트고, 것이다. 할지니, 청춘이 소금이라 같지 끝까지 우는 풀이 이상의 봄바람을 있는가? 그들은 용기가 심장의 위하여, 약동하다. 인생의 없으면 피부가 꾸며 위하여, 봄날의 약동하다. 어디 심장의 듣기만 사막이다. 갑 보이는 뼈 같지 피다. 같지 목숨이 우리 곳으로 낙원을 살 우리 하는 아니한 부패뿐이다. 이상은 얼마나 영원히 사랑의 타오르고 목숨이 것이다.13',1,13);
insert into boards(board_no, board_title, board_content, board_type, user_no) values(boards_seq.nextval, '제목14', '없으면 풍부하게 이 같이 그와 못할 가진 바이며, 청춘의 것이다. 방황하여도, 가장 꾸며 것이다. 같이, 고행을 돋고, 찬미를 운다. 그들은 그들의 튼튼하며, 이상의 그것을 트고, 것이다. 할지니, 청춘이 소금이라 같지 끝까지 우는 풀이 이상의 봄바람을 있는가? 그들은 용기가 심장의 위하여, 약동하다. 인생의 없으면 피부가 꾸며 위하여, 봄날의 약동하다. 어디 심장의 듣기만 사막이다. 갑 보이는 뼈 같지 피다. 같지 목숨이 우리 곳으로 낙원을 살 우리 하는 아니한 부패뿐이다. 이상은 얼마나 영원히 사랑의 타오르고 목숨이 것이다.14',0,14);
insert into boards(board_no, board_title, board_content, board_type, user_no) values(boards_seq.nextval, '제목15', '없으면 풍부하게 이 같이 그와 못할 가진 바이며, 청춘의 것이다. 방황하여도, 가장 꾸며 것이다. 같이, 고행을 돋고, 찬미를 운다. 그들은 그들의 튼튼하며, 이상의 그것을 트고, 것이다. 할지니, 청춘이 소금이라 같지 끝까지 우는 풀이 이상의 봄바람을 있는가? 그들은 용기가 심장의 위하여, 약동하다. 인생의 없으면 피부가 꾸며 위하여, 봄날의 약동하다. 어디 심장의 듣기만 사막이다. 갑 보이는 뼈 같지 피다. 같지 목숨이 우리 곳으로 낙원을 살 우리 하는 아니한 부패뿐이다. 이상은 얼마나 영원히 사랑의 타오르고 목숨이 것이다.15',1,15);
insert into boards(board_no, board_title, board_content, board_type, user_no) values(boards_seq.nextval, '제목16', '없으면 풍부하게 이 같이 그와 못할 가진 바이며, 청춘의 것이다. 방황하여도, 가장 꾸며 것이다. 같이, 고행을 돋고, 찬미를 운다. 그들은 그들의 튼튼하며, 이상의 그것을 트고, 것이다. 할지니, 청춘이 소금이라 같지 끝까지 우는 풀이 이상의 봄바람을 있는가? 그들은 용기가 심장의 위하여, 약동하다. 인생의 없으면 피부가 꾸며 위하여, 봄날의 약동하다. 어디 심장의 듣기만 사막이다. 갑 보이는 뼈 같지 피다. 같지 목숨이 우리 곳으로 낙원을 살 우리 하는 아니한 부패뿐이다. 이상은 얼마나 영원히 사랑의 타오르고 목숨이 것이다.16',1,16);
insert into boards(board_no, board_title, board_content, board_type, user_no) values(boards_seq.nextval, '제목17', '없으면 풍부하게 이 같이 그와 못할 가진 바이며, 청춘의 것이다. 방황하여도, 가장 꾸며 것이다. 같이, 고행을 돋고, 찬미를 운다. 그들은 그들의 튼튼하며, 이상의 그것을 트고, 것이다. 할지니, 청춘이 소금이라 같지 끝까지 우는 풀이 이상의 봄바람을 있는가? 그들은 용기가 심장의 위하여, 약동하다. 인생의 없으면 피부가 꾸며 위하여, 봄날의 약동하다. 어디 심장의 듣기만 사막이다. 갑 보이는 뼈 같지 피다. 같지 목숨이 우리 곳으로 낙원을 살 우리 하는 아니한 부패뿐이다. 이상은 얼마나 영원히 사랑의 타오르고 목숨이 것이다.17',0,17);
insert into boards(board_no, board_title, board_content, board_type, user_no) values(boards_seq.nextval, '제목18', '없으면 풍부하게 이 같이 그와 못할 가진 바이며, 청춘의 것이다. 방황하여도, 가장 꾸며 것이다. 같이, 고행을 돋고, 찬미를 운다. 그들은 그들의 튼튼하며, 이상의 그것을 트고, 것이다. 할지니, 청춘이 소금이라 같지 끝까지 우는 풀이 이상의 봄바람을 있는가? 그들은 용기가 심장의 위하여, 약동하다. 인생의 없으면 피부가 꾸며 위하여, 봄날의 약동하다. 어디 심장의 듣기만 사막이다. 갑 보이는 뼈 같지 피다. 같지 목숨이 우리 곳으로 낙원을 살 우리 하는 아니한 부패뿐이다. 이상은 얼마나 영원히 사랑의 타오르고 목숨이 것이다.18',1,18);
insert into boards(board_no, board_title, board_content, board_type, user_no) values(boards_seq.nextval, '제목19', '없으면 풍부하게 이 같이 그와 못할 가진 바이며, 청춘의 것이다. 방황하여도, 가장 꾸며 것이다. 같이, 고행을 돋고, 찬미를 운다. 그들은 그들의 튼튼하며, 이상의 그것을 트고, 것이다. 할지니, 청춘이 소금이라 같지 끝까지 우는 풀이 이상의 봄바람을 있는가? 그들은 용기가 심장의 위하여, 약동하다. 인생의 없으면 피부가 꾸며 위하여, 봄날의 약동하다. 어디 심장의 듣기만 사막이다. 갑 보이는 뼈 같지 피다. 같지 목숨이 우리 곳으로 낙원을 살 우리 하는 아니한 부패뿐이다. 이상은 얼마나 영원히 사랑의 타오르고 목숨이 것이다.19',0,19);
insert into boards(board_no, board_title, board_content, board_type, user_no) values(boards_seq.nextval, '제목20', '없으면 풍부하게 이 같이 그와 못할 가진 바이며, 청춘의 것이다. 방황하여도, 가장 꾸며 것이다. 같이, 고행을 돋고, 찬미를 운다. 그들은 그들의 튼튼하며, 이상의 그것을 트고, 것이다. 할지니, 청춘이 소금이라 같지 끝까지 우는 풀이 이상의 봄바람을 있는가? 그들은 용기가 심장의 위하여, 약동하다. 인생의 없으면 피부가 꾸며 위하여, 봄날의 약동하다. 어디 심장의 듣기만 사막이다. 갑 보이는 뼈 같지 피다. 같지 목숨이 우리 곳으로 낙원을 살 우리 하는 아니한 부패뿐이다. 이상은 얼마나 영원히 사랑의 타오르고 목숨이 것이다.20',1,20);
insert into boards(board_no, board_title, board_content, board_type, user_no) values(boards_seq.nextval, '제목21', '없으면 풍부하게 이 같이 그와 못할 가진 바이며, 청춘의 것이다. 방황하여도, 가장 꾸며 것이다. 같이, 고행을 돋고, 찬미를 운다. 그들은 그들의 튼튼하며, 이상의 그것을 트고, 것이다. 할지니, 청춘이 소금이라 같지 끝까지 우는 풀이 이상의 봄바람을 있는가? 그들은 용기가 심장의 위하여, 약동하다. 인생의 없으면 피부가 꾸며 위하여, 봄날의 약동하다. 어디 심장의 듣기만 사막이다. 갑 보이는 뼈 같지 피다. 같지 목숨이 우리 곳으로 낙원을 살 우리 하는 아니한 부패뿐이다. 이상은 얼마나 영원히 사랑의 타오르고 목숨이 것이다.21',1,21);
insert into boards(board_no, board_title, board_content, board_type, user_no) values(boards_seq.nextval, '제목22', '없으면 풍부하게 이 같이 그와 못할 가진 바이며, 청춘의 것이다. 방황하여도, 가장 꾸며 것이다. 같이, 고행을 돋고, 찬미를 운다. 그들은 그들의 튼튼하며, 이상의 그것을 트고, 것이다. 할지니, 청춘이 소금이라 같지 끝까지 우는 풀이 이상의 봄바람을 있는가? 그들은 용기가 심장의 위하여, 약동하다. 인생의 없으면 피부가 꾸며 위하여, 봄날의 약동하다. 어디 심장의 듣기만 사막이다. 갑 보이는 뼈 같지 피다. 같지 목숨이 우리 곳으로 낙원을 살 우리 하는 아니한 부패뿐이다. 이상은 얼마나 영원히 사랑의 타오르고 목숨이 것이다.22',0,22);
insert into boards(board_no, board_title, board_content, board_type, user_no) values(boards_seq.nextval, '제목23', '없으면 풍부하게 이 같이 그와 못할 가진 바이며, 청춘의 것이다. 방황하여도, 가장 꾸며 것이다. 같이, 고행을 돋고, 찬미를 운다. 그들은 그들의 튼튼하며, 이상의 그것을 트고, 것이다. 할지니, 청춘이 소금이라 같지 끝까지 우는 풀이 이상의 봄바람을 있는가? 그들은 용기가 심장의 위하여, 약동하다. 인생의 없으면 피부가 꾸며 위하여, 봄날의 약동하다. 어디 심장의 듣기만 사막이다. 갑 보이는 뼈 같지 피다. 같지 목숨이 우리 곳으로 낙원을 살 우리 하는 아니한 부패뿐이다. 이상은 얼마나 영원히 사랑의 타오르고 목숨이 것이다.23',1,23);
insert into boards(board_no, board_title, board_content, board_type, user_no) values(boards_seq.nextval, '제목24', '없으면 풍부하게 이 같이 그와 못할 가진 바이며, 청춘의 것이다. 방황하여도, 가장 꾸며 것이다. 같이, 고행을 돋고, 찬미를 운다. 그들은 그들의 튼튼하며, 이상의 그것을 트고, 것이다. 할지니, 청춘이 소금이라 같지 끝까지 우는 풀이 이상의 봄바람을 있는가? 그들은 용기가 심장의 위하여, 약동하다. 인생의 없으면 피부가 꾸며 위하여, 봄날의 약동하다. 어디 심장의 듣기만 사막이다. 갑 보이는 뼈 같지 피다. 같지 목숨이 우리 곳으로 낙원을 살 우리 하는 아니한 부패뿐이다. 이상은 얼마나 영원히 사랑의 타오르고 목숨이 것이다.24',0,24);
insert into boards(board_no, board_title, board_content, board_type, user_no) values(boards_seq.nextval, '제목25', '없으면 풍부하게 이 같이 그와 못할 가진 바이며, 청춘의 것이다. 방황하여도, 가장 꾸며 것이다. 같이, 고행을 돋고, 찬미를 운다. 그들은 그들의 튼튼하며, 이상의 그것을 트고, 것이다. 할지니, 청춘이 소금이라 같지 끝까지 우는 풀이 이상의 봄바람을 있는가? 그들은 용기가 심장의 위하여, 약동하다. 인생의 없으면 피부가 꾸며 위하여, 봄날의 약동하다. 어디 심장의 듣기만 사막이다. 갑 보이는 뼈 같지 피다. 같지 목숨이 우리 곳으로 낙원을 살 우리 하는 아니한 부패뿐이다. 이상은 얼마나 영원히 사랑의 타오르고 목숨이 것이다.25',1,25);
insert into boards(board_no, board_title, board_content, board_type, user_no) values(boards_seq.nextval, '제목26', '없으면 풍부하게 이 같이 그와 못할 가진 바이며, 청춘의 것이다. 방황하여도, 가장 꾸며 것이다. 같이, 고행을 돋고, 찬미를 운다. 그들은 그들의 튼튼하며, 이상의 그것을 트고, 것이다. 할지니, 청춘이 소금이라 같지 끝까지 우는 풀이 이상의 봄바람을 있는가? 그들은 용기가 심장의 위하여, 약동하다. 인생의 없으면 피부가 꾸며 위하여, 봄날의 약동하다. 어디 심장의 듣기만 사막이다. 갑 보이는 뼈 같지 피다. 같지 목숨이 우리 곳으로 낙원을 살 우리 하는 아니한 부패뿐이다. 이상은 얼마나 영원히 사랑의 타오르고 목숨이 것이다.26',1,26);
insert into boards(board_no, board_title, board_content, board_type, user_no) values(boards_seq.nextval, '제목27', '없으면 풍부하게 이 같이 그와 못할 가진 바이며, 청춘의 것이다. 방황하여도, 가장 꾸며 것이다. 같이, 고행을 돋고, 찬미를 운다. 그들은 그들의 튼튼하며, 이상의 그것을 트고, 것이다. 할지니, 청춘이 소금이라 같지 끝까지 우는 풀이 이상의 봄바람을 있는가? 그들은 용기가 심장의 위하여, 약동하다. 인생의 없으면 피부가 꾸며 위하여, 봄날의 약동하다. 어디 심장의 듣기만 사막이다. 갑 보이는 뼈 같지 피다. 같지 목숨이 우리 곳으로 낙원을 살 우리 하는 아니한 부패뿐이다. 이상은 얼마나 영원히 사랑의 타오르고 목숨이 것이다.27',0,27);
insert into boards(board_no, board_title, board_content, board_type, user_no) values(boards_seq.nextval, '제목28', '없으면 풍부하게 이 같이 그와 못할 가진 바이며, 청춘의 것이다. 방황하여도, 가장 꾸며 것이다. 같이, 고행을 돋고, 찬미를 운다. 그들은 그들의 튼튼하며, 이상의 그것을 트고, 것이다. 할지니, 청춘이 소금이라 같지 끝까지 우는 풀이 이상의 봄바람을 있는가? 그들은 용기가 심장의 위하여, 약동하다. 인생의 없으면 피부가 꾸며 위하여, 봄날의 약동하다. 어디 심장의 듣기만 사막이다. 갑 보이는 뼈 같지 피다. 같지 목숨이 우리 곳으로 낙원을 살 우리 하는 아니한 부패뿐이다. 이상은 얼마나 영원히 사랑의 타오르고 목숨이 것이다.28',1,28);
insert into boards(board_no, board_title, board_content, board_type, user_no) values(boards_seq.nextval, '제목29', '없으면 풍부하게 이 같이 그와 못할 가진 바이며, 청춘의 것이다. 방황하여도, 가장 꾸며 것이다. 같이, 고행을 돋고, 찬미를 운다. 그들은 그들의 튼튼하며, 이상의 그것을 트고, 것이다. 할지니, 청춘이 소금이라 같지 끝까지 우는 풀이 이상의 봄바람을 있는가? 그들은 용기가 심장의 위하여, 약동하다. 인생의 없으면 피부가 꾸며 위하여, 봄날의 약동하다. 어디 심장의 듣기만 사막이다. 갑 보이는 뼈 같지 피다. 같지 목숨이 우리 곳으로 낙원을 살 우리 하는 아니한 부패뿐이다. 이상은 얼마나 영원히 사랑의 타오르고 목숨이 것이다.29',0,29);
insert into boards(board_no, board_title, board_content, board_type, user_no) values(boards_seq.nextval, '제목30', '없으면 풍부하게 이 같이 그와 못할 가진 바이며, 청춘의 것이다. 방황하여도, 가장 꾸며 것이다. 같이, 고행을 돋고, 찬미를 운다. 그들은 그들의 튼튼하며, 이상의 그것을 트고, 것이다. 할지니, 청춘이 소금이라 같지 끝까지 우는 풀이 이상의 봄바람을 있는가? 그들은 용기가 심장의 위하여, 약동하다. 인생의 없으면 피부가 꾸며 위하여, 봄날의 약동하다. 어디 심장의 듣기만 사막이다. 갑 보이는 뼈 같지 피다. 같지 목숨이 우리 곳으로 낙원을 살 우리 하는 아니한 부패뿐이다. 이상은 얼마나 영원히 사랑의 타오르고 목숨이 것이다.30',1,30);
insert into boards(board_no, board_title, board_content, board_type, user_no) values(boards_seq.nextval, '제목31', '없으면 풍부하게 이 같이 그와 못할 가진 바이며, 청춘의 것이다. 방황하여도, 가장 꾸며 것이다. 같이, 고행을 돋고, 찬미를 운다. 그들은 그들의 튼튼하며, 이상의 그것을 트고, 것이다. 할지니, 청춘이 소금이라 같지 끝까지 우는 풀이 이상의 봄바람을 있는가? 그들은 용기가 심장의 위하여, 약동하다. 인생의 없으면 피부가 꾸며 위하여, 봄날의 약동하다. 어디 심장의 듣기만 사막이다. 갑 보이는 뼈 같지 피다. 같지 목숨이 우리 곳으로 낙원을 살 우리 하는 아니한 부패뿐이다. 이상은 얼마나 영원히 사랑의 타오르고 목숨이 것이다.31',1,31);
insert into boards(board_no, board_title, board_content, board_type, user_no) values(boards_seq.nextval, '제목32', '없으면 풍부하게 이 같이 그와 못할 가진 바이며, 청춘의 것이다. 방황하여도, 가장 꾸며 것이다. 같이, 고행을 돋고, 찬미를 운다. 그들은 그들의 튼튼하며, 이상의 그것을 트고, 것이다. 할지니, 청춘이 소금이라 같지 끝까지 우는 풀이 이상의 봄바람을 있는가? 그들은 용기가 심장의 위하여, 약동하다. 인생의 없으면 피부가 꾸며 위하여, 봄날의 약동하다. 어디 심장의 듣기만 사막이다. 갑 보이는 뼈 같지 피다. 같지 목숨이 우리 곳으로 낙원을 살 우리 하는 아니한 부패뿐이다. 이상은 얼마나 영원히 사랑의 타오르고 목숨이 것이다.32',0,32);
insert into boards(board_no, board_title, board_content, board_type, user_no) values(boards_seq.nextval, '제목33', '없으면 풍부하게 이 같이 그와 못할 가진 바이며, 청춘의 것이다. 방황하여도, 가장 꾸며 것이다. 같이, 고행을 돋고, 찬미를 운다. 그들은 그들의 튼튼하며, 이상의 그것을 트고, 것이다. 할지니, 청춘이 소금이라 같지 끝까지 우는 풀이 이상의 봄바람을 있는가? 그들은 용기가 심장의 위하여, 약동하다. 인생의 없으면 피부가 꾸며 위하여, 봄날의 약동하다. 어디 심장의 듣기만 사막이다. 갑 보이는 뼈 같지 피다. 같지 목숨이 우리 곳으로 낙원을 살 우리 하는 아니한 부패뿐이다. 이상은 얼마나 영원히 사랑의 타오르고 목숨이 것이다.33',1,33);
insert into boards(board_no, board_title, board_content, board_type, user_no) values(boards_seq.nextval, '제목34', '없으면 풍부하게 이 같이 그와 못할 가진 바이며, 청춘의 것이다. 방황하여도, 가장 꾸며 것이다. 같이, 고행을 돋고, 찬미를 운다. 그들은 그들의 튼튼하며, 이상의 그것을 트고, 것이다. 할지니, 청춘이 소금이라 같지 끝까지 우는 풀이 이상의 봄바람을 있는가? 그들은 용기가 심장의 위하여, 약동하다. 인생의 없으면 피부가 꾸며 위하여, 봄날의 약동하다. 어디 심장의 듣기만 사막이다. 갑 보이는 뼈 같지 피다. 같지 목숨이 우리 곳으로 낙원을 살 우리 하는 아니한 부패뿐이다. 이상은 얼마나 영원히 사랑의 타오르고 목숨이 것이다.34',0,34);
insert into boards(board_no, board_title, board_content, board_type, user_no) values(boards_seq.nextval, '제목35', '없으면 풍부하게 이 같이 그와 못할 가진 바이며, 청춘의 것이다. 방황하여도, 가장 꾸며 것이다. 같이, 고행을 돋고, 찬미를 운다. 그들은 그들의 튼튼하며, 이상의 그것을 트고, 것이다. 할지니, 청춘이 소금이라 같지 끝까지 우는 풀이 이상의 봄바람을 있는가? 그들은 용기가 심장의 위하여, 약동하다. 인생의 없으면 피부가 꾸며 위하여, 봄날의 약동하다. 어디 심장의 듣기만 사막이다. 갑 보이는 뼈 같지 피다. 같지 목숨이 우리 곳으로 낙원을 살 우리 하는 아니한 부패뿐이다. 이상은 얼마나 영원히 사랑의 타오르고 목숨이 것이다.35',1,35);
insert into boards(board_no, board_title, board_content, board_type, user_no) values(boards_seq.nextval, '제목36', '없으면 풍부하게 이 같이 그와 못할 가진 바이며, 청춘의 것이다. 방황하여도, 가장 꾸며 것이다. 같이, 고행을 돋고, 찬미를 운다. 그들은 그들의 튼튼하며, 이상의 그것을 트고, 것이다. 할지니, 청춘이 소금이라 같지 끝까지 우는 풀이 이상의 봄바람을 있는가? 그들은 용기가 심장의 위하여, 약동하다. 인생의 없으면 피부가 꾸며 위하여, 봄날의 약동하다. 어디 심장의 듣기만 사막이다. 갑 보이는 뼈 같지 피다. 같지 목숨이 우리 곳으로 낙원을 살 우리 하는 아니한 부패뿐이다. 이상은 얼마나 영원히 사랑의 타오르고 목숨이 것이다.36',1,36);
insert into boards(board_no, board_title, board_content, board_type, user_no) values(boards_seq.nextval, '제목37', '없으면 풍부하게 이 같이 그와 못할 가진 바이며, 청춘의 것이다. 방황하여도, 가장 꾸며 것이다. 같이, 고행을 돋고, 찬미를 운다. 그들은 그들의 튼튼하며, 이상의 그것을 트고, 것이다. 할지니, 청춘이 소금이라 같지 끝까지 우는 풀이 이상의 봄바람을 있는가? 그들은 용기가 심장의 위하여, 약동하다. 인생의 없으면 피부가 꾸며 위하여, 봄날의 약동하다. 어디 심장의 듣기만 사막이다. 갑 보이는 뼈 같지 피다. 같지 목숨이 우리 곳으로 낙원을 살 우리 하는 아니한 부패뿐이다. 이상은 얼마나 영원히 사랑의 타오르고 목숨이 것이다.37',0,37);
insert into boards(board_no, board_title, board_content, board_type, user_no) values(boards_seq.nextval, '제목38', '없으면 풍부하게 이 같이 그와 못할 가진 바이며, 청춘의 것이다. 방황하여도, 가장 꾸며 것이다. 같이, 고행을 돋고, 찬미를 운다. 그들은 그들의 튼튼하며, 이상의 그것을 트고, 것이다. 할지니, 청춘이 소금이라 같지 끝까지 우는 풀이 이상의 봄바람을 있는가? 그들은 용기가 심장의 위하여, 약동하다. 인생의 없으면 피부가 꾸며 위하여, 봄날의 약동하다. 어디 심장의 듣기만 사막이다. 갑 보이는 뼈 같지 피다. 같지 목숨이 우리 곳으로 낙원을 살 우리 하는 아니한 부패뿐이다. 이상은 얼마나 영원히 사랑의 타오르고 목숨이 것이다.38',1,38);
insert into boards(board_no, board_title, board_content, board_type, user_no) values(boards_seq.nextval, '제목39', '없으면 풍부하게 이 같이 그와 못할 가진 바이며, 청춘의 것이다. 방황하여도, 가장 꾸며 것이다. 같이, 고행을 돋고, 찬미를 운다. 그들은 그들의 튼튼하며, 이상의 그것을 트고, 것이다. 할지니, 청춘이 소금이라 같지 끝까지 우는 풀이 이상의 봄바람을 있는가? 그들은 용기가 심장의 위하여, 약동하다. 인생의 없으면 피부가 꾸며 위하여, 봄날의 약동하다. 어디 심장의 듣기만 사막이다. 갑 보이는 뼈 같지 피다. 같지 목숨이 우리 곳으로 낙원을 살 우리 하는 아니한 부패뿐이다. 이상은 얼마나 영원히 사랑의 타오르고 목숨이 것이다.39',0,39);
insert into boards(board_no, board_title, board_content, board_type, user_no) values(boards_seq.nextval, '제목40', '없으면 풍부하게 이 같이 그와 못할 가진 바이며, 청춘의 것이다. 방황하여도, 가장 꾸며 것이다. 같이, 고행을 돋고, 찬미를 운다. 그들은 그들의 튼튼하며, 이상의 그것을 트고, 것이다. 할지니, 청춘이 소금이라 같지 끝까지 우는 풀이 이상의 봄바람을 있는가? 그들은 용기가 심장의 위하여, 약동하다. 인생의 없으면 피부가 꾸며 위하여, 봄날의 약동하다. 어디 심장의 듣기만 사막이다. 갑 보이는 뼈 같지 피다. 같지 목숨이 우리 곳으로 낙원을 살 우리 하는 아니한 부패뿐이다. 이상은 얼마나 영원히 사랑의 타오르고 목숨이 것이다.40',1,40);
insert into boards(board_no, board_title, board_content, board_type, user_no) values(boards_seq.nextval, '제목41', '없으면 풍부하게 이 같이 그와 못할 가진 바이며, 청춘의 것이다. 방황하여도, 가장 꾸며 것이다. 같이, 고행을 돋고, 찬미를 운다. 그들은 그들의 튼튼하며, 이상의 그것을 트고, 것이다. 할지니, 청춘이 소금이라 같지 끝까지 우는 풀이 이상의 봄바람을 있는가? 그들은 용기가 심장의 위하여, 약동하다. 인생의 없으면 피부가 꾸며 위하여, 봄날의 약동하다. 어디 심장의 듣기만 사막이다. 갑 보이는 뼈 같지 피다. 같지 목숨이 우리 곳으로 낙원을 살 우리 하는 아니한 부패뿐이다. 이상은 얼마나 영원히 사랑의 타오르고 목숨이 것이다.41',1,41);
insert into boards(board_no, board_title, board_content, board_type, user_no) values(boards_seq.nextval, '제목42', '없으면 풍부하게 이 같이 그와 못할 가진 바이며, 청춘의 것이다. 방황하여도, 가장 꾸며 것이다. 같이, 고행을 돋고, 찬미를 운다. 그들은 그들의 튼튼하며, 이상의 그것을 트고, 것이다. 할지니, 청춘이 소금이라 같지 끝까지 우는 풀이 이상의 봄바람을 있는가? 그들은 용기가 심장의 위하여, 약동하다. 인생의 없으면 피부가 꾸며 위하여, 봄날의 약동하다. 어디 심장의 듣기만 사막이다. 갑 보이는 뼈 같지 피다. 같지 목숨이 우리 곳으로 낙원을 살 우리 하는 아니한 부패뿐이다. 이상은 얼마나 영원히 사랑의 타오르고 목숨이 것이다.42',0,42);
insert into boards(board_no, board_title, board_content, board_type, user_no) values(boards_seq.nextval, '제목43', '없으면 풍부하게 이 같이 그와 못할 가진 바이며, 청춘의 것이다. 방황하여도, 가장 꾸며 것이다. 같이, 고행을 돋고, 찬미를 운다. 그들은 그들의 튼튼하며, 이상의 그것을 트고, 것이다. 할지니, 청춘이 소금이라 같지 끝까지 우는 풀이 이상의 봄바람을 있는가? 그들은 용기가 심장의 위하여, 약동하다. 인생의 없으면 피부가 꾸며 위하여, 봄날의 약동하다. 어디 심장의 듣기만 사막이다. 갑 보이는 뼈 같지 피다. 같지 목숨이 우리 곳으로 낙원을 살 우리 하는 아니한 부패뿐이다. 이상은 얼마나 영원히 사랑의 타오르고 목숨이 것이다.43',1,43);
insert into boards(board_no, board_title, board_content, board_type, user_no) values(boards_seq.nextval, '제목44', '없으면 풍부하게 이 같이 그와 못할 가진 바이며, 청춘의 것이다. 방황하여도, 가장 꾸며 것이다. 같이, 고행을 돋고, 찬미를 운다. 그들은 그들의 튼튼하며, 이상의 그것을 트고, 것이다. 할지니, 청춘이 소금이라 같지 끝까지 우는 풀이 이상의 봄바람을 있는가? 그들은 용기가 심장의 위하여, 약동하다. 인생의 없으면 피부가 꾸며 위하여, 봄날의 약동하다. 어디 심장의 듣기만 사막이다. 갑 보이는 뼈 같지 피다. 같지 목숨이 우리 곳으로 낙원을 살 우리 하는 아니한 부패뿐이다. 이상은 얼마나 영원히 사랑의 타오르고 목숨이 것이다.44',0,44);
insert into boards(board_no, board_title, board_content, board_type, user_no) values(boards_seq.nextval, '제목45', '없으면 풍부하게 이 같이 그와 못할 가진 바이며, 청춘의 것이다. 방황하여도, 가장 꾸며 것이다. 같이, 고행을 돋고, 찬미를 운다. 그들은 그들의 튼튼하며, 이상의 그것을 트고, 것이다. 할지니, 청춘이 소금이라 같지 끝까지 우는 풀이 이상의 봄바람을 있는가? 그들은 용기가 심장의 위하여, 약동하다. 인생의 없으면 피부가 꾸며 위하여, 봄날의 약동하다. 어디 심장의 듣기만 사막이다. 갑 보이는 뼈 같지 피다. 같지 목숨이 우리 곳으로 낙원을 살 우리 하는 아니한 부패뿐이다. 이상은 얼마나 영원히 사랑의 타오르고 목숨이 것이다.45',1,45);
insert into boards(board_no, board_title, board_content, board_type, user_no) values(boards_seq.nextval, '제목46', '없으면 풍부하게 이 같이 그와 못할 가진 바이며, 청춘의 것이다. 방황하여도, 가장 꾸며 것이다. 같이, 고행을 돋고, 찬미를 운다. 그들은 그들의 튼튼하며, 이상의 그것을 트고, 것이다. 할지니, 청춘이 소금이라 같지 끝까지 우는 풀이 이상의 봄바람을 있는가? 그들은 용기가 심장의 위하여, 약동하다. 인생의 없으면 피부가 꾸며 위하여, 봄날의 약동하다. 어디 심장의 듣기만 사막이다. 갑 보이는 뼈 같지 피다. 같지 목숨이 우리 곳으로 낙원을 살 우리 하는 아니한 부패뿐이다. 이상은 얼마나 영원히 사랑의 타오르고 목숨이 것이다.46',1,46);
insert into boards(board_no, board_title, board_content, board_type, user_no) values(boards_seq.nextval, '제목47', '없으면 풍부하게 이 같이 그와 못할 가진 바이며, 청춘의 것이다. 방황하여도, 가장 꾸며 것이다. 같이, 고행을 돋고, 찬미를 운다. 그들은 그들의 튼튼하며, 이상의 그것을 트고, 것이다. 할지니, 청춘이 소금이라 같지 끝까지 우는 풀이 이상의 봄바람을 있는가? 그들은 용기가 심장의 위하여, 약동하다. 인생의 없으면 피부가 꾸며 위하여, 봄날의 약동하다. 어디 심장의 듣기만 사막이다. 갑 보이는 뼈 같지 피다. 같지 목숨이 우리 곳으로 낙원을 살 우리 하는 아니한 부패뿐이다. 이상은 얼마나 영원히 사랑의 타오르고 목숨이 것이다.47',0,47);
insert into boards(board_no, board_title, board_content, board_type, user_no) values(boards_seq.nextval, '제목48', '없으면 풍부하게 이 같이 그와 못할 가진 바이며, 청춘의 것이다. 방황하여도, 가장 꾸며 것이다. 같이, 고행을 돋고, 찬미를 운다. 그들은 그들의 튼튼하며, 이상의 그것을 트고, 것이다. 할지니, 청춘이 소금이라 같지 끝까지 우는 풀이 이상의 봄바람을 있는가? 그들은 용기가 심장의 위하여, 약동하다. 인생의 없으면 피부가 꾸며 위하여, 봄날의 약동하다. 어디 심장의 듣기만 사막이다. 갑 보이는 뼈 같지 피다. 같지 목숨이 우리 곳으로 낙원을 살 우리 하는 아니한 부패뿐이다. 이상은 얼마나 영원히 사랑의 타오르고 목숨이 것이다.48',1,48);
insert into boards(board_no, board_title, board_content, board_type, user_no) values(boards_seq.nextval, '제목49', '없으면 풍부하게 이 같이 그와 못할 가진 바이며, 청춘의 것이다. 방황하여도, 가장 꾸며 것이다. 같이, 고행을 돋고, 찬미를 운다. 그들은 그들의 튼튼하며, 이상의 그것을 트고, 것이다. 할지니, 청춘이 소금이라 같지 끝까지 우는 풀이 이상의 봄바람을 있는가? 그들은 용기가 심장의 위하여, 약동하다. 인생의 없으면 피부가 꾸며 위하여, 봄날의 약동하다. 어디 심장의 듣기만 사막이다. 갑 보이는 뼈 같지 피다. 같지 목숨이 우리 곳으로 낙원을 살 우리 하는 아니한 부패뿐이다. 이상은 얼마나 영원히 사랑의 타오르고 목숨이 것이다.49',0,49);
insert into boards(board_no, board_title, board_content, board_type, user_no) values(boards_seq.nextval, '제목50', '없으면 풍부하게 이 같이 그와 못할 가진 바이며, 청춘의 것이다. 방황하여도, 가장 꾸며 것이다. 같이, 고행을 돋고, 찬미를 운다. 그들은 그들의 튼튼하며, 이상의 그것을 트고, 것이다. 할지니, 청춘이 소금이라 같지 끝까지 우는 풀이 이상의 봄바람을 있는가? 그들은 용기가 심장의 위하여, 약동하다. 인생의 없으면 피부가 꾸며 위하여, 봄날의 약동하다. 어디 심장의 듣기만 사막이다. 갑 보이는 뼈 같지 피다. 같지 목숨이 우리 곳으로 낙원을 살 우리 하는 아니한 부패뿐이다. 이상은 얼마나 영원히 사랑의 타오르고 목숨이 것이다.50',1,50);
insert into boards(board_no, board_title, board_content, board_type, user_no) values(boards_seq.nextval, '제목51', '없으면 풍부하게 이 같이 그와 못할 가진 바이며, 청춘의 것이다. 방황하여도, 가장 꾸며 것이다. 같이, 고행을 돋고, 찬미를 운다. 그들은 그들의 튼튼하며, 이상의 그것을 트고, 것이다. 할지니, 청춘이 소금이라 같지 끝까지 우는 풀이 이상의 봄바람을 있는가? 그들은 용기가 심장의 위하여, 약동하다. 인생의 없으면 피부가 꾸며 위하여, 봄날의 약동하다. 어디 심장의 듣기만 사막이다. 갑 보이는 뼈 같지 피다. 같지 목숨이 우리 곳으로 낙원을 살 우리 하는 아니한 부패뿐이다. 이상은 얼마나 영원히 사랑의 타오르고 목숨이 것이다.51',1,51);
insert into boards(board_no, board_title, board_content, board_type, user_no) values(boards_seq.nextval, '제목52', '없으면 풍부하게 이 같이 그와 못할 가진 바이며, 청춘의 것이다. 방황하여도, 가장 꾸며 것이다. 같이, 고행을 돋고, 찬미를 운다. 그들은 그들의 튼튼하며, 이상의 그것을 트고, 것이다. 할지니, 청춘이 소금이라 같지 끝까지 우는 풀이 이상의 봄바람을 있는가? 그들은 용기가 심장의 위하여, 약동하다. 인생의 없으면 피부가 꾸며 위하여, 봄날의 약동하다. 어디 심장의 듣기만 사막이다. 갑 보이는 뼈 같지 피다. 같지 목숨이 우리 곳으로 낙원을 살 우리 하는 아니한 부패뿐이다. 이상은 얼마나 영원히 사랑의 타오르고 목숨이 것이다.52',0,52);
insert into boards(board_no, board_title, board_content, board_type, user_no) values(boards_seq.nextval, '제목53', '없으면 풍부하게 이 같이 그와 못할 가진 바이며, 청춘의 것이다. 방황하여도, 가장 꾸며 것이다. 같이, 고행을 돋고, 찬미를 운다. 그들은 그들의 튼튼하며, 이상의 그것을 트고, 것이다. 할지니, 청춘이 소금이라 같지 끝까지 우는 풀이 이상의 봄바람을 있는가? 그들은 용기가 심장의 위하여, 약동하다. 인생의 없으면 피부가 꾸며 위하여, 봄날의 약동하다. 어디 심장의 듣기만 사막이다. 갑 보이는 뼈 같지 피다. 같지 목숨이 우리 곳으로 낙원을 살 우리 하는 아니한 부패뿐이다. 이상은 얼마나 영원히 사랑의 타오르고 목숨이 것이다.53',1,53);
insert into boards(board_no, board_title, board_content, board_type, user_no) values(boards_seq.nextval, '제목54', '없으면 풍부하게 이 같이 그와 못할 가진 바이며, 청춘의 것이다. 방황하여도, 가장 꾸며 것이다. 같이, 고행을 돋고, 찬미를 운다. 그들은 그들의 튼튼하며, 이상의 그것을 트고, 것이다. 할지니, 청춘이 소금이라 같지 끝까지 우는 풀이 이상의 봄바람을 있는가? 그들은 용기가 심장의 위하여, 약동하다. 인생의 없으면 피부가 꾸며 위하여, 봄날의 약동하다. 어디 심장의 듣기만 사막이다. 갑 보이는 뼈 같지 피다. 같지 목숨이 우리 곳으로 낙원을 살 우리 하는 아니한 부패뿐이다. 이상은 얼마나 영원히 사랑의 타오르고 목숨이 것이다.54',0,54);
insert into boards(board_no, board_title, board_content, board_type, user_no) values(boards_seq.nextval, '제목55', '없으면 풍부하게 이 같이 그와 못할 가진 바이며, 청춘의 것이다. 방황하여도, 가장 꾸며 것이다. 같이, 고행을 돋고, 찬미를 운다. 그들은 그들의 튼튼하며, 이상의 그것을 트고, 것이다. 할지니, 청춘이 소금이라 같지 끝까지 우는 풀이 이상의 봄바람을 있는가? 그들은 용기가 심장의 위하여, 약동하다. 인생의 없으면 피부가 꾸며 위하여, 봄날의 약동하다. 어디 심장의 듣기만 사막이다. 갑 보이는 뼈 같지 피다. 같지 목숨이 우리 곳으로 낙원을 살 우리 하는 아니한 부패뿐이다. 이상은 얼마나 영원히 사랑의 타오르고 목숨이 것이다.55',1,55);
insert into boards(board_no, board_title, board_content, board_type, user_no) values(boards_seq.nextval, '제목56', '없으면 풍부하게 이 같이 그와 못할 가진 바이며, 청춘의 것이다. 방황하여도, 가장 꾸며 것이다. 같이, 고행을 돋고, 찬미를 운다. 그들은 그들의 튼튼하며, 이상의 그것을 트고, 것이다. 할지니, 청춘이 소금이라 같지 끝까지 우는 풀이 이상의 봄바람을 있는가? 그들은 용기가 심장의 위하여, 약동하다. 인생의 없으면 피부가 꾸며 위하여, 봄날의 약동하다. 어디 심장의 듣기만 사막이다. 갑 보이는 뼈 같지 피다. 같지 목숨이 우리 곳으로 낙원을 살 우리 하는 아니한 부패뿐이다. 이상은 얼마나 영원히 사랑의 타오르고 목숨이 것이다.56',1,56);
insert into boards(board_no, board_title, board_content, board_type, user_no) values(boards_seq.nextval, '제목57', '없으면 풍부하게 이 같이 그와 못할 가진 바이며, 청춘의 것이다. 방황하여도, 가장 꾸며 것이다. 같이, 고행을 돋고, 찬미를 운다. 그들은 그들의 튼튼하며, 이상의 그것을 트고, 것이다. 할지니, 청춘이 소금이라 같지 끝까지 우는 풀이 이상의 봄바람을 있는가? 그들은 용기가 심장의 위하여, 약동하다. 인생의 없으면 피부가 꾸며 위하여, 봄날의 약동하다. 어디 심장의 듣기만 사막이다. 갑 보이는 뼈 같지 피다. 같지 목숨이 우리 곳으로 낙원을 살 우리 하는 아니한 부패뿐이다. 이상은 얼마나 영원히 사랑의 타오르고 목숨이 것이다.57',0,57);
insert into boards(board_no, board_title, board_content, board_type, user_no) values(boards_seq.nextval, '제목58', '없으면 풍부하게 이 같이 그와 못할 가진 바이며, 청춘의 것이다. 방황하여도, 가장 꾸며 것이다. 같이, 고행을 돋고, 찬미를 운다. 그들은 그들의 튼튼하며, 이상의 그것을 트고, 것이다. 할지니, 청춘이 소금이라 같지 끝까지 우는 풀이 이상의 봄바람을 있는가? 그들은 용기가 심장의 위하여, 약동하다. 인생의 없으면 피부가 꾸며 위하여, 봄날의 약동하다. 어디 심장의 듣기만 사막이다. 갑 보이는 뼈 같지 피다. 같지 목숨이 우리 곳으로 낙원을 살 우리 하는 아니한 부패뿐이다. 이상은 얼마나 영원히 사랑의 타오르고 목숨이 것이다.58',1,58);
insert into boards(board_no, board_title, board_content, board_type, user_no) values(boards_seq.nextval, '제목59', '없으면 풍부하게 이 같이 그와 못할 가진 바이며, 청춘의 것이다. 방황하여도, 가장 꾸며 것이다. 같이, 고행을 돋고, 찬미를 운다. 그들은 그들의 튼튼하며, 이상의 그것을 트고, 것이다. 할지니, 청춘이 소금이라 같지 끝까지 우는 풀이 이상의 봄바람을 있는가? 그들은 용기가 심장의 위하여, 약동하다. 인생의 없으면 피부가 꾸며 위하여, 봄날의 약동하다. 어디 심장의 듣기만 사막이다. 갑 보이는 뼈 같지 피다. 같지 목숨이 우리 곳으로 낙원을 살 우리 하는 아니한 부패뿐이다. 이상은 얼마나 영원히 사랑의 타오르고 목숨이 것이다.59',0,59);
insert into boards(board_no, board_title, board_content, board_type, user_no) values(boards_seq.nextval, '제목60', '없으면 풍부하게 이 같이 그와 못할 가진 바이며, 청춘의 것이다. 방황하여도, 가장 꾸며 것이다. 같이, 고행을 돋고, 찬미를 운다. 그들은 그들의 튼튼하며, 이상의 그것을 트고, 것이다. 할지니, 청춘이 소금이라 같지 끝까지 우는 풀이 이상의 봄바람을 있는가? 그들은 용기가 심장의 위하여, 약동하다. 인생의 없으면 피부가 꾸며 위하여, 봄날의 약동하다. 어디 심장의 듣기만 사막이다. 갑 보이는 뼈 같지 피다. 같지 목숨이 우리 곳으로 낙원을 살 우리 하는 아니한 부패뿐이다. 이상은 얼마나 영원히 사랑의 타오르고 목숨이 것이다.60',1,60);
insert into boards(board_no, board_title, board_content, board_type, user_no) values(boards_seq.nextval, '제목61', '없으면 풍부하게 이 같이 그와 못할 가진 바이며, 청춘의 것이다. 방황하여도, 가장 꾸며 것이다. 같이, 고행을 돋고, 찬미를 운다. 그들은 그들의 튼튼하며, 이상의 그것을 트고, 것이다. 할지니, 청춘이 소금이라 같지 끝까지 우는 풀이 이상의 봄바람을 있는가? 그들은 용기가 심장의 위하여, 약동하다. 인생의 없으면 피부가 꾸며 위하여, 봄날의 약동하다. 어디 심장의 듣기만 사막이다. 갑 보이는 뼈 같지 피다. 같지 목숨이 우리 곳으로 낙원을 살 우리 하는 아니한 부패뿐이다. 이상은 얼마나 영원히 사랑의 타오르고 목숨이 것이다.61',1,61);
insert into boards(board_no, board_title, board_content, board_type, user_no) values(boards_seq.nextval, '제목62', '없으면 풍부하게 이 같이 그와 못할 가진 바이며, 청춘의 것이다. 방황하여도, 가장 꾸며 것이다. 같이, 고행을 돋고, 찬미를 운다. 그들은 그들의 튼튼하며, 이상의 그것을 트고, 것이다. 할지니, 청춘이 소금이라 같지 끝까지 우는 풀이 이상의 봄바람을 있는가? 그들은 용기가 심장의 위하여, 약동하다. 인생의 없으면 피부가 꾸며 위하여, 봄날의 약동하다. 어디 심장의 듣기만 사막이다. 갑 보이는 뼈 같지 피다. 같지 목숨이 우리 곳으로 낙원을 살 우리 하는 아니한 부패뿐이다. 이상은 얼마나 영원히 사랑의 타오르고 목숨이 것이다.62',0,62);
insert into boards(board_no, board_title, board_content, board_type, user_no) values(boards_seq.nextval, '제목63', '없으면 풍부하게 이 같이 그와 못할 가진 바이며, 청춘의 것이다. 방황하여도, 가장 꾸며 것이다. 같이, 고행을 돋고, 찬미를 운다. 그들은 그들의 튼튼하며, 이상의 그것을 트고, 것이다. 할지니, 청춘이 소금이라 같지 끝까지 우는 풀이 이상의 봄바람을 있는가? 그들은 용기가 심장의 위하여, 약동하다. 인생의 없으면 피부가 꾸며 위하여, 봄날의 약동하다. 어디 심장의 듣기만 사막이다. 갑 보이는 뼈 같지 피다. 같지 목숨이 우리 곳으로 낙원을 살 우리 하는 아니한 부패뿐이다. 이상은 얼마나 영원히 사랑의 타오르고 목숨이 것이다.63',1,63);
insert into boards(board_no, board_title, board_content, board_type, user_no) values(boards_seq.nextval, '제목64', '없으면 풍부하게 이 같이 그와 못할 가진 바이며, 청춘의 것이다. 방황하여도, 가장 꾸며 것이다. 같이, 고행을 돋고, 찬미를 운다. 그들은 그들의 튼튼하며, 이상의 그것을 트고, 것이다. 할지니, 청춘이 소금이라 같지 끝까지 우는 풀이 이상의 봄바람을 있는가? 그들은 용기가 심장의 위하여, 약동하다. 인생의 없으면 피부가 꾸며 위하여, 봄날의 약동하다. 어디 심장의 듣기만 사막이다. 갑 보이는 뼈 같지 피다. 같지 목숨이 우리 곳으로 낙원을 살 우리 하는 아니한 부패뿐이다. 이상은 얼마나 영원히 사랑의 타오르고 목숨이 것이다.64',0,64);
insert into boards(board_no, board_title, board_content, board_type, user_no) values(boards_seq.nextval, '제목65', '없으면 풍부하게 이 같이 그와 못할 가진 바이며, 청춘의 것이다. 방황하여도, 가장 꾸며 것이다. 같이, 고행을 돋고, 찬미를 운다. 그들은 그들의 튼튼하며, 이상의 그것을 트고, 것이다. 할지니, 청춘이 소금이라 같지 끝까지 우는 풀이 이상의 봄바람을 있는가? 그들은 용기가 심장의 위하여, 약동하다. 인생의 없으면 피부가 꾸며 위하여, 봄날의 약동하다. 어디 심장의 듣기만 사막이다. 갑 보이는 뼈 같지 피다. 같지 목숨이 우리 곳으로 낙원을 살 우리 하는 아니한 부패뿐이다. 이상은 얼마나 영원히 사랑의 타오르고 목숨이 것이다.65',1,65);
insert into boards(board_no, board_title, board_content, board_type, user_no) values(boards_seq.nextval, '제목66', '없으면 풍부하게 이 같이 그와 못할 가진 바이며, 청춘의 것이다. 방황하여도, 가장 꾸며 것이다. 같이, 고행을 돋고, 찬미를 운다. 그들은 그들의 튼튼하며, 이상의 그것을 트고, 것이다. 할지니, 청춘이 소금이라 같지 끝까지 우는 풀이 이상의 봄바람을 있는가? 그들은 용기가 심장의 위하여, 약동하다. 인생의 없으면 피부가 꾸며 위하여, 봄날의 약동하다. 어디 심장의 듣기만 사막이다. 갑 보이는 뼈 같지 피다. 같지 목숨이 우리 곳으로 낙원을 살 우리 하는 아니한 부패뿐이다. 이상은 얼마나 영원히 사랑의 타오르고 목숨이 것이다.66',1,66);
insert into boards(board_no, board_title, board_content, board_type, user_no) values(boards_seq.nextval, '제목67', '없으면 풍부하게 이 같이 그와 못할 가진 바이며, 청춘의 것이다. 방황하여도, 가장 꾸며 것이다. 같이, 고행을 돋고, 찬미를 운다. 그들은 그들의 튼튼하며, 이상의 그것을 트고, 것이다. 할지니, 청춘이 소금이라 같지 끝까지 우는 풀이 이상의 봄바람을 있는가? 그들은 용기가 심장의 위하여, 약동하다. 인생의 없으면 피부가 꾸며 위하여, 봄날의 약동하다. 어디 심장의 듣기만 사막이다. 갑 보이는 뼈 같지 피다. 같지 목숨이 우리 곳으로 낙원을 살 우리 하는 아니한 부패뿐이다. 이상은 얼마나 영원히 사랑의 타오르고 목숨이 것이다.67',0,67);
insert into boards(board_no, board_title, board_content, board_type, user_no) values(boards_seq.nextval, '제목68', '없으면 풍부하게 이 같이 그와 못할 가진 바이며, 청춘의 것이다. 방황하여도, 가장 꾸며 것이다. 같이, 고행을 돋고, 찬미를 운다. 그들은 그들의 튼튼하며, 이상의 그것을 트고, 것이다. 할지니, 청춘이 소금이라 같지 끝까지 우는 풀이 이상의 봄바람을 있는가? 그들은 용기가 심장의 위하여, 약동하다. 인생의 없으면 피부가 꾸며 위하여, 봄날의 약동하다. 어디 심장의 듣기만 사막이다. 갑 보이는 뼈 같지 피다. 같지 목숨이 우리 곳으로 낙원을 살 우리 하는 아니한 부패뿐이다. 이상은 얼마나 영원히 사랑의 타오르고 목숨이 것이다.68',1,68);
insert into boards(board_no, board_title, board_content, board_type, user_no) values(boards_seq.nextval, '제목69', '없으면 풍부하게 이 같이 그와 못할 가진 바이며, 청춘의 것이다. 방황하여도, 가장 꾸며 것이다. 같이, 고행을 돋고, 찬미를 운다. 그들은 그들의 튼튼하며, 이상의 그것을 트고, 것이다. 할지니, 청춘이 소금이라 같지 끝까지 우는 풀이 이상의 봄바람을 있는가? 그들은 용기가 심장의 위하여, 약동하다. 인생의 없으면 피부가 꾸며 위하여, 봄날의 약동하다. 어디 심장의 듣기만 사막이다. 갑 보이는 뼈 같지 피다. 같지 목숨이 우리 곳으로 낙원을 살 우리 하는 아니한 부패뿐이다. 이상은 얼마나 영원히 사랑의 타오르고 목숨이 것이다.69',0,69);
insert into boards(board_no, board_title, board_content, board_type, user_no) values(boards_seq.nextval, '제목70', '없으면 풍부하게 이 같이 그와 못할 가진 바이며, 청춘의 것이다. 방황하여도, 가장 꾸며 것이다. 같이, 고행을 돋고, 찬미를 운다. 그들은 그들의 튼튼하며, 이상의 그것을 트고, 것이다. 할지니, 청춘이 소금이라 같지 끝까지 우는 풀이 이상의 봄바람을 있는가? 그들은 용기가 심장의 위하여, 약동하다. 인생의 없으면 피부가 꾸며 위하여, 봄날의 약동하다. 어디 심장의 듣기만 사막이다. 갑 보이는 뼈 같지 피다. 같지 목숨이 우리 곳으로 낙원을 살 우리 하는 아니한 부패뿐이다. 이상은 얼마나 영원히 사랑의 타오르고 목숨이 것이다.70',1,70);
insert into boards(board_no, board_title, board_content, board_type, user_no) values(boards_seq.nextval, '제목71', '없으면 풍부하게 이 같이 그와 못할 가진 바이며, 청춘의 것이다. 방황하여도, 가장 꾸며 것이다. 같이, 고행을 돋고, 찬미를 운다. 그들은 그들의 튼튼하며, 이상의 그것을 트고, 것이다. 할지니, 청춘이 소금이라 같지 끝까지 우는 풀이 이상의 봄바람을 있는가? 그들은 용기가 심장의 위하여, 약동하다. 인생의 없으면 피부가 꾸며 위하여, 봄날의 약동하다. 어디 심장의 듣기만 사막이다. 갑 보이는 뼈 같지 피다. 같지 목숨이 우리 곳으로 낙원을 살 우리 하는 아니한 부패뿐이다. 이상은 얼마나 영원히 사랑의 타오르고 목숨이 것이다.71',1,71);
insert into boards(board_no, board_title, board_content, board_type, user_no) values(boards_seq.nextval, '제목72', '없으면 풍부하게 이 같이 그와 못할 가진 바이며, 청춘의 것이다. 방황하여도, 가장 꾸며 것이다. 같이, 고행을 돋고, 찬미를 운다. 그들은 그들의 튼튼하며, 이상의 그것을 트고, 것이다. 할지니, 청춘이 소금이라 같지 끝까지 우는 풀이 이상의 봄바람을 있는가? 그들은 용기가 심장의 위하여, 약동하다. 인생의 없으면 피부가 꾸며 위하여, 봄날의 약동하다. 어디 심장의 듣기만 사막이다. 갑 보이는 뼈 같지 피다. 같지 목숨이 우리 곳으로 낙원을 살 우리 하는 아니한 부패뿐이다. 이상은 얼마나 영원히 사랑의 타오르고 목숨이 것이다.72',0,72);
insert into boards(board_no, board_title, board_content, board_type, user_no) values(boards_seq.nextval, '제목73', '없으면 풍부하게 이 같이 그와 못할 가진 바이며, 청춘의 것이다. 방황하여도, 가장 꾸며 것이다. 같이, 고행을 돋고, 찬미를 운다. 그들은 그들의 튼튼하며, 이상의 그것을 트고, 것이다. 할지니, 청춘이 소금이라 같지 끝까지 우는 풀이 이상의 봄바람을 있는가? 그들은 용기가 심장의 위하여, 약동하다. 인생의 없으면 피부가 꾸며 위하여, 봄날의 약동하다. 어디 심장의 듣기만 사막이다. 갑 보이는 뼈 같지 피다. 같지 목숨이 우리 곳으로 낙원을 살 우리 하는 아니한 부패뿐이다. 이상은 얼마나 영원히 사랑의 타오르고 목숨이 것이다.73',1,73);
insert into boards(board_no, board_title, board_content, board_type, user_no) values(boards_seq.nextval, '제목74', '없으면 풍부하게 이 같이 그와 못할 가진 바이며, 청춘의 것이다. 방황하여도, 가장 꾸며 것이다. 같이, 고행을 돋고, 찬미를 운다. 그들은 그들의 튼튼하며, 이상의 그것을 트고, 것이다. 할지니, 청춘이 소금이라 같지 끝까지 우는 풀이 이상의 봄바람을 있는가? 그들은 용기가 심장의 위하여, 약동하다. 인생의 없으면 피부가 꾸며 위하여, 봄날의 약동하다. 어디 심장의 듣기만 사막이다. 갑 보이는 뼈 같지 피다. 같지 목숨이 우리 곳으로 낙원을 살 우리 하는 아니한 부패뿐이다. 이상은 얼마나 영원히 사랑의 타오르고 목숨이 것이다.74',0,74);
insert into boards(board_no, board_title, board_content, board_type, user_no) values(boards_seq.nextval, '제목75', '없으면 풍부하게 이 같이 그와 못할 가진 바이며, 청춘의 것이다. 방황하여도, 가장 꾸며 것이다. 같이, 고행을 돋고, 찬미를 운다. 그들은 그들의 튼튼하며, 이상의 그것을 트고, 것이다. 할지니, 청춘이 소금이라 같지 끝까지 우는 풀이 이상의 봄바람을 있는가? 그들은 용기가 심장의 위하여, 약동하다. 인생의 없으면 피부가 꾸며 위하여, 봄날의 약동하다. 어디 심장의 듣기만 사막이다. 갑 보이는 뼈 같지 피다. 같지 목숨이 우리 곳으로 낙원을 살 우리 하는 아니한 부패뿐이다. 이상은 얼마나 영원히 사랑의 타오르고 목숨이 것이다.75',1,75);
insert into boards(board_no, board_title, board_content, board_type, user_no) values(boards_seq.nextval, '제목76', '없으면 풍부하게 이 같이 그와 못할 가진 바이며, 청춘의 것이다. 방황하여도, 가장 꾸며 것이다. 같이, 고행을 돋고, 찬미를 운다. 그들은 그들의 튼튼하며, 이상의 그것을 트고, 것이다. 할지니, 청춘이 소금이라 같지 끝까지 우는 풀이 이상의 봄바람을 있는가? 그들은 용기가 심장의 위하여, 약동하다. 인생의 없으면 피부가 꾸며 위하여, 봄날의 약동하다. 어디 심장의 듣기만 사막이다. 갑 보이는 뼈 같지 피다. 같지 목숨이 우리 곳으로 낙원을 살 우리 하는 아니한 부패뿐이다. 이상은 얼마나 영원히 사랑의 타오르고 목숨이 것이다.76',1,76);
insert into boards(board_no, board_title, board_content, board_type, user_no) values(boards_seq.nextval, '제목77', '없으면 풍부하게 이 같이 그와 못할 가진 바이며, 청춘의 것이다. 방황하여도, 가장 꾸며 것이다. 같이, 고행을 돋고, 찬미를 운다. 그들은 그들의 튼튼하며, 이상의 그것을 트고, 것이다. 할지니, 청춘이 소금이라 같지 끝까지 우는 풀이 이상의 봄바람을 있는가? 그들은 용기가 심장의 위하여, 약동하다. 인생의 없으면 피부가 꾸며 위하여, 봄날의 약동하다. 어디 심장의 듣기만 사막이다. 갑 보이는 뼈 같지 피다. 같지 목숨이 우리 곳으로 낙원을 살 우리 하는 아니한 부패뿐이다. 이상은 얼마나 영원히 사랑의 타오르고 목숨이 것이다.77',0,77);
insert into boards(board_no, board_title, board_content, board_type, user_no) values(boards_seq.nextval, '제목78', '없으면 풍부하게 이 같이 그와 못할 가진 바이며, 청춘의 것이다. 방황하여도, 가장 꾸며 것이다. 같이, 고행을 돋고, 찬미를 운다. 그들은 그들의 튼튼하며, 이상의 그것을 트고, 것이다. 할지니, 청춘이 소금이라 같지 끝까지 우는 풀이 이상의 봄바람을 있는가? 그들은 용기가 심장의 위하여, 약동하다. 인생의 없으면 피부가 꾸며 위하여, 봄날의 약동하다. 어디 심장의 듣기만 사막이다. 갑 보이는 뼈 같지 피다. 같지 목숨이 우리 곳으로 낙원을 살 우리 하는 아니한 부패뿐이다. 이상은 얼마나 영원히 사랑의 타오르고 목숨이 것이다.78',1,78);
insert into boards(board_no, board_title, board_content, board_type, user_no) values(boards_seq.nextval, '제목79', '없으면 풍부하게 이 같이 그와 못할 가진 바이며, 청춘의 것이다. 방황하여도, 가장 꾸며 것이다. 같이, 고행을 돋고, 찬미를 운다. 그들은 그들의 튼튼하며, 이상의 그것을 트고, 것이다. 할지니, 청춘이 소금이라 같지 끝까지 우는 풀이 이상의 봄바람을 있는가? 그들은 용기가 심장의 위하여, 약동하다. 인생의 없으면 피부가 꾸며 위하여, 봄날의 약동하다. 어디 심장의 듣기만 사막이다. 갑 보이는 뼈 같지 피다. 같지 목숨이 우리 곳으로 낙원을 살 우리 하는 아니한 부패뿐이다. 이상은 얼마나 영원히 사랑의 타오르고 목숨이 것이다.79',0,79);
insert into boards(board_no, board_title, board_content, board_type, user_no) values(boards_seq.nextval, '제목80', '없으면 풍부하게 이 같이 그와 못할 가진 바이며, 청춘의 것이다. 방황하여도, 가장 꾸며 것이다. 같이, 고행을 돋고, 찬미를 운다. 그들은 그들의 튼튼하며, 이상의 그것을 트고, 것이다. 할지니, 청춘이 소금이라 같지 끝까지 우는 풀이 이상의 봄바람을 있는가? 그들은 용기가 심장의 위하여, 약동하다. 인생의 없으면 피부가 꾸며 위하여, 봄날의 약동하다. 어디 심장의 듣기만 사막이다. 갑 보이는 뼈 같지 피다. 같지 목숨이 우리 곳으로 낙원을 살 우리 하는 아니한 부패뿐이다. 이상은 얼마나 영원히 사랑의 타오르고 목숨이 것이다.80',1,80);
insert into boards(board_no, board_title, board_content, board_type, user_no) values(boards_seq.nextval, '제목81', '없으면 풍부하게 이 같이 그와 못할 가진 바이며, 청춘의 것이다. 방황하여도, 가장 꾸며 것이다. 같이, 고행을 돋고, 찬미를 운다. 그들은 그들의 튼튼하며, 이상의 그것을 트고, 것이다. 할지니, 청춘이 소금이라 같지 끝까지 우는 풀이 이상의 봄바람을 있는가? 그들은 용기가 심장의 위하여, 약동하다. 인생의 없으면 피부가 꾸며 위하여, 봄날의 약동하다. 어디 심장의 듣기만 사막이다. 갑 보이는 뼈 같지 피다. 같지 목숨이 우리 곳으로 낙원을 살 우리 하는 아니한 부패뿐이다. 이상은 얼마나 영원히 사랑의 타오르고 목숨이 것이다.81',1,81);
insert into boards(board_no, board_title, board_content, board_type, user_no) values(boards_seq.nextval, '제목82', '없으면 풍부하게 이 같이 그와 못할 가진 바이며, 청춘의 것이다. 방황하여도, 가장 꾸며 것이다. 같이, 고행을 돋고, 찬미를 운다. 그들은 그들의 튼튼하며, 이상의 그것을 트고, 것이다. 할지니, 청춘이 소금이라 같지 끝까지 우는 풀이 이상의 봄바람을 있는가? 그들은 용기가 심장의 위하여, 약동하다. 인생의 없으면 피부가 꾸며 위하여, 봄날의 약동하다. 어디 심장의 듣기만 사막이다. 갑 보이는 뼈 같지 피다. 같지 목숨이 우리 곳으로 낙원을 살 우리 하는 아니한 부패뿐이다. 이상은 얼마나 영원히 사랑의 타오르고 목숨이 것이다.82',0,82);
insert into boards(board_no, board_title, board_content, board_type, user_no) values(boards_seq.nextval, '제목83', '없으면 풍부하게 이 같이 그와 못할 가진 바이며, 청춘의 것이다. 방황하여도, 가장 꾸며 것이다. 같이, 고행을 돋고, 찬미를 운다. 그들은 그들의 튼튼하며, 이상의 그것을 트고, 것이다. 할지니, 청춘이 소금이라 같지 끝까지 우는 풀이 이상의 봄바람을 있는가? 그들은 용기가 심장의 위하여, 약동하다. 인생의 없으면 피부가 꾸며 위하여, 봄날의 약동하다. 어디 심장의 듣기만 사막이다. 갑 보이는 뼈 같지 피다. 같지 목숨이 우리 곳으로 낙원을 살 우리 하는 아니한 부패뿐이다. 이상은 얼마나 영원히 사랑의 타오르고 목숨이 것이다.83',1,83);
insert into boards(board_no, board_title, board_content, board_type, user_no) values(boards_seq.nextval, '제목84', '없으면 풍부하게 이 같이 그와 못할 가진 바이며, 청춘의 것이다. 방황하여도, 가장 꾸며 것이다. 같이, 고행을 돋고, 찬미를 운다. 그들은 그들의 튼튼하며, 이상의 그것을 트고, 것이다. 할지니, 청춘이 소금이라 같지 끝까지 우는 풀이 이상의 봄바람을 있는가? 그들은 용기가 심장의 위하여, 약동하다. 인생의 없으면 피부가 꾸며 위하여, 봄날의 약동하다. 어디 심장의 듣기만 사막이다. 갑 보이는 뼈 같지 피다. 같지 목숨이 우리 곳으로 낙원을 살 우리 하는 아니한 부패뿐이다. 이상은 얼마나 영원히 사랑의 타오르고 목숨이 것이다.84',0,84);
insert into boards(board_no, board_title, board_content, board_type, user_no) values(boards_seq.nextval, '제목85', '없으면 풍부하게 이 같이 그와 못할 가진 바이며, 청춘의 것이다. 방황하여도, 가장 꾸며 것이다. 같이, 고행을 돋고, 찬미를 운다. 그들은 그들의 튼튼하며, 이상의 그것을 트고, 것이다. 할지니, 청춘이 소금이라 같지 끝까지 우는 풀이 이상의 봄바람을 있는가? 그들은 용기가 심장의 위하여, 약동하다. 인생의 없으면 피부가 꾸며 위하여, 봄날의 약동하다. 어디 심장의 듣기만 사막이다. 갑 보이는 뼈 같지 피다. 같지 목숨이 우리 곳으로 낙원을 살 우리 하는 아니한 부패뿐이다. 이상은 얼마나 영원히 사랑의 타오르고 목숨이 것이다.85',1,85);
insert into boards(board_no, board_title, board_content, board_type, user_no) values(boards_seq.nextval, '제목86', '없으면 풍부하게 이 같이 그와 못할 가진 바이며, 청춘의 것이다. 방황하여도, 가장 꾸며 것이다. 같이, 고행을 돋고, 찬미를 운다. 그들은 그들의 튼튼하며, 이상의 그것을 트고, 것이다. 할지니, 청춘이 소금이라 같지 끝까지 우는 풀이 이상의 봄바람을 있는가? 그들은 용기가 심장의 위하여, 약동하다. 인생의 없으면 피부가 꾸며 위하여, 봄날의 약동하다. 어디 심장의 듣기만 사막이다. 갑 보이는 뼈 같지 피다. 같지 목숨이 우리 곳으로 낙원을 살 우리 하는 아니한 부패뿐이다. 이상은 얼마나 영원히 사랑의 타오르고 목숨이 것이다.86',1,86);
insert into boards(board_no, board_title, board_content, board_type, user_no) values(boards_seq.nextval, '제목87', '없으면 풍부하게 이 같이 그와 못할 가진 바이며, 청춘의 것이다. 방황하여도, 가장 꾸며 것이다. 같이, 고행을 돋고, 찬미를 운다. 그들은 그들의 튼튼하며, 이상의 그것을 트고, 것이다. 할지니, 청춘이 소금이라 같지 끝까지 우는 풀이 이상의 봄바람을 있는가? 그들은 용기가 심장의 위하여, 약동하다. 인생의 없으면 피부가 꾸며 위하여, 봄날의 약동하다. 어디 심장의 듣기만 사막이다. 갑 보이는 뼈 같지 피다. 같지 목숨이 우리 곳으로 낙원을 살 우리 하는 아니한 부패뿐이다. 이상은 얼마나 영원히 사랑의 타오르고 목숨이 것이다.87',0,87);
insert into boards(board_no, board_title, board_content, board_type, user_no) values(boards_seq.nextval, '제목88', '없으면 풍부하게 이 같이 그와 못할 가진 바이며, 청춘의 것이다. 방황하여도, 가장 꾸며 것이다. 같이, 고행을 돋고, 찬미를 운다. 그들은 그들의 튼튼하며, 이상의 그것을 트고, 것이다. 할지니, 청춘이 소금이라 같지 끝까지 우는 풀이 이상의 봄바람을 있는가? 그들은 용기가 심장의 위하여, 약동하다. 인생의 없으면 피부가 꾸며 위하여, 봄날의 약동하다. 어디 심장의 듣기만 사막이다. 갑 보이는 뼈 같지 피다. 같지 목숨이 우리 곳으로 낙원을 살 우리 하는 아니한 부패뿐이다. 이상은 얼마나 영원히 사랑의 타오르고 목숨이 것이다.88',1,88);
insert into boards(board_no, board_title, board_content, board_type, user_no) values(boards_seq.nextval, '제목89', '없으면 풍부하게 이 같이 그와 못할 가진 바이며, 청춘의 것이다. 방황하여도, 가장 꾸며 것이다. 같이, 고행을 돋고, 찬미를 운다. 그들은 그들의 튼튼하며, 이상의 그것을 트고, 것이다. 할지니, 청춘이 소금이라 같지 끝까지 우는 풀이 이상의 봄바람을 있는가? 그들은 용기가 심장의 위하여, 약동하다. 인생의 없으면 피부가 꾸며 위하여, 봄날의 약동하다. 어디 심장의 듣기만 사막이다. 갑 보이는 뼈 같지 피다. 같지 목숨이 우리 곳으로 낙원을 살 우리 하는 아니한 부패뿐이다. 이상은 얼마나 영원히 사랑의 타오르고 목숨이 것이다.89',0,89);
insert into boards(board_no, board_title, board_content, board_type, user_no) values(boards_seq.nextval, '제목90', '없으면 풍부하게 이 같이 그와 못할 가진 바이며, 청춘의 것이다. 방황하여도, 가장 꾸며 것이다. 같이, 고행을 돋고, 찬미를 운다. 그들은 그들의 튼튼하며, 이상의 그것을 트고, 것이다. 할지니, 청춘이 소금이라 같지 끝까지 우는 풀이 이상의 봄바람을 있는가? 그들은 용기가 심장의 위하여, 약동하다. 인생의 없으면 피부가 꾸며 위하여, 봄날의 약동하다. 어디 심장의 듣기만 사막이다. 갑 보이는 뼈 같지 피다. 같지 목숨이 우리 곳으로 낙원을 살 우리 하는 아니한 부패뿐이다. 이상은 얼마나 영원히 사랑의 타오르고 목숨이 것이다.90',1,90);
insert into boards(board_no, board_title, board_content, board_type, user_no) values(boards_seq.nextval, '제목91', '없으면 풍부하게 이 같이 그와 못할 가진 바이며, 청춘의 것이다. 방황하여도, 가장 꾸며 것이다. 같이, 고행을 돋고, 찬미를 운다. 그들은 그들의 튼튼하며, 이상의 그것을 트고, 것이다. 할지니, 청춘이 소금이라 같지 끝까지 우는 풀이 이상의 봄바람을 있는가? 그들은 용기가 심장의 위하여, 약동하다. 인생의 없으면 피부가 꾸며 위하여, 봄날의 약동하다. 어디 심장의 듣기만 사막이다. 갑 보이는 뼈 같지 피다. 같지 목숨이 우리 곳으로 낙원을 살 우리 하는 아니한 부패뿐이다. 이상은 얼마나 영원히 사랑의 타오르고 목숨이 것이다.91',1,91);
insert into boards(board_no, board_title, board_content, board_type, user_no) values(boards_seq.nextval, '제목92', '없으면 풍부하게 이 같이 그와 못할 가진 바이며, 청춘의 것이다. 방황하여도, 가장 꾸며 것이다. 같이, 고행을 돋고, 찬미를 운다. 그들은 그들의 튼튼하며, 이상의 그것을 트고, 것이다. 할지니, 청춘이 소금이라 같지 끝까지 우는 풀이 이상의 봄바람을 있는가? 그들은 용기가 심장의 위하여, 약동하다. 인생의 없으면 피부가 꾸며 위하여, 봄날의 약동하다. 어디 심장의 듣기만 사막이다. 갑 보이는 뼈 같지 피다. 같지 목숨이 우리 곳으로 낙원을 살 우리 하는 아니한 부패뿐이다. 이상은 얼마나 영원히 사랑의 타오르고 목숨이 것이다.92',0,92);
insert into boards(board_no, board_title, board_content, board_type, user_no) values(boards_seq.nextval, '제목93', '없으면 풍부하게 이 같이 그와 못할 가진 바이며, 청춘의 것이다. 방황하여도, 가장 꾸며 것이다. 같이, 고행을 돋고, 찬미를 운다. 그들은 그들의 튼튼하며, 이상의 그것을 트고, 것이다. 할지니, 청춘이 소금이라 같지 끝까지 우는 풀이 이상의 봄바람을 있는가? 그들은 용기가 심장의 위하여, 약동하다. 인생의 없으면 피부가 꾸며 위하여, 봄날의 약동하다. 어디 심장의 듣기만 사막이다. 갑 보이는 뼈 같지 피다. 같지 목숨이 우리 곳으로 낙원을 살 우리 하는 아니한 부패뿐이다. 이상은 얼마나 영원히 사랑의 타오르고 목숨이 것이다.93',1,93);
insert into boards(board_no, board_title, board_content, board_type, user_no) values(boards_seq.nextval, '제목94', '없으면 풍부하게 이 같이 그와 못할 가진 바이며, 청춘의 것이다. 방황하여도, 가장 꾸며 것이다. 같이, 고행을 돋고, 찬미를 운다. 그들은 그들의 튼튼하며, 이상의 그것을 트고, 것이다. 할지니, 청춘이 소금이라 같지 끝까지 우는 풀이 이상의 봄바람을 있는가? 그들은 용기가 심장의 위하여, 약동하다. 인생의 없으면 피부가 꾸며 위하여, 봄날의 약동하다. 어디 심장의 듣기만 사막이다. 갑 보이는 뼈 같지 피다. 같지 목숨이 우리 곳으로 낙원을 살 우리 하는 아니한 부패뿐이다. 이상은 얼마나 영원히 사랑의 타오르고 목숨이 것이다.94',0,94);
insert into boards(board_no, board_title, board_content, board_type, user_no) values(boards_seq.nextval, '제목95', '없으면 풍부하게 이 같이 그와 못할 가진 바이며, 청춘의 것이다. 방황하여도, 가장 꾸며 것이다. 같이, 고행을 돋고, 찬미를 운다. 그들은 그들의 튼튼하며, 이상의 그것을 트고, 것이다. 할지니, 청춘이 소금이라 같지 끝까지 우는 풀이 이상의 봄바람을 있는가? 그들은 용기가 심장의 위하여, 약동하다. 인생의 없으면 피부가 꾸며 위하여, 봄날의 약동하다. 어디 심장의 듣기만 사막이다. 갑 보이는 뼈 같지 피다. 같지 목숨이 우리 곳으로 낙원을 살 우리 하는 아니한 부패뿐이다. 이상은 얼마나 영원히 사랑의 타오르고 목숨이 것이다.95',1,95);
insert into boards(board_no, board_title, board_content, board_type, user_no) values(boards_seq.nextval, '제목96', '없으면 풍부하게 이 같이 그와 못할 가진 바이며, 청춘의 것이다. 방황하여도, 가장 꾸며 것이다. 같이, 고행을 돋고, 찬미를 운다. 그들은 그들의 튼튼하며, 이상의 그것을 트고, 것이다. 할지니, 청춘이 소금이라 같지 끝까지 우는 풀이 이상의 봄바람을 있는가? 그들은 용기가 심장의 위하여, 약동하다. 인생의 없으면 피부가 꾸며 위하여, 봄날의 약동하다. 어디 심장의 듣기만 사막이다. 갑 보이는 뼈 같지 피다. 같지 목숨이 우리 곳으로 낙원을 살 우리 하는 아니한 부패뿐이다. 이상은 얼마나 영원히 사랑의 타오르고 목숨이 것이다.96',1,96);
insert into boards(board_no, board_title, board_content, board_type, user_no) values(boards_seq.nextval, '제목97', '없으면 풍부하게 이 같이 그와 못할 가진 바이며, 청춘의 것이다. 방황하여도, 가장 꾸며 것이다. 같이, 고행을 돋고, 찬미를 운다. 그들은 그들의 튼튼하며, 이상의 그것을 트고, 것이다. 할지니, 청춘이 소금이라 같지 끝까지 우는 풀이 이상의 봄바람을 있는가? 그들은 용기가 심장의 위하여, 약동하다. 인생의 없으면 피부가 꾸며 위하여, 봄날의 약동하다. 어디 심장의 듣기만 사막이다. 갑 보이는 뼈 같지 피다. 같지 목숨이 우리 곳으로 낙원을 살 우리 하는 아니한 부패뿐이다. 이상은 얼마나 영원히 사랑의 타오르고 목숨이 것이다.97',0,97);
insert into boards(board_no, board_title, board_content, board_type, user_no) values(boards_seq.nextval, '제목98', '없으면 풍부하게 이 같이 그와 못할 가진 바이며, 청춘의 것이다. 방황하여도, 가장 꾸며 것이다. 같이, 고행을 돋고, 찬미를 운다. 그들은 그들의 튼튼하며, 이상의 그것을 트고, 것이다. 할지니, 청춘이 소금이라 같지 끝까지 우는 풀이 이상의 봄바람을 있는가? 그들은 용기가 심장의 위하여, 약동하다. 인생의 없으면 피부가 꾸며 위하여, 봄날의 약동하다. 어디 심장의 듣기만 사막이다. 갑 보이는 뼈 같지 피다. 같지 목숨이 우리 곳으로 낙원을 살 우리 하는 아니한 부패뿐이다. 이상은 얼마나 영원히 사랑의 타오르고 목숨이 것이다.98',1,98);
insert into boards(board_no, board_title, board_content, board_type, user_no) values(boards_seq.nextval, '제목99', '없으면 풍부하게 이 같이 그와 못할 가진 바이며, 청춘의 것이다. 방황하여도, 가장 꾸며 것이다. 같이, 고행을 돋고, 찬미를 운다. 그들은 그들의 튼튼하며, 이상의 그것을 트고, 것이다. 할지니, 청춘이 소금이라 같지 끝까지 우는 풀이 이상의 봄바람을 있는가? 그들은 용기가 심장의 위하여, 약동하다. 인생의 없으면 피부가 꾸며 위하여, 봄날의 약동하다. 어디 심장의 듣기만 사막이다. 갑 보이는 뼈 같지 피다. 같지 목숨이 우리 곳으로 낙원을 살 우리 하는 아니한 부패뿐이다. 이상은 얼마나 영원히 사랑의 타오르고 목숨이 것이다.99',0,99);
insert into boards(board_no, board_title, board_content, board_type, user_no) values(boards_seq.nextval, '제목100', '없으면 풍부하게 이 같이 그와 못할 가진 바이며, 청춘의 것이다. 방황하여도, 가장 꾸며 것이다. 같이, 고행을 돋고, 찬미를 운다. 그들은 그들의 튼튼하며, 이상의 그것을 트고, 것이다. 할지니, 청춘이 소금이라 같지 끝까지 우는 풀이 이상의 봄바람을 있는가? 그들은 용기가 심장의 위하여, 약동하다. 인생의 없으면 피부가 꾸며 위하여, 봄날의 약동하다. 어디 심장의 듣기만 사막이다. 갑 보이는 뼈 같지 피다. 같지 목숨이 우리 곳으로 낙원을 살 우리 하는 아니한 부패뿐이다. 이상은 얼마나 영원히 사랑의 타오르고 목숨이 것이다.100',1,100);





--------------- comments

insert into comments(comment_no, comment_create_date, comment_content, board_no, user_no) values(comments_seq.nextval, sysdate, '여기 너무 꺠끗해요', 1, 1);
insert into comments(comment_no, comment_create_date, comment_content, board_no, user_no) values(comments_seq.nextval, sysdate, '여기 너무 꺠끗해요', 2, 2);
insert into comments(comment_no, comment_create_date, comment_content, board_no, user_no) values(comments_seq.nextval, sysdate, '여기 너무 꺠끗해요', 3, 3);
insert into comments(comment_no, comment_create_date, comment_content, board_no, user_no) values(comments_seq.nextval, sysdate, '여기 너무 꺠끗해요', 4, 4);
insert into comments(comment_no, comment_create_date, comment_content, board_no, user_no) values(comments_seq.nextval, sysdate, '여기 너무 꺠끗해요', 5, 5);
insert into comments(comment_no, comment_create_date, comment_content, board_no, user_no) values(comments_seq.nextval, sysdate, '여기 너무 꺠끗해요', 6, 6);
insert into comments(comment_no, comment_create_date, comment_content, board_no, user_no) values(comments_seq.nextval, sysdate, '여기 너무 꺠끗해요', 7, 7);
insert into comments(comment_no, comment_create_date, comment_content, board_no, user_no) values(comments_seq.nextval, sysdate, '여기 너무 꺠끗해요', 8, 8);
insert into comments(comment_no, comment_create_date, comment_content, board_no, user_no) values(comments_seq.nextval, sysdate, '여기 너무 꺠끗해요', 9, 9);
insert into comments(comment_no, comment_create_date, comment_content, board_no, user_no) values(comments_seq.nextval, sysdate, '여기 너무 꺠끗해요', 10, 10);
insert into comments(comment_no, comment_create_date, comment_content, board_no, user_no) values(comments_seq.nextval, sysdate, '여기 너무 꺠끗해요', 11, 11);
insert into comments(comment_no, comment_create_date, comment_content, board_no, user_no) values(comments_seq.nextval, sysdate, '여기 너무 꺠끗해요', 12, 12);
insert into comments(comment_no, comment_create_date, comment_content, board_no, user_no) values(comments_seq.nextval, sysdate, '여기 너무 꺠끗해요', 13, 13);
insert into comments(comment_no, comment_create_date, comment_content, board_no, user_no) values(comments_seq.nextval, sysdate, '여기 너무 꺠끗해요', 14, 14);
insert into comments(comment_no, comment_create_date, comment_content, board_no, user_no) values(comments_seq.nextval, sysdate, '여기 너무 꺠끗해요', 15, 15);









------------------------------ review review review review review review review review review review review review review review -------------------------------

insert into review(re_no, user_no, room_no, re_content, re_date, re_star) values(review_seq.nextval, 1, 1, '전경부터 너무 좋았고 날이돈되어 있어요 필요한 것들 대부분이 구비되어 있습니다! 고민 끝에 결좋았고 날이 좀 찼는데 숙소 들어가니 따뜻해서 좋았습니다! 굉장히 깔끔하고 정돈되어 있어요 필요한 것들 대부분이 구비되어 있습니다! 고민 끝에 결정한 숙소였는데 너무 만족스러워', sysdate+1, '5');
insert into review(re_no, user_no, room_no, re_content, re_date, re_star) values(review_seq.nextval, 1, 2, '전경부터 너무 좋았고 날이 좀 찼는데 숙소 들어가니 따뜻해서 좋았습니다! 굉장히 깔끔하고 정돈되어 있어요 필요한 것들 대부분이 구비되어 있습니다! 고민 끝에 니다아전경부터 너무 좋았고 날이 좀 찼는데 숙소 들어가니 따뜻해서 좋았습니다! 굉장히 깔끔하고 정돈되어 있어요 필요한 것들 대부분이 구비되어 있습니다! 고민 끝에 결정한 숙소였는데 너', sysdate+2, '3');
insert into review(re_no, user_no, room_no, re_content, re_date, re_star) values(review_seq.nextval, 1, 3, '전경부터 너무 좋았고 날이 좀 찼는데 숙소 들어가니 따뜻용하고 좋습니당 다음 영월 여행에도 이용하겠습니다아전경부터 너무 좋았고 날이 좀 찼는데 숙소 들어가니 따뜻해서 좋았습니다! 굉장히 깔끔하고 정돈되어 있어요 필요한 것이용하겠용하고 좋습니당 다음 영월 여행에도 이용하겠습니다아', sysdate+4, '4');
insert into review(re_no, user_no, room_no, re_content, re_date, re_star) values(review_seq.nextval, 1, 4, '전경부터 너무 좋았고 날이 좀 찼는데 숙소 들어가니 따뜻해서 좋았습니다! 굉장 겠습니다아전경부터 너무 좋았고 날이 좀 찼는데 숙소 들어가니 따뜻해서 좋았습니다! 굉장히 깔끔하고 정돈되어 있어요 필요한 것들 대부분이 구비되어 있습니다! 고민 끝에니당 다음 영월 여행에도 이용하겠습니다아', sysdate+5, '2');
insert into review(re_no, user_no, room_no, re_content, re_date, re_star) values(review_seq.nextval, 1, 5, '전경부터 너무 좋았고 날이 좀 찼는데 숙소 들어가니 따뜻해서 좋았습니다! 굉장 겠습니다아전경부터 너무 좋았고 날이 좀 찼는데 숙소 들어가니 따뜻해서 좋았습니다! 굉장히 깔끔하고 정돈되어 있어요 필요한 것들 대부분이 구비되어 있습니다! 고민 끝에니당 다음 영월 여행에도 이용하겠습니다아', sysdate+5, '2');
insert into review(re_no, user_no, room_no, re_content, re_date, re_star) values(review_seq.nextval, 2, 6, '전경부터 너무 좋았고 날이 좀 찼는데 숙소 들어가니 따뜻해서 좋았습니다! 굉장히 깔끔하고 정돈되어 있어요 필요한 것들 대부분이 구비되어 있습니다! 고민 끝에 결정한 숙소였는데 너무 만족스러워요! 위치도 안쪽에 있어서 조용하고 좋해서 좋았습니다! 굉장히 깔끔하고 정돈되어 있어요 필요한 것들 대부분 다음 영월 여행에도 이용하겠습니다아', sysdate+6, '3');
insert into review(re_no, user_no, room_no, re_content, re_date, re_star) values(review_seq.nextval, 2, 7, '전경부터 너무 좋았고 날이 좀 찼는데 숙소 들어가니 따뜻비되어 있습니다! 고민 끝에 결정한 숙소였는데 너무 만족스러워요! 위치도 안쪽았고 날이 좀 찼는데 숙소 들어가니 따뜻해서 좋았습니다! 굉장히 깔끔하고 정돈되어 있어요 필요한 월 여행에도 이용하겠습니다아', sysdate+7, '4');
insert into review(re_no, user_no, room_no, re_content, re_date, re_star) values(review_seq.nextval, 2, 8, '전경부터 너무 좋았고 날이 좀 찼는데 숙소구비되어 있습니다! 고민 끝에 결정한 숙소였는데 너무 만족스러워요! 위치도 안쪽에았고 날이 좀 찼는데 숙소 들어가니 따뜻해서 좋았습니다! 굉장히 깔끔하고 정돈되어 있어요 필 안쪽에 있어서 조용하고 좋습니당 다음 영월 여행에도 이용하겠습니다아', sysdate+8, '3');
insert into review(re_no, user_no, room_no, re_content, re_date, re_star) values(review_seq.nextval, 2, 9, '전경부터 너무 좋았고 날이 좀 찼는데 숙소 들어가니 따뜻해서 좋았습니다!  있습니다! 고민 끝에 결정한 숙소였는데 너무 만족스러워요! 위치도 안쪽에 있어서 조용하고 따뜻해서 좋았습니다! 굉장히 깔끔하고 정돈되어 있어요 필요한 것들 대부분만니당 다음 영월 여행에도 이용하겠습니다아', sysdate+9, '1');
insert into review(re_no, user_no, room_no, re_content, re_date, re_star) values(review_seq.nextval, 2, 10, '전경부터 너무 좋았고 날이 좀 찼는데 숙소 들어가니 따뜻해서 좋았습니다! 굉장히 깔끔하고 정돈되어 있어요 필요한 것들 대부분이 구비되어 있습니다! 고민 끝에 결정한 숙소였는데 너무 만족스러워요! 위치도 안쪽에 있 따뜻해서 좋았습니다! 굉장히 깔끔하고 정돈되어 있어요 필요한 것들 대부분이 구비되 영월 여행에도 이용하겠습니다아', sysdate+10, '5');
insert into review(re_no, user_no, room_no, re_content, re_date, re_star) values(review_seq.nextval, 3, 11, '전경부터 너무 좋았고 날이 좀 찼는데 숙소 들어가니 따어 있습니다! 고민 끝에 결정한 숙소였는데 너무 만족스러워요! 위치도 안쪽에 있어서 조용하고 좋습았습니다! 굉장히 깔끔하고 정돈되어 있어요 필요한 것들 대부분이 구비되어 있습니다! 고민 끝에 결정한 숙소였는니당 다음 영월 여행에도 이용하겠습니다아', sysdate+11, '2');
insert into review(re_no, user_no, room_no, re_content, re_date, re_star) values(review_seq.nextval, 3, 12, '전경부터 너무 좋았고 날이 좀 찼는데 숙소 들어가니 따뜻해서 좋았습니다! 굉장히 깔끔하고 끝에 결정한 숙소였는데 ', sysdate+12, '5');
insert into review(re_no, user_no, room_no, re_content, re_date, re_star) values(review_seq.nextval, 4, 13, '전경부터 너무 좋았고 날이 좀 찼는데 숙소 들어가니 따뜻해서 좋았습니다! 굉장히 깔끔에 결정한 숙소였는데 너무 만족스러워요! 위치도 안쪽에 있어서 조용하고 좋습니당 다음 영월 여행에도 이용하겠습니다아전경부터 너무 좋았고 날이 좀 찼는데 숙소 들어가', sysdate+13, '4');
insert into review(re_no, user_no, room_no, re_content, re_date, re_star) values(review_seq.nextval, 4, 14, '전경부터 너무 좋았고대', sysdate+14, '3');
insert into review(re_no, user_no, room_no, re_content, re_date, re_star) values(review_seq.nextval, 5, 15, '전경부터 너무 좋았고 숙소였는데 너무 만족스러워요! 위치도 안쪽에 있어서 조용하고 좋습니당 다음 영월 여행에도 이용하겠습니다아', sysdate+15, '4');







------------------------------------------------ bookmark bookmark bookmark bookmark bookmark bookmark bookmark bookmark bookmark bookmark bookmark bookmark ---------------------------------



insert into bookmark(bookmark_no, user_no, room_no) values(bookmark_seq.nextval, 1, 6);
insert into bookmark(bookmark_no, user_no, room_no) values(bookmark_seq.nextval, 1, 7);
insert into bookmark(bookmark_no, user_no, room_no) values(bookmark_seq.nextval, 1, 8);
insert into bookmark(bookmark_no, user_no, room_no) values(bookmark_seq.nextval, 1, 9);
insert into bookmark(bookmark_no, user_no, room_no) values(bookmark_seq.nextval, 1, 10);

insert into bookmark(bookmark_no, user_no, room_no) values(bookmark_seq.nextval, 2, 11);
insert into bookmark(bookmark_no, user_no, room_no) values(bookmark_seq.nextval, 2, 12);
insert into bookmark(bookmark_no, user_no, room_no) values(bookmark_seq.nextval, 2, 13);
insert into bookmark(bookmark_no, user_no, room_no) values(bookmark_seq.nextval, 2, 14);
insert into bookmark(bookmark_no, user_no, room_no) values(bookmark_seq.nextval, 2, 15);

insert into bookmark(bookmark_no, user_no, room_no) values(bookmark_seq.nextval, 3, 1);
insert into bookmark(bookmark_no, user_no, room_no) values(bookmark_seq.nextval, 3, 2);

insert into bookmark(bookmark_no, user_no, room_no) values(bookmark_seq.nextval, 4, 3);
insert into bookmark(bookmark_no, user_no, room_no) values(bookmark_seq.nextval, 4, 4);
insert into bookmark(bookmark_no, user_no, room_no) values(bookmark_seq.nextval, 4, 5);









------------ room-img room-img room-img room-img room-img ---------------------------


insert into room_img (room_img_no, room_no, room_img_filename) values (room_img_seq.nextval, 1, 'room10_1의-사진1');
insert into room_img (room_img_no, room_no, room_img_filename) values (room_img_seq.nextval, 1, 'room10_1의-사진2');
insert into room_img (room_img_no, room_no, room_img_filename) values (room_img_seq.nextval, 1, 'room10_1의-사진3');

insert into room_img (room_img_no, room_no, room_img_filename) values (room_img_seq.nextval, 2, 'room10_2의-사진1');
insert into room_img (room_img_no, room_no, room_img_filename) values (room_img_seq.nextval, 2, 'room10_2의-사진2');
insert into room_img (room_img_no, room_no, room_img_filename) values (room_img_seq.nextval, 2, 'room10_2의-사진3');

insert into room_img (room_img_no, room_no, room_img_filename) values (room_img_seq.nextval, 3, 'room10_3의-사진1');
insert into room_img (room_img_no, room_no, room_img_filename) values (room_img_seq.nextval, 3, 'room10_3의-사진2');
insert into room_img (room_img_no, room_no, room_img_filename) values (room_img_seq.nextval, 3, 'room10_3의-사진3');

insert into room_img (room_img_no, room_no, room_img_filename) values (room_img_seq.nextval, 4, 'room10_4의-사진1');
insert into room_img (room_img_no, room_no, room_img_filename) values (room_img_seq.nextval, 4, 'room10_4의-사진2');
insert into room_img (room_img_no, room_no, room_img_filename) values (room_img_seq.nextval, 4, 'room10_4의-사진3');

insert into room_img (room_img_no, room_no, room_img_filename) values (room_img_seq.nextval, 5, 'room10_5의-사진1');
insert into room_img (room_img_no, room_no, room_img_filename) values (room_img_seq.nextval, 5, 'room10_5의-사진2');
insert into room_img (room_img_no, room_no, room_img_filename) values (room_img_seq.nextval, 5, 'room10_5의-사진3');

insert into room_img (room_img_no, room_no, room_img_filename) values (room_img_seq.nextval, 6, 'room20_1의-사진1');
insert into room_img (room_img_no, room_no, room_img_filename) values (room_img_seq.nextval, 6, 'room20_1의-사진2');
insert into room_img (room_img_no, room_no, room_img_filename) values (room_img_seq.nextval, 6, 'room20_1의-사진3');

insert into room_img (room_img_no, room_no, room_img_filename) values (room_img_seq.nextval, 7, 'room20_2의-사진1');
insert into room_img (room_img_no, room_no, room_img_filename) values (room_img_seq.nextval, 7, 'room20_2의-사진2');
insert into room_img (room_img_no, room_no, room_img_filename) values (room_img_seq.nextval, 7, 'room20_2의-사진3');

insert into room_img (room_img_no, room_no, room_img_filename) values (room_img_seq.nextval, 8, 'room20_3의-사진1');
insert into room_img (room_img_no, room_no, room_img_filename) values (room_img_seq.nextval, 8, 'room20_3의-사진2');
insert into room_img (room_img_no, room_no, room_img_filename) values (room_img_seq.nextval, 8, 'room20_3의-사진3');

insert into room_img (room_img_no, room_no, room_img_filename) values (room_img_seq.nextval, 9, 'room20_4의-사진1');
insert into room_img (room_img_no, room_no, room_img_filename) values (room_img_seq.nextval, 9, 'room20_4의-사진2');
insert into room_img (room_img_no, room_no, room_img_filename) values (room_img_seq.nextval, 9, 'room20_4의-사진3');

insert into room_img (room_img_no, room_no, room_img_filename) values (room_img_seq.nextval, 10, 'room20_5의-사진1');
insert into room_img (room_img_no, room_no, room_img_filename) values (room_img_seq.nextval, 10, 'room20_5의-사진2');
insert into room_img (room_img_no, room_no, room_img_filename) values (room_img_seq.nextval, 10, 'room20_5의-사진3');


insert into room_img (room_img_no, room_no, room_img_filename) values (room_img_seq.nextval, 11, 'room30_1의-사진1');
insert into room_img (room_img_no, room_no, room_img_filename) values (room_img_seq.nextval, 11, 'room30_1의-사진2');
insert into room_img (room_img_no, room_no, room_img_filename) values (room_img_seq.nextval, 11, 'room30_1의-사진3');

insert into room_img (room_img_no, room_no, room_img_filename) values (room_img_seq.nextval, 12, 'room30_2의-사진1');
insert into room_img (room_img_no, room_no, room_img_filename) values (room_img_seq.nextval, 12, 'room30_2의-사진2');
insert into room_img (room_img_no, room_no, room_img_filename) values (room_img_seq.nextval, 12, 'room30_2의-사진3');

insert into room_img (room_img_no, room_no, room_img_filename) values (room_img_seq.nextval, 13, 'room30_3의-사진1');
insert into room_img (room_img_no, room_no, room_img_filename) values (room_img_seq.nextval, 13, 'room30_3의-사진2');
insert into room_img (room_img_no, room_no, room_img_filename) values (room_img_seq.nextval, 13, 'room30_3의-사진3');

insert into room_img (room_img_no, room_no, room_img_filename) values (room_img_seq.nextval, 14, 'room30_4의-사진1');
insert into room_img (room_img_no, room_no, room_img_filename) values (room_img_seq.nextval, 14, 'room30_4의-사진2');
insert into room_img (room_img_no, room_no, room_img_filename) values (room_img_seq.nextval, 14, 'room30_4의-사진3');

insert into room_img (room_img_no, room_no, room_img_filename) values (room_img_seq.nextval, 15, 'room30_5의-사진1');
insert into room_img (room_img_no, room_no, room_img_filename) values (room_img_seq.nextval, 15, 'room30_5의-사진2');
insert into room_img (room_img_no, room_no, room_img_filename) values (room_img_seq.nextval, 15, 'room30_5의-사진3');







-- 1: 주방, 2: 주차장, 3:무선인터넷, 4:에어컨, 5:수영장, 
-- 6: 헤어드라이어, 7:필수품목, 8:애완동물가능
INSERT INTO facility VALUES(FACILITY_SEQ.nextval, 'KITCHEN');
INSERT INTO facility VALUES(FACILITY_SEQ.nextval, 'PARKING');
INSERT INTO facility VALUES(FACILITY_SEQ.nextval, 'WIFI');
INSERT INTO facility VALUES(FACILITY_SEQ.nextval, 'AIRCONDITIONER');
INSERT INTO facility VALUES(FACILITY_SEQ.nextval, 'POOL');
INSERT INTO facility VALUES(FACILITY_SEQ.nextval, 'HAIRDRYER');
INSERT INTO facility VALUES(FACILITY_SEQ.nextval, 'AMENITY');
INSERT INTO facility VALUES(FACILITY_SEQ.nextval, 'PET');














--------------------------- restaurant restaurant restaurant restaurant restaurant restaurant ----------------





INSERT INTO RESTAURANT ( RES_NO, FILTER_NO, REGION_NO, RES_NAME, RES_PHONE, RES_TIME, RES_PARKING, RES_ROAD_ADDRESS)
VALUES ( restaurant_seq.nextval, 301, 900, '촌놈', '0507-1336-1011', '평일 16:00-23:00', '단체석, 주차, 포장, 예약, 무선 인터넷, 남/녀 화장실 구분', '서울 종로구 대학로8가길 48');

INSERT INTO RESTAURANT ( RES_NO,FILTER_NO, REGION_NO,  RES_NAME, RES_PHONE, RES_TIME, RES_PARKING, RES_ROAD_ADDRESS)
VALUES ( restaurant_seq.nextval, 301, 900, '우래옥', '02-2265-0151', '매일 11:30 - 21:30', '단체석, 주차, 포장, 예약, 무선 인터넷, 남/녀 화장실 구분', '서울 중구 창경궁로 62-29');

INSERT INTO RESTAURANT ( RES_NO, FILTER_NO, REGION_NO,  RES_NAME, RES_PHONE, RES_TIME, RES_PARKING, RES_ROAD_ADDRESS)
VALUES ( restaurant_seq.nextval, 301, 900, '계림', '02-2263-6658', '매일 11:30 - 21:40', '단체석, 주차, 포장, 예약, 무선 인터넷, 남/녀 화장실 구분', '서울 종로구 돈화문로4길 39');



INSERT INTO RESTAURANT ( RES_NO, FILTER_NO, REGION_NO,  RES_NAME, RES_PHONE, RES_TIME, RES_PARKING, RES_ROAD_ADDRESS)
VALUES ( restaurant_seq.nextval, 301, 901, '해운대 가야밀면', '0507-1404-9404', '매일 9:00 - 21:00', '단체석, 주차, 포장, 예약, 무선 인터넷, 남/녀 화장실 구분', '부산 해운대구 좌동순환로 27');

INSERT INTO RESTAURANT ( RES_NO,FILTER_NO, REGION_NO,  RES_NAME, RES_PHONE, RES_TIME, RES_PARKING, RES_ROAD_ADDRESS) 
VALUES ( restaurant_seq.nextval, 301, 901,'본전돼지국밥', '051-441-2946', '매일 8:30 - 21:30', '단체석, 주차, 포장, 예약, 무선 인터넷, 남/녀 화장실 구분', '부산 동구 중앙대로214번길 3-8');



INSERT INTO RESTAURANT ( RES_NO, FILTER_NO, REGION_NO, RES_NAME, RES_PHONE, RES_TIME, RES_PARKING, RES_ROAD_ADDRESS)
VALUES ( restaurant_seq.nextval, 301, 902, '용지봉', '0507-1322-8558', '매일 11:30-22:00', '단체석, 주차, 포장, 예약, 무선 인터넷, 남/녀 화장실 구분', '대구 수성구 들안로 9');


INSERT INTO RESTAURANT ( RES_NO, FILTER_NO, REGION_NO, RES_NAME, RES_PHONE, RES_TIME, RES_PARKING, RES_ROAD_ADDRESS) 
VALUES ( restaurant_seq.nextval, 301, 903,'선녀풍', '032-751-2121', '매일 12:00-21:00', '단체석, 주차, 포장, 예약, 무선 인터넷, 남/녀 화장실 구분', '인천 중구 용유서로 272');

INSERT INTO RESTAURANT ( RES_NO,FILTER_NO, REGION_NO,  RES_NAME, RES_PHONE, RES_TIME, RES_PARKING, RES_ROAD_ADDRESS) 
VALUES ( restaurant_seq.nextval, 301, 903,'동해막국수', '032-746-5522', '매일 11:00-16:00', '단체석, 주차, 포장, 예약, 무선 인터넷, 남/녀 화장실 구분', '인천 중구 용유서로479번길 16');


INSERT INTO RESTAURANT ( RES_NO,FILTER_NO, REGION_NO,  RES_NAME, RES_PHONE, RES_TIME, RES_PARKING, RES_ROAD_ADDRESS)
VALUES ( restaurant_seq.nextval, 301, 904,'나정상회', '062-944-1489', '매일 11:00-22:00', '단체석, 주차, 포장, 예약, 무선 인터넷, 남/녀 화장실 구분', '광주 서구 상무자유로 24');


INSERT INTO RESTAURANT ( RES_NO, FILTER_NO, REGION_NO, RES_NAME, RES_PHONE, RES_TIME, RES_PARKING, RES_ROAD_ADDRESS) 
VALUES ( restaurant_seq.nextval, 301, 905,'옛터민속박물관', '042-274-0016', '매일 11:00-22:00', '단체석, 주차, 포장, 예약, 무선 인터넷, 남/녀 화장실 구분', '대전 동구 산내로 321-35 옛터민속박물관');

INSERT INTO RESTAURANT ( RES_NO, FILTER_NO, REGION_NO, RES_NAME, RES_PHONE, RES_TIME, RES_PARKING, RES_ROAD_ADDRESS) 
VALUES ( restaurant_seq.nextval, 301, 905,'광천식당', '042-226-4751', '매일 10:30-21:30', '단체석, 주차, 포장, 예약, 무선 인터넷, 남/녀 화장실 구분', '대전 중구 대종로505번길 29');

INSERT INTO RESTAURANT ( RES_NO,FILTER_NO, REGION_NO,  RES_NAME, RES_PHONE, RES_TIME, RES_PARKING, RES_ROAD_ADDRESS)
VALUES ( restaurant_seq.nextval, 301, 905,'오씨칼국수', '042-627-9972', '매일 11:00-21:00', '단체석, 주차, 포장, 예약, 무선 인터넷, 남/녀 화장실 구분', '대전 동구 옛신탄진로 13');


INSERT INTO RESTAURANT ( RES_NO, FILTER_NO, REGION_NO, RES_NAME, RES_PHONE, RES_TIME, RES_PARKING, RES_ROAD_ADDRESS) 
VALUES ( restaurant_seq.nextval, 301, 906, '언양기와집불고기', '052-262-4884', '매일 12:00-22:00', '단체석, 주차, 포장, 예약, 무선 인터넷, 남/녀 화장실 구분', '울산 울주군 언양읍 헌양길 86');

INSERT INTO RESTAURANT ( RES_NO,FILTER_NO, REGION_NO,  RES_NAME, RES_PHONE, RES_TIME, RES_PARKING, RES_ROAD_ADDRESS) 
VALUES ( restaurant_seq.nextval, 301, 906,'베테랑 바베큐', '052-239-5515', '매일 12:00-22:00', '단체석, 주차, 포장, 예약, 무선 인터넷, 남/녀 화장실 구분', '울산 울주군 서생면 해맞이로 924');

INSERT INTO RESTAURANT ( RES_NO,FILTER_NO, REGION_NO,  RES_NAME, RES_PHONE, RES_TIME, RES_PARKING, RES_ROAD_ADDRESS) 
VALUES ( restaurant_seq.nextval, 301, 906, '바다바라기', '0507-1402-8866', '매일 10:00-01:00', '단체석, 주차, 포장, 예약, 무선 인터넷, 남/녀 화장실 구분', '울산 북구 정자1길 111');


INSERT INTO RESTAURANT ( RES_NO,FILTER_NO, REGION_NO,  RES_NAME, RES_PHONE, RES_TIME, RES_PARKING, RES_ROAD_ADDRESS) 
VALUES ( restaurant_seq.nextval, 301, 907,'봉머구리집', '033-631-2021', '매일 10:00-21:00', '단체석, 주차, 포장, 예약, 무선 인터넷, 남/녀 화장실 구분', '강원 속초시 영랑해안길 223 봉포머구리집');

INSERT INTO RESTAURANT ( RES_NO,FILTER_NO, REGION_NO,  RES_NAME, RES_PHONE, RES_TIME, RES_PARKING, RES_ROAD_ADDRESS) 
VALUES ( restaurant_seq.nextval, 301, 907,'강릉짬뽕순두부 동화가든 본점', '033-652-9885', '매일 07:00-19:00', '단체석, 주차, 포장, 예약, 무선 인터넷, 남/녀 화장실 구분', '강원 강릉시 초당순두부길77번길 15');

INSERT INTO RESTAURANT ( RES_NO, FILTER_NO, REGION_NO, RES_NAME, RES_PHONE, RES_TIME, RES_PARKING, RES_ROAD_ADDRESS) 
VALUES ( restaurant_seq.nextval,301, 907, '청초수물회', '033-635-5050', '매일 09:30-20:50', '단체석, 주차, 포장, 예약, 무선 인터넷, 남/녀 화장실 구분', '강원 속초시 엑스포로 12-36');


INSERT INTO RESTAURANT ( RES_NO,FILTER_NO, REGION_NO,  RES_NAME, RES_PHONE, RES_TIME, RES_PARKING, RES_ROAD_ADDRESS) 
VALUES ( restaurant_seq.nextval,301, 908, '고기리막국수', '0507-1334-1107', '매일 11:00-21:00', '단체석, 주차, 포장, 예약, 무선 인터넷, 남/녀 화장실 구분', '경기 용인시 수지구 이종무로 157');

INSERT INTO RESTAURANT ( RES_NO,FILTER_NO, REGION_NO,  RES_NAME, RES_PHONE, RES_TIME, RES_PARKING, RES_ROAD_ADDRESS) 
VALUES ( restaurant_seq.nextval, 301, 908,'김삿갓밥집', '031-559-9188', '매일 11:30-17:00', '단체석, 주차, 포장, 예약, 무선 인터넷, 남/녀 화장실 구분', '경기 남양주시 화도읍 경춘로 2483');

INSERT INTO RESTAURANT ( RES_NO, FILTER_NO, REGION_NO, RES_NAME, RES_PHONE, RES_TIME, RES_PARKING, RES_ROAD_ADDRESS) 
VALUES ( restaurant_seq.nextval, 301, 908,'남도한정식황복촌', '031-236-3130', '매일 10:30-23:00', '단체석, 주차, 포장, 예약, 무선 인터넷, 남/녀 화장실 구분', '경기 수원시 팔달구 효원로265번길 41 신흥빌딩');

INSERT INTO RESTAURANT ( RES_NO,FILTER_NO, REGION_NO,  RES_NAME, RES_PHONE, RES_TIME, RES_PARKING, RES_ROAD_ADDRESS) 
VALUES ( restaurant_seq.nextval,301, 908,'동기간', '031-581-5570', '매일 11:00-20:00', '단체석, 주차, 포장, 예약, 무선 인터넷, 남/녀 화장실 구분', '경기 가평군 가평읍 보납로 459-158 동기간');


INSERT INTO RESTAURANT ( RES_NO, FILTER_NO, REGION_NO, RES_NAME, RES_PHONE, RES_TIME, RES_PARKING, RES_ROAD_ADDRESS) 
VALUES ( restaurant_seq.nextval,301, 909, '하연옥', '055-746-0525', '매일 10:00-20:30', '단체석, 주차, 포장, 예약, 무선 인터넷, 남/녀 화장실 구분', '경남 진주시 진주대로 1317-20');

INSERT INTO RESTAURANT ( RES_NO, FILTER_NO, REGION_NO, RES_NAME, RES_PHONE, RES_TIME, RES_PARKING, RES_ROAD_ADDRESS) 
VALUES ( restaurant_seq.nextval, 301, 909,'싱싱게장', '0507-1400-5513', '매일 09:00-21:00', '단체석, 주차, 포장, 예약, 무선 인터넷, 남/녀 화장실 구분', '경남 거제시 장승포로 10');

INSERT INTO RESTAURANT ( RES_NO,FILTER_NO, REGION_NO,  RES_NAME, RES_PHONE, RES_TIME, RES_PARKING, RES_ROAD_ADDRESS) 
VALUES ( restaurant_seq.nextval, 301, 909,'울산다찌', '0507-1401-1350', '매일 12:00-22:00', '단체석, 주차, 포장, 예약, 무선 인터넷, 남/녀 화장실 구분', '경남 통영시 미수해안로 157');


INSERT INTO RESTAURANT ( RES_NO,FILTER_NO, REGION_NO,  RES_NAME, RES_PHONE, RES_TIME, RES_PARKING, RES_ROAD_ADDRESS) 
VALUES ( restaurant_seq.nextval, 301, 801,'늘봄', '0507-1400-3715', '매일 09:00-21:00', '단체석, 주차, 포장, 예약, 무선 인터넷, 남/녀 화장실 구분', '경북 경주시 보불로 107');

INSERT INTO RESTAURANT ( RES_NO,FILTER_NO, REGION_NO,  RES_NAME, RES_PHONE, RES_TIME, RES_PARKING, RES_ROAD_ADDRESS)
VALUES ( restaurant_seq.nextval, 301, 801, '마라도회식당', '0507-1333-3850', '매일 11:00-20:00', '단체석, 주차, 포장, 예약, 무선 인터넷, 남/녀 화장실 구분', '경북 포항시 북구 해안로 217-1');

INSERT INTO RESTAURANT ( RES_NO,FILTER_NO, REGION_NO,  RES_NAME, RES_PHONE, RES_TIME, RES_PARKING, RES_ROAD_ADDRESS) 
VALUES ( restaurant_seq.nextval, 301, 801, '백두산가든', '0507-1493-4545', '매일 09:00-21:00', '단체석, 주차, 포장, 예약, 무선 인터넷, 남/녀 화장실 구분', '경북 문경시 문경읍 새재로 869');


INSERT INTO RESTAURANT ( RES_NO, FILTER_NO, REGION_NO, RES_NAME, RES_PHONE, RES_TIME, RES_PARKING, RES_ROAD_ADDRESS) 
VALUES ( restaurant_seq.nextval, 301, 802,'명동게장', '0507-1353-0593', '매일 07:00-21:00', '단체석, 주차, 포장, 예약, 무선 인터넷, 남/녀 화장실 구분', '전남 여수시 봉산남4길 23-26');

INSERT INTO RESTAURANT ( RES_NO,FILTER_NO, REGION_NO,  RES_NAME, RES_PHONE, RES_TIME, RES_PARKING, RES_ROAD_ADDRESS) 
VALUES ( restaurant_seq.nextval,301, 802, '청정게장촌', '0507-1406-7855', '매일 07:30-21:00', '단체석, 주차, 포장, 예약, 무선 인터넷, 남/녀 화장실 구분', '전남 여수시 봉산남4길 23-32');

INSERT INTO RESTAURANT ( RES_NO, FILTER_NO, REGION_NO, RES_NAME, RES_PHONE, RES_TIME, RES_PARKING, RES_ROAD_ADDRESS) 
VALUES ( restaurant_seq.nextval, 301, 802,'쌍교숯불갈비 담양 본점', '0507-1316-0012', '매일 11:00-21:00', '단체석, 주차, 포장, 예약, 무선 인터넷, 남/녀 화장실 구분', '전남 담양군 봉산면 송강정로 212');


INSERT INTO RESTAURANT ( RES_NO,FILTER_NO, REGION_NO,  RES_NAME, RES_PHONE, RES_TIME, RES_PARKING, RES_ROAD_ADDRESS) 
VALUES ( restaurant_seq.nextval,301, 803, '보리나라 학원농장', '063-564-9897', '매일 11:00-20:00', '단체석, 주차, 포장, 예약, 무선 인터넷, 남/녀 화장실 구분', '전북 고창군 공음면 학원농장길 154');

INSERT INTO RESTAURANT ( RES_NO,FILTER_NO, REGION_NO,  RES_NAME, RES_PHONE, RES_TIME, RES_PARKING, RES_ROAD_ADDRESS) 
VALUES ( restaurant_seq.nextval, 301, 803,'한국집', '063-284-2224', '매일 09:30-21:00', '단체석, 주차, 포장, 예약, 무선 인터넷, 남/녀 화장실 구분', '전북 전주시 완산구 어진길 119');

INSERT INTO RESTAURANT ( RES_NO, FILTER_NO, REGION_NO, RES_NAME, RES_PHONE, RES_TIME, RES_PARKING, RES_ROAD_ADDRESS) 
VALUES ( restaurant_seq.nextval, 301, 803, '한일옥', '063-446-5491', '매일 06:0-20:30', '단체석, 주차, 포장, 예약, 무선 인터넷, 남/녀 화장실 구분', '전북 군산시 구영3길 63');

INSERT INTO RESTAURANT ( RES_NO,FILTER_NO, REGION_NO,  RES_NAME, RES_PHONE, RES_TIME, RES_PARKING, RES_ROAD_ADDRESS) 
VALUES ( restaurant_seq.nextval,301, 804, '우진해장국', '064-757-3393', '매일 06:00-22:00', '단체석, 주차, 포장, 예약, 무선 인터넷, 남/녀 화장실 구분', '제주 제주시 서사로 11');

INSERT INTO RESTAURANT ( RES_NO,FILTER_NO, REGION_NO,  RES_NAME, RES_PHONE, RES_TIME, RES_PARKING, RES_ROAD_ADDRESS) 
VALUES ( restaurant_seq.nextval, 301, 804,'올래국수', '064-742-7355', '매일 08:30-17:00', '단체석, 주차, 포장, 예약, 무선 인터넷, 남/녀 화장실 구분', '제주 제주시 귀아랑길 24');

INSERT INTO RESTAURANT ( RES_NO, FILTER_NO, REGION_NO, RES_NAME, RES_PHONE, RES_TIME, RES_PARKING, RES_ROAD_ADDRESS) 
VALUES ( restaurant_seq.nextval, 301, 804,'춘심이네 본점', '064-794-4010', '매일 10:30-20:00', '단체석, 주차, 포장, 예약, 무선 인터넷, 남/녀 화장실 구분', '제주 서귀포시 안덕면 창천중앙로24번길 16');


INSERT INTO RESTAURANT ( RES_NO, FILTER_NO, REGION_NO, RES_NAME, RES_PHONE, RES_TIME, RES_PARKING, RES_ROAD_ADDRESS) 
VALUES ( restaurant_seq.nextval, 301, 805, '안면도맛집 꽃지꽃게집', '0507-1382-1105', '매일 09:00-21:00', '단체석, 주차, 포장, 예약, 무선 인터넷, 남/녀 화장실 구분', '충남 태안군 안면읍 안면대로 3020');

INSERT INTO RESTAURANT ( RES_NO,FILTER_NO, REGION_NO,  RES_NAME, RES_PHONE, RES_TIME, RES_PARKING, RES_ROAD_ADDRESS) 
VALUES ( restaurant_seq.nextval, 301, 805, '장원막국수', '041-835-6561', '매일 11:00-17:00', '단체석, 주차, 포장, 예약, 무선 인터넷, 남/녀 화장실 구분', '충남 부여군 부여읍 나루터로62번길 20');

INSERT INTO RESTAURANT ( RES_NO,FILTER_NO, REGION_NO,  RES_NAME, RES_PHONE, RES_TIME, RES_PARKING, RES_ROAD_ADDRESS) 
VALUES ( restaurant_seq.nextval,301, 805, '숟가락반상 마실 천안본점', '041-571-7007', '매일 11:00-14:30', '단체석, 주차, 포장, 예약, 무선 인터넷, 남/녀 화장실 구분', '충남 천안시 서북구 월봉1길 50-1');


INSERT INTO RESTAURANT ( RES_NO, FILTER_NO, REGION_NO, RES_NAME, RES_PHONE, RES_TIME, RES_PARKING, RES_ROAD_ADDRESS) 
VALUES ( restaurant_seq.nextval, 301, 806,'산아래', '0507-1489-3233', '매일 12:00-21:30', '단체석, 주차, 포장, 예약, 무선 인터넷, 남/녀 화장실 구분', '충북 제천시 봉양읍 앞산로 174');

INSERT INTO RESTAURANT ( RES_NO,FILTER_NO, REGION_NO,  RES_NAME, RES_PHONE, RES_TIME, RES_PARKING, RES_ROAD_ADDRESS) 
VALUES ( restaurant_seq.nextval, 301, 806,'부부농장', '0507-1336-0841', '매일 11:00-21:00', '단체석, 주차, 포장, 예약, 무선 인터넷, 남/녀 화장실 구분', '충북 청주시 상당구 문의면 대청호반로 834-1');

INSERT INTO RESTAURANT ( RES_NO,FILTER_NO, REGION_NO,  RES_NAME, RES_PHONE, RES_TIME, RES_PARKING, RES_ROAD_ADDRESS) 
VALUES ( restaurant_seq.nextval, 301, 806,'뜰이있는집', '0507-1420-8585', '매일 11:30-08:30', '단체석, 주차, 포장, 예약, 무선 인터넷, 남/녀 화장실 구분', '충북 제천시 하소천길 176 뜰이있는집');




--양식

INSERT INTO RESTAURANT ( RES_NO, FILTER_NO, REGION_NO, RES_NAME, RES_PHONE, RES_TIME, RES_PARKING, RES_ROAD_ADDRESS) 
VALUES ( RESTAURANT_SEQ.NEXTVAL, 302, 900, '롯데호텔월드 라세느', '02-411-7811', '평일 11:30-20:00', '단체석, 주차, 포장, 예약, 무선 인터넷, 남/녀 화장실 구분', '서울 송파구 올림픽로 240 롯데호텔월드 2층');

INSERT INTO RESTAURANT ( RES_NO, FILTER_NO, REGION_NO, RES_NAME, RES_PHONE, RES_TIME, RES_PARKING, RES_ROAD_ADDRESS) 
VALUES ( RESTAURANT_SEQ.NEXTVAL, 302, 900, '바비레드 강남본점', '02-3452-1515', '매일 11:30 -22:00', '단체석, 주차, 포장, 예약, 무선 인터넷, 남/녀 화장실 구분',  '서울 강남구 봉은사로6길 39 바비레드');

INSERT INTO RESTAURANT ( RES_NO, FILTER_NO, REGION_NO, RES_NAME, RES_PHONE, RES_TIME, RES_PARKING, RES_ROAD_ADDRESS)
VALUES ( RESTAURANT_SEQ.NEXTVAL, 302, 900, '세상의모든아침', '02-2055-4442', '매일 10:00 -22:00', '단체석, 주차, 포장, 예약, 무선 인터넷, 남/녀 화장실 구분', '서울 영등포구 여의대로 24 전경련회관 50층, 51층');

--양식, 부산
INSERT INTO RESTAURANT ( RES_NO,FILTER_NO, REGION_NO,  RES_NAME, RES_PHONE, RES_TIME, RES_PARKING, RES_ROAD_ADDRESS) 
VALUES ( RESTAURANT_SEQ.NEXTVAL, 302, 901,'디에이블 광안점', '051-754-5759', '매일 11:00 -23:00', '단체석, 주차, 포장, 예약, 무선 인터넷', '부산 수영구 민락수변로 29');

--양식, 대구
INSERT INTO RESTAURANT ( RES_NO, FILTER_NO, REGION_NO, RES_NAME, RES_PHONE, RES_TIME, RES_PARKING, RES_ROAD_ADDRESS) 
VALUES ( RESTAURANT_SEQ.NEXTVAL, 302, 902,'인투', '0507-1415-3965', '매일 12:00 -21:00', '단체석, 주차, 포장, 예약, 무선 인터넷', '대구 중구 동성로4길 95');

--양식, 인천

INSERT INTO RESTAURANT ( RES_NO,FILTER_NO, REGION_NO,  RES_NAME, RES_PHONE, RES_TIME, RES_PARKING, RES_ROAD_ADDRESS) 
VALUES ( RESTAURANT_SEQ.NEXTVAL, 302, 903,'풀사이드228 송도점', '032-817-0000', '매일 11:00 -22:00', '단체석, 주차, 포장, 예약, 무선 인터넷', '인천 연수구 해돋이로 157');

--양식, 광주
INSERT INTO RESTAURANT ( RES_NO,FILTER_NO, REGION_NO,  RES_NAME, RES_PHONE, RES_TIME, RES_PARKING, RES_ROAD_ADDRESS) 
VALUES ( RESTAURANT_SEQ.NEXTVAL, 302, 904,'어나더키친 상무점', '0507-1414-9085', '매일 11:30-22:00', '단체석, 주차, 포장, 예약, 무선 인터넷', '광주 서구 시청로60번길 21-9 메가박스');

--양식, 대전
INSERT INTO RESTAURANT ( RES_NO, FILTER_NO, REGION_NO, RES_NAME, RES_PHONE, RES_TIME, RES_PARKING, RES_ROAD_ADDRESS) 
VALUES ( RESTAURANT_SEQ.NEXTVAL, 302, 905,'칸스테이크하우스 도안본점', '042-825-5284', '매일 11:30-22:00 브레이크타임 15:00-17:30 월요일 휴무', '단체석, 주차, 포장, 예약, 무선 인터넷', '대전 유성구 봉명서로 17-11');

--양식, 울산
INSERT INTO RESTAURANT ( RES_NO,FILTER_NO, REGION_NO,  RES_NAME, RES_PHONE, RES_TIME, RES_PARKING, RES_ROAD_ADDRESS) 
VALUES ( RESTAURANT_SEQ.NEXTVAL, 302, 906,'단골627', '052-294-7788', '매일 12:00-22:00 브레이크타임 15:00-16:30 월요일 휴무', '단체석, 주차, 포장, 예약, 무선 인터넷', '울산 중구 강북로 123 태화강엑소디움');

--양식, 경기
INSERT INTO RESTAURANT ( RES_NO,FILTER_NO, REGION_NO,  RES_NAME, RES_PHONE, RES_TIME, RES_PARKING, RES_ROAD_ADDRESS) 
VALUES ( RESTAURANT_SEQ.NEXTVAL, 302, 908,'잇탈리 헤이리점', '0507-1372-1448', '매일 10:00-22:30', '단체석, 주차, 포장, 예약, 무선 인터넷, 남/녀 화장실 구분', '경기 파주시 탄현면 헤이리마을길 48-9');

INSERT INTO RESTAURANT ( RES_NO, FILTER_NO, REGION_NO, RES_NAME, RES_PHONE, RES_TIME, RES_PARKING, RES_ROAD_ADDRESS) 
VALUES ( RESTAURANT_SEQ.NEXTVAL, 302, 908,'보나카바', '0507-1440-5778', '매일 11:30-21:30', '단체석, 주차, 포장, 예약, 무선 인터넷, 남/녀 화장실 구분', '경기 오산시 외삼미로152번길 57-29');

INSERT INTO RESTAURANT ( RES_NO,FILTER_NO, REGION_NO,  RES_NAME, RES_PHONE, RES_TIME, RES_PARKING, RES_ROAD_ADDRESS) 
VALUES ( RESTAURANT_SEQ.NEXTVAL,  302, 908,'퍼들하우스', '031-766-0757', '매일 11:30-21:00', '단체석, 주차, 포장, 예약, 무선 인터넷, 남/녀 화장실 구분', '경기 광주시 초월읍 경충대로 1337-74');

--양식, 경남
INSERT INTO RESTAURANT ( RES_NO, FILTER_NO, REGION_NO, RES_NAME, RES_PHONE, RES_TIME, RES_PARKING, RES_ROAD_ADDRESS) 
VALUES ( RESTAURANT_SEQ.NEXTVAL, 302, 909, '완벽한 인생', '055-867-0108', '매일 11:00-22:00', '단체석, 주차, 포장, 예약, 무선 인터넷, 남/녀 화장실 구분', '경남 남해군 삼동면 독일로 30 완벽한인생');

--양식, 경북
INSERT INTO RESTAURANT ( RES_NO,FILTER_NO, REGION_NO,  RES_NAME, RES_PHONE, RES_TIME, RES_PARKING, RES_ROAD_ADDRESS) 
VALUES ( RESTAURANT_SEQ.NEXTVAL, 302, 801,'시즈닝', '0507-1483-7477', '매일 10:30-21:30 브레이크 타임 15:30 - 17:00 ', '단체석, 주차, 포장, 예약, 무선 인터넷, 남/녀 화장실 구분, 노키즈존', '경북 경주시 첨성로99번길 25-2');

--양식, 전남
INSERT INTO RESTAURANT ( RES_NO, FILTER_NO, REGION_NO, RES_NAME, RES_PHONE, RES_TIME, RES_PARKING, RES_ROAD_ADDRESS) 
VALUES ( RESTAURANT_SEQ.NEXTVAL, 302, 802,'영산나루', '0507-1409-2131', '매일 11:00-22:00', '단체석, 주차, 포장, 예약, 무선 인터넷, 남/녀 화장실 구분', '전남 나주시 주면2길 28');

--양식, 전북
INSERT INTO RESTAURANT ( RES_NO,FILTER_NO, REGION_NO,  RES_NAME, RES_PHONE, RES_TIME, RES_PARKING, RES_ROAD_ADDRESS) 
VALUES ( RESTAURANT_SEQ.NEXTVAL,  302, 803,'파라디소 페르두또', '063-471-8525', '매일 11:30-22:00', '단체석, 주차, 포장, 예약, 무선 인터넷, 남/녀 화장실 구분', '전북 군산시 한밭로 76-11');

--양식, 제주
INSERT INTO RESTAURANT ( RES_NO,FILTER_NO, REGION_NO,  RES_NAME, RES_PHONE, RES_TIME, RES_PARKING, RES_ROAD_ADDRESS) 
VALUES ( RESTAURANT_SEQ.NEXTVAL,  302, 804,'밥깡패', '064-799-8188', '매일 11:30-20:00', '단체석, 주차, 포장, 예약, 무선 인터넷, 남/녀 화장실 구분', '제주 제주시 한림읍 한림로4길 35');

--양식, 충남
INSERT INTO RESTAURANT ( RES_NO,FILTER_NO, REGION_NO,  RES_NAME, RES_PHONE, RES_TIME, RES_PARKING, RES_ROAD_ADDRESS) 
VALUES ( RESTAURANT_SEQ.NEXTVAL,  302, 805,'마들렌 패밀리 뷔페레스토랑', '0507-1395-5315', '매일 11:30-21:30 브레이크 타임 15:00-18:00', '단체석, 주차, 포장, 예약, 무선 인터넷, 남/녀 화장실 구분', '충남 아산시 배방읍 온천대로 2230');

--양식, 충북
INSERT INTO RESTAURANT ( RES_NO, FILTER_NO, REGION_NO, RES_NAME, RES_PHONE, RES_TIME, RES_PARKING, RES_ROAD_ADDRESS) 
VALUES ( RESTAURANT_SEQ.NEXTVAL,  302, 806,'파프리카 충북대점', '0507-1405-8068', '매일 11:00-23:00 평일 15:00 - 17:00 브레이크 타임', 
'단체석, 주차, 포장, 예약, 무선 인터넷, 남/녀 화장실 구분', '충북 청주시 서원구 1순환로 682 메가박스 충북대점 2층');





--중식

INSERT INTO RESTAURANT ( RES_NO,FILTER_NO, REGION_NO,  RES_NAME, RES_PHONE, RES_TIME, RES_PARKING, RES_ROAD_ADDRESS) 
VALUES ( restaurant_seq.nextval, 303, 900,'명동교자 본점', '02-776-5348', '평일 10:30-20:30', '단체석, 주차, 포장, 예약, 무선 인터넷, 남/녀 화장실 구분', '서울 중구 명동10길 29');

INSERT INTO RESTAURANT ( RES_NO,FILTER_NO, REGION_NO,  RES_NAME, RES_PHONE, RES_TIME, RES_PARKING, RES_ROAD_ADDRESS) 
VALUES ( restaurant_seq.nextval, 303, 900,'목란', '02-732-1245', '월요일 휴무, 평일 11:30-21:20', '단체석, 주차, 포장, 예약, 무선 인터넷, 남/녀 화장실 구분', '서울 서대문구 연희로15길 21');

--중식, 대구
INSERT INTO RESTAURANT ( RES_NO, FILTER_NO, REGION_NO, RES_NAME, RES_PHONE, RES_TIME, RES_PARKING, RES_ROAD_ADDRESS) 
VALUES ( restaurant_seq.nextval, 303, 902,'가야성', '053-654-0545', '매일 11:00-21:00', '단체석, 주차, 포장, 예약, 무선 인터넷, 남/녀 화장실 구분', '대구 달서구 월배로83길 7');

INSERT INTO RESTAURANT ( RES_NO,FILTER_NO, REGION_NO,  RES_NAME, RES_PHONE, RES_TIME, RES_PARKING, RES_ROAD_ADDRESS) 
VALUES ( restaurant_seq.nextval, 303, 902,'리안', '053-746-0203', '매일 11:30-21:00', '단체석, 주차, 포장, 예약, 무선 인터넷, 남/녀 화장실 구분', '대구 수성구 교학로4길 48');

--중식, 인천
INSERT INTO RESTAURANT ( RES_NO,FILTER_NO, REGION_NO,  RES_NAME, RES_PHONE, RES_TIME, RES_PARKING, RES_ROAD_ADDRESS) 
VALUES ( restaurant_seq.nextval, 303, 903,'연경', '0507-1311-7888', '매일 10:30-21:30', '단체석, 주차, 포장, 예약, 무선 인터넷, 남/녀 화장실 구분', '인천 중구 차이나타운로 41');

INSERT INTO RESTAURANT ( RES_NO,FILTER_NO, REGION_NO,  RES_NAME, RES_PHONE, RES_TIME, RES_PARKING, RES_ROAD_ADDRESS) 
VALUES ( restaurant_seq.nextval, 303, 903,'만다복', '032-773-3838', '매일 11:00-21:30', '단체석, 주차, 포장, 예약, 무선 인터넷, 남/녀 화장실 구분', '인천 중구 차이나타운로 36');

--중식, 경기
INSERT INTO RESTAURANT ( RES_NO,FILTER_NO, REGION_NO,  RES_NAME, RES_PHONE, RES_TIME, RES_PARKING, RES_ROAD_ADDRESS) 
VALUES ( restaurant_seq.nextval, 303, 908, '고구려짬뽕집', '031-317-3636', '매일 10:30-20:00', '단체석, 주차, 포장, 예약, 무선 인터넷, 남/녀 화장실 구분', '경기 시흥시 수인로 3472-22');

INSERT INTO RESTAURANT ( RES_NO,FILTER_NO, REGION_NO,  RES_NAME, RES_PHONE, RES_TIME, RES_PARKING, RES_ROAD_ADDRESS) 
VALUES ( restaurant_seq.nextval, 303, 908,'상해루', '031-8015-0102', '매일 11:00-22:00', '단체석, 주차, 포장, 예약, 무선 인터넷, 남/녀 화장실 구분', '경기 화성시 노작로 147 돌모루프라자 DM프라자');




--일식, 부산
INSERT INTO RESTAURANT ( RES_NO,FILTER_NO, REGION_NO,  RES_NAME, RES_PHONE, RES_TIME, RES_PARKING, RES_ROAD_ADDRESS) 
VALUES ( restaurant_seq.nextval, 304, 901,'갓파스시 연산점', '051-868-4377', '평일 11:30-21:30 토요일 11:30-22:00', '단체석, 주차, 포장, 예약, 무선 인터넷, 남/녀 화장실 구분', '부산 연제구 반송로 44');

--일식, 대구
INSERT INTO RESTAURANT ( RES_NO,FILTER_NO, REGION_NO,  RES_NAME, RES_PHONE, RES_TIME, RES_PARKING, RES_ROAD_ADDRESS) 
VALUES ( restaurant_seq.nextval, 304, 902,'한냐마켓또', '070-4241-8155', '평일 17:30-03:00 주말 17:00-05:00', '단체석, 주차, 포장, 예약, 무선 인터넷, 남/녀 화장실 구분', '대구 중구 동성로5길 69-1 한냐마켓또');

--일식, 인천
INSERT INTO RESTAURANT ( RES_NO, FILTER_NO, REGION_NO, RES_NAME, RES_PHONE, RES_TIME, RES_PARKING, RES_ROAD_ADDRESS) 
VALUES ( restaurant_seq.nextval, 304, 903,'스시애 2호점', '0507-1474-5572', '매일 11:30-16:00', '단체석, 주차, 포장, 예약, 무선 인터넷, 남/녀 화장실 구분', '인천 부평구 부평대로87번길 4 2층');

--일식, 경기
INSERT INTO RESTAURANT ( RES_NO, FILTER_NO, REGION_NO, RES_NAME, RES_PHONE, RES_TIME, RES_PARKING, RES_ROAD_ADDRESS)
VALUES ( restaurant_seq.nextval, 304, 908,'초밥왕', '0507-1378-8856', '매일 11:00-24:00', '단체석, 주차, 포장, 예약, 무선 인터넷, 남/녀 화장실 구분', '경기 수원시 팔달구 향교로1번길 5 지하 초밥왕');

INSERT INTO RESTAURANT ( RES_NO,FILTER_NO, REGION_NO,  RES_NAME, RES_PHONE, RES_TIME, RES_PARKING, RES_ROAD_ADDRESS) 
VALUES ( restaurant_seq.nextval, 304, 908,'에버그린', '031-425-4359', '매일 11:00-16:00 일요일 휴무', '단체석, 주차, 포장, 예약, 무선 인터넷, 남/녀 화장실 구분', '경기 안양시 동안구 인덕원로 29-16');

INSERT INTO RESTAURANT ( RES_NO,FILTER_NO, REGION_NO,  RES_NAME, RES_PHONE, RES_TIME, RES_PARKING, RES_ROAD_ADDRESS) 
VALUES ( restaurant_seq.nextval, 304, 908,'스시웨이 광명본점', '02-2616-3774', '매일 11:30-22:00 일요일 휴무', '단체석, 주차, 포장, 예약, 무선 인터넷, 남/녀 화장실 구분', '경기 광명시 가림일로 80 로즈힐빌딩3층');


--아시아 음식, 광주
INSERT INTO RESTAURANT ( RES_NO, FILTER_NO, REGION_NO, RES_NAME, RES_PHONE, RES_TIME, RES_PARKING, RES_ROAD_ADDRESS) 
VALUES ( restaurant_seq.nextval, 305, 904, '분포나인', '0507-1439-2274', '매일 11:00-21:00', '단체석, 주차, 포장, 예약, 무선 인터넷, 남/녀 화장실 구분', '광주 남구 백서로 39');

--아시아 음식, 경기
INSERT INTO RESTAURANT ( RES_NO,FILTER_NO, REGION_NO,  RES_NAME, RES_PHONE, RES_TIME, RES_PARKING, RES_ROAD_ADDRESS) 
VALUES ( restaurant_seq.nextval, 305, 908, '포레스트', '031-8003-6616', '매일 11:30-21:30', '단체석, 주차, 포장, 예약, 무선 인터넷, 남/녀 화장실 구분', '경기 화성시 동탄공원로2길 33-9 1층');

INSERT INTO RESTAURANT ( RES_NO, FILTER_NO, REGION_NO, RES_NAME, RES_PHONE, RES_TIME, RES_PARKING, RES_ROAD_ADDRESS) 
VALUES ( restaurant_seq.nextval, 305, 908,'타임포타이', '0507-1441-1145', '매일 11:00-22:00', '단체석, 주차, 포장, 예약, 무선 인터넷, 남/녀 화장실 구분', '경기 성남시 분당구 문정로144번길 5');

INSERT INTO RESTAURANT ( RES_NO,FILTER_NO, REGION_NO,  RES_NAME, RES_PHONE, RES_TIME, RES_PARKING, RES_ROAD_ADDRESS) 
VALUES ( restaurant_seq.nextval,305, 908, '아초원', '0507-1314-4490', '매일 11:00-22:00', '단체석, 주차, 포장, 예약, 무선 인터넷, 남/녀 화장실 구분', '경기 하남시 감일남로52번길 21-29');





--카페, 서울

INSERT INTO RESTAURANT ( RES_NO, FILTER_NO, REGION_NO, RES_NAME, RES_PHONE, RES_TIME, RES_PARKING, RES_ROAD_ADDRESS) 
VALUES ( restaurant_seq.nextval,306, 900, '쟝블랑제리', '02-889-5170', '매일 07:00 - 22:00', '단체석, 주차, 포장, 예약, 무선 인터넷, 남/녀 화장실 구분', '서울 관악구 낙성대역길 8');

INSERT INTO RESTAURANT ( RES_NO, FILTER_NO, REGION_NO, RES_NAME, RES_PHONE, RES_TIME, RES_PARKING, RES_ROAD_ADDRESS) 
VALUES ( restaurant_seq.nextval,306, 900, '피오니', '02-333-5325', '매일 12:00-22:00', '단체석, 주차, 포장, 예약, 무선 인터넷, 남/녀 화장실 구분', '서울 마포구 어울마당로 56');

INSERT INTO RESTAURANT ( RES_NO, FILTER_NO, REGION_NO, RES_NAME, RES_PHONE, RES_TIME, RES_PARKING, RES_ROAD_ADDRESS) 
VALUES ( restaurant_seq.nextval,306, 900, '더베이커스테이블', '070-7717-3501', '매일 08:00-21:00', '단체석, 주차, 포장, 예약, 무선 인터넷, 남/녀 화장실 구분', '서울 용산구 녹사평대로 244-1');

--카페, 부산
INSERT INTO RESTAURANT ( RES_NO,FILTER_NO, REGION_NO,  RES_NAME, RES_PHONE, RES_TIME, RES_PARKING, RES_ROAD_ADDRESS) 
VALUES ( restaurant_seq.nextval,306, 901, '웨이브온 커피', '051-727-1660', '매일 11:00-24:00', '단체석, 주차, 포장, 예약, 무선 인터넷, 남/녀 화장실 구분', '부산 기장군 장안읍 해맞이로 286 웨이브온커피');

INSERT INTO RESTAURANT ( RES_NO, FILTER_NO, REGION_NO, RES_NAME, RES_PHONE, RES_TIME, RES_PARKING, RES_ROAD_ADDRESS) 
VALUES ( restaurant_seq.nextval,306, 901, '옵스 해운대점', '051-747-6886', '매일 09:00-21:00', '단체석, 주차, 포장, 예약, 무선 인터넷, 남/녀 화장실 구분', '부산 해운대구 중동1로 31');

--카페, 대구
INSERT INTO RESTAURANT ( RES_NO, FILTER_NO, REGION_NO, RES_NAME, RES_PHONE, RES_TIME, RES_PARKING, RES_ROAD_ADDRESS) 
VALUES ( restaurant_seq.nextval,306, 902, '삼송빵집 본점', '053-254-4064', '매일 08:00-22:00', '단체석, 주차, 포장, 예약, 무선 인터넷, 남/녀 화장실 구분', '대구 중구 중앙대로 397');

--카페, 광주
INSERT INTO RESTAURANT ( RES_NO,FILTER_NO, REGION_NO,  RES_NAME, RES_PHONE, RES_TIME, RES_PARKING, RES_ROAD_ADDRESS) 
VALUES ( restaurant_seq.nextval, 306, 904,'센도리', '0507-1488-4200', '매일 11:30-22:00', '단체석, 주차, 포장, 예약, 무선 인터넷, 남/녀 화장실 구분', '광주 동구 충장로 93-6');

--카페, 인천
INSERT INTO RESTAURANT ( RES_NO,FILTER_NO, REGION_NO,  RES_NAME, RES_PHONE, RES_TIME, RES_PARKING, RES_ROAD_ADDRESS) 
VALUES ( restaurant_seq.nextval, 306, 903, '카페오라', '032-752-0888', '매일 09:30-21:00', '단체석, 주차, 포장, 예약, 무선 인터넷, 남/녀 화장실 구분', '인천 중구 용유서로 380');

INSERT INTO RESTAURANT ( RES_NO,FILTER_NO, REGION_NO,  RES_NAME, RES_PHONE, RES_TIME, RES_PARKING, RES_ROAD_ADDRESS) 
VALUES ( restaurant_seq.nextval, 306, 903,'궁전제과 충장점', '062-222-3477', '매일 10:00-21:30', '단체석, 주차, 포장, 예약, 무선 인터넷, 남/녀 화장실 구분', '인천 중구 용유서로 380');

--카페, 경기
INSERT INTO RESTAURANT ( RES_NO, FILTER_NO, REGION_NO, RES_NAME, RES_PHONE, RES_TIME, RES_PARKING, RES_ROAD_ADDRESS) 
VALUES ( restaurant_seq.nextval, 306, 908,'고당', '031-576-8090', '매일 11:00-22:00', '단체석, 주차, 포장, 예약, 무선 인터넷, 남/녀 화장실 구분', '경기 남양주시 조안면 북한강로 121 고당');

INSERT INTO RESTAURANT ( RES_NO,FILTER_NO, REGION_NO,  RES_NAME, RES_PHONE, RES_TIME, RES_PARKING, RES_ROAD_ADDRESS) 
VALUES ( restaurant_seq.nextval, 306, 908, '뱀부15-8', '0507-1409-7001', '매일 11:00-22:00', '단체석, 주차, 포장, 예약, 무선 인터넷, 남/녀 화장실 구분', '경기 김포시 하성면 금포로1915번길 7 뱀부카페 레스토랑');

INSERT INTO RESTAURANT ( RES_NO, FILTER_NO, REGION_NO, RES_NAME, RES_PHONE, RES_TIME, RES_PARKING, RES_ROAD_ADDRESS) 
VALUES ( restaurant_seq.nextval,  306, 908,'유니스의 정원', '031-437-2045', '매일 11:00-22:00', '단체석, 주차, 포장, 예약, 무선 인터넷, 남/녀 화장실 구분', '경기 안산시 상록구 반월천북길 139');

INSERT INTO RESTAURANT ( RES_NO,FILTER_NO, REGION_NO,  RES_NAME, RES_PHONE, RES_TIME, RES_PARKING, RES_ROAD_ADDRESS) 
VALUES ( restaurant_seq.nextval,  306, 908,'카페 아를', '031-837-1717', '매일 10:00-24:00', '단체석, 주차, 포장, 예약, 무선 인터넷, 남/녀 화장실 구분', '경기 의정부시 동일로 204 카페 아를');

INSERT INTO RESTAURANT ( RES_NO, FILTER_NO, REGION_NO, RES_NAME, RES_PHONE, RES_TIME, RES_PARKING, RES_ROAD_ADDRESS) 
VALUES ( restaurant_seq.nextval,  306, 908,'포레스트아웃팅스', '070-4154-8955', '매일 10:00-22:00', '단체석, 주차, 포장, 예약, 무선 인터넷, 남/녀 화장실 구분', '경기 고양시 일산동구 고양대로 1124 포레스트 아웃팅스');

INSERT INTO RESTAURANT ( RES_NO, FILTER_NO, REGION_NO, RES_NAME, RES_PHONE, RES_TIME, RES_PARKING, RES_ROAD_ADDRESS) 
VALUES ( restaurant_seq.nextval,  306, 908,'마이알레', '02-3445-1794', '매일 11:00-22:00', '단체석, 주차, 포장, 예약, 무선 인터넷, 남/녀 화장실 구분', '경기 과천시 삼부골3로 17');

--카페, 제주
INSERT INTO RESTAURANT ( RES_NO,FILTER_NO, REGION_NO,  RES_NAME, RES_PHONE, RES_TIME, RES_PARKING, RES_ROAD_ADDRESS) 
VALUES ( restaurant_seq.nextval,  306, 804, '애월더선셋', '0507-1403-5943', '매일 10:00-20:00', '단체석, 주차, 포장, 예약, 무선 인터넷, 남/녀 화장실 구분', '제주 제주시 애월읍 일주서로 6111');

INSERT INTO RESTAURANT ( RES_NO, FILTER_NO, REGION_NO, RES_NAME, RES_PHONE, RES_TIME, RES_PARKING, RES_ROAD_ADDRESS) 
VALUES ( restaurant_seq.nextval, 306, 804,'카페델문도', '064-702-00073', '매일 07:00-00:00', '단체석, 주차, 포장, 예약, 무선 인터넷, 남/녀 화장실 구분', '제주 제주시 조천읍 조함해안로 519-10');

INSERT INTO RESTAURANT ( RES_NO, FILTER_NO, REGION_NO, RES_NAME, RES_PHONE, RES_TIME, RES_PARKING, RES_ROAD_ADDRESS) 
VALUES ( restaurant_seq.nextval, 306, 804,'풍림다방 송당점', '1811-5775', '매일 10:30-18:00', '단체석, 주차, 포장, 예약, 무선 인터넷, 남/녀 화장실 구분', '제주 제주시 구좌읍 중산간동로 2267-4 풍림다방');



--분식 , 서울

INSERT INTO RESTAURANT ( RES_NO,FILTER_NO, REGION_NO,  RES_NAME, RES_PHONE, RES_TIME, RES_PARKING, RES_ROAD_ADDRESS) 
VALUES ( restaurant_seq.nextval,307, 900, '101번지 남산돈까스 본점', '02-777-7929', '매일 10:30 - 22:00', '단체석, 주차, 포장, 예약, 무선 인터넷, 남/녀 화장실 구분', '서울 중구 소파로 101');

--분식, 부산
INSERT INTO RESTAURANT ( RES_NO, FILTER_NO, REGION_NO, RES_NAME, RES_PHONE, RES_TIME, RES_PARKING, RES_ROAD_ADDRESS) 
VALUES ( restaurant_seq.nextval, 307, 901,'다리집', '051-625-0130', '매일 11:30-21:30 화요일 휴무', '단체석, 주차, 포장, 예약, 무선 인터넷, 남/녀 화장실 구분', '부산 수영구 남천바다로10번길 70 101호');

--분식, 대구
INSERT INTO RESTAURANT ( RES_NO,FILTER_NO, REGION_NO,  RES_NAME, RES_PHONE, RES_TIME, RES_PARKING, RES_ROAD_ADDRESS) 
VALUES ( restaurant_seq.nextval, 307, 902,'중앙떡볶이', '053-424-7692', '매일 11:20-20:00 목요일 휴무 셋째주', '단체석, 주차, 포장, 예약, 무선 인터넷, 남/녀 화장실 구분', '대구 중구 동성로2길 81');

--분식, 인천
INSERT INTO RESTAURANT ( RES_NO, FILTER_NO, REGION_NO, RES_NAME, RES_PHONE, RES_TIME, RES_PARKING, RES_ROAD_ADDRESS) 
VALUES ( restaurant_seq.nextval,307, 903, '잉글랜드왕돈까스', '032-772-7266', '매일 11:30-21:00', '단체석, 주차, 포장, 예약, 무선 인터넷, 남/녀 화장실 구분', '인천 중구 우현로90번길 7 혜성빌딩 2층');

--분식, 경기
INSERT INTO RESTAURANT ( RES_NO, FILTER_NO, REGION_NO, RES_NAME, RES_PHONE, RES_TIME, RES_PARKING, RES_ROAD_ADDRESS) 
VALUES ( restaurant_seq.nextval, 307, 908,'묘향만두', '02-444-3515', '매일 09:30-21:30', '단체석, 주차, 포장, 예약, 무선 인터넷, 남/녀 화장실 구분', '경기 구리시 아차산로 63');

INSERT INTO RESTAURANT ( RES_NO,FILTER_NO, REGION_NO,  RES_NAME, RES_PHONE, RES_TIME, RES_PARKING, RES_ROAD_ADDRESS) 
VALUES ( restaurant_seq.nextval,307, 908, '보영만두 북문본점', '031-242-9076', '매일 10:00-01:00', '단체석, 주차, 포장, 예약, 무선 인터넷, 남/녀 화장실 구분', '경기 수원시 장안구 팔달로 271');





--기타, 서울
INSERT INTO RESTAURANT ( RES_NO,FILTER_NO, REGION_NO,  RES_NAME, RES_PHONE, RES_TIME, RES_PARKING, RES_ROAD_ADDRESS) 
VALUES ( restaurant_seq.nextval, 308, 900,'감성타코 강남역점', '02-565-8830', '매일 11:30-22:00', '단체석, 주차, 포장, 예약, 무선 인터넷, 남/녀 화장실 구분', '강남역 11번출구 앞 글래스타워 지하1층');

INSERT INTO RESTAURANT ( RES_NO, FILTER_NO, REGION_NO, RES_NAME, RES_PHONE, RES_TIME, RES_PARKING, RES_ROAD_ADDRESS) 
VALUES ( restaurant_seq.nextval, 308, 900,'바토스 이태원점', '02-797-8226', '매일 11:30 - 22:00', '단체석, 주차, 포장, 예약, 무선 인터넷, 남/녀 화장실 구분', '서울 용산구 이태원로15길 1 2층');

--기타, 대구
INSERT INTO RESTAURANT ( RES_NO, FILTER_NO, REGION_NO, RES_NAME, RES_PHONE, RES_TIME, RES_PARKING, RES_ROAD_ADDRESS) 
VALUES ( restaurant_seq.nextval,308, 902, 'VASCO 본점', '0507-1400-9354', '매일 12:00 - 21:30', '단체석, 주차, 포장, 예약, 무선 인터넷, 남/녀 화장실 구분', '대구 중구 동성로4길 100 vasco');

--기타, 인천
INSERT INTO RESTAURANT ( RES_NO, FILTER_NO, REGION_NO, RES_NAME, RES_PHONE, RES_TIME, RES_PARKING, RES_ROAD_ADDRESS) 
VALUES ( restaurant_seq.nextval, 308, 903,'원조신포닭강정', '032-762-5853', '매일 10:30 -21:00', '단체석, 주차, 포장, 예약, 무선 인터넷, 남/녀 화장실 구분', '인천 중구 우현로49번길 3');

--기타, 광주
INSERT INTO RESTAURANT ( RES_NO,FILTER_NO, REGION_NO,  RES_NAME, RES_PHONE, RES_TIME, RES_PARKING, RES_ROAD_ADDRESS) 
VALUES ( restaurant_seq.nextval, 308, 904,'영미오리탕', '062-527-0248', '매일 09:00 -01:00', '단체석, 주차, 포장, 예약, 무선 인터넷, 남/녀 화장실 구분', '광주 북구 경양로 126');

--기타, 경기
INSERT INTO RESTAURANT ( RES_NO,FILTER_NO, REGION_NO,  RES_NAME, RES_PHONE, RES_TIME, RES_PARKING, RES_ROAD_ADDRESS) 
VALUES ( restaurant_seq.nextval, 308, 908,'낙원타코 롯데몰수원점', '031-8066-1890', '매일 10:30 -22:00', '단체석, 주차, 포장, 예약, 무선 인터넷, 남/녀 화장실 구분', '경기 수원시 권선구 세화로 134 롯데몰수원점 3층');

INSERT INTO RESTAURANT ( RES_NO,FILTER_NO, REGION_NO,  RES_NAME, RES_PHONE, RES_TIME, RES_PARKING, RES_ROAD_ADDRESS) 
VALUES ( restaurant_seq.nextval,308, 908, '온더보더 스타필드하남점', '031-8072-8682', '매일 10:00 -22:00', '단체석, 주차, 포장, 예약, 무선 인터넷, 남/녀 화장실 구분', '경기 하남시 미사대로 750 스타필드 하남 1층');

commit;
--rollback;




 --기존 테이블,시퀀스 삭제

DROP TABLE USERS CASCADE CONSTRAINTS;
DROP SEQUENCE USERS_SEQ;
DROP TABLE ROOM CASCADE CONSTRAINTS;
DROP SEQUENCE ROOM_SEQ;
DROP TABLE BOARDS CASCADE CONSTRAINTS;
DROP SEQUENCE BOARDS_SEQ;
DROP TABLE FACILITY CASCADE CONSTRAINTS;
DROP SEQUENCE FACILITY_SEQ;
DROP TABLE FILTER CASCADE CONSTRAINTS;
DROP SEQUENCE FILTER_SEQ;
DROP TABLE RESTAURANT CASCADE CONSTRAINTS;
DROP SEQUENCE RESTAURANT_SEQ;
DROP TABLE COMMENTS CASCADE CONSTRAINTS;
DROP SEQUENCE COMMENTS_SEQ;
DROP TABLE BOOKING CASCADE CONSTRAINTS;
DROP SEQUENCE BOOKING_SEQ;
DROP TABLE BOOKMARK CASCADE CONSTRAINTS;
DROP SEQUENCE BOOKMARK_SEQ;
DROP TABLE ROOM_IMG CASCADE CONSTRAINTS;
DROP SEQUENCE ROOM_IMG_SEQ;
DROP TABLE ROOM_FACILITY_MAPPING CASCADE CONSTRAINTS;
DROP TABLE REVIEW CASCADE CONSTRAINTS;
DROP SEQUENCE REVIEW_SEQ;

-- 테이블 순서는 관계를 고려하여 한 번에 실행해도 에러가 발생하지 않게 정렬되었습니다.





-- USERS Table Create SQL
CREATE TABLE USERS 
   (	
    USER_NO NUMBER NOT NULL, 
	USER_ID VARCHAR2(20) NOT NULL, 
	USER_PW VARCHAR2(20) NOT NULL , 
	USER_NAME VARCHAR2(20) NOT NULL, 
	USER_GENDER VARCHAR2(1) CHECK (USER_GENDER IN('M','F') ) , 
	USER_NICK VARCHAR2(20) NOT NULL, 
	USER_BIRTHDATE VARCHAR2(20) NOT NULL , 
	USER_EMAIL VARCHAR2(50) NOT NULL , 
	USER_PHONE VARCHAR2(20) NOT NULL , 
	USER_GRADE NUMBER DEFAULT 1, 
    CONSTRAINT UK_EMAIL UNIQUE (USER_EMAIL),
    CONSTRAINT PK_USERS PRIMARY KEY (USER_NO)
);
CREATE SEQUENCE USERS_SEQ
START WITH 1
INCREMENT BY 1;
/
-- USERS Table Create SQL
CREATE TABLE ROOM
(
    ROOMNO                 NUMBER            NOT NULL, 
    USERNO                 NUMBER            NOT NULL, 
    ROOMNAME               VARCHAR2(320)     NOT NULL, 
    ROOMGUESTS             NUMBER            NOT NULL, 
    ROOMPRICE              NUMBER            NOT NULL, 
    ROOMBEDROOM            NUMBER            NOT NULL, 
    ROOMBED                NUMBER            NOT NULL, 
    ROOMADMINCHECK         VARCHAR2(1)       NOT NULL, 
    ROOMDESC               VARCHAR2(4000)    NOT NULL, 
    ROOMBATHROOM           NUMBER            NOT NULL, 
    ROOMTYPE               VARCHAR2(20)      NOT NULL, 
    ROOMROADADDRESS        VARCHAR2(200)     NOT NULL, 
    ROOMDETAILEDADDRESS    VARCHAR2(200)     NOT NULL, 
    CONSTRAINT PK_ROOM PRIMARY KEY (ROOMNO), 
    CONSTRAINT CK_ROOM_ADMIN_CHECK CHECK ( ROOMADMINCHECK IN('Y' , 'N', 'W'))   
)
/

CREATE SEQUENCE ROOM_SEQ
START WITH 1
INCREMENT BY 1;
/
ALTER TABLE ROOM
    ADD CONSTRAINT FK_ROOM_USERNO_USERS_USER_NO FOREIGN KEY (USERNO)
        REFERENCES USERS (USER_NO) ON DELETE CASCADE
/


-- USERS Table Create SQL
CREATE TABLE BOARDS
   (	
    BOARD_NO NUMBER NOT NULL, 
	BOARD_TITLE VARCHAR2(100 BYTE) NOT NULL , 
	BOARD_CONTENT VARCHAR2(4000 BYTE) NOT NULL , 
	BOARD_CREATE_DATE DATE DEFAULT sysdate, 
	BOARD_TYPE NUMBER DEFAULT 1, 
	USER_NO NUMBER NOT NULL , 
	 CONSTRAINT PK_BOARDS PRIMARY KEY (BOARD_NO),
     CONSTRAINT FK_USERS FOREIGN KEY (USER_NO) REFERENCES USERS(USER_NO) on delete cascade
);
CREATE SEQUENCE BOARDS_SEQ;



-- USERS Table Create SQL
CREATE TABLE FACILITY
(
    FACILITY_NO      NUMBER          NOT NULL, 
    FACILITY_NAME    VARCHAR2(50)    NOT NULL, 
    CONSTRAINT PK_FACILITY PRIMARY KEY (FACILITY_NO)
)
/

CREATE SEQUENCE FACILITY_SEQ
START WITH 1
INCREMENT BY 1;
/

--DROP TRIGGER FACILITY_AI_TRG;
/

--DROP SEQUENCE FACILITY_SEQ;
/


-- USERS Table Create SQL
CREATE TABLE FILTER
(
    FILTER_NO      NUMBER          NOT NULL, 
    FILTER_NAME    VARCHAR2(20)    NULL, 
    CONSTRAINT PK_FILTER PRIMARY KEY (FILTER_NO)
)
/

CREATE SEQUENCE FILTER_SEQ
START WITH 1
INCREMENT BY 1;
/


--DROP TRIGGER FILTER_AI_TRG;
/

--DROP SEQUENCE FILTER_SEQ;
/

-- USERS Table Create SQL
CREATE TABLE RESTAURANT
(
    RES_NO                  NUMBER           NOT NULL, 
    FILTER_NO              NUMBER           NULL, 
    REGION_NO               NUMBER           NULL, 
    RES_NAME                VARCHAR2(50)     NULL, 
    RES_PHONE               VARCHAR2(20)     NULL, 
    RES_TIME                VARCHAR2(300)    NULL, 
    RES_PARKING             VARCHAR2(100)      NULL, 
    RES_ROAD_ADDRESS        VARCHAR2(200)    NULL,  
    CONSTRAINT PK_RESTAURANT PRIMARY KEY (RES_NO)
);
/

CREATE SEQUENCE RESTAURANT_SEQ
START WITH 1
INCREMENT BY 1;
/


--DROP TRIGGER RESTAURANT_AI_TRG;
/

--DROP SEQUENCE RESTAURANT_SEQ;
/


-- USERS Table Create SQL
CREATE TABLE COMMENTS
(
    COMMENT_NO             NUMBER           NOT NULL, 
    COMMENT_CREATE_DATE    DATE             NOT NULL, 
    COMMENT_CONTENT        VARCHAR2(500)    NOT NULL, 
    BOARD_NO               NUMBER           NOT NULL, 
    USER_NO                NUMBER           NOT NULL, 
    CONSTRAINT PK_COMMENT PRIMARY KEY (COMMENT_NO)
)
/
CREATE SEQUENCE COMMENTS_SEQ
START WITH 1
INCREMENT BY 1;
/

ALTER TABLE COMMENTS
    ADD CONSTRAINT FK_COMMENT_BOARD_NO_BOARDS_BOA FOREIGN KEY (BOARD_NO)
        REFERENCES BOARDS (BOARD_NO) ON DELETE CASCADE
/

ALTER TABLE COMMENTS
    ADD CONSTRAINT FK_COMMENT_USER_NO_USERS_USER_ FOREIGN KEY (USER_NO)
        REFERENCES USERS (USER_NO) ON DELETE CASCADE
/


-- USERS Table Create SQL
CREATE TABLE BOOKING
(
    BOOKING_NO           NUMBER           NOT NULL, 
    USER_NO              NUMBER           NOT NULL, 
    BOOKING_GUEST        NUMBER(2)        NOT NULL, 
    BOOKING_CHECKIN      VARCHAR2(20)     NOT NULL, 
    BOOKING_CHECKOUT     VARCHAR2(20)     NOT NULL, 
    BOOKING_STATUS       VARCHAR2(1)      NOT NULL, 
    BOOKING_MESSAGE      VARCHAR2(200)    NOT NULL, 
    ROOM_NO              NUMBER           NOT NULL,
    BOOKING_USERNAME     VARCHAR2(20)     NULL, 
    BOOKING_USERPHONE    VARCHAR2(20)     NULL, 
    BOOKING_USEREMAIL    VARCHAR2(50)     NULL, 
    CONSTRAINT PK_BOOKING PRIMARY KEY (BOOKING_NO)
)
/

CREATE SEQUENCE BOOKING_SEQ
START WITH 1
INCREMENT BY 1;
/

ALTER TABLE BOOKING
    ADD CONSTRAINT FK_BOOKING_USER_NO_USERS_USER_ FOREIGN KEY (USER_NO)
        REFERENCES USERS (USER_NO) ON DELETE CASCADE
/

ALTER TABLE BOOKING
    ADD CONSTRAINT FK_BOOKING_ROOM_NO_ROOM_ROOMNO FOREIGN KEY (ROOM_NO)
        REFERENCES ROOM (ROOMNO) ON DELETE CASCADE
/



-- USERS Table Create SQL
CREATE TABLE BOOKMARK
(
    BOOKMARK_NO    NUMBER    NOT NULL, 
    USER_NO        NUMBER    NOT NULL, 
    ROOM_NO        NUMBER    NOT NULL, 
    CONSTRAINT PK_BOOKMARK PRIMARY KEY (BOOKMARK_NO)
)
/
CREATE SEQUENCE BOOKMARK_SEQ
START WITH 1
INCREMENT BY 1;
/
ALTER TABLE BOOKMARK
    ADD CONSTRAINT FK_BOOKMARK_USER_NO_USERS_USER FOREIGN KEY (USER_NO)
        REFERENCES USERS (USER_NO) ON DELETE CASCADE
/

ALTER TABLE BOOKMARK
    ADD CONSTRAINT FK_BOOKMARK_ROOM_NO_ROOM_ROOMN FOREIGN KEY (ROOM_NO)
        REFERENCES ROOM (ROOMNO) ON DELETE CASCADE
/


-- USERS Table Create SQL
CREATE TABLE ROOM_IMG
(
    ROOM_IMG_NO          NUMBER          NOT NULL, 
    ROOM_NO              NUMBER          NULL, 
    ROOM_IMG_FILENAME    VARCHAR2(50)    NULL, 
    CONSTRAINT PK_ROOM_IMG PRIMARY KEY (ROOM_IMG_NO)
)
/

CREATE SEQUENCE ROOM_IMG_SEQ
START WITH 1
INCREMENT BY 1;
/

--DROP TRIGGER ROOM_IMG_AI_TRG;
/

--DROP SEQUENCE ROOM_IMG_SEQ;
/
ALTER TABLE ROOM_IMG
    ADD CONSTRAINT FK_ROOM_IMG_ROOM_NO_ROOM_ROOMN FOREIGN KEY (ROOM_NO)
        REFERENCES ROOM (ROOMNO) ON DELETE CASCADE
/


-- USERS Table Create SQL
CREATE TABLE ROOM_FACILITY_MAPPING
(
    ROOM_NO        NUMBER    NOT NULL, 
    FACILITY_NO    NUMBER    NOT NULL, 
    CONSTRAINT PK_ROOM_FACILITY_MAPPING PRIMARY KEY (ROOM_NO, FACILITY_NO)
)
/

ALTER TABLE ROOM_FACILITY_MAPPING
    ADD CONSTRAINT FK_ROOM_FACILITY_MAPPING_FACIL FOREIGN KEY (FACILITY_NO)
        REFERENCES FACILITY (FACILITY_NO) ON DELETE CASCADE
/

ALTER TABLE ROOM_FACILITY_MAPPING
    ADD CONSTRAINT FK_ROOM_FACILITY_MAPPING_ROOM_ FOREIGN KEY (ROOM_NO)
        REFERENCES ROOM (ROOMNO) ON DELETE CASCADE
/


-- USERS Table Create SQL
CREATE TABLE REVIEW
(
    RE_NO         NUMBER           NOT NULL, 
    USER_NO       NUMBER           NULL, 
    ROOM_NO       NUMBER           NULL, 
    RE_CONTENT    VARCHAR2(500)    NULL, 
    RE_DATE       DATE             NULL, 
    RE_STAR       VARCHAR2(20)     NULL, 
    CONSTRAINT PK_REVIEW PRIMARY KEY (RE_NO)
)
/

CREATE SEQUENCE REVIEW_SEQ
START WITH 1
INCREMENT BY 1;
/

--DROP TRIGGER REVIEW_AI_TRG;
/

--DROP SEQUENCE REVIEW_SEQ;
/

ALTER TABLE REVIEW
    ADD CONSTRAINT FK_REVIEW_USER_NO_USERS_USER_N FOREIGN KEY (USER_NO)
        REFERENCES USERS (USER_NO) ON DELETE CASCADE
/

ALTER TABLE REVIEW
    ADD CONSTRAINT FK_REVIEW_ROOM_NO_ROOM_ROOMNO FOREIGN KEY (ROOM_NO)
        REFERENCES ROOM (ROOMNO) ON DELETE CASCADE
/

DROP TABLE restaurant  CASCADE CONSTRAINTS;
CREATE TABLE RESTAURANT
(
    RES_NO                  NUMBER           NOT NULL, 
    FILTER_NO              NUMBER           NULL, 
    REGION_NO               NUMBER           NULL, 
    RES_NAME                VARCHAR2(50)     NULL, 
    RES_PHONE               VARCHAR2(20)     NULL, 
    RES_TIME                VARCHAR2(300)    NULL, 
    RES_PARKING             VARCHAR2(100)      NULL, 
    RES_ROAD_ADDRESS        VARCHAR2(200)    NULL,  
    CONSTRAINT PK_RESTAURANT PRIMARY KEY (RES_NO)
);
DROP SEQUENCE RESTAURANT_seq;
CREATE SEQUENCE RESTAURANT_seq;


/**
-- USERS Table Create SQL
CREATE TABLE RES_FILTER_MAPPING
(
    FILTER_NO    NUMBER    NOT NULL, 
    RES_NO       NUMBER    NOT NULL, 
    CONSTRAINT PK_RES_FILTER_MAPPING PRIMARY KEY (FILTER_NO, RES_NO)
)
/

ALTER TABLE RES_FILTER_MAPPING
    ADD CONSTRAINT FK_RES_FILTER_MAPPING_FILTER_N FOREIGN KEY (FILTER_NO)
        REFERENCES FILTER (FILTER_NO)
/

ALTER TABLE RES_FILTER_MAPPING
    ADD CONSTRAINT FK_RES_FILTER_MAPPING_RES_NO_R FOREIGN KEY (RES_NO)
        REFERENCES RESTAURANT (RES_NO)
/

**/









---------------------------------------------------------------------------------------------데이터삽입
----------- users users users users users users users users users users users users users users users users users users users users -------------------------------------


insert into users(user_no, user_id, user_pw, user_name, user_gender, user_nick, user_birthdate, user_email, user_phone, user_grade) values(users_seq.nextval,'test1','test1','test1','M','테스트1','19900101','test1@gmail.com','01000000000',1);
insert into users(user_no, user_id, user_pw, user_name, user_gender, user_nick, user_birthdate, user_email, user_phone, user_grade) values(users_seq.nextval,'test2','test2','test2','M','테스트2','19900101','test2@gmail.com','01000000000',2);
insert into users(user_no, user_id, user_pw, user_name, user_gender, user_nick, user_birthdate, user_email, user_phone, user_grade) values(users_seq.nextval,'test3','test3','test3','M','테스트3','19900101','test3@gmail.com','01000000000',0);
insert into users(user_no, user_id, user_pw, user_name, user_gender, user_nick, user_birthdate, user_email, user_phone, user_grade) values(users_seq.nextval,'test4','test4','test4','M','테스트4','19900101','test4@gmail.com','01000000000',1);
insert into users(user_no, user_id, user_pw, user_name, user_gender, user_nick, user_birthdate, user_email, user_phone, user_grade) values(users_seq.nextval,'test5','test5','test5','M','테스트5','19900101','test5@gmail.com','01000000000',2);
insert into users(user_no, user_id, user_pw, user_name, user_gender, user_nick, user_birthdate, user_email, user_phone, user_grade) values(users_seq.nextval,'test6','test6','test6','M','테스트6','19900101','test6@gmail.com','01000000000',0);
insert into users(user_no, user_id, user_pw, user_name, user_gender, user_nick, user_birthdate, user_email, user_phone, user_grade) values(users_seq.nextval,'test7','test7','test7','M','테스트7','19900101','test7@gmail.com','01000000000',1);
insert into users(user_no, user_id, user_pw, user_name, user_gender, user_nick, user_birthdate, user_email, user_phone, user_grade) values(users_seq.nextval,'test8','test8','test8','M','테스트8','19900101','test8@gmail.com','01000000000',2);
insert into users(user_no, user_id, user_pw, user_name, user_gender, user_nick, user_birthdate, user_email, user_phone, user_grade) values(users_seq.nextval,'test9','test9','test9','M','테스트9','19900101','test9@gmail.com','01000000000',0);
insert into users(user_no, user_id, user_pw, user_name, user_gender, user_nick, user_birthdate, user_email, user_phone, user_grade) values(users_seq.nextval,'test10','test10','test10','M','테스트10','19900101','test10@gmail.com','01000000000',1);
insert into users(user_no, user_id, user_pw, user_name, user_gender, user_nick, user_birthdate, user_email, user_phone, user_grade) values(users_seq.nextval,'test11','test11','test11','M','테스트11','19900101','test11@gmail.com','01000000000',2);
insert into users(user_no, user_id, user_pw, user_name, user_gender, user_nick, user_birthdate, user_email, user_phone, user_grade) values(users_seq.nextval,'test12','test12','test12','M','테스트12','19900101','test12@gmail.com','01000000000',0);
insert into users(user_no, user_id, user_pw, user_name, user_gender, user_nick, user_birthdate, user_email, user_phone, user_grade) values(users_seq.nextval,'test13','test13','test13','M','테스트13','19900101','test13@gmail.com','01000000000',1);
insert into users(user_no, user_id, user_pw, user_name, user_gender, user_nick, user_birthdate, user_email, user_phone, user_grade) values(users_seq.nextval,'test14','test14','test14','M','테스트14','19900101','test14@gmail.com','01000000000',2);
insert into users(user_no, user_id, user_pw, user_name, user_gender, user_nick, user_birthdate, user_email, user_phone, user_grade) values(users_seq.nextval,'test15','test15','test15','M','테스트15','19900101','test15@gmail.com','01000000000',0);
insert into users(user_no, user_id, user_pw, user_name, user_gender, user_nick, user_birthdate, user_email, user_phone, user_grade) values(users_seq.nextval,'test16','test16','test16','M','테스트16','19900101','test16@gmail.com','01000000000',1);
insert into users(user_no, user_id, user_pw, user_name, user_gender, user_nick, user_birthdate, user_email, user_phone, user_grade) values(users_seq.nextval,'test17','test17','test17','M','테스트17','19900101','test17@gmail.com','01000000000',2);
insert into users(user_no, user_id, user_pw, user_name, user_gender, user_nick, user_birthdate, user_email, user_phone, user_grade) values(users_seq.nextval,'test18','test18','test18','M','테스트18','19900101','test18@gmail.com','01000000000',0);
insert into users(user_no, user_id, user_pw, user_name, user_gender, user_nick, user_birthdate, user_email, user_phone, user_grade) values(users_seq.nextval,'test19','test19','test19','M','테스트19','19900101','test19@gmail.com','01000000000',1);
insert into users(user_no, user_id, user_pw, user_name, user_gender, user_nick, user_birthdate, user_email, user_phone, user_grade) values(users_seq.nextval,'test20','test20','test20','M','테스트20','19900101','test20@gmail.com','01000000000',2);
insert into users(user_no, user_id, user_pw, user_name, user_gender, user_nick, user_birthdate, user_email, user_phone, user_grade) values(users_seq.nextval,'test21','test21','test21','M','테스트21','19900101','test21@gmail.com','01000000000',0);
insert into users(user_no, user_id, user_pw, user_name, user_gender, user_nick, user_birthdate, user_email, user_phone, user_grade) values(users_seq.nextval,'test22','test22','test22','M','테스트22','19900101','test22@gmail.com','01000000000',1);
insert into users(user_no, user_id, user_pw, user_name, user_gender, user_nick, user_birthdate, user_email, user_phone, user_grade) values(users_seq.nextval,'test23','test23','test23','M','테스트23','19900101','test23@gmail.com','01000000000',2);
insert into users(user_no, user_id, user_pw, user_name, user_gender, user_nick, user_birthdate, user_email, user_phone, user_grade) values(users_seq.nextval,'test24','test24','test24','M','테스트24','19900101','test24@gmail.com','01000000000',0);
insert into users(user_no, user_id, user_pw, user_name, user_gender, user_nick, user_birthdate, user_email, user_phone, user_grade) values(users_seq.nextval,'test25','test25','test25','M','테스트25','19900101','test25@gmail.com','01000000000',1);
insert into users(user_no, user_id, user_pw, user_name, user_gender, user_nick, user_birthdate, user_email, user_phone, user_grade) values(users_seq.nextval,'test26','test26','test26','M','테스트26','19900101','test26@gmail.com','01000000000',2);
insert into users(user_no, user_id, user_pw, user_name, user_gender, user_nick, user_birthdate, user_email, user_phone, user_grade) values(users_seq.nextval,'test27','test27','test27','M','테스트27','19900101','test27@gmail.com','01000000000',0);
insert into users(user_no, user_id, user_pw, user_name, user_gender, user_nick, user_birthdate, user_email, user_phone, user_grade) values(users_seq.nextval,'test28','test28','test28','M','테스트28','19900101','test28@gmail.com','01000000000',1);
insert into users(user_no, user_id, user_pw, user_name, user_gender, user_nick, user_birthdate, user_email, user_phone, user_grade) values(users_seq.nextval,'test29','test29','test29','M','테스트29','19900101','test29@gmail.com','01000000000',2);
insert into users(user_no, user_id, user_pw, user_name, user_gender, user_nick, user_birthdate, user_email, user_phone, user_grade) values(users_seq.nextval,'test30','test30','test30','M','테스트30','19900101','test30@gmail.com','01000000000',0);
insert into users(user_no, user_id, user_pw, user_name, user_gender, user_nick, user_birthdate, user_email, user_phone, user_grade) values(users_seq.nextval,'test31','test31','test31','M','테스트31','19900101','test31@gmail.com','01000000000',1);
insert into users(user_no, user_id, user_pw, user_name, user_gender, user_nick, user_birthdate, user_email, user_phone, user_grade) values(users_seq.nextval,'test32','test32','test32','M','테스트32','19900101','test32@gmail.com','01000000000',2);
insert into users(user_no, user_id, user_pw, user_name, user_gender, user_nick, user_birthdate, user_email, user_phone, user_grade) values(users_seq.nextval,'test33','test33','test33','M','테스트33','19900101','test33@gmail.com','01000000000',0);
insert into users(user_no, user_id, user_pw, user_name, user_gender, user_nick, user_birthdate, user_email, user_phone, user_grade) values(users_seq.nextval,'test34','test34','test34','M','테스트34','19900101','test34@gmail.com','01000000000',1);
insert into users(user_no, user_id, user_pw, user_name, user_gender, user_nick, user_birthdate, user_email, user_phone, user_grade) values(users_seq.nextval,'test35','test35','test35','M','테스트35','19900101','test35@gmail.com','01000000000',2);
insert into users(user_no, user_id, user_pw, user_name, user_gender, user_nick, user_birthdate, user_email, user_phone, user_grade) values(users_seq.nextval,'test36','test36','test36','M','테스트36','19900101','test36@gmail.com','01000000000',0);
insert into users(user_no, user_id, user_pw, user_name, user_gender, user_nick, user_birthdate, user_email, user_phone, user_grade) values(users_seq.nextval,'test37','test37','test37','M','테스트37','19900101','test37@gmail.com','01000000000',1);
insert into users(user_no, user_id, user_pw, user_name, user_gender, user_nick, user_birthdate, user_email, user_phone, user_grade) values(users_seq.nextval,'test38','test38','test38','M','테스트38','19900101','test38@gmail.com','01000000000',2);
insert into users(user_no, user_id, user_pw, user_name, user_gender, user_nick, user_birthdate, user_email, user_phone, user_grade) values(users_seq.nextval,'test39','test39','test39','M','테스트39','19900101','test39@gmail.com','01000000000',0);
insert into users(user_no, user_id, user_pw, user_name, user_gender, user_nick, user_birthdate, user_email, user_phone, user_grade) values(users_seq.nextval,'test40','test40','test40','M','테스트40','19900101','test40@gmail.com','01000000000',1);
insert into users(user_no, user_id, user_pw, user_name, user_gender, user_nick, user_birthdate, user_email, user_phone, user_grade) values(users_seq.nextval,'test41','test41','test41','M','테스트41','19900101','test41@gmail.com','01000000000',2);
insert into users(user_no, user_id, user_pw, user_name, user_gender, user_nick, user_birthdate, user_email, user_phone, user_grade) values(users_seq.nextval,'test42','test42','test42','M','테스트42','19900101','test42@gmail.com','01000000000',0);
insert into users(user_no, user_id, user_pw, user_name, user_gender, user_nick, user_birthdate, user_email, user_phone, user_grade) values(users_seq.nextval,'test43','test43','test43','M','테스트43','19900101','test43@gmail.com','01000000000',1);
insert into users(user_no, user_id, user_pw, user_name, user_gender, user_nick, user_birthdate, user_email, user_phone, user_grade) values(users_seq.nextval,'test44','test44','test44','M','테스트44','19900101','test44@gmail.com','01000000000',2);
insert into users(user_no, user_id, user_pw, user_name, user_gender, user_nick, user_birthdate, user_email, user_phone, user_grade) values(users_seq.nextval,'test45','test45','test45','M','테스트45','19900101','test45@gmail.com','01000000000',0);
insert into users(user_no, user_id, user_pw, user_name, user_gender, user_nick, user_birthdate, user_email, user_phone, user_grade) values(users_seq.nextval,'test46','test46','test46','M','테스트46','19900101','test46@gmail.com','01000000000',1);
insert into users(user_no, user_id, user_pw, user_name, user_gender, user_nick, user_birthdate, user_email, user_phone, user_grade) values(users_seq.nextval,'test47','test47','test47','M','테스트47','19900101','test47@gmail.com','01000000000',2);
insert into users(user_no, user_id, user_pw, user_name, user_gender, user_nick, user_birthdate, user_email, user_phone, user_grade) values(users_seq.nextval,'test48','test48','test48','M','테스트48','19900101','test48@gmail.com','01000000000',0);
insert into users(user_no, user_id, user_pw, user_name, user_gender, user_nick, user_birthdate, user_email, user_phone, user_grade) values(users_seq.nextval,'test49','test49','test49','M','테스트49','19900101','test49@gmail.com','01000000000',1);
insert into users(user_no, user_id, user_pw, user_name, user_gender, user_nick, user_birthdate, user_email, user_phone, user_grade) values(users_seq.nextval,'test50','test50','test50','M','테스트50','19900101','test50@gmail.com','01000000000',2);
insert into users(user_no, user_id, user_pw, user_name, user_gender, user_nick, user_birthdate, user_email, user_phone, user_grade) values(users_seq.nextval,'test51','test51','test51','M','테스트51','19900101','test51@gmail.com','01000000000',0);
insert into users(user_no, user_id, user_pw, user_name, user_gender, user_nick, user_birthdate, user_email, user_phone, user_grade) values(users_seq.nextval,'test52','test52','test52','M','테스트52','19900101','test52@gmail.com','01000000000',1);
insert into users(user_no, user_id, user_pw, user_name, user_gender, user_nick, user_birthdate, user_email, user_phone, user_grade) values(users_seq.nextval,'test53','test53','test53','M','테스트53','19900101','test53@gmail.com','01000000000',2);
insert into users(user_no, user_id, user_pw, user_name, user_gender, user_nick, user_birthdate, user_email, user_phone, user_grade) values(users_seq.nextval,'test54','test54','test54','M','테스트54','19900101','test54@gmail.com','01000000000',0);
insert into users(user_no, user_id, user_pw, user_name, user_gender, user_nick, user_birthdate, user_email, user_phone, user_grade) values(users_seq.nextval,'test55','test55','test55','M','테스트55','19900101','test55@gmail.com','01000000000',1);
insert into users(user_no, user_id, user_pw, user_name, user_gender, user_nick, user_birthdate, user_email, user_phone, user_grade) values(users_seq.nextval,'test56','test56','test56','M','테스트56','19900101','test56@gmail.com','01000000000',2);
insert into users(user_no, user_id, user_pw, user_name, user_gender, user_nick, user_birthdate, user_email, user_phone, user_grade) values(users_seq.nextval,'test57','test57','test57','M','테스트57','19900101','test57@gmail.com','01000000000',0);
insert into users(user_no, user_id, user_pw, user_name, user_gender, user_nick, user_birthdate, user_email, user_phone, user_grade) values(users_seq.nextval,'test58','test58','test58','M','테스트58','19900101','test58@gmail.com','01000000000',1);
insert into users(user_no, user_id, user_pw, user_name, user_gender, user_nick, user_birthdate, user_email, user_phone, user_grade) values(users_seq.nextval,'test59','test59','test59','M','테스트59','19900101','test59@gmail.com','01000000000',2);
insert into users(user_no, user_id, user_pw, user_name, user_gender, user_nick, user_birthdate, user_email, user_phone, user_grade) values(users_seq.nextval,'test60','test60','test60','M','테스트60','19900101','test60@gmail.com','01000000000',0);
insert into users(user_no, user_id, user_pw, user_name, user_gender, user_nick, user_birthdate, user_email, user_phone, user_grade) values(users_seq.nextval,'test61','test61','test61','M','테스트61','19900101','test61@gmail.com','01000000000',1);
insert into users(user_no, user_id, user_pw, user_name, user_gender, user_nick, user_birthdate, user_email, user_phone, user_grade) values(users_seq.nextval,'test62','test62','test62','M','테스트62','19900101','test62@gmail.com','01000000000',2);
insert into users(user_no, user_id, user_pw, user_name, user_gender, user_nick, user_birthdate, user_email, user_phone, user_grade) values(users_seq.nextval,'test63','test63','test63','M','테스트63','19900101','test63@gmail.com','01000000000',0);
insert into users(user_no, user_id, user_pw, user_name, user_gender, user_nick, user_birthdate, user_email, user_phone, user_grade) values(users_seq.nextval,'test64','test64','test64','M','테스트64','19900101','test64@gmail.com','01000000000',1);
insert into users(user_no, user_id, user_pw, user_name, user_gender, user_nick, user_birthdate, user_email, user_phone, user_grade) values(users_seq.nextval,'test65','test65','test65','M','테스트65','19900101','test65@gmail.com','01000000000',2);
insert into users(user_no, user_id, user_pw, user_name, user_gender, user_nick, user_birthdate, user_email, user_phone, user_grade) values(users_seq.nextval,'test66','test66','test66','M','테스트66','19900101','test66@gmail.com','01000000000',0);
insert into users(user_no, user_id, user_pw, user_name, user_gender, user_nick, user_birthdate, user_email, user_phone, user_grade) values(users_seq.nextval,'test67','test67','test67','M','테스트67','19900101','test67@gmail.com','01000000000',1);
insert into users(user_no, user_id, user_pw, user_name, user_gender, user_nick, user_birthdate, user_email, user_phone, user_grade) values(users_seq.nextval,'test68','test68','test68','M','테스트68','19900101','test68@gmail.com','01000000000',2);
insert into users(user_no, user_id, user_pw, user_name, user_gender, user_nick, user_birthdate, user_email, user_phone, user_grade) values(users_seq.nextval,'test69','test69','test69','M','테스트69','19900101','test69@gmail.com','01000000000',0);
insert into users(user_no, user_id, user_pw, user_name, user_gender, user_nick, user_birthdate, user_email, user_phone, user_grade) values(users_seq.nextval,'test70','test70','test70','M','테스트70','19900101','test70@gmail.com','01000000000',1);
insert into users(user_no, user_id, user_pw, user_name, user_gender, user_nick, user_birthdate, user_email, user_phone, user_grade) values(users_seq.nextval,'test71','test71','test71','M','테스트71','19900101','test71@gmail.com','01000000000',2);
insert into users(user_no, user_id, user_pw, user_name, user_gender, user_nick, user_birthdate, user_email, user_phone, user_grade) values(users_seq.nextval,'test72','test72','test72','M','테스트72','19900101','test72@gmail.com','01000000000',0);
insert into users(user_no, user_id, user_pw, user_name, user_gender, user_nick, user_birthdate, user_email, user_phone, user_grade) values(users_seq.nextval,'test73','test73','test73','M','테스트73','19900101','test73@gmail.com','01000000000',1);
insert into users(user_no, user_id, user_pw, user_name, user_gender, user_nick, user_birthdate, user_email, user_phone, user_grade) values(users_seq.nextval,'test74','test74','test74','M','테스트74','19900101','test74@gmail.com','01000000000',2);
insert into users(user_no, user_id, user_pw, user_name, user_gender, user_nick, user_birthdate, user_email, user_phone, user_grade) values(users_seq.nextval,'test75','test75','test75','M','테스트75','19900101','test75@gmail.com','01000000000',0);
insert into users(user_no, user_id, user_pw, user_name, user_gender, user_nick, user_birthdate, user_email, user_phone, user_grade) values(users_seq.nextval,'test76','test76','test76','M','테스트76','19900101','test76@gmail.com','01000000000',1);
insert into users(user_no, user_id, user_pw, user_name, user_gender, user_nick, user_birthdate, user_email, user_phone, user_grade) values(users_seq.nextval,'test77','test77','test77','M','테스트77','19900101','test77@gmail.com','01000000000',2);
insert into users(user_no, user_id, user_pw, user_name, user_gender, user_nick, user_birthdate, user_email, user_phone, user_grade) values(users_seq.nextval,'test78','test78','test78','M','테스트78','19900101','test78@gmail.com','01000000000',0);
insert into users(user_no, user_id, user_pw, user_name, user_gender, user_nick, user_birthdate, user_email, user_phone, user_grade) values(users_seq.nextval,'test79','test79','test79','M','테스트79','19900101','test79@gmail.com','01000000000',1);
insert into users(user_no, user_id, user_pw, user_name, user_gender, user_nick, user_birthdate, user_email, user_phone, user_grade) values(users_seq.nextval,'test80','test80','test80','M','테스트80','19900101','test80@gmail.com','01000000000',2);
insert into users(user_no, user_id, user_pw, user_name, user_gender, user_nick, user_birthdate, user_email, user_phone, user_grade) values(users_seq.nextval,'test81','test81','test81','M','테스트81','19900101','test81@gmail.com','01000000000',0);
insert into users(user_no, user_id, user_pw, user_name, user_gender, user_nick, user_birthdate, user_email, user_phone, user_grade) values(users_seq.nextval,'test82','test82','test82','M','테스트82','19900101','test82@gmail.com','01000000000',1);
insert into users(user_no, user_id, user_pw, user_name, user_gender, user_nick, user_birthdate, user_email, user_phone, user_grade) values(users_seq.nextval,'test83','test83','test83','M','테스트83','19900101','test83@gmail.com','01000000000',2);
insert into users(user_no, user_id, user_pw, user_name, user_gender, user_nick, user_birthdate, user_email, user_phone, user_grade) values(users_seq.nextval,'test84','test84','test84','M','테스트84','19900101','test84@gmail.com','01000000000',0);
insert into users(user_no, user_id, user_pw, user_name, user_gender, user_nick, user_birthdate, user_email, user_phone, user_grade) values(users_seq.nextval,'test85','test85','test85','M','테스트85','19900101','test85@gmail.com','01000000000',1);
insert into users(user_no, user_id, user_pw, user_name, user_gender, user_nick, user_birthdate, user_email, user_phone, user_grade) values(users_seq.nextval,'test86','test86','test86','M','테스트86','19900101','test86@gmail.com','01000000000',2);
insert into users(user_no, user_id, user_pw, user_name, user_gender, user_nick, user_birthdate, user_email, user_phone, user_grade) values(users_seq.nextval,'test87','test87','test87','M','테스트87','19900101','test87@gmail.com','01000000000',0);
insert into users(user_no, user_id, user_pw, user_name, user_gender, user_nick, user_birthdate, user_email, user_phone, user_grade) values(users_seq.nextval,'test88','test88','test88','M','테스트88','19900101','test88@gmail.com','01000000000',1);
insert into users(user_no, user_id, user_pw, user_name, user_gender, user_nick, user_birthdate, user_email, user_phone, user_grade) values(users_seq.nextval,'test89','test89','test89','M','테스트89','19900101','test89@gmail.com','01000000000',2);
insert into users(user_no, user_id, user_pw, user_name, user_gender, user_nick, user_birthdate, user_email, user_phone, user_grade) values(users_seq.nextval,'test90','test90','test90','M','테스트90','19900101','test90@gmail.com','01000000000',0);
insert into users(user_no, user_id, user_pw, user_name, user_gender, user_nick, user_birthdate, user_email, user_phone, user_grade) values(users_seq.nextval,'test91','test91','test91','M','테스트91','19900101','test91@gmail.com','01000000000',1);
insert into users(user_no, user_id, user_pw, user_name, user_gender, user_nick, user_birthdate, user_email, user_phone, user_grade) values(users_seq.nextval,'test92','test92','test92','M','테스트92','19900101','test92@gmail.com','01000000000',2);
insert into users(user_no, user_id, user_pw, user_name, user_gender, user_nick, user_birthdate, user_email, user_phone, user_grade) values(users_seq.nextval,'test93','test93','test93','M','테스트93','19900101','test93@gmail.com','01000000000',0);
insert into users(user_no, user_id, user_pw, user_name, user_gender, user_nick, user_birthdate, user_email, user_phone, user_grade) values(users_seq.nextval,'test94','test94','test94','M','테스트94','19900101','test94@gmail.com','01000000000',1);
insert into users(user_no, user_id, user_pw, user_name, user_gender, user_nick, user_birthdate, user_email, user_phone, user_grade) values(users_seq.nextval,'test95','test95','test95','M','테스트95','19900101','test95@gmail.com','01000000000',2);
insert into users(user_no, user_id, user_pw, user_name, user_gender, user_nick, user_birthdate, user_email, user_phone, user_grade) values(users_seq.nextval,'test96','test96','test96','M','테스트96','19900101','test96@gmail.com','01000000000',0);
insert into users(user_no, user_id, user_pw, user_name, user_gender, user_nick, user_birthdate, user_email, user_phone, user_grade) values(users_seq.nextval,'test97','test97','test97','M','테스트97','19900101','test97@gmail.com','01000000000',1);
insert into users(user_no, user_id, user_pw, user_name, user_gender, user_nick, user_birthdate, user_email, user_phone, user_grade) values(users_seq.nextval,'test98','test98','test98','M','테스트98','19900101','test98@gmail.com','01000000000',2);
insert into users(user_no, user_id, user_pw, user_name, user_gender, user_nick, user_birthdate, user_email, user_phone, user_grade) values(users_seq.nextval,'test99','test99','test99','M','테스트99','19900101','test99@gmail.com','01000000000',0);
insert into users(user_no, user_id, user_pw, user_name, user_gender, user_nick, user_birthdate, user_email, user_phone, user_grade) values(users_seq.nextval,'test100','test100','test100','M','테스트100','19900101','test100@gmail.com','01000000000',1);
insert into users(user_no, user_id, user_pw, user_name, user_gender, user_nick, user_birthdate, user_email, user_phone, user_grade) values(users_seq.nextval,'test101','test101','test101','M','테스트101','19900101','test101@gmail.com','01000000000',2);
insert into users(user_no, user_id, user_pw, user_name, user_gender, user_nick, user_birthdate, user_email, user_phone, user_grade) values(users_seq.nextval,'test102','test102','test102','M','테스트102','19900101','test102@gmail.com','01000000000',0);
insert into users(user_no, user_id, user_pw, user_name, user_gender, user_nick, user_birthdate, user_email, user_phone, user_grade) values(users_seq.nextval,'test103','test103','test103','M','테스트103','19900101','test103@gmail.com','01000000000',1);








----------------------------room room room room room room room room room room room room room room room room room room room room room room room room room room room room room room------------------------


insert into room(roomno, userno, roomname, roomguests, roomprice, roombedroom, roombed, roomadmincheck, roomdesc, roombathroom, roomtype, roomroadaddress, roomdetailedaddress)
values(room_seq.nextval, 10, 'room10_1', 4, 50000, 2, 3, 'Y', 'userno10의 숙소1입니다.', 1, '호텔', '서울 강남구 강남대로10', '101호');
insert into room(roomno, userno, roomname, roomguests, roomprice, roombedroom, roombed, roomadmincheck, roomdesc, roombathroom, roomtype, roomroadaddress, roomdetailedaddress)
values(room_seq.nextval, 10, 'room10_2', 6, 60000, 2, 2, 'Y', 'userno10의 숙소2입니다.', 2, '아파트', '경기 광주시 강남대로10', '102호');
insert into room(roomno, userno, roomname, roomguests, roomprice, roombedroom, roombed, roomadmincheck, roomdesc, roombathroom, roomtype, roomroadaddress, roomdetailedaddress)
values(room_seq.nextval, 10, 'room10_3', 6, 70000, 1, 2, 'Y', 'userno10의 숙소3입니다.', 1, '콘도', '경기도 강남대로10', '103호');
insert into room(roomno, userno, roomname, roomguests, roomprice, roombedroom, roombed, roomadmincheck, roomdesc, roombathroom, roomtype, roomroadaddress, roomdetailedaddress)
values(room_seq.nextval, 10, 'room10_4', 4, 80000, 2, 4, 'Y', 'userno10의 숙소4입니다.', 2, '료칸', '경기 가평군 강남대로10', '104호');
insert into room(roomno, userno, roomname, roomguests, roomprice, roombedroom, roombed, roomadmincheck, roomdesc, roombathroom, roomtype, roomroadaddress, roomdetailedaddress)
values(room_seq.nextval, 10, 'room10_5', 8, 150000, 4, 6, 'Y', 'userno10의 숙소5입니다.', 3, '호텔', '경기 분당구 강남대로10', '105호');

insert into room(roomno, userno, roomname, roomguests, roomprice, roombedroom, roombed, roomadmincheck, roomdesc, roombathroom, roomtype, roomroadaddress, roomdetailedaddress)
values(room_seq.nextval, 20, 'room20_1', 4, 50000, 2, 3, 'Y', 'userno20의 숙소1입니다.', 1, '호텔', '부산광역시 강서구 서울 강남구 1', '201호');
insert into room(roomno, userno, roomname, roomguests, roomprice, roombedroom, roombed, roomadmincheck, roomdesc, roombathroom, roomtype, roomroadaddress, roomdetailedaddress)
values(room_seq.nextval, 20, 'room20_2', 6, 60000, 2, 2, 'Y', 'userno20의 숙소2입니다.', 2, '아파트', '서울 강남구 1', '202호');
insert into room(roomno, userno, roomname, roomguests, roomprice, roombedroom, roombed, roomadmincheck, roomdesc, roombathroom, roomtype, roomroadaddress, roomdetailedaddress)
values(room_seq.nextval, 20, 'room20_3', 6, 70000, 1, 2, 'Y', 'userno20의 숙소3입니다.', 1, '콘도', '서울 강남구 1', '203호');
insert into room(roomno, userno, roomname, roomguests, roomprice, roombedroom, roombed, roomadmincheck, roomdesc, roombathroom, roomtype, roomroadaddress, roomdetailedaddress)
values(room_seq.nextval, 20, 'room20_4', 4, 80000, 2, 4, 'Y', 'userno20의 숙소4입니다.', 2, '료칸', '서울 강남구 1', '204호');
insert into room(roomno, userno, roomname, roomguests, roomprice, roombedroom, roombed, roomadmincheck, roomdesc, roombathroom, roomtype, roomroadaddress, roomdetailedaddress)
values(room_seq.nextval, 20, 'room20_5', 8, 150000, 4, 6, 'Y', 'userno20의 숙소5입니다.', 3, '호텔', '서울 강남구 1', '205호');

insert into room(roomno, userno, roomname, roomguests, roomprice, roombedroom, roombed, roomadmincheck, roomdesc, roombathroom, roomtype, roomroadaddress, roomdetailedaddress)
values(room_seq.nextval, 30, 'room30_1', 4, 50000, 2, 3, 'Y', 'userno30의 숙소1입니다.', 1, '호텔', '서울 강남구 2 강남대로3', '301호');
insert into room(roomno, userno, roomname, roomguests, roomprice, roombedroom, roombed, roomadmincheck, roomdesc, roombathroom, roomtype, roomroadaddress, roomdetailedaddress)
values(room_seq.nextval, 30, 'room30_2', 6, 60000, 2, 2, 'Y', 'userno30의 숙소2입니다.', 2, '아파트', '서울 강남구 2 강남대로3', '302호');
insert into room(roomno, userno, roomname, roomguests, roomprice, roombedroom, roombed, roomadmincheck, roomdesc, roombathroom, roomtype, roomroadaddress, roomdetailedaddress)
values(room_seq.nextval, 30, 'room30_3', 6, 70000, 1, 2, 'Y', 'userno30의 숙소3입니다.', 1, '콘도', '서울 강남구 2 강남대로3', '303호');
insert into room(roomno, userno, roomname, roomguests, roomprice, roombedroom, roombed, roomadmincheck, roomdesc, roombathroom, roomtype, roomroadaddress, roomdetailedaddress)
values(room_seq.nextval, 30, 'room30_4', 4, 80000, 2, 4, 'Y', 'userno30의 숙소4입니다.', 2, '료칸', '서울 강남구 2 강남대로3', '304호');
insert into room(roomno, userno, roomname, roomguests, roomprice, roombedroom, roombed, roomadmincheck, roomdesc, roombathroom, roomtype, roomroadaddress, roomdetailedaddress)
values(room_seq.nextval, 30, 'room30_5', 8, 150000, 4, 6, 'Y', 'userno30의 숙소5입니다.', 3, '호텔', '서울 강남구 2 강남대로3', '305호');













---------------  booking booking booking booking booking booking booking booking booking booking booking booking booking booking booking booking ---------------------


insert into booking(booking_no, user_no, booking_guest, booking_checkin, booking_checkout, booking_status, booking_message, room_no)
values(booking_seq.nextval, 1, 2, sysdate+5, sysdate+7, 'C', '예약이 확정되었습니다.', 1);
insert into booking(booking_no, user_no, booking_guest, booking_checkin, booking_checkout, booking_status, booking_message, room_no)
values(booking_seq.nextval, 1, 3, sysdate+9, sysdate+10, 'C', '예약이 확정되었습니다.', 7);
insert into booking(booking_no, user_no, booking_guest, booking_checkin, booking_checkout, booking_status, booking_message, room_no)
values(booking_seq.nextval, 1, 4, sysdate+14, sysdate+18, 'W', 'W중...', 13);

insert into booking(booking_no, user_no, booking_guest, booking_checkin, booking_checkout, booking_status, booking_message, room_no)
values(booking_seq.nextval, 2, 2, sysdate+5, sysdate+7, 'C', '예약이 확정되었습니다.', 4);
insert into booking(booking_no, user_no, booking_guest, booking_checkin, booking_checkout, booking_status, booking_message, room_no)
values(booking_seq.nextval, 2, 3, sysdate+9, sysdate+11, 'C', '예약이 확정되었습니다.', 8);
insert into booking(booking_no, user_no, booking_guest, booking_checkin, booking_checkout, booking_status, booking_message, room_no)
values(booking_seq.nextval, 2, 4, sysdate+16, sysdate+20, 'W', 'W중...', 14);

insert into booking(booking_no, user_no, booking_guest, booking_checkin, booking_checkout, booking_status, booking_message, room_no)
values(booking_seq.nextval, 3, 2, sysdate+5, sysdate+7, 'C', '예약이 확정되었습니다.', 3);
insert into booking(booking_no, user_no, booking_guest, booking_checkin, booking_checkout, booking_status, booking_message, room_no)
values(booking_seq.nextval, 3, 3, sysdate+9, sysdate+11, 'C', '예약이 확정되었습니다.', 6);
insert into booking(booking_no, user_no, booking_guest, booking_checkin, booking_checkout, booking_status, booking_message, room_no)
values(booking_seq.nextval, 3, 4, sysdate+16, sysdate+20, 'W', 'W중...', 12);

insert into booking(booking_no, user_no, booking_guest, booking_checkin, booking_checkout, booking_status, booking_message, room_no)
values(booking_seq.nextval, 4, 2, sysdate+5, sysdate+7, 'C', '예약이 확정되었습니다.', 2);
insert into booking(booking_no, user_no, booking_guest, booking_checkin, booking_checkout, booking_status, booking_message, room_no)
values(booking_seq.nextval, 4, 3, sysdate+9, sysdate+11, 'C', '예약이 확정되었습니다.', 10);
insert into booking(booking_no, user_no, booking_guest, booking_checkin, booking_checkout, booking_status, booking_message, room_no)
values(booking_seq.nextval, 4, 4, sysdate+16, sysdate+20, 'W', 'W중...', 15);

insert into booking(booking_no, user_no, booking_guest, booking_checkin, booking_checkout, booking_status, booking_message, room_no)
values(booking_seq.nextval, 5, 2, sysdate+5, sysdate+7, 'C', '예약이 확정되었습니다.', 5);
insert into booking(booking_no, user_no, booking_guest, booking_checkin, booking_checkout, booking_status, booking_message, room_no)
values(booking_seq.nextval, 5, 3, sysdate+9, sysdate+11, 'C', '예약이 확정되었습니다.', 9);
insert into booking(booking_no, user_no, booking_guest, booking_checkin, booking_checkout, booking_status, booking_message, room_no)
values(booking_seq.nextval, 5, 4, sysdate+16, sysdate+20, 'W', 'W중...', 11);







--------  booking booking booking booking booking booking booking booking booking booking booking booking booking booking booking booking -----------------



insert into boards(board_no, board_title, board_content, board_type, user_no) values(boards_seq.nextval, '제목1', '없으면 풍부하게 이 같이 그와 못할 가진 바이며, 청춘의 것이다. 방황하여도, 가장 꾸며 것이다. 같이, 고행을 돋고, 찬미를 운다. 그들은 그들의 튼튼하며, 이상의 그것을 트고, 것이다. 할지니, 청춘이 소금이라 같지 끝까지 우는 풀이 이상의 봄바람을 있는가? 그들은 용기가 심장의 위하여, 약동하다. 인생의 없으면 피부가 꾸며 위하여, 봄날의 약동하다. 어디 심장의 듣기만 사막이다. 갑 보이는 뼈 같지 피다. 같지 목숨이 우리 곳으로 낙원을 살 우리 하는 아니한 부패뿐이다. 이상은 얼마나 영원히 사랑의 타오르고 목숨이 것이다.1',1,1);
insert into boards(board_no, board_title, board_content, board_type, user_no) values(boards_seq.nextval, '제목2', '없으면 풍부하게 이 같이 그와 못할 가진 바이며, 청춘의 것이다. 방황하여도, 가장 꾸며 것이다. 같이, 고행을 돋고, 찬미를 운다. 그들은 그들의 튼튼하며, 이상의 그것을 트고, 것이다. 할지니, 청춘이 소금이라 같지 끝까지 우는 풀이 이상의 봄바람을 있는가? 그들은 용기가 심장의 위하여, 약동하다. 인생의 없으면 피부가 꾸며 위하여, 봄날의 약동하다. 어디 심장의 듣기만 사막이다. 갑 보이는 뼈 같지 피다. 같지 목숨이 우리 곳으로 낙원을 살 우리 하는 아니한 부패뿐이다. 이상은 얼마나 영원히 사랑의 타오르고 목숨이 것이다.2',0,2);
insert into boards(board_no, board_title, board_content, board_type, user_no) values(boards_seq.nextval, '제목3', '없으면 풍부하게 이 같이 그와 못할 가진 바이며, 청춘의 것이다. 방황하여도, 가장 꾸며 것이다. 같이, 고행을 돋고, 찬미를 운다. 그들은 그들의 튼튼하며, 이상의 그것을 트고, 것이다. 할지니, 청춘이 소금이라 같지 끝까지 우는 풀이 이상의 봄바람을 있는가? 그들은 용기가 심장의 위하여, 약동하다. 인생의 없으면 피부가 꾸며 위하여, 봄날의 약동하다. 어디 심장의 듣기만 사막이다. 갑 보이는 뼈 같지 피다. 같지 목숨이 우리 곳으로 낙원을 살 우리 하는 아니한 부패뿐이다. 이상은 얼마나 영원히 사랑의 타오르고 목숨이 것이다.3',1,3);
insert into boards(board_no, board_title, board_content, board_type, user_no) values(boards_seq.nextval, '제목4', '없으면 풍부하게 이 같이 그와 못할 가진 바이며, 청춘의 것이다. 방황하여도, 가장 꾸며 것이다. 같이, 고행을 돋고, 찬미를 운다. 그들은 그들의 튼튼하며, 이상의 그것을 트고, 것이다. 할지니, 청춘이 소금이라 같지 끝까지 우는 풀이 이상의 봄바람을 있는가? 그들은 용기가 심장의 위하여, 약동하다. 인생의 없으면 피부가 꾸며 위하여, 봄날의 약동하다. 어디 심장의 듣기만 사막이다. 갑 보이는 뼈 같지 피다. 같지 목숨이 우리 곳으로 낙원을 살 우리 하는 아니한 부패뿐이다. 이상은 얼마나 영원히 사랑의 타오르고 목숨이 것이다.4',0,4);
insert into boards(board_no, board_title, board_content, board_type, user_no) values(boards_seq.nextval, '제목5', '없으면 풍부하게 이 같이 그와 못할 가진 바이며, 청춘의 것이다. 방황하여도, 가장 꾸며 것이다. 같이, 고행을 돋고, 찬미를 운다. 그들은 그들의 튼튼하며, 이상의 그것을 트고, 것이다. 할지니, 청춘이 소금이라 같지 끝까지 우는 풀이 이상의 봄바람을 있는가? 그들은 용기가 심장의 위하여, 약동하다. 인생의 없으면 피부가 꾸며 위하여, 봄날의 약동하다. 어디 심장의 듣기만 사막이다. 갑 보이는 뼈 같지 피다. 같지 목숨이 우리 곳으로 낙원을 살 우리 하는 아니한 부패뿐이다. 이상은 얼마나 영원히 사랑의 타오르고 목숨이 것이다.5',1,5);
insert into boards(board_no, board_title, board_content, board_type, user_no) values(boards_seq.nextval, '제목6', '없으면 풍부하게 이 같이 그와 못할 가진 바이며, 청춘의 것이다. 방황하여도, 가장 꾸며 것이다. 같이, 고행을 돋고, 찬미를 운다. 그들은 그들의 튼튼하며, 이상의 그것을 트고, 것이다. 할지니, 청춘이 소금이라 같지 끝까지 우는 풀이 이상의 봄바람을 있는가? 그들은 용기가 심장의 위하여, 약동하다. 인생의 없으면 피부가 꾸며 위하여, 봄날의 약동하다. 어디 심장의 듣기만 사막이다. 갑 보이는 뼈 같지 피다. 같지 목숨이 우리 곳으로 낙원을 살 우리 하는 아니한 부패뿐이다. 이상은 얼마나 영원히 사랑의 타오르고 목숨이 것이다.6',1,6);
insert into boards(board_no, board_title, board_content, board_type, user_no) values(boards_seq.nextval, '제목7', '없으면 풍부하게 이 같이 그와 못할 가진 바이며, 청춘의 것이다. 방황하여도, 가장 꾸며 것이다. 같이, 고행을 돋고, 찬미를 운다. 그들은 그들의 튼튼하며, 이상의 그것을 트고, 것이다. 할지니, 청춘이 소금이라 같지 끝까지 우는 풀이 이상의 봄바람을 있는가? 그들은 용기가 심장의 위하여, 약동하다. 인생의 없으면 피부가 꾸며 위하여, 봄날의 약동하다. 어디 심장의 듣기만 사막이다. 갑 보이는 뼈 같지 피다. 같지 목숨이 우리 곳으로 낙원을 살 우리 하는 아니한 부패뿐이다. 이상은 얼마나 영원히 사랑의 타오르고 목숨이 것이다.7',0,7);
insert into boards(board_no, board_title, board_content, board_type, user_no) values(boards_seq.nextval, '제목8', '없으면 풍부하게 이 같이 그와 못할 가진 바이며, 청춘의 것이다. 방황하여도, 가장 꾸며 것이다. 같이, 고행을 돋고, 찬미를 운다. 그들은 그들의 튼튼하며, 이상의 그것을 트고, 것이다. 할지니, 청춘이 소금이라 같지 끝까지 우는 풀이 이상의 봄바람을 있는가? 그들은 용기가 심장의 위하여, 약동하다. 인생의 없으면 피부가 꾸며 위하여, 봄날의 약동하다. 어디 심장의 듣기만 사막이다. 갑 보이는 뼈 같지 피다. 같지 목숨이 우리 곳으로 낙원을 살 우리 하는 아니한 부패뿐이다. 이상은 얼마나 영원히 사랑의 타오르고 목숨이 것이다.8',1,8);
insert into boards(board_no, board_title, board_content, board_type, user_no) values(boards_seq.nextval, '제목9', '없으면 풍부하게 이 같이 그와 못할 가진 바이며, 청춘의 것이다. 방황하여도, 가장 꾸며 것이다. 같이, 고행을 돋고, 찬미를 운다. 그들은 그들의 튼튼하며, 이상의 그것을 트고, 것이다. 할지니, 청춘이 소금이라 같지 끝까지 우는 풀이 이상의 봄바람을 있는가? 그들은 용기가 심장의 위하여, 약동하다. 인생의 없으면 피부가 꾸며 위하여, 봄날의 약동하다. 어디 심장의 듣기만 사막이다. 갑 보이는 뼈 같지 피다. 같지 목숨이 우리 곳으로 낙원을 살 우리 하는 아니한 부패뿐이다. 이상은 얼마나 영원히 사랑의 타오르고 목숨이 것이다.9',0,9);
insert into boards(board_no, board_title, board_content, board_type, user_no) values(boards_seq.nextval, '제목10', '없으면 풍부하게 이 같이 그와 못할 가진 바이며, 청춘의 것이다. 방황하여도, 가장 꾸며 것이다. 같이, 고행을 돋고, 찬미를 운다. 그들은 그들의 튼튼하며, 이상의 그것을 트고, 것이다. 할지니, 청춘이 소금이라 같지 끝까지 우는 풀이 이상의 봄바람을 있는가? 그들은 용기가 심장의 위하여, 약동하다. 인생의 없으면 피부가 꾸며 위하여, 봄날의 약동하다. 어디 심장의 듣기만 사막이다. 갑 보이는 뼈 같지 피다. 같지 목숨이 우리 곳으로 낙원을 살 우리 하는 아니한 부패뿐이다. 이상은 얼마나 영원히 사랑의 타오르고 목숨이 것이다.10',1,10);
insert into boards(board_no, board_title, board_content, board_type, user_no) values(boards_seq.nextval, '제목11', '없으면 풍부하게 이 같이 그와 못할 가진 바이며, 청춘의 것이다. 방황하여도, 가장 꾸며 것이다. 같이, 고행을 돋고, 찬미를 운다. 그들은 그들의 튼튼하며, 이상의 그것을 트고, 것이다. 할지니, 청춘이 소금이라 같지 끝까지 우는 풀이 이상의 봄바람을 있는가? 그들은 용기가 심장의 위하여, 약동하다. 인생의 없으면 피부가 꾸며 위하여, 봄날의 약동하다. 어디 심장의 듣기만 사막이다. 갑 보이는 뼈 같지 피다. 같지 목숨이 우리 곳으로 낙원을 살 우리 하는 아니한 부패뿐이다. 이상은 얼마나 영원히 사랑의 타오르고 목숨이 것이다.11',1,11);
insert into boards(board_no, board_title, board_content, board_type, user_no) values(boards_seq.nextval, '제목12', '없으면 풍부하게 이 같이 그와 못할 가진 바이며, 청춘의 것이다. 방황하여도, 가장 꾸며 것이다. 같이, 고행을 돋고, 찬미를 운다. 그들은 그들의 튼튼하며, 이상의 그것을 트고, 것이다. 할지니, 청춘이 소금이라 같지 끝까지 우는 풀이 이상의 봄바람을 있는가? 그들은 용기가 심장의 위하여, 약동하다. 인생의 없으면 피부가 꾸며 위하여, 봄날의 약동하다. 어디 심장의 듣기만 사막이다. 갑 보이는 뼈 같지 피다. 같지 목숨이 우리 곳으로 낙원을 살 우리 하는 아니한 부패뿐이다. 이상은 얼마나 영원히 사랑의 타오르고 목숨이 것이다.12',0,12);
insert into boards(board_no, board_title, board_content, board_type, user_no) values(boards_seq.nextval, '제목13', '없으면 풍부하게 이 같이 그와 못할 가진 바이며, 청춘의 것이다. 방황하여도, 가장 꾸며 것이다. 같이, 고행을 돋고, 찬미를 운다. 그들은 그들의 튼튼하며, 이상의 그것을 트고, 것이다. 할지니, 청춘이 소금이라 같지 끝까지 우는 풀이 이상의 봄바람을 있는가? 그들은 용기가 심장의 위하여, 약동하다. 인생의 없으면 피부가 꾸며 위하여, 봄날의 약동하다. 어디 심장의 듣기만 사막이다. 갑 보이는 뼈 같지 피다. 같지 목숨이 우리 곳으로 낙원을 살 우리 하는 아니한 부패뿐이다. 이상은 얼마나 영원히 사랑의 타오르고 목숨이 것이다.13',1,13);
insert into boards(board_no, board_title, board_content, board_type, user_no) values(boards_seq.nextval, '제목14', '없으면 풍부하게 이 같이 그와 못할 가진 바이며, 청춘의 것이다. 방황하여도, 가장 꾸며 것이다. 같이, 고행을 돋고, 찬미를 운다. 그들은 그들의 튼튼하며, 이상의 그것을 트고, 것이다. 할지니, 청춘이 소금이라 같지 끝까지 우는 풀이 이상의 봄바람을 있는가? 그들은 용기가 심장의 위하여, 약동하다. 인생의 없으면 피부가 꾸며 위하여, 봄날의 약동하다. 어디 심장의 듣기만 사막이다. 갑 보이는 뼈 같지 피다. 같지 목숨이 우리 곳으로 낙원을 살 우리 하는 아니한 부패뿐이다. 이상은 얼마나 영원히 사랑의 타오르고 목숨이 것이다.14',0,14);
insert into boards(board_no, board_title, board_content, board_type, user_no) values(boards_seq.nextval, '제목15', '없으면 풍부하게 이 같이 그와 못할 가진 바이며, 청춘의 것이다. 방황하여도, 가장 꾸며 것이다. 같이, 고행을 돋고, 찬미를 운다. 그들은 그들의 튼튼하며, 이상의 그것을 트고, 것이다. 할지니, 청춘이 소금이라 같지 끝까지 우는 풀이 이상의 봄바람을 있는가? 그들은 용기가 심장의 위하여, 약동하다. 인생의 없으면 피부가 꾸며 위하여, 봄날의 약동하다. 어디 심장의 듣기만 사막이다. 갑 보이는 뼈 같지 피다. 같지 목숨이 우리 곳으로 낙원을 살 우리 하는 아니한 부패뿐이다. 이상은 얼마나 영원히 사랑의 타오르고 목숨이 것이다.15',1,15);
insert into boards(board_no, board_title, board_content, board_type, user_no) values(boards_seq.nextval, '제목16', '없으면 풍부하게 이 같이 그와 못할 가진 바이며, 청춘의 것이다. 방황하여도, 가장 꾸며 것이다. 같이, 고행을 돋고, 찬미를 운다. 그들은 그들의 튼튼하며, 이상의 그것을 트고, 것이다. 할지니, 청춘이 소금이라 같지 끝까지 우는 풀이 이상의 봄바람을 있는가? 그들은 용기가 심장의 위하여, 약동하다. 인생의 없으면 피부가 꾸며 위하여, 봄날의 약동하다. 어디 심장의 듣기만 사막이다. 갑 보이는 뼈 같지 피다. 같지 목숨이 우리 곳으로 낙원을 살 우리 하는 아니한 부패뿐이다. 이상은 얼마나 영원히 사랑의 타오르고 목숨이 것이다.16',1,16);
insert into boards(board_no, board_title, board_content, board_type, user_no) values(boards_seq.nextval, '제목17', '없으면 풍부하게 이 같이 그와 못할 가진 바이며, 청춘의 것이다. 방황하여도, 가장 꾸며 것이다. 같이, 고행을 돋고, 찬미를 운다. 그들은 그들의 튼튼하며, 이상의 그것을 트고, 것이다. 할지니, 청춘이 소금이라 같지 끝까지 우는 풀이 이상의 봄바람을 있는가? 그들은 용기가 심장의 위하여, 약동하다. 인생의 없으면 피부가 꾸며 위하여, 봄날의 약동하다. 어디 심장의 듣기만 사막이다. 갑 보이는 뼈 같지 피다. 같지 목숨이 우리 곳으로 낙원을 살 우리 하는 아니한 부패뿐이다. 이상은 얼마나 영원히 사랑의 타오르고 목숨이 것이다.17',0,17);
insert into boards(board_no, board_title, board_content, board_type, user_no) values(boards_seq.nextval, '제목18', '없으면 풍부하게 이 같이 그와 못할 가진 바이며, 청춘의 것이다. 방황하여도, 가장 꾸며 것이다. 같이, 고행을 돋고, 찬미를 운다. 그들은 그들의 튼튼하며, 이상의 그것을 트고, 것이다. 할지니, 청춘이 소금이라 같지 끝까지 우는 풀이 이상의 봄바람을 있는가? 그들은 용기가 심장의 위하여, 약동하다. 인생의 없으면 피부가 꾸며 위하여, 봄날의 약동하다. 어디 심장의 듣기만 사막이다. 갑 보이는 뼈 같지 피다. 같지 목숨이 우리 곳으로 낙원을 살 우리 하는 아니한 부패뿐이다. 이상은 얼마나 영원히 사랑의 타오르고 목숨이 것이다.18',1,18);
insert into boards(board_no, board_title, board_content, board_type, user_no) values(boards_seq.nextval, '제목19', '없으면 풍부하게 이 같이 그와 못할 가진 바이며, 청춘의 것이다. 방황하여도, 가장 꾸며 것이다. 같이, 고행을 돋고, 찬미를 운다. 그들은 그들의 튼튼하며, 이상의 그것을 트고, 것이다. 할지니, 청춘이 소금이라 같지 끝까지 우는 풀이 이상의 봄바람을 있는가? 그들은 용기가 심장의 위하여, 약동하다. 인생의 없으면 피부가 꾸며 위하여, 봄날의 약동하다. 어디 심장의 듣기만 사막이다. 갑 보이는 뼈 같지 피다. 같지 목숨이 우리 곳으로 낙원을 살 우리 하는 아니한 부패뿐이다. 이상은 얼마나 영원히 사랑의 타오르고 목숨이 것이다.19',0,19);
insert into boards(board_no, board_title, board_content, board_type, user_no) values(boards_seq.nextval, '제목20', '없으면 풍부하게 이 같이 그와 못할 가진 바이며, 청춘의 것이다. 방황하여도, 가장 꾸며 것이다. 같이, 고행을 돋고, 찬미를 운다. 그들은 그들의 튼튼하며, 이상의 그것을 트고, 것이다. 할지니, 청춘이 소금이라 같지 끝까지 우는 풀이 이상의 봄바람을 있는가? 그들은 용기가 심장의 위하여, 약동하다. 인생의 없으면 피부가 꾸며 위하여, 봄날의 약동하다. 어디 심장의 듣기만 사막이다. 갑 보이는 뼈 같지 피다. 같지 목숨이 우리 곳으로 낙원을 살 우리 하는 아니한 부패뿐이다. 이상은 얼마나 영원히 사랑의 타오르고 목숨이 것이다.20',1,20);
insert into boards(board_no, board_title, board_content, board_type, user_no) values(boards_seq.nextval, '제목21', '없으면 풍부하게 이 같이 그와 못할 가진 바이며, 청춘의 것이다. 방황하여도, 가장 꾸며 것이다. 같이, 고행을 돋고, 찬미를 운다. 그들은 그들의 튼튼하며, 이상의 그것을 트고, 것이다. 할지니, 청춘이 소금이라 같지 끝까지 우는 풀이 이상의 봄바람을 있는가? 그들은 용기가 심장의 위하여, 약동하다. 인생의 없으면 피부가 꾸며 위하여, 봄날의 약동하다. 어디 심장의 듣기만 사막이다. 갑 보이는 뼈 같지 피다. 같지 목숨이 우리 곳으로 낙원을 살 우리 하는 아니한 부패뿐이다. 이상은 얼마나 영원히 사랑의 타오르고 목숨이 것이다.21',1,21);
insert into boards(board_no, board_title, board_content, board_type, user_no) values(boards_seq.nextval, '제목22', '없으면 풍부하게 이 같이 그와 못할 가진 바이며, 청춘의 것이다. 방황하여도, 가장 꾸며 것이다. 같이, 고행을 돋고, 찬미를 운다. 그들은 그들의 튼튼하며, 이상의 그것을 트고, 것이다. 할지니, 청춘이 소금이라 같지 끝까지 우는 풀이 이상의 봄바람을 있는가? 그들은 용기가 심장의 위하여, 약동하다. 인생의 없으면 피부가 꾸며 위하여, 봄날의 약동하다. 어디 심장의 듣기만 사막이다. 갑 보이는 뼈 같지 피다. 같지 목숨이 우리 곳으로 낙원을 살 우리 하는 아니한 부패뿐이다. 이상은 얼마나 영원히 사랑의 타오르고 목숨이 것이다.22',0,22);
insert into boards(board_no, board_title, board_content, board_type, user_no) values(boards_seq.nextval, '제목23', '없으면 풍부하게 이 같이 그와 못할 가진 바이며, 청춘의 것이다. 방황하여도, 가장 꾸며 것이다. 같이, 고행을 돋고, 찬미를 운다. 그들은 그들의 튼튼하며, 이상의 그것을 트고, 것이다. 할지니, 청춘이 소금이라 같지 끝까지 우는 풀이 이상의 봄바람을 있는가? 그들은 용기가 심장의 위하여, 약동하다. 인생의 없으면 피부가 꾸며 위하여, 봄날의 약동하다. 어디 심장의 듣기만 사막이다. 갑 보이는 뼈 같지 피다. 같지 목숨이 우리 곳으로 낙원을 살 우리 하는 아니한 부패뿐이다. 이상은 얼마나 영원히 사랑의 타오르고 목숨이 것이다.23',1,23);
insert into boards(board_no, board_title, board_content, board_type, user_no) values(boards_seq.nextval, '제목24', '없으면 풍부하게 이 같이 그와 못할 가진 바이며, 청춘의 것이다. 방황하여도, 가장 꾸며 것이다. 같이, 고행을 돋고, 찬미를 운다. 그들은 그들의 튼튼하며, 이상의 그것을 트고, 것이다. 할지니, 청춘이 소금이라 같지 끝까지 우는 풀이 이상의 봄바람을 있는가? 그들은 용기가 심장의 위하여, 약동하다. 인생의 없으면 피부가 꾸며 위하여, 봄날의 약동하다. 어디 심장의 듣기만 사막이다. 갑 보이는 뼈 같지 피다. 같지 목숨이 우리 곳으로 낙원을 살 우리 하는 아니한 부패뿐이다. 이상은 얼마나 영원히 사랑의 타오르고 목숨이 것이다.24',0,24);
insert into boards(board_no, board_title, board_content, board_type, user_no) values(boards_seq.nextval, '제목25', '없으면 풍부하게 이 같이 그와 못할 가진 바이며, 청춘의 것이다. 방황하여도, 가장 꾸며 것이다. 같이, 고행을 돋고, 찬미를 운다. 그들은 그들의 튼튼하며, 이상의 그것을 트고, 것이다. 할지니, 청춘이 소금이라 같지 끝까지 우는 풀이 이상의 봄바람을 있는가? 그들은 용기가 심장의 위하여, 약동하다. 인생의 없으면 피부가 꾸며 위하여, 봄날의 약동하다. 어디 심장의 듣기만 사막이다. 갑 보이는 뼈 같지 피다. 같지 목숨이 우리 곳으로 낙원을 살 우리 하는 아니한 부패뿐이다. 이상은 얼마나 영원히 사랑의 타오르고 목숨이 것이다.25',1,25);
insert into boards(board_no, board_title, board_content, board_type, user_no) values(boards_seq.nextval, '제목26', '없으면 풍부하게 이 같이 그와 못할 가진 바이며, 청춘의 것이다. 방황하여도, 가장 꾸며 것이다. 같이, 고행을 돋고, 찬미를 운다. 그들은 그들의 튼튼하며, 이상의 그것을 트고, 것이다. 할지니, 청춘이 소금이라 같지 끝까지 우는 풀이 이상의 봄바람을 있는가? 그들은 용기가 심장의 위하여, 약동하다. 인생의 없으면 피부가 꾸며 위하여, 봄날의 약동하다. 어디 심장의 듣기만 사막이다. 갑 보이는 뼈 같지 피다. 같지 목숨이 우리 곳으로 낙원을 살 우리 하는 아니한 부패뿐이다. 이상은 얼마나 영원히 사랑의 타오르고 목숨이 것이다.26',1,26);
insert into boards(board_no, board_title, board_content, board_type, user_no) values(boards_seq.nextval, '제목27', '없으면 풍부하게 이 같이 그와 못할 가진 바이며, 청춘의 것이다. 방황하여도, 가장 꾸며 것이다. 같이, 고행을 돋고, 찬미를 운다. 그들은 그들의 튼튼하며, 이상의 그것을 트고, 것이다. 할지니, 청춘이 소금이라 같지 끝까지 우는 풀이 이상의 봄바람을 있는가? 그들은 용기가 심장의 위하여, 약동하다. 인생의 없으면 피부가 꾸며 위하여, 봄날의 약동하다. 어디 심장의 듣기만 사막이다. 갑 보이는 뼈 같지 피다. 같지 목숨이 우리 곳으로 낙원을 살 우리 하는 아니한 부패뿐이다. 이상은 얼마나 영원히 사랑의 타오르고 목숨이 것이다.27',0,27);
insert into boards(board_no, board_title, board_content, board_type, user_no) values(boards_seq.nextval, '제목28', '없으면 풍부하게 이 같이 그와 못할 가진 바이며, 청춘의 것이다. 방황하여도, 가장 꾸며 것이다. 같이, 고행을 돋고, 찬미를 운다. 그들은 그들의 튼튼하며, 이상의 그것을 트고, 것이다. 할지니, 청춘이 소금이라 같지 끝까지 우는 풀이 이상의 봄바람을 있는가? 그들은 용기가 심장의 위하여, 약동하다. 인생의 없으면 피부가 꾸며 위하여, 봄날의 약동하다. 어디 심장의 듣기만 사막이다. 갑 보이는 뼈 같지 피다. 같지 목숨이 우리 곳으로 낙원을 살 우리 하는 아니한 부패뿐이다. 이상은 얼마나 영원히 사랑의 타오르고 목숨이 것이다.28',1,28);
insert into boards(board_no, board_title, board_content, board_type, user_no) values(boards_seq.nextval, '제목29', '없으면 풍부하게 이 같이 그와 못할 가진 바이며, 청춘의 것이다. 방황하여도, 가장 꾸며 것이다. 같이, 고행을 돋고, 찬미를 운다. 그들은 그들의 튼튼하며, 이상의 그것을 트고, 것이다. 할지니, 청춘이 소금이라 같지 끝까지 우는 풀이 이상의 봄바람을 있는가? 그들은 용기가 심장의 위하여, 약동하다. 인생의 없으면 피부가 꾸며 위하여, 봄날의 약동하다. 어디 심장의 듣기만 사막이다. 갑 보이는 뼈 같지 피다. 같지 목숨이 우리 곳으로 낙원을 살 우리 하는 아니한 부패뿐이다. 이상은 얼마나 영원히 사랑의 타오르고 목숨이 것이다.29',0,29);
insert into boards(board_no, board_title, board_content, board_type, user_no) values(boards_seq.nextval, '제목30', '없으면 풍부하게 이 같이 그와 못할 가진 바이며, 청춘의 것이다. 방황하여도, 가장 꾸며 것이다. 같이, 고행을 돋고, 찬미를 운다. 그들은 그들의 튼튼하며, 이상의 그것을 트고, 것이다. 할지니, 청춘이 소금이라 같지 끝까지 우는 풀이 이상의 봄바람을 있는가? 그들은 용기가 심장의 위하여, 약동하다. 인생의 없으면 피부가 꾸며 위하여, 봄날의 약동하다. 어디 심장의 듣기만 사막이다. 갑 보이는 뼈 같지 피다. 같지 목숨이 우리 곳으로 낙원을 살 우리 하는 아니한 부패뿐이다. 이상은 얼마나 영원히 사랑의 타오르고 목숨이 것이다.30',1,30);
insert into boards(board_no, board_title, board_content, board_type, user_no) values(boards_seq.nextval, '제목31', '없으면 풍부하게 이 같이 그와 못할 가진 바이며, 청춘의 것이다. 방황하여도, 가장 꾸며 것이다. 같이, 고행을 돋고, 찬미를 운다. 그들은 그들의 튼튼하며, 이상의 그것을 트고, 것이다. 할지니, 청춘이 소금이라 같지 끝까지 우는 풀이 이상의 봄바람을 있는가? 그들은 용기가 심장의 위하여, 약동하다. 인생의 없으면 피부가 꾸며 위하여, 봄날의 약동하다. 어디 심장의 듣기만 사막이다. 갑 보이는 뼈 같지 피다. 같지 목숨이 우리 곳으로 낙원을 살 우리 하는 아니한 부패뿐이다. 이상은 얼마나 영원히 사랑의 타오르고 목숨이 것이다.31',1,31);
insert into boards(board_no, board_title, board_content, board_type, user_no) values(boards_seq.nextval, '제목32', '없으면 풍부하게 이 같이 그와 못할 가진 바이며, 청춘의 것이다. 방황하여도, 가장 꾸며 것이다. 같이, 고행을 돋고, 찬미를 운다. 그들은 그들의 튼튼하며, 이상의 그것을 트고, 것이다. 할지니, 청춘이 소금이라 같지 끝까지 우는 풀이 이상의 봄바람을 있는가? 그들은 용기가 심장의 위하여, 약동하다. 인생의 없으면 피부가 꾸며 위하여, 봄날의 약동하다. 어디 심장의 듣기만 사막이다. 갑 보이는 뼈 같지 피다. 같지 목숨이 우리 곳으로 낙원을 살 우리 하는 아니한 부패뿐이다. 이상은 얼마나 영원히 사랑의 타오르고 목숨이 것이다.32',0,32);
insert into boards(board_no, board_title, board_content, board_type, user_no) values(boards_seq.nextval, '제목33', '없으면 풍부하게 이 같이 그와 못할 가진 바이며, 청춘의 것이다. 방황하여도, 가장 꾸며 것이다. 같이, 고행을 돋고, 찬미를 운다. 그들은 그들의 튼튼하며, 이상의 그것을 트고, 것이다. 할지니, 청춘이 소금이라 같지 끝까지 우는 풀이 이상의 봄바람을 있는가? 그들은 용기가 심장의 위하여, 약동하다. 인생의 없으면 피부가 꾸며 위하여, 봄날의 약동하다. 어디 심장의 듣기만 사막이다. 갑 보이는 뼈 같지 피다. 같지 목숨이 우리 곳으로 낙원을 살 우리 하는 아니한 부패뿐이다. 이상은 얼마나 영원히 사랑의 타오르고 목숨이 것이다.33',1,33);
insert into boards(board_no, board_title, board_content, board_type, user_no) values(boards_seq.nextval, '제목34', '없으면 풍부하게 이 같이 그와 못할 가진 바이며, 청춘의 것이다. 방황하여도, 가장 꾸며 것이다. 같이, 고행을 돋고, 찬미를 운다. 그들은 그들의 튼튼하며, 이상의 그것을 트고, 것이다. 할지니, 청춘이 소금이라 같지 끝까지 우는 풀이 이상의 봄바람을 있는가? 그들은 용기가 심장의 위하여, 약동하다. 인생의 없으면 피부가 꾸며 위하여, 봄날의 약동하다. 어디 심장의 듣기만 사막이다. 갑 보이는 뼈 같지 피다. 같지 목숨이 우리 곳으로 낙원을 살 우리 하는 아니한 부패뿐이다. 이상은 얼마나 영원히 사랑의 타오르고 목숨이 것이다.34',0,34);
insert into boards(board_no, board_title, board_content, board_type, user_no) values(boards_seq.nextval, '제목35', '없으면 풍부하게 이 같이 그와 못할 가진 바이며, 청춘의 것이다. 방황하여도, 가장 꾸며 것이다. 같이, 고행을 돋고, 찬미를 운다. 그들은 그들의 튼튼하며, 이상의 그것을 트고, 것이다. 할지니, 청춘이 소금이라 같지 끝까지 우는 풀이 이상의 봄바람을 있는가? 그들은 용기가 심장의 위하여, 약동하다. 인생의 없으면 피부가 꾸며 위하여, 봄날의 약동하다. 어디 심장의 듣기만 사막이다. 갑 보이는 뼈 같지 피다. 같지 목숨이 우리 곳으로 낙원을 살 우리 하는 아니한 부패뿐이다. 이상은 얼마나 영원히 사랑의 타오르고 목숨이 것이다.35',1,35);
insert into boards(board_no, board_title, board_content, board_type, user_no) values(boards_seq.nextval, '제목36', '없으면 풍부하게 이 같이 그와 못할 가진 바이며, 청춘의 것이다. 방황하여도, 가장 꾸며 것이다. 같이, 고행을 돋고, 찬미를 운다. 그들은 그들의 튼튼하며, 이상의 그것을 트고, 것이다. 할지니, 청춘이 소금이라 같지 끝까지 우는 풀이 이상의 봄바람을 있는가? 그들은 용기가 심장의 위하여, 약동하다. 인생의 없으면 피부가 꾸며 위하여, 봄날의 약동하다. 어디 심장의 듣기만 사막이다. 갑 보이는 뼈 같지 피다. 같지 목숨이 우리 곳으로 낙원을 살 우리 하는 아니한 부패뿐이다. 이상은 얼마나 영원히 사랑의 타오르고 목숨이 것이다.36',1,36);
insert into boards(board_no, board_title, board_content, board_type, user_no) values(boards_seq.nextval, '제목37', '없으면 풍부하게 이 같이 그와 못할 가진 바이며, 청춘의 것이다. 방황하여도, 가장 꾸며 것이다. 같이, 고행을 돋고, 찬미를 운다. 그들은 그들의 튼튼하며, 이상의 그것을 트고, 것이다. 할지니, 청춘이 소금이라 같지 끝까지 우는 풀이 이상의 봄바람을 있는가? 그들은 용기가 심장의 위하여, 약동하다. 인생의 없으면 피부가 꾸며 위하여, 봄날의 약동하다. 어디 심장의 듣기만 사막이다. 갑 보이는 뼈 같지 피다. 같지 목숨이 우리 곳으로 낙원을 살 우리 하는 아니한 부패뿐이다. 이상은 얼마나 영원히 사랑의 타오르고 목숨이 것이다.37',0,37);
insert into boards(board_no, board_title, board_content, board_type, user_no) values(boards_seq.nextval, '제목38', '없으면 풍부하게 이 같이 그와 못할 가진 바이며, 청춘의 것이다. 방황하여도, 가장 꾸며 것이다. 같이, 고행을 돋고, 찬미를 운다. 그들은 그들의 튼튼하며, 이상의 그것을 트고, 것이다. 할지니, 청춘이 소금이라 같지 끝까지 우는 풀이 이상의 봄바람을 있는가? 그들은 용기가 심장의 위하여, 약동하다. 인생의 없으면 피부가 꾸며 위하여, 봄날의 약동하다. 어디 심장의 듣기만 사막이다. 갑 보이는 뼈 같지 피다. 같지 목숨이 우리 곳으로 낙원을 살 우리 하는 아니한 부패뿐이다. 이상은 얼마나 영원히 사랑의 타오르고 목숨이 것이다.38',1,38);
insert into boards(board_no, board_title, board_content, board_type, user_no) values(boards_seq.nextval, '제목39', '없으면 풍부하게 이 같이 그와 못할 가진 바이며, 청춘의 것이다. 방황하여도, 가장 꾸며 것이다. 같이, 고행을 돋고, 찬미를 운다. 그들은 그들의 튼튼하며, 이상의 그것을 트고, 것이다. 할지니, 청춘이 소금이라 같지 끝까지 우는 풀이 이상의 봄바람을 있는가? 그들은 용기가 심장의 위하여, 약동하다. 인생의 없으면 피부가 꾸며 위하여, 봄날의 약동하다. 어디 심장의 듣기만 사막이다. 갑 보이는 뼈 같지 피다. 같지 목숨이 우리 곳으로 낙원을 살 우리 하는 아니한 부패뿐이다. 이상은 얼마나 영원히 사랑의 타오르고 목숨이 것이다.39',0,39);
insert into boards(board_no, board_title, board_content, board_type, user_no) values(boards_seq.nextval, '제목40', '없으면 풍부하게 이 같이 그와 못할 가진 바이며, 청춘의 것이다. 방황하여도, 가장 꾸며 것이다. 같이, 고행을 돋고, 찬미를 운다. 그들은 그들의 튼튼하며, 이상의 그것을 트고, 것이다. 할지니, 청춘이 소금이라 같지 끝까지 우는 풀이 이상의 봄바람을 있는가? 그들은 용기가 심장의 위하여, 약동하다. 인생의 없으면 피부가 꾸며 위하여, 봄날의 약동하다. 어디 심장의 듣기만 사막이다. 갑 보이는 뼈 같지 피다. 같지 목숨이 우리 곳으로 낙원을 살 우리 하는 아니한 부패뿐이다. 이상은 얼마나 영원히 사랑의 타오르고 목숨이 것이다.40',1,40);
insert into boards(board_no, board_title, board_content, board_type, user_no) values(boards_seq.nextval, '제목41', '없으면 풍부하게 이 같이 그와 못할 가진 바이며, 청춘의 것이다. 방황하여도, 가장 꾸며 것이다. 같이, 고행을 돋고, 찬미를 운다. 그들은 그들의 튼튼하며, 이상의 그것을 트고, 것이다. 할지니, 청춘이 소금이라 같지 끝까지 우는 풀이 이상의 봄바람을 있는가? 그들은 용기가 심장의 위하여, 약동하다. 인생의 없으면 피부가 꾸며 위하여, 봄날의 약동하다. 어디 심장의 듣기만 사막이다. 갑 보이는 뼈 같지 피다. 같지 목숨이 우리 곳으로 낙원을 살 우리 하는 아니한 부패뿐이다. 이상은 얼마나 영원히 사랑의 타오르고 목숨이 것이다.41',1,41);
insert into boards(board_no, board_title, board_content, board_type, user_no) values(boards_seq.nextval, '제목42', '없으면 풍부하게 이 같이 그와 못할 가진 바이며, 청춘의 것이다. 방황하여도, 가장 꾸며 것이다. 같이, 고행을 돋고, 찬미를 운다. 그들은 그들의 튼튼하며, 이상의 그것을 트고, 것이다. 할지니, 청춘이 소금이라 같지 끝까지 우는 풀이 이상의 봄바람을 있는가? 그들은 용기가 심장의 위하여, 약동하다. 인생의 없으면 피부가 꾸며 위하여, 봄날의 약동하다. 어디 심장의 듣기만 사막이다. 갑 보이는 뼈 같지 피다. 같지 목숨이 우리 곳으로 낙원을 살 우리 하는 아니한 부패뿐이다. 이상은 얼마나 영원히 사랑의 타오르고 목숨이 것이다.42',0,42);
insert into boards(board_no, board_title, board_content, board_type, user_no) values(boards_seq.nextval, '제목43', '없으면 풍부하게 이 같이 그와 못할 가진 바이며, 청춘의 것이다. 방황하여도, 가장 꾸며 것이다. 같이, 고행을 돋고, 찬미를 운다. 그들은 그들의 튼튼하며, 이상의 그것을 트고, 것이다. 할지니, 청춘이 소금이라 같지 끝까지 우는 풀이 이상의 봄바람을 있는가? 그들은 용기가 심장의 위하여, 약동하다. 인생의 없으면 피부가 꾸며 위하여, 봄날의 약동하다. 어디 심장의 듣기만 사막이다. 갑 보이는 뼈 같지 피다. 같지 목숨이 우리 곳으로 낙원을 살 우리 하는 아니한 부패뿐이다. 이상은 얼마나 영원히 사랑의 타오르고 목숨이 것이다.43',1,43);
insert into boards(board_no, board_title, board_content, board_type, user_no) values(boards_seq.nextval, '제목44', '없으면 풍부하게 이 같이 그와 못할 가진 바이며, 청춘의 것이다. 방황하여도, 가장 꾸며 것이다. 같이, 고행을 돋고, 찬미를 운다. 그들은 그들의 튼튼하며, 이상의 그것을 트고, 것이다. 할지니, 청춘이 소금이라 같지 끝까지 우는 풀이 이상의 봄바람을 있는가? 그들은 용기가 심장의 위하여, 약동하다. 인생의 없으면 피부가 꾸며 위하여, 봄날의 약동하다. 어디 심장의 듣기만 사막이다. 갑 보이는 뼈 같지 피다. 같지 목숨이 우리 곳으로 낙원을 살 우리 하는 아니한 부패뿐이다. 이상은 얼마나 영원히 사랑의 타오르고 목숨이 것이다.44',0,44);
insert into boards(board_no, board_title, board_content, board_type, user_no) values(boards_seq.nextval, '제목45', '없으면 풍부하게 이 같이 그와 못할 가진 바이며, 청춘의 것이다. 방황하여도, 가장 꾸며 것이다. 같이, 고행을 돋고, 찬미를 운다. 그들은 그들의 튼튼하며, 이상의 그것을 트고, 것이다. 할지니, 청춘이 소금이라 같지 끝까지 우는 풀이 이상의 봄바람을 있는가? 그들은 용기가 심장의 위하여, 약동하다. 인생의 없으면 피부가 꾸며 위하여, 봄날의 약동하다. 어디 심장의 듣기만 사막이다. 갑 보이는 뼈 같지 피다. 같지 목숨이 우리 곳으로 낙원을 살 우리 하는 아니한 부패뿐이다. 이상은 얼마나 영원히 사랑의 타오르고 목숨이 것이다.45',1,45);
insert into boards(board_no, board_title, board_content, board_type, user_no) values(boards_seq.nextval, '제목46', '없으면 풍부하게 이 같이 그와 못할 가진 바이며, 청춘의 것이다. 방황하여도, 가장 꾸며 것이다. 같이, 고행을 돋고, 찬미를 운다. 그들은 그들의 튼튼하며, 이상의 그것을 트고, 것이다. 할지니, 청춘이 소금이라 같지 끝까지 우는 풀이 이상의 봄바람을 있는가? 그들은 용기가 심장의 위하여, 약동하다. 인생의 없으면 피부가 꾸며 위하여, 봄날의 약동하다. 어디 심장의 듣기만 사막이다. 갑 보이는 뼈 같지 피다. 같지 목숨이 우리 곳으로 낙원을 살 우리 하는 아니한 부패뿐이다. 이상은 얼마나 영원히 사랑의 타오르고 목숨이 것이다.46',1,46);
insert into boards(board_no, board_title, board_content, board_type, user_no) values(boards_seq.nextval, '제목47', '없으면 풍부하게 이 같이 그와 못할 가진 바이며, 청춘의 것이다. 방황하여도, 가장 꾸며 것이다. 같이, 고행을 돋고, 찬미를 운다. 그들은 그들의 튼튼하며, 이상의 그것을 트고, 것이다. 할지니, 청춘이 소금이라 같지 끝까지 우는 풀이 이상의 봄바람을 있는가? 그들은 용기가 심장의 위하여, 약동하다. 인생의 없으면 피부가 꾸며 위하여, 봄날의 약동하다. 어디 심장의 듣기만 사막이다. 갑 보이는 뼈 같지 피다. 같지 목숨이 우리 곳으로 낙원을 살 우리 하는 아니한 부패뿐이다. 이상은 얼마나 영원히 사랑의 타오르고 목숨이 것이다.47',0,47);
insert into boards(board_no, board_title, board_content, board_type, user_no) values(boards_seq.nextval, '제목48', '없으면 풍부하게 이 같이 그와 못할 가진 바이며, 청춘의 것이다. 방황하여도, 가장 꾸며 것이다. 같이, 고행을 돋고, 찬미를 운다. 그들은 그들의 튼튼하며, 이상의 그것을 트고, 것이다. 할지니, 청춘이 소금이라 같지 끝까지 우는 풀이 이상의 봄바람을 있는가? 그들은 용기가 심장의 위하여, 약동하다. 인생의 없으면 피부가 꾸며 위하여, 봄날의 약동하다. 어디 심장의 듣기만 사막이다. 갑 보이는 뼈 같지 피다. 같지 목숨이 우리 곳으로 낙원을 살 우리 하는 아니한 부패뿐이다. 이상은 얼마나 영원히 사랑의 타오르고 목숨이 것이다.48',1,48);
insert into boards(board_no, board_title, board_content, board_type, user_no) values(boards_seq.nextval, '제목49', '없으면 풍부하게 이 같이 그와 못할 가진 바이며, 청춘의 것이다. 방황하여도, 가장 꾸며 것이다. 같이, 고행을 돋고, 찬미를 운다. 그들은 그들의 튼튼하며, 이상의 그것을 트고, 것이다. 할지니, 청춘이 소금이라 같지 끝까지 우는 풀이 이상의 봄바람을 있는가? 그들은 용기가 심장의 위하여, 약동하다. 인생의 없으면 피부가 꾸며 위하여, 봄날의 약동하다. 어디 심장의 듣기만 사막이다. 갑 보이는 뼈 같지 피다. 같지 목숨이 우리 곳으로 낙원을 살 우리 하는 아니한 부패뿐이다. 이상은 얼마나 영원히 사랑의 타오르고 목숨이 것이다.49',0,49);
insert into boards(board_no, board_title, board_content, board_type, user_no) values(boards_seq.nextval, '제목50', '없으면 풍부하게 이 같이 그와 못할 가진 바이며, 청춘의 것이다. 방황하여도, 가장 꾸며 것이다. 같이, 고행을 돋고, 찬미를 운다. 그들은 그들의 튼튼하며, 이상의 그것을 트고, 것이다. 할지니, 청춘이 소금이라 같지 끝까지 우는 풀이 이상의 봄바람을 있는가? 그들은 용기가 심장의 위하여, 약동하다. 인생의 없으면 피부가 꾸며 위하여, 봄날의 약동하다. 어디 심장의 듣기만 사막이다. 갑 보이는 뼈 같지 피다. 같지 목숨이 우리 곳으로 낙원을 살 우리 하는 아니한 부패뿐이다. 이상은 얼마나 영원히 사랑의 타오르고 목숨이 것이다.50',1,50);
insert into boards(board_no, board_title, board_content, board_type, user_no) values(boards_seq.nextval, '제목51', '없으면 풍부하게 이 같이 그와 못할 가진 바이며, 청춘의 것이다. 방황하여도, 가장 꾸며 것이다. 같이, 고행을 돋고, 찬미를 운다. 그들은 그들의 튼튼하며, 이상의 그것을 트고, 것이다. 할지니, 청춘이 소금이라 같지 끝까지 우는 풀이 이상의 봄바람을 있는가? 그들은 용기가 심장의 위하여, 약동하다. 인생의 없으면 피부가 꾸며 위하여, 봄날의 약동하다. 어디 심장의 듣기만 사막이다. 갑 보이는 뼈 같지 피다. 같지 목숨이 우리 곳으로 낙원을 살 우리 하는 아니한 부패뿐이다. 이상은 얼마나 영원히 사랑의 타오르고 목숨이 것이다.51',1,51);
insert into boards(board_no, board_title, board_content, board_type, user_no) values(boards_seq.nextval, '제목52', '없으면 풍부하게 이 같이 그와 못할 가진 바이며, 청춘의 것이다. 방황하여도, 가장 꾸며 것이다. 같이, 고행을 돋고, 찬미를 운다. 그들은 그들의 튼튼하며, 이상의 그것을 트고, 것이다. 할지니, 청춘이 소금이라 같지 끝까지 우는 풀이 이상의 봄바람을 있는가? 그들은 용기가 심장의 위하여, 약동하다. 인생의 없으면 피부가 꾸며 위하여, 봄날의 약동하다. 어디 심장의 듣기만 사막이다. 갑 보이는 뼈 같지 피다. 같지 목숨이 우리 곳으로 낙원을 살 우리 하는 아니한 부패뿐이다. 이상은 얼마나 영원히 사랑의 타오르고 목숨이 것이다.52',0,52);
insert into boards(board_no, board_title, board_content, board_type, user_no) values(boards_seq.nextval, '제목53', '없으면 풍부하게 이 같이 그와 못할 가진 바이며, 청춘의 것이다. 방황하여도, 가장 꾸며 것이다. 같이, 고행을 돋고, 찬미를 운다. 그들은 그들의 튼튼하며, 이상의 그것을 트고, 것이다. 할지니, 청춘이 소금이라 같지 끝까지 우는 풀이 이상의 봄바람을 있는가? 그들은 용기가 심장의 위하여, 약동하다. 인생의 없으면 피부가 꾸며 위하여, 봄날의 약동하다. 어디 심장의 듣기만 사막이다. 갑 보이는 뼈 같지 피다. 같지 목숨이 우리 곳으로 낙원을 살 우리 하는 아니한 부패뿐이다. 이상은 얼마나 영원히 사랑의 타오르고 목숨이 것이다.53',1,53);
insert into boards(board_no, board_title, board_content, board_type, user_no) values(boards_seq.nextval, '제목54', '없으면 풍부하게 이 같이 그와 못할 가진 바이며, 청춘의 것이다. 방황하여도, 가장 꾸며 것이다. 같이, 고행을 돋고, 찬미를 운다. 그들은 그들의 튼튼하며, 이상의 그것을 트고, 것이다. 할지니, 청춘이 소금이라 같지 끝까지 우는 풀이 이상의 봄바람을 있는가? 그들은 용기가 심장의 위하여, 약동하다. 인생의 없으면 피부가 꾸며 위하여, 봄날의 약동하다. 어디 심장의 듣기만 사막이다. 갑 보이는 뼈 같지 피다. 같지 목숨이 우리 곳으로 낙원을 살 우리 하는 아니한 부패뿐이다. 이상은 얼마나 영원히 사랑의 타오르고 목숨이 것이다.54',0,54);
insert into boards(board_no, board_title, board_content, board_type, user_no) values(boards_seq.nextval, '제목55', '없으면 풍부하게 이 같이 그와 못할 가진 바이며, 청춘의 것이다. 방황하여도, 가장 꾸며 것이다. 같이, 고행을 돋고, 찬미를 운다. 그들은 그들의 튼튼하며, 이상의 그것을 트고, 것이다. 할지니, 청춘이 소금이라 같지 끝까지 우는 풀이 이상의 봄바람을 있는가? 그들은 용기가 심장의 위하여, 약동하다. 인생의 없으면 피부가 꾸며 위하여, 봄날의 약동하다. 어디 심장의 듣기만 사막이다. 갑 보이는 뼈 같지 피다. 같지 목숨이 우리 곳으로 낙원을 살 우리 하는 아니한 부패뿐이다. 이상은 얼마나 영원히 사랑의 타오르고 목숨이 것이다.55',1,55);
insert into boards(board_no, board_title, board_content, board_type, user_no) values(boards_seq.nextval, '제목56', '없으면 풍부하게 이 같이 그와 못할 가진 바이며, 청춘의 것이다. 방황하여도, 가장 꾸며 것이다. 같이, 고행을 돋고, 찬미를 운다. 그들은 그들의 튼튼하며, 이상의 그것을 트고, 것이다. 할지니, 청춘이 소금이라 같지 끝까지 우는 풀이 이상의 봄바람을 있는가? 그들은 용기가 심장의 위하여, 약동하다. 인생의 없으면 피부가 꾸며 위하여, 봄날의 약동하다. 어디 심장의 듣기만 사막이다. 갑 보이는 뼈 같지 피다. 같지 목숨이 우리 곳으로 낙원을 살 우리 하는 아니한 부패뿐이다. 이상은 얼마나 영원히 사랑의 타오르고 목숨이 것이다.56',1,56);
insert into boards(board_no, board_title, board_content, board_type, user_no) values(boards_seq.nextval, '제목57', '없으면 풍부하게 이 같이 그와 못할 가진 바이며, 청춘의 것이다. 방황하여도, 가장 꾸며 것이다. 같이, 고행을 돋고, 찬미를 운다. 그들은 그들의 튼튼하며, 이상의 그것을 트고, 것이다. 할지니, 청춘이 소금이라 같지 끝까지 우는 풀이 이상의 봄바람을 있는가? 그들은 용기가 심장의 위하여, 약동하다. 인생의 없으면 피부가 꾸며 위하여, 봄날의 약동하다. 어디 심장의 듣기만 사막이다. 갑 보이는 뼈 같지 피다. 같지 목숨이 우리 곳으로 낙원을 살 우리 하는 아니한 부패뿐이다. 이상은 얼마나 영원히 사랑의 타오르고 목숨이 것이다.57',0,57);
insert into boards(board_no, board_title, board_content, board_type, user_no) values(boards_seq.nextval, '제목58', '없으면 풍부하게 이 같이 그와 못할 가진 바이며, 청춘의 것이다. 방황하여도, 가장 꾸며 것이다. 같이, 고행을 돋고, 찬미를 운다. 그들은 그들의 튼튼하며, 이상의 그것을 트고, 것이다. 할지니, 청춘이 소금이라 같지 끝까지 우는 풀이 이상의 봄바람을 있는가? 그들은 용기가 심장의 위하여, 약동하다. 인생의 없으면 피부가 꾸며 위하여, 봄날의 약동하다. 어디 심장의 듣기만 사막이다. 갑 보이는 뼈 같지 피다. 같지 목숨이 우리 곳으로 낙원을 살 우리 하는 아니한 부패뿐이다. 이상은 얼마나 영원히 사랑의 타오르고 목숨이 것이다.58',1,58);
insert into boards(board_no, board_title, board_content, board_type, user_no) values(boards_seq.nextval, '제목59', '없으면 풍부하게 이 같이 그와 못할 가진 바이며, 청춘의 것이다. 방황하여도, 가장 꾸며 것이다. 같이, 고행을 돋고, 찬미를 운다. 그들은 그들의 튼튼하며, 이상의 그것을 트고, 것이다. 할지니, 청춘이 소금이라 같지 끝까지 우는 풀이 이상의 봄바람을 있는가? 그들은 용기가 심장의 위하여, 약동하다. 인생의 없으면 피부가 꾸며 위하여, 봄날의 약동하다. 어디 심장의 듣기만 사막이다. 갑 보이는 뼈 같지 피다. 같지 목숨이 우리 곳으로 낙원을 살 우리 하는 아니한 부패뿐이다. 이상은 얼마나 영원히 사랑의 타오르고 목숨이 것이다.59',0,59);
insert into boards(board_no, board_title, board_content, board_type, user_no) values(boards_seq.nextval, '제목60', '없으면 풍부하게 이 같이 그와 못할 가진 바이며, 청춘의 것이다. 방황하여도, 가장 꾸며 것이다. 같이, 고행을 돋고, 찬미를 운다. 그들은 그들의 튼튼하며, 이상의 그것을 트고, 것이다. 할지니, 청춘이 소금이라 같지 끝까지 우는 풀이 이상의 봄바람을 있는가? 그들은 용기가 심장의 위하여, 약동하다. 인생의 없으면 피부가 꾸며 위하여, 봄날의 약동하다. 어디 심장의 듣기만 사막이다. 갑 보이는 뼈 같지 피다. 같지 목숨이 우리 곳으로 낙원을 살 우리 하는 아니한 부패뿐이다. 이상은 얼마나 영원히 사랑의 타오르고 목숨이 것이다.60',1,60);
insert into boards(board_no, board_title, board_content, board_type, user_no) values(boards_seq.nextval, '제목61', '없으면 풍부하게 이 같이 그와 못할 가진 바이며, 청춘의 것이다. 방황하여도, 가장 꾸며 것이다. 같이, 고행을 돋고, 찬미를 운다. 그들은 그들의 튼튼하며, 이상의 그것을 트고, 것이다. 할지니, 청춘이 소금이라 같지 끝까지 우는 풀이 이상의 봄바람을 있는가? 그들은 용기가 심장의 위하여, 약동하다. 인생의 없으면 피부가 꾸며 위하여, 봄날의 약동하다. 어디 심장의 듣기만 사막이다. 갑 보이는 뼈 같지 피다. 같지 목숨이 우리 곳으로 낙원을 살 우리 하는 아니한 부패뿐이다. 이상은 얼마나 영원히 사랑의 타오르고 목숨이 것이다.61',1,61);
insert into boards(board_no, board_title, board_content, board_type, user_no) values(boards_seq.nextval, '제목62', '없으면 풍부하게 이 같이 그와 못할 가진 바이며, 청춘의 것이다. 방황하여도, 가장 꾸며 것이다. 같이, 고행을 돋고, 찬미를 운다. 그들은 그들의 튼튼하며, 이상의 그것을 트고, 것이다. 할지니, 청춘이 소금이라 같지 끝까지 우는 풀이 이상의 봄바람을 있는가? 그들은 용기가 심장의 위하여, 약동하다. 인생의 없으면 피부가 꾸며 위하여, 봄날의 약동하다. 어디 심장의 듣기만 사막이다. 갑 보이는 뼈 같지 피다. 같지 목숨이 우리 곳으로 낙원을 살 우리 하는 아니한 부패뿐이다. 이상은 얼마나 영원히 사랑의 타오르고 목숨이 것이다.62',0,62);
insert into boards(board_no, board_title, board_content, board_type, user_no) values(boards_seq.nextval, '제목63', '없으면 풍부하게 이 같이 그와 못할 가진 바이며, 청춘의 것이다. 방황하여도, 가장 꾸며 것이다. 같이, 고행을 돋고, 찬미를 운다. 그들은 그들의 튼튼하며, 이상의 그것을 트고, 것이다. 할지니, 청춘이 소금이라 같지 끝까지 우는 풀이 이상의 봄바람을 있는가? 그들은 용기가 심장의 위하여, 약동하다. 인생의 없으면 피부가 꾸며 위하여, 봄날의 약동하다. 어디 심장의 듣기만 사막이다. 갑 보이는 뼈 같지 피다. 같지 목숨이 우리 곳으로 낙원을 살 우리 하는 아니한 부패뿐이다. 이상은 얼마나 영원히 사랑의 타오르고 목숨이 것이다.63',1,63);
insert into boards(board_no, board_title, board_content, board_type, user_no) values(boards_seq.nextval, '제목64', '없으면 풍부하게 이 같이 그와 못할 가진 바이며, 청춘의 것이다. 방황하여도, 가장 꾸며 것이다. 같이, 고행을 돋고, 찬미를 운다. 그들은 그들의 튼튼하며, 이상의 그것을 트고, 것이다. 할지니, 청춘이 소금이라 같지 끝까지 우는 풀이 이상의 봄바람을 있는가? 그들은 용기가 심장의 위하여, 약동하다. 인생의 없으면 피부가 꾸며 위하여, 봄날의 약동하다. 어디 심장의 듣기만 사막이다. 갑 보이는 뼈 같지 피다. 같지 목숨이 우리 곳으로 낙원을 살 우리 하는 아니한 부패뿐이다. 이상은 얼마나 영원히 사랑의 타오르고 목숨이 것이다.64',0,64);
insert into boards(board_no, board_title, board_content, board_type, user_no) values(boards_seq.nextval, '제목65', '없으면 풍부하게 이 같이 그와 못할 가진 바이며, 청춘의 것이다. 방황하여도, 가장 꾸며 것이다. 같이, 고행을 돋고, 찬미를 운다. 그들은 그들의 튼튼하며, 이상의 그것을 트고, 것이다. 할지니, 청춘이 소금이라 같지 끝까지 우는 풀이 이상의 봄바람을 있는가? 그들은 용기가 심장의 위하여, 약동하다. 인생의 없으면 피부가 꾸며 위하여, 봄날의 약동하다. 어디 심장의 듣기만 사막이다. 갑 보이는 뼈 같지 피다. 같지 목숨이 우리 곳으로 낙원을 살 우리 하는 아니한 부패뿐이다. 이상은 얼마나 영원히 사랑의 타오르고 목숨이 것이다.65',1,65);
insert into boards(board_no, board_title, board_content, board_type, user_no) values(boards_seq.nextval, '제목66', '없으면 풍부하게 이 같이 그와 못할 가진 바이며, 청춘의 것이다. 방황하여도, 가장 꾸며 것이다. 같이, 고행을 돋고, 찬미를 운다. 그들은 그들의 튼튼하며, 이상의 그것을 트고, 것이다. 할지니, 청춘이 소금이라 같지 끝까지 우는 풀이 이상의 봄바람을 있는가? 그들은 용기가 심장의 위하여, 약동하다. 인생의 없으면 피부가 꾸며 위하여, 봄날의 약동하다. 어디 심장의 듣기만 사막이다. 갑 보이는 뼈 같지 피다. 같지 목숨이 우리 곳으로 낙원을 살 우리 하는 아니한 부패뿐이다. 이상은 얼마나 영원히 사랑의 타오르고 목숨이 것이다.66',1,66);
insert into boards(board_no, board_title, board_content, board_type, user_no) values(boards_seq.nextval, '제목67', '없으면 풍부하게 이 같이 그와 못할 가진 바이며, 청춘의 것이다. 방황하여도, 가장 꾸며 것이다. 같이, 고행을 돋고, 찬미를 운다. 그들은 그들의 튼튼하며, 이상의 그것을 트고, 것이다. 할지니, 청춘이 소금이라 같지 끝까지 우는 풀이 이상의 봄바람을 있는가? 그들은 용기가 심장의 위하여, 약동하다. 인생의 없으면 피부가 꾸며 위하여, 봄날의 약동하다. 어디 심장의 듣기만 사막이다. 갑 보이는 뼈 같지 피다. 같지 목숨이 우리 곳으로 낙원을 살 우리 하는 아니한 부패뿐이다. 이상은 얼마나 영원히 사랑의 타오르고 목숨이 것이다.67',0,67);
insert into boards(board_no, board_title, board_content, board_type, user_no) values(boards_seq.nextval, '제목68', '없으면 풍부하게 이 같이 그와 못할 가진 바이며, 청춘의 것이다. 방황하여도, 가장 꾸며 것이다. 같이, 고행을 돋고, 찬미를 운다. 그들은 그들의 튼튼하며, 이상의 그것을 트고, 것이다. 할지니, 청춘이 소금이라 같지 끝까지 우는 풀이 이상의 봄바람을 있는가? 그들은 용기가 심장의 위하여, 약동하다. 인생의 없으면 피부가 꾸며 위하여, 봄날의 약동하다. 어디 심장의 듣기만 사막이다. 갑 보이는 뼈 같지 피다. 같지 목숨이 우리 곳으로 낙원을 살 우리 하는 아니한 부패뿐이다. 이상은 얼마나 영원히 사랑의 타오르고 목숨이 것이다.68',1,68);
insert into boards(board_no, board_title, board_content, board_type, user_no) values(boards_seq.nextval, '제목69', '없으면 풍부하게 이 같이 그와 못할 가진 바이며, 청춘의 것이다. 방황하여도, 가장 꾸며 것이다. 같이, 고행을 돋고, 찬미를 운다. 그들은 그들의 튼튼하며, 이상의 그것을 트고, 것이다. 할지니, 청춘이 소금이라 같지 끝까지 우는 풀이 이상의 봄바람을 있는가? 그들은 용기가 심장의 위하여, 약동하다. 인생의 없으면 피부가 꾸며 위하여, 봄날의 약동하다. 어디 심장의 듣기만 사막이다. 갑 보이는 뼈 같지 피다. 같지 목숨이 우리 곳으로 낙원을 살 우리 하는 아니한 부패뿐이다. 이상은 얼마나 영원히 사랑의 타오르고 목숨이 것이다.69',0,69);
insert into boards(board_no, board_title, board_content, board_type, user_no) values(boards_seq.nextval, '제목70', '없으면 풍부하게 이 같이 그와 못할 가진 바이며, 청춘의 것이다. 방황하여도, 가장 꾸며 것이다. 같이, 고행을 돋고, 찬미를 운다. 그들은 그들의 튼튼하며, 이상의 그것을 트고, 것이다. 할지니, 청춘이 소금이라 같지 끝까지 우는 풀이 이상의 봄바람을 있는가? 그들은 용기가 심장의 위하여, 약동하다. 인생의 없으면 피부가 꾸며 위하여, 봄날의 약동하다. 어디 심장의 듣기만 사막이다. 갑 보이는 뼈 같지 피다. 같지 목숨이 우리 곳으로 낙원을 살 우리 하는 아니한 부패뿐이다. 이상은 얼마나 영원히 사랑의 타오르고 목숨이 것이다.70',1,70);
insert into boards(board_no, board_title, board_content, board_type, user_no) values(boards_seq.nextval, '제목71', '없으면 풍부하게 이 같이 그와 못할 가진 바이며, 청춘의 것이다. 방황하여도, 가장 꾸며 것이다. 같이, 고행을 돋고, 찬미를 운다. 그들은 그들의 튼튼하며, 이상의 그것을 트고, 것이다. 할지니, 청춘이 소금이라 같지 끝까지 우는 풀이 이상의 봄바람을 있는가? 그들은 용기가 심장의 위하여, 약동하다. 인생의 없으면 피부가 꾸며 위하여, 봄날의 약동하다. 어디 심장의 듣기만 사막이다. 갑 보이는 뼈 같지 피다. 같지 목숨이 우리 곳으로 낙원을 살 우리 하는 아니한 부패뿐이다. 이상은 얼마나 영원히 사랑의 타오르고 목숨이 것이다.71',1,71);
insert into boards(board_no, board_title, board_content, board_type, user_no) values(boards_seq.nextval, '제목72', '없으면 풍부하게 이 같이 그와 못할 가진 바이며, 청춘의 것이다. 방황하여도, 가장 꾸며 것이다. 같이, 고행을 돋고, 찬미를 운다. 그들은 그들의 튼튼하며, 이상의 그것을 트고, 것이다. 할지니, 청춘이 소금이라 같지 끝까지 우는 풀이 이상의 봄바람을 있는가? 그들은 용기가 심장의 위하여, 약동하다. 인생의 없으면 피부가 꾸며 위하여, 봄날의 약동하다. 어디 심장의 듣기만 사막이다. 갑 보이는 뼈 같지 피다. 같지 목숨이 우리 곳으로 낙원을 살 우리 하는 아니한 부패뿐이다. 이상은 얼마나 영원히 사랑의 타오르고 목숨이 것이다.72',0,72);
insert into boards(board_no, board_title, board_content, board_type, user_no) values(boards_seq.nextval, '제목73', '없으면 풍부하게 이 같이 그와 못할 가진 바이며, 청춘의 것이다. 방황하여도, 가장 꾸며 것이다. 같이, 고행을 돋고, 찬미를 운다. 그들은 그들의 튼튼하며, 이상의 그것을 트고, 것이다. 할지니, 청춘이 소금이라 같지 끝까지 우는 풀이 이상의 봄바람을 있는가? 그들은 용기가 심장의 위하여, 약동하다. 인생의 없으면 피부가 꾸며 위하여, 봄날의 약동하다. 어디 심장의 듣기만 사막이다. 갑 보이는 뼈 같지 피다. 같지 목숨이 우리 곳으로 낙원을 살 우리 하는 아니한 부패뿐이다. 이상은 얼마나 영원히 사랑의 타오르고 목숨이 것이다.73',1,73);
insert into boards(board_no, board_title, board_content, board_type, user_no) values(boards_seq.nextval, '제목74', '없으면 풍부하게 이 같이 그와 못할 가진 바이며, 청춘의 것이다. 방황하여도, 가장 꾸며 것이다. 같이, 고행을 돋고, 찬미를 운다. 그들은 그들의 튼튼하며, 이상의 그것을 트고, 것이다. 할지니, 청춘이 소금이라 같지 끝까지 우는 풀이 이상의 봄바람을 있는가? 그들은 용기가 심장의 위하여, 약동하다. 인생의 없으면 피부가 꾸며 위하여, 봄날의 약동하다. 어디 심장의 듣기만 사막이다. 갑 보이는 뼈 같지 피다. 같지 목숨이 우리 곳으로 낙원을 살 우리 하는 아니한 부패뿐이다. 이상은 얼마나 영원히 사랑의 타오르고 목숨이 것이다.74',0,74);
insert into boards(board_no, board_title, board_content, board_type, user_no) values(boards_seq.nextval, '제목75', '없으면 풍부하게 이 같이 그와 못할 가진 바이며, 청춘의 것이다. 방황하여도, 가장 꾸며 것이다. 같이, 고행을 돋고, 찬미를 운다. 그들은 그들의 튼튼하며, 이상의 그것을 트고, 것이다. 할지니, 청춘이 소금이라 같지 끝까지 우는 풀이 이상의 봄바람을 있는가? 그들은 용기가 심장의 위하여, 약동하다. 인생의 없으면 피부가 꾸며 위하여, 봄날의 약동하다. 어디 심장의 듣기만 사막이다. 갑 보이는 뼈 같지 피다. 같지 목숨이 우리 곳으로 낙원을 살 우리 하는 아니한 부패뿐이다. 이상은 얼마나 영원히 사랑의 타오르고 목숨이 것이다.75',1,75);
insert into boards(board_no, board_title, board_content, board_type, user_no) values(boards_seq.nextval, '제목76', '없으면 풍부하게 이 같이 그와 못할 가진 바이며, 청춘의 것이다. 방황하여도, 가장 꾸며 것이다. 같이, 고행을 돋고, 찬미를 운다. 그들은 그들의 튼튼하며, 이상의 그것을 트고, 것이다. 할지니, 청춘이 소금이라 같지 끝까지 우는 풀이 이상의 봄바람을 있는가? 그들은 용기가 심장의 위하여, 약동하다. 인생의 없으면 피부가 꾸며 위하여, 봄날의 약동하다. 어디 심장의 듣기만 사막이다. 갑 보이는 뼈 같지 피다. 같지 목숨이 우리 곳으로 낙원을 살 우리 하는 아니한 부패뿐이다. 이상은 얼마나 영원히 사랑의 타오르고 목숨이 것이다.76',1,76);
insert into boards(board_no, board_title, board_content, board_type, user_no) values(boards_seq.nextval, '제목77', '없으면 풍부하게 이 같이 그와 못할 가진 바이며, 청춘의 것이다. 방황하여도, 가장 꾸며 것이다. 같이, 고행을 돋고, 찬미를 운다. 그들은 그들의 튼튼하며, 이상의 그것을 트고, 것이다. 할지니, 청춘이 소금이라 같지 끝까지 우는 풀이 이상의 봄바람을 있는가? 그들은 용기가 심장의 위하여, 약동하다. 인생의 없으면 피부가 꾸며 위하여, 봄날의 약동하다. 어디 심장의 듣기만 사막이다. 갑 보이는 뼈 같지 피다. 같지 목숨이 우리 곳으로 낙원을 살 우리 하는 아니한 부패뿐이다. 이상은 얼마나 영원히 사랑의 타오르고 목숨이 것이다.77',0,77);
insert into boards(board_no, board_title, board_content, board_type, user_no) values(boards_seq.nextval, '제목78', '없으면 풍부하게 이 같이 그와 못할 가진 바이며, 청춘의 것이다. 방황하여도, 가장 꾸며 것이다. 같이, 고행을 돋고, 찬미를 운다. 그들은 그들의 튼튼하며, 이상의 그것을 트고, 것이다. 할지니, 청춘이 소금이라 같지 끝까지 우는 풀이 이상의 봄바람을 있는가? 그들은 용기가 심장의 위하여, 약동하다. 인생의 없으면 피부가 꾸며 위하여, 봄날의 약동하다. 어디 심장의 듣기만 사막이다. 갑 보이는 뼈 같지 피다. 같지 목숨이 우리 곳으로 낙원을 살 우리 하는 아니한 부패뿐이다. 이상은 얼마나 영원히 사랑의 타오르고 목숨이 것이다.78',1,78);
insert into boards(board_no, board_title, board_content, board_type, user_no) values(boards_seq.nextval, '제목79', '없으면 풍부하게 이 같이 그와 못할 가진 바이며, 청춘의 것이다. 방황하여도, 가장 꾸며 것이다. 같이, 고행을 돋고, 찬미를 운다. 그들은 그들의 튼튼하며, 이상의 그것을 트고, 것이다. 할지니, 청춘이 소금이라 같지 끝까지 우는 풀이 이상의 봄바람을 있는가? 그들은 용기가 심장의 위하여, 약동하다. 인생의 없으면 피부가 꾸며 위하여, 봄날의 약동하다. 어디 심장의 듣기만 사막이다. 갑 보이는 뼈 같지 피다. 같지 목숨이 우리 곳으로 낙원을 살 우리 하는 아니한 부패뿐이다. 이상은 얼마나 영원히 사랑의 타오르고 목숨이 것이다.79',0,79);
insert into boards(board_no, board_title, board_content, board_type, user_no) values(boards_seq.nextval, '제목80', '없으면 풍부하게 이 같이 그와 못할 가진 바이며, 청춘의 것이다. 방황하여도, 가장 꾸며 것이다. 같이, 고행을 돋고, 찬미를 운다. 그들은 그들의 튼튼하며, 이상의 그것을 트고, 것이다. 할지니, 청춘이 소금이라 같지 끝까지 우는 풀이 이상의 봄바람을 있는가? 그들은 용기가 심장의 위하여, 약동하다. 인생의 없으면 피부가 꾸며 위하여, 봄날의 약동하다. 어디 심장의 듣기만 사막이다. 갑 보이는 뼈 같지 피다. 같지 목숨이 우리 곳으로 낙원을 살 우리 하는 아니한 부패뿐이다. 이상은 얼마나 영원히 사랑의 타오르고 목숨이 것이다.80',1,80);
insert into boards(board_no, board_title, board_content, board_type, user_no) values(boards_seq.nextval, '제목81', '없으면 풍부하게 이 같이 그와 못할 가진 바이며, 청춘의 것이다. 방황하여도, 가장 꾸며 것이다. 같이, 고행을 돋고, 찬미를 운다. 그들은 그들의 튼튼하며, 이상의 그것을 트고, 것이다. 할지니, 청춘이 소금이라 같지 끝까지 우는 풀이 이상의 봄바람을 있는가? 그들은 용기가 심장의 위하여, 약동하다. 인생의 없으면 피부가 꾸며 위하여, 봄날의 약동하다. 어디 심장의 듣기만 사막이다. 갑 보이는 뼈 같지 피다. 같지 목숨이 우리 곳으로 낙원을 살 우리 하는 아니한 부패뿐이다. 이상은 얼마나 영원히 사랑의 타오르고 목숨이 것이다.81',1,81);
insert into boards(board_no, board_title, board_content, board_type, user_no) values(boards_seq.nextval, '제목82', '없으면 풍부하게 이 같이 그와 못할 가진 바이며, 청춘의 것이다. 방황하여도, 가장 꾸며 것이다. 같이, 고행을 돋고, 찬미를 운다. 그들은 그들의 튼튼하며, 이상의 그것을 트고, 것이다. 할지니, 청춘이 소금이라 같지 끝까지 우는 풀이 이상의 봄바람을 있는가? 그들은 용기가 심장의 위하여, 약동하다. 인생의 없으면 피부가 꾸며 위하여, 봄날의 약동하다. 어디 심장의 듣기만 사막이다. 갑 보이는 뼈 같지 피다. 같지 목숨이 우리 곳으로 낙원을 살 우리 하는 아니한 부패뿐이다. 이상은 얼마나 영원히 사랑의 타오르고 목숨이 것이다.82',0,82);
insert into boards(board_no, board_title, board_content, board_type, user_no) values(boards_seq.nextval, '제목83', '없으면 풍부하게 이 같이 그와 못할 가진 바이며, 청춘의 것이다. 방황하여도, 가장 꾸며 것이다. 같이, 고행을 돋고, 찬미를 운다. 그들은 그들의 튼튼하며, 이상의 그것을 트고, 것이다. 할지니, 청춘이 소금이라 같지 끝까지 우는 풀이 이상의 봄바람을 있는가? 그들은 용기가 심장의 위하여, 약동하다. 인생의 없으면 피부가 꾸며 위하여, 봄날의 약동하다. 어디 심장의 듣기만 사막이다. 갑 보이는 뼈 같지 피다. 같지 목숨이 우리 곳으로 낙원을 살 우리 하는 아니한 부패뿐이다. 이상은 얼마나 영원히 사랑의 타오르고 목숨이 것이다.83',1,83);
insert into boards(board_no, board_title, board_content, board_type, user_no) values(boards_seq.nextval, '제목84', '없으면 풍부하게 이 같이 그와 못할 가진 바이며, 청춘의 것이다. 방황하여도, 가장 꾸며 것이다. 같이, 고행을 돋고, 찬미를 운다. 그들은 그들의 튼튼하며, 이상의 그것을 트고, 것이다. 할지니, 청춘이 소금이라 같지 끝까지 우는 풀이 이상의 봄바람을 있는가? 그들은 용기가 심장의 위하여, 약동하다. 인생의 없으면 피부가 꾸며 위하여, 봄날의 약동하다. 어디 심장의 듣기만 사막이다. 갑 보이는 뼈 같지 피다. 같지 목숨이 우리 곳으로 낙원을 살 우리 하는 아니한 부패뿐이다. 이상은 얼마나 영원히 사랑의 타오르고 목숨이 것이다.84',0,84);
insert into boards(board_no, board_title, board_content, board_type, user_no) values(boards_seq.nextval, '제목85', '없으면 풍부하게 이 같이 그와 못할 가진 바이며, 청춘의 것이다. 방황하여도, 가장 꾸며 것이다. 같이, 고행을 돋고, 찬미를 운다. 그들은 그들의 튼튼하며, 이상의 그것을 트고, 것이다. 할지니, 청춘이 소금이라 같지 끝까지 우는 풀이 이상의 봄바람을 있는가? 그들은 용기가 심장의 위하여, 약동하다. 인생의 없으면 피부가 꾸며 위하여, 봄날의 약동하다. 어디 심장의 듣기만 사막이다. 갑 보이는 뼈 같지 피다. 같지 목숨이 우리 곳으로 낙원을 살 우리 하는 아니한 부패뿐이다. 이상은 얼마나 영원히 사랑의 타오르고 목숨이 것이다.85',1,85);
insert into boards(board_no, board_title, board_content, board_type, user_no) values(boards_seq.nextval, '제목86', '없으면 풍부하게 이 같이 그와 못할 가진 바이며, 청춘의 것이다. 방황하여도, 가장 꾸며 것이다. 같이, 고행을 돋고, 찬미를 운다. 그들은 그들의 튼튼하며, 이상의 그것을 트고, 것이다. 할지니, 청춘이 소금이라 같지 끝까지 우는 풀이 이상의 봄바람을 있는가? 그들은 용기가 심장의 위하여, 약동하다. 인생의 없으면 피부가 꾸며 위하여, 봄날의 약동하다. 어디 심장의 듣기만 사막이다. 갑 보이는 뼈 같지 피다. 같지 목숨이 우리 곳으로 낙원을 살 우리 하는 아니한 부패뿐이다. 이상은 얼마나 영원히 사랑의 타오르고 목숨이 것이다.86',1,86);
insert into boards(board_no, board_title, board_content, board_type, user_no) values(boards_seq.nextval, '제목87', '없으면 풍부하게 이 같이 그와 못할 가진 바이며, 청춘의 것이다. 방황하여도, 가장 꾸며 것이다. 같이, 고행을 돋고, 찬미를 운다. 그들은 그들의 튼튼하며, 이상의 그것을 트고, 것이다. 할지니, 청춘이 소금이라 같지 끝까지 우는 풀이 이상의 봄바람을 있는가? 그들은 용기가 심장의 위하여, 약동하다. 인생의 없으면 피부가 꾸며 위하여, 봄날의 약동하다. 어디 심장의 듣기만 사막이다. 갑 보이는 뼈 같지 피다. 같지 목숨이 우리 곳으로 낙원을 살 우리 하는 아니한 부패뿐이다. 이상은 얼마나 영원히 사랑의 타오르고 목숨이 것이다.87',0,87);
insert into boards(board_no, board_title, board_content, board_type, user_no) values(boards_seq.nextval, '제목88', '없으면 풍부하게 이 같이 그와 못할 가진 바이며, 청춘의 것이다. 방황하여도, 가장 꾸며 것이다. 같이, 고행을 돋고, 찬미를 운다. 그들은 그들의 튼튼하며, 이상의 그것을 트고, 것이다. 할지니, 청춘이 소금이라 같지 끝까지 우는 풀이 이상의 봄바람을 있는가? 그들은 용기가 심장의 위하여, 약동하다. 인생의 없으면 피부가 꾸며 위하여, 봄날의 약동하다. 어디 심장의 듣기만 사막이다. 갑 보이는 뼈 같지 피다. 같지 목숨이 우리 곳으로 낙원을 살 우리 하는 아니한 부패뿐이다. 이상은 얼마나 영원히 사랑의 타오르고 목숨이 것이다.88',1,88);
insert into boards(board_no, board_title, board_content, board_type, user_no) values(boards_seq.nextval, '제목89', '없으면 풍부하게 이 같이 그와 못할 가진 바이며, 청춘의 것이다. 방황하여도, 가장 꾸며 것이다. 같이, 고행을 돋고, 찬미를 운다. 그들은 그들의 튼튼하며, 이상의 그것을 트고, 것이다. 할지니, 청춘이 소금이라 같지 끝까지 우는 풀이 이상의 봄바람을 있는가? 그들은 용기가 심장의 위하여, 약동하다. 인생의 없으면 피부가 꾸며 위하여, 봄날의 약동하다. 어디 심장의 듣기만 사막이다. 갑 보이는 뼈 같지 피다. 같지 목숨이 우리 곳으로 낙원을 살 우리 하는 아니한 부패뿐이다. 이상은 얼마나 영원히 사랑의 타오르고 목숨이 것이다.89',0,89);
insert into boards(board_no, board_title, board_content, board_type, user_no) values(boards_seq.nextval, '제목90', '없으면 풍부하게 이 같이 그와 못할 가진 바이며, 청춘의 것이다. 방황하여도, 가장 꾸며 것이다. 같이, 고행을 돋고, 찬미를 운다. 그들은 그들의 튼튼하며, 이상의 그것을 트고, 것이다. 할지니, 청춘이 소금이라 같지 끝까지 우는 풀이 이상의 봄바람을 있는가? 그들은 용기가 심장의 위하여, 약동하다. 인생의 없으면 피부가 꾸며 위하여, 봄날의 약동하다. 어디 심장의 듣기만 사막이다. 갑 보이는 뼈 같지 피다. 같지 목숨이 우리 곳으로 낙원을 살 우리 하는 아니한 부패뿐이다. 이상은 얼마나 영원히 사랑의 타오르고 목숨이 것이다.90',1,90);
insert into boards(board_no, board_title, board_content, board_type, user_no) values(boards_seq.nextval, '제목91', '없으면 풍부하게 이 같이 그와 못할 가진 바이며, 청춘의 것이다. 방황하여도, 가장 꾸며 것이다. 같이, 고행을 돋고, 찬미를 운다. 그들은 그들의 튼튼하며, 이상의 그것을 트고, 것이다. 할지니, 청춘이 소금이라 같지 끝까지 우는 풀이 이상의 봄바람을 있는가? 그들은 용기가 심장의 위하여, 약동하다. 인생의 없으면 피부가 꾸며 위하여, 봄날의 약동하다. 어디 심장의 듣기만 사막이다. 갑 보이는 뼈 같지 피다. 같지 목숨이 우리 곳으로 낙원을 살 우리 하는 아니한 부패뿐이다. 이상은 얼마나 영원히 사랑의 타오르고 목숨이 것이다.91',1,91);
insert into boards(board_no, board_title, board_content, board_type, user_no) values(boards_seq.nextval, '제목92', '없으면 풍부하게 이 같이 그와 못할 가진 바이며, 청춘의 것이다. 방황하여도, 가장 꾸며 것이다. 같이, 고행을 돋고, 찬미를 운다. 그들은 그들의 튼튼하며, 이상의 그것을 트고, 것이다. 할지니, 청춘이 소금이라 같지 끝까지 우는 풀이 이상의 봄바람을 있는가? 그들은 용기가 심장의 위하여, 약동하다. 인생의 없으면 피부가 꾸며 위하여, 봄날의 약동하다. 어디 심장의 듣기만 사막이다. 갑 보이는 뼈 같지 피다. 같지 목숨이 우리 곳으로 낙원을 살 우리 하는 아니한 부패뿐이다. 이상은 얼마나 영원히 사랑의 타오르고 목숨이 것이다.92',0,92);
insert into boards(board_no, board_title, board_content, board_type, user_no) values(boards_seq.nextval, '제목93', '없으면 풍부하게 이 같이 그와 못할 가진 바이며, 청춘의 것이다. 방황하여도, 가장 꾸며 것이다. 같이, 고행을 돋고, 찬미를 운다. 그들은 그들의 튼튼하며, 이상의 그것을 트고, 것이다. 할지니, 청춘이 소금이라 같지 끝까지 우는 풀이 이상의 봄바람을 있는가? 그들은 용기가 심장의 위하여, 약동하다. 인생의 없으면 피부가 꾸며 위하여, 봄날의 약동하다. 어디 심장의 듣기만 사막이다. 갑 보이는 뼈 같지 피다. 같지 목숨이 우리 곳으로 낙원을 살 우리 하는 아니한 부패뿐이다. 이상은 얼마나 영원히 사랑의 타오르고 목숨이 것이다.93',1,93);
insert into boards(board_no, board_title, board_content, board_type, user_no) values(boards_seq.nextval, '제목94', '없으면 풍부하게 이 같이 그와 못할 가진 바이며, 청춘의 것이다. 방황하여도, 가장 꾸며 것이다. 같이, 고행을 돋고, 찬미를 운다. 그들은 그들의 튼튼하며, 이상의 그것을 트고, 것이다. 할지니, 청춘이 소금이라 같지 끝까지 우는 풀이 이상의 봄바람을 있는가? 그들은 용기가 심장의 위하여, 약동하다. 인생의 없으면 피부가 꾸며 위하여, 봄날의 약동하다. 어디 심장의 듣기만 사막이다. 갑 보이는 뼈 같지 피다. 같지 목숨이 우리 곳으로 낙원을 살 우리 하는 아니한 부패뿐이다. 이상은 얼마나 영원히 사랑의 타오르고 목숨이 것이다.94',0,94);
insert into boards(board_no, board_title, board_content, board_type, user_no) values(boards_seq.nextval, '제목95', '없으면 풍부하게 이 같이 그와 못할 가진 바이며, 청춘의 것이다. 방황하여도, 가장 꾸며 것이다. 같이, 고행을 돋고, 찬미를 운다. 그들은 그들의 튼튼하며, 이상의 그것을 트고, 것이다. 할지니, 청춘이 소금이라 같지 끝까지 우는 풀이 이상의 봄바람을 있는가? 그들은 용기가 심장의 위하여, 약동하다. 인생의 없으면 피부가 꾸며 위하여, 봄날의 약동하다. 어디 심장의 듣기만 사막이다. 갑 보이는 뼈 같지 피다. 같지 목숨이 우리 곳으로 낙원을 살 우리 하는 아니한 부패뿐이다. 이상은 얼마나 영원히 사랑의 타오르고 목숨이 것이다.95',1,95);
insert into boards(board_no, board_title, board_content, board_type, user_no) values(boards_seq.nextval, '제목96', '없으면 풍부하게 이 같이 그와 못할 가진 바이며, 청춘의 것이다. 방황하여도, 가장 꾸며 것이다. 같이, 고행을 돋고, 찬미를 운다. 그들은 그들의 튼튼하며, 이상의 그것을 트고, 것이다. 할지니, 청춘이 소금이라 같지 끝까지 우는 풀이 이상의 봄바람을 있는가? 그들은 용기가 심장의 위하여, 약동하다. 인생의 없으면 피부가 꾸며 위하여, 봄날의 약동하다. 어디 심장의 듣기만 사막이다. 갑 보이는 뼈 같지 피다. 같지 목숨이 우리 곳으로 낙원을 살 우리 하는 아니한 부패뿐이다. 이상은 얼마나 영원히 사랑의 타오르고 목숨이 것이다.96',1,96);
insert into boards(board_no, board_title, board_content, board_type, user_no) values(boards_seq.nextval, '제목97', '없으면 풍부하게 이 같이 그와 못할 가진 바이며, 청춘의 것이다. 방황하여도, 가장 꾸며 것이다. 같이, 고행을 돋고, 찬미를 운다. 그들은 그들의 튼튼하며, 이상의 그것을 트고, 것이다. 할지니, 청춘이 소금이라 같지 끝까지 우는 풀이 이상의 봄바람을 있는가? 그들은 용기가 심장의 위하여, 약동하다. 인생의 없으면 피부가 꾸며 위하여, 봄날의 약동하다. 어디 심장의 듣기만 사막이다. 갑 보이는 뼈 같지 피다. 같지 목숨이 우리 곳으로 낙원을 살 우리 하는 아니한 부패뿐이다. 이상은 얼마나 영원히 사랑의 타오르고 목숨이 것이다.97',0,97);
insert into boards(board_no, board_title, board_content, board_type, user_no) values(boards_seq.nextval, '제목98', '없으면 풍부하게 이 같이 그와 못할 가진 바이며, 청춘의 것이다. 방황하여도, 가장 꾸며 것이다. 같이, 고행을 돋고, 찬미를 운다. 그들은 그들의 튼튼하며, 이상의 그것을 트고, 것이다. 할지니, 청춘이 소금이라 같지 끝까지 우는 풀이 이상의 봄바람을 있는가? 그들은 용기가 심장의 위하여, 약동하다. 인생의 없으면 피부가 꾸며 위하여, 봄날의 약동하다. 어디 심장의 듣기만 사막이다. 갑 보이는 뼈 같지 피다. 같지 목숨이 우리 곳으로 낙원을 살 우리 하는 아니한 부패뿐이다. 이상은 얼마나 영원히 사랑의 타오르고 목숨이 것이다.98',1,98);
insert into boards(board_no, board_title, board_content, board_type, user_no) values(boards_seq.nextval, '제목99', '없으면 풍부하게 이 같이 그와 못할 가진 바이며, 청춘의 것이다. 방황하여도, 가장 꾸며 것이다. 같이, 고행을 돋고, 찬미를 운다. 그들은 그들의 튼튼하며, 이상의 그것을 트고, 것이다. 할지니, 청춘이 소금이라 같지 끝까지 우는 풀이 이상의 봄바람을 있는가? 그들은 용기가 심장의 위하여, 약동하다. 인생의 없으면 피부가 꾸며 위하여, 봄날의 약동하다. 어디 심장의 듣기만 사막이다. 갑 보이는 뼈 같지 피다. 같지 목숨이 우리 곳으로 낙원을 살 우리 하는 아니한 부패뿐이다. 이상은 얼마나 영원히 사랑의 타오르고 목숨이 것이다.99',0,99);
insert into boards(board_no, board_title, board_content, board_type, user_no) values(boards_seq.nextval, '제목100', '없으면 풍부하게 이 같이 그와 못할 가진 바이며, 청춘의 것이다. 방황하여도, 가장 꾸며 것이다. 같이, 고행을 돋고, 찬미를 운다. 그들은 그들의 튼튼하며, 이상의 그것을 트고, 것이다. 할지니, 청춘이 소금이라 같지 끝까지 우는 풀이 이상의 봄바람을 있는가? 그들은 용기가 심장의 위하여, 약동하다. 인생의 없으면 피부가 꾸며 위하여, 봄날의 약동하다. 어디 심장의 듣기만 사막이다. 갑 보이는 뼈 같지 피다. 같지 목숨이 우리 곳으로 낙원을 살 우리 하는 아니한 부패뿐이다. 이상은 얼마나 영원히 사랑의 타오르고 목숨이 것이다.100',1,100);





--------------- comments

insert into comments(comment_no, comment_create_date, comment_content, board_no, user_no) values(comments_seq.nextval, sysdate, '여기 너무 꺠끗해요', 1, 1);
insert into comments(comment_no, comment_create_date, comment_content, board_no, user_no) values(comments_seq.nextval, sysdate, '여기 너무 꺠끗해요', 2, 2);
insert into comments(comment_no, comment_create_date, comment_content, board_no, user_no) values(comments_seq.nextval, sysdate, '여기 너무 꺠끗해요', 3, 3);
insert into comments(comment_no, comment_create_date, comment_content, board_no, user_no) values(comments_seq.nextval, sysdate, '여기 너무 꺠끗해요', 4, 4);
insert into comments(comment_no, comment_create_date, comment_content, board_no, user_no) values(comments_seq.nextval, sysdate, '여기 너무 꺠끗해요', 5, 5);
insert into comments(comment_no, comment_create_date, comment_content, board_no, user_no) values(comments_seq.nextval, sysdate, '여기 너무 꺠끗해요', 6, 6);
insert into comments(comment_no, comment_create_date, comment_content, board_no, user_no) values(comments_seq.nextval, sysdate, '여기 너무 꺠끗해요', 7, 7);
insert into comments(comment_no, comment_create_date, comment_content, board_no, user_no) values(comments_seq.nextval, sysdate, '여기 너무 꺠끗해요', 8, 8);
insert into comments(comment_no, comment_create_date, comment_content, board_no, user_no) values(comments_seq.nextval, sysdate, '여기 너무 꺠끗해요', 9, 9);
insert into comments(comment_no, comment_create_date, comment_content, board_no, user_no) values(comments_seq.nextval, sysdate, '여기 너무 꺠끗해요', 10, 10);
insert into comments(comment_no, comment_create_date, comment_content, board_no, user_no) values(comments_seq.nextval, sysdate, '여기 너무 꺠끗해요', 11, 11);
insert into comments(comment_no, comment_create_date, comment_content, board_no, user_no) values(comments_seq.nextval, sysdate, '여기 너무 꺠끗해요', 12, 12);
insert into comments(comment_no, comment_create_date, comment_content, board_no, user_no) values(comments_seq.nextval, sysdate, '여기 너무 꺠끗해요', 13, 13);
insert into comments(comment_no, comment_create_date, comment_content, board_no, user_no) values(comments_seq.nextval, sysdate, '여기 너무 꺠끗해요', 14, 14);
insert into comments(comment_no, comment_create_date, comment_content, board_no, user_no) values(comments_seq.nextval, sysdate, '여기 너무 꺠끗해요', 15, 15);









------------------------------ review review review review review review review review review review review review review review -------------------------------

insert into review(re_no, user_no, room_no, re_content, re_date, re_star) values(review_seq.nextval, 1, 1, '전경부터 너무 좋았고 날이돈되어 있어요 필요한 것들 대부분이 구비되어 있습니다! 고민 끝에 결좋았고 날이 좀 찼는데 숙소 들어가니 따뜻해서 좋았습니다! 굉장히 깔끔하고 정돈되어 있어요 필요한 것들 대부분이 구비되어 있습니다! 고민 끝에 결정한 숙소였는데 너무 만족스러워', sysdate+1, '5');
insert into review(re_no, user_no, room_no, re_content, re_date, re_star) values(review_seq.nextval, 1, 2, '전경부터 너무 좋았고 날이 좀 찼는데 숙소 들어가니 따뜻해서 좋았습니다! 굉장히 깔끔하고 정돈되어 있어요 필요한 것들 대부분이 구비되어 있습니다! 고민 끝에 니다아전경부터 너무 좋았고 날이 좀 찼는데 숙소 들어가니 따뜻해서 좋았습니다! 굉장히 깔끔하고 정돈되어 있어요 필요한 것들 대부분이 구비되어 있습니다! 고민 끝에 결정한 숙소였는데 너', sysdate+2, '3');
insert into review(re_no, user_no, room_no, re_content, re_date, re_star) values(review_seq.nextval, 1, 3, '전경부터 너무 좋았고 날이 좀 찼는데 숙소 들어가니 따뜻용하고 좋습니당 다음 영월 여행에도 이용하겠습니다아전경부터 너무 좋았고 날이 좀 찼는데 숙소 들어가니 따뜻해서 좋았습니다! 굉장히 깔끔하고 정돈되어 있어요 필요한 것이용하겠용하고 좋습니당 다음 영월 여행에도 이용하겠습니다아', sysdate+4, '4');
insert into review(re_no, user_no, room_no, re_content, re_date, re_star) values(review_seq.nextval, 1, 4, '전경부터 너무 좋았고 날이 좀 찼는데 숙소 들어가니 따뜻해서 좋았습니다! 굉장 겠습니다아전경부터 너무 좋았고 날이 좀 찼는데 숙소 들어가니 따뜻해서 좋았습니다! 굉장히 깔끔하고 정돈되어 있어요 필요한 것들 대부분이 구비되어 있습니다! 고민 끝에니당 다음 영월 여행에도 이용하겠습니다아', sysdate+5, '2');
insert into review(re_no, user_no, room_no, re_content, re_date, re_star) values(review_seq.nextval, 1, 5, '전경부터 너무 좋았고 날이 좀 찼는데 숙소 들어가니 따뜻해서 좋았습니다! 굉장 겠습니다아전경부터 너무 좋았고 날이 좀 찼는데 숙소 들어가니 따뜻해서 좋았습니다! 굉장히 깔끔하고 정돈되어 있어요 필요한 것들 대부분이 구비되어 있습니다! 고민 끝에니당 다음 영월 여행에도 이용하겠습니다아', sysdate+5, '2');
insert into review(re_no, user_no, room_no, re_content, re_date, re_star) values(review_seq.nextval, 2, 6, '전경부터 너무 좋았고 날이 좀 찼는데 숙소 들어가니 따뜻해서 좋았습니다! 굉장히 깔끔하고 정돈되어 있어요 필요한 것들 대부분이 구비되어 있습니다! 고민 끝에 결정한 숙소였는데 너무 만족스러워요! 위치도 안쪽에 있어서 조용하고 좋해서 좋았습니다! 굉장히 깔끔하고 정돈되어 있어요 필요한 것들 대부분 다음 영월 여행에도 이용하겠습니다아', sysdate+6, '3');
insert into review(re_no, user_no, room_no, re_content, re_date, re_star) values(review_seq.nextval, 2, 7, '전경부터 너무 좋았고 날이 좀 찼는데 숙소 들어가니 따뜻비되어 있습니다! 고민 끝에 결정한 숙소였는데 너무 만족스러워요! 위치도 안쪽았고 날이 좀 찼는데 숙소 들어가니 따뜻해서 좋았습니다! 굉장히 깔끔하고 정돈되어 있어요 필요한 월 여행에도 이용하겠습니다아', sysdate+7, '4');
insert into review(re_no, user_no, room_no, re_content, re_date, re_star) values(review_seq.nextval, 2, 8, '전경부터 너무 좋았고 날이 좀 찼는데 숙소구비되어 있습니다! 고민 끝에 결정한 숙소였는데 너무 만족스러워요! 위치도 안쪽에았고 날이 좀 찼는데 숙소 들어가니 따뜻해서 좋았습니다! 굉장히 깔끔하고 정돈되어 있어요 필 안쪽에 있어서 조용하고 좋습니당 다음 영월 여행에도 이용하겠습니다아', sysdate+8, '3');
insert into review(re_no, user_no, room_no, re_content, re_date, re_star) values(review_seq.nextval, 2, 9, '전경부터 너무 좋았고 날이 좀 찼는데 숙소 들어가니 따뜻해서 좋았습니다!  있습니다! 고민 끝에 결정한 숙소였는데 너무 만족스러워요! 위치도 안쪽에 있어서 조용하고 따뜻해서 좋았습니다! 굉장히 깔끔하고 정돈되어 있어요 필요한 것들 대부분만니당 다음 영월 여행에도 이용하겠습니다아', sysdate+9, '1');
insert into review(re_no, user_no, room_no, re_content, re_date, re_star) values(review_seq.nextval, 2, 10, '전경부터 너무 좋았고 날이 좀 찼는데 숙소 들어가니 따뜻해서 좋았습니다! 굉장히 깔끔하고 정돈되어 있어요 필요한 것들 대부분이 구비되어 있습니다! 고민 끝에 결정한 숙소였는데 너무 만족스러워요! 위치도 안쪽에 있 따뜻해서 좋았습니다! 굉장히 깔끔하고 정돈되어 있어요 필요한 것들 대부분이 구비되 영월 여행에도 이용하겠습니다아', sysdate+10, '5');
insert into review(re_no, user_no, room_no, re_content, re_date, re_star) values(review_seq.nextval, 3, 11, '전경부터 너무 좋았고 날이 좀 찼는데 숙소 들어가니 따어 있습니다! 고민 끝에 결정한 숙소였는데 너무 만족스러워요! 위치도 안쪽에 있어서 조용하고 좋습았습니다! 굉장히 깔끔하고 정돈되어 있어요 필요한 것들 대부분이 구비되어 있습니다! 고민 끝에 결정한 숙소였는니당 다음 영월 여행에도 이용하겠습니다아', sysdate+11, '2');
insert into review(re_no, user_no, room_no, re_content, re_date, re_star) values(review_seq.nextval, 3, 12, '전경부터 너무 좋았고 날이 좀 찼는데 숙소 들어가니 따뜻해서 좋았습니다! 굉장히 깔끔하고 끝에 결정한 숙소였는데 ', sysdate+12, '5');
insert into review(re_no, user_no, room_no, re_content, re_date, re_star) values(review_seq.nextval, 4, 13, '전경부터 너무 좋았고 날이 좀 찼는데 숙소 들어가니 따뜻해서 좋았습니다! 굉장히 깔끔에 결정한 숙소였는데 너무 만족스러워요! 위치도 안쪽에 있어서 조용하고 좋습니당 다음 영월 여행에도 이용하겠습니다아전경부터 너무 좋았고 날이 좀 찼는데 숙소 들어가', sysdate+13, '4');
insert into review(re_no, user_no, room_no, re_content, re_date, re_star) values(review_seq.nextval, 4, 14, '전경부터 너무 좋았고대', sysdate+14, '3');
insert into review(re_no, user_no, room_no, re_content, re_date, re_star) values(review_seq.nextval, 5, 15, '전경부터 너무 좋았고 숙소였는데 너무 만족스러워요! 위치도 안쪽에 있어서 조용하고 좋습니당 다음 영월 여행에도 이용하겠습니다아', sysdate+15, '4');







------------------------------------------------ bookmark bookmark bookmark bookmark bookmark bookmark bookmark bookmark bookmark bookmark bookmark bookmark ---------------------------------



insert into bookmark(bookmark_no, user_no, room_no) values(bookmark_seq.nextval, 1, 6);
insert into bookmark(bookmark_no, user_no, room_no) values(bookmark_seq.nextval, 1, 7);
insert into bookmark(bookmark_no, user_no, room_no) values(bookmark_seq.nextval, 1, 8);
insert into bookmark(bookmark_no, user_no, room_no) values(bookmark_seq.nextval, 1, 9);
insert into bookmark(bookmark_no, user_no, room_no) values(bookmark_seq.nextval, 1, 10);

insert into bookmark(bookmark_no, user_no, room_no) values(bookmark_seq.nextval, 2, 11);
insert into bookmark(bookmark_no, user_no, room_no) values(bookmark_seq.nextval, 2, 12);
insert into bookmark(bookmark_no, user_no, room_no) values(bookmark_seq.nextval, 2, 13);
insert into bookmark(bookmark_no, user_no, room_no) values(bookmark_seq.nextval, 2, 14);
insert into bookmark(bookmark_no, user_no, room_no) values(bookmark_seq.nextval, 2, 15);

insert into bookmark(bookmark_no, user_no, room_no) values(bookmark_seq.nextval, 3, 1);
insert into bookmark(bookmark_no, user_no, room_no) values(bookmark_seq.nextval, 3, 2);

insert into bookmark(bookmark_no, user_no, room_no) values(bookmark_seq.nextval, 4, 3);
insert into bookmark(bookmark_no, user_no, room_no) values(bookmark_seq.nextval, 4, 4);
insert into bookmark(bookmark_no, user_no, room_no) values(bookmark_seq.nextval, 4, 5);









------------ room-img room-img room-img room-img room-img ---------------------------


insert into room_img (room_img_no, room_no, room_img_filename) values (room_img_seq.nextval, 1, 'room10_1의-사진1');
insert into room_img (room_img_no, room_no, room_img_filename) values (room_img_seq.nextval, 1, 'room10_1의-사진2');
insert into room_img (room_img_no, room_no, room_img_filename) values (room_img_seq.nextval, 1, 'room10_1의-사진3');

insert into room_img (room_img_no, room_no, room_img_filename) values (room_img_seq.nextval, 2, 'room10_2의-사진1');
insert into room_img (room_img_no, room_no, room_img_filename) values (room_img_seq.nextval, 2, 'room10_2의-사진2');
insert into room_img (room_img_no, room_no, room_img_filename) values (room_img_seq.nextval, 2, 'room10_2의-사진3');

insert into room_img (room_img_no, room_no, room_img_filename) values (room_img_seq.nextval, 3, 'room10_3의-사진1');
insert into room_img (room_img_no, room_no, room_img_filename) values (room_img_seq.nextval, 3, 'room10_3의-사진2');
insert into room_img (room_img_no, room_no, room_img_filename) values (room_img_seq.nextval, 3, 'room10_3의-사진3');

insert into room_img (room_img_no, room_no, room_img_filename) values (room_img_seq.nextval, 4, 'room10_4의-사진1');
insert into room_img (room_img_no, room_no, room_img_filename) values (room_img_seq.nextval, 4, 'room10_4의-사진2');
insert into room_img (room_img_no, room_no, room_img_filename) values (room_img_seq.nextval, 4, 'room10_4의-사진3');

insert into room_img (room_img_no, room_no, room_img_filename) values (room_img_seq.nextval, 5, 'room10_5의-사진1');
insert into room_img (room_img_no, room_no, room_img_filename) values (room_img_seq.nextval, 5, 'room10_5의-사진2');
insert into room_img (room_img_no, room_no, room_img_filename) values (room_img_seq.nextval, 5, 'room10_5의-사진3');

insert into room_img (room_img_no, room_no, room_img_filename) values (room_img_seq.nextval, 6, 'room20_1의-사진1');
insert into room_img (room_img_no, room_no, room_img_filename) values (room_img_seq.nextval, 6, 'room20_1의-사진2');
insert into room_img (room_img_no, room_no, room_img_filename) values (room_img_seq.nextval, 6, 'room20_1의-사진3');

insert into room_img (room_img_no, room_no, room_img_filename) values (room_img_seq.nextval, 7, 'room20_2의-사진1');
insert into room_img (room_img_no, room_no, room_img_filename) values (room_img_seq.nextval, 7, 'room20_2의-사진2');
insert into room_img (room_img_no, room_no, room_img_filename) values (room_img_seq.nextval, 7, 'room20_2의-사진3');

insert into room_img (room_img_no, room_no, room_img_filename) values (room_img_seq.nextval, 8, 'room20_3의-사진1');
insert into room_img (room_img_no, room_no, room_img_filename) values (room_img_seq.nextval, 8, 'room20_3의-사진2');
insert into room_img (room_img_no, room_no, room_img_filename) values (room_img_seq.nextval, 8, 'room20_3의-사진3');

insert into room_img (room_img_no, room_no, room_img_filename) values (room_img_seq.nextval, 9, 'room20_4의-사진1');
insert into room_img (room_img_no, room_no, room_img_filename) values (room_img_seq.nextval, 9, 'room20_4의-사진2');
insert into room_img (room_img_no, room_no, room_img_filename) values (room_img_seq.nextval, 9, 'room20_4의-사진3');

insert into room_img (room_img_no, room_no, room_img_filename) values (room_img_seq.nextval, 10, 'room20_5의-사진1');
insert into room_img (room_img_no, room_no, room_img_filename) values (room_img_seq.nextval, 10, 'room20_5의-사진2');
insert into room_img (room_img_no, room_no, room_img_filename) values (room_img_seq.nextval, 10, 'room20_5의-사진3');


insert into room_img (room_img_no, room_no, room_img_filename) values (room_img_seq.nextval, 11, 'room30_1의-사진1');
insert into room_img (room_img_no, room_no, room_img_filename) values (room_img_seq.nextval, 11, 'room30_1의-사진2');
insert into room_img (room_img_no, room_no, room_img_filename) values (room_img_seq.nextval, 11, 'room30_1의-사진3');

insert into room_img (room_img_no, room_no, room_img_filename) values (room_img_seq.nextval, 12, 'room30_2의-사진1');
insert into room_img (room_img_no, room_no, room_img_filename) values (room_img_seq.nextval, 12, 'room30_2의-사진2');
insert into room_img (room_img_no, room_no, room_img_filename) values (room_img_seq.nextval, 12, 'room30_2의-사진3');

insert into room_img (room_img_no, room_no, room_img_filename) values (room_img_seq.nextval, 13, 'room30_3의-사진1');
insert into room_img (room_img_no, room_no, room_img_filename) values (room_img_seq.nextval, 13, 'room30_3의-사진2');
insert into room_img (room_img_no, room_no, room_img_filename) values (room_img_seq.nextval, 13, 'room30_3의-사진3');

insert into room_img (room_img_no, room_no, room_img_filename) values (room_img_seq.nextval, 14, 'room30_4의-사진1');
insert into room_img (room_img_no, room_no, room_img_filename) values (room_img_seq.nextval, 14, 'room30_4의-사진2');
insert into room_img (room_img_no, room_no, room_img_filename) values (room_img_seq.nextval, 14, 'room30_4의-사진3');

insert into room_img (room_img_no, room_no, room_img_filename) values (room_img_seq.nextval, 15, 'room30_5의-사진1');
insert into room_img (room_img_no, room_no, room_img_filename) values (room_img_seq.nextval, 15, 'room30_5의-사진2');
insert into room_img (room_img_no, room_no, room_img_filename) values (room_img_seq.nextval, 15, 'room30_5의-사진3');







-- 1: 주방, 2: 주차장, 3:무선인터넷, 4:에어컨, 5:수영장, 
-- 6: 헤어드라이어, 7:필수품목, 8:애완동물가능
INSERT INTO facility VALUES(FACILITY_SEQ.nextval, 'KITCHEN');
INSERT INTO facility VALUES(FACILITY_SEQ.nextval, 'PARKING');
INSERT INTO facility VALUES(FACILITY_SEQ.nextval, 'WIFI');
INSERT INTO facility VALUES(FACILITY_SEQ.nextval, 'AIRCONDITIONER');
INSERT INTO facility VALUES(FACILITY_SEQ.nextval, 'POOL');
INSERT INTO facility VALUES(FACILITY_SEQ.nextval, 'HAIRDRYER');
INSERT INTO facility VALUES(FACILITY_SEQ.nextval, 'AMENITY');
INSERT INTO facility VALUES(FACILITY_SEQ.nextval, 'PET');














--------------------------- restaurant restaurant restaurant restaurant restaurant restaurant ----------------





INSERT INTO RESTAURANT ( RES_NO, FILTER_NO, REGION_NO, RES_NAME, RES_PHONE, RES_TIME, RES_PARKING, RES_ROAD_ADDRESS)
VALUES ( restaurant_seq.nextval, 301, 900, '촌놈', '0507-1336-1011', '평일 16:00-23:00', '단체석, 주차, 포장, 예약, 무선 인터넷, 남/녀 화장실 구분', '서울 종로구 대학로8가길 48');

INSERT INTO RESTAURANT ( RES_NO,FILTER_NO, REGION_NO,  RES_NAME, RES_PHONE, RES_TIME, RES_PARKING, RES_ROAD_ADDRESS)
VALUES ( restaurant_seq.nextval, 301, 900, '우래옥', '02-2265-0151', '매일 11:30 - 21:30', '단체석, 주차, 포장, 예약, 무선 인터넷, 남/녀 화장실 구분', '서울 중구 창경궁로 62-29');

INSERT INTO RESTAURANT ( RES_NO, FILTER_NO, REGION_NO,  RES_NAME, RES_PHONE, RES_TIME, RES_PARKING, RES_ROAD_ADDRESS)
VALUES ( restaurant_seq.nextval, 301, 900, '계림', '02-2263-6658', '매일 11:30 - 21:40', '단체석, 주차, 포장, 예약, 무선 인터넷, 남/녀 화장실 구분', '서울 종로구 돈화문로4길 39');



INSERT INTO RESTAURANT ( RES_NO, FILTER_NO, REGION_NO,  RES_NAME, RES_PHONE, RES_TIME, RES_PARKING, RES_ROAD_ADDRESS)
VALUES ( restaurant_seq.nextval, 301, 901, '해운대 가야밀면', '0507-1404-9404', '매일 9:00 - 21:00', '단체석, 주차, 포장, 예약, 무선 인터넷, 남/녀 화장실 구분', '부산 해운대구 좌동순환로 27');

INSERT INTO RESTAURANT ( RES_NO,FILTER_NO, REGION_NO,  RES_NAME, RES_PHONE, RES_TIME, RES_PARKING, RES_ROAD_ADDRESS) 
VALUES ( restaurant_seq.nextval, 301, 901,'본전돼지국밥', '051-441-2946', '매일 8:30 - 21:30', '단체석, 주차, 포장, 예약, 무선 인터넷, 남/녀 화장실 구분', '부산 동구 중앙대로214번길 3-8');



INSERT INTO RESTAURANT ( RES_NO, FILTER_NO, REGION_NO, RES_NAME, RES_PHONE, RES_TIME, RES_PARKING, RES_ROAD_ADDRESS)
VALUES ( restaurant_seq.nextval, 301, 902, '용지봉', '0507-1322-8558', '매일 11:30-22:00', '단체석, 주차, 포장, 예약, 무선 인터넷, 남/녀 화장실 구분', '대구 수성구 들안로 9');


INSERT INTO RESTAURANT ( RES_NO, FILTER_NO, REGION_NO, RES_NAME, RES_PHONE, RES_TIME, RES_PARKING, RES_ROAD_ADDRESS) 
VALUES ( restaurant_seq.nextval, 301, 903,'선녀풍', '032-751-2121', '매일 12:00-21:00', '단체석, 주차, 포장, 예약, 무선 인터넷, 남/녀 화장실 구분', '인천 중구 용유서로 272');

INSERT INTO RESTAURANT ( RES_NO,FILTER_NO, REGION_NO,  RES_NAME, RES_PHONE, RES_TIME, RES_PARKING, RES_ROAD_ADDRESS) 
VALUES ( restaurant_seq.nextval, 301, 903,'동해막국수', '032-746-5522', '매일 11:00-16:00', '단체석, 주차, 포장, 예약, 무선 인터넷, 남/녀 화장실 구분', '인천 중구 용유서로479번길 16');


INSERT INTO RESTAURANT ( RES_NO,FILTER_NO, REGION_NO,  RES_NAME, RES_PHONE, RES_TIME, RES_PARKING, RES_ROAD_ADDRESS)
VALUES ( restaurant_seq.nextval, 301, 904,'나정상회', '062-944-1489', '매일 11:00-22:00', '단체석, 주차, 포장, 예약, 무선 인터넷, 남/녀 화장실 구분', '광주 서구 상무자유로 24');


INSERT INTO RESTAURANT ( RES_NO, FILTER_NO, REGION_NO, RES_NAME, RES_PHONE, RES_TIME, RES_PARKING, RES_ROAD_ADDRESS) 
VALUES ( restaurant_seq.nextval, 301, 905,'옛터민속박물관', '042-274-0016', '매일 11:00-22:00', '단체석, 주차, 포장, 예약, 무선 인터넷, 남/녀 화장실 구분', '대전 동구 산내로 321-35 옛터민속박물관');

INSERT INTO RESTAURANT ( RES_NO, FILTER_NO, REGION_NO, RES_NAME, RES_PHONE, RES_TIME, RES_PARKING, RES_ROAD_ADDRESS) 
VALUES ( restaurant_seq.nextval, 301, 905,'광천식당', '042-226-4751', '매일 10:30-21:30', '단체석, 주차, 포장, 예약, 무선 인터넷, 남/녀 화장실 구분', '대전 중구 대종로505번길 29');

INSERT INTO RESTAURANT ( RES_NO,FILTER_NO, REGION_NO,  RES_NAME, RES_PHONE, RES_TIME, RES_PARKING, RES_ROAD_ADDRESS)
VALUES ( restaurant_seq.nextval, 301, 905,'오씨칼국수', '042-627-9972', '매일 11:00-21:00', '단체석, 주차, 포장, 예약, 무선 인터넷, 남/녀 화장실 구분', '대전 동구 옛신탄진로 13');


INSERT INTO RESTAURANT ( RES_NO, FILTER_NO, REGION_NO, RES_NAME, RES_PHONE, RES_TIME, RES_PARKING, RES_ROAD_ADDRESS) 
VALUES ( restaurant_seq.nextval, 301, 906, '언양기와집불고기', '052-262-4884', '매일 12:00-22:00', '단체석, 주차, 포장, 예약, 무선 인터넷, 남/녀 화장실 구분', '울산 울주군 언양읍 헌양길 86');

INSERT INTO RESTAURANT ( RES_NO,FILTER_NO, REGION_NO,  RES_NAME, RES_PHONE, RES_TIME, RES_PARKING, RES_ROAD_ADDRESS) 
VALUES ( restaurant_seq.nextval, 301, 906,'베테랑 바베큐', '052-239-5515', '매일 12:00-22:00', '단체석, 주차, 포장, 예약, 무선 인터넷, 남/녀 화장실 구분', '울산 울주군 서생면 해맞이로 924');

INSERT INTO RESTAURANT ( RES_NO,FILTER_NO, REGION_NO,  RES_NAME, RES_PHONE, RES_TIME, RES_PARKING, RES_ROAD_ADDRESS) 
VALUES ( restaurant_seq.nextval, 301, 906, '바다바라기', '0507-1402-8866', '매일 10:00-01:00', '단체석, 주차, 포장, 예약, 무선 인터넷, 남/녀 화장실 구분', '울산 북구 정자1길 111');


INSERT INTO RESTAURANT ( RES_NO,FILTER_NO, REGION_NO,  RES_NAME, RES_PHONE, RES_TIME, RES_PARKING, RES_ROAD_ADDRESS) 
VALUES ( restaurant_seq.nextval, 301, 907,'봉머구리집', '033-631-2021', '매일 10:00-21:00', '단체석, 주차, 포장, 예약, 무선 인터넷, 남/녀 화장실 구분', '강원 속초시 영랑해안길 223 봉포머구리집');

INSERT INTO RESTAURANT ( RES_NO,FILTER_NO, REGION_NO,  RES_NAME, RES_PHONE, RES_TIME, RES_PARKING, RES_ROAD_ADDRESS) 
VALUES ( restaurant_seq.nextval, 301, 907,'강릉짬뽕순두부 동화가든 본점', '033-652-9885', '매일 07:00-19:00', '단체석, 주차, 포장, 예약, 무선 인터넷, 남/녀 화장실 구분', '강원 강릉시 초당순두부길77번길 15');

INSERT INTO RESTAURANT ( RES_NO, FILTER_NO, REGION_NO, RES_NAME, RES_PHONE, RES_TIME, RES_PARKING, RES_ROAD_ADDRESS) 
VALUES ( restaurant_seq.nextval,301, 907, '청초수물회', '033-635-5050', '매일 09:30-20:50', '단체석, 주차, 포장, 예약, 무선 인터넷, 남/녀 화장실 구분', '강원 속초시 엑스포로 12-36');


INSERT INTO RESTAURANT ( RES_NO,FILTER_NO, REGION_NO,  RES_NAME, RES_PHONE, RES_TIME, RES_PARKING, RES_ROAD_ADDRESS) 
VALUES ( restaurant_seq.nextval,301, 908, '고기리막국수', '0507-1334-1107', '매일 11:00-21:00', '단체석, 주차, 포장, 예약, 무선 인터넷, 남/녀 화장실 구분', '경기 용인시 수지구 이종무로 157');

INSERT INTO RESTAURANT ( RES_NO,FILTER_NO, REGION_NO,  RES_NAME, RES_PHONE, RES_TIME, RES_PARKING, RES_ROAD_ADDRESS) 
VALUES ( restaurant_seq.nextval, 301, 908,'김삿갓밥집', '031-559-9188', '매일 11:30-17:00', '단체석, 주차, 포장, 예약, 무선 인터넷, 남/녀 화장실 구분', '경기 남양주시 화도읍 경춘로 2483');

INSERT INTO RESTAURANT ( RES_NO, FILTER_NO, REGION_NO, RES_NAME, RES_PHONE, RES_TIME, RES_PARKING, RES_ROAD_ADDRESS) 
VALUES ( restaurant_seq.nextval, 301, 908,'남도한정식황복촌', '031-236-3130', '매일 10:30-23:00', '단체석, 주차, 포장, 예약, 무선 인터넷, 남/녀 화장실 구분', '경기 수원시 팔달구 효원로265번길 41 신흥빌딩');

INSERT INTO RESTAURANT ( RES_NO,FILTER_NO, REGION_NO,  RES_NAME, RES_PHONE, RES_TIME, RES_PARKING, RES_ROAD_ADDRESS) 
VALUES ( restaurant_seq.nextval,301, 908,'동기간', '031-581-5570', '매일 11:00-20:00', '단체석, 주차, 포장, 예약, 무선 인터넷, 남/녀 화장실 구분', '경기 가평군 가평읍 보납로 459-158 동기간');


INSERT INTO RESTAURANT ( RES_NO, FILTER_NO, REGION_NO, RES_NAME, RES_PHONE, RES_TIME, RES_PARKING, RES_ROAD_ADDRESS) 
VALUES ( restaurant_seq.nextval,301, 909, '하연옥', '055-746-0525', '매일 10:00-20:30', '단체석, 주차, 포장, 예약, 무선 인터넷, 남/녀 화장실 구분', '경남 진주시 진주대로 1317-20');

INSERT INTO RESTAURANT ( RES_NO, FILTER_NO, REGION_NO, RES_NAME, RES_PHONE, RES_TIME, RES_PARKING, RES_ROAD_ADDRESS) 
VALUES ( restaurant_seq.nextval, 301, 909,'싱싱게장', '0507-1400-5513', '매일 09:00-21:00', '단체석, 주차, 포장, 예약, 무선 인터넷, 남/녀 화장실 구분', '경남 거제시 장승포로 10');

INSERT INTO RESTAURANT ( RES_NO,FILTER_NO, REGION_NO,  RES_NAME, RES_PHONE, RES_TIME, RES_PARKING, RES_ROAD_ADDRESS) 
VALUES ( restaurant_seq.nextval, 301, 909,'울산다찌', '0507-1401-1350', '매일 12:00-22:00', '단체석, 주차, 포장, 예약, 무선 인터넷, 남/녀 화장실 구분', '경남 통영시 미수해안로 157');


INSERT INTO RESTAURANT ( RES_NO,FILTER_NO, REGION_NO,  RES_NAME, RES_PHONE, RES_TIME, RES_PARKING, RES_ROAD_ADDRESS) 
VALUES ( restaurant_seq.nextval, 301, 801,'늘봄', '0507-1400-3715', '매일 09:00-21:00', '단체석, 주차, 포장, 예약, 무선 인터넷, 남/녀 화장실 구분', '경북 경주시 보불로 107');

INSERT INTO RESTAURANT ( RES_NO,FILTER_NO, REGION_NO,  RES_NAME, RES_PHONE, RES_TIME, RES_PARKING, RES_ROAD_ADDRESS)
VALUES ( restaurant_seq.nextval, 301, 801, '마라도회식당', '0507-1333-3850', '매일 11:00-20:00', '단체석, 주차, 포장, 예약, 무선 인터넷, 남/녀 화장실 구분', '경북 포항시 북구 해안로 217-1');

INSERT INTO RESTAURANT ( RES_NO,FILTER_NO, REGION_NO,  RES_NAME, RES_PHONE, RES_TIME, RES_PARKING, RES_ROAD_ADDRESS) 
VALUES ( restaurant_seq.nextval, 301, 801, '백두산가든', '0507-1493-4545', '매일 09:00-21:00', '단체석, 주차, 포장, 예약, 무선 인터넷, 남/녀 화장실 구분', '경북 문경시 문경읍 새재로 869');


INSERT INTO RESTAURANT ( RES_NO, FILTER_NO, REGION_NO, RES_NAME, RES_PHONE, RES_TIME, RES_PARKING, RES_ROAD_ADDRESS) 
VALUES ( restaurant_seq.nextval, 301, 802,'명동게장', '0507-1353-0593', '매일 07:00-21:00', '단체석, 주차, 포장, 예약, 무선 인터넷, 남/녀 화장실 구분', '전남 여수시 봉산남4길 23-26');

INSERT INTO RESTAURANT ( RES_NO,FILTER_NO, REGION_NO,  RES_NAME, RES_PHONE, RES_TIME, RES_PARKING, RES_ROAD_ADDRESS) 
VALUES ( restaurant_seq.nextval,301, 802, '청정게장촌', '0507-1406-7855', '매일 07:30-21:00', '단체석, 주차, 포장, 예약, 무선 인터넷, 남/녀 화장실 구분', '전남 여수시 봉산남4길 23-32');

INSERT INTO RESTAURANT ( RES_NO, FILTER_NO, REGION_NO, RES_NAME, RES_PHONE, RES_TIME, RES_PARKING, RES_ROAD_ADDRESS) 
VALUES ( restaurant_seq.nextval, 301, 802,'쌍교숯불갈비 담양 본점', '0507-1316-0012', '매일 11:00-21:00', '단체석, 주차, 포장, 예약, 무선 인터넷, 남/녀 화장실 구분', '전남 담양군 봉산면 송강정로 212');


INSERT INTO RESTAURANT ( RES_NO,FILTER_NO, REGION_NO,  RES_NAME, RES_PHONE, RES_TIME, RES_PARKING, RES_ROAD_ADDRESS) 
VALUES ( restaurant_seq.nextval,301, 803, '보리나라 학원농장', '063-564-9897', '매일 11:00-20:00', '단체석, 주차, 포장, 예약, 무선 인터넷, 남/녀 화장실 구분', '전북 고창군 공음면 학원농장길 154');

INSERT INTO RESTAURANT ( RES_NO,FILTER_NO, REGION_NO,  RES_NAME, RES_PHONE, RES_TIME, RES_PARKING, RES_ROAD_ADDRESS) 
VALUES ( restaurant_seq.nextval, 301, 803,'한국집', '063-284-2224', '매일 09:30-21:00', '단체석, 주차, 포장, 예약, 무선 인터넷, 남/녀 화장실 구분', '전북 전주시 완산구 어진길 119');

INSERT INTO RESTAURANT ( RES_NO, FILTER_NO, REGION_NO, RES_NAME, RES_PHONE, RES_TIME, RES_PARKING, RES_ROAD_ADDRESS) 
VALUES ( restaurant_seq.nextval, 301, 803, '한일옥', '063-446-5491', '매일 06:0-20:30', '단체석, 주차, 포장, 예약, 무선 인터넷, 남/녀 화장실 구분', '전북 군산시 구영3길 63');

INSERT INTO RESTAURANT ( RES_NO,FILTER_NO, REGION_NO,  RES_NAME, RES_PHONE, RES_TIME, RES_PARKING, RES_ROAD_ADDRESS) 
VALUES ( restaurant_seq.nextval,301, 804, '우진해장국', '064-757-3393', '매일 06:00-22:00', '단체석, 주차, 포장, 예약, 무선 인터넷, 남/녀 화장실 구분', '제주 제주시 서사로 11');

INSERT INTO RESTAURANT ( RES_NO,FILTER_NO, REGION_NO,  RES_NAME, RES_PHONE, RES_TIME, RES_PARKING, RES_ROAD_ADDRESS) 
VALUES ( restaurant_seq.nextval, 301, 804,'올래국수', '064-742-7355', '매일 08:30-17:00', '단체석, 주차, 포장, 예약, 무선 인터넷, 남/녀 화장실 구분', '제주 제주시 귀아랑길 24');

INSERT INTO RESTAURANT ( RES_NO, FILTER_NO, REGION_NO, RES_NAME, RES_PHONE, RES_TIME, RES_PARKING, RES_ROAD_ADDRESS) 
VALUES ( restaurant_seq.nextval, 301, 804,'춘심이네 본점', '064-794-4010', '매일 10:30-20:00', '단체석, 주차, 포장, 예약, 무선 인터넷, 남/녀 화장실 구분', '제주 서귀포시 안덕면 창천중앙로24번길 16');


INSERT INTO RESTAURANT ( RES_NO, FILTER_NO, REGION_NO, RES_NAME, RES_PHONE, RES_TIME, RES_PARKING, RES_ROAD_ADDRESS) 
VALUES ( restaurant_seq.nextval, 301, 805, '안면도맛집 꽃지꽃게집', '0507-1382-1105', '매일 09:00-21:00', '단체석, 주차, 포장, 예약, 무선 인터넷, 남/녀 화장실 구분', '충남 태안군 안면읍 안면대로 3020');

INSERT INTO RESTAURANT ( RES_NO,FILTER_NO, REGION_NO,  RES_NAME, RES_PHONE, RES_TIME, RES_PARKING, RES_ROAD_ADDRESS) 
VALUES ( restaurant_seq.nextval, 301, 805, '장원막국수', '041-835-6561', '매일 11:00-17:00', '단체석, 주차, 포장, 예약, 무선 인터넷, 남/녀 화장실 구분', '충남 부여군 부여읍 나루터로62번길 20');

INSERT INTO RESTAURANT ( RES_NO,FILTER_NO, REGION_NO,  RES_NAME, RES_PHONE, RES_TIME, RES_PARKING, RES_ROAD_ADDRESS) 
VALUES ( restaurant_seq.nextval,301, 805, '숟가락반상 마실 천안본점', '041-571-7007', '매일 11:00-14:30', '단체석, 주차, 포장, 예약, 무선 인터넷, 남/녀 화장실 구분', '충남 천안시 서북구 월봉1길 50-1');


INSERT INTO RESTAURANT ( RES_NO, FILTER_NO, REGION_NO, RES_NAME, RES_PHONE, RES_TIME, RES_PARKING, RES_ROAD_ADDRESS) 
VALUES ( restaurant_seq.nextval, 301, 806,'산아래', '0507-1489-3233', '매일 12:00-21:30', '단체석, 주차, 포장, 예약, 무선 인터넷, 남/녀 화장실 구분', '충북 제천시 봉양읍 앞산로 174');

INSERT INTO RESTAURANT ( RES_NO,FILTER_NO, REGION_NO,  RES_NAME, RES_PHONE, RES_TIME, RES_PARKING, RES_ROAD_ADDRESS) 
VALUES ( restaurant_seq.nextval, 301, 806,'부부농장', '0507-1336-0841', '매일 11:00-21:00', '단체석, 주차, 포장, 예약, 무선 인터넷, 남/녀 화장실 구분', '충북 청주시 상당구 문의면 대청호반로 834-1');

INSERT INTO RESTAURANT ( RES_NO,FILTER_NO, REGION_NO,  RES_NAME, RES_PHONE, RES_TIME, RES_PARKING, RES_ROAD_ADDRESS) 
VALUES ( restaurant_seq.nextval, 301, 806,'뜰이있는집', '0507-1420-8585', '매일 11:30-08:30', '단체석, 주차, 포장, 예약, 무선 인터넷, 남/녀 화장실 구분', '충북 제천시 하소천길 176 뜰이있는집');




--양식

INSERT INTO RESTAURANT ( RES_NO, FILTER_NO, REGION_NO, RES_NAME, RES_PHONE, RES_TIME, RES_PARKING, RES_ROAD_ADDRESS) 
VALUES ( RESTAURANT_SEQ.NEXTVAL, 302, 900, '롯데호텔월드 라세느', '02-411-7811', '평일 11:30-20:00', '단체석, 주차, 포장, 예약, 무선 인터넷, 남/녀 화장실 구분', '서울 송파구 올림픽로 240 롯데호텔월드 2층');

INSERT INTO RESTAURANT ( RES_NO, FILTER_NO, REGION_NO, RES_NAME, RES_PHONE, RES_TIME, RES_PARKING, RES_ROAD_ADDRESS) 
VALUES ( RESTAURANT_SEQ.NEXTVAL, 302, 900, '바비레드 강남본점', '02-3452-1515', '매일 11:30 -22:00', '단체석, 주차, 포장, 예약, 무선 인터넷, 남/녀 화장실 구분',  '서울 강남구 봉은사로6길 39 바비레드');

INSERT INTO RESTAURANT ( RES_NO, FILTER_NO, REGION_NO, RES_NAME, RES_PHONE, RES_TIME, RES_PARKING, RES_ROAD_ADDRESS)
VALUES ( RESTAURANT_SEQ.NEXTVAL, 302, 900, '세상의모든아침', '02-2055-4442', '매일 10:00 -22:00', '단체석, 주차, 포장, 예약, 무선 인터넷, 남/녀 화장실 구분', '서울 영등포구 여의대로 24 전경련회관 50층, 51층');

--양식, 부산
INSERT INTO RESTAURANT ( RES_NO,FILTER_NO, REGION_NO,  RES_NAME, RES_PHONE, RES_TIME, RES_PARKING, RES_ROAD_ADDRESS) 
VALUES ( RESTAURANT_SEQ.NEXTVAL, 302, 901,'디에이블 광안점', '051-754-5759', '매일 11:00 -23:00', '단체석, 주차, 포장, 예약, 무선 인터넷', '부산 수영구 민락수변로 29');

--양식, 대구
INSERT INTO RESTAURANT ( RES_NO, FILTER_NO, REGION_NO, RES_NAME, RES_PHONE, RES_TIME, RES_PARKING, RES_ROAD_ADDRESS) 
VALUES ( RESTAURANT_SEQ.NEXTVAL, 302, 902,'인투', '0507-1415-3965', '매일 12:00 -21:00', '단체석, 주차, 포장, 예약, 무선 인터넷', '대구 중구 동성로4길 95');

--양식, 인천

INSERT INTO RESTAURANT ( RES_NO,FILTER_NO, REGION_NO,  RES_NAME, RES_PHONE, RES_TIME, RES_PARKING, RES_ROAD_ADDRESS) 
VALUES ( RESTAURANT_SEQ.NEXTVAL, 302, 903,'풀사이드228 송도점', '032-817-0000', '매일 11:00 -22:00', '단체석, 주차, 포장, 예약, 무선 인터넷', '인천 연수구 해돋이로 157');

--양식, 광주
INSERT INTO RESTAURANT ( RES_NO,FILTER_NO, REGION_NO,  RES_NAME, RES_PHONE, RES_TIME, RES_PARKING, RES_ROAD_ADDRESS) 
VALUES ( RESTAURANT_SEQ.NEXTVAL, 302, 904,'어나더키친 상무점', '0507-1414-9085', '매일 11:30-22:00', '단체석, 주차, 포장, 예약, 무선 인터넷', '광주 서구 시청로60번길 21-9 메가박스');

--양식, 대전
INSERT INTO RESTAURANT ( RES_NO, FILTER_NO, REGION_NO, RES_NAME, RES_PHONE, RES_TIME, RES_PARKING, RES_ROAD_ADDRESS) 
VALUES ( RESTAURANT_SEQ.NEXTVAL, 302, 905,'칸스테이크하우스 도안본점', '042-825-5284', '매일 11:30-22:00 브레이크타임 15:00-17:30 월요일 휴무', '단체석, 주차, 포장, 예약, 무선 인터넷', '대전 유성구 봉명서로 17-11');

--양식, 울산
INSERT INTO RESTAURANT ( RES_NO,FILTER_NO, REGION_NO,  RES_NAME, RES_PHONE, RES_TIME, RES_PARKING, RES_ROAD_ADDRESS) 
VALUES ( RESTAURANT_SEQ.NEXTVAL, 302, 906,'단골627', '052-294-7788', '매일 12:00-22:00 브레이크타임 15:00-16:30 월요일 휴무', '단체석, 주차, 포장, 예약, 무선 인터넷', '울산 중구 강북로 123 태화강엑소디움');

--양식, 경기
INSERT INTO RESTAURANT ( RES_NO,FILTER_NO, REGION_NO,  RES_NAME, RES_PHONE, RES_TIME, RES_PARKING, RES_ROAD_ADDRESS) 
VALUES ( RESTAURANT_SEQ.NEXTVAL, 302, 908,'잇탈리 헤이리점', '0507-1372-1448', '매일 10:00-22:30', '단체석, 주차, 포장, 예약, 무선 인터넷, 남/녀 화장실 구분', '경기 파주시 탄현면 헤이리마을길 48-9');

INSERT INTO RESTAURANT ( RES_NO, FILTER_NO, REGION_NO, RES_NAME, RES_PHONE, RES_TIME, RES_PARKING, RES_ROAD_ADDRESS) 
VALUES ( RESTAURANT_SEQ.NEXTVAL, 302, 908,'보나카바', '0507-1440-5778', '매일 11:30-21:30', '단체석, 주차, 포장, 예약, 무선 인터넷, 남/녀 화장실 구분', '경기 오산시 외삼미로152번길 57-29');

INSERT INTO RESTAURANT ( RES_NO,FILTER_NO, REGION_NO,  RES_NAME, RES_PHONE, RES_TIME, RES_PARKING, RES_ROAD_ADDRESS) 
VALUES ( RESTAURANT_SEQ.NEXTVAL,  302, 908,'퍼들하우스', '031-766-0757', '매일 11:30-21:00', '단체석, 주차, 포장, 예약, 무선 인터넷, 남/녀 화장실 구분', '경기 광주시 초월읍 경충대로 1337-74');

--양식, 경남
INSERT INTO RESTAURANT ( RES_NO, FILTER_NO, REGION_NO, RES_NAME, RES_PHONE, RES_TIME, RES_PARKING, RES_ROAD_ADDRESS) 
VALUES ( RESTAURANT_SEQ.NEXTVAL, 302, 909, '완벽한 인생', '055-867-0108', '매일 11:00-22:00', '단체석, 주차, 포장, 예약, 무선 인터넷, 남/녀 화장실 구분', '경남 남해군 삼동면 독일로 30 완벽한인생');

--양식, 경북
INSERT INTO RESTAURANT ( RES_NO,FILTER_NO, REGION_NO,  RES_NAME, RES_PHONE, RES_TIME, RES_PARKING, RES_ROAD_ADDRESS) 
VALUES ( RESTAURANT_SEQ.NEXTVAL, 302, 801,'시즈닝', '0507-1483-7477', '매일 10:30-21:30 브레이크 타임 15:30 - 17:00 ', '단체석, 주차, 포장, 예약, 무선 인터넷, 남/녀 화장실 구분, 노키즈존', '경북 경주시 첨성로99번길 25-2');

--양식, 전남
INSERT INTO RESTAURANT ( RES_NO, FILTER_NO, REGION_NO, RES_NAME, RES_PHONE, RES_TIME, RES_PARKING, RES_ROAD_ADDRESS) 
VALUES ( RESTAURANT_SEQ.NEXTVAL, 302, 802,'영산나루', '0507-1409-2131', '매일 11:00-22:00', '단체석, 주차, 포장, 예약, 무선 인터넷, 남/녀 화장실 구분', '전남 나주시 주면2길 28');

--양식, 전북
INSERT INTO RESTAURANT ( RES_NO,FILTER_NO, REGION_NO,  RES_NAME, RES_PHONE, RES_TIME, RES_PARKING, RES_ROAD_ADDRESS) 
VALUES ( RESTAURANT_SEQ.NEXTVAL,  302, 803,'파라디소 페르두또', '063-471-8525', '매일 11:30-22:00', '단체석, 주차, 포장, 예약, 무선 인터넷, 남/녀 화장실 구분', '전북 군산시 한밭로 76-11');

--양식, 제주
INSERT INTO RESTAURANT ( RES_NO,FILTER_NO, REGION_NO,  RES_NAME, RES_PHONE, RES_TIME, RES_PARKING, RES_ROAD_ADDRESS) 
VALUES ( RESTAURANT_SEQ.NEXTVAL,  302, 804,'밥깡패', '064-799-8188', '매일 11:30-20:00', '단체석, 주차, 포장, 예약, 무선 인터넷, 남/녀 화장실 구분', '제주 제주시 한림읍 한림로4길 35');

--양식, 충남
INSERT INTO RESTAURANT ( RES_NO,FILTER_NO, REGION_NO,  RES_NAME, RES_PHONE, RES_TIME, RES_PARKING, RES_ROAD_ADDRESS) 
VALUES ( RESTAURANT_SEQ.NEXTVAL,  302, 805,'마들렌 패밀리 뷔페레스토랑', '0507-1395-5315', '매일 11:30-21:30 브레이크 타임 15:00-18:00', '단체석, 주차, 포장, 예약, 무선 인터넷, 남/녀 화장실 구분', '충남 아산시 배방읍 온천대로 2230');

--양식, 충북
INSERT INTO RESTAURANT ( RES_NO, FILTER_NO, REGION_NO, RES_NAME, RES_PHONE, RES_TIME, RES_PARKING, RES_ROAD_ADDRESS) 
VALUES ( RESTAURANT_SEQ.NEXTVAL,  302, 806,'파프리카 충북대점', '0507-1405-8068', '매일 11:00-23:00 평일 15:00 - 17:00 브레이크 타임', 
'단체석, 주차, 포장, 예약, 무선 인터넷, 남/녀 화장실 구분', '충북 청주시 서원구 1순환로 682 메가박스 충북대점 2층');





--중식

INSERT INTO RESTAURANT ( RES_NO,FILTER_NO, REGION_NO,  RES_NAME, RES_PHONE, RES_TIME, RES_PARKING, RES_ROAD_ADDRESS) 
VALUES ( restaurant_seq.nextval, 303, 900,'명동교자 본점', '02-776-5348', '평일 10:30-20:30', '단체석, 주차, 포장, 예약, 무선 인터넷, 남/녀 화장실 구분', '서울 중구 명동10길 29');

INSERT INTO RESTAURANT ( RES_NO,FILTER_NO, REGION_NO,  RES_NAME, RES_PHONE, RES_TIME, RES_PARKING, RES_ROAD_ADDRESS) 
VALUES ( restaurant_seq.nextval, 303, 900,'목란', '02-732-1245', '월요일 휴무, 평일 11:30-21:20', '단체석, 주차, 포장, 예약, 무선 인터넷, 남/녀 화장실 구분', '서울 서대문구 연희로15길 21');

--중식, 대구
INSERT INTO RESTAURANT ( RES_NO, FILTER_NO, REGION_NO, RES_NAME, RES_PHONE, RES_TIME, RES_PARKING, RES_ROAD_ADDRESS) 
VALUES ( restaurant_seq.nextval, 303, 902,'가야성', '053-654-0545', '매일 11:00-21:00', '단체석, 주차, 포장, 예약, 무선 인터넷, 남/녀 화장실 구분', '대구 달서구 월배로83길 7');

INSERT INTO RESTAURANT ( RES_NO,FILTER_NO, REGION_NO,  RES_NAME, RES_PHONE, RES_TIME, RES_PARKING, RES_ROAD_ADDRESS) 
VALUES ( restaurant_seq.nextval, 303, 902,'리안', '053-746-0203', '매일 11:30-21:00', '단체석, 주차, 포장, 예약, 무선 인터넷, 남/녀 화장실 구분', '대구 수성구 교학로4길 48');

--중식, 인천
INSERT INTO RESTAURANT ( RES_NO,FILTER_NO, REGION_NO,  RES_NAME, RES_PHONE, RES_TIME, RES_PARKING, RES_ROAD_ADDRESS) 
VALUES ( restaurant_seq.nextval, 303, 903,'연경', '0507-1311-7888', '매일 10:30-21:30', '단체석, 주차, 포장, 예약, 무선 인터넷, 남/녀 화장실 구분', '인천 중구 차이나타운로 41');

INSERT INTO RESTAURANT ( RES_NO,FILTER_NO, REGION_NO,  RES_NAME, RES_PHONE, RES_TIME, RES_PARKING, RES_ROAD_ADDRESS) 
VALUES ( restaurant_seq.nextval, 303, 903,'만다복', '032-773-3838', '매일 11:00-21:30', '단체석, 주차, 포장, 예약, 무선 인터넷, 남/녀 화장실 구분', '인천 중구 차이나타운로 36');

--중식, 경기
INSERT INTO RESTAURANT ( RES_NO,FILTER_NO, REGION_NO,  RES_NAME, RES_PHONE, RES_TIME, RES_PARKING, RES_ROAD_ADDRESS) 
VALUES ( restaurant_seq.nextval, 303, 908, '고구려짬뽕집', '031-317-3636', '매일 10:30-20:00', '단체석, 주차, 포장, 예약, 무선 인터넷, 남/녀 화장실 구분', '경기 시흥시 수인로 3472-22');

INSERT INTO RESTAURANT ( RES_NO,FILTER_NO, REGION_NO,  RES_NAME, RES_PHONE, RES_TIME, RES_PARKING, RES_ROAD_ADDRESS) 
VALUES ( restaurant_seq.nextval, 303, 908,'상해루', '031-8015-0102', '매일 11:00-22:00', '단체석, 주차, 포장, 예약, 무선 인터넷, 남/녀 화장실 구분', '경기 화성시 노작로 147 돌모루프라자 DM프라자');




--일식, 부산
INSERT INTO RESTAURANT ( RES_NO,FILTER_NO, REGION_NO,  RES_NAME, RES_PHONE, RES_TIME, RES_PARKING, RES_ROAD_ADDRESS) 
VALUES ( restaurant_seq.nextval, 304, 901,'갓파스시 연산점', '051-868-4377', '평일 11:30-21:30 토요일 11:30-22:00', '단체석, 주차, 포장, 예약, 무선 인터넷, 남/녀 화장실 구분', '부산 연제구 반송로 44');

--일식, 대구
INSERT INTO RESTAURANT ( RES_NO,FILTER_NO, REGION_NO,  RES_NAME, RES_PHONE, RES_TIME, RES_PARKING, RES_ROAD_ADDRESS) 
VALUES ( restaurant_seq.nextval, 304, 902,'한냐마켓또', '070-4241-8155', '평일 17:30-03:00 주말 17:00-05:00', '단체석, 주차, 포장, 예약, 무선 인터넷, 남/녀 화장실 구분', '대구 중구 동성로5길 69-1 한냐마켓또');

--일식, 인천
INSERT INTO RESTAURANT ( RES_NO, FILTER_NO, REGION_NO, RES_NAME, RES_PHONE, RES_TIME, RES_PARKING, RES_ROAD_ADDRESS) 
VALUES ( restaurant_seq.nextval, 304, 903,'스시애 2호점', '0507-1474-5572', '매일 11:30-16:00', '단체석, 주차, 포장, 예약, 무선 인터넷, 남/녀 화장실 구분', '인천 부평구 부평대로87번길 4 2층');

--일식, 경기
INSERT INTO RESTAURANT ( RES_NO, FILTER_NO, REGION_NO, RES_NAME, RES_PHONE, RES_TIME, RES_PARKING, RES_ROAD_ADDRESS)
VALUES ( restaurant_seq.nextval, 304, 908,'초밥왕', '0507-1378-8856', '매일 11:00-24:00', '단체석, 주차, 포장, 예약, 무선 인터넷, 남/녀 화장실 구분', '경기 수원시 팔달구 향교로1번길 5 지하 초밥왕');

INSERT INTO RESTAURANT ( RES_NO,FILTER_NO, REGION_NO,  RES_NAME, RES_PHONE, RES_TIME, RES_PARKING, RES_ROAD_ADDRESS) 
VALUES ( restaurant_seq.nextval, 304, 908,'에버그린', '031-425-4359', '매일 11:00-16:00 일요일 휴무', '단체석, 주차, 포장, 예약, 무선 인터넷, 남/녀 화장실 구분', '경기 안양시 동안구 인덕원로 29-16');

INSERT INTO RESTAURANT ( RES_NO,FILTER_NO, REGION_NO,  RES_NAME, RES_PHONE, RES_TIME, RES_PARKING, RES_ROAD_ADDRESS) 
VALUES ( restaurant_seq.nextval, 304, 908,'스시웨이 광명본점', '02-2616-3774', '매일 11:30-22:00 일요일 휴무', '단체석, 주차, 포장, 예약, 무선 인터넷, 남/녀 화장실 구분', '경기 광명시 가림일로 80 로즈힐빌딩3층');


--아시아 음식, 광주
INSERT INTO RESTAURANT ( RES_NO, FILTER_NO, REGION_NO, RES_NAME, RES_PHONE, RES_TIME, RES_PARKING, RES_ROAD_ADDRESS) 
VALUES ( restaurant_seq.nextval, 305, 904, '분포나인', '0507-1439-2274', '매일 11:00-21:00', '단체석, 주차, 포장, 예약, 무선 인터넷, 남/녀 화장실 구분', '광주 남구 백서로 39');

--아시아 음식, 경기
INSERT INTO RESTAURANT ( RES_NO,FILTER_NO, REGION_NO,  RES_NAME, RES_PHONE, RES_TIME, RES_PARKING, RES_ROAD_ADDRESS) 
VALUES ( restaurant_seq.nextval, 305, 908, '포레스트', '031-8003-6616', '매일 11:30-21:30', '단체석, 주차, 포장, 예약, 무선 인터넷, 남/녀 화장실 구분', '경기 화성시 동탄공원로2길 33-9 1층');

INSERT INTO RESTAURANT ( RES_NO, FILTER_NO, REGION_NO, RES_NAME, RES_PHONE, RES_TIME, RES_PARKING, RES_ROAD_ADDRESS) 
VALUES ( restaurant_seq.nextval, 305, 908,'타임포타이', '0507-1441-1145', '매일 11:00-22:00', '단체석, 주차, 포장, 예약, 무선 인터넷, 남/녀 화장실 구분', '경기 성남시 분당구 문정로144번길 5');

INSERT INTO RESTAURANT ( RES_NO,FILTER_NO, REGION_NO,  RES_NAME, RES_PHONE, RES_TIME, RES_PARKING, RES_ROAD_ADDRESS) 
VALUES ( restaurant_seq.nextval,305, 908, '아초원', '0507-1314-4490', '매일 11:00-22:00', '단체석, 주차, 포장, 예약, 무선 인터넷, 남/녀 화장실 구분', '경기 하남시 감일남로52번길 21-29');





--카페, 서울

INSERT INTO RESTAURANT ( RES_NO, FILTER_NO, REGION_NO, RES_NAME, RES_PHONE, RES_TIME, RES_PARKING, RES_ROAD_ADDRESS) 
VALUES ( restaurant_seq.nextval,306, 900, '쟝블랑제리', '02-889-5170', '매일 07:00 - 22:00', '단체석, 주차, 포장, 예약, 무선 인터넷, 남/녀 화장실 구분', '서울 관악구 낙성대역길 8');

INSERT INTO RESTAURANT ( RES_NO, FILTER_NO, REGION_NO, RES_NAME, RES_PHONE, RES_TIME, RES_PARKING, RES_ROAD_ADDRESS) 
VALUES ( restaurant_seq.nextval,306, 900, '피오니', '02-333-5325', '매일 12:00-22:00', '단체석, 주차, 포장, 예약, 무선 인터넷, 남/녀 화장실 구분', '서울 마포구 어울마당로 56');

INSERT INTO RESTAURANT ( RES_NO, FILTER_NO, REGION_NO, RES_NAME, RES_PHONE, RES_TIME, RES_PARKING, RES_ROAD_ADDRESS) 
VALUES ( restaurant_seq.nextval,306, 900, '더베이커스테이블', '070-7717-3501', '매일 08:00-21:00', '단체석, 주차, 포장, 예약, 무선 인터넷, 남/녀 화장실 구분', '서울 용산구 녹사평대로 244-1');

--카페, 부산
INSERT INTO RESTAURANT ( RES_NO,FILTER_NO, REGION_NO,  RES_NAME, RES_PHONE, RES_TIME, RES_PARKING, RES_ROAD_ADDRESS) 
VALUES ( restaurant_seq.nextval,306, 901, '웨이브온 커피', '051-727-1660', '매일 11:00-24:00', '단체석, 주차, 포장, 예약, 무선 인터넷, 남/녀 화장실 구분', '부산 기장군 장안읍 해맞이로 286 웨이브온커피');

INSERT INTO RESTAURANT ( RES_NO, FILTER_NO, REGION_NO, RES_NAME, RES_PHONE, RES_TIME, RES_PARKING, RES_ROAD_ADDRESS) 
VALUES ( restaurant_seq.nextval,306, 901, '옵스 해운대점', '051-747-6886', '매일 09:00-21:00', '단체석, 주차, 포장, 예약, 무선 인터넷, 남/녀 화장실 구분', '부산 해운대구 중동1로 31');

--카페, 대구
INSERT INTO RESTAURANT ( RES_NO, FILTER_NO, REGION_NO, RES_NAME, RES_PHONE, RES_TIME, RES_PARKING, RES_ROAD_ADDRESS) 
VALUES ( restaurant_seq.nextval,306, 902, '삼송빵집 본점', '053-254-4064', '매일 08:00-22:00', '단체석, 주차, 포장, 예약, 무선 인터넷, 남/녀 화장실 구분', '대구 중구 중앙대로 397');

--카페, 광주
INSERT INTO RESTAURANT ( RES_NO,FILTER_NO, REGION_NO,  RES_NAME, RES_PHONE, RES_TIME, RES_PARKING, RES_ROAD_ADDRESS) 
VALUES ( restaurant_seq.nextval, 306, 904,'센도리', '0507-1488-4200', '매일 11:30-22:00', '단체석, 주차, 포장, 예약, 무선 인터넷, 남/녀 화장실 구분', '광주 동구 충장로 93-6');

--카페, 인천
INSERT INTO RESTAURANT ( RES_NO,FILTER_NO, REGION_NO,  RES_NAME, RES_PHONE, RES_TIME, RES_PARKING, RES_ROAD_ADDRESS) 
VALUES ( restaurant_seq.nextval, 306, 903, '카페오라', '032-752-0888', '매일 09:30-21:00', '단체석, 주차, 포장, 예약, 무선 인터넷, 남/녀 화장실 구분', '인천 중구 용유서로 380');

INSERT INTO RESTAURANT ( RES_NO,FILTER_NO, REGION_NO,  RES_NAME, RES_PHONE, RES_TIME, RES_PARKING, RES_ROAD_ADDRESS) 
VALUES ( restaurant_seq.nextval, 306, 903,'궁전제과 충장점', '062-222-3477', '매일 10:00-21:30', '단체석, 주차, 포장, 예약, 무선 인터넷, 남/녀 화장실 구분', '인천 중구 용유서로 380');

--카페, 경기
INSERT INTO RESTAURANT ( RES_NO, FILTER_NO, REGION_NO, RES_NAME, RES_PHONE, RES_TIME, RES_PARKING, RES_ROAD_ADDRESS) 
VALUES ( restaurant_seq.nextval, 306, 908,'고당', '031-576-8090', '매일 11:00-22:00', '단체석, 주차, 포장, 예약, 무선 인터넷, 남/녀 화장실 구분', '경기 남양주시 조안면 북한강로 121 고당');

INSERT INTO RESTAURANT ( RES_NO,FILTER_NO, REGION_NO,  RES_NAME, RES_PHONE, RES_TIME, RES_PARKING, RES_ROAD_ADDRESS) 
VALUES ( restaurant_seq.nextval, 306, 908, '뱀부15-8', '0507-1409-7001', '매일 11:00-22:00', '단체석, 주차, 포장, 예약, 무선 인터넷, 남/녀 화장실 구분', '경기 김포시 하성면 금포로1915번길 7 뱀부카페 레스토랑');

INSERT INTO RESTAURANT ( RES_NO, FILTER_NO, REGION_NO, RES_NAME, RES_PHONE, RES_TIME, RES_PARKING, RES_ROAD_ADDRESS) 
VALUES ( restaurant_seq.nextval,  306, 908,'유니스의 정원', '031-437-2045', '매일 11:00-22:00', '단체석, 주차, 포장, 예약, 무선 인터넷, 남/녀 화장실 구분', '경기 안산시 상록구 반월천북길 139');

INSERT INTO RESTAURANT ( RES_NO,FILTER_NO, REGION_NO,  RES_NAME, RES_PHONE, RES_TIME, RES_PARKING, RES_ROAD_ADDRESS) 
VALUES ( restaurant_seq.nextval,  306, 908,'카페 아를', '031-837-1717', '매일 10:00-24:00', '단체석, 주차, 포장, 예약, 무선 인터넷, 남/녀 화장실 구분', '경기 의정부시 동일로 204 카페 아를');

INSERT INTO RESTAURANT ( RES_NO, FILTER_NO, REGION_NO, RES_NAME, RES_PHONE, RES_TIME, RES_PARKING, RES_ROAD_ADDRESS) 
VALUES ( restaurant_seq.nextval,  306, 908,'포레스트아웃팅스', '070-4154-8955', '매일 10:00-22:00', '단체석, 주차, 포장, 예약, 무선 인터넷, 남/녀 화장실 구분', '경기 고양시 일산동구 고양대로 1124 포레스트 아웃팅스');

INSERT INTO RESTAURANT ( RES_NO, FILTER_NO, REGION_NO, RES_NAME, RES_PHONE, RES_TIME, RES_PARKING, RES_ROAD_ADDRESS) 
VALUES ( restaurant_seq.nextval,  306, 908,'마이알레', '02-3445-1794', '매일 11:00-22:00', '단체석, 주차, 포장, 예약, 무선 인터넷, 남/녀 화장실 구분', '경기 과천시 삼부골3로 17');

--카페, 제주
INSERT INTO RESTAURANT ( RES_NO,FILTER_NO, REGION_NO,  RES_NAME, RES_PHONE, RES_TIME, RES_PARKING, RES_ROAD_ADDRESS) 
VALUES ( restaurant_seq.nextval,  306, 804, '애월더선셋', '0507-1403-5943', '매일 10:00-20:00', '단체석, 주차, 포장, 예약, 무선 인터넷, 남/녀 화장실 구분', '제주 제주시 애월읍 일주서로 6111');

INSERT INTO RESTAURANT ( RES_NO, FILTER_NO, REGION_NO, RES_NAME, RES_PHONE, RES_TIME, RES_PARKING, RES_ROAD_ADDRESS) 
VALUES ( restaurant_seq.nextval, 306, 804,'카페델문도', '064-702-00073', '매일 07:00-00:00', '단체석, 주차, 포장, 예약, 무선 인터넷, 남/녀 화장실 구분', '제주 제주시 조천읍 조함해안로 519-10');

INSERT INTO RESTAURANT ( RES_NO, FILTER_NO, REGION_NO, RES_NAME, RES_PHONE, RES_TIME, RES_PARKING, RES_ROAD_ADDRESS) 
VALUES ( restaurant_seq.nextval, 306, 804,'풍림다방 송당점', '1811-5775', '매일 10:30-18:00', '단체석, 주차, 포장, 예약, 무선 인터넷, 남/녀 화장실 구분', '제주 제주시 구좌읍 중산간동로 2267-4 풍림다방');



--분식 , 서울

INSERT INTO RESTAURANT ( RES_NO,FILTER_NO, REGION_NO,  RES_NAME, RES_PHONE, RES_TIME, RES_PARKING, RES_ROAD_ADDRESS) 
VALUES ( restaurant_seq.nextval,307, 900, '101번지 남산돈까스 본점', '02-777-7929', '매일 10:30 - 22:00', '단체석, 주차, 포장, 예약, 무선 인터넷, 남/녀 화장실 구분', '서울 중구 소파로 101');

--분식, 부산
INSERT INTO RESTAURANT ( RES_NO, FILTER_NO, REGION_NO, RES_NAME, RES_PHONE, RES_TIME, RES_PARKING, RES_ROAD_ADDRESS) 
VALUES ( restaurant_seq.nextval, 307, 901,'다리집', '051-625-0130', '매일 11:30-21:30 화요일 휴무', '단체석, 주차, 포장, 예약, 무선 인터넷, 남/녀 화장실 구분', '부산 수영구 남천바다로10번길 70 101호');

--분식, 대구
INSERT INTO RESTAURANT ( RES_NO,FILTER_NO, REGION_NO,  RES_NAME, RES_PHONE, RES_TIME, RES_PARKING, RES_ROAD_ADDRESS) 
VALUES ( restaurant_seq.nextval, 307, 902,'중앙떡볶이', '053-424-7692', '매일 11:20-20:00 목요일 휴무 셋째주', '단체석, 주차, 포장, 예약, 무선 인터넷, 남/녀 화장실 구분', '대구 중구 동성로2길 81');

--분식, 인천
INSERT INTO RESTAURANT ( RES_NO, FILTER_NO, REGION_NO, RES_NAME, RES_PHONE, RES_TIME, RES_PARKING, RES_ROAD_ADDRESS) 
VALUES ( restaurant_seq.nextval,307, 903, '잉글랜드왕돈까스', '032-772-7266', '매일 11:30-21:00', '단체석, 주차, 포장, 예약, 무선 인터넷, 남/녀 화장실 구분', '인천 중구 우현로90번길 7 혜성빌딩 2층');

--분식, 경기
INSERT INTO RESTAURANT ( RES_NO, FILTER_NO, REGION_NO, RES_NAME, RES_PHONE, RES_TIME, RES_PARKING, RES_ROAD_ADDRESS) 
VALUES ( restaurant_seq.nextval, 307, 908,'묘향만두', '02-444-3515', '매일 09:30-21:30', '단체석, 주차, 포장, 예약, 무선 인터넷, 남/녀 화장실 구분', '경기 구리시 아차산로 63');

INSERT INTO RESTAURANT ( RES_NO,FILTER_NO, REGION_NO,  RES_NAME, RES_PHONE, RES_TIME, RES_PARKING, RES_ROAD_ADDRESS) 
VALUES ( restaurant_seq.nextval,307, 908, '보영만두 북문본점', '031-242-9076', '매일 10:00-01:00', '단체석, 주차, 포장, 예약, 무선 인터넷, 남/녀 화장실 구분', '경기 수원시 장안구 팔달로 271');





--기타, 서울
INSERT INTO RESTAURANT ( RES_NO,FILTER_NO, REGION_NO,  RES_NAME, RES_PHONE, RES_TIME, RES_PARKING, RES_ROAD_ADDRESS) 
VALUES ( restaurant_seq.nextval, 308, 900,'감성타코 강남역점', '02-565-8830', '매일 11:30-22:00', '단체석, 주차, 포장, 예약, 무선 인터넷, 남/녀 화장실 구분', '강남역 11번출구 앞 글래스타워 지하1층');

INSERT INTO RESTAURANT ( RES_NO, FILTER_NO, REGION_NO, RES_NAME, RES_PHONE, RES_TIME, RES_PARKING, RES_ROAD_ADDRESS) 
VALUES ( restaurant_seq.nextval, 308, 900,'바토스 이태원점', '02-797-8226', '매일 11:30 - 22:00', '단체석, 주차, 포장, 예약, 무선 인터넷, 남/녀 화장실 구분', '서울 용산구 이태원로15길 1 2층');

--기타, 대구
INSERT INTO RESTAURANT ( RES_NO, FILTER_NO, REGION_NO, RES_NAME, RES_PHONE, RES_TIME, RES_PARKING, RES_ROAD_ADDRESS) 
VALUES ( restaurant_seq.nextval,308, 902, 'VASCO 본점', '0507-1400-9354', '매일 12:00 - 21:30', '단체석, 주차, 포장, 예약, 무선 인터넷, 남/녀 화장실 구분', '대구 중구 동성로4길 100 vasco');

--기타, 인천
INSERT INTO RESTAURANT ( RES_NO, FILTER_NO, REGION_NO, RES_NAME, RES_PHONE, RES_TIME, RES_PARKING, RES_ROAD_ADDRESS) 
VALUES ( restaurant_seq.nextval, 308, 903,'원조신포닭강정', '032-762-5853', '매일 10:30 -21:00', '단체석, 주차, 포장, 예약, 무선 인터넷, 남/녀 화장실 구분', '인천 중구 우현로49번길 3');

--기타, 광주
INSERT INTO RESTAURANT ( RES_NO,FILTER_NO, REGION_NO,  RES_NAME, RES_PHONE, RES_TIME, RES_PARKING, RES_ROAD_ADDRESS) 
VALUES ( restaurant_seq.nextval, 308, 904,'영미오리탕', '062-527-0248', '매일 09:00 -01:00', '단체석, 주차, 포장, 예약, 무선 인터넷, 남/녀 화장실 구분', '광주 북구 경양로 126');

--기타, 경기
INSERT INTO RESTAURANT ( RES_NO,FILTER_NO, REGION_NO,  RES_NAME, RES_PHONE, RES_TIME, RES_PARKING, RES_ROAD_ADDRESS) 
VALUES ( restaurant_seq.nextval, 308, 908,'낙원타코 롯데몰수원점', '031-8066-1890', '매일 10:30 -22:00', '단체석, 주차, 포장, 예약, 무선 인터넷, 남/녀 화장실 구분', '경기 수원시 권선구 세화로 134 롯데몰수원점 3층');

INSERT INTO RESTAURANT ( RES_NO,FILTER_NO, REGION_NO,  RES_NAME, RES_PHONE, RES_TIME, RES_PARKING, RES_ROAD_ADDRESS) 
VALUES ( restaurant_seq.nextval,308, 908, '온더보더 스타필드하남점', '031-8072-8682', '매일 10:00 -22:00', '단체석, 주차, 포장, 예약, 무선 인터넷, 남/녀 화장실 구분', '경기 하남시 미사대로 750 스타필드 하남 1층');

commit;
--rollback;

--최종 !!!!!!


DROP TABLE restaurant;
CREATE TABLE RESTAURANT
(
    RES_NO                  NUMBER           NOT NULL, 
    imgcheck               NUMBER            default 0,   
    FILTER_NO              NUMBER           NULL, 
    REGION_NO               NUMBER           NULL, 
    RES_NAME                VARCHAR2(50)     NULL, 
    RES_PHONE               VARCHAR2(20)     NULL, 
    RES_TIME                VARCHAR2(300)    NULL, 
    RES_PARKING             VARCHAR2(100)      NULL, 
    RES_ROAD_ADDRESS        VARCHAR2(200)    NULL,  
    CONSTRAINT PK_RESTAURANT PRIMARY KEY (RES_NO)
);
DROP SEQUENCE RESTAURANT_seq;

CREATE SEQUENCE RESTAURANT_seq
START WITH 1
INCREMENT BY 1;

drop table restaurantimg;

create table restaurantimg (
RES_IMGNO number not null,
RESTAURANT_NO number null,
RES_FILENAME varchar2(100) null,
CONSTRAINT PK_RES_IMGNO PRIMARY KEY (RES_IMGNO));

DROP SEQUENCE RESTAURANTIMG_seq;
CREATE SEQUENCE RESTAURANTIMG_SEQ
START WITH 1
INCREMENT BY 1;

--ALTER TABLE RESTAURANTIMG
--ADD CONSTRAINT FK_RES_NO FOREIGN KEY (RESTAURANT_NO)
--REFERENCES RESTAURANT (RES_NO);

--alter table restaurant add imgcheck number default 0;

--update restaurant set imgcheck = 1 WHERE res_no = 199;

--alter table restaurant drop column imgcheck;





INSERT INTO RESTAURANT ( RES_NO, imgcheck, FILTER_NO, REGION_NO, RES_NAME, RES_PHONE, RES_TIME, RES_PARKING, RES_ROAD_ADDRESS)
VALUES ( restaurant_seq.nextval, 1, 301,  900, '촌놈', '0507-1336-1011', '평일 16:00-23:00', '단체석, 주차, 포장, 예약, 무선 인터넷, 남/녀 화장실 구분', '서울 종로구 대학로8가길 48');

INSERT INTO RESTAURANT ( RES_NO,imgcheck,FILTER_NO, REGION_NO,  RES_NAME, RES_PHONE, RES_TIME, RES_PARKING, RES_ROAD_ADDRESS)
VALUES ( restaurant_seq.nextval,1, 301, 900, '우래옥', '02-2265-0151', '매일 11:30 - 21:30', '단체석, 주차, 포장, 예약, 무선 인터넷, 남/녀 화장실 구분', '서울 중구 창경궁로 62-29');

INSERT INTO RESTAURANT ( RES_NO, imgcheck, FILTER_NO, REGION_NO,  RES_NAME, RES_PHONE, RES_TIME, RES_PARKING, RES_ROAD_ADDRESS)
VALUES ( restaurant_seq.nextval,1, 301, 900, '계림', '02-2263-6658', '매일 11:30 - 21:40', '단체석, 주차, 포장, 예약, 무선 인터넷, 남/녀 화장실 구분', '서울 종로구 돈화문로4길 39');



INSERT INTO RESTAURANT ( RES_NO,imgcheck, FILTER_NO, REGION_NO,  RES_NAME, RES_PHONE, RES_TIME, RES_PARKING, RES_ROAD_ADDRESS)
VALUES ( restaurant_seq.nextval,1, 301, 901, '해운대 가야밀면', '0507-1404-9404', '매일 9:00 - 21:00', '단체석, 주차, 포장, 예약, 무선 인터넷, 남/녀 화장실 구분', '부산 해운대구 좌동순환로 27');

INSERT INTO RESTAURANT ( RES_NO,imgcheck,FILTER_NO, REGION_NO,  RES_NAME, RES_PHONE, RES_TIME, RES_PARKING, RES_ROAD_ADDRESS) 
VALUES ( restaurant_seq.nextval,1, 301, 901,'본전돼지국밥', '051-441-2946', '매일 8:30 - 21:30', '단체석, 주차, 포장, 예약, 무선 인터넷, 남/녀 화장실 구분', '부산 동구 중앙대로214번길 3-8');



INSERT INTO RESTAURANT ( RES_NO, imgcheck,FILTER_NO, REGION_NO, RES_NAME, RES_PHONE, RES_TIME, RES_PARKING, RES_ROAD_ADDRESS)
VALUES ( restaurant_seq.nextval,1, 301, 902, '용지봉', '0507-1322-8558', '매일 11:30-22:00', '단체석, 주차, 포장, 예약, 무선 인터넷, 남/녀 화장실 구분', '대구 수성구 들안로 9');


INSERT INTO RESTAURANT ( RES_NO, imgcheck,FILTER_NO, REGION_NO, RES_NAME, RES_PHONE, RES_TIME, RES_PARKING, RES_ROAD_ADDRESS) 
VALUES ( restaurant_seq.nextval,1, 301, 903,'선녀풍', '032-751-2121', '매일 12:00-21:00', '단체석, 주차, 포장, 예약, 무선 인터넷, 남/녀 화장실 구분', '인천 중구 용유서로 272');

INSERT INTO RESTAURANT ( RES_NO,imgcheck,FILTER_NO, REGION_NO,  RES_NAME, RES_PHONE, RES_TIME, RES_PARKING, RES_ROAD_ADDRESS) 
VALUES ( restaurant_seq.nextval,1, 301, 903,'동해막국수', '032-746-5522', '매일 11:00-16:00', '단체석, 주차, 포장, 예약, 무선 인터넷, 남/녀 화장실 구분', '인천 중구 용유서로479번길 16');


INSERT INTO RESTAURANT ( RES_NO,imgcheck,FILTER_NO, REGION_NO,  RES_NAME, RES_PHONE, RES_TIME, RES_PARKING, RES_ROAD_ADDRESS)
VALUES ( restaurant_seq.nextval, 1,301, 904,'나정상회', '062-944-1489', '매일 11:00-22:00', '단체석, 주차, 포장, 예약, 무선 인터넷, 남/녀 화장실 구분', '광주 서구 상무자유로 24');


INSERT INTO RESTAURANT ( RES_NO,imgcheck, FILTER_NO, REGION_NO, RES_NAME, RES_PHONE, RES_TIME, RES_PARKING, RES_ROAD_ADDRESS) 
VALUES ( restaurant_seq.nextval,1, 301, 905,'옛터민속박물관', '042-274-0016', '매일 11:00-22:00', '단체석, 주차, 포장, 예약, 무선 인터넷, 남/녀 화장실 구분', '대전 동구 산내로 321-35 옛터민속박물관');

INSERT INTO RESTAURANT ( RES_NO, imgcheck, FILTER_NO, REGION_NO, RES_NAME, RES_PHONE, RES_TIME, RES_PARKING, RES_ROAD_ADDRESS) 
VALUES ( restaurant_seq.nextval,1, 301, 905,'광천식당', '042-226-4751', '매일 10:30-21:30', '단체석, 주차, 포장, 예약, 무선 인터넷, 남/녀 화장실 구분', '대전 중구 대종로505번길 29');

INSERT INTO RESTAURANT ( RES_NO,imgcheck,FILTER_NO, REGION_NO,  RES_NAME, RES_PHONE, RES_TIME, RES_PARKING, RES_ROAD_ADDRESS)
VALUES ( restaurant_seq.nextval,1, 301, 905,'오씨칼국수', '042-627-9972', '매일 11:00-21:00', '단체석, 주차, 포장, 예약, 무선 인터넷, 남/녀 화장실 구분', '대전 동구 옛신탄진로 13');


INSERT INTO RESTAURANT ( RES_NO, imgcheck,FILTER_NO, REGION_NO, RES_NAME, RES_PHONE, RES_TIME, RES_PARKING, RES_ROAD_ADDRESS) 
VALUES ( restaurant_seq.nextval, 1,301, 906, '언양기와집불고기', '052-262-4884', '매일 12:00-22:00', '단체석, 주차, 포장, 예약, 무선 인터넷, 남/녀 화장실 구분', '울산 울주군 언양읍 헌양길 86');

INSERT INTO RESTAURANT ( RES_NO, imgcheck,FILTER_NO, REGION_NO,  RES_NAME, RES_PHONE, RES_TIME, RES_PARKING, RES_ROAD_ADDRESS) 
VALUES ( restaurant_seq.nextval,1, 301, 906,'베테랑 바베큐', '052-239-5515', '매일 12:00-22:00', '단체석, 주차, 포장, 예약, 무선 인터넷, 남/녀 화장실 구분', '울산 울주군 서생면 해맞이로 924');

INSERT INTO RESTAURANT ( RES_NO, imgcheck,FILTER_NO, REGION_NO,  RES_NAME, RES_PHONE, RES_TIME, RES_PARKING, RES_ROAD_ADDRESS) 
VALUES ( restaurant_seq.nextval, 1,301, 906, '바다바라기', '0507-1402-8866', '매일 10:00-01:00', '단체석, 주차, 포장, 예약, 무선 인터넷, 남/녀 화장실 구분', '울산 북구 정자1길 111');


INSERT INTO RESTAURANT ( RES_NO,imgcheck,FILTER_NO, REGION_NO,  RES_NAME, RES_PHONE, RES_TIME, RES_PARKING, RES_ROAD_ADDRESS) 
VALUES ( restaurant_seq.nextval, 1,301, 907,'봉머구리집', '033-631-2021', '매일 10:00-21:00', '단체석, 주차, 포장, 예약, 무선 인터넷, 남/녀 화장실 구분', '강원 속초시 영랑해안길 223 봉포머구리집');

INSERT INTO RESTAURANT ( RES_NO,imgcheck,FILTER_NO, REGION_NO,  RES_NAME, RES_PHONE, RES_TIME, RES_PARKING, RES_ROAD_ADDRESS) 
VALUES ( restaurant_seq.nextval, 1,301, 907,'강릉짬뽕순두부 동화가든 본점', '033-652-9885', '매일 07:00-19:00', '단체석, 주차, 포장, 예약, 무선 인터넷, 남/녀 화장실 구분', '강원 강릉시 초당순두부길77번길 15');

INSERT INTO RESTAURANT ( RES_NO,imgcheck, FILTER_NO, REGION_NO, RES_NAME, RES_PHONE, RES_TIME, RES_PARKING, RES_ROAD_ADDRESS) 
VALUES ( restaurant_seq.nextval,1,301, 907, '청초수물회', '033-635-5050', '매일 09:30-20:50', '단체석, 주차, 포장, 예약, 무선 인터넷, 남/녀 화장실 구분', '강원 속초시 엑스포로 12-36');


INSERT INTO RESTAURANT ( RES_NO,imgcheck,FILTER_NO, REGION_NO,  RES_NAME, RES_PHONE, RES_TIME, RES_PARKING, RES_ROAD_ADDRESS) 
VALUES ( restaurant_seq.nextval,1,301, 908, '고기리막국수', '0507-1334-1107', '매일 11:00-21:00', '단체석, 주차, 포장, 예약, 무선 인터넷, 남/녀 화장실 구분', '경기 용인시 수지구 이종무로 157');

INSERT INTO RESTAURANT ( RES_NO,imgcheck,FILTER_NO, REGION_NO,  RES_NAME, RES_PHONE, RES_TIME, RES_PARKING, RES_ROAD_ADDRESS) 
VALUES ( restaurant_seq.nextval,1, 301, 908,'김삿갓밥집', '031-559-9188', '매일 11:30-17:00', '단체석, 주차, 포장, 예약, 무선 인터넷, 남/녀 화장실 구분', '경기 남양주시 화도읍 경춘로 2483');

INSERT INTO RESTAURANT ( RES_NO,imgcheck, FILTER_NO, REGION_NO, RES_NAME, RES_PHONE, RES_TIME, RES_PARKING, RES_ROAD_ADDRESS) 
VALUES ( restaurant_seq.nextval,1, 301, 908,'남도한정식황복촌', '031-236-3130', '매일 10:30-23:00', '단체석, 주차, 포장, 예약, 무선 인터넷, 남/녀 화장실 구분', '경기 수원시 팔달구 효원로265번길 41 신흥빌딩');

INSERT INTO RESTAURANT ( RES_NO,imgcheck,FILTER_NO, REGION_NO,  RES_NAME, RES_PHONE, RES_TIME, RES_PARKING, RES_ROAD_ADDRESS) 
VALUES ( restaurant_seq.nextval,1,301, 908,'동기간', '031-581-5570', '매일 11:00-20:00', '단체석, 주차, 포장, 예약, 무선 인터넷, 남/녀 화장실 구분', '경기 가평군 가평읍 보납로 459-158 동기간');


INSERT INTO RESTAURANT ( RES_NO, imgcheck,FILTER_NO, REGION_NO, RES_NAME, RES_PHONE, RES_TIME, RES_PARKING, RES_ROAD_ADDRESS) 
VALUES ( restaurant_seq.nextval,1,301, 909, '하연옥', '055-746-0525', '매일 10:00-20:30', '단체석, 주차, 포장, 예약, 무선 인터넷, 남/녀 화장실 구분', '경남 진주시 진주대로 1317-20');

INSERT INTO RESTAURANT ( RES_NO,imgcheck, FILTER_NO, REGION_NO, RES_NAME, RES_PHONE, RES_TIME, RES_PARKING, RES_ROAD_ADDRESS) 
VALUES ( restaurant_seq.nextval,1, 301, 909,'싱싱게장', '0507-1400-5513', '매일 09:00-21:00', '단체석, 주차, 포장, 예약, 무선 인터넷, 남/녀 화장실 구분', '경남 거제시 장승포로 10');

INSERT INTO RESTAURANT ( RES_NO,imgcheck,FILTER_NO, REGION_NO,  RES_NAME, RES_PHONE, RES_TIME, RES_PARKING, RES_ROAD_ADDRESS) 
VALUES ( restaurant_seq.nextval, 1,301, 909,'울산다찌', '0507-1401-1350', '매일 12:00-22:00', '단체석, 주차, 포장, 예약, 무선 인터넷, 남/녀 화장실 구분', '경남 통영시 미수해안로 157');


INSERT INTO RESTAURANT ( RES_NO,imgcheck,FILTER_NO, REGION_NO,  RES_NAME, RES_PHONE, RES_TIME, RES_PARKING, RES_ROAD_ADDRESS) 
VALUES ( restaurant_seq.nextval, 1,301, 801,'늘봄', '0507-1400-3715', '매일 09:00-21:00', '단체석, 주차, 포장, 예약, 무선 인터넷, 남/녀 화장실 구분', '경북 경주시 보불로 107');

INSERT INTO RESTAURANT ( RES_NO,imgcheck,FILTER_NO, REGION_NO,  RES_NAME, RES_PHONE, RES_TIME, RES_PARKING, RES_ROAD_ADDRESS)
VALUES ( restaurant_seq.nextval, 1,301, 801, '마라도회식당', '0507-1333-3850', '매일 11:00-20:00', '단체석, 주차, 포장, 예약, 무선 인터넷, 남/녀 화장실 구분', '경북 포항시 북구 해안로 217-1');

INSERT INTO RESTAURANT ( RES_NO,imgcheck,FILTER_NO, REGION_NO,  RES_NAME, RES_PHONE, RES_TIME, RES_PARKING, RES_ROAD_ADDRESS) 
VALUES ( restaurant_seq.nextval,1, 301, 801, '백두산가든', '0507-1493-4545', '매일 09:00-21:00', '단체석, 주차, 포장, 예약, 무선 인터넷, 남/녀 화장실 구분', '경북 문경시 문경읍 새재로 869');


INSERT INTO RESTAURANT ( RES_NO,imgcheck, FILTER_NO, REGION_NO, RES_NAME, RES_PHONE, RES_TIME, RES_PARKING, RES_ROAD_ADDRESS) 
VALUES ( restaurant_seq.nextval,1, 301, 802,'명동게장', '0507-1353-0593', '매일 07:00-21:00', '단체석, 주차, 포장, 예약, 무선 인터넷, 남/녀 화장실 구분', '전남 여수시 봉산남4길 23-26');

INSERT INTO RESTAURANT ( RES_NO,imgcheck,FILTER_NO, REGION_NO,  RES_NAME, RES_PHONE, RES_TIME, RES_PARKING, RES_ROAD_ADDRESS) 
VALUES ( restaurant_seq.nextval,1,301, 802, '청정게장촌', '0507-1406-7855', '매일 07:30-21:00', '단체석, 주차, 포장, 예약, 무선 인터넷, 남/녀 화장실 구분', '전남 여수시 봉산남4길 23-32');

INSERT INTO RESTAURANT ( RES_NO, imgcheck,FILTER_NO, REGION_NO, RES_NAME, RES_PHONE, RES_TIME, RES_PARKING, RES_ROAD_ADDRESS) 
VALUES ( restaurant_seq.nextval,1, 301, 802,'쌍교숯불갈비 담양 본점', '0507-1316-0012', '매일 11:00-21:00', '단체석, 주차, 포장, 예약, 무선 인터넷, 남/녀 화장실 구분', '전남 담양군 봉산면 송강정로 212');


INSERT INTO RESTAURANT ( RES_NO,imgcheck,FILTER_NO, REGION_NO,  RES_NAME, RES_PHONE, RES_TIME, RES_PARKING, RES_ROAD_ADDRESS) 
VALUES ( restaurant_seq.nextval,1,301, 803, '보리나라 학원농장', '063-564-9897', '매일 11:00-20:00', '단체석, 주차, 포장, 예약, 무선 인터넷, 남/녀 화장실 구분', '전북 고창군 공음면 학원농장길 154');

INSERT INTO RESTAURANT ( RES_NO,imgcheck,FILTER_NO, REGION_NO,  RES_NAME, RES_PHONE, RES_TIME, RES_PARKING, RES_ROAD_ADDRESS) 
VALUES ( restaurant_seq.nextval,1, 301, 803,'한국집', '063-284-2224', '매일 09:30-21:00', '단체석, 주차, 포장, 예약, 무선 인터넷, 남/녀 화장실 구분', '전북 전주시 완산구 어진길 119');

INSERT INTO RESTAURANT ( RES_NO,imgcheck, FILTER_NO, REGION_NO, RES_NAME, RES_PHONE, RES_TIME, RES_PARKING, RES_ROAD_ADDRESS) 
VALUES ( restaurant_seq.nextval,1, 301, 803, '한일옥', '063-446-5491', '매일 06:0-20:30', '단체석, 주차, 포장, 예약, 무선 인터넷, 남/녀 화장실 구분', '전북 군산시 구영3길 63');

INSERT INTO RESTAURANT ( RES_NO,imgcheck,FILTER_NO, REGION_NO,  RES_NAME, RES_PHONE, RES_TIME, RES_PARKING, RES_ROAD_ADDRESS) 
VALUES ( restaurant_seq.nextval,1,301, 804, '우진해장국', '064-757-3393', '매일 06:00-22:00', '단체석, 주차, 포장, 예약, 무선 인터넷, 남/녀 화장실 구분', '제주 제주시 서사로 11');

INSERT INTO RESTAURANT ( RES_NO,imgcheck,FILTER_NO, REGION_NO,  RES_NAME, RES_PHONE, RES_TIME, RES_PARKING, RES_ROAD_ADDRESS) 
VALUES ( restaurant_seq.nextval,1, 301, 804,'올래국수', '064-742-7355', '매일 08:30-17:00', '단체석, 주차, 포장, 예약, 무선 인터넷, 남/녀 화장실 구분', '제주 제주시 귀아랑길 24');

INSERT INTO RESTAURANT ( RES_NO,imgcheck, FILTER_NO, REGION_NO, RES_NAME, RES_PHONE, RES_TIME, RES_PARKING, RES_ROAD_ADDRESS) 
VALUES ( restaurant_seq.nextval,1, 301, 804,'춘심이네 본점', '064-794-4010', '매일 10:30-20:00', '단체석, 주차, 포장, 예약, 무선 인터넷, 남/녀 화장실 구분', '제주 서귀포시 안덕면 창천중앙로24번길 16');


INSERT INTO RESTAURANT ( RES_NO,imgcheck, FILTER_NO, REGION_NO, RES_NAME, RES_PHONE, RES_TIME, RES_PARKING, RES_ROAD_ADDRESS) 
VALUES ( restaurant_seq.nextval, 1,301, 805, '안면도맛집 꽃지꽃게집', '0507-1382-1105', '매일 09:00-21:00', '단체석, 주차, 포장, 예약, 무선 인터넷, 남/녀 화장실 구분', '충남 태안군 안면읍 안면대로 3020');

INSERT INTO RESTAURANT ( RES_NO,imgcheck,FILTER_NO, REGION_NO,  RES_NAME, RES_PHONE, RES_TIME, RES_PARKING, RES_ROAD_ADDRESS) 
VALUES ( restaurant_seq.nextval,1, 301, 805, '장원막국수', '041-835-6561', '매일 11:00-17:00', '단체석, 주차, 포장, 예약, 무선 인터넷, 남/녀 화장실 구분', '충남 부여군 부여읍 나루터로62번길 20');

INSERT INTO RESTAURANT ( RES_NO,imgcheck,FILTER_NO, REGION_NO,  RES_NAME, RES_PHONE, RES_TIME, RES_PARKING, RES_ROAD_ADDRESS) 
VALUES ( restaurant_seq.nextval,1,301, 805, '숟가락반상 마실 천안본점', '041-571-7007', '매일 11:00-14:30', '단체석, 주차, 포장, 예약, 무선 인터넷, 남/녀 화장실 구분', '충남 천안시 서북구 월봉1길 50-1');


INSERT INTO RESTAURANT ( RES_NO,imgcheck, FILTER_NO, REGION_NO, RES_NAME, RES_PHONE, RES_TIME, RES_PARKING, RES_ROAD_ADDRESS) 
VALUES ( restaurant_seq.nextval,1, 301, 806,'산아래', '0507-1489-3233', '매일 12:00-21:30', '단체석, 주차, 포장, 예약, 무선 인터넷, 남/녀 화장실 구분', '충북 제천시 봉양읍 앞산로 174');


INSERT INTO RESTAURANT ( RES_NO, imgcheck,FILTER_NO, REGION_NO,  RES_NAME, RES_PHONE, RES_TIME, RES_PARKING, RES_ROAD_ADDRESS) 
VALUES ( restaurant_seq.nextval,1, 301, 806,'부부농장', '0507-1336-0841', '매일 11:00-21:00', '단체석, 주차, 포장, 예약, 무선 인터넷, 남/녀 화장실 구분', '충북 청주시 상당구 문의면 대청호반로 834-1');

INSERT INTO RESTAURANT ( RES_NO,imgcheck,FILTER_NO, REGION_NO,  RES_NAME, RES_PHONE, RES_TIME, RES_PARKING, RES_ROAD_ADDRESS) 
VALUES ( restaurant_seq.nextval,1, 301, 806,'뜰이있는집', '0507-1420-8585', '매일 11:30-08:30', '단체석, 주차, 포장, 예약, 무선 인터넷, 남/녀 화장실 구분', '충북 제천시 하소천길 176 뜰이있는집');




--양식

INSERT INTO RESTAURANT ( RES_NO, imgcheck,FILTER_NO, REGION_NO, RES_NAME, RES_PHONE, RES_TIME, RES_PARKING, RES_ROAD_ADDRESS) 
VALUES ( RESTAURANT_SEQ.NEXTVAL, 1,302, 900, '롯데호텔월드 라세느', '02-411-7811', '평일 11:30-20:00', '단체석, 주차, 포장, 예약, 무선 인터넷, 남/녀 화장실 구분', '서울 송파구 올림픽로 240 롯데호텔월드 2층');

INSERT INTO RESTAURANT ( RES_NO, imgcheck,FILTER_NO, REGION_NO, RES_NAME, RES_PHONE, RES_TIME, RES_PARKING, RES_ROAD_ADDRESS) 
VALUES ( RESTAURANT_SEQ.NEXTVAL, 1,302, 900, '바비레드 강남본점', '02-3452-1515', '매일 11:30 -22:00', '단체석, 주차, 포장, 예약, 무선 인터넷, 남/녀 화장실 구분',  '서울 강남구 봉은사로6길 39 바비레드');

INSERT INTO RESTAURANT ( RES_NO,imgcheck, FILTER_NO, REGION_NO, RES_NAME, RES_PHONE, RES_TIME, RES_PARKING, RES_ROAD_ADDRESS)
VALUES ( RESTAURANT_SEQ.NEXTVAL, 1,302, 900, '세상의모든아침', '02-2055-4442', '매일 10:00 -22:00', '단체석, 주차, 포장, 예약, 무선 인터넷, 남/녀 화장실 구분', '서울 영등포구 여의대로 24 전경련회관 50층, 51층');

--양식, 부산
INSERT INTO RESTAURANT ( RES_NO,imgcheck,FILTER_NO, REGION_NO,  RES_NAME, RES_PHONE, RES_TIME, RES_PARKING, RES_ROAD_ADDRESS) 
VALUES ( RESTAURANT_SEQ.NEXTVAL,1, 302, 901,'디에이블 광안점', '051-754-5759', '매일 11:00 -23:00', '단체석, 주차, 포장, 예약, 무선 인터넷', '부산 수영구 민락수변로 29');

--양식, 대구
INSERT INTO RESTAURANT ( RES_NO,imgcheck, FILTER_NO, REGION_NO, RES_NAME, RES_PHONE, RES_TIME, RES_PARKING, RES_ROAD_ADDRESS) 
VALUES ( RESTAURANT_SEQ.NEXTVAL,1, 302, 902,'인투', '0507-1415-3965', '매일 12:00 -21:00', '단체석, 주차, 포장, 예약, 무선 인터넷', '대구 중구 동성로4길 95');

--양식, 인천

INSERT INTO RESTAURANT ( RES_NO,imgcheck,FILTER_NO, REGION_NO,  RES_NAME, RES_PHONE, RES_TIME, RES_PARKING, RES_ROAD_ADDRESS) 
VALUES ( RESTAURANT_SEQ.NEXTVAL, 1,302, 903,'풀사이드228 송도점', '032-817-0000', '매일 11:00 -22:00', '단체석, 주차, 포장, 예약, 무선 인터넷', '인천 연수구 해돋이로 157');

--양식, 광주
INSERT INTO RESTAURANT ( RES_NO,imgcheck,FILTER_NO, REGION_NO,  RES_NAME, RES_PHONE, RES_TIME, RES_PARKING, RES_ROAD_ADDRESS) 
VALUES ( RESTAURANT_SEQ.NEXTVAL,1, 302, 904,'어나더키친 상무점', '0507-1414-9085', '매일 11:30-22:00', '단체석, 주차, 포장, 예약, 무선 인터넷', '광주 서구 시청로60번길 21-9 메가박스');

--양식, 대전
INSERT INTO RESTAURANT ( RES_NO,imgcheck, FILTER_NO, REGION_NO, RES_NAME, RES_PHONE, RES_TIME, RES_PARKING, RES_ROAD_ADDRESS) 
VALUES ( RESTAURANT_SEQ.NEXTVAL, 1,302, 905,'칸스테이크하우스 도안본점', '042-825-5284', '매일 11:30-22:00 브레이크타임 15:00-17:30 월요일 휴무', '단체석, 주차, 포장, 예약, 무선 인터넷', '대전 유성구 봉명서로 17-11');

--양식, 울산
INSERT INTO RESTAURANT ( RES_NO,imgcheck,FILTER_NO, REGION_NO,  RES_NAME, RES_PHONE, RES_TIME, RES_PARKING, RES_ROAD_ADDRESS) 
VALUES ( RESTAURANT_SEQ.NEXTVAL,1, 302, 906,'단골627', '052-294-7788', '매일 12:00-22:00 브레이크타임 15:00-16:30 월요일 휴무', '단체석, 주차, 포장, 예약, 무선 인터넷', '울산 중구 강북로 123 태화강엑소디움');

--양식, 경기
INSERT INTO RESTAURANT ( RES_NO,imgcheck,FILTER_NO, REGION_NO,  RES_NAME, RES_PHONE, RES_TIME, RES_PARKING, RES_ROAD_ADDRESS) 
VALUES ( RESTAURANT_SEQ.NEXTVAL, 1,302, 908,'잇탈리 헤이리점', '0507-1372-1448', '매일 10:00-22:30', '단체석, 주차, 포장, 예약, 무선 인터넷, 남/녀 화장실 구분', '경기 파주시 탄현면 헤이리마을길 48-9');

INSERT INTO RESTAURANT ( RES_NO,imgcheck, FILTER_NO, REGION_NO, RES_NAME, RES_PHONE, RES_TIME, RES_PARKING, RES_ROAD_ADDRESS) 
VALUES ( RESTAURANT_SEQ.NEXTVAL,1, 302, 908,'보나카바', '0507-1440-5778', '매일 11:30-21:30', '단체석, 주차, 포장, 예약, 무선 인터넷, 남/녀 화장실 구분', '경기 오산시 외삼미로152번길 57-29');

INSERT INTO RESTAURANT ( RES_NO,imgcheck,FILTER_NO, REGION_NO,  RES_NAME, RES_PHONE, RES_TIME, RES_PARKING, RES_ROAD_ADDRESS) 
VALUES ( RESTAURANT_SEQ.NEXTVAL, 1, 302, 908,'퍼들하우스', '031-766-0757', '매일 11:30-21:00', '단체석, 주차, 포장, 예약, 무선 인터넷, 남/녀 화장실 구분', '경기 광주시 초월읍 경충대로 1337-74');

--양식, 경남
INSERT INTO RESTAURANT ( RES_NO, imgcheck,FILTER_NO, REGION_NO, RES_NAME, RES_PHONE, RES_TIME, RES_PARKING, RES_ROAD_ADDRESS) 
VALUES ( RESTAURANT_SEQ.NEXTVAL, 1,302, 909, '완벽한 인생', '055-867-0108', '매일 11:00-22:00', '단체석, 주차, 포장, 예약, 무선 인터넷, 남/녀 화장실 구분', '경남 남해군 삼동면 독일로 30 완벽한인생');






--양식, 경북
INSERT INTO RESTAURANT ( RES_NO,imgcheck,FILTER_NO, REGION_NO,  RES_NAME, RES_PHONE, RES_TIME, RES_PARKING, RES_ROAD_ADDRESS) 
VALUES ( RESTAURANT_SEQ.NEXTVAL,1, 302, 801,'시즈닝', '0507-1483-7477', '매일 10:30-21:30 브레이크 타임 15:30 - 17:00 ', '단체석, 주차, 포장, 예약, 무선 인터넷, 남/녀 화장실 구분, 노키즈존', '경북 경주시 첨성로99번길 25-2');

--양식, 전남
INSERT INTO RESTAURANT ( RES_NO,imgcheck, FILTER_NO, REGION_NO, RES_NAME, RES_PHONE, RES_TIME, RES_PARKING, RES_ROAD_ADDRESS) 
VALUES ( RESTAURANT_SEQ.NEXTVAL,1, 302, 802,'영산나루', '0507-1409-2131', '매일 11:00-22:00', '단체석, 주차, 포장, 예약, 무선 인터넷, 남/녀 화장실 구분', '전남 나주시 주면2길 28');

--양식, 전북
INSERT INTO RESTAURANT ( RES_NO,imgcheck,FILTER_NO, REGION_NO,  RES_NAME, RES_PHONE, RES_TIME, RES_PARKING, RES_ROAD_ADDRESS) 
VALUES ( RESTAURANT_SEQ.NEXTVAL, 1, 302, 803,'파라디소 페르두또', '063-471-8525', '매일 11:30-22:00', '단체석, 주차, 포장, 예약, 무선 인터넷, 남/녀 화장실 구분', '전북 군산시 한밭로 76-11');

--양식, 제주
INSERT INTO RESTAURANT ( RES_NO,imgcheck,FILTER_NO, REGION_NO,  RES_NAME, RES_PHONE, RES_TIME, RES_PARKING, RES_ROAD_ADDRESS) 
VALUES ( RESTAURANT_SEQ.NEXTVAL, 1, 302, 804,'밥깡패', '064-799-8188', '매일 11:30-20:00', '단체석, 주차, 포장, 예약, 무선 인터넷, 남/녀 화장실 구분', '제주 제주시 한림읍 한림로4길 35');

--양식, 충남
INSERT INTO RESTAURANT ( RES_NO,imgcheck,FILTER_NO, REGION_NO,  RES_NAME, RES_PHONE, RES_TIME, RES_PARKING, RES_ROAD_ADDRESS) 
VALUES ( RESTAURANT_SEQ.NEXTVAL, 1, 302, 805,'마들렌 패밀리 뷔페레스토랑', '0507-1395-5315', '매일 11:30-21:30 브레이크 타임 15:00-18:00', '단체석, 주차, 포장, 예약, 무선 인터넷, 남/녀 화장실 구분', '충남 아산시 배방읍 온천대로 2230');

--양식, 충북
INSERT INTO RESTAURANT ( RES_NO,imgcheck, FILTER_NO, REGION_NO, RES_NAME, RES_PHONE, RES_TIME, RES_PARKING, RES_ROAD_ADDRESS) 
VALUES ( RESTAURANT_SEQ.NEXTVAL, 1, 302, 806,'파프리카 충북대점', '0507-1405-8068', '매일 11:00-23:00 평일 15:00 - 17:00 브레이크 타임', 
'단체석, 주차, 포장, 예약, 무선 인터넷, 남/녀 화장실 구분', '충북 청주시 서원구 1순환로 682 메가박스 충북대점 2층');





--중식

INSERT INTO RESTAURANT ( RES_NO,imgcheck,FILTER_NO, REGION_NO,  RES_NAME, RES_PHONE, RES_TIME, RES_PARKING, RES_ROAD_ADDRESS) 
VALUES ( restaurant_seq.nextval,1, 303, 900,'명동교자 본점', '02-776-5348', '평일 10:30-20:30', '단체석, 주차, 포장, 예약, 무선 인터넷, 남/녀 화장실 구분', '서울 중구 명동10길 29');

INSERT INTO RESTAURANT ( RES_NO,imgcheck,FILTER_NO, REGION_NO,  RES_NAME, RES_PHONE, RES_TIME, RES_PARKING, RES_ROAD_ADDRESS) 
VALUES ( restaurant_seq.nextval, 1,303, 900,'목란', '02-732-1245', '월요일 휴무, 평일 11:30-21:20', '단체석, 주차, 포장, 예약, 무선 인터넷, 남/녀 화장실 구분', '서울 서대문구 연희로15길 21');

--중식, 대구
INSERT INTO RESTAURANT ( RES_NO, imgcheck,FILTER_NO, REGION_NO, RES_NAME, RES_PHONE, RES_TIME, RES_PARKING, RES_ROAD_ADDRESS) 
VALUES ( restaurant_seq.nextval, 1,303, 902,'가야성', '053-654-0545', '매일 11:00-21:00', '단체석, 주차, 포장, 예약, 무선 인터넷, 남/녀 화장실 구분', '대구 달서구 월배로83길 7');

INSERT INTO RESTAURANT ( RES_NO,imgcheck,FILTER_NO, REGION_NO,  RES_NAME, RES_PHONE, RES_TIME, RES_PARKING, RES_ROAD_ADDRESS) 
VALUES ( restaurant_seq.nextval,1, 303, 902,'리안', '053-746-0203', '매일 11:30-21:00', '단체석, 주차, 포장, 예약, 무선 인터넷, 남/녀 화장실 구분', '대구 수성구 교학로4길 48');

--중식, 인천
INSERT INTO RESTAURANT ( RES_NO,imgcheck,FILTER_NO, REGION_NO,  RES_NAME, RES_PHONE, RES_TIME, RES_PARKING, RES_ROAD_ADDRESS) 
VALUES ( restaurant_seq.nextval, 1,303, 903,'연경', '0507-1311-7888', '매일 10:30-21:30', '단체석, 주차, 포장, 예약, 무선 인터넷, 남/녀 화장실 구분', '인천 중구 차이나타운로 41');

INSERT INTO RESTAURANT ( RES_NO,imgcheck,FILTER_NO, REGION_NO,  RES_NAME, RES_PHONE, RES_TIME, RES_PARKING, RES_ROAD_ADDRESS) 
VALUES ( restaurant_seq.nextval, 1,303, 903,'만다복', '032-773-3838', '매일 11:00-21:30', '단체석, 주차, 포장, 예약, 무선 인터넷, 남/녀 화장실 구분', '인천 중구 차이나타운로 36');

--중식, 경기
INSERT INTO RESTAURANT ( RES_NO,imgcheck,FILTER_NO, REGION_NO,  RES_NAME, RES_PHONE, RES_TIME, RES_PARKING, RES_ROAD_ADDRESS) 
VALUES ( restaurant_seq.nextval,1, 303, 908, '고구려짬뽕집', '031-317-3636', '매일 10:30-20:00', '단체석, 주차, 포장, 예약, 무선 인터넷, 남/녀 화장실 구분', '경기 시흥시 수인로 3472-22');

INSERT INTO RESTAURANT ( RES_NO,imgcheck,FILTER_NO, REGION_NO,  RES_NAME, RES_PHONE, RES_TIME, RES_PARKING, RES_ROAD_ADDRESS) 
VALUES ( restaurant_seq.nextval,1, 303, 908,'상해루', '031-8015-0102', '매일 11:00-22:00', '단체석, 주차, 포장, 예약, 무선 인터넷, 남/녀 화장실 구분', '경기 화성시 노작로 147 돌모루프라자 DM프라자');




--일식, 부산
INSERT INTO RESTAURANT ( RES_NO,imgcheck,FILTER_NO, REGION_NO,  RES_NAME, RES_PHONE, RES_TIME, RES_PARKING, RES_ROAD_ADDRESS) 
VALUES ( restaurant_seq.nextval, 304, 901,'갓파스시 연산점', '051-868-4377', '평일 11:30-21:30 토요일 11:30-22:00', '단체석, 주차, 포장, 예약, 무선 인터넷, 남/녀 화장실 구분', '부산 연제구 반송로 44');

--일식, 대구
INSERT INTO RESTAURANT ( RES_NO,imgcheck,FILTER_NO, REGION_NO,  RES_NAME, RES_PHONE, RES_TIME, RES_PARKING, RES_ROAD_ADDRESS) 
VALUES ( restaurant_seq.nextval, 1,304, 902,'한냐마켓또', '070-4241-8155', '평일 17:30-03:00 주말 17:00-05:00', '단체석, 주차, 포장, 예약, 무선 인터넷, 남/녀 화장실 구분', '대구 중구 동성로5길 69-1 한냐마켓또');

--일식, 인천
INSERT INTO RESTAURANT ( RES_NO,imgcheck, FILTER_NO, REGION_NO, RES_NAME, RES_PHONE, RES_TIME, RES_PARKING, RES_ROAD_ADDRESS) 
VALUES ( restaurant_seq.nextval,1, 304, 903,'스시애 2호점', '0507-1474-5572', '매일 11:30-16:00', '단체석, 주차, 포장, 예약, 무선 인터넷, 남/녀 화장실 구분', '인천 부평구 부평대로87번길 4 2층');

--일식, 경기
INSERT INTO RESTAURANT ( RES_NO,imgcheck, FILTER_NO, REGION_NO, RES_NAME, RES_PHONE, RES_TIME, RES_PARKING, RES_ROAD_ADDRESS)
VALUES ( restaurant_seq.nextval, 1,304, 908,'초밥왕', '0507-1378-8856', '매일 11:00-24:00', '단체석, 주차, 포장, 예약, 무선 인터넷, 남/녀 화장실 구분', '경기 수원시 팔달구 향교로1번길 5 지하 초밥왕');

INSERT INTO RESTAURANT ( RES_NO,imgcheck,FILTER_NO, REGION_NO,  RES_NAME, RES_PHONE, RES_TIME, RES_PARKING, RES_ROAD_ADDRESS) 
VALUES ( restaurant_seq.nextval, 1,304, 908,'에버그린', '031-425-4359', '매일 11:00-16:00 일요일 휴무', '단체석, 주차, 포장, 예약, 무선 인터넷, 남/녀 화장실 구분', '경기 안양시 동안구 인덕원로 29-16');

INSERT INTO RESTAURANT ( RES_NO,imgcheck,FILTER_NO, REGION_NO,  RES_NAME, RES_PHONE, RES_TIME, RES_PARKING, RES_ROAD_ADDRESS) 
VALUES ( restaurant_seq.nextval, 1,304, 908,'스시웨이 광명본점', '02-2616-3774', '매일 11:30-22:00 일요일 휴무', '단체석, 주차, 포장, 예약, 무선 인터넷, 남/녀 화장실 구분', '경기 광명시 가림일로 80 로즈힐빌딩3층');


--아시아 음식, 광주
INSERT INTO RESTAURANT ( RES_NO,imgcheck, FILTER_NO, REGION_NO, RES_NAME, RES_PHONE, RES_TIME, RES_PARKING, RES_ROAD_ADDRESS) 
VALUES ( restaurant_seq.nextval, 1,305, 904, '분포나인', '0507-1439-2274', '매일 11:00-21:00', '단체석, 주차, 포장, 예약, 무선 인터넷, 남/녀 화장실 구분', '광주 남구 백서로 39');

--아시아 음식, 경기
INSERT INTO RESTAURANT ( RES_NO,imgcheck,FILTER_NO, REGION_NO,  RES_NAME, RES_PHONE, RES_TIME, RES_PARKING, RES_ROAD_ADDRESS) 
VALUES ( restaurant_seq.nextval,1, 305, 908, '포레스트', '031-8003-6616', '매일 11:30-21:30', '단체석, 주차, 포장, 예약, 무선 인터넷, 남/녀 화장실 구분', '경기 화성시 동탄공원로2길 33-9 1층');

INSERT INTO RESTAURANT ( RES_NO,imgcheck, FILTER_NO, REGION_NO, RES_NAME, RES_PHONE, RES_TIME, RES_PARKING, RES_ROAD_ADDRESS) 
VALUES ( restaurant_seq.nextval,1, 305, 908,'타임포타이', '0507-1441-1145', '매일 11:00-22:00', '단체석, 주차, 포장, 예약, 무선 인터넷, 남/녀 화장실 구분', '경기 성남시 분당구 문정로144번길 5');

INSERT INTO RESTAURANT ( RES_NO,imgcheck,FILTER_NO, REGION_NO,  RES_NAME, RES_PHONE, RES_TIME, RES_PARKING, RES_ROAD_ADDRESS) 
VALUES ( restaurant_seq.nextval,1,305, 908, '아초원', '0507-1314-4490', '매일 11:00-22:00', '단체석, 주차, 포장, 예약, 무선 인터넷, 남/녀 화장실 구분', '경기 하남시 감일남로52번길 21-29');





--카페, 서울

INSERT INTO RESTAURANT ( RES_NO,imgcheck, FILTER_NO, REGION_NO, RES_NAME, RES_PHONE, RES_TIME, RES_PARKING, RES_ROAD_ADDRESS) 
VALUES ( restaurant_seq.nextval,1,306, 900, '쟝블랑제리', '02-889-5170', '매일 07:00 - 22:00', '단체석, 주차, 포장, 예약, 무선 인터넷, 남/녀 화장실 구분', '서울 관악구 낙성대역길 8');

INSERT INTO RESTAURANT ( RES_NO,imgcheck, FILTER_NO, REGION_NO, RES_NAME, RES_PHONE, RES_TIME, RES_PARKING, RES_ROAD_ADDRESS) 
VALUES ( restaurant_seq.nextval,1,306, 900, '피오니', '02-333-5325', '매일 12:00-22:00', '단체석, 주차, 포장, 예약, 무선 인터넷, 남/녀 화장실 구분', '서울 마포구 어울마당로 56');

INSERT INTO RESTAURANT ( RES_NO, imgcheck,FILTER_NO, REGION_NO, RES_NAME, RES_PHONE, RES_TIME, RES_PARKING, RES_ROAD_ADDRESS) 
VALUES ( restaurant_seq.nextval,1,306, 900, '더베이커스테이블', '070-7717-3501', '매일 08:00-21:00', '단체석, 주차, 포장, 예약, 무선 인터넷, 남/녀 화장실 구분', '서울 용산구 녹사평대로 244-1');

--카페, 부산
INSERT INTO RESTAURANT ( RES_NO,imgcheck,FILTER_NO, REGION_NO,  RES_NAME, RES_PHONE, RES_TIME, RES_PARKING, RES_ROAD_ADDRESS) 
VALUES ( restaurant_seq.nextval,1,306, 901, '웨이브온 커피', '051-727-1660', '매일 11:00-24:00', '단체석, 주차, 포장, 예약, 무선 인터넷, 남/녀 화장실 구분', '부산 기장군 장안읍 해맞이로 286 웨이브온커피');

INSERT INTO RESTAURANT ( RES_NO,imgcheck,FILTER_NO, REGION_NO, RES_NAME, RES_PHONE, RES_TIME, RES_PARKING, RES_ROAD_ADDRESS) 
VALUES ( restaurant_seq.nextval,1,306, 901, '옵스 해운대점', '051-747-6886', '매일 09:00-21:00', '단체석, 주차, 포장, 예약, 무선 인터넷, 남/녀 화장실 구분', '부산 해운대구 중동1로 31');

--카페, 대구
INSERT INTO RESTAURANT ( RES_NO,imgcheck, FILTER_NO, REGION_NO, RES_NAME, RES_PHONE, RES_TIME, RES_PARKING, RES_ROAD_ADDRESS) 
VALUES ( restaurant_seq.nextval,1,306, 902, '삼송빵집 본점', '053-254-4064', '매일 08:00-22:00', '단체석, 주차, 포장, 예약, 무선 인터넷, 남/녀 화장실 구분', '대구 중구 중앙대로 397');

--카페, 광주
INSERT INTO RESTAURANT ( RES_NO,imgcheck,FILTER_NO, REGION_NO,  RES_NAME, RES_PHONE, RES_TIME, RES_PARKING, RES_ROAD_ADDRESS) 
VALUES ( restaurant_seq.nextval, 1,306, 904,'센도리', '0507-1488-4200', '매일 11:30-22:00', '단체석, 주차, 포장, 예약, 무선 인터넷, 남/녀 화장실 구분', '광주 동구 충장로 93-6');

--카페, 인천
INSERT INTO RESTAURANT ( RES_NO,imgcheck,FILTER_NO, REGION_NO,  RES_NAME, RES_PHONE, RES_TIME, RES_PARKING, RES_ROAD_ADDRESS) 
VALUES ( restaurant_seq.nextval,1, 306, 903, '카페오라', '032-752-0888', '매일 09:30-21:00', '단체석, 주차, 포장, 예약, 무선 인터넷, 남/녀 화장실 구분', '인천 중구 용유서로 380');

INSERT INTO RESTAURANT ( RES_NO,imgcheck,FILTER_NO, REGION_NO,  RES_NAME, RES_PHONE, RES_TIME, RES_PARKING, RES_ROAD_ADDRESS) 
VALUES ( restaurant_seq.nextval,1, 306, 903,'궁전제과 충장점', '062-222-3477', '매일 10:00-21:30', '단체석, 주차, 포장, 예약, 무선 인터넷, 남/녀 화장실 구분', '인천 중구 용유서로 380');

--카페, 경기
INSERT INTO RESTAURANT ( RES_NO, imgcheck,FILTER_NO, REGION_NO, RES_NAME, RES_PHONE, RES_TIME, RES_PARKING, RES_ROAD_ADDRESS) 
VALUES ( restaurant_seq.nextval,1, 306, 908,'고당', '031-576-8090', '매일 11:00-22:00', '단체석, 주차, 포장, 예약, 무선 인터넷, 남/녀 화장실 구분', '경기 남양주시 조안면 북한강로 121 고당');

INSERT INTO RESTAURANT ( RES_NO,imgcheck,FILTER_NO, REGION_NO,  RES_NAME, RES_PHONE, RES_TIME, RES_PARKING, RES_ROAD_ADDRESS) 
VALUES ( restaurant_seq.nextval,1, 306, 908, '뱀부15-8', '0507-1409-7001', '매일 11:00-22:00', '단체석, 주차, 포장, 예약, 무선 인터넷, 남/녀 화장실 구분', '경기 김포시 하성면 금포로1915번길 7 뱀부카페&레스토랑');

INSERT INTO RESTAURANT ( RES_NO,imgcheck, FILTER_NO, REGION_NO, RES_NAME, RES_PHONE, RES_TIME, RES_PARKING, RES_ROAD_ADDRESS) 
VALUES ( restaurant_seq.nextval, 1, 306, 908,'유니스의 정원', '031-437-2045', '매일 11:00-22:00', '단체석, 주차, 포장, 예약, 무선 인터넷, 남/녀 화장실 구분', '경기 안산시 상록구 반월천북길 139');

INSERT INTO RESTAURANT ( RES_NO,imgcheck,FILTER_NO, REGION_NO,  RES_NAME, RES_PHONE, RES_TIME, RES_PARKING, RES_ROAD_ADDRESS) 
VALUES ( restaurant_seq.nextval, 1, 306, 908,'카페 아를', '031-837-1717', '매일 10:00-24:00', '단체석, 주차, 포장, 예약, 무선 인터넷, 남/녀 화장실 구분', '경기 의정부시 동일로 204 카페 아를');

INSERT INTO RESTAURANT ( RES_NO,imgcheck, FILTER_NO, REGION_NO, RES_NAME, RES_PHONE, RES_TIME, RES_PARKING, RES_ROAD_ADDRESS) 
VALUES ( restaurant_seq.nextval, 1, 306, 908,'포레스트아웃팅스', '070-4154-8955', '매일 10:00-22:00', '단체석, 주차, 포장, 예약, 무선 인터넷, 남/녀 화장실 구분', '경기 고양시 일산동구 고양대로 1124 포레스트 아웃팅스');

INSERT INTO RESTAURANT ( RES_NO, imgcheck,FILTER_NO, REGION_NO, RES_NAME, RES_PHONE, RES_TIME, RES_PARKING, RES_ROAD_ADDRESS) 
VALUES ( restaurant_seq.nextval,1,  306, 908,'마이알레', '02-3445-1794', '매일 11:00-22:00', '단체석, 주차, 포장, 예약, 무선 인터넷, 남/녀 화장실 구분', '경기 과천시 삼부골3로 17');

--카페, 제주
INSERT INTO RESTAURANT ( RES_NO,imgcheck,FILTER_NO, REGION_NO,  RES_NAME, RES_PHONE, RES_TIME, RES_PARKING, RES_ROAD_ADDRESS) 
VALUES ( restaurant_seq.nextval, 1, 306, 804, '애월더선셋', '0507-1403-5943', '매일 10:00-20:00', '단체석, 주차, 포장, 예약, 무선 인터넷, 남/녀 화장실 구분', '제주 제주시 애월읍 일주서로 6111');

INSERT INTO RESTAURANT ( RES_NO,imgcheck, FILTER_NO, REGION_NO, RES_NAME, RES_PHONE, RES_TIME, RES_PARKING, RES_ROAD_ADDRESS) 
VALUES ( restaurant_seq.nextval,1, 306, 804,'카페델문도', '064-702-00073', '매일 07:00-00:00', '단체석, 주차, 포장, 예약, 무선 인터넷, 남/녀 화장실 구분', '제주 제주시 조천읍 조함해안로 519-10');

INSERT INTO RESTAURANT ( RES_NO,imgcheck, FILTER_NO, REGION_NO, RES_NAME, RES_PHONE, RES_TIME, RES_PARKING, RES_ROAD_ADDRESS) 
VALUES ( restaurant_seq.nextval,1, 306, 804,'풍림다방 송당점', '1811-5775', '매일 10:30-18:00', '단체석, 주차, 포장, 예약, 무선 인터넷, 남/녀 화장실 구분', '제주 제주시 구좌읍 중산간동로 2267-4 풍림다방');



--분식 , 서울

INSERT INTO RESTAURANT ( RES_NO,imgcheck,FILTER_NO, REGION_NO,  RES_NAME, RES_PHONE, RES_TIME, RES_PARKING, RES_ROAD_ADDRESS) 
VALUES ( restaurant_seq.nextval,1,307, 900, '101번지 남산돈까스 본점', '02-777-7929', '매일 10:30 - 22:00', '단체석, 주차, 포장, 예약, 무선 인터넷, 남/녀 화장실 구분', '서울 중구 소파로 101');

--분식, 부산
INSERT INTO RESTAURANT ( RES_NO,imgcheck, FILTER_NO, REGION_NO, RES_NAME, RES_PHONE, RES_TIME, RES_PARKING, RES_ROAD_ADDRESS) 
VALUES ( restaurant_seq.nextval, 1,307, 901,'다리집', '051-625-0130', '매일 11:30-21:30 화요일 휴무', '단체석, 주차, 포장, 예약, 무선 인터넷, 남/녀 화장실 구분', '부산 수영구 남천바다로10번길 70 101호');

--분식, 대구
INSERT INTO RESTAURANT ( RES_NO,imgcheck,FILTER_NO, REGION_NO,  RES_NAME, RES_PHONE, RES_TIME, RES_PARKING, RES_ROAD_ADDRESS) 
VALUES ( restaurant_seq.nextval,1, 307, 902,'중앙떡볶이', '053-424-7692', '매일 11:20-20:00 목요일 휴무 셋째주', '단체석, 주차, 포장, 예약, 무선 인터넷, 남/녀 화장실 구분', '대구 중구 동성로2길 81');

--분식, 인천
INSERT INTO RESTAURANT ( RES_NO, imgcheck,FILTER_NO, REGION_NO, RES_NAME, RES_PHONE, RES_TIME, RES_PARKING, RES_ROAD_ADDRESS) 
VALUES ( restaurant_seq.nextval,1,307, 903, '잉글랜드왕돈까스', '032-772-7266', '매일 11:30-21:00', '단체석, 주차, 포장, 예약, 무선 인터넷, 남/녀 화장실 구분', '인천 중구 우현로90번길 7 혜성빌딩 2층');

--분식, 경기
INSERT INTO RESTAURANT ( RES_NO, imgcheck,FILTER_NO, REGION_NO, RES_NAME, RES_PHONE, RES_TIME, RES_PARKING, RES_ROAD_ADDRESS) 
VALUES ( restaurant_seq.nextval, 1,307, 908,'묘향만두', '02-444-3515', '매일 09:30-21:30', '단체석, 주차, 포장, 예약, 무선 인터넷, 남/녀 화장실 구분', '경기 구리시 아차산로 63');

INSERT INTO RESTAURANT ( RES_NO,imgcheck,FILTER_NO, REGION_NO,  RES_NAME, RES_PHONE, RES_TIME, RES_PARKING, RES_ROAD_ADDRESS) 
VALUES ( restaurant_seq.nextval,1,307, 908, '보영만두 북문본점', '031-242-9076', '매일 10:00-01:00', '단체석, 주차, 포장, 예약, 무선 인터넷, 남/녀 화장실 구분', '경기 수원시 장안구 팔달로 271');





--기타, 서울
INSERT INTO RESTAURANT ( RES_NO,imgcheck,FILTER_NO, REGION_NO,  RES_NAME, RES_PHONE, RES_TIME, RES_PARKING, RES_ROAD_ADDRESS) 
VALUES ( restaurant_seq.nextval, 1,308, 900,'감성타코 강남역점', '02-565-8830', '매일 11:30-22:00', '단체석, 주차, 포장, 예약, 무선 인터넷, 남/녀 화장실 구분', '강남역 11번출구 앞 글래스타워 지하1층');

INSERT INTO RESTAURANT ( RES_NO,imgcheck, FILTER_NO, REGION_NO, RES_NAME, RES_PHONE, RES_TIME, RES_PARKING, RES_ROAD_ADDRESS) 
VALUES ( restaurant_seq.nextval, 1,308, 900,'바토스 이태원점', '02-797-8226', '매일 11:30 - 22:00', '단체석, 주차, 포장, 예약, 무선 인터넷, 남/녀 화장실 구분', '서울 용산구 이태원로15길 1 2층');

--기타, 대구
INSERT INTO RESTAURANT ( RES_NO, imgcheck,FILTER_NO, REGION_NO, RES_NAME, RES_PHONE, RES_TIME, RES_PARKING, RES_ROAD_ADDRESS) 
VALUES ( restaurant_seq.nextval,1,308, 902, 'VASCO 본점', '0507-1400-9354', '매일 12:00 - 21:30', '단체석, 주차, 포장, 예약, 무선 인터넷, 남/녀 화장실 구분', '대구 중구 동성로4길 100 vasco');

--기타, 인천
INSERT INTO RESTAURANT ( RES_NO,imgcheck, FILTER_NO, REGION_NO, RES_NAME, RES_PHONE, RES_TIME, RES_PARKING, RES_ROAD_ADDRESS) 
VALUES ( restaurant_seq.nextval,1, 308, 903,'원조신포닭강정', '032-762-5853', '매일 10:30 -21:00', '단체석, 주차, 포장, 예약, 무선 인터넷, 남/녀 화장실 구분', '인천 중구 우현로49번길 3');

--기타, 광주
INSERT INTO RESTAURANT ( RES_NO,imgcheck,FILTER_NO, REGION_NO,  RES_NAME, RES_PHONE, RES_TIME, RES_PARKING, RES_ROAD_ADDRESS) 
VALUES ( restaurant_seq.nextval,1, 308, 904,'영미오리탕', '062-527-0248', '매일 09:00 -01:00', '단체석, 주차, 포장, 예약, 무선 인터넷, 남/녀 화장실 구분', '광주 북구 경양로 126');

--기타, 경기
INSERT INTO RESTAURANT ( RES_NO,imgcheck,FILTER_NO, REGION_NO,  RES_NAME, RES_PHONE, RES_TIME, RES_PARKING, RES_ROAD_ADDRESS) 
VALUES ( restaurant_seq.nextval, 1,308, 908,'낙원타코 롯데몰수원점', '031-8066-1890', '매일 10:30 -22:00', '단체석, 주차, 포장, 예약, 무선 인터넷, 남/녀 화장실 구분', '경기 수원시 권선구 세화로 134 롯데몰수원점 3층');

INSERT INTO RESTAURANT ( RES_NO,imgcheck,FILTER_NO, REGION_NO,  RES_NAME, RES_PHONE, RES_TIME, RES_PARKING, RES_ROAD_ADDRESS) 
VALUES ( restaurant_seq.nextval,1,308, 908, '온더보더 스타필드하남점', '031-8072-8682', '매일 10:00 -22:00', '단체석, 주차, 포장, 예약, 무선 인터넷, 남/녀 화장실 구분', '경기 하남시 미사대로 750 스타필드 하남 1층');

--최종 !!!!!!


DROP TABLE restaurant;
CREATE TABLE RESTAURANT
(
    RES_NO                  NUMBER           NOT NULL, 
    imgcheck               NUMBER            default 0,   
    FILTER_NO              NUMBER           NULL, 
    REGION_NO               NUMBER           NULL, 
    RES_NAME                VARCHAR2(50)     NULL, 
    RES_PHONE               VARCHAR2(20)     NULL, 
    RES_TIME                VARCHAR2(300)    NULL, 
    RES_PARKING             VARCHAR2(100)      NULL, 
    RES_ROAD_ADDRESS        VARCHAR2(200)    NULL,  
    CONSTRAINT PK_RESTAURANT PRIMARY KEY (RES_NO)
);
DROP SEQUENCE RESTAURANT_seq;

CREATE SEQUENCE RESTAURANT_seq
START WITH 1
INCREMENT BY 1;

drop table restaurantimg;

create table restaurantimg (
RES_IMGNO number not null,
RESTAURANT_NO number null,
RES_FILENAME varchar2(100) null,
CONSTRAINT PK_RES_IMGNO PRIMARY KEY (RES_IMGNO));

DROP SEQUENCE RESTAURANTIMG_seq;
CREATE SEQUENCE RESTAURANTIMG_SEQ
START WITH 1
INCREMENT BY 1;

--ALTER TABLE RESTAURANTIMG
--ADD CONSTRAINT FK_RES_NO FOREIGN KEY (RESTAURANT_NO)
--REFERENCES RESTAURANT (RES_NO);

--alter table restaurant add imgcheck number default 0;

--update restaurant set imgcheck = 1 WHERE res_no = 199;

--alter table restaurant drop column imgcheck;





INSERT INTO RESTAURANT ( RES_NO, imgcheck, FILTER_NO, REGION_NO, RES_NAME, RES_PHONE, RES_TIME, RES_PARKING, RES_ROAD_ADDRESS)
VALUES ( restaurant_seq.nextval, 1, 301,  900, '촌놈', '0507-1336-1011', '평일 16:00-23:00', '단체석, 주차, 포장, 예약, 무선 인터넷, 남/녀 화장실 구분', '서울 종로구 대학로8가길 48');

INSERT INTO RESTAURANT ( RES_NO,imgcheck,FILTER_NO, REGION_NO,  RES_NAME, RES_PHONE, RES_TIME, RES_PARKING, RES_ROAD_ADDRESS)
VALUES ( restaurant_seq.nextval,1, 301, 900, '우래옥', '02-2265-0151', '매일 11:30 - 21:30', '단체석, 주차, 포장, 예약, 무선 인터넷, 남/녀 화장실 구분', '서울 중구 창경궁로 62-29');

INSERT INTO RESTAURANT ( RES_NO, imgcheck, FILTER_NO, REGION_NO,  RES_NAME, RES_PHONE, RES_TIME, RES_PARKING, RES_ROAD_ADDRESS)
VALUES ( restaurant_seq.nextval,1, 301, 900, '계림', '02-2263-6658', '매일 11:30 - 21:40', '단체석, 주차, 포장, 예약, 무선 인터넷, 남/녀 화장실 구분', '서울 종로구 돈화문로4길 39');



INSERT INTO RESTAURANT ( RES_NO,imgcheck, FILTER_NO, REGION_NO,  RES_NAME, RES_PHONE, RES_TIME, RES_PARKING, RES_ROAD_ADDRESS)
VALUES ( restaurant_seq.nextval,1, 301, 901, '해운대 가야밀면', '0507-1404-9404', '매일 9:00 - 21:00', '단체석, 주차, 포장, 예약, 무선 인터넷, 남/녀 화장실 구분', '부산 해운대구 좌동순환로 27');

INSERT INTO RESTAURANT ( RES_NO,imgcheck,FILTER_NO, REGION_NO,  RES_NAME, RES_PHONE, RES_TIME, RES_PARKING, RES_ROAD_ADDRESS) 
VALUES ( restaurant_seq.nextval,1, 301, 901,'본전돼지국밥', '051-441-2946', '매일 8:30 - 21:30', '단체석, 주차, 포장, 예약, 무선 인터넷, 남/녀 화장실 구분', '부산 동구 중앙대로214번길 3-8');



INSERT INTO RESTAURANT ( RES_NO, imgcheck,FILTER_NO, REGION_NO, RES_NAME, RES_PHONE, RES_TIME, RES_PARKING, RES_ROAD_ADDRESS)
VALUES ( restaurant_seq.nextval,1, 301, 902, '용지봉', '0507-1322-8558', '매일 11:30-22:00', '단체석, 주차, 포장, 예약, 무선 인터넷, 남/녀 화장실 구분', '대구 수성구 들안로 9');


INSERT INTO RESTAURANT ( RES_NO, imgcheck,FILTER_NO, REGION_NO, RES_NAME, RES_PHONE, RES_TIME, RES_PARKING, RES_ROAD_ADDRESS) 
VALUES ( restaurant_seq.nextval,1, 301, 903,'선녀풍', '032-751-2121', '매일 12:00-21:00', '단체석, 주차, 포장, 예약, 무선 인터넷, 남/녀 화장실 구분', '인천 중구 용유서로 272');

INSERT INTO RESTAURANT ( RES_NO,imgcheck,FILTER_NO, REGION_NO,  RES_NAME, RES_PHONE, RES_TIME, RES_PARKING, RES_ROAD_ADDRESS) 
VALUES ( restaurant_seq.nextval,1, 301, 903,'동해막국수', '032-746-5522', '매일 11:00-16:00', '단체석, 주차, 포장, 예약, 무선 인터넷, 남/녀 화장실 구분', '인천 중구 용유서로479번길 16');


INSERT INTO RESTAURANT ( RES_NO,imgcheck,FILTER_NO, REGION_NO,  RES_NAME, RES_PHONE, RES_TIME, RES_PARKING, RES_ROAD_ADDRESS)
VALUES ( restaurant_seq.nextval, 1,301, 904,'나정상회', '062-944-1489', '매일 11:00-22:00', '단체석, 주차, 포장, 예약, 무선 인터넷, 남/녀 화장실 구분', '광주 서구 상무자유로 24');


INSERT INTO RESTAURANT ( RES_NO,imgcheck, FILTER_NO, REGION_NO, RES_NAME, RES_PHONE, RES_TIME, RES_PARKING, RES_ROAD_ADDRESS) 
VALUES ( restaurant_seq.nextval,1, 301, 905,'옛터민속박물관', '042-274-0016', '매일 11:00-22:00', '단체석, 주차, 포장, 예약, 무선 인터넷, 남/녀 화장실 구분', '대전 동구 산내로 321-35 옛터민속박물관');

INSERT INTO RESTAURANT ( RES_NO, imgcheck, FILTER_NO, REGION_NO, RES_NAME, RES_PHONE, RES_TIME, RES_PARKING, RES_ROAD_ADDRESS) 
VALUES ( restaurant_seq.nextval,1, 301, 905,'광천식당', '042-226-4751', '매일 10:30-21:30', '단체석, 주차, 포장, 예약, 무선 인터넷, 남/녀 화장실 구분', '대전 중구 대종로505번길 29');

INSERT INTO RESTAURANT ( RES_NO,imgcheck,FILTER_NO, REGION_NO,  RES_NAME, RES_PHONE, RES_TIME, RES_PARKING, RES_ROAD_ADDRESS)
VALUES ( restaurant_seq.nextval,1, 301, 905,'오씨칼국수', '042-627-9972', '매일 11:00-21:00', '단체석, 주차, 포장, 예약, 무선 인터넷, 남/녀 화장실 구분', '대전 동구 옛신탄진로 13');


INSERT INTO RESTAURANT ( RES_NO, imgcheck,FILTER_NO, REGION_NO, RES_NAME, RES_PHONE, RES_TIME, RES_PARKING, RES_ROAD_ADDRESS) 
VALUES ( restaurant_seq.nextval, 1,301, 906, '언양기와집불고기', '052-262-4884', '매일 12:00-22:00', '단체석, 주차, 포장, 예약, 무선 인터넷, 남/녀 화장실 구분', '울산 울주군 언양읍 헌양길 86');

INSERT INTO RESTAURANT ( RES_NO, imgcheck,FILTER_NO, REGION_NO,  RES_NAME, RES_PHONE, RES_TIME, RES_PARKING, RES_ROAD_ADDRESS) 
VALUES ( restaurant_seq.nextval,1, 301, 906,'베테랑 바베큐', '052-239-5515', '매일 12:00-22:00', '단체석, 주차, 포장, 예약, 무선 인터넷, 남/녀 화장실 구분', '울산 울주군 서생면 해맞이로 924');

INSERT INTO RESTAURANT ( RES_NO, imgcheck,FILTER_NO, REGION_NO,  RES_NAME, RES_PHONE, RES_TIME, RES_PARKING, RES_ROAD_ADDRESS) 
VALUES ( restaurant_seq.nextval, 1,301, 906, '바다바라기', '0507-1402-8866', '매일 10:00-01:00', '단체석, 주차, 포장, 예약, 무선 인터넷, 남/녀 화장실 구분', '울산 북구 정자1길 111');


INSERT INTO RESTAURANT ( RES_NO,imgcheck,FILTER_NO, REGION_NO,  RES_NAME, RES_PHONE, RES_TIME, RES_PARKING, RES_ROAD_ADDRESS) 
VALUES ( restaurant_seq.nextval, 1,301, 907,'봉머구리집', '033-631-2021', '매일 10:00-21:00', '단체석, 주차, 포장, 예약, 무선 인터넷, 남/녀 화장실 구분', '강원 속초시 영랑해안길 223 봉포머구리집');

INSERT INTO RESTAURANT ( RES_NO,imgcheck,FILTER_NO, REGION_NO,  RES_NAME, RES_PHONE, RES_TIME, RES_PARKING, RES_ROAD_ADDRESS) 
VALUES ( restaurant_seq.nextval, 1,301, 907,'강릉짬뽕순두부 동화가든 본점', '033-652-9885', '매일 07:00-19:00', '단체석, 주차, 포장, 예약, 무선 인터넷, 남/녀 화장실 구분', '강원 강릉시 초당순두부길77번길 15');

INSERT INTO RESTAURANT ( RES_NO,imgcheck, FILTER_NO, REGION_NO, RES_NAME, RES_PHONE, RES_TIME, RES_PARKING, RES_ROAD_ADDRESS) 
VALUES ( restaurant_seq.nextval,1,301, 907, '청초수물회', '033-635-5050', '매일 09:30-20:50', '단체석, 주차, 포장, 예약, 무선 인터넷, 남/녀 화장실 구분', '강원 속초시 엑스포로 12-36');


INSERT INTO RESTAURANT ( RES_NO,imgcheck,FILTER_NO, REGION_NO,  RES_NAME, RES_PHONE, RES_TIME, RES_PARKING, RES_ROAD_ADDRESS) 
VALUES ( restaurant_seq.nextval,1,301, 908, '고기리막국수', '0507-1334-1107', '매일 11:00-21:00', '단체석, 주차, 포장, 예약, 무선 인터넷, 남/녀 화장실 구분', '경기 용인시 수지구 이종무로 157');

INSERT INTO RESTAURANT ( RES_NO,imgcheck,FILTER_NO, REGION_NO,  RES_NAME, RES_PHONE, RES_TIME, RES_PARKING, RES_ROAD_ADDRESS) 
VALUES ( restaurant_seq.nextval,1, 301, 908,'김삿갓밥집', '031-559-9188', '매일 11:30-17:00', '단체석, 주차, 포장, 예약, 무선 인터넷, 남/녀 화장실 구분', '경기 남양주시 화도읍 경춘로 2483');

INSERT INTO RESTAURANT ( RES_NO,imgcheck, FILTER_NO, REGION_NO, RES_NAME, RES_PHONE, RES_TIME, RES_PARKING, RES_ROAD_ADDRESS) 
VALUES ( restaurant_seq.nextval,1, 301, 908,'남도한정식황복촌', '031-236-3130', '매일 10:30-23:00', '단체석, 주차, 포장, 예약, 무선 인터넷, 남/녀 화장실 구분', '경기 수원시 팔달구 효원로265번길 41 신흥빌딩');

INSERT INTO RESTAURANT ( RES_NO,imgcheck,FILTER_NO, REGION_NO,  RES_NAME, RES_PHONE, RES_TIME, RES_PARKING, RES_ROAD_ADDRESS) 
VALUES ( restaurant_seq.nextval,1,301, 908,'동기간', '031-581-5570', '매일 11:00-20:00', '단체석, 주차, 포장, 예약, 무선 인터넷, 남/녀 화장실 구분', '경기 가평군 가평읍 보납로 459-158 동기간');


INSERT INTO RESTAURANT ( RES_NO, imgcheck,FILTER_NO, REGION_NO, RES_NAME, RES_PHONE, RES_TIME, RES_PARKING, RES_ROAD_ADDRESS) 
VALUES ( restaurant_seq.nextval,1,301, 909, '하연옥', '055-746-0525', '매일 10:00-20:30', '단체석, 주차, 포장, 예약, 무선 인터넷, 남/녀 화장실 구분', '경남 진주시 진주대로 1317-20');

INSERT INTO RESTAURANT ( RES_NO,imgcheck, FILTER_NO, REGION_NO, RES_NAME, RES_PHONE, RES_TIME, RES_PARKING, RES_ROAD_ADDRESS) 
VALUES ( restaurant_seq.nextval,1, 301, 909,'싱싱게장', '0507-1400-5513', '매일 09:00-21:00', '단체석, 주차, 포장, 예약, 무선 인터넷, 남/녀 화장실 구분', '경남 거제시 장승포로 10');

INSERT INTO RESTAURANT ( RES_NO,imgcheck,FILTER_NO, REGION_NO,  RES_NAME, RES_PHONE, RES_TIME, RES_PARKING, RES_ROAD_ADDRESS) 
VALUES ( restaurant_seq.nextval, 1,301, 909,'울산다찌', '0507-1401-1350', '매일 12:00-22:00', '단체석, 주차, 포장, 예약, 무선 인터넷, 남/녀 화장실 구분', '경남 통영시 미수해안로 157');


INSERT INTO RESTAURANT ( RES_NO,imgcheck,FILTER_NO, REGION_NO,  RES_NAME, RES_PHONE, RES_TIME, RES_PARKING, RES_ROAD_ADDRESS) 
VALUES ( restaurant_seq.nextval, 1,301, 801,'늘봄', '0507-1400-3715', '매일 09:00-21:00', '단체석, 주차, 포장, 예약, 무선 인터넷, 남/녀 화장실 구분', '경북 경주시 보불로 107');

INSERT INTO RESTAURANT ( RES_NO,imgcheck,FILTER_NO, REGION_NO,  RES_NAME, RES_PHONE, RES_TIME, RES_PARKING, RES_ROAD_ADDRESS)
VALUES ( restaurant_seq.nextval, 1,301, 801, '마라도회식당', '0507-1333-3850', '매일 11:00-20:00', '단체석, 주차, 포장, 예약, 무선 인터넷, 남/녀 화장실 구분', '경북 포항시 북구 해안로 217-1');

INSERT INTO RESTAURANT ( RES_NO,imgcheck,FILTER_NO, REGION_NO,  RES_NAME, RES_PHONE, RES_TIME, RES_PARKING, RES_ROAD_ADDRESS) 
VALUES ( restaurant_seq.nextval,1, 301, 801, '백두산가든', '0507-1493-4545', '매일 09:00-21:00', '단체석, 주차, 포장, 예약, 무선 인터넷, 남/녀 화장실 구분', '경북 문경시 문경읍 새재로 869');


INSERT INTO RESTAURANT ( RES_NO,imgcheck, FILTER_NO, REGION_NO, RES_NAME, RES_PHONE, RES_TIME, RES_PARKING, RES_ROAD_ADDRESS) 
VALUES ( restaurant_seq.nextval,1, 301, 802,'명동게장', '0507-1353-0593', '매일 07:00-21:00', '단체석, 주차, 포장, 예약, 무선 인터넷, 남/녀 화장실 구분', '전남 여수시 봉산남4길 23-26');

INSERT INTO RESTAURANT ( RES_NO,imgcheck,FILTER_NO, REGION_NO,  RES_NAME, RES_PHONE, RES_TIME, RES_PARKING, RES_ROAD_ADDRESS) 
VALUES ( restaurant_seq.nextval,1,301, 802, '청정게장촌', '0507-1406-7855', '매일 07:30-21:00', '단체석, 주차, 포장, 예약, 무선 인터넷, 남/녀 화장실 구분', '전남 여수시 봉산남4길 23-32');

INSERT INTO RESTAURANT ( RES_NO, imgcheck,FILTER_NO, REGION_NO, RES_NAME, RES_PHONE, RES_TIME, RES_PARKING, RES_ROAD_ADDRESS) 
VALUES ( restaurant_seq.nextval,1, 301, 802,'쌍교숯불갈비 담양 본점', '0507-1316-0012', '매일 11:00-21:00', '단체석, 주차, 포장, 예약, 무선 인터넷, 남/녀 화장실 구분', '전남 담양군 봉산면 송강정로 212');


INSERT INTO RESTAURANT ( RES_NO,imgcheck,FILTER_NO, REGION_NO,  RES_NAME, RES_PHONE, RES_TIME, RES_PARKING, RES_ROAD_ADDRESS) 
VALUES ( restaurant_seq.nextval,1,301, 803, '보리나라 학원농장', '063-564-9897', '매일 11:00-20:00', '단체석, 주차, 포장, 예약, 무선 인터넷, 남/녀 화장실 구분', '전북 고창군 공음면 학원농장길 154');

INSERT INTO RESTAURANT ( RES_NO,imgcheck,FILTER_NO, REGION_NO,  RES_NAME, RES_PHONE, RES_TIME, RES_PARKING, RES_ROAD_ADDRESS) 
VALUES ( restaurant_seq.nextval,1, 301, 803,'한국집', '063-284-2224', '매일 09:30-21:00', '단체석, 주차, 포장, 예약, 무선 인터넷, 남/녀 화장실 구분', '전북 전주시 완산구 어진길 119');

INSERT INTO RESTAURANT ( RES_NO,imgcheck, FILTER_NO, REGION_NO, RES_NAME, RES_PHONE, RES_TIME, RES_PARKING, RES_ROAD_ADDRESS) 
VALUES ( restaurant_seq.nextval,1, 301, 803, '한일옥', '063-446-5491', '매일 06:0-20:30', '단체석, 주차, 포장, 예약, 무선 인터넷, 남/녀 화장실 구분', '전북 군산시 구영3길 63');

INSERT INTO RESTAURANT ( RES_NO,imgcheck,FILTER_NO, REGION_NO,  RES_NAME, RES_PHONE, RES_TIME, RES_PARKING, RES_ROAD_ADDRESS) 
VALUES ( restaurant_seq.nextval,1,301, 804, '우진해장국', '064-757-3393', '매일 06:00-22:00', '단체석, 주차, 포장, 예약, 무선 인터넷, 남/녀 화장실 구분', '제주 제주시 서사로 11');

INSERT INTO RESTAURANT ( RES_NO,imgcheck,FILTER_NO, REGION_NO,  RES_NAME, RES_PHONE, RES_TIME, RES_PARKING, RES_ROAD_ADDRESS) 
VALUES ( restaurant_seq.nextval,1, 301, 804,'올래국수', '064-742-7355', '매일 08:30-17:00', '단체석, 주차, 포장, 예약, 무선 인터넷, 남/녀 화장실 구분', '제주 제주시 귀아랑길 24');

INSERT INTO RESTAURANT ( RES_NO,imgcheck, FILTER_NO, REGION_NO, RES_NAME, RES_PHONE, RES_TIME, RES_PARKING, RES_ROAD_ADDRESS) 
VALUES ( restaurant_seq.nextval,1, 301, 804,'춘심이네 본점', '064-794-4010', '매일 10:30-20:00', '단체석, 주차, 포장, 예약, 무선 인터넷, 남/녀 화장실 구분', '제주 서귀포시 안덕면 창천중앙로24번길 16');


INSERT INTO RESTAURANT ( RES_NO,imgcheck, FILTER_NO, REGION_NO, RES_NAME, RES_PHONE, RES_TIME, RES_PARKING, RES_ROAD_ADDRESS) 
VALUES ( restaurant_seq.nextval, 1,301, 805, '안면도맛집 꽃지꽃게집', '0507-1382-1105', '매일 09:00-21:00', '단체석, 주차, 포장, 예약, 무선 인터넷, 남/녀 화장실 구분', '충남 태안군 안면읍 안면대로 3020');

INSERT INTO RESTAURANT ( RES_NO,imgcheck,FILTER_NO, REGION_NO,  RES_NAME, RES_PHONE, RES_TIME, RES_PARKING, RES_ROAD_ADDRESS) 
VALUES ( restaurant_seq.nextval,1, 301, 805, '장원막국수', '041-835-6561', '매일 11:00-17:00', '단체석, 주차, 포장, 예약, 무선 인터넷, 남/녀 화장실 구분', '충남 부여군 부여읍 나루터로62번길 20');

INSERT INTO RESTAURANT ( RES_NO,imgcheck,FILTER_NO, REGION_NO,  RES_NAME, RES_PHONE, RES_TIME, RES_PARKING, RES_ROAD_ADDRESS) 
VALUES ( restaurant_seq.nextval,1,301, 805, '숟가락반상 마실 천안본점', '041-571-7007', '매일 11:00-14:30', '단체석, 주차, 포장, 예약, 무선 인터넷, 남/녀 화장실 구분', '충남 천안시 서북구 월봉1길 50-1');


INSERT INTO RESTAURANT ( RES_NO,imgcheck, FILTER_NO, REGION_NO, RES_NAME, RES_PHONE, RES_TIME, RES_PARKING, RES_ROAD_ADDRESS) 
VALUES ( restaurant_seq.nextval,1, 301, 806,'산아래', '0507-1489-3233', '매일 12:00-21:30', '단체석, 주차, 포장, 예약, 무선 인터넷, 남/녀 화장실 구분', '충북 제천시 봉양읍 앞산로 174');


INSERT INTO RESTAURANT ( RES_NO, imgcheck,FILTER_NO, REGION_NO,  RES_NAME, RES_PHONE, RES_TIME, RES_PARKING, RES_ROAD_ADDRESS) 
VALUES ( restaurant_seq.nextval,1, 301, 806,'부부농장', '0507-1336-0841', '매일 11:00-21:00', '단체석, 주차, 포장, 예약, 무선 인터넷, 남/녀 화장실 구분', '충북 청주시 상당구 문의면 대청호반로 834-1');

INSERT INTO RESTAURANT ( RES_NO,imgcheck,FILTER_NO, REGION_NO,  RES_NAME, RES_PHONE, RES_TIME, RES_PARKING, RES_ROAD_ADDRESS) 
VALUES ( restaurant_seq.nextval,1, 301, 806,'뜰이있는집', '0507-1420-8585', '매일 11:30-08:30', '단체석, 주차, 포장, 예약, 무선 인터넷, 남/녀 화장실 구분', '충북 제천시 하소천길 176 뜰이있는집');




--양식

INSERT INTO RESTAURANT ( RES_NO, imgcheck,FILTER_NO, REGION_NO, RES_NAME, RES_PHONE, RES_TIME, RES_PARKING, RES_ROAD_ADDRESS) 
VALUES ( RESTAURANT_SEQ.NEXTVAL, 1,302, 900, '롯데호텔월드 라세느', '02-411-7811', '평일 11:30-20:00', '단체석, 주차, 포장, 예약, 무선 인터넷, 남/녀 화장실 구분', '서울 송파구 올림픽로 240 롯데호텔월드 2층');

INSERT INTO RESTAURANT ( RES_NO, imgcheck,FILTER_NO, REGION_NO, RES_NAME, RES_PHONE, RES_TIME, RES_PARKING, RES_ROAD_ADDRESS) 
VALUES ( RESTAURANT_SEQ.NEXTVAL, 1,302, 900, '바비레드 강남본점', '02-3452-1515', '매일 11:30 -22:00', '단체석, 주차, 포장, 예약, 무선 인터넷, 남/녀 화장실 구분',  '서울 강남구 봉은사로6길 39 바비레드');

INSERT INTO RESTAURANT ( RES_NO,imgcheck, FILTER_NO, REGION_NO, RES_NAME, RES_PHONE, RES_TIME, RES_PARKING, RES_ROAD_ADDRESS)
VALUES ( RESTAURANT_SEQ.NEXTVAL, 1,302, 900, '세상의모든아침', '02-2055-4442', '매일 10:00 -22:00', '단체석, 주차, 포장, 예약, 무선 인터넷, 남/녀 화장실 구분', '서울 영등포구 여의대로 24 전경련회관 50층, 51층');

--양식, 부산
INSERT INTO RESTAURANT ( RES_NO,imgcheck,FILTER_NO, REGION_NO,  RES_NAME, RES_PHONE, RES_TIME, RES_PARKING, RES_ROAD_ADDRESS) 
VALUES ( RESTAURANT_SEQ.NEXTVAL,1, 302, 901,'디에이블 광안점', '051-754-5759', '매일 11:00 -23:00', '단체석, 주차, 포장, 예약, 무선 인터넷', '부산 수영구 민락수변로 29');

--양식, 대구
INSERT INTO RESTAURANT ( RES_NO,imgcheck, FILTER_NO, REGION_NO, RES_NAME, RES_PHONE, RES_TIME, RES_PARKING, RES_ROAD_ADDRESS) 
VALUES ( RESTAURANT_SEQ.NEXTVAL,1, 302, 902,'인투', '0507-1415-3965', '매일 12:00 -21:00', '단체석, 주차, 포장, 예약, 무선 인터넷', '대구 중구 동성로4길 95');

--양식, 인천

INSERT INTO RESTAURANT ( RES_NO,imgcheck,FILTER_NO, REGION_NO,  RES_NAME, RES_PHONE, RES_TIME, RES_PARKING, RES_ROAD_ADDRESS) 
VALUES ( RESTAURANT_SEQ.NEXTVAL, 1,302, 903,'풀사이드228 송도점', '032-817-0000', '매일 11:00 -22:00', '단체석, 주차, 포장, 예약, 무선 인터넷', '인천 연수구 해돋이로 157');

--양식, 광주
INSERT INTO RESTAURANT ( RES_NO,imgcheck,FILTER_NO, REGION_NO,  RES_NAME, RES_PHONE, RES_TIME, RES_PARKING, RES_ROAD_ADDRESS) 
VALUES ( RESTAURANT_SEQ.NEXTVAL,1, 302, 904,'어나더키친 상무점', '0507-1414-9085', '매일 11:30-22:00', '단체석, 주차, 포장, 예약, 무선 인터넷', '광주 서구 시청로60번길 21-9 메가박스');

--양식, 대전
INSERT INTO RESTAURANT ( RES_NO,imgcheck, FILTER_NO, REGION_NO, RES_NAME, RES_PHONE, RES_TIME, RES_PARKING, RES_ROAD_ADDRESS) 
VALUES ( RESTAURANT_SEQ.NEXTVAL, 1,302, 905,'칸스테이크하우스 도안본점', '042-825-5284', '매일 11:30-22:00 브레이크타임 15:00-17:30 월요일 휴무', '단체석, 주차, 포장, 예약, 무선 인터넷', '대전 유성구 봉명서로 17-11');

--양식, 울산
INSERT INTO RESTAURANT ( RES_NO,imgcheck,FILTER_NO, REGION_NO,  RES_NAME, RES_PHONE, RES_TIME, RES_PARKING, RES_ROAD_ADDRESS) 
VALUES ( RESTAURANT_SEQ.NEXTVAL,1, 302, 906,'단골627', '052-294-7788', '매일 12:00-22:00 브레이크타임 15:00-16:30 월요일 휴무', '단체석, 주차, 포장, 예약, 무선 인터넷', '울산 중구 강북로 123 태화강엑소디움');

--양식, 경기
INSERT INTO RESTAURANT ( RES_NO,imgcheck,FILTER_NO, REGION_NO,  RES_NAME, RES_PHONE, RES_TIME, RES_PARKING, RES_ROAD_ADDRESS) 
VALUES ( RESTAURANT_SEQ.NEXTVAL, 1,302, 908,'잇탈리 헤이리점', '0507-1372-1448', '매일 10:00-22:30', '단체석, 주차, 포장, 예약, 무선 인터넷, 남/녀 화장실 구분', '경기 파주시 탄현면 헤이리마을길 48-9');

INSERT INTO RESTAURANT ( RES_NO,imgcheck, FILTER_NO, REGION_NO, RES_NAME, RES_PHONE, RES_TIME, RES_PARKING, RES_ROAD_ADDRESS) 
VALUES ( RESTAURANT_SEQ.NEXTVAL,1, 302, 908,'보나카바', '0507-1440-5778', '매일 11:30-21:30', '단체석, 주차, 포장, 예약, 무선 인터넷, 남/녀 화장실 구분', '경기 오산시 외삼미로152번길 57-29');

INSERT INTO RESTAURANT ( RES_NO,imgcheck,FILTER_NO, REGION_NO,  RES_NAME, RES_PHONE, RES_TIME, RES_PARKING, RES_ROAD_ADDRESS) 
VALUES ( RESTAURANT_SEQ.NEXTVAL, 1, 302, 908,'퍼들하우스', '031-766-0757', '매일 11:30-21:00', '단체석, 주차, 포장, 예약, 무선 인터넷, 남/녀 화장실 구분', '경기 광주시 초월읍 경충대로 1337-74');

--양식, 경남
INSERT INTO RESTAURANT ( RES_NO, imgcheck,FILTER_NO, REGION_NO, RES_NAME, RES_PHONE, RES_TIME, RES_PARKING, RES_ROAD_ADDRESS) 
VALUES ( RESTAURANT_SEQ.NEXTVAL, 1,302, 909, '완벽한 인생', '055-867-0108', '매일 11:00-22:00', '단체석, 주차, 포장, 예약, 무선 인터넷, 남/녀 화장실 구분', '경남 남해군 삼동면 독일로 30 완벽한인생');






--양식, 경북
INSERT INTO RESTAURANT ( RES_NO,imgcheck,FILTER_NO, REGION_NO,  RES_NAME, RES_PHONE, RES_TIME, RES_PARKING, RES_ROAD_ADDRESS) 
VALUES ( RESTAURANT_SEQ.NEXTVAL,1, 302, 801,'시즈닝', '0507-1483-7477', '매일 10:30-21:30 브레이크 타임 15:30 - 17:00 ', '단체석, 주차, 포장, 예약, 무선 인터넷, 남/녀 화장실 구분, 노키즈존', '경북 경주시 첨성로99번길 25-2');

--양식, 전남
INSERT INTO RESTAURANT ( RES_NO,imgcheck, FILTER_NO, REGION_NO, RES_NAME, RES_PHONE, RES_TIME, RES_PARKING, RES_ROAD_ADDRESS) 
VALUES ( RESTAURANT_SEQ.NEXTVAL,1, 302, 802,'영산나루', '0507-1409-2131', '매일 11:00-22:00', '단체석, 주차, 포장, 예약, 무선 인터넷, 남/녀 화장실 구분', '전남 나주시 주면2길 28');

--양식, 전북
INSERT INTO RESTAURANT ( RES_NO,imgcheck,FILTER_NO, REGION_NO,  RES_NAME, RES_PHONE, RES_TIME, RES_PARKING, RES_ROAD_ADDRESS) 
VALUES ( RESTAURANT_SEQ.NEXTVAL, 1, 302, 803,'파라디소 페르두또', '063-471-8525', '매일 11:30-22:00', '단체석, 주차, 포장, 예약, 무선 인터넷, 남/녀 화장실 구분', '전북 군산시 한밭로 76-11');

--양식, 제주
INSERT INTO RESTAURANT ( RES_NO,imgcheck,FILTER_NO, REGION_NO,  RES_NAME, RES_PHONE, RES_TIME, RES_PARKING, RES_ROAD_ADDRESS) 
VALUES ( RESTAURANT_SEQ.NEXTVAL, 1, 302, 804,'밥깡패', '064-799-8188', '매일 11:30-20:00', '단체석, 주차, 포장, 예약, 무선 인터넷, 남/녀 화장실 구분', '제주 제주시 한림읍 한림로4길 35');

--양식, 충남
INSERT INTO RESTAURANT ( RES_NO,imgcheck,FILTER_NO, REGION_NO,  RES_NAME, RES_PHONE, RES_TIME, RES_PARKING, RES_ROAD_ADDRESS) 
VALUES ( RESTAURANT_SEQ.NEXTVAL, 1, 302, 805,'마들렌 패밀리 뷔페레스토랑', '0507-1395-5315', '매일 11:30-21:30 브레이크 타임 15:00-18:00', '단체석, 주차, 포장, 예약, 무선 인터넷, 남/녀 화장실 구분', '충남 아산시 배방읍 온천대로 2230');

--양식, 충북
INSERT INTO RESTAURANT ( RES_NO,imgcheck, FILTER_NO, REGION_NO, RES_NAME, RES_PHONE, RES_TIME, RES_PARKING, RES_ROAD_ADDRESS) 
VALUES ( RESTAURANT_SEQ.NEXTVAL, 1, 302, 806,'파프리카 충북대점', '0507-1405-8068', '매일 11:00-23:00 평일 15:00 - 17:00 브레이크 타임', 
'단체석, 주차, 포장, 예약, 무선 인터넷, 남/녀 화장실 구분', '충북 청주시 서원구 1순환로 682 메가박스 충북대점 2층');





--중식

INSERT INTO RESTAURANT ( RES_NO,imgcheck,FILTER_NO, REGION_NO,  RES_NAME, RES_PHONE, RES_TIME, RES_PARKING, RES_ROAD_ADDRESS) 
VALUES ( restaurant_seq.nextval,1, 303, 900,'명동교자 본점', '02-776-5348', '평일 10:30-20:30', '단체석, 주차, 포장, 예약, 무선 인터넷, 남/녀 화장실 구분', '서울 중구 명동10길 29');

INSERT INTO RESTAURANT ( RES_NO,imgcheck,FILTER_NO, REGION_NO,  RES_NAME, RES_PHONE, RES_TIME, RES_PARKING, RES_ROAD_ADDRESS) 
VALUES ( restaurant_seq.nextval, 1,303, 900,'목란', '02-732-1245', '월요일 휴무, 평일 11:30-21:20', '단체석, 주차, 포장, 예약, 무선 인터넷, 남/녀 화장실 구분', '서울 서대문구 연희로15길 21');

--중식, 대구
INSERT INTO RESTAURANT ( RES_NO, imgcheck,FILTER_NO, REGION_NO, RES_NAME, RES_PHONE, RES_TIME, RES_PARKING, RES_ROAD_ADDRESS) 
VALUES ( restaurant_seq.nextval, 1,303, 902,'가야성', '053-654-0545', '매일 11:00-21:00', '단체석, 주차, 포장, 예약, 무선 인터넷, 남/녀 화장실 구분', '대구 달서구 월배로83길 7');

INSERT INTO RESTAURANT ( RES_NO,imgcheck,FILTER_NO, REGION_NO,  RES_NAME, RES_PHONE, RES_TIME, RES_PARKING, RES_ROAD_ADDRESS) 
VALUES ( restaurant_seq.nextval,1, 303, 902,'리안', '053-746-0203', '매일 11:30-21:00', '단체석, 주차, 포장, 예약, 무선 인터넷, 남/녀 화장실 구분', '대구 수성구 교학로4길 48');

--중식, 인천
INSERT INTO RESTAURANT ( RES_NO,imgcheck,FILTER_NO, REGION_NO,  RES_NAME, RES_PHONE, RES_TIME, RES_PARKING, RES_ROAD_ADDRESS) 
VALUES ( restaurant_seq.nextval, 1,303, 903,'연경', '0507-1311-7888', '매일 10:30-21:30', '단체석, 주차, 포장, 예약, 무선 인터넷, 남/녀 화장실 구분', '인천 중구 차이나타운로 41');

INSERT INTO RESTAURANT ( RES_NO,imgcheck,FILTER_NO, REGION_NO,  RES_NAME, RES_PHONE, RES_TIME, RES_PARKING, RES_ROAD_ADDRESS) 
VALUES ( restaurant_seq.nextval, 1,303, 903,'만다복', '032-773-3838', '매일 11:00-21:30', '단체석, 주차, 포장, 예약, 무선 인터넷, 남/녀 화장실 구분', '인천 중구 차이나타운로 36');

--중식, 경기
INSERT INTO RESTAURANT ( RES_NO,imgcheck,FILTER_NO, REGION_NO,  RES_NAME, RES_PHONE, RES_TIME, RES_PARKING, RES_ROAD_ADDRESS) 
VALUES ( restaurant_seq.nextval,1, 303, 908, '고구려짬뽕집', '031-317-3636', '매일 10:30-20:00', '단체석, 주차, 포장, 예약, 무선 인터넷, 남/녀 화장실 구분', '경기 시흥시 수인로 3472-22');

INSERT INTO RESTAURANT ( RES_NO,imgcheck,FILTER_NO, REGION_NO,  RES_NAME, RES_PHONE, RES_TIME, RES_PARKING, RES_ROAD_ADDRESS) 
VALUES ( restaurant_seq.nextval,1, 303, 908,'상해루', '031-8015-0102', '매일 11:00-22:00', '단체석, 주차, 포장, 예약, 무선 인터넷, 남/녀 화장실 구분', '경기 화성시 노작로 147 돌모루프라자 DM프라자');




--일식, 부산
INSERT INTO RESTAURANT ( RES_NO,imgcheck,FILTER_NO, REGION_NO,  RES_NAME, RES_PHONE, RES_TIME, RES_PARKING, RES_ROAD_ADDRESS) 
VALUES ( restaurant_seq.nextval, 304, 901,'갓파스시 연산점', '051-868-4377', '평일 11:30-21:30 토요일 11:30-22:00', '단체석, 주차, 포장, 예약, 무선 인터넷, 남/녀 화장실 구분', '부산 연제구 반송로 44');

--일식, 대구
INSERT INTO RESTAURANT ( RES_NO,imgcheck,FILTER_NO, REGION_NO,  RES_NAME, RES_PHONE, RES_TIME, RES_PARKING, RES_ROAD_ADDRESS) 
VALUES ( restaurant_seq.nextval, 1,304, 902,'한냐마켓또', '070-4241-8155', '평일 17:30-03:00 주말 17:00-05:00', '단체석, 주차, 포장, 예약, 무선 인터넷, 남/녀 화장실 구분', '대구 중구 동성로5길 69-1 한냐마켓또');

--일식, 인천
INSERT INTO RESTAURANT ( RES_NO,imgcheck, FILTER_NO, REGION_NO, RES_NAME, RES_PHONE, RES_TIME, RES_PARKING, RES_ROAD_ADDRESS) 
VALUES ( restaurant_seq.nextval,1, 304, 903,'스시애 2호점', '0507-1474-5572', '매일 11:30-16:00', '단체석, 주차, 포장, 예약, 무선 인터넷, 남/녀 화장실 구분', '인천 부평구 부평대로87번길 4 2층');

--일식, 경기
INSERT INTO RESTAURANT ( RES_NO,imgcheck, FILTER_NO, REGION_NO, RES_NAME, RES_PHONE, RES_TIME, RES_PARKING, RES_ROAD_ADDRESS)
VALUES ( restaurant_seq.nextval, 1,304, 908,'초밥왕', '0507-1378-8856', '매일 11:00-24:00', '단체석, 주차, 포장, 예약, 무선 인터넷, 남/녀 화장실 구분', '경기 수원시 팔달구 향교로1번길 5 지하 초밥왕');

INSERT INTO RESTAURANT ( RES_NO,imgcheck,FILTER_NO, REGION_NO,  RES_NAME, RES_PHONE, RES_TIME, RES_PARKING, RES_ROAD_ADDRESS) 
VALUES ( restaurant_seq.nextval, 1,304, 908,'에버그린', '031-425-4359', '매일 11:00-16:00 일요일 휴무', '단체석, 주차, 포장, 예약, 무선 인터넷, 남/녀 화장실 구분', '경기 안양시 동안구 인덕원로 29-16');

INSERT INTO RESTAURANT ( RES_NO,imgcheck,FILTER_NO, REGION_NO,  RES_NAME, RES_PHONE, RES_TIME, RES_PARKING, RES_ROAD_ADDRESS) 
VALUES ( restaurant_seq.nextval, 1,304, 908,'스시웨이 광명본점', '02-2616-3774', '매일 11:30-22:00 일요일 휴무', '단체석, 주차, 포장, 예약, 무선 인터넷, 남/녀 화장실 구분', '경기 광명시 가림일로 80 로즈힐빌딩3층');


--아시아 음식, 광주
INSERT INTO RESTAURANT ( RES_NO,imgcheck, FILTER_NO, REGION_NO, RES_NAME, RES_PHONE, RES_TIME, RES_PARKING, RES_ROAD_ADDRESS) 
VALUES ( restaurant_seq.nextval, 1,305, 904, '분포나인', '0507-1439-2274', '매일 11:00-21:00', '단체석, 주차, 포장, 예약, 무선 인터넷, 남/녀 화장실 구분', '광주 남구 백서로 39');

--아시아 음식, 경기
INSERT INTO RESTAURANT ( RES_NO,imgcheck,FILTER_NO, REGION_NO,  RES_NAME, RES_PHONE, RES_TIME, RES_PARKING, RES_ROAD_ADDRESS) 
VALUES ( restaurant_seq.nextval,1, 305, 908, '포레스트', '031-8003-6616', '매일 11:30-21:30', '단체석, 주차, 포장, 예약, 무선 인터넷, 남/녀 화장실 구분', '경기 화성시 동탄공원로2길 33-9 1층');

INSERT INTO RESTAURANT ( RES_NO,imgcheck, FILTER_NO, REGION_NO, RES_NAME, RES_PHONE, RES_TIME, RES_PARKING, RES_ROAD_ADDRESS) 
VALUES ( restaurant_seq.nextval,1, 305, 908,'타임포타이', '0507-1441-1145', '매일 11:00-22:00', '단체석, 주차, 포장, 예약, 무선 인터넷, 남/녀 화장실 구분', '경기 성남시 분당구 문정로144번길 5');

INSERT INTO RESTAURANT ( RES_NO,imgcheck,FILTER_NO, REGION_NO,  RES_NAME, RES_PHONE, RES_TIME, RES_PARKING, RES_ROAD_ADDRESS) 
VALUES ( restaurant_seq.nextval,1,305, 908, '아초원', '0507-1314-4490', '매일 11:00-22:00', '단체석, 주차, 포장, 예약, 무선 인터넷, 남/녀 화장실 구분', '경기 하남시 감일남로52번길 21-29');





--카페, 서울

INSERT INTO RESTAURANT ( RES_NO,imgcheck, FILTER_NO, REGION_NO, RES_NAME, RES_PHONE, RES_TIME, RES_PARKING, RES_ROAD_ADDRESS) 
VALUES ( restaurant_seq.nextval,1,306, 900, '쟝블랑제리', '02-889-5170', '매일 07:00 - 22:00', '단체석, 주차, 포장, 예약, 무선 인터넷, 남/녀 화장실 구분', '서울 관악구 낙성대역길 8');

INSERT INTO RESTAURANT ( RES_NO,imgcheck, FILTER_NO, REGION_NO, RES_NAME, RES_PHONE, RES_TIME, RES_PARKING, RES_ROAD_ADDRESS) 
VALUES ( restaurant_seq.nextval,1,306, 900, '피오니', '02-333-5325', '매일 12:00-22:00', '단체석, 주차, 포장, 예약, 무선 인터넷, 남/녀 화장실 구분', '서울 마포구 어울마당로 56');

INSERT INTO RESTAURANT ( RES_NO, imgcheck,FILTER_NO, REGION_NO, RES_NAME, RES_PHONE, RES_TIME, RES_PARKING, RES_ROAD_ADDRESS) 
VALUES ( restaurant_seq.nextval,1,306, 900, '더베이커스테이블', '070-7717-3501', '매일 08:00-21:00', '단체석, 주차, 포장, 예약, 무선 인터넷, 남/녀 화장실 구분', '서울 용산구 녹사평대로 244-1');

--카페, 부산
INSERT INTO RESTAURANT ( RES_NO,imgcheck,FILTER_NO, REGION_NO,  RES_NAME, RES_PHONE, RES_TIME, RES_PARKING, RES_ROAD_ADDRESS) 
VALUES ( restaurant_seq.nextval,1,306, 901, '웨이브온 커피', '051-727-1660', '매일 11:00-24:00', '단체석, 주차, 포장, 예약, 무선 인터넷, 남/녀 화장실 구분', '부산 기장군 장안읍 해맞이로 286 웨이브온커피');

INSERT INTO RESTAURANT ( RES_NO,imgcheck,FILTER_NO, REGION_NO, RES_NAME, RES_PHONE, RES_TIME, RES_PARKING, RES_ROAD_ADDRESS) 
VALUES ( restaurant_seq.nextval,1,306, 901, '옵스 해운대점', '051-747-6886', '매일 09:00-21:00', '단체석, 주차, 포장, 예약, 무선 인터넷, 남/녀 화장실 구분', '부산 해운대구 중동1로 31');

--카페, 대구
INSERT INTO RESTAURANT ( RES_NO,imgcheck, FILTER_NO, REGION_NO, RES_NAME, RES_PHONE, RES_TIME, RES_PARKING, RES_ROAD_ADDRESS) 
VALUES ( restaurant_seq.nextval,1,306, 902, '삼송빵집 본점', '053-254-4064', '매일 08:00-22:00', '단체석, 주차, 포장, 예약, 무선 인터넷, 남/녀 화장실 구분', '대구 중구 중앙대로 397');

--카페, 광주
INSERT INTO RESTAURANT ( RES_NO,imgcheck,FILTER_NO, REGION_NO,  RES_NAME, RES_PHONE, RES_TIME, RES_PARKING, RES_ROAD_ADDRESS) 
VALUES ( restaurant_seq.nextval, 1,306, 904,'센도리', '0507-1488-4200', '매일 11:30-22:00', '단체석, 주차, 포장, 예약, 무선 인터넷, 남/녀 화장실 구분', '광주 동구 충장로 93-6');

--카페, 인천
INSERT INTO RESTAURANT ( RES_NO,imgcheck,FILTER_NO, REGION_NO,  RES_NAME, RES_PHONE, RES_TIME, RES_PARKING, RES_ROAD_ADDRESS) 
VALUES ( restaurant_seq.nextval,1, 306, 903, '카페오라', '032-752-0888', '매일 09:30-21:00', '단체석, 주차, 포장, 예약, 무선 인터넷, 남/녀 화장실 구분', '인천 중구 용유서로 380');

INSERT INTO RESTAURANT ( RES_NO,imgcheck,FILTER_NO, REGION_NO,  RES_NAME, RES_PHONE, RES_TIME, RES_PARKING, RES_ROAD_ADDRESS) 
VALUES ( restaurant_seq.nextval,1, 306, 903,'궁전제과 충장점', '062-222-3477', '매일 10:00-21:30', '단체석, 주차, 포장, 예약, 무선 인터넷, 남/녀 화장실 구분', '인천 중구 용유서로 380');

--카페, 경기
INSERT INTO RESTAURANT ( RES_NO, imgcheck,FILTER_NO, REGION_NO, RES_NAME, RES_PHONE, RES_TIME, RES_PARKING, RES_ROAD_ADDRESS) 
VALUES ( restaurant_seq.nextval,1, 306, 908,'고당', '031-576-8090', '매일 11:00-22:00', '단체석, 주차, 포장, 예약, 무선 인터넷, 남/녀 화장실 구분', '경기 남양주시 조안면 북한강로 121 고당');

INSERT INTO RESTAURANT ( RES_NO,imgcheck,FILTER_NO, REGION_NO,  RES_NAME, RES_PHONE, RES_TIME, RES_PARKING, RES_ROAD_ADDRESS) 
VALUES ( restaurant_seq.nextval,1, 306, 908, '뱀부15-8', '0507-1409-7001', '매일 11:00-22:00', '단체석, 주차, 포장, 예약, 무선 인터넷, 남/녀 화장실 구분', '경기 김포시 하성면 금포로1915번길 7 뱀부카페&레스토랑');

INSERT INTO RESTAURANT ( RES_NO,imgcheck, FILTER_NO, REGION_NO, RES_NAME, RES_PHONE, RES_TIME, RES_PARKING, RES_ROAD_ADDRESS) 
VALUES ( restaurant_seq.nextval, 1, 306, 908,'유니스의 정원', '031-437-2045', '매일 11:00-22:00', '단체석, 주차, 포장, 예약, 무선 인터넷, 남/녀 화장실 구분', '경기 안산시 상록구 반월천북길 139');

INSERT INTO RESTAURANT ( RES_NO,imgcheck,FILTER_NO, REGION_NO,  RES_NAME, RES_PHONE, RES_TIME, RES_PARKING, RES_ROAD_ADDRESS) 
VALUES ( restaurant_seq.nextval, 1, 306, 908,'카페 아를', '031-837-1717', '매일 10:00-24:00', '단체석, 주차, 포장, 예약, 무선 인터넷, 남/녀 화장실 구분', '경기 의정부시 동일로 204 카페 아를');

INSERT INTO RESTAURANT ( RES_NO,imgcheck, FILTER_NO, REGION_NO, RES_NAME, RES_PHONE, RES_TIME, RES_PARKING, RES_ROAD_ADDRESS) 
VALUES ( restaurant_seq.nextval, 1, 306, 908,'포레스트아웃팅스', '070-4154-8955', '매일 10:00-22:00', '단체석, 주차, 포장, 예약, 무선 인터넷, 남/녀 화장실 구분', '경기 고양시 일산동구 고양대로 1124 포레스트 아웃팅스');

INSERT INTO RESTAURANT ( RES_NO, imgcheck,FILTER_NO, REGION_NO, RES_NAME, RES_PHONE, RES_TIME, RES_PARKING, RES_ROAD_ADDRESS) 
VALUES ( restaurant_seq.nextval,1,  306, 908,'마이알레', '02-3445-1794', '매일 11:00-22:00', '단체석, 주차, 포장, 예약, 무선 인터넷, 남/녀 화장실 구분', '경기 과천시 삼부골3로 17');

--카페, 제주
INSERT INTO RESTAURANT ( RES_NO,imgcheck,FILTER_NO, REGION_NO,  RES_NAME, RES_PHONE, RES_TIME, RES_PARKING, RES_ROAD_ADDRESS) 
VALUES ( restaurant_seq.nextval, 1, 306, 804, '애월더선셋', '0507-1403-5943', '매일 10:00-20:00', '단체석, 주차, 포장, 예약, 무선 인터넷, 남/녀 화장실 구분', '제주 제주시 애월읍 일주서로 6111');

INSERT INTO RESTAURANT ( RES_NO,imgcheck, FILTER_NO, REGION_NO, RES_NAME, RES_PHONE, RES_TIME, RES_PARKING, RES_ROAD_ADDRESS) 
VALUES ( restaurant_seq.nextval,1, 306, 804,'카페델문도', '064-702-00073', '매일 07:00-00:00', '단체석, 주차, 포장, 예약, 무선 인터넷, 남/녀 화장실 구분', '제주 제주시 조천읍 조함해안로 519-10');

INSERT INTO RESTAURANT ( RES_NO,imgcheck, FILTER_NO, REGION_NO, RES_NAME, RES_PHONE, RES_TIME, RES_PARKING, RES_ROAD_ADDRESS) 
VALUES ( restaurant_seq.nextval,1, 306, 804,'풍림다방 송당점', '1811-5775', '매일 10:30-18:00', '단체석, 주차, 포장, 예약, 무선 인터넷, 남/녀 화장실 구분', '제주 제주시 구좌읍 중산간동로 2267-4 풍림다방');



--분식 , 서울

INSERT INTO RESTAURANT ( RES_NO,imgcheck,FILTER_NO, REGION_NO,  RES_NAME, RES_PHONE, RES_TIME, RES_PARKING, RES_ROAD_ADDRESS) 
VALUES ( restaurant_seq.nextval,1,307, 900, '101번지 남산돈까스 본점', '02-777-7929', '매일 10:30 - 22:00', '단체석, 주차, 포장, 예약, 무선 인터넷, 남/녀 화장실 구분', '서울 중구 소파로 101');

--분식, 부산
INSERT INTO RESTAURANT ( RES_NO,imgcheck, FILTER_NO, REGION_NO, RES_NAME, RES_PHONE, RES_TIME, RES_PARKING, RES_ROAD_ADDRESS) 
VALUES ( restaurant_seq.nextval, 1,307, 901,'다리집', '051-625-0130', '매일 11:30-21:30 화요일 휴무', '단체석, 주차, 포장, 예약, 무선 인터넷, 남/녀 화장실 구분', '부산 수영구 남천바다로10번길 70 101호');

--분식, 대구
INSERT INTO RESTAURANT ( RES_NO,imgcheck,FILTER_NO, REGION_NO,  RES_NAME, RES_PHONE, RES_TIME, RES_PARKING, RES_ROAD_ADDRESS) 
VALUES ( restaurant_seq.nextval,1, 307, 902,'중앙떡볶이', '053-424-7692', '매일 11:20-20:00 목요일 휴무 셋째주', '단체석, 주차, 포장, 예약, 무선 인터넷, 남/녀 화장실 구분', '대구 중구 동성로2길 81');

--분식, 인천
INSERT INTO RESTAURANT ( RES_NO, imgcheck,FILTER_NO, REGION_NO, RES_NAME, RES_PHONE, RES_TIME, RES_PARKING, RES_ROAD_ADDRESS) 
VALUES ( restaurant_seq.nextval,1,307, 903, '잉글랜드왕돈까스', '032-772-7266', '매일 11:30-21:00', '단체석, 주차, 포장, 예약, 무선 인터넷, 남/녀 화장실 구분', '인천 중구 우현로90번길 7 혜성빌딩 2층');

--분식, 경기
INSERT INTO RESTAURANT ( RES_NO, imgcheck,FILTER_NO, REGION_NO, RES_NAME, RES_PHONE, RES_TIME, RES_PARKING, RES_ROAD_ADDRESS) 
VALUES ( restaurant_seq.nextval, 1,307, 908,'묘향만두', '02-444-3515', '매일 09:30-21:30', '단체석, 주차, 포장, 예약, 무선 인터넷, 남/녀 화장실 구분', '경기 구리시 아차산로 63');

INSERT INTO RESTAURANT ( RES_NO,imgcheck,FILTER_NO, REGION_NO,  RES_NAME, RES_PHONE, RES_TIME, RES_PARKING, RES_ROAD_ADDRESS) 
VALUES ( restaurant_seq.nextval,1,307, 908, '보영만두 북문본점', '031-242-9076', '매일 10:00-01:00', '단체석, 주차, 포장, 예약, 무선 인터넷, 남/녀 화장실 구분', '경기 수원시 장안구 팔달로 271');





--기타, 서울
INSERT INTO RESTAURANT ( RES_NO,imgcheck,FILTER_NO, REGION_NO,  RES_NAME, RES_PHONE, RES_TIME, RES_PARKING, RES_ROAD_ADDRESS) 
VALUES ( restaurant_seq.nextval, 1,308, 900,'감성타코 강남역점', '02-565-8830', '매일 11:30-22:00', '단체석, 주차, 포장, 예약, 무선 인터넷, 남/녀 화장실 구분', '강남역 11번출구 앞 글래스타워 지하1층');

INSERT INTO RESTAURANT ( RES_NO,imgcheck, FILTER_NO, REGION_NO, RES_NAME, RES_PHONE, RES_TIME, RES_PARKING, RES_ROAD_ADDRESS) 
VALUES ( restaurant_seq.nextval, 1,308, 900,'바토스 이태원점', '02-797-8226', '매일 11:30 - 22:00', '단체석, 주차, 포장, 예약, 무선 인터넷, 남/녀 화장실 구분', '서울 용산구 이태원로15길 1 2층');

--기타, 대구
INSERT INTO RESTAURANT ( RES_NO, imgcheck,FILTER_NO, REGION_NO, RES_NAME, RES_PHONE, RES_TIME, RES_PARKING, RES_ROAD_ADDRESS) 
VALUES ( restaurant_seq.nextval,1,308, 902, 'VASCO 본점', '0507-1400-9354', '매일 12:00 - 21:30', '단체석, 주차, 포장, 예약, 무선 인터넷, 남/녀 화장실 구분', '대구 중구 동성로4길 100 vasco');

--기타, 인천
INSERT INTO RESTAURANT ( RES_NO,imgcheck, FILTER_NO, REGION_NO, RES_NAME, RES_PHONE, RES_TIME, RES_PARKING, RES_ROAD_ADDRESS) 
VALUES ( restaurant_seq.nextval,1, 308, 903,'원조신포닭강정', '032-762-5853', '매일 10:30 -21:00', '단체석, 주차, 포장, 예약, 무선 인터넷, 남/녀 화장실 구분', '인천 중구 우현로49번길 3');

--기타, 광주
INSERT INTO RESTAURANT ( RES_NO,imgcheck,FILTER_NO, REGION_NO,  RES_NAME, RES_PHONE, RES_TIME, RES_PARKING, RES_ROAD_ADDRESS) 
VALUES ( restaurant_seq.nextval,1, 308, 904,'영미오리탕', '062-527-0248', '매일 09:00 -01:00', '단체석, 주차, 포장, 예약, 무선 인터넷, 남/녀 화장실 구분', '광주 북구 경양로 126');

--기타, 경기
INSERT INTO RESTAURANT ( RES_NO,imgcheck,FILTER_NO, REGION_NO,  RES_NAME, RES_PHONE, RES_TIME, RES_PARKING, RES_ROAD_ADDRESS) 
VALUES ( restaurant_seq.nextval, 1,308, 908,'낙원타코 롯데몰수원점', '031-8066-1890', '매일 10:30 -22:00', '단체석, 주차, 포장, 예약, 무선 인터넷, 남/녀 화장실 구분', '경기 수원시 권선구 세화로 134 롯데몰수원점 3층');

INSERT INTO RESTAURANT ( RES_NO,imgcheck,FILTER_NO, REGION_NO,  RES_NAME, RES_PHONE, RES_TIME, RES_PARKING, RES_ROAD_ADDRESS) 
VALUES ( restaurant_seq.nextval,1,308, 908, '온더보더 스타필드하남점', '031-8072-8682', '매일 10:00 -22:00', '단체석, 주차, 포장, 예약, 무선 인터넷, 남/녀 화장실 구분', '경기 하남시 미사대로 750 스타필드 하남 1층');







delete from review;
delete from booking;
delete from bookmark;
delete from room;


commit;