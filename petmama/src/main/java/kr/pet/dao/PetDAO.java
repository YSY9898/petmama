package kr.pet.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import kr.pet.vo.PetVO;
import kr.util.DBUtil;

public class PetDAO {
	//싱글턴 패턴
	private static PetDAO instance = new PetDAO();
	public static PetDAO getInstance() {
		return instance;
	}
	
	private PetDAO() {}
	
	//회원 애완동물 확인
		public List<PetVO> checkPet(int mem_num) throws Exception{
			Connection conn = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			List<PetVO> list = null;
			String sql = null;
			
			try {
				//커넥션풀로부터 커넥션 할당
				conn = DBUtil.getConnection();
				//SQL문 작성
				sql = "SELECT * FROM pet_detail WHERE mem_num=?";
				//PreparedStatement 객체 생성
				pstmt = conn.prepareStatement(sql);
				//?에 데이터 바인딩
				pstmt.setInt(1, mem_num);
				//SQL문 실행
				rs = pstmt.executeQuery();
				list = new ArrayList<PetVO>();
				while(rs.next()) {
					PetVO vo = new PetVO();
					//펫 번호
					vo.setPet_num(rs.getInt("pet_num"));
					//펫 이름
					vo.setPet_name(rs.getString("pet_name"));
					//펫 나이
					vo.setPet_age(rs.getInt("pet_age"));
					//펫 사진
					vo.setPet_photo(rs.getString("pet_photo"));
					//펫 사진
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