package kr.board2.vo;

public class BoardReplyVO2 {
	private int re_num;				//댓글번호
	private String re_content; 		//내용
	private String re_date;			//작성일
	private String re_modifydate;	//수정일
	private String re_ip;			//아이피주소
	private int board_num;			//게시판번호
	private int mem_num;			//작성자 회원번호
	private String mem_nickname;	//작성자 닉네임
	private String mem_id;
	
	public int getRe_num() {
		return re_num;
	}
	public void setRe_num(int re_num) {
		this.re_num = re_num;
	}
	public String getRe_content() {
		return re_content;
	}
	public void setRe_content(String re_content) {
		this.re_content = re_content;
	}
	public String getRe_date() {
		return re_date;
	}
	public void setRe_date(String re_date) {
		this.re_date = re_date;
	}
	public String getRe_modifydate() {
		return re_modifydate;
	}
	public void setRe_modifydate(String re_modifydate) {
		this.re_modifydate = re_modifydate;
	}
	public String getRe_ip() {
		return re_ip;
	}
	public void setRe_ip(String re_ip) {
		this.re_ip = re_ip;
	}
	public int getBoard_num() {
		return board_num;
	}
	public void setBoard_num(int board_num) {
		this.board_num = board_num;
	}
	public int getMem_num() {
		return mem_num;
	}
	public void setMem_num(int mem_num) {
		this.mem_num = mem_num;
	}
	public String getMem_nickname() {
		return mem_nickname;
	}
	public void setMem_nickname(String mem_nickname) {
		this.mem_nickname = mem_nickname;
	}
	public String getMem_id() {
		return mem_id;
	}
	public void setMem_id(String mem_id) {
		this.mem_id = mem_id;
	}
}
