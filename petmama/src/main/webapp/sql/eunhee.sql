create table board(
 mem_num number not null,
 id varchar2(12) unique not null,
 auth number(1) default 2 not null, --회원등급 : 0 탈퇴회원, 1 정지회원, 2 일반회원, 9 관리자
 constraint zmember_pk primary key (mem_num)
);