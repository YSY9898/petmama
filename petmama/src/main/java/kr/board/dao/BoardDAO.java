package kr.board.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;

import kr.board.vo.BoardVO;
import kr.util.DBUtil;

public class BoardDAO {
	//싱글턴 패턴
	private static BoardDAO instance = new BoardDAO();
	
	public static BoardDAO getInstance() {
		return instance;
	}
	
	private BoardDAO() {}
	
	//글 등록
	public void insertBoard(BoardVO board)throws Exception{
		Connection conn = null;
		PreparedStatement pstmt = null;
		String sql = null;

		try {
			conn = DBUtil.getConnection();
			sql = "INSERT INTO board (board_num,board_type,title,content,filename,ip,mem_num,mem_nickname) VALUES (board_seq.nextval,0,?,?,?,?,?,?)";
			System.out.println(sql);
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, board.getTitle());
			pstmt.setString(2, board.getContent());
			pstmt.setString(3, board.getFilename());
			pstmt.setString(4, board.getIp());
			pstmt.setInt(5, board.getMem_num());
			pstmt.setString(6, board.getMem_nickname());
			
			pstmt.executeUpdate();
			
		}catch(Exception e) {
			throw new Exception(e);
		}finally {
			DBUtil.executeClose(null, pstmt, conn);

		}
	}
	//전체 레코드 수/검색 레코드 수
	//전체 글/검색 글 목록
	//글 상세
	//조회수 증가
	//파일 삭제
	//글 수정
	//글 삭제
		
	//좋아요 등록
	//좋아요 개수
	//회원번호와 게시물 번호를 이용한 좋아요 정보 (좋아요 상세 정보)
	//좋아요 삭제
	//내가 선택한 좋아요 목록
		
	//댓글 등록
	//댓글 개수
	//댓글 목록
	//댓글 상세(댓글 수정,삭제시 작성자 회원번호 체크 용도로 사용)
	//댓글 수정
	//댓글 삭제


}
