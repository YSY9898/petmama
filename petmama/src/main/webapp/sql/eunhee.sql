create table board(
 board_num number not null,
 board_type number(10) not null,
 title varchar2(150) not null,
 content clob not null,
 hit number(9) default 0 not null,
 reg_date date default sysdate not null,
 modify_date date,
 filename varchar2(150),
 ip varchar2(40) not null,
 mem_num number not null,
 mem_nickname varchar2(30) not null,
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