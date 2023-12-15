package kr.qna.vo;

import java.sql.Date;

public class QnaVO {
	private int q_num; // qna 게시글 번호
	private int mem_num;
	private String mem_id;
	private int sis_num; // 펫시터 번호(해당 데이터가 null인 경우, 고객센터 관리자 qna)
	private int passwd; // qna 게시글 비밀번호
	private String title; // 제목
	private String content; // 내용
	private String filename; // 파일명
	private Date reg_date; // 가입일
	private Date modify_date; // 수정일
	private String answer_yn; // 답변여부
	private String hide_yn; // 공개여부

	public int getQ_num() {
		return q_num;
	}

	public void setQ_num(int q_num) {
		this.q_num = q_num;
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

	public int getSis_num() {
		return sis_num;
	}

	public void setSis_num(int sis_num) {
		this.sis_num = sis_num;
	}

	public int getPasswd() {
		return passwd;
	}

	public void setPasswd(int passwd) {
		this.passwd = passwd;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public String getFilename() {
		return filename;
	}

	public void setFilename(String filename) {
		this.filename = filename;
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

	public String getAnswer_yn() {
		return answer_yn;
	}

	public void setAnswer_yn(String answer_yn) {
		this.answer_yn = answer_yn;
	}

	public String getHide_yn() {
		return hide_yn;
	}

	public void setHide_yn(String hide_yn) {
		this.hide_yn = hide_yn;
	}
}