package kr.noticeboard.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;

import kr.noticeboard.vo.NoticeBoardVO;

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
		
	}
}
