create table board(
 board_num number not null,
 title varchar2(150) not null,
 content clob not null,
 hit number(9) default 0 not null,
 reg_date date default sysdate not null,
 modify_date date,
 filename varchar2(150),
 ip varchar2(40) not null,
 mem_num number not null,
 board_best default 0 not null, --0:일반글 1:공지글
 constraint board_pk primary key (board_num),
 constraint board_fk foreign key (mem_num) references member (mem_num)
);

create sequence board_seq;

create table board_scrap(
 board_num number not null,
 mem_num number not null,
 constraint board_scrap_fk1 foreign key (board_num) references board (board_num),
 constraint board_scrap_fk2 foreign key (mem_num) references member (mem_num) 
);

create table board_reply(
 re_num number not null,
 re_content varchar2(900) not null,
 re_date date default sysdate not null,
 re_modifydate date,
 re_ip varchar2(40) not null,
 board_num number not null,
 mem_num number not null,
 mem_nickname varchar2(30) not null,
 constraint board_reply_fk1 foreign key (board_num) references board (board_num),
 constraint board_reply_fk2 foreign key (mem_num) references member (mem_num)
);

create sequence board_reply_seq;

create table board_fav(
 board_num number not null,
 mem_num number not null,
 constraint board_fav_fk1 foreign key (board_num) references board (board_num),
 constraint board_fav_fk2 foreign key (mem_num) references member (mem_num)
);

create table notice_board(
 notice_num number not null,
 notice_title varchar2(150) not null,
 notice_content clob not null,
 notice_hit number(9) default 0 not null,
 notice_reg_date date default sysdate not null,
 notice_modify_date date,
 notice_filename varchar2(150),
 notice_ip varchar2(40) not null,
 mem_num number not null,
 constraint notice_board_pk primary key (notice_num),
 constraint notice_board_fk foreign key (mem_num) references member (mem_num)
);

create sequence notice_board_seq;