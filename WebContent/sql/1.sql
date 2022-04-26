drop  table cart cascade constraints;
drop  table product_imageFile cascade constraints;
drop  table user_table cascade constraints;
drop  table user_order cascade constraints;
drop  table userOrder_detail cascade constraints;
drop  table product cascade constraints;
drop  table product_category cascade constraints;
drop  table notice cascade constraints;
drop  table qna_board cascade constraints;
drop table userorder_refund  cascade constraints;


CREATE TABLE user_table
(USER_ID VARCHAR2(30) PRIMARY KEY 
,USER_PWD VARCHAR2(50)
,USER_NAME VARCHAR2(20)
,USER_PHONE VARCHAR2(20)
,USER_EMAIL VARCHAR2(20)
,USER_ADDR VARCHAR2(500)
,USER_GRADE VARCHAR2(10)
);
commit;
insert into user_table values ('admin','1234','admin1','010-admin','admin@','adminh','C');
insert into user_table values ('user1','1234','user1','010-user1','user1@','user1h','B');
insert into user_table values ('user2','1234','user2','010-user2','user2@','user2h','B');
insert into user_table values ('b1','1234','b1','010-b1','b1@','b1h','A');
insert into user_table values ('b2','1234','b2','010-b2','b2@','b2h','A');
CREATE TABLE user_order (
    order_number  VARCHAR2(30 byte)  primary key,
    user_id        VARCHAR2(30 BYTE),
    order_date     DATE,
    receiver_addr  VARCHAR2(500 BYTE),
    receiver_name  VARCHAR2(20 BYTE),
    receiver_phone VARCHAR2(20 BYTE),
    constraint user_order_fk1 foreign key(user_id) references user_table(user_id)ON DELETE CASCADE
);
insert into user_order values (1,'user1','1991-01-01','�λ�','user1','010-user1');
insert into user_order values (3,'user1','1991-01-01','����','user1','010-user1');
insert into user_order values (2,'user2','1992-02-02','�뱸','user2','010-user2');



CREATE TABLE product_category (
    category_code     VARCHAR2(30 BYTE) primary key,
    category_name     VARCHAR2(50 BYTE),
    category_ref_code VARCHAR2(30 BYTE)
)
PCTFREE 10 PCTUSED 40 TABLESPACE system LOGGING
    STORAGE ( INITIAL 65536 NEXT 1048576 PCTINCREASE 0 MINEXTENTS 1 MAXEXTENTS 2147483645 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT );
insert into product_category values ('�Ź�','����','1');
insert into product_category values ('����','����','1');
insert into product_category values ('����','�Ź�','1');




CREATE TABLE product (
    product_number NUMBER(*, 0)  primary key,   -- �����̸Ӹ�Ű �߰�
    category_code  VARCHAR2(30 BYTE)  ,
    product_name   VARCHAR2(50 BYTE)  ,
    product_price  NUMBER(*, 0)  ,
    product_stock  NUMBER(*, 0)  ,
    product_desc   VARCHAR2(3000 BYTE)  ,
    product_date   DATE  ,
    product_hits   NUMBER(*, 0)  ,
    constraint category_fk foreign key(category_code) references product_category(category_code) ON DELETE CASCADE
);  

insert into product values (1,'����','������',1,1,'Ƽ�����Դϴ�','1990-11-11',1);
insert into product values (2,'����','Ƽ',2,2,'2Ƽ�����Դϴ�','1990-11-11',1);
insert into product values (3,'����','Ƽ����',3,3,'3Ƽ�����Դϴ�','1990-11-11',1);
insert into product values (4,'����','����Ƽ',4,4,'4Ƽ�����Դϴ�','1990-11-11',1);
insert into product values (5,'����','����Ƽ',5,5,'5Ƽ�����Դϴ�','1990-11-11',1);
insert into product values (6,'����','����Ƽ',6,6,'6Ƽ�����Դϴ�','1990-11-11',1);
insert into product values (7,'����','����Ƽ',7,7,'7Ƽ�����Դϴ�','1990-11-11',1);
insert into product values (8,'����','����Ƽ',8,8,'8Ƽ�����Դϴ�','1990-11-11',1);
insert into product values (9,'����','Ƽ',8,8,'9Ƽ�����Դϴ�','1990-11-11',1);
insert into product values (10,'����','Ƽ',8,8,'10Ƽ�����Դϴ�','1990-11-11',1);

insert into product values (11,'����','����',1,1,'�����Դϴ�','1990-11-11',1);
insert into product values (12,'����','����',1,1,'�����Դϴ�','1990-11-11',1);
insert into product values (13,'����','����',1,1,'�����Դϴ�','1990-11-11',1);
insert into product values (14,'����','����',1,1,'�����Դϴ�','1990-11-11',1);
insert into product values (15,'����','����',1,1,'�����Դϴ�','1990-11-11',1);
insert into product values (16,'����','����',1,1,'�����Դϴ�','1990-11-11',1);
insert into product values (1,1,'������',1,1,'Ƽ�����Դϴ�','1990-11-11',1);
insert into product values (17,'����','����',1,1,'�����Դϴ�','1990-11-11',1);
insert into product values (18,'����','����',1,1,'�����Դϴ�','1990-11-11',1);

insert into product values (19,'�Ź�','�Ź�',1,1,'�Ź��Դϴ�','1990-11-11',1);
insert into product values (20,'�Ź�','����',1,1,'�����Դϴ�','1990-11-11',1);

insert into product values (21,'�Ź�','�Ź�',1,1,'�Ź��Դϴ�','1990-11-11',1);
insert into product values (22,'�Ź�','����',1,1,'�����Դϴ�','1990-11-11',1);
insert into product values (23,'�Ź�','�Ź�',1,1,'�Ź��Դϴ�','1990-11-11',1);
insert into product values (24,'�Ź�','�Ź�',1,1,'�Ź��Դϴ�','1990-11-11',1);
insert into product values (25,'�Ź�','�Ź�',1,1,'�Ź��Դϴ�','1990-11-11',1);
insert into product values (26,'�Ź�','�Ź�',1,1,'�Ź��Դϴ�','1990-11-11',1);
insert into product values (27,'�Ź�','�Ź�',1,1,'�Ź��Դϴ�','1990-11-11',1);
insert into product values (28,'�Ź�','�Ź�',1,1,'�Ź��Դϴ�','1990-11-11',1);
insert into product values (29,'�Ź�','�Ź�',1,1,'�Ź��Դϴ�','1990-11-11',1);
insert into product values (30,'����','Ƽ',1,1,'Ƽ�Դϴ�','1990-11-11',1);


CREATE TABLE userOrder_detail (
    order_detail_number   NUMBER(*, 0) primary key,
    order_number          VARCHAR2(30 byte),
    product_number        NUMBER(*, 0),
    product_count         NUMBER(*, 0),
    product_price           NUMBER(*, 0),
    order_detail_status   VARCHAR2(20 BYTE),
    refund_check  VARCHAR2(10 BYTE),
    constraint userOrder_detail_fk1 foreign key(order_number) references user_order(order_number) ON DELETE CASCADE,
    constraint userOrder_detail_fk2 foreign key(product_number) references product(product_number)ON DELETE CASCADE
);
insert into userOrder_detail values (1,'1',1,1,1000,'����غ�','no');
insert into userOrder_detail values (2,'2',2,2,2000,'����غ�','no');
insert into userOrder_detail values (3,'3',3,3,3000,'����غ�','no');


CREATE TABLE cart (
    cart_number    NUMBER(*, 0) primary key,   -- �����̸Ӹ�Ű �߰�    
    user_id varchar2(30),
    product_number NUMBER(*, 0) NOT NULL,
--    cart_value     VARCHAR2(30 BYTE) NOT NULL,
    product_count  NUMBER(*, 0) NOT NULL,
    constraint cart_fk1 foreign key(user_id) references user_table(user_id) ON DELETE CASCADE ,
    constraint cart_fk2 foreign key(product_number) references product(product_number)ON DELETE CASCADE 

);

insert into cart values (1,'user1',1,'1');
insert into cart values (2,'user1',2,'2');
insert into cart values (3,'user1',3,'3');
insert into cart values (4,'user1',4,'4');
insert into cart values (5,'user2',5,'5');
insert into cart values (6,'user2',6,'6');
insert into cart values (7,'user2',7,'7');
insert into cart values (8,'user2',8,'8');


CREATE TABLE product_imagefile (
    file_number        NUMBER(*, 0) NOT NULL,
    product_number     NUMBER(*, 0),
    orgin_file_name    VARCHAR2(300 BYTE),
    stored_file_name   VARCHAR2(300 BYTE),
    stored_thumbnail   VARCHAR2(300 BYTE),
    delegate_thumbnail VARCHAR2(5 BYTE),
    file_size          NUMBER(*, 0),
    create_date        DATE,
    delete_check       VARCHAR2(5 BYTE)
    ,constraint numberfk foreign key(product_number) references product(product_number)ON DELETE CASCADE
);
insert into product_imagefile values (1,1,'1.jpg','1.jpg',null,'1',1,'1990-01-01','1');
insert into product_imagefile values (2,2,'2.jpg','2.jpg',null,'2',2,'1990-02-02','2');
insert into product_imagefile values (3,3,'3.jpg','3.jpg',null,'3',3,'1990-03-03','3');
insert into product_imagefile values (4,4,'4.jpg','4.jpg',null,'4',4,'1990-04-04','4');
insert into product_imagefile values (5,5,'5.jpg','5.jpg',null,'5',5,'1990-05-05','5');
insert into product_imagefile values (6,6,'6.jpg','6.jpg',null,'6',6,'1990-06-06','6');
insert into product_imagefile values (7,7,'7.jpg','7.jpg',null,'7',7,'1990-07-07','7');
insert into product_imagefile values (8,8,'8.jpg','8.jpg',null,'8',8,'1990-08-08','8');
insert into product_imagefile values (9,9,'8.jpg','9.jpg',null,'9',8,'1990-08-08','8');
insert into product_imagefile values (10,10,'8.jpg','10.jpg',null,'10',8,'1990-08-08','8');
insert into product_imagefile values (11,11,'8.jpg','11.jpg',null,'8',8,'1990-08-08','8');
insert into product_imagefile values (12,12,'8.jpg','12.jpg',null,'8',8,'1990-08-08','8');
insert into product_imagefile values (13,13,'8.jpg','13.jpg',null,'8',8,'1990-08-08','8');
insert into product_imagefile values (14,14,'8.jpg','14.jpg',null,'8',8,'1990-08-08','8');
insert into product_imagefile values (15,15,'8.jpg','15.jpg',null,'8',8,'1990-08-08','8');
insert into product_imagefile values (16,16,'8.jpg','16.jpg',null,'8',8,'1990-08-08','8');
insert into product_imagefile values (17,17,'8.jpg','17.jpg',null,'8',8,'1990-08-08','8');
insert into product_imagefile values (18,18,'8.jpg','18.jpg',null,'8',8,'1990-08-08','8');
insert into product_imagefile values (19,19,'8.jpg','19.jpg',null,'8',8,'1990-08-08','8');
insert into product_imagefile values (20,20,'8.jpg','20.jpg',null,'8',8,'1990-08-08','8');
insert into product_imagefile values (21,21,'8.jpg','21.jpg',null,'8',8,'1990-08-08','8');
insert into product_imagefile values (22,22,'8.jpg','22.jpg',null,'8',8,'1990-08-08','8');
insert into product_imagefile values (23,23,'8.jpg','23.jpg',null,'8',8,'1990-08-08','8');
insert into product_imagefile values (24,24,'8.jpg','24.jpg',null,'8',8,'1990-08-08','8');
insert into product_imagefile values (25,25,'8.jpg','25.jpg',null,'8',8,'1990-08-08','8');
insert into product_imagefile values (26,26,'8.jpg','26.jpg',null,'8',8,'1990-08-08','8');
insert into product_imagefile values (27,27,'8.jpg','27.jpg',null,'8',8,'1990-08-08','8');
insert into product_imagefile values (28,28,'8.jpg','28.jpg',null,'8',8,'1990-08-08','8');
insert into product_imagefile values (29,29,'8.jpg','29.jpg',null,'8',8,'1990-08-08','8');
insert into product_imagefile values (30,30,'8.jpg','30.jpg',null,'8',8,'1990-08-08','8');



CREATE TABLE NOTICE
(
N_NUM NUMBER(5,0) PRIMARY KEY 
,N_TITLE VARCHAR2(100)
,N_CONTENT VARCHAR2(3000)
,N_DATE DATE
,N_HIT NUMBER(5,0) DEFAULT(0)
,N_PWD VARCHAR2(12)
,N_IP VARCHAR2(15)
,USER_ID VARCHAR2(50)
);

insert into NOTICE values (1,'1','1','1991-01-01','1','1','1','user1');
insert into NOTICE values (2,'2','2','1992-02-02','2','2','2','user2');

CREATE TABLE qna_board(
b_id	NUMBER(10) primary key		
,u_id	VARCHAR2(15)	
,b_category	VARCHAR2(10)		
,b_view	NUMBER(10)	DEFAULT 0	
,b_title	VARCHAR2(100)		
,b_content	VARCHAR2(3000)
,b_ip varchar2(30)
,b_pwd varchar2(30)
,b_date	DATE		
,b_secret	CHAR(1)		
,b_ref	NUMBER(10)
,b_step NUMBER(10)
,b_level NUMBER(10)
,b_fname VARCHAR2(100)
,b_fsize NUMBER(10)
,b_rfname VARCHAR2(100)
);		

CREATE TABLE userorder_refund(
     refund_number NUMBER PRIMARY KEY 
    ,order_detail_number NUMBER
    ,refund_reason VARCHAR2(500)
    ,refund_img VARCHAR2(300)
    ,user_email VARCHAR2(50)
    ,constraint orderdetailnumberFK foreign key(order_detail_number) references userOrder_detail(order_detail_number)ON DELETE CASCADE
);

commit;