package kr.petsitter.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.servlet.http.HttpSession;

import kr.petsitter.vo.PetsitterVO;
import kr.util.DBUtil;

public class PetsitterDAO {
	//싱글턴 패턴
	private static PetsitterDAO instance = new PetsitterDAO();
	public static PetsitterDAO getInstance() {
		return instance;
	}
	private PetsitterDAO() {}
	
	//펫시터 지원
	public void applyPetsitter(PetsitterVO member)throws Exception{
		Connection conn = null;
		PreparedStatement pstmt = null;
		PreparedStatement pstmt2 = null;
		PreparedStatement pstmt3 = null;
		ResultSet rs = null;
		String sql = null;
		int num = 0; // 시퀀스 번호 저장
		
		try {
			//커넥션풀로부터 커넥션 할당
			conn = DBUtil.getConnection();
			//오토 커밋 해제
			conn.setAutoCommit(false);
			
			//펫시터 번호(sis_num) 생성
			sql = "SELECT petsitter_seq.nextval FROM dual";
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				num = rs.getInt(1);
			}
			
			//petsitter 테이블에 데이터를 저장
			sql = "INSERT INTO petsitter (sis_num, mem_num) VALUES (?,?)";
			pstmt2 = conn.prepareStatement(sql);
			pstmt2.setInt(1, num);
			pstmt2.setInt(2, member.getMem_num());
			pstmt2.executeUpdate();
			
			//petsitter_detail 테이블에 데이터를 저장
			sql = "INSERT INTO petsitter_detail (sis_num,mem_num,sis_name,sis_condition,sis_work,sis_career,"
				+ "sis_photo1,sis_photo2,sis_phone,sis_email,sis_zipcode,sis_address1,sis_address2,"
				+ "sis_title,sis_tag) "
				+ "VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
			pstmt3 = conn.prepareStatement(sql);
			
			pstmt3.setInt(1,num);
			pstmt3.setInt(2,member.getMem_num());
			pstmt3.setString(3,member.getSis_name());			
			pstmt3.setInt(4,member.getSis_condition());
			pstmt3.setInt(5,member.getSis_work());
			pstmt3.setInt(6,member.getSis_career());
			pstmt3.setString(7,member.getSis_photo1());
			pstmt3.setString(8,member.getSis_photo2());
			pstmt3.setString(9,member.getSis_phone());
			pstmt3.setString(10,member.getSis_email());
			pstmt3.setString(11,member.getSis_zipcode());
			pstmt3.setString(12, member.getSis_address1());
			pstmt3.setString(13, member.getSis_address2());
			pstmt3.setString(14, member.getTitle());
			pstmt3.setString(15, member.getTag());
			pstmt3.executeUpdate();
			
			//SQL문 실행시 모두 성공하면 commit
			conn.commit();
			
		}catch(Exception e) {
			//SQL문이 하나라도 실패하면 rollback
			conn.rollback();
			throw new Exception(e);
		}finally {
			DBUtil.executeClose(null, pstmt3, null);
			DBUtil.executeClose(null, pstmt2, null);
			DBUtil.executeClose(rs, pstmt, conn);
		}
		
	}
}
