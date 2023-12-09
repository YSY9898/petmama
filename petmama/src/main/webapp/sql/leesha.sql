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