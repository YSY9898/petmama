package kr.reservation.vo;

import java.sql.Date;

public class ReservationVO {
	private int r_num;
	private int mem_num;
	private int sis_num;
	private Date r_reg_date;
	private Date r_modify_date;
	private int r_condition;
	private String r_pet_note;
	private String r_start;
	private String r_end;
	private int visit_status;
	private int sis_work; //펫시터 일 유형 (1. 산책 2. 돌봄 3. 둘 다)
	
	
	public int getSis_work() {
		return sis_work;
	}
	public void setSis_work(int sis_work) {
		this.sis_work = sis_work;
	}
	public String getR_pet_note() {
		return r_pet_note;
	}
	public void setR_pet_note(String r_pet_note) {
		this.r_pet_note = r_pet_note;
	}
	public int getVisit_status() {
		return visit_status;
	}
	public void setVisit_status(int visit_status) {
		this.visit_status = visit_status;
	}
	public int getR_num() {
		return r_num;
	}
	public void setR_num(int r_num) {
		this.r_num = r_num;
	}
	public int getMem_num() {
		return mem_num;
	}
	public void setMem_num(int mem_num) {
		this.mem_num = mem_num;
	}
	public int getSis_num() {
		return sis_num;
	}
	public void setSis_num(int sis_num) {
		this.sis_num = sis_num;
	}
	public Date getR_reg_date() {
		return r_reg_date;
	}
	public void setR_reg_date(Date r_reg_date) {
		this.r_reg_date = r_reg_date;
	}
	public Date getR_modify_date() {
		return r_modify_date;
	}
	public void setR_modify_date(Date r_modify_date) {
		this.r_modify_date = r_modify_date;
	}
	public int getR_condition() {
		return r_condition;
	}
	public void setR_condition(int r_condition) {
		this.r_condition = r_condition;
	}
	public String getR_start() {
		return r_start;
	}
	public void setR_start(String r_start) {
		this.r_start = r_start;
	}
	public String getR_end() {
		return r_end;
	}
	public void setR_end(String r_end) {
		this.r_end = r_end;
	}
	
}
