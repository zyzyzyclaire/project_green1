drop table team_product;
CREATE TABLE NOTICE
(N_NUM NUMBER(5,0) PRIMARY KEY NOT NULL
,N_TITLE VARCHAR2(100)
,N_CONTENT VARCHAR2(3000)
,N_DATE DATE
,N_HIT NUMBER(5,0) DEFAULT(0)
,N_PWD VARCHAR2(12)
,N_IP VARCHAR2(15)
,USER_ID VARCHAR2(50)
);