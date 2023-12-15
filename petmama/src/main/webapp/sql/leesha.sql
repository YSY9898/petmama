create table member (
 mem_num number not null,
 mem_id varchar2(12) unique not null,
 mem_auth number(1) default 2 not null,
 constraint member_pk primary key (mem_num)
);

create table member_detail(
 mem_num number not null,
 mem_name varchar2(30) not null,
 mem_nickname varchar2(30) not null,
 mem_pw varchar2(12) not null,
 mem_cell varchar2(15) not null,
 mem_email varchar2(50) not null,
 mem_zipcode varchar2(5) not null,
 mem_address1 varchar2(50) not null,
 mem_address2 varchar2(50) not null,
 mem_rdate date default sysdate not null,
 mem_mdate date,
 constraint member_detail_pk primary key (mem_num),
 constraint member_detail_fk foreign key (mem_num) references member (mem_num)
);
create sequence member_seq;

create table qna (
  q_num number not null,
  mem_num number not null,
  sis_num number null,
  passwd varchar2(12) not null,
  title varchar2(150) not null,
  content clob not null,
  filename varchar2(150),
  reg_date date default sysdate not null,
  modify_date date,
  answer_yn varchar2(1) default 'N' not null, 
  hide_yn varchar2(1) default 'N' not null,
  constraint qna_pk primary key (q_num),
  constraint qna_member_fk foreign key (mem_num) references member (mem_num)  
);
create sequence qna_seq;

create table qna_reply (
  qr_num number not null,
  q_num number not null,
  mem_num number not null,
  qr_content varchar2(500) not null,
  reg_date date default sysdate not null,
  modify_date date,
  qr_ip varchar2(40) not null,
  constraint qna_reply_pk primary key (qr_num),
  constraint qna_reply_member_fk foreign key (mem_num) references member (mem_num)  
);
create sequence qna_reply_seq;