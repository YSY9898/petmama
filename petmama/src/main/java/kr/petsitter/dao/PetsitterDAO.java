package kr.petsitter.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

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
				+ "sis_title,sis_tag,sis_apply_date) "
				+ "VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,SYSDATE)";
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
	
	//펫시터 일 유형
	public int getPSwork(int sis_num) throws Exception{
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		int sis_work = 0;
		
		try {
			//커넥션풀로부터 커넥션 할당
			conn = DBUtil.getConnection();
			//SQL문 작성
			sql = "SELECT sis_work FROM petsitter_detail WHERE sis_num = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, sis_num);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				sis_work = rs.getInt("sis_work");
			}
			
		}catch(Exception e) {
			throw new Exception(e);
		}finally {
			DBUtil.executeClose(rs, pstmt, conn);
		}
		
		return sis_work;
	}
	
	//관리자 - 전체 지원글 수
	public int getApplyCount(String keyfield, String keyword) throws Exception{
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		String sub_sql = "";
		int count = 0;
		
		try {
			//커넥션풀로부터 커넥션을 할당
			conn = DBUtil.getConnection();
			if(keyword!=null && !"".equals(keyword)) {
				//검색 처리
				if(keyfield.equals("1")) sub_sql += "WHERE sis_num LIKE ?";
				else if(keyfield.equals("2")) sub_sql += "WHERE sis_name LIKE ?";
				else if(keyfield.equals("3")) sub_sql += "WHERE sis_condition LIKE ?";
			}
			//SQL문 작성
			sql = "SELECT COUNT(*) FROM petsitter JOIN petsitter_detail USING(mem_num) " + sub_sql;
			//PreparedStatement 객체 생성
			pstmt = conn.prepareStatement(sql);
			
			if(keyword!=null && !"".equals(keyword)) {
				pstmt.setString(1, "%"+keyword+"%");
			}
			
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
	//관리자 - 전체 지원글 목록
	public List<PetsitterVO> getListApply(int start, int end,
			                    String keyfield, String keyword)
	                            throws Exception{
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		List<PetsitterVO> list = null;
		String sql = null;
		String sub_sql = "";
		int cnt = 0;
		
		try {
			//커넥션풀로부터 커넥션 할당
			conn = DBUtil.getConnection();
		
			if(keyword!=null && !"".equals(keyword)) {
				//검색 처리
				if(keyfield.equals("1")) sub_sql += "WHERE sis_num LIKE ?";
				else if(keyfield.equals("2")) sub_sql += "WHERE sis_name LIKE ?";
				else if(keyfield.equals("3")) sub_sql += "WHERE sis_condition LIKE ?";
			}
			
			//SQL문 작성
			sql = "SELECT * FROM (SELECT a.*, rownum rnum FROM (SELECT * FROM petsitter JOIN petsitter_detail USING(mem_num) " + sub_sql + " ORDER BY sis_apply_date DESC)a) WHERE rnum >= ? AND rnum <= ?";
			//PreparedStatement 객체 생성
			pstmt = conn.prepareStatement(sql);
			//?에 데이터 바인딩
			if(keyword!=null && !"".equals(keyword)) {
				pstmt.setString(++cnt, "%"+keyword+"%");
			}
			
			pstmt.setInt(++cnt, start);
			pstmt.setInt(++cnt, end);
			//SQL문 실행
			rs = pstmt.executeQuery();
			
			list = new ArrayList<PetsitterVO>();
			while(rs.next()) {
				PetsitterVO vo = new PetsitterVO();
				vo.setSis_num(rs.getInt("sis_num"));
				vo.setMem_num(rs.getInt("mem_num"));
				vo.setSis_name(rs.getString("sis_name"));
				vo.setSis_condition(rs.getInt("sis_condition"));
				vo.setSis_work(rs.getInt("sis_work"));
				vo.setSis_career(rs.getInt("sis_career"));
				vo.setSis_email(rs.getString("sis_email"));
				vo.setSis_phone(rs.getString("sis_phone"));
				vo.setSis_photo1(rs.getString("sis_photo1"));
				vo.setSis_photo2(rs.getString("sis_photo2"));
				vo.setSis_zipcode(rs.getString("sis_zipcode"));
				vo.setSis_address1(rs.getString("sis_address1"));
				vo.setSis_address2(rs.getString("sis_address2"));
				vo.setSis_apply_date(rs.getDate("sis_apply_date"));
				//vo.setSis_accept_date(rs.getDate("sis_accept_date"));
				//vo.setSis_mdate(rs.getDate("sis_mdate"));
				vo.setTitle(rs.getString("sis_title"));
				vo.setTag(rs.getString("sis_tag"));
				
				list.add(vo);				
			}			
		}catch(Exception e) {
			throw new Exception(e);
		}finally {
			DBUtil.executeClose(rs, pstmt, conn);
		}		
		return list;
	}
	//펫시터 상세
	public PetsitterVO getApply(int sis_num)throws Exception{
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		PetsitterVO vo = null;
		String sql = null;

		try {
			//커넥션풀로부터 커넥션 할당
			conn = DBUtil.getConnection();
		
			//SQL문 작성
			sql = "SELECT * FROM petsitter a JOIN petsitter_detail USING(mem_num) WHERE a.sis_num=?";
			//PreparedStatement 객체 생성
			pstmt = conn.prepareStatement(sql);
			//?에 데이터 바인딩
			pstmt.setInt(1, sis_num);
			//SQL문 실행
			rs = pstmt.executeQuery();
			if(rs.next()) {
				vo = new PetsitterVO();
				vo.setSis_num(rs.getInt("sis_num"));
				vo.setMem_num(rs.getInt("mem_num"));
				vo.setSis_name(rs.getString("sis_name"));
				vo.setSis_condition(rs.getInt("sis_condition"));
				vo.setSis_work(rs.getInt("sis_work"));
				vo.setSis_career(rs.getInt("sis_career"));
				vo.setSis_email(rs.getString("sis_email"));
				vo.setSis_phone(rs.getString("sis_phone"));
				vo.setSis_photo1(rs.getString("sis_photo1"));
				vo.setSis_photo2(rs.getString("sis_photo2"));
				vo.setSis_zipcode(rs.getString("sis_zipcode"));
				vo.setSis_address1(rs.getString("sis_address1"));
				vo.setSis_address2(rs.getString("sis_address2"));
				vo.setSis_apply_date(rs.getDate("sis_apply_date"));
				vo.setSis_accept_date(rs.getDate("sis_accept_date"));
				vo.setSis_mdate(rs.getDate("sis_mdate"));
				vo.setTitle(rs.getString("sis_title"));
				vo.setTag(rs.getString("sis_tag"));				
			}			
		}catch(Exception e) {
			throw new Exception(e);
		}finally {
			DBUtil.executeClose(rs, pstmt, conn);
		}		
			return vo;
		}
		
	//관리자 - 시터 상태 수정
	public void updatePetsitterStatus(PetsitterVO vo)throws Exception{
		Connection conn = null;
		PreparedStatement pstmt = null;
		String sql = null;
		
		try {
			//커넥션풀로부터 커넥션 할당
			conn = DBUtil.getConnection();
			//SQL문 작성
			sql = "UPDATE petsitter_detail SET sis_condition=?,sis_accept_date=SYSDATE WHERE sis_num=?";
			//PreparedStatement 객체 생성
			pstmt = conn.prepareStatement(sql);
			//?에 데이터 바인딩
			pstmt.setInt(1, vo.getSis_condition());
			pstmt.setInt(2, vo.getSis_num());
			//SQL문 실행
			pstmt.executeUpdate();
			
		}catch(Exception e) {
			throw new Exception(e);
		}finally {
			DBUtil.executeClose(null, pstmt, conn);
		}
	}
}
