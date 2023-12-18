package kr.qnareply.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import kr.qna.vo.QnaReplyVO;
import kr.qna.vo.QnaVO;
import kr.util.DBUtil;
import kr.util.StringUtil;

public class QnaReplyDAO {
	// 싱글턴 패턴
	private static QnaReplyDAO instance = new QnaReplyDAO();

	public static QnaReplyDAO getInstance() {
		return instance;
	}

	private QnaReplyDAO() {
	}

	// 글 등록
	public boolean insertQnaReply(QnaReplyVO qnaReply) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		String sql = null;
		
		try {
			conn = DBUtil.getConnection();
			if(checkQnaReplyCount(qnaReply.getQ_num()) > 0) {
			sql = "UPDATE qna_reply SET " 
					+ " mem_num = ?," 
					+ " qr_content = ?," 
					+ " modify_date = SYSDATE," 
					+ " qr_ip = ? "
					+ " WHERE q_num = " + qnaReply.getQ_num();
					pstmt = conn.prepareStatement(sql);
					pstmt.setInt(1, qnaReply.getMem_num());
					pstmt.setString(2, qnaReply.getQr_content());
					pstmt.setString(3, qnaReply.getQr_ip());
					pstmt.executeUpdate();
			} else {
			sql = "INSERT INTO qna_reply ("
					+ "qr_num, " 
					+ "q_num," 
					+ "mem_num," 
					+ "qr_content," 
					+ "reg_date," 
					+ "modify_date," 
					+ "qr_ip) "
					+ "VALUES (qna_reply_seq.nextval,?,?,?,SYSDATE,NULL,?)";
					pstmt = conn.prepareStatement(sql);
					pstmt.setInt(1, qnaReply.getQ_num());
					pstmt.setInt(2, qnaReply.getMem_num());
					pstmt.setString(3, qnaReply.getQr_content());
					pstmt.setString(4, qnaReply.getQr_ip());
					pstmt.executeUpdate();
			}
		} catch (Exception e) {
			throw new Exception(e);
		} finally {
			DBUtil.executeClose(null, pstmt, conn);
		}
		return true;
	}
	
	public int checkQnaReplyCount(int q_num) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		int count = 0;
		
		try {
			//커넥션풀로부터 커넥션 할당
			conn = DBUtil.getConnection();
			//SQL문 작성
			sql = "SELECT COUNT(*) FROM qna_reply WHERE q_num = " + q_num;
			//PreparedStatement 객체 생성
			pstmt = conn.prepareStatement(sql);
			//SQL문 실행
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
}