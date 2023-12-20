package kr.reservation.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;

import kr.reservation.vo.ReservationVO;
import kr.util.DBUtil;

public class ReservationDAO {
	//싱글턴 패턴
	private static ReservationDAO instance = new ReservationDAO();
	
	public static ReservationDAO getInstance() {
		return instance;
	}
	
	private ReservationDAO() {}
	
	//예약 등록
	public void reserve(ReservationVO reservation)throws Exception{
		Connection conn = null;
		PreparedStatement pstmt = null;
		String sql = null;
		
		try {
			conn = DBUtil.getConnection();
			sql = "INSERT INTO reservation (r_num, mem_num, sis_num, r_condition, "
				+ "visit_status, sis_work, r_pet_note, r_start, r_end, r_reg_date)"
				+ " VALUES(reservation_seq.nextval,?,?,?,?,?,?,?,?,SYSDATE)";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1,reservation.getMem_num());
			pstmt.setInt(2,reservation.getSis_num());
			pstmt.setInt(3,reservation.getR_condition());
			pstmt.setInt(4,reservation.getVisit_status());
			pstmt.setInt(5,reservation.getSis_work());
			pstmt.setString(6, reservation.getR_pet_note());
			pstmt.setString(7,reservation.getR_start());
			pstmt.setString(8,reservation.getR_end());
			
			pstmt.executeUpdate();
			
		}catch(Exception e) {
			throw new Exception(e);
		}finally {
			DBUtil.executeClose(null, pstmt, conn);
		}
	}
}
