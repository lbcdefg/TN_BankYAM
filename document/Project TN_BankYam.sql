--alter session set "_oracle_script"=true;
--create user bank identified by yam;
--grant connect, resource, unlimited tablespace to bank;
--conn bank/yam;

drop table BLOCKLIST;
drop sequence BLOCKLIST_SEQ;
drop table FRIEND;
drop sequence FRIEND_SEQ;
drop table FRIENDREQ;
drop sequence FRIENDREQ_SEQ;
drop table CHATSTATUS;
drop table CHATFILE;
drop sequence CHATFILE_SEQ;
drop table CHATCONTENT;
drop sequence CHATCONTENT_SEQ;
drop table CHATMEMBER;
drop table CHATROOM;
drop sequence CHATROOM_SEQ;
drop table TRANSACTIONS;
drop sequence TRANSACTIONS_SEQ;
drop table ACCOUNTY;
drop sequence ACCOUNTY_SEQ;
drop table PRODUCT;
drop sequence PRODUCT_SEQ;
drop table MEMBERY;
drop sequence MEMBERY_SEQ;
purge recyclebin;

create table MEMBERY(
   MB_SEQ number constraint MEMBERY_PK primary key,
   MB_EMAIL varchar2(50),
   MB_PWD varchar2(100),
   MB_NAME varchar2(20),
   MB_ADDR varchar2(150),
   MB_DADDR varchar2(150),
   MB_PHONE varchar2(11) constraint MEMBERY_PH_UQ unique,
   MB_JOB varchar2(30),
   MB_SALARY number,
   MB_CREDIT number,
   MB_IMAGEPATH varchar2(100),
   MB_RDATE date,
   MB_WDATE date
);
create sequence MEMBERY_SEQ increment by 1 start with 1 nocache;

create table PRODUCT(
  PD_SEQ number constraint PRODUCT_PK primary key,
  PD_TYPE varchar2(20),
  PD_NAME varchar2(50),
  PD_RATE number(5,2),
  PD_ADDRATE number(5,2),
  PD_INFO varchar2(100),
  PD_DEL varchar2(1),
  PD_RDATE date,
  PD_XDATE date
);
create sequence PRODUCT_SEQ increment by 1 start with 1 nocache;

create table ACCOUNTY(
   AC_SEQ number constraint ACCOUNTY_PK primary key,
   AC_PWD varchar(100),
   AC_MB_SEQ number,
   AC_BALANCE number,
   AC_NAME varchar2(50),
   AC_MAIN varchar2(30),
   AC_STATUS varchar2(20),
   AC_PD_SEQ number,
   AC_PWD_CHECK number(1),
   AC_PURPOSE varchar2(10),
   AC_RDATE date,
   AC_UDATE date,
   AC_XDATE date
);
create sequence ACCOUNTY_SEQ increment by 10 start with 888010000010 nocache;
alter table ACCOUNTY add constraint ACCOUNTY_MB_FK foreign key(AC_MB_SEQ) references MEMBERY(MB_SEQ) on delete cascade;
alter table ACCOUNTY add constraint ACCOUNTY_PD_FK foreign key(AC_PD_SEQ) references PRODUCT(PD_SEQ) on delete cascade;

create table TRANSACTIONS(
   TR_SEQ number constraint TRANSACTIONS_PK primary key,
   TR_AC_SEQ number,
   TR_OTHER_ACCNUM number,
   TR_OTHER_BANK varchar2(30),
   TR_TYPE varchar2(15),
   TR_AMOUNT number,
   TR_AFTER_BALANCE number,
   TR_MSG varchar(60),
   TR_DATE date
);
create sequence TRANSACTIONS_SEQ increment by 1 start with 1 nocache;
alter table TRANSACTIONS add constraint TRANSACTIONS_AC_FK foreign key(TR_AC_SEQ) references ACCOUNTY(AC_SEQ) on delete cascade;

create table CHATROOM(
   CR_SEQ number constraint CHATROOM_PK primary key,
   CR_NAME varchar2(60),
   CR_RDATE date,
   CR_UDATE date
);
create sequence CHATROOM_SEQ increment by 1 start with 1 nocache;

create table CHATMEMBER(
   CM_CR_SEQ number,
   CM_MB_SEQ number
);
alter table CHATMEMBER add constraint CHATMEMBER_CR_FK foreign key(CM_CR_SEQ) references CHATROOM(CR_SEQ) on delete cascade;
alter table CHATMEMBER add constraint CHATMEMBER_MB_FK foreign key(CM_MB_SEQ) references MEMBERY(MB_SEQ) on delete cascade;

create table CHATFILE(
   CF_SEQ number constraint CHATFILE_PK primary key,
   CF_ORGNM varchar2(100),
   CF_SAVEDNM varchar2(1000),
   CF_SAVEDPATH varchar2(300),
   CF_SIZE number
);
create sequence CHATFILE_SEQ increment by 1 start with 1 nocache;

create table CHATCONTENT(
   CC_SEQ number constraint CHATCONTENT_PK primary key,
   CC_CR_SEQ number,
   CC_MB_SEQ number,
   CC_CF_SEQ number,
   CC_CONTENT clob,
   CC_RDATE date
);
create sequence CHATCONTENT_SEQ increment by 1 start with 1 nocache;
alter table CHATCONTENT add constraint CHATCONTENT_CR_FK foreign key(CC_CR_SEQ) references CHATROOM(CR_SEQ) on delete cascade;
alter table CHATCONTENT add constraint CHATCONTENT_MB_FK foreign key(CC_MB_SEQ) references MEMBERY(MB_SEQ) on delete cascade;
alter table CHATCONTENT add constraint CHATCONTENT_CF_FK foreign key(CC_CF_SEQ) references CHATFILE(CF_SEQ) on delete cascade;


create table CHATSTATUS(
   CS_CC_SEQ number,
   CS_MB_SEQ number,
   CS_READ date
);
alter table CHATSTATUS add constraint CHATSTATUS_CC_FK foreign key(CS_CC_SEQ) references CHATCONTENT(CC_SEQ) on delete cascade;
alter table CHATSTATUS add constraint CHATSTATUS_MB_FK foreign key(CS_MB_SEQ) references MEMBERY(MB_SEQ) on delete cascade;

create table FRIENDREQ(
   FR_SEQ number constraint FRIENDREQ_PK primary key,
   FR_REQ_MB_SEQ number,
   FR_REC_MB_SEQ number,
   FR_STATUS varchar2(20),
   FR_RDATE date
);
create sequence FRIENDREQ_SEQ increment by 1 start with 1 nocache;
alter table FRIENDREQ add constraint FRIENDREQ_REQ_MB_FK foreign key(FR_REQ_MB_SEQ) references MEMBERY(MB_SEQ) on delete cascade;
alter table FRIENDREQ add constraint FRIENDREQ_REC_MB_FK foreign key(FR_REC_MB_SEQ) references MEMBERY(MB_SEQ) on delete cascade;

create table FRIEND(
   F_SEQ number constraint FRIEND_PK primary key,
   F_MB_SEQ number,
   F_F_MB_SEQ number,
   F_RDATE date
);
create sequence FRIEND_SEQ increment by 1 start with 1 nocache;
alter table FRIEND add constraint FRIEND_MB_FK foreign key(F_MB_SEQ) references MEMBERY(MB_SEQ) on delete cascade;
alter table FRIEND add constraint FRIEND_FRIEND_MB_FK foreign key(F_F_MB_SEQ) references MEMBERY(MB_SEQ) on delete cascade;

create table BLOCKLIST(
   BL_SEQ number constraint BLOCKLIST_PK primary key,
   BL_MB_SEQ number,
   BL_BL_MB_SEQ number,
   BL_RDATE date
);
create sequence BLOCKLIST_SEQ increment by 1 start with 1 nocache;
alter table BLOCKLIST add constraint BLOCKLIST_MB_FK foreign key(BL_MB_SEQ) references MEMBERY(MB_SEQ) on delete cascade;
alter table BLOCKLIST add constraint BLOCKLIST_BLOCK_MB_FK foreign key(BL_BL_MB_SEQ) references MEMBERY(MB_SEQ) on delete cascade;


select * from TAB;


----- MEMBERY TEST
insert into MEMBERY values(MEMBERY_SEQ.nextval,'hong@gmail.com',1234,'홍길동','서울시 금천구 가산동', 'A아파트 1호', '01000000001', '회사원',4000,800,'/img/character/hi.png', TO_DATE('2023-03-30 09:10:10', 'YYYY-MM-DD HH24:MI:SS'), null);
insert into MEMBERY values(MEMBERY_SEQ.nextval,'gang@gmail.com',1234,'강감찬','서울시 금천구 시흥동', 'A아파트 2호', '01000000002', '학생',0,600,'/img/character/hi.png', TO_DATE('2023-03-30 09:10:10', 'YYYY-MM-DD HH24:MI:SS'), null);
insert into MEMBERY values(MEMBERY_SEQ.nextval,'lee@hanmail.com',1234,'이순신','서울시 금천구 독산동', 'A아파트 3호', '01000000003', '무직',5000,900,'/img/character/hi.png', TO_DATE('2023-03-30 09:10:10', 'YYYY-MM-DD HH24:MI:SS'), null);
insert into MEMBERY values(MEMBERY_SEQ.nextval,'you@gmail.com',1234,'유관순','서울시 영등포구 영등포동', 'A아파트 4호', '01000000004', '자영업',5000,850,'/img/character/hi.png', TO_DATE('2023-03-30 09:10:10', 'YYYY-MM-DD HH24:MI:SS'), null);
insert into MEMBERY values(MEMBERY_SEQ.nextval,'kim@hanmail.com',1234,'김길동','서울시 금천구 가산동', 'A아파트 5호', '01000000005', '회사원',5000,900,'/img/character/hi.png', TO_DATE('2023-03-30 09:10:10', 'YYYY-MM-DD HH24:MI:SS'), null);
insert into MEMBERY values(MEMBERY_SEQ.nextval,'test1@hanmail.com',1234,'여서엇','서울시 금천구 가산동', 'A아파트 6호', '01000000006', '회사원',8000,780,'/img/character/hi.png', TO_DATE('2023-03-31 09:10:10', 'YYYY-MM-DD HH24:MI:SS'),null);
insert into MEMBERY values(MEMBERY_SEQ.nextval,'test2@gmail.com',1234,'일고옵','서울시 금천구 시흥동', 'A아파트 7호', '01000000007', '무직',0,500,'/img/character/hi.png',TO_DATE('2023-04-03 09:10:10', 'YYYY-MM-DD HH24:MI:SS'),null);
insert into MEMBERY values(MEMBERY_SEQ.nextval,'test3@naver.com',1234,'여더얼','서울시 금천구 독산동', 'A아파트 8호', '01000000008', '학생',0,600,'/img/character/hi.png',TO_DATE('2023-04-03 09:10:10', 'YYYY-MM-DD HH24:MI:SS'),null);
insert into MEMBERY values(MEMBERY_SEQ.nextval,'test4@gmail.com',1234,'아호옵','서울시 금천구 독산동', 'A아파트 9호', '01000000009', '학생',0,650,'/img/character/hi.png',TO_DATE('2023-04-03 09:10:10', 'YYYY-MM-DD HH24:MI:SS'),null);
insert into MEMBERY values(MEMBERY_SEQ.nextval,'test5@naver.com',1234,'열열열','서울시 금천구 시흥동', 'A아파트 10호', '01000000010', '자영업',8000,900,'/img/character/hi.png',TO_DATE('2023-04-03 09:10:10', 'YYYY-MM-DD HH24:MI:SS'),null);
insert into MEMBERY values(MEMBERY_SEQ.nextval,'test6@naver.com',1234,'열하나','서울시 영등포구 영등포동', 'A아파트 11호', '01000000011', '공무원',4500,950,'/img/character/hi.png',TO_DATE('2023-04-08 09:10:10', 'YYYY-MM-DD HH24:MI:SS'),null);
insert into MEMBERY values(MEMBERY_SEQ.nextval,'test7@gmail.com',1234,'열두울','서울시 구로구 구로동', 'A아파트 12호', '01000000012', '공무원',4000,850,'/img/character/hi.png',TO_DATE('2023-04-08 09:10:10', 'YYYY-MM-DD HH24:MI:SS'),null);
insert into MEMBERY values(MEMBERY_SEQ.nextval,'test8@gmail.com',1234,'열세엣','서울시 관악구 신림동', 'A아파트 13호', '01000000013', '무직',0,700,'/img/character/hi.png',TO_DATE('2023-04-08 09:10:10', 'YYYY-MM-DD HH24:MI:SS'),null);
insert into MEMBERY values(MEMBERY_SEQ.nextval,'test9@naver.com',1234,'열네엣','서울시 금천구 가산동', 'A아파트 14호', '01000000014', '학생',2000,800,'/img/character/hi.png',SYSDATE,null);
insert into MEMBERY values(MEMBERY_SEQ.nextval,'test10@gmail.com',1234,'열다섯','서울시 금천구 독산동', 'A아파트 15호', '01000000015', '회사원',3500,700,'/img/character/hi.png',SYSDATE,null);
insert into MEMBERY values(MEMBERY_SEQ.nextval,'bomi@gmail.com',1234,'이보미','서울시 중랑구 망우동', 'A아파트 16호', '01000000016', '학생',10000,999,'/img/character/hi.png',SYSDATE,null);
--insert into MEMBERY values(MEMBERY_SEQ.nextval,'test11@gmail.com',1234,'열다섯','서울시 금천구 독산동', '01000000016', '회사원',3500,700,'/img/character/hi.png',SYSDATE,null);
--insert into MEMBERY values(MEMBERY_SEQ.nextval,'test12@gmail.com',1234,'열다섯','서울시 금천구 독산동', '01000000017', '회사원',3500,700,'/img/character/hi.png',SYSDATE,null);
--insert into MEMBERY values(MEMBERY_SEQ.nextval,'test13@gmail.com',1234,'열다섯','서울시 금천구 독산동', '01000000018', '회사원',3500,700,'/img/character/hi.png',SYSDATE,null);
--insert into MEMBERY values(MEMBERY_SEQ.nextval,'test14@gmail.com',1234,'열다섯','서울시 금천구 독산동', '01000000019', '회사원',3500,700,'/img/character/hi.png',SYSDATE,null);
--insert into MEMBERY values(MEMBERY_SEQ.nextval,'test15@gmail.com',1234,'열다섯','서울시 금천구 독산동', '01000000020', '회사원',3500,700,'/img/character/hi.png',SYSDATE,null);
--insert into MEMBERY values(MEMBERY_SEQ.nextval,'test16@gmail.com',1234,'열다섯','서울시 금천구 독산동', '01000000021', '회사원',3500,700,'/img/character/hi.png',SYSDATE,null);
--insert into MEMBERY values(MEMBERY_SEQ.nextval,'test17@gmail.com',1234,'열다섯','서울시 금천구 독산동', '01000000022', '회사원',3500,700,'/img/character/hi.png',SYSDATE,null);
--insert into MEMBERY values(MEMBERY_SEQ.nextval,'test18@gmail.com',1234,'열다섯','서울시 금천구 독산동', '01000000023', '회사원',3500,700,'/img/character/hi.png',SYSDATE,null);
--insert into MEMBERY values(MEMBERY_SEQ.nextval,'test19@gmail.com',1234,'열다섯','서울시 금천구 독산동', '01000000024', '회사원',3500,700,'/img/character/hi.png',SYSDATE,null);
--insert into MEMBERY values(MEMBERY_SEQ.nextval,'test20@gmail.com',1234,'열다섯','서울시 금천구 독산동', '01000000025', '회사원',3500,700,'/img/character/hi.png',SYSDATE,null);
--insert into MEMBERY values(MEMBERY_SEQ.nextval,'test21@gmail.com',1234,'열다섯','서울시 금천구 독산동', '01000000026', '회사원',3500,700,'/img/character/hi.png',SYSDATE,null);

update MEMBERY set MB_IMAGEPATH='/img/user/16_img.png' where MB_SEQ=16;

commit;

select * from MEMBERY;

SELECT * FROM MEMBERY M JOIN ACCOUNTY A ON M.MB_SEQ = A.AC_MB_SEQ WHERE M.MB_EMAIL = 'test1@hanmail.com';

--rollback;


----- PRODUCT TEST
insert into PRODUCT values(PRODUCT_SEQ.nextval, '예금', '뱅크얌_예금통장', 3.50, 0.00, '안녕하세요', 'X', TO_DATE('2023-01-13 09:00:38', 'YYYY-MM-DD HH24:MI:SS'), null);

commit;

select * from PRODUCT;



----- ACCOUNTY TEST
insert into ACCOUNTY values(ACCOUNTY_SEQ.nextval, 1234, 1, 1000000, '뱅크얌_예금통장', '주', '사용중', 1, 0, '예금', TO_DATE('2023-03-30 10:10:10', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2023-05-01 10:10:10', 'YYYY-MM-DD HH24:MI:SS'), null);
insert into ACCOUNTY values(ACCOUNTY_SEQ.nextval, 1234, 2, 1000000, '뱅크얌_예금통장', '주', '사용중', 1, 0, '급여', TO_DATE('2023-03-30 10:10:10', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2023-05-01 10:10:10', 'YYYY-MM-DD HH24:MI:SS'), null);
insert into ACCOUNTY values(ACCOUNTY_SEQ.nextval, 1234, 3, 1000000, '뱅크얌_예금통장', '주', '사용중', 1, 0, '예금', TO_DATE('2023-03-30 10:10:10', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2023-05-01 10:10:10', 'YYYY-MM-DD HH24:MI:SS'), null);
insert into ACCOUNTY values(ACCOUNTY_SEQ.nextval, 1234, 4, 1000000, '뱅크얌_예금통장', '주', '사용중', 1, 0, '생활비', TO_DATE('2023-03-30 10:10:10', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2023-05-01 10:10:10', 'YYYY-MM-DD HH24:MI:SS'), null);
insert into ACCOUNTY values(ACCOUNTY_SEQ.nextval, 1234, 5, 1000000, '뱅크얌_예금통장', '주', '사용중', 1, 0, '예금', TO_DATE('2023-03-30 10:10:10', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2023-05-01 10:10:10', 'YYYY-MM-DD HH24:MI:SS'), null); --5
insert into ACCOUNTY values(ACCOUNTY_SEQ.nextval, 1234, 5, 500000, '뱅크얌_예금통장2', '부', '사용중', 1, 0, '급여', TO_DATE('2023-03-31 10:10:10', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2023-05-01 10:10:10', 'YYYY-MM-DD HH24:MI:SS'), null);
insert into ACCOUNTY values(ACCOUNTY_SEQ.nextval, 1234, 6, 1000000, '뱅크얌_예금통장', '주', '사용중', 1, 0, '급여', TO_DATE('2023-03-31 10:10:10', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2023-05-01 10:10:10', 'YYYY-MM-DD HH24:MI:SS'), null);
insert into ACCOUNTY values(ACCOUNTY_SEQ.nextval, 1234, 6, 51, '뱅크얌_예금통장2', '부', '해지', 1, 0, '예금', TO_DATE('2023-04-01 10:10:10', 'YYYY-MM-DD HH24:MI:SS'), null, SYSDATE);
insert into ACCOUNTY values(ACCOUNTY_SEQ.nextval, 1234, 7, 1000000, '뱅크얌_예금통장', '주', '사용중', 1, 0, '예금', TO_DATE('2023-04-03 10:10:10', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2023-05-05 10:10:10', 'YYYY-MM-DD HH24:MI:SS'), null);
insert into ACCOUNTY values(ACCOUNTY_SEQ.nextval, 1234, 2, 3, '뱅크얌_예금통장0', '부', '해지', 1, 0, '예금', TO_DATE('2023-04-03 10:10:10', 'YYYY-MM-DD HH24:MI:SS'), null, SYSDATE); --10
insert into ACCOUNTY values(ACCOUNTY_SEQ.nextval, 0000, 9, 1000000, '뱅크얌_예금통장', '주', '사용중', 1, 0, '예금', TO_DATE('2023-04-03 10:10:10', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2023-05-05 10:10:10', 'YYYY-MM-DD HH24:MI:SS'), null);
insert into ACCOUNTY values(ACCOUNTY_SEQ.nextval, 0000, 10, 1000000, '뱅크얌_예금통장', '주', '사용중', 1, 0, '급여', TO_DATE('2023-04-03 10:10:10', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2023-05-05 10:10:10', 'YYYY-MM-DD HH24:MI:SS'), null);
insert into ACCOUNTY values(ACCOUNTY_SEQ.nextval, 0000, 2, 7, '뱅크얌_예금통장2', '부', '휴면', 1, 0, '예금', TO_DATE('2023-04-04 10:10:10', 'YYYY-MM-DD HH24:MI:SS'), null, SYSDATE);
insert into ACCOUNTY values(ACCOUNTY_SEQ.nextval, 0000, 11, 300000, '뱅크얌_예금통장', '부', '사용중', 1, 0, '예금', TO_DATE('2023-04-08 10:10:10', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2023-05-10 10:10:10', 'YYYY-MM-DD HH24:MI:SS'), null);
insert into ACCOUNTY values(ACCOUNTY_SEQ.nextval, 0000, 12, 1000000, '뱅크얌_예금통장', '주', '사용중', 1, 0, '예금', TO_DATE('2023-04-08 10:10:10', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2023-05-10 10:10:10', 'YYYY-MM-DD HH24:MI:SS'), null); --15
insert into ACCOUNTY values(ACCOUNTY_SEQ.nextval, 0000, 2, 600000, '뱅크얌_예금통장3', '부', '사용중', 1, 0, '예금', TO_DATE('2023-04-08 10:10:10', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2023-05-10 10:10:10', 'YYYY-MM-DD HH24:MI:SS'), null);
insert into ACCOUNTY values(ACCOUNTY_SEQ.nextval, 0000, 13, 1000000, '뱅크얌_예금통장', '주', '사용중', 1, 0, '급여', TO_DATE('2023-04-08 10:10:10', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2023-05-10 10:10:10', 'YYYY-MM-DD HH24:MI:SS'), null);
insert into ACCOUNTY values(ACCOUNTY_SEQ.nextval, 0000, 4, 300000, '뱅크얌_예금통장2', '부', '사용중', 1, 0, '예금', SYSDATE, (ADD_MONTHS(SYSDATE, 1))+4, null);
insert into ACCOUNTY values(ACCOUNTY_SEQ.nextval, 0000, 14, 1000000, '뱅크얌_예금통장', '주', '사용중', 1, 0, '예금', SYSDATE, (ADD_MONTHS(SYSDATE, 1))+4, null);
insert into ACCOUNTY values(ACCOUNTY_SEQ.nextval, 0000, 15, 1000000, '뱅크얌_예금통장', '주', '사용중', 1, 0, '생활비', SYSDATE, (ADD_MONTHS(SYSDATE, 1))+4, null); --20
insert into ACCOUNTY values(ACCOUNTY_SEQ.nextval, 0000, 8, 2100000, '뱅크얌_예금통장2', '주', '사용중', 1, 0, '예금', SYSDATE, (ADD_MONTHS(SYSDATE, 1))+4, null);
insert into ACCOUNTY values(ACCOUNTY_SEQ.nextval, 0000, 11, 800000, '뱅크얌_예금통장2', '주', '사용중', 1, 0, '예금', SYSDATE, (ADD_MONTHS(SYSDATE, 1))+4, null);
insert into ACCOUNTY values(ACCOUNTY_SEQ.nextval, 0000, 2, 100000000000, '뱅크얌_예금통장4', '부', '사용중', 1, 0, '급여', SYSDATE, (ADD_MONTHS(SYSDATE, 1))+4, null);
insert into ACCOUNTY values(ACCOUNTY_SEQ.nextval, 0000, 2, 100000000000, '뱅크얌_예금통장5', '부', '사용중', 1, 0, '예금', SYSDATE, (ADD_MONTHS(SYSDATE, 1))+4, null);
insert into ACCOUNTY values(ACCOUNTY_SEQ.nextval, 0000, 2, 100000000000, '뱅크얌_예금통장6', '부', '사용중', 1, 0, '생활비', SYSDATE, (ADD_MONTHS(SYSDATE, 1))+4, null);
insert into ACCOUNTY values(ACCOUNTY_SEQ.nextval, 0000, 2, 100000000000, '뱅크얌_예금통장7', '부', '사용중', 1, 0, '급여', SYSDATE, (ADD_MONTHS(SYSDATE, 1))+4, null);
insert into ACCOUNTY values(ACCOUNTY_SEQ.nextval, 0000, 2, 100000000000, '뱅크얌_예금통장8', '부', '사용중', 1, 0, '예금', SYSDATE, (ADD_MONTHS(SYSDATE, 1))+4, null);
insert into ACCOUNTY values(ACCOUNTY_SEQ.nextval, 0000, 16, 100000000000, '뱅크얌_예금통장8', '주', '사용중', 1, 0, '예금', SYSDATE, (ADD_MONTHS(SYSDATE, 1))+4, null);

insert into MEMBERY values(MEMBERY_SEQ.nextval,'admin@gmail.com',1234,'뱅크얌','한국소프트웨어인재개발원', 'KOSMO', '11111111111', '관리자',0,0,'/img/YamLogoHover.png', TO_DATE('2023-03-30 09:10:10', 'YYYY-MM-DD HH24:MI:SS'), null);

commit;

select * from ACCOUNTY;

update ACCOUNTY set ac_status='복구중' where ac_seq=888010000100;
update ACCOUNTY set ac_balance=300000 where ac_seq=888010000100;
update ACCOUNTY set ac_balance=300000000 where ac_seq=888010000220;
update ACCOUNTY set ac_main='주' where ac_seq=888010000140;
delete from ACCOUNTY where ac_seq=888010000250;
select * from ACCOUNTY where AC_MB_SEQ=2;
SELECT * FROM membery m JOIN accounty a ON m.mb_seq = a.ac_mb_seq WHERE m.mb_seq = 2 AND a.ac_seq = 888010000160;
select * from ACCOUNTY where AC_SEQ = '888010000110';
SELECT * FROM MEMBERY M JOIN ACCOUNTY A ON M.MB_SEQ = A.AC_MB_SEQ
WHERE M.MB_EMAIL = 'ww' OR A.AC_SEQ = '11';
SELECT * FROM membery m JOIN accounty a ON m.mb_seq = a.ac_mb_seq WHERE m.mb_seq = 2 AND a.ac_status != '해지' AND a.ac_status != '복구중'
ORDER BY a.ac_main DESC, a.ac_status;
SELECT * FROM membery m JOIN accounty a ON m.mb_seq = a.ac_mb_seq WHERE m.mb_seq = 2 AND (a.ac_status = '해지' OR a.ac_status = '복구중')
ORDER BY a.ac_main DESC, a.ac_status;


----- TRANSACTIONS TEST
insert into TRANSACTIONS values(TRANSACTIONS_SEQ.nextval, 888010000020, 888010000070, '뱅크얌', '송금', 50000, 950000, '강감찬 보냄', TO_DATE('2023-03-31 19:17:43', 'YYYY-MM-DD HH24:MI:SS'));
insert into TRANSACTIONS values(TRANSACTIONS_SEQ.nextval, 888010000070, 888010000020, '뱅크얌', '입금', 50000, 1050000, '강감찬 보냄', TO_DATE('2023-03-31 19:17:43', 'YYYY-MM-DD HH24:MI:SS'));
update ACCOUNTY set AC_BALANCE = AC_BALANCE-50000 where AC_SEQ = 888010000020;
update ACCOUNTY set AC_BALANCE = AC_BALANCE+50000 where AC_SEQ = 888010000070;
insert into TRANSACTIONS values(TRANSACTIONS_SEQ.nextval, 888010000020, 888010000110, '뱅크얌', '송금', 80000, 870000, '강감찬 보냄', TO_DATE('2023-04-04 12:21:50', 'YYYY-MM-DD HH24:MI:SS'));
insert into TRANSACTIONS values(TRANSACTIONS_SEQ.nextval, 888010000110, 888010000020, '뱅크얌', '입금', 80000, 1080000, '강감찬 보냄', TO_DATE('2023-04-04 12:21:50', 'YYYY-MM-DD HH24:MI:SS'));
update ACCOUNTY set AC_BALANCE = AC_BALANCE-80000 where AC_SEQ = 888010000020;
update ACCOUNTY set AC_BALANCE = AC_BALANCE+80000 where AC_SEQ = 888010000110;
insert into TRANSACTIONS values(TRANSACTIONS_SEQ.nextval, 888010000020, 888010000110, '뱅크얌', '송금', 20000, 850000, '강감찬 보냄', TO_DATE('2023-04-04 14:00:30', 'YYYY-MM-DD HH24:MI:SS'));
insert into TRANSACTIONS values(TRANSACTIONS_SEQ.nextval, 888010000110, 888010000020, '뱅크얌', '입금', 20000, 1100000, '강감찬 보냄', TO_DATE('2023-04-04 14:00:30', 'YYYY-MM-DD HH24:MI:SS'));
update ACCOUNTY set AC_BALANCE = AC_BALANCE-20000 where AC_SEQ = 888010000020;
update ACCOUNTY set AC_BALANCE = AC_BALANCE+20000 where AC_SEQ = 888010000110;
insert into TRANSACTIONS values(TRANSACTIONS_SEQ.nextval, 888010000020, 888010000070, '뱅크얌', '송금', 100000, 750000, '강감찬 보냄', TO_DATE('2023-04-09 09:58:55', 'YYYY-MM-DD HH24:MI:SS'));
insert into TRANSACTIONS values(TRANSACTIONS_SEQ.nextval, 888010000070, 888010000020, '뱅크얌', '입금', 100000, 1150000, '강감찬 보냄', TO_DATE('2023-03-31 19:17:43', 'YYYY-MM-DD HH24:MI:SS'));
update ACCOUNTY set AC_BALANCE = AC_BALANCE-100000 where AC_SEQ = 888010000020;
update ACCOUNTY set AC_BALANCE = AC_BALANCE+100000 where AC_SEQ = 888010000070;
insert into TRANSACTIONS values(TRANSACTIONS_SEQ.nextval, 888010000020, 888010000200, '뱅크얌', '송금', 100000, 650000, '강감찬 보냄', SYSDATE);
insert into TRANSACTIONS values(TRANSACTIONS_SEQ.nextval, 888010000200, 888010000020, '뱅크얌', '입금', 100000, 1100000, '강감찬 보냄', SYSDATE);
update ACCOUNTY set AC_BALANCE = AC_BALANCE-100000 where AC_SEQ = 888010000020;
update ACCOUNTY set AC_BALANCE = AC_BALANCE+100000 where AC_SEQ = 888010000200;

commit;

select * from TRANSACTIONS;
select * from ACCOUNTY;
rollback;


----- FRIENDREQ TEST
insert into FRIENDREQ values(FRIENDREQ_SEQ.nextval, 6, 2, '완료', TO_DATE('2023-03-31 13:15:25', 'YYYY-MM-DD HH24:MI:SS')); -- 6 / 2
insert into FRIENDREQ values(FRIENDREQ_SEQ.nextval, 9, 2, '완료', TO_DATE('2023-04-04 11:55:25', 'YYYY-MM-DD HH24:MI:SS')); -- 9 / 2
insert into FRIENDREQ values(FRIENDREQ_SEQ.nextval, 2, 15, '완료', SYSDATE); -- 9 / 2
insert into FRIENDREQ values(FRIENDREQ_SEQ.nextval, 10, 2, '요청', SYSDATE); -- 10 / 2
insert into FRIENDREQ values(FRIENDREQ_SEQ.nextval, 11, 2, '요청', SYSDATE); -- 11 / 2
insert into FRIENDREQ values(FRIENDREQ_SEQ.nextval, 2, 12, '요청', SYSDATE); -- 2 / 12

commit;

select * from FRIENDREQ;
SELECT * FROM FRIENDREQ WHERE (FR_REQ_MB_SEQ = 2 OR FR_REQ_MB_SEQ = 6)
AND (FR_REC_MB_SEQ = 6 OR FR_REC_MB_SEQ = 2);

SELECT * FROM friendreq fq JOIN membery m ON m.mb_seq = fr_rec_mb_seq WHERE
 fr_req_mb_seq = 2 AND fr_status = '요청';

SELECT * FROM friendreq fq JOIN membery m ON m.mb_seq = fr_req_mb_seq WHERE
 fr_rec_mb_seq = 2 AND fr_status = '요청';



----- FRIEND TEST
insert into FRIEND values(FRIEND_SEQ.nextval, 2, 6, TO_DATE('2023-03-31 13:15:25', 'YYYY-MM-DD HH24:MI:SS')); -- 2 / 6
insert into FRIEND values(FRIEND_SEQ.nextval, 6, 2, TO_DATE('2023-03-31 13:15:25', 'YYYY-MM-DD HH24:MI:SS')); -- 6 / 2
insert into FRIEND values(FRIEND_SEQ.nextval, 2, 9, TO_DATE('2023-04-04 11:55:25', 'YYYY-MM-DD HH24:MI:SS')); -- 2 / 9
insert into FRIEND values(FRIEND_SEQ.nextval, 9, 2, TO_DATE('2023-04-04 11:55:25', 'YYYY-MM-DD HH24:MI:SS')); -- 2 / 9
insert into FRIEND values(FRIEND_SEQ.nextval, 15, 2, SYSDATE); -- 15 / 2
insert into FRIEND values(FRIEND_SEQ.nextval, 2, 15, SYSDATE); -- 15 / 2

insert into FRIEND values(FRIEND_SEQ.nextval, 1, 2, SYSDATE); -- 15 / 2
insert into FRIEND values(FRIEND_SEQ.nextval, 2, 1, SYSDATE); -- 15 / 2
insert into FRIEND values(FRIEND_SEQ.nextval, 3, 2, SYSDATE); -- 15 / 2
insert into FRIEND values(FRIEND_SEQ.nextval, 2, 3, SYSDATE); -- 15 / 2
insert into FRIEND values(FRIEND_SEQ.nextval, 4, 2, SYSDATE); -- 15 / 2
insert into FRIEND values(FRIEND_SEQ.nextval, 2, 4, SYSDATE); -- 15 / 2
insert into FRIEND values(FRIEND_SEQ.nextval, 5, 2, SYSDATE); -- 15 / 2
insert into FRIEND values(FRIEND_SEQ.nextval, 2, 5, SYSDATE); -- 15 / 2
insert into FRIEND values(FRIEND_SEQ.nextval, 13, 2, SYSDATE); -- 15 / 2
insert into FRIEND values(FRIEND_SEQ.nextval, 2, 13, SYSDATE); -- 15 / 2

--insert into FRIEND values(FRIEND_SEQ.nextval, 16, 2, SYSDATE);insert into FRIEND values(FRIEND_SEQ.nextval, 2, 16, SYSDATE);insert into FRIEND values(FRIEND_SEQ.nextval, 17, 2, SYSDATE);insert into FRIEND values(FRIEND_SEQ.nextval, 2, 17, SYSDATE);
--insert into FRIEND values(FRIEND_SEQ.nextval, 18, 2, SYSDATE);insert into FRIEND values(FRIEND_SEQ.nextval, 2, 18, SYSDATE);insert into FRIEND values(FRIEND_SEQ.nextval, 19, 2, SYSDATE);insert into FRIEND values(FRIEND_SEQ.nextval, 2, 19, SYSDATE);
--insert into FRIEND values(FRIEND_SEQ.nextval, 20, 2, SYSDATE);insert into FRIEND values(FRIEND_SEQ.nextval, 2, 20, SYSDATE);insert into FRIEND values(FRIEND_SEQ.nextval, 21, 2, SYSDATE);insert into FRIEND values(FRIEND_SEQ.nextval, 2, 21, SYSDATE);
--insert into FRIEND values(FRIEND_SEQ.nextval, 23, 2, SYSDATE);insert into FRIEND values(FRIEND_SEQ.nextval, 2, 23, SYSDATE);insert into FRIEND values(FRIEND_SEQ.nextval, 24, 2, SYSDATE);insert into FRIEND values(FRIEND_SEQ.nextval, 2, 24, SYSDATE);
--insert into FRIEND values(FRIEND_SEQ.nextval, 25, 2, SYSDATE);insert into FRIEND values(FRIEND_SEQ.nextval, 2, 25, SYSDATE);insert into FRIEND values(FRIEND_SEQ.nextval, 26, 2, SYSDATE);insert into FRIEND values(FRIEND_SEQ.nextval, 2, 26, SYSDATE);
--insert into FRIEND values(FRIEND_SEQ.nextval, 22, 2, SYSDATE);insert into FRIEND values(FRIEND_SEQ.nextval, 2, 22, SYSDATE);



commit;

select * from FRIEND;
SELECT * FROM MEMBERY M JOIN FRIEND F ON F.F_MB_SEQ = 2
WHERE F.F_F_MB_SEQ = M.MB_SEQ;
select * from FRIEND where (F_MB_SEQ = 2 and F_F_MB_SEQ = 15) or (F_MB_SEQ = 15 and F_F_MB_SEQ = 2);

insert into FRIEND values(FRIEND_SEQ.nextval, 2, 14, SYSDATE); insert into FRIEND values(FRIEND_SEQ.nextval, 14, 2, SYSDATE);


----- FRIEND TEST
insert into BLOCKLIST values(BLOCKLIST_SEQ.nextval, 2, 1, SYSDATE); -- 2 / 1
insert into BLOCKLIST values(BLOCKLIST_SEQ.nextval, 2, 14, SYSDATE); -- 2 / 14
insert into BLOCKLIST values(BLOCKLIST_SEQ.nextval, 2, 13, SYSDATE); -- 2 / 13

commit;

select * from BLOCKLIST;



----- CHATROOM TEST
insert into CHATROOM values(CHATROOM_SEQ.nextval, null, TO_DATE('2023-03-31 17:10:05', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2023-04-09 10:01:45', 'YYYY-MM-DD HH24:MI:SS')); -- 2 / 6
insert into CHATROOM values(CHATROOM_SEQ.nextval, null, TO_DATE('2023-04-04 12:15:15', 'YYYY-MM-DD HH24:MI:SS'), '23/04/04'); -- 2 / 9
insert into CHATROOM values(CHATROOM_SEQ.nextval, null, SYSDATE, SYSDATE); -- 2 / 15

commit;

select * from CHATROOM;

----- CHATMEMBER TEST
insert into CHATMEMBER values(1, 2); -- 2 / 6
insert into CHATMEMBER values(1, 6); -- 2 / 6
insert into CHATMEMBER values(2, 2); -- 2 / 9
insert into CHATMEMBER values(2, 9); -- 2 / 9
insert into CHATMEMBER values(3, 2); -- 2 / 15
insert into CHATMEMBER values(3, 15); -- 2 / 15

commit;

select * from CHATMEMBER;


----- CHATMEMBER TEST
insert into CHATCONTENT values(CHATCONTENT_SEQ.nextval, 1, 2, null, '안녕하세요', TO_DATE('2023-03-31 17:10:05', 'YYYY-MM-DD HH24:MI:SS')); -- 2 / 6
insert into CHATCONTENT values(CHATCONTENT_SEQ.nextval, 1, 6, null, '넵 돈주세요', TO_DATE('2023-03-31 17:12:13', 'YYYY-MM-DD HH24:MI:SS')); -- 2 / 6
insert into CHATCONTENT values(CHATCONTENT_SEQ.nextval, 1, 2, null, '네 잠시만요', TO_DATE('2023-03-31 18:10:03', 'YYYY-MM-DD HH24:MI:SS')); -- 2 / 6
insert into CHATCONTENT values(CHATCONTENT_SEQ.nextval, 1, 6, null, '저기요?', TO_DATE('2023-03-31 18:12:20', 'YYYY-MM-DD HH24:MI:SS')); -- 2 / 6
insert into CHATCONTENT values(CHATCONTENT_SEQ.nextval, 1, 6, null, '빨리요', TO_DATE('2023-03-31 18:14:20', 'YYYY-MM-DD HH24:MI:SS')); -- 2 / 6
insert into CHATCONTENT values(CHATCONTENT_SEQ.nextval, 1, 6, null, '...', TO_DATE('2023-03-31 18:14:20', 'YYYY-MM-DD HH24:MI:SS')); -- 2 / 6
insert into CHATCONTENT values(CHATCONTENT_SEQ.nextval, 1, 2, null, '곧 가요', TO_DATE('2023-03-31 19:14:23', 'YYYY-MM-DD HH24:MI:SS')); -- 2 / 6
insert into CHATCONTENT values(CHATCONTENT_SEQ.nextval, 2, 2, null, '안녕하세요', TO_DATE('2023-04-04 12:15:15', 'YYYY-MM-DD HH24:MI:SS')); -- 2 / 9
insert into CHATCONTENT values(CHATCONTENT_SEQ.nextval, 2, 9, null, '안녕하세요', TO_DATE('2023-04-04 12:16:45', 'YYYY-MM-DD HH24:MI:SS')); -- 2 / 9
insert into CHATCONTENT values(CHATCONTENT_SEQ.nextval, 2, 2, null, '계약금 입금하려구요 그쪽 계좌로 보내면 되나요?', TO_DATE('2023-04-04 12:17:22', 'YYYY-MM-DD HH24:MI:SS')); -- 2 / 9
insert into CHATCONTENT values(CHATCONTENT_SEQ.nextval, 2, 9, null, '네 주세요~~', TO_DATE('2023-04-04 12:20:32', 'YYYY-MM-DD HH24:MI:SS')); -- 2 / 9
insert into CHATCONTENT values(CHATCONTENT_SEQ.nextval, 2, 2, null, '보냈어요!', TO_DATE('2023-04-04 12:23:50', 'YYYY-MM-DD HH24:MI:SS')); -- 2 / 9
insert into CHATCONTENT values(CHATCONTENT_SEQ.nextval, 2, 9, null, '2만원 모자르네요..?', TO_DATE('2023-04-04 13:54:31', 'YYYY-MM-DD HH24:MI:SS')); -- 2 / 9
insert into CHATCONTENT values(CHATCONTENT_SEQ.nextval, 2, 2, null, '앗 죄송합니다 잠시만요~', TO_DATE('2023-04-04 13:56:20', 'YYYY-MM-DD HH24:MI:SS')); -- 2 / 9
insert into CHATCONTENT values(CHATCONTENT_SEQ.nextval, 2, 2, null, '추가로 보냈어요!', TO_DATE('2023-04-04 14:03:01', 'YYYY-MM-DD HH24:MI:SS')); -- 2 / 9
insert into CHATCONTENT values(CHATCONTENT_SEQ.nextval, 2, 9, null, '네 확인이요!', TO_DATE('2023-04-04 14:05:11', 'YYYY-MM-DD HH24:MI:SS')); -- 2 / 9
insert into CHATCONTENT values(CHATCONTENT_SEQ.nextval, 1, 2, null, '계약금 추가로 보냈어요', TO_DATE('2023-04-09 10:01:45', 'YYYY-MM-DD HH24:MI:SS')); -- 2 / 6
insert into CHATCONTENT values(CHATCONTENT_SEQ.nextval, 3, 2, null, '계약금 보낼께요', SYSDATE); -- 2 / 15
insert into CHATCONTENT values(CHATCONTENT_SEQ.nextval, 3, 15, null, '네', SYSDATE); -- 2 / 15
insert into CHATCONTENT values(CHATCONTENT_SEQ.nextval, 3, 15, null, '감사합니다!', SYSDATE); -- 2 / 15

commit;

select * from CHATCONTENT;
select * from CHATFILE;

