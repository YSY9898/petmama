package kr.noticeboard.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;

import kr.noticeboard.vo.NoticeBoardVO;
import kr.util.DBUtil;

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
			sql = "INSERT INTO NOTICE_BOARD (notice_num,notice_title,notice_content,notice_filename,notice_ip,mem_num) VALUES (notice_board.nextval,?,?,?,?,?)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, vo.getNotice_title());
			pstmt.setString(2, vo.getNotice_content());
			pstmt.setString(3, vo.getNotice_filename());
			pstmt.setString(4, vo.getNotice_ip());
			pstmt.setInt(5, vo.getMem_num());
			
			pstmt.executeUpdate();
			
		}catch(Exception e) {
			throw new Exception(e);
		}finally {
			DBUtil.executeClose(null, pstmt, conn);
		}
	}
}
