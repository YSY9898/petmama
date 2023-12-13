create table pet_detail(
	mem_num number not null,
	pet_num number not null,
	pet_name varchar2(30) not null,
	pet_age number(2) not null,    
	pet_photo varchar2(150),
	pet_note varchar2(30) not null,
	constraint pet_detail_pk primary key (mem_num),
	constraint pet_detail_fk foreign key (mem_num) references member (mem_num)
);





