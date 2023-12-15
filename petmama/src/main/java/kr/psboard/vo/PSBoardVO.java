package kr.psboard.vo;

import java.sql.Date;

public class PSBoardVO {
	private int board_num; 		//글번호
	private String title;		//제목
	private String tag;			//태그 ex)#훈련 경기 대회 수상 다수 # 방송 출현(개훌륭)
	private double rating;		//평점 5점 만점이며 소숫점 둘째 자리까지
	private int review_num;		//후기수
	private String photo1;		//펫시터 프로필 사진
	private String photo2;		//펫시터 소개 사진
	private String name;		//펫시터 이름
	private int sis_num;		//펫시터 회원번호
	private String ip;			//ip주소
	private Date reg_date;		//등록일
	private Date modify_date;	//수정일
	
	public int getSis_num() {
		return sis_num;
	}
	public void setSis_num(int sis_num) {
		this.sis_num = sis_num;
	}
	public String getIp() {
		return ip;
	}
	public void setIp(String ip) {
		this.ip = ip;
	}
	public int getBoard_num() {
		return board_num;
	}
	public void setBoard_num(int board_num) {
		this.board_num = board_num;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public double getRating() {
		return rating;
	}
	public void setRating(double rating) {
		this.rating = rating;
	}
	public int getReview_num() {
		return review_num;
	}
	public void setReview_num(int review_num) {
		this.review_num = review_num;
	}
	public String getPhoto1() {
		return photo1;
	}
	public void setPhoto1(String photo1) {
		this.photo1 = photo1;
	}
	public String getPhoto2() {
		return photo2;
	}
	public void setPhoto2(String photo2) {
		this.photo2 = photo2;
	}
	public Date getReg_date() {
		return reg_date;
	}
	public void setReg_date(Date reg_date) {
		this.reg_date = reg_date;
	}
	public Date getModify_date() {
		return modify_date;
	}
	public void setModify_date(Date modify_date) {
		this.modify_date = modify_date;
	}
	public String getTag() {
		return tag;
	}
	public void setTag(String tag) {
		this.tag = tag;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	
}
