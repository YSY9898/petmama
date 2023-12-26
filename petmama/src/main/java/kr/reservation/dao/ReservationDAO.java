package kr.reservation.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import kr.qna.vo.QnaVO;
import kr.reservation.vo.ReservationVO;
import kr.util.DBUtil;
import kr.util.StringUtil;

public class ReservationDAO {
	// 싱글턴 패턴
	private static ReservationDAO instance = new ReservationDAO();

	public static ReservationDAO getInstance() {
		return instance;
	}

	private ReservationDAO() {
	}

	// 예약 등록
	public void reserve(ReservationVO reservation) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		String sql = null;

		try {
			conn = DBUtil.getConnection();
			sql = "INSERT INTO reservation (r_num, mem_num, sis_num, r_condition, "
					+ "visit_status, sis_work, r_pet_note, fee, r_start, r_end, r_reg_date)"
					+ " VALUES(reservation_seq.nextval,?,?,?,?,?,?,?,?,?,SYSDATE)";

			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, reservation.getMem_num());
			pstmt.setInt(2, reservation.getSis_num());
			pstmt.setInt(3, reservation.getR_condition());
			pstmt.setInt(4, reservation.getVisit_status());
			pstmt.setInt(5, reservation.getSis_work());
			pstmt.setString(6, reservation.getR_pet_note());
			pstmt.setInt(7, reservation.getFee());
			pstmt.setString(8, reservation.getR_start());
			pstmt.setString(9, reservation.getR_end());

			pstmt.executeUpdate();

		} catch (Exception e) {
			throw new Exception(e);
		} finally {
			DBUtil.executeClose(null, pstmt, conn);
		}
	}

	// 전체 레코드 수/검색 레코드 수
	public int getReservCount(int mem_num, int mem_auth, String keyfield, String keyword) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		String sub_sql = "";
		int count = 0;
		System.out.println(mem_auth);

		try {
			// 커넥션풀로부터 커넥션 할당
			conn = DBUtil.getConnection();

			if (keyfield.equals("ing")) {
				sub_sql += "AND r_start >= TO_CHAR(SYSDATE, 'YYYY-MM-DD HH24:MI:SS') AND r_end >= TO_CHAR(SYSDATE, 'YYYY-MM-DD HH24:MI:SS') AND r_condition IN(0,1)";
			} else if (keyfield.equals("after")) {
				sub_sql += "AND (r_start <= TO_CHAR(SYSDATE, 'YYYY-MM-DD HH24:MI:SS') AND r_end <= TO_CHAR(SYSDATE, 'YYYY-MM-DD HH24:MI:SS')) OR r_condition IN(2,3)";
			}
			// SQL문 작성
			if(mem_auth == 3) {
				sql = "SELECT COUNT(*) FROM reservation JOIN member USING(mem_num) WHERE sis_num = (select sis_num from petsitter where mem_num = " + mem_num + ")";
			} else {
				sql = "SELECT COUNT(*) FROM reservation JOIN member USING(mem_num) WHERE mem_num = " + mem_num + " " + sub_sql;				
			}
			// PreparedStatement 객체 생성
			pstmt = conn.prepareStatement(sql);
			// SQL문 실행
			rs = pstmt.executeQuery();
			if (rs.next()) {
				count = rs.getInt(1);
			}

		} catch (Exception e) {
			throw new Exception(e);
		} finally {
			DBUtil.executeClose(rs, pstmt, conn);
		}
		return count;
	}

	public List<ReservationVO> getReservList(int mem_num, int mem_auth, int start, int end, String keyfield, String keyword) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		List<ReservationVO> list = null;
		String sql = null;
		String sub_sql = "";
		int cnt = 0;
		
		System.out.println("mem_auth ::: " + mem_auth);

		try {
			// 커넥션풀로부터 커넥션 할당
			conn = DBUtil.getConnection();

			if (keyfield.equals("ing")) {
				System.out.println("inging");
				sub_sql += " r_start >= TO_CHAR(SYSDATE, 'YYYY-MM-DD HH24:MI:SS') AND r_end >= TO_CHAR(SYSDATE, 'YYYY-MM-DD HH24:MI:SS') AND r_condition IN(0,1)";
			} else if (keyfield.equals("after")) {
				sub_sql += " (r_start <= TO_CHAR(SYSDATE, 'YYYY-MM-DD HH24:MI:SS') AND r_end <= TO_CHAR(SYSDATE, 'YYYY-MM-DD HH24:MI:SS')) OR r_condition IN(2,3)";
			}
			// SQL문 작성
			if(mem_auth == 3) {
				sql = "SELECT * FROM (SELECT a.*, rownum rnum FROM (SELECT * FROM reservation JOIN member USING(mem_num) WHERE sis_num = (select sis_num from petsitter where mem_num = " + mem_num + ") AND " + sub_sql
						+ " ORDER BY r_num DESC)a) WHERE rnum >= ? AND rnum <= ? AND sis_num = (select sis_num from petsitter where mem_num = " + mem_num + ") AND " + sub_sql;
			} else {
				sql = "SELECT * FROM (SELECT a.*, rownum rnum FROM (SELECT * FROM reservation JOIN member USING(mem_num) WHERE mem_num =" + mem_num + " AND " + sub_sql
						+ " ORDER BY r_num DESC)a) WHERE rnum >= ? AND rnum <= ? AND mem_num = " + mem_num + " AND " + sub_sql;
			}
			System.out.println(sql);
			// PreparedStatement 객체 생성
			pstmt = conn.prepareStatement(sql);

			pstmt.setInt(++cnt, start);
			pstmt.setInt(++cnt, end);

			// SQL문 실행
			rs = pstmt.executeQuery();
			list = new ArrayList<ReservationVO>();
			while (rs.next()) {
				ReservationVO reservation = new ReservationVO();
				reservation.setR_num(rs.getInt("r_num"));
				reservation.setMem_num(rs.getInt("mem_num"));
				reservation.setSis_num(rs.getInt("sis_num"));
				reservation.setR_reg_date(rs.getDate("r_reg_date"));
				reservation.setR_modify_date(rs.getDate("r_modify_date"));
				reservation.setR_condition(rs.getInt("r_condition"));
				reservation.setVisit_status(rs.getInt("visit_status"));
				reservation.setSis_work(rs.getInt("sis_work"));
				reservation.setR_pet_note(rs.getString("r_pet_note"));
				reservation.setFee(rs.getInt("fee"));
				reservation.setR_start(rs.getString("r_start"));
				reservation.setR_end(rs.getString("r_end"));
				list.add(reservation);
			}
		} catch (Exception e) {
			throw new Exception(e);
		} finally {
			DBUtil.executeClose(rs, pstmt, conn);
		}
		return list;
	}
	
	public List<ReservationVO> getReservDetail(int mem_num, int mem_auth, int r_num) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		List<ReservationVO> list = null;
		String sql = null;
		String sub_sql = "";
		int cnt = 0;

		try {
			// 커넥션풀로부터 커넥션 할당
			conn = DBUtil.getConnection();

			// SQL문 작성
			if(mem_auth == 3) {				
				sql = "SELECT * FROM reservation WHERE r_num= " + r_num;
			} else {
				sql = "SELECT * FROM reservation WHERE mem_num = " + mem_num + " AND r_num= " + r_num;
			}
			// PreparedStatement 객체 생성
			pstmt = conn.prepareStatement(sql);
			// SQL문 실행
			rs = pstmt.executeQuery();
			list = new ArrayList<ReservationVO>();
			while (rs.next()) {
				ReservationVO reservation = new ReservationVO();
				reservation.setR_num(rs.getInt("r_num"));
				reservation.setMem_num(rs.getInt("mem_num"));
				reservation.setSis_num(rs.getInt("sis_num"));
				reservation.setR_reg_date(rs.getDate("r_reg_date"));
				reservation.setR_modify_date(rs.getDate("r_modify_date"));
				reservation.setR_condition(rs.getInt("r_condition"));
				reservation.setVisit_status(rs.getInt("visit_status"));
				reservation.setSis_work(rs.getInt("sis_work"));
				reservation.setR_pet_note(rs.getString("r_pet_note"));
				reservation.setFee(rs.getInt("fee"));
				reservation.setR_start(rs.getString("r_start"));
				reservation.setR_end(rs.getString("r_end"));
				list.add(reservation);
			}

		} catch (Exception e) {
			throw new Exception(e);
		} finally {
			DBUtil.executeClose(rs, pstmt, conn);
		}
		return list;
	}
}