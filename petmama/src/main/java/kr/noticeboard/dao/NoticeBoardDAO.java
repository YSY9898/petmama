package kr.noticeboard.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import kr.noticeboard.vo.NoticeBoardVO;
import kr.util.DBUtil;
import kr.util.StringUtil;

public class NoticeBoardDAO {
	//싱글턴 패턴
	private static NoticeBoardDAO instance = new NoticeBoardDAO();
	
	public static NoticeBoardDAO getInstance() {
		return instance;
	}
	
	private NoticeBoardDAO() {}
	
	//글 등록
	public void insertNoticeBoard(NoticeBoardVO vo)throws Exception{
		Connection conn = null;
		PreparedStatement pstmt = null;
		String sql = null;
		
		try {
			conn = DBUtil.getConnection();
			sql = "INSERT INTO notice_board (notice_num,notice_title,notice_content,notice_filename,notice_ip,notice_status,mem_num) VALUES (notice_board_seq.nextval,?,?,?,?,?,?)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, vo.getNotice_title());
			pstmt.setString(2, vo.getNotice_content());
			pstmt.setString(3, vo.getNotice_filename());
			pstmt.setString(4, vo.getNotice_ip());
			pstmt.setInt(5, vo.getNotice_status());
			pstmt.setInt(6, vo.getMem_num());
			
			pstmt.executeUpdate();
			
		}catch(Exception e) {
			throw new Exception(e);
		}finally {
			DBUtil.executeClose(null, pstmt, conn);
		}
	}
	
	//전체 레코드수/검색 레코드수
	public int getNoticeBoardCount(String keyfield,String keyword, int notice_status) throws Exception{
			Connection conn = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			String sql = null;
			String sub_sql ="";
			int count = 0;
			
		try {
			conn = DBUtil.getConnection();
			if(keyword!=null && !"".equals(keyword)) {
				//검색 처리
				if(keyfield.equals("1")) sub_sql += "AND notice_title LIKE ?";
				else if(keyfield.equals("2")) sub_sql += "AND mem_nickname LIKE ?";
				else if(keyfield.equals("3")) sub_sql += "AND notice_content LIKE ?";
			}
			sql = "SELECT COUNT(*) FROM notice_board JOIN member USING(mem_num) LEFT OUTER JOIN member_detail USING(mem_num) WHERE notice_status > ? " + sub_sql;
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, notice_status);
			if(keyword!=null && !"".equals(keyword)) pstmt.setString(2, "%"+keyword+"%");
			rs = pstmt.executeQuery();
			if(rs.next()) {
				count = rs.getInt(1);
			}
		}catch(Exception e) {
			throw new Exception(e);
		}finally {
			DBUtil.executeClose(rs, pstmt, conn);
		}
		return count;
	}
	//전체 글/검색 글 목록
	public List<NoticeBoardVO> getNoticeListBoard(int start,int end,String keyfield,String keyword,int notice_status)throws Exception{
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		List<NoticeBoardVO> list = null;
		String sql = null;
		String sub_sql = "";
		int cnt = 0;
		
		try {
			conn = DBUtil.getConnection();
			if(keyword!=null && !"".equals(keyword)) { 
				//검색 처리
				if(keyfield.equals("1")) sub_sql += "AND notice_title LIKE ?";
				else if(keyfield.equals("2")) sub_sql += "AND mem_nickname LIKE ?";
				else if(keyfield.equals("3")) sub_sql += "AND notice_content LIKE ?";
			}
			sql = "SELECT * FROM (SELECT a.*, rownum rnum FROM (SELECT * FROM notice_board JOIN member USING(mem_num) LEFT OUTER JOIN member_detail USING(mem_num) WHERE notice_status > ? " + sub_sql + " ORDER BY notice_num DESC)a) WHERE rnum >= ? AND rnum <= ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(++cnt, notice_status);
			if(keyword!=null && !"".equals(keyword)) {
				pstmt.setString(++cnt, "%"+keyword+"%");
			}
			pstmt.setInt(++cnt, start);
			pstmt.setInt(++cnt, end);
			rs = pstmt.executeQuery();
			list = new ArrayList<NoticeBoardVO>();
			while(rs.next()) {
				NoticeBoardVO vo = new NoticeBoardVO();
				vo.setNotice_num(rs.getInt("notice_num"));
				vo.setNotice_title(StringUtil.useNoHtml(rs.getString("notice_title")));
				vo.setNotice_hit(rs.getInt("notice_hit"));
				vo.setNotice_reg_date(rs.getDate("notice_reg_date"));
				vo.setNotice_status(rs.getInt("notice_status"));
				vo.setMem_nickname(rs.getString("mem_nickname"));
				vo.setMem_id(rs.getString("mem_id"));
				
				list.add(vo);
			}
		}catch(Exception e) {
			throw new Exception(e);
		}finally {
			DBUtil.executeClose(rs, pstmt, conn);
		}
		return list;
	}
	//글 상세
	public NoticeBoardVO getNoticeBoard(int notice_num) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		NoticeBoardVO vo = null;
		
		try {
			conn = DBUtil.getConnection();
			sql = "SELECT * FROM notice_board JOIN member USING(mem_num) LEFT OUTER JOIN member_detail USING(mem_num) LEFT OUTER JOIN pet_detail USING(mem_num) WHERE notice_num = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, notice_num);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				vo = new NoticeBoardVO();
				vo.setNotice_num(rs.getInt("notice_num"));
				vo.setNotice_title(rs.getString("notice_title"));
				vo.setNotice_content(rs.getString("notice_content"));
				vo.setNotice_hit(rs.getInt("notice_hit"));
				vo.setNotice_reg_date(rs.getDate("notice_reg_date"));
				vo.setNotice_modify_date(rs.getDate("notice_modify_date"));
				vo.setNotice_filename(rs.getString("notice_filename"));
				vo.setNotice_status(rs.getInt("notice_status"));
				vo.setMem_nickname(rs.getString("mem_nickname"));
				vo.setMem_num(rs.getInt("mem_num"));
				vo.setPet_photo(rs.getString("pet_photo"));
			}
		}catch(Exception e) {
			throw new Exception(e);
		}finally {
			DBUtil.executeClose(rs, pstmt, conn);
		}
		return vo;
	}
	//조회수 증가
	public void upNoticeBoardcount(int notice_num)throws Exception{
		Connection conn = null;
		PreparedStatement pstmt = null;
		String sql = null;
		
		try {
			conn = DBUtil.getConnection();
			sql = "UPDATE notice_board SET notice_hit=notice_hit+1 WHERE notice_num=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, notice_num);
			pstmt.executeUpdate();
			
		}catch(Exception e) {
			throw new Exception(e);
		}finally {
			DBUtil.executeClose(null, pstmt, conn);
		}
	}
	
	//글 수정
	public void updateNoticeBoard(NoticeBoardVO board)throws Exception{
		Connection conn = null;
		PreparedStatement pstmt = null;
		String sql = null;
		String sub_sql = "";
		int cnt = 0;
		
		try {
			conn = DBUtil.getConnection();
			if(board.getNotice_filename()!=null) {
				sub_sql += ",notice_filename=?";
			}
			sql = "UPDATE notice_board SET notice_title=?,notice_content=?,notice_modify_date=SYSDATE,notice_ip=?,notice_status=?" + sub_sql + " WHERE notice_num=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(++cnt, board.getNotice_title());
			pstmt.setString(++cnt, board.getNotice_content());
			pstmt.setString(++cnt, board.getNotice_ip());
			pstmt.setInt(++cnt, board.getNotice_status());
			if(board.getNotice_filename()!=null) {
				pstmt.setString(++cnt, board.getNotice_filename());
			}
			pstmt.setInt(++cnt, board.getNotice_num());
			pstmt.executeUpdate();
		}catch(Exception e) {
			throw new Exception(e);
		}finally {
			DBUtil.executeClose(null, pstmt, conn);
		}
	}
	//파일 삭제
	public void deleteNoticeFile(int notice_num)throws Exception{
		Connection conn = null;
		PreparedStatement pstmt = null;
		String sql = null;
		
		try {
			conn = DBUtil.getConnection();
			sql = "UPDATE notice_board SET notice_filename='' WHERE notice_num = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, notice_num);
			pstmt.executeUpdate();
			
		}catch(Exception e) {
			throw new Exception(e);
		}finally {
			DBUtil.executeClose(null, pstmt, conn);
		}
	}
	//글 삭제
	public void deleteNoticeBoard(int notice_num)throws Exception{
		Connection conn = null;
		PreparedStatement pstmt = null;
		String sql = null;
		
		try {
			conn = DBUtil.getConnection();			
			
			sql = "DELETE FROM notice_board WHERE notice_num=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, notice_num);
			pstmt.executeUpdate();
			
		}catch(Exception e) {
			conn.rollback();
			throw new Exception(e);
		}finally {
			DBUtil.executeClose(null, pstmt, conn);
		}
	}
}
