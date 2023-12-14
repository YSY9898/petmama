package kr.member.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import kr.member.vo.MemberVO;
import kr.util.DBUtil;

public class MemberDAO {
	//싱글턴 패턴
	private static MemberDAO instance = new MemberDAO();
	public static MemberDAO getInstance() {
		return instance;
	}
	private MemberDAO() {}
	
	//일반회원 회원가입
	public void insertMember(MemberVO member)throws Exception{
		Connection conn = null;
		PreparedStatement pstmt = null;
		PreparedStatement pstmt2 = null;
		PreparedStatement pstmt3 = null;
		PreparedStatement pstmt4 = null;
		ResultSet rs = null;
		String sql = null;
		int num = 0; //시퀀스 번호 저장
		
		try {
			//커넥션풀로부터 커넥션 할당
			conn = DBUtil.getConnection();
			//오토 커밋 해제
			conn.setAutoCommit(false);
			
			//회원 번호(mem_num) 생성
			sql = "SELECT member_seq.nextval FROM dual";
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				num = rs.getInt(1);
			}
			
			//member 테이블에 데이터를 저장
			sql = "INSERT INTO member (mem_num,mem_id) VALUES (?,?)";
			pstmt2 = conn.prepareStatement(sql);
			pstmt2.setInt(1, num);//회원 번호
			pstmt2.setString(2, member.getMem_id());//아이디
			pstmt2.executeUpdate();

			//member_detail 테이블에 데이터를 저장
			sql = "INSERT INTO member_detail (mem_num,mem_name,mem_nickname,mem_pw,mem_cell,"
				+ "mem_email,mem_zipcode,mem_address1,mem_address2) VALUES (?,?,?,?,?,?,?,?,?)";
			pstmt3 = conn.prepareStatement(sql);
			
			pstmt3.setInt(1, num);//회원 번호
			pstmt3.setString(2, member.getMem_name());
			pstmt3.setString(3, member.getMem_nickname());
			pstmt3.setString(4, member.getMem_pw());
			pstmt3.setString(5, member.getMem_cell());
			pstmt3.setString(6, member.getMem_email());
			pstmt3.setString(7, member.getMem_zipcode());
			pstmt3.setString(8, member.getMem_address1());
			pstmt3.setString(9, member.getMem_address2());
			pstmt3.executeUpdate();
			
			//pet_detail 테이블에 데이터를 저장
			sql="INSERT INTO pet_detail (mem_num,pet_num,pet_name,pet_age,pet_photo,pet_note) "
					+ "VALUES (?,?,?,?,?,?)";
			pstmt4 = conn.prepareStatement(sql);
			
			pstmt4.setInt(1, num);//회원번호
			pstmt4.setInt(2, member.getPet_num());
			pstmt4.setString(3, member.getPet_name());
			pstmt4.setInt(4, member.getPet_age());
			pstmt4.setString(5,member.getPet_photo());
			pstmt4.setString(6,member.getPet_note());
			pstmt4.executeUpdate();

			
			//SQL문 실행시 모두 성공하면 commit
			conn.commit();			
		}catch(Exception e) {
			//SQL문이 하나라도 실패하면 rollback
			conn.rollback();
			throw new Exception(e);
		}finally {
			DBUtil.executeClose(null, pstmt4, null);
			DBUtil.executeClose(null, pstmt3, null);
			DBUtil.executeClose(null, pstmt2, null);
			DBUtil.executeClose(rs, pstmt, conn);
		}
	}
	
	
	//ID 중복 체크 및 로그인 처리
	public MemberVO checkMember(String mem_id)throws Exception{
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		MemberVO member = null;
		String sql = null;
		
		try {
			//커넥션풀로부터 커넥션 할당
			conn = DBUtil.getConnection();
			//SQL문 작성
			//member와 member_detail 조인시 member의 누락된 데이터가 보여야 id 중복 체크 가능
			sql="SELECT * FROM member LEFT OUTER JOIN member_detail USING(mem_num) WHERE mem_id=?";
			//PreparedStatement 객체 생성
			pstmt = conn.prepareStatement(sql);
			//?에 데이터 바인딩
			pstmt.setString(1, mem_id);
			//SQL문 실행
			rs = pstmt.executeQuery();
			if(rs.next()) {
				member = new MemberVO();
				member.setMem_num(rs.getInt("mem_num"));
				member.setMem_id(rs.getString("mem_id"));
				member.setMem_auth(rs.getInt("mem_auth"));
				member.setMem_pw(rs.getString("mem_pw"));
				member.setMem_email(rs.getString("mem_email"));//회원탈퇴시 활용
				
			}
		}catch(Exception e) {
			throw new Exception(e);
		}finally {
			DBUtil.executeClose(rs, pstmt, conn);
		}
		return member;
	}
	//회원 상세 정보
	public MemberVO getMember(int mem_num)throws Exception{
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		MemberVO member = null;
		String sql = null;
		
		try {
			//커넥션풀로부터 커넥션을 할당
			conn = DBUtil.getConnection();
			//SQL문 작성
			sql = "SELECT * FROM member JOIN member_detail USING(mem_num) "
					+ "LEFT OUTER JOIN pet_detail USING(mem_num) WHERE mem_num=?";
			
			//PreparedStatement 객체 생성
			pstmt = conn.prepareStatement(sql);
			
			//?에 데이터 바인딩
			pstmt.setInt(1, mem_num);
			
			//SQL문 실행 
			rs = pstmt.executeQuery();
			if(rs.next()) {
				member = new MemberVO();
				member.setMem_num(rs.getInt("mem_num"));
				member.setMem_id(rs.getString("mem_id"));
				member.setMem_auth(rs.getInt("mem_auth"));
				member.setMem_pw(rs.getString("mem_pw"));
				member.setMem_name(rs.getString("mem_name"));
				member.setMem_nickname(rs.getString("mem_nickname"));
				member.setMem_cell(rs.getString("mem_cell"));
				member.setMem_email(rs.getString("mem_email"));
				member.setMem_zipcode(rs.getString("mem_zipcode"));
				member.setMem_address1(rs.getString("mem_address1"));
				member.setMem_address2(rs.getString("mem_address2"));
				member.setMem_rdate(rs.getDate("mem_rdate"));//가입일
				member.setMem_mdate(rs.getDate("mem_mdate"));//수정일
				
				//펫 상세정보
				member.setPet_num(rs.getInt("pet_num"));
				member.setPet_name(rs.getString("pet_name"));
				member.setPet_age(rs.getInt("pet_age"));
				member.setPet_photo(rs.getString("pet_photo"));
			}
		}catch(Exception e) {
			throw new Exception(e);
		}finally {
			//DBUtil.executeClose(null, pstmt4, null);
			DBUtil.executeClose(rs, pstmt, conn);
		}
		return member;
	}

	
	
	//회원 정보 수정
	public void updateMember(MemberVO member)throws Exception{
		Connection conn = null;
		PreparedStatement pstmt = null;
		String sql = null;
		
		try {
			//커넥션풀로부터 커넥션 할당
			conn = DBUtil.getConnection();
			//SQL문 작성
			sql = "UPDATE member_detail SET mem_name=?,mem_nickname=?,mem_cell=?,mem_email=?,"
				+ "mem_zipcode=?,mem_address1=?,mem_address2=?,"
				+ "mem_mdate=SYSDATE WHERE mem_num=?";
			//PreparedStatement 객체 생성
			pstmt = conn.prepareStatement(sql);
			//?에 데이터 바인딩
			pstmt.setString(1, member.getMem_name());
			pstmt.setString(2, member.getMem_nickname());
			pstmt.setString(3, member.getMem_cell());
			pstmt.setString(4, member.getMem_email());
			pstmt.setString(5, member.getMem_zipcode());
			pstmt.setString(6, member.getMem_address1());
			pstmt.setString(7, member.getMem_address2());
			pstmt.setInt(8, member.getMem_num());
			//SQL문 실행
			pstmt.executeUpdate();
		}catch(Exception e) {
			throw new Exception(e);
		}finally {
			DBUtil.executeClose(null, pstmt, conn);
		}		
	}

	//펫 프로필 사진 수정
	public void updatePetPhoto(String pet_photo,int mem_num)
	                                    throws Exception{
		Connection conn = null;
		PreparedStatement pstmt = null;
		String sql = null;
		
		try {
			//커넥션풀로부터 커넥션을 할당
			conn = DBUtil.getConnection();
			//SQL문 작성
			sql = "UPDATE pet_detail SET pet_photo=? WHERE mem_num=?";
			//PreparedStatement 객체 생성
			pstmt = conn.prepareStatement(sql);
			//?에 데이터 바인당
			pstmt.setString(1, pet_photo);
			pstmt.setInt(2, mem_num);
			//SQL문 실행
			pstmt.executeUpdate();
		}catch(Exception e) {
			throw new Exception(e);
		}finally {
			DBUtil.executeClose(null, pstmt, conn);
		}
	}
	//비밀번호 수정
	public void updatePassword(String mem_pw,int mem_num)
	                                          throws Exception{
		Connection conn = null;
		PreparedStatement pstmt = null;
		String sql = null;
		
		try {
			//커넥션풀로부터 커넥션을 할당
			conn = DBUtil.getConnection();
			//SQL문 작성
			sql="UPDATE member_detail SET mem_pw=? WHERE mem_num=?";
			//PreparedStatement 객체 생성
			pstmt = conn.prepareStatement(sql);
			//?에 데이터를 바인딩
			pstmt.setString(1, mem_pw);
			pstmt.setInt(2, mem_num);
			//SQL문 실행
			pstmt.executeUpdate();			
		}catch(Exception e) {
			throw new Exception(e);
		}finally {
			DBUtil.executeClose(null, pstmt, conn);
		}
	}
	
	
	//회원탈퇴(회원 정보 삭제)
	public void deleteMember(int mem_num)throws Exception{
		Connection conn = null;
		PreparedStatement pstmt = null;
		PreparedStatement pstmt2 = null;
		String sql = null;
		
		try {
			//커넥션풀로부터 커넥션 할당
			conn = DBUtil.getConnection();
			//auto commit 해제
			conn.setAutoCommit(false);
			
			//member의 auth값 변경
			sql = "UPDATE member SET mem_auth=0 WHERE mem_num=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, mem_num);
			pstmt.executeUpdate();
			
			//member_detail의 레코드 삭제
			sql = "DELETE FROM member_detail WHERE mem_num=?";
			pstmt2 = conn.prepareStatement(sql);
			pstmt2.setInt(1, mem_num);
			pstmt2.executeUpdate();
			
			//전체 SQL문 실행이 성공하면
			conn.commit();
		}catch(Exception e) {
			//SQL문이 하나라도 실패하면 
			conn.rollback();
			throw new Exception(e);
		}finally {
			DBUtil.executeClose(null, pstmt2, conn);
		}
	}
	
	
	//관리자
	//전체 내용 개수, 검색 내용 개수
	public int getMemberCountByAdmin(String keyfield,
			                         String keyword)
	                                    throws Exception{
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		String sub_sql = "";
		int count = 0;
		
		try {
			//커넥션풀로부터 커넥션 할당
			conn = DBUtil.getConnection();
			if(keyword!=null && !"".equals(keyword)) {
				//검색 처리
				if(keyfield.equals("1")) sub_sql += "WHERE mem_id LIKE ?";
				else if(keyfield.equals("2")) sub_sql += "WHERE mem_name LIKE ?";
				else if(keyfield.equals("3")) sub_sql += "WHERE mem_email LIKE ?";
			}
			
			//SQL문 작성
			sql = "SELECT COUNT(*) FROM member LEFT OUTER JOIN member_detail USING(mem_num) " + sub_sql;
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
	//목록, 검색 목록 
	public List<MemberVO> getListMemberByAdmin(int start,
			              int end, String keyfield, 
			              String keyword)throws Exception{
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		List<MemberVO> list = null;
		String sql = null;
		String sub_sql = "";
		int cnt = 0;
		
		try {
			//커넥션풀로부터 커넥션 할당
			conn = DBUtil.getConnection();
			
			if(keyword!=null && !"".equals(keyword)) {
				//검색 처리
				if(keyfield.equals("1")) sub_sql += "WHERE mem_id LIKE ?";
				else if(keyfield.equals("2")) sub_sql += "WHERE mem_name LIKE ?";
				else if(keyfield.equals("3")) sub_sql += "WHERE mem_email LIKE ?";
			}
			
			//SQL문 작성
			sql = "SELECT * FROM (SELECT a.*, rownum rnum FROM "
				+ "(SELECT * FROM member m LEFT OUTER JOIN "
				+ "member_detail d ON m.mem_num=d.mem_num " + sub_sql
				+ " ORDER BY m.mem_num DESC NULLS LAST)a) "
				+ "WHERE rnum>=? AND rnum<=?";
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
			
			list = new ArrayList<MemberVO>();
			while(rs.next()) {
				MemberVO member = new MemberVO();
				member.setMem_num(rs.getInt("mem_num"));
				member.setMem_name(rs.getString("mem_name"));
				member.setMem_nickname(rs.getString("mem_nickname"));
				member.setMem_id(rs.getString("mem_id"));
				member.setMem_auth(rs.getInt("mem_auth"));
				member.setMem_pw(rs.getString("mem_pw"));
				member.setMem_cell(rs.getString("mem_cell"));
				member.setMem_email(rs.getString("mem_email"));
				member.setMem_zipcode(rs.getString("mem_zipcode"));
				member.setMem_address1(rs.getString("mem_address1"));
				member.setMem_address2(rs.getString("mem_address2"));
				member.setMem_rdate(rs.getDate("mem_rdate"));
				member.setMem_mdate(rs.getDate("mem_mdate"));
				
				list.add(member);
			}
			
		}catch(Exception e) {
			throw new Exception(e);
		}finally {
			DBUtil.executeClose(rs, pstmt, conn);
		}		
		return list;
	}
	//회원 등급 수정
	public void updateMemberByAdmin(int mem_auth, int mem_num)
	                                          throws Exception{
		Connection conn = null;
		PreparedStatement pstmt = null;
		String sql = null;
		
		try {
			//커넥션풀로부터 커넥션 할당
			conn = DBUtil.getConnection();
			//SQL문 작성
			sql = "UPDATE member SET mem_auth=? WHERE mem_num=?";
			//PreparedStatement 객체 생성
			pstmt = conn.prepareStatement(sql);
			//?에 데이터 바인딩
			pstmt.setInt(1, mem_auth);
			pstmt.setInt(2, mem_num);
			//SQL문 실행
			pstmt.executeUpdate();
		}catch(Exception e) {
			throw new Exception(e);
		}finally {
			DBUtil.executeClose(null, pstmt, conn);
		}
	}
	
	
	
}
	