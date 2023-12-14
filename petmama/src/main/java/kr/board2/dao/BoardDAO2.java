package kr.board2.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import kr.board2.vo.BoardReplyVO2;
import kr.board2.vo.BoardVO2;
import kr.util.DBUtil;
import kr.util.StringUtil;

public class BoardDAO2 {
	private static BoardDAO2 instance = new BoardDAO2();

	public static BoardDAO2 getInstance() {
		return instance;
	}

	private BoardDAO2() {}

	//글 등록
	public void insertBoard2(BoardVO2 board1)throws Exception{
		Connection conn = null;
		PreparedStatement pstmt = null;
		String sql = null;

		try {
			conn = DBUtil.getConnection();
			sql = "INSERT INTO board2 (board_num,board_type,title,content,filename,ip,mem_num) VALUES (board2_seq.nextval,1,?,?,?,?,?)";
			System.out.println(sql);
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, board1.getTitle());
			pstmt.setString(2, board1.getContent());
			pstmt.setString(3, board1.getFilename());
			pstmt.setString(4, board1.getIp());
			pstmt.setInt(5, board1.getMem_num());

			pstmt.executeUpdate();

		}catch(Exception e) {
			throw new Exception(e);
		}finally {
			DBUtil.executeClose(null, pstmt, conn);
		}
	}
	//전체 레코드 수/검색 레코드 수
	public int getBoardCount(String keyfield,String keyword)
			throws Exception{
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		String sub_sql = "";
		int count = 0;

		try {
			conn = DBUtil.getConnection();
			sql = "SELECT COUNT (*) FROM board2 JOIN member USING(mem_num) LEFT OUTER JOIN member_detail USING(mem_num) " + sub_sql;
			pstmt = conn.prepareStatement(sql);
			if(keyword != null && !"".equals(keyword)) {
				pstmt.setString(1, "%"+keyword+"%");
			}
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
	public List<BoardVO2> getListBoard(int start,int end,
			String keyfield, String keyword)
					throws Exception{
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		List<BoardVO2> list = null;
		String sql = null;
		String sub_sql = "";
		int cnt = 0;

		try {
			conn = DBUtil.getConnection();

			if(keyword != null && !"".equals(keyword)) {
				if(keyfield.equals("1")) sub_sql += "WHERE title LIKE ?";
				else if(keyfield.equals("2")) sub_sql += "WHERE mem_nickname LIKE ?";
				else if(keyfield.equals("3")) sub_sql += "WHERE content LIKE ?";
			}
			sql = "SELECT * FROM (SELECT a.*, rownum rnum FROM "
				+ "(SELECT * FROM board2 JOIN member USING(mem_num) LEFT OUTER JOIN member_detail USING(mem_num) " + sub_sql
				+ " ORDER BY board_num DESC)a) WHERE rnum >=? AND rnum <= ?";

			pstmt = conn.prepareStatement(sql);

			if(keyword != null && !"".equals(keyword)) {
				pstmt.setString(++cnt, "%"+keyword+"%");
			}
			pstmt.setInt(++cnt, start);
			pstmt.setInt(++cnt, end);

			rs = pstmt.executeQuery();
			list = new ArrayList<BoardVO2>();
			while(rs.next()) {
				BoardVO2 board1 = new BoardVO2();
				board1.setBoard_num(rs.getInt("board_num"));
				board1.setTitle(StringUtil.useNoHtml(rs.getString("title")));
				board1.setHit(rs.getInt("hit"));
				board1.setReg_date(rs.getDate("reg_date"));
				board1.setMem_nickname(rs.getString("mem_nickname"));
				board1.setMem_id(rs.getString("mem_id"));

				list.add(board1);
			}
		}catch(Exception e) {
			throw new Exception(e);
		}finally {
			DBUtil.executeClose(rs, pstmt, conn);
		}

		return list;
	}
	//글 상세
	public BoardVO2 getBoard(int board_num)throws Exception{
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		BoardVO2 board1 = null;
		String sql = null;

		try {
			conn = DBUtil.getConnection();
			sql = "SELECT * FROM board2 JOIN member USING(mem_num) "
				+ "LEFT OUTER JOIN member_detail USING(mem_num) "
				+ "WHERE board_num=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, board_num);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				board1 = new BoardVO2();
				board1.setBoard_num(rs.getInt("board_num"));
				board1.setMem_nickname(rs.getString("mem_nickname"));
				board1.setTitle(rs.getString("title"));
				board1.setContent(rs.getString("content"));
				board1.setHit(rs.getInt("hit"));
				board1.setReg_date(rs.getDate("reg_date"));
				board1.setModify_date(rs.getDate("modify_date"));
				board1.setFilename(rs.getString("filename"));
				board1.setMem_num(rs.getInt("mem_num"));
				board1.setMem_id(rs.getString("mem_id"));
			}
		}catch(Exception e) {
			throw new Exception(e);
		}finally {
			DBUtil.executeClose(rs, pstmt, conn);
		}
		return board1;
	}
	//조회수 증가
	public void updateReadCount(int board_num)throws Exception{
		Connection conn = null;
		PreparedStatement pstmt = null;
		String sql = null;
		
		try {
			conn = DBUtil.getConnection();
			sql = "UPDATE board2 SET hit=hit+1 WHERE board_num=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, board_num);
			pstmt.executeUpdate();
		}catch(Exception e) {
			throw new Exception(e);
		}finally {
			DBUtil.executeClose(null, pstmt, conn);
		}
		
	}
	//파일 삭제
	public void deleteFile(int board_num)throws Exception{
		Connection conn = null;
		PreparedStatement pstmt = null;
		String sql = null;
		
		try {
			conn = DBUtil.getConnection();
			sql = "UPDATE board2 SET filename='' WHERE board_num=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, board_num);
			pstmt.executeUpdate();
		}catch(Exception e) {
			throw new Exception(e);
		}finally {
			DBUtil.executeClose(null, pstmt, conn);
		}
	}
	//글 수정
	public void updateBoard(BoardVO2 board1)throws Exception{
		Connection conn = null;
		PreparedStatement pstmt = null;
		String sql = null;
		String sub_sql = "";
		int cnt = 0;
		
		try {
			conn = DBUtil.getConnection();
			
			if(board1.getFilename()!=null) {
				sub_sql += ",filename=?";
			}
			sql = "UPDATE board2 SET title=?,content=?,modify_date=SYSDATE,ip=?" + sub_sql + " WHERE board_num=?";
			
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(++cnt, board1.getTitle());
			pstmt.setString(++cnt, board1.getContent());
			pstmt.setString(++cnt, board1.getIp());
			if(board1.getFilename()!=null) {
				pstmt.setString(++cnt, board1.getFilename());
			}
			pstmt.setInt(++cnt, board1.getBoard_num());
			
			pstmt.executeUpdate();
		}catch(Exception e) {
			throw new Exception(e);
		}finally {
			DBUtil.executeClose(null, pstmt, conn);
		}
	}
	//글 삭제
	public void deleteBoard(int board_num)throws Exception{
		Connection conn = null;
		PreparedStatement pstmt = null;
		PreparedStatement pstmt2 = null;
		PreparedStatement pstmt3 = null;
		String sql = null;
		
		try {
			conn = DBUtil.getConnection();
			
			conn.setAutoCommit(false);
			
			sql = "DELETE FROM board2_fav WHERE board_num=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, board_num);
			pstmt.executeUpdate();
			
			sql = "DELETE FROM board2_reply WHERE board_num=?";
			pstmt2 = conn.prepareStatement(sql);
			pstmt2.setInt(2, board_num);
			pstmt2.executeUpdate();
			
			sql = "DELETE FROM board2 WHERE board_num=?";
			pstmt3 = conn.prepareStatement(sql);
			pstmt3.setInt(3, board_num);
			pstmt.executeUpdate();
			
			conn.commit();
		}catch(Exception e) {
			conn.rollback();
			throw new Exception(e);
		}finally {
			DBUtil.executeClose(null, pstmt3, null);
			DBUtil.executeClose(null, pstmt2, null);
			DBUtil.executeClose(null, pstmt, conn);
		}
	}
	//좋아요 등록
	//좋아요 개수
	//회원번호와 게시물 번호를 이용한 좋아요 정보 (좋아요 상세 정보)
	//좋아요 삭제
	//내가 선택한 좋아요 목록

	//댓글 등록
	public void insertReplyBoard(BoardReplyVO2 boardreply)
									throws Exception{
		Connection conn = null;
		PreparedStatement pstmt = null;
		String sql = null;
		
		try {
			conn = DBUtil.getConnection();			
			sql = "INSERT INTO board2_reply (re_num,re_content,"
				+ "re_ip,mem_num,board_num) VALUES "
				+ "(board2_reply_seq.nextval,?,?,?,?)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, boardreply.getRe_content());
			pstmt.setString(2, boardreply.getRe_ip());
			pstmt.setInt(3, boardreply.getMem_num());
			pstmt.setInt(4, boardreply.getBoard_num());
			
			pstmt.executeUpdate();
		}catch(Exception e) {
			throw new Exception(e);
		}finally {
			DBUtil.executeClose(null, pstmt, conn);
		}
	}
	//댓글 개수 
	public int getReplyBoardCount(int board_num)throws Exception{
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		int count = 0;
		
		try {
			conn = DBUtil.getConnection();
			sql = "SELECT COUNT(*) FROM board2_reply JOIN member "
				+ "USING(mem_num) WHERE board_num=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, board_num);
			rs=pstmt.executeQuery();
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
	//댓글 목록
	//댓글 상세(댓글 수정,삭제시 작성자 회원번호 체크 용도로 사용)
	//댓글 수정
	//댓글 삭제
}
