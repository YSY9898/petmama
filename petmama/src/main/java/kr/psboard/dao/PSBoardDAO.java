package kr.psboard.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import kr.psboard.vo.PSBoardVO;
import kr.util.DBUtil;

public class PSBoardDAO {
	//싱글턴 패턴
	private static PSBoardDAO instance = new PSBoardDAO();
	public static PSBoardDAO getInstance() {
		return instance;
	}
	private PSBoardDAO() {}
	
	//펫시터 목록
	public List<PSBoardVO> getListPS()throws Exception{
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		List<PSBoardVO> list = null;
		String sql = null;
		
		try {
			//커넥션풀로부터 커넥션 할당
			conn = DBUtil.getConnection();
			//SQL문 작성
			sql = "SELECT * FROM petsitter_detail WHERE sis_condition=1 ORDER BY sis_num ASC"; //sis_condition이 1인것만 
			//PreparedStatement 객체 생성
			pstmt = conn.prepareStatement(sql);
			//SQL문 실행
			rs = pstmt.executeQuery();
			list = new ArrayList<PSBoardVO>();
			while(rs.next()) {
				PSBoardVO vo = new PSBoardVO();
				vo.setSis_num(rs.getInt("sis_num"));
				//펫시터 프로필에 필요한 내용
				//-------------------------
				//펫시터 프로필 사진
				vo.setPhoto1(rs.getString("sis_photo1"));
				//펫시터 소개 사진
				vo.setPhoto2(rs.getString("sis_photo2"));
				//펫시터 이름
				vo.setName(rs.getString("sis_name"));
				//제목
				vo.setTitle(rs.getString("sis_title"));
				//태그
				vo.setTag(rs.getString("sis_tag"));
				//후기 수
				//vo.setReview_num(rs.getInt(""));
				//별점
				vo.setRating(rs.getDouble("sis_rate"));
				list.add(vo);
			}
		}catch(Exception e) {
			throw new Exception(e);
		}finally {
			DBUtil.executeClose(rs, pstmt, conn);
		}	
		return list;
	}
	
	//펫시터 정보 상세
	public PSBoardVO getPSboard(int sis_num)throws Exception{
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		PSBoardVO vo = null;
		String sql = null;
		
		try {
			conn = DBUtil.getConnection();
			sql = "SELECT * FROM petsitter_detail WHERE sis_num=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, sis_num);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				vo = new PSBoardVO();
				//이름
				vo.setName(rs.getString("sis_name"));
				//펫시터 소개 제목
				vo.setTitle(rs.getString("sis_title"));
				//태그
				vo.setTag(rs.getString("sis_tag"));
				//평점
				//리뷰수
				//리뷰
				//프로필 사진
				vo.setPhoto1(rs.getString("sis_photo1"));
				//소개 사진
				vo.setPhoto2(rs.getString("sis_photo2"));
			}
		}catch(Exception e) {
			throw new Exception(e);
		}finally {
			DBUtil.executeClose(rs, pstmt, conn);
		}
		return vo;
	}
}
