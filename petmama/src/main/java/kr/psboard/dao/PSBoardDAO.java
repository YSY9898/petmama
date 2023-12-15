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
	public static PSBoardDAO getinstatnce() {
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
			sql = "SELECT * FROM petsitter_detail WHERE sis_condition=1 ORDER BY sis_num DESC"; //sis_condition이 1인것만 
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
				//별점
				
				list.add(vo);
			}
		}catch(Exception e) {
			throw new Exception(e);
		}finally {
			DBUtil.executeClose(rs, pstmt, conn);
		}	
		return list;
	}
}
