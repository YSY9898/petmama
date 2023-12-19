--펫시터
create table petsitter(
 sis_num number not null,
 mem_num number not null,
 constraint petsitter_fk foreign key (mem_num) references member (mem_num),
 constraint petsitter_pk primary key (sis_num)
);
create table petsitter_detail(
 sis_num number not null,
 mem_num number not null,
 sis_name varchar2(30) not null,
 sis_condition number default 0 not null, -- 신청하면 대기상태
 sis_work number not null,
 sis_career number(2) not null,
 sis_photo1 varchar2(150) not null,
 sis_photo2 varchar2(150) not null,
 sis_phone varchar2(15) not null,
 sis_email varchar2(50) not null,
 sis_zipcode varchar2(5) not null,
 sis_address1 varchar2(90) not null,
 sis_address2 varchar2(90) not null,
 sis_accept_date date,
 sis_mdate date,
 sis_rate number(3,2),
 constraint petsitter_detail_pk primary key(sis_num),
 constraint petsitter_detail_fk foreign key(sis_num) references petsitter (sis_num)
);
create sequence petsitter_seq;

-- 펫시터 예약 테이블
create table reservation(
 r_num number not null,
 mem_num number not null,
 sis_num number not null,
 r_reg_date date not null,
 r_modify_date date,
 r_condition number default 1 not null, -- 1 : 예약접수 상태
 visit_status number not null, -- 0 : 펫시터 집으로 부르기 펫시터 집에 맡기기
 r_pet_note varchar2(90) not null,
 r_start varchar2(30) not null,
 r_end varchar2(30) not null,
 constraint reservation_pk primary key(r_num),
 constraint reservation_fk1 foreign key(mem_num) references member (mem_num),
 constraint reservation_fk2 foreign key(sis_num) references petsitter (sis_num)
 );
 create sequence reservation_seq;