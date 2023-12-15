package kr.qna.vo;

import java.sql.Date;

public class QnaReplyVO {
	private int qr_num; // qna 게시글 댓글 번호
	private int q_num; // qna 게시글 번호(fk)
	private int mem_num;
	private String qr_content; // 내용
	private Date reg_date; // 작성일
	private Date modify_date; // 수정일
	private String qr_ip;

	public int getQr_num() {
		return qr_num;
	}

	public void setQr_num(int qr_num) {
		this.qr_num = qr_num;
	}

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

	public String getQr_content() {
		return qr_content;
	}

	public void setQr_content(String qr_content) {
		this.qr_content = qr_content;
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

	public String getQr_ip() {
		return qr_ip;
	}

	public void setQr_ip(String qr_ip) {
		this.qr_ip = qr_ip;
	}
}