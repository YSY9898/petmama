package kr.member.vo;

import java.sql.Date;

public class MemberVO {
	private int mem_num; 			//회원 번호
	private String mem_id; 			//아이디
	private int mem_auth;			//회원 등급
	private String mem_name;		//이름
	private String mem_nickname;		//닉네임
	public String getMem_nickname() {
		return mem_nickname;
	}

	public void setMem_nickname(String mem_nickname) {
		this.mem_nickname = mem_nickname;
	}

	private String mem_pw;			//비밀번호 
	private String mem_cell;		//전화번호
	private String mem_email;		//이메일
	private String mem_zipcode;		//우편번호
	private String mem_address1;	//주소
	private String mem_address2;	//상세주소
	private Date mem_rdate;			//가입일
	private Date mem_mdate;		    //수정일
	private int pet_num; 			//펫 번호
	private String pet_name;		//펫 이름
	private int pet_age;			//펫 나이
	private String pet_photo;		//펫 사진
	private String pet_note;  		//희망 반려생활
	
	//비밀번호 일치 여부 체크
	public boolean isCheckedPassword(String userPasswd) {
		//회원 등급(auth) : 0탈퇴회원,1정지회원,2일반회원,9관리자
		if(mem_auth > 1 && mem_pw.equals(userPasswd)) {
			return true;
		}
		return false;
	}

	public int getMem_num() {
		return mem_num;
	}

	public void setMem_num(int mem_num) {
		this.mem_num = mem_num;
	}

	public String getMem_id() {
		return mem_id;
	}

	public void setMem_id(String mem_id) {
		this.mem_id = mem_id;
	}

	public int getMem_auth() {
		return mem_auth;
	}

	public void setMem_auth(int mem_auth) {
		this.mem_auth = mem_auth;
	}

	public String getMem_name() {
		return mem_name;
	}

	public void setMem_name(String mem_name) {
		this.mem_name = mem_name;
	}

	public String getMem_pw() {
		return mem_pw;
	}

	public void setMem_pw(String mem_pw) {
		this.mem_pw = mem_pw;
	}

	public String getMem_cell() {
		return mem_cell;
	}

	public void setMem_cell(String mem_cell) {
		this.mem_cell = mem_cell;
	}

	public String getMem_email() {
		return mem_email;
	}

	public void setMem_email(String mem_email) {
		this.mem_email = mem_email;
	}

	public String getMem_zipcode() {
		return mem_zipcode;
	}

	public void setMem_zipcode(String mem_zipcode) {
		this.mem_zipcode = mem_zipcode;
	}

	public String getMem_address1() {
		return mem_address1;
	}

	public void setMem_address1(String mem_address1) {
		this.mem_address1 = mem_address1;
	}

	public String getMem_address2() {
		return mem_address2;
	}

	public void setMem_address2(String mem_address2) {
		this.mem_address2 = mem_address2;
	}

	public Date getMem_rdate() {
		return mem_rdate;
	}

	public void setMem_rdate(Date mem_rdate) {
		this.mem_rdate = mem_rdate;
	}

	public Date getMem_mdate() {
		return mem_mdate;
	}

	public void setMem_mdate(Date mem_mdate) {
		this.mem_mdate = mem_mdate;
	}	
public int getPet_num() {
	return pet_num;
}

public void setPet_num(int pet_num) {
	this.pet_num = pet_num;
}

public String getPet_name() {
	return pet_name;
}

public void setPet_name(String pet_name) {
	this.pet_name = pet_name;
}

public int getPet_age() {
	return pet_age;
}

public void setPet_age(int pet_age) {
	this.pet_age = pet_age;
}
public String getPet_photo() {
	return pet_photo;
}

public void setPet_photo(String pet_photo) {
	this.pet_photo = pet_photo;
}

public String getPet_note() {
	return pet_note;
}

public void setPet_note(String pet_note) {
	this.pet_note = pet_note;
}
}