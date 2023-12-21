package kr.noticeboard.vo;

import java.sql.Date;

public class NoticeBoardVO {
	
	private int notice_num;
	private String notice_title;
	private String notice_content;
	private int notice_hit;
	private Date notice_reg_date;
	private Date notice_modify_date;
	private String notice_filename;
	private String notice_ip;
	private int mem_num;
	
	public int getNotice_num() {
		return notice_num;
	}
	public void setNotice_num(int notice_num) {
		this.notice_num = notice_num;
	}
	public String getNotice_title() {
		return notice_title;
	}
	public void setNotice_title(String notice_title) {
		this.notice_title = notice_title;
	}
	public String getNotice_content() {
		return notice_content;
	}
	public void setNotice_content(String notice_content) {
		this.notice_content = notice_content;
	}
	public int getNotice_hit() {
		return notice_hit;
	}
	public void setNotice_hit(int notice_hit) {
		this.notice_hit = notice_hit;
	}
	public Date getNotice_reg_date() {
		return notice_reg_date;
	}
	public void setNotice_reg_date(Date notice_reg_date) {
		this.notice_reg_date = notice_reg_date;
	}
	public Date getNotice_modify_date() {
		return notice_modify_date;
	}
	public void setNotice_modify_date(Date notice_modify_date) {
		this.notice_modify_date = notice_modify_date;
	}
	public String getNotice_filename() {
		return notice_filename;
	}
	public void setNotice_filename(String notice_filename) {
		this.notice_filename = notice_filename;
	}
	public String getNotice_ip() {
		return notice_ip;
	}
	public void setNotice_ip(String notice_ip) {
		this.notice_ip = notice_ip;
	}
	public int getMem_num() {
		return mem_num;
	}
	public void setMem_num(int mem_num) {
		this.mem_num = mem_num;
	}

}
