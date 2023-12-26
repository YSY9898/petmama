package kr.petsitter.vo;

import java.sql.Date;

public class PetsitterVO {
	private int sis_num;			//펫시터 번호
	private int mem_num;			//회원 번호
	private String sis_name;		//펫시터 이름
	private int sis_condition;		//펫시터 상태(0:대기상태 1:시터회원수락 2:정지 3:탈퇴)
	private int sis_work;			//일 1. 산책 2. 돌봄 3. 둘 다 가능
	private int sis_career;			//경력(개월 수)
	private String sis_email;		//펫시터 이메일
	private String sis_phone;		//펫시터 전화번호
	private String sis_photo1;		//펫시터 프로필 사진
	private String sis_photo2;		//펫시터 소개 사진
	private String sis_zipcode;		//우편번호
	private String sis_address1;	//펫시터 주소
	private String sis_address2;	//펫시터 상세주소
	private Date sis_apply_date;	//펫시터 지원일
	private Date sis_accept_date;	//펫시터 수락일
	private Date sis_mdate;			//펫시터 정보 수정일		
	private String title;			//펫시터 소개 제목
	private String tag;				//펫시터 소개 태그
	
	public int getSis_num() {
		return sis_num;
	}
	public void setSis_num(int sis_num) {
		this.sis_num = sis_num;
	}
	public String getSis_name() {
		return sis_name;
	}
	public void setSis_name(String sis_name) {
		this.sis_name = sis_name;
	}
	public int getSis_condition() {
		return sis_condition;
	}
	public void setSis_condition(int sis_condition) {
		this.sis_condition = sis_condition;
	}
	public int getSis_work() {
		return sis_work;
	}
	public void setSis_work(int sis_work) {
		this.sis_work = sis_work;
	}
	public int getSis_career() {
		return sis_career;
	}
	public void setSis_career(int sis_career) {
		this.sis_career = sis_career;
	}
	public String getSis_phone() {
		return sis_phone;
	}
	public void setSis_phone(String sis_phone) {
		this.sis_phone = sis_phone;
	}
	public String getSis_photo1() {
		return sis_photo1;
	}
	public void setSis_photo1(String sis_photo1) {
		this.sis_photo1 = sis_photo1;
	}
	public String getSis_photo2() {
		return sis_photo2;
	}
	public void setSis_photo2(String sis_photo2) {
		this.sis_photo2 = sis_photo2;
	}
	public String getSis_zipcode() {
		return sis_zipcode;
	}
	public void setSis_zipcode(String sis_zipcode) {
		this.sis_zipcode = sis_zipcode;
	}
	public String getSis_address1() {
		return sis_address1;
	}
	public void setSis_address1(String sis_address1) {
		this.sis_address1 = sis_address1;
	}
	public String getSis_address2() {
		return sis_address2;
	}
	public void setSis_address2(String sis_address2) {
		this.sis_address2 = sis_address2;
	}
	public Date getSis_apply_date() {
		return sis_apply_date;
	}
	public void setSis_apply_date(Date sis_apply_date) {
		this.sis_apply_date = sis_apply_date;
	}
	public Date getSis_accept_date() {
		return sis_accept_date;
	}
	public void setSis_accept_date(Date sis_accept_date) {
		this.sis_accept_date = sis_accept_date;
	}
	public Date getSis_mdate() {
		return sis_mdate;
	}
	public void setSis_mdate(Date sis_mdate) {
		this.sis_mdate = sis_mdate;
	}
	public String getSis_email() {
		return sis_email;
	}
	public void setSis_email(String sis_email) {
		this.sis_email = sis_email;
	}
	public int getMem_num() {
		return mem_num;
	}
	public void setMem_num(int mem_num) {
		this.mem_num = mem_num;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getTag() {
		return tag;
	}
	public void setTag(String tag) {
		this.tag = tag;
	}
	
	
}
