package kr.qna.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import kr.qna.vo.QnaReplyVO;
import kr.qna.vo.QnaVO;
import kr.util.DBUtil;
import kr.util.StringUtil;

public class QnaDAO {
	// 싱글턴 패턴
	private static QnaDAO instance = new QnaDAO();

	public static QnaDAO getInstance() {
		return instance;
	}

	private QnaDAO() {
	}

	// 글 등록
	public boolean insertQna(QnaVO qna) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		String sql = null;

		try {
			conn = DBUtil.getConnection();
			sql = "INSERT INTO qna (" + "q_num," + "mem_num," + "mem_id," + "sis_num," + "passwd," + "title,"
					+ "content,"
//					+ "filename,"
					+ "reg_date,"
//					+ "modify_date,"
//					+ "answer_yn,"
					+ "hide_yn) VALUES (qna_seq.nextval,?,?,?,?,?,?,SYSDATE,?)";
			System.out.println(sql);
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, qna.getMem_num());
			pstmt.setString(2, qna.getMem_id());
			pstmt.setInt(3, qna.getSis_num());
			pstmt.setInt(4, qna.getPasswd());
			pstmt.setString(5, qna.getTitle());
			pstmt.setString(6, qna.getContent());
			pstmt.setString(7, qna.getHide_yn());

			pstmt.executeUpdate();

		} catch (Exception e) {
			throw new Exception(e);
		} finally {
			DBUtil.executeClose(null, pstmt, conn);
		}
		return true;
	}

	// 전체 레코드 수/검색 레코드 수
	public int getQnaCount(String keyfield, String keyword) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		String sub_sql = "";
		int count = 0;

		System.out.println("keyfield : " + keyfield);
		System.out.println("keyword : " + keyword);

		try {
			// 커넥션풀로부터 커넥션 할당
			conn = DBUtil.getConnection();

			if (keyword != null && !"".equals(keyword)) {
				// 검색 처리
				if (keyfield.equals("1"))
					sub_sql += "WHERE title LIKE ?";
				else if (keyfield.equals("2"))
					sub_sql += "WHERE content LIKE ?";
				else if (keyfield.equals("3"))
					sub_sql += "WHERE qna.mem_id = ?";
			}
			// SQL문 작성
			sql = "SELECT COUNT(*) FROM qna JOIN member USING(mem_num) " + sub_sql;
			System.out.println(sql);
			// PreparedStatement 객체 생성
			pstmt = conn.prepareStatement(sql);
			if (keyword != null && !"".equals(keyword)) { // 객체가 생성되었는데 비어있을 수도 있어서 조건 검사
				if (keyfield.equals("3")) {
					pstmt.setString(1, keyword);
				} else {
					pstmt.setString(1, "%" + keyword + "%");
				}
			}
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

	// 전체 글/검색 글 목록
	public List<QnaVO> getListQna(int start, int end, String keyfield, String keyword) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		List<QnaVO> list = null;
		String sql = null;
		String sub_sql = "";
		int cnt = 0;

		try {
			// 커넥션풀로부터 커넥션 할당
			conn = DBUtil.getConnection();

			if (keyword != null && !"".equals(keyword)) {
				// 검색 처리
				if (keyfield.equals("1"))
					sub_sql += "WHERE title LIKE ?";
				else if (keyfield.equals("2"))
					sub_sql += "WHERE content LIKE ?";
				else if (keyfield.equals("3"))
					sub_sql += "WHERE qna.mem_id = ?";
			}
			// SQL문 작성
			sql = "SELECT * FROM (SELECT a.*, rownum rnum FROM (SELECT * FROM qna JOIN member USING(mem_num) " + sub_sql
					+ " ORDER BY q_num DESC)a) WHERE rnum >= ? AND rnum <= ?";
			// PreparedStatement 객체 생성
			pstmt = conn.prepareStatement(sql);
			if (keyword != null && !"".equals(keyword)) { // 객체가 생성되었는데 비어있을 수도 있어서 조건 검사
				if (keyfield.equals("3")) {
					pstmt.setString(++cnt, keyword);
				} else {
					pstmt.setString(++cnt, "%" + keyword + "%");
				}
			}

			pstmt.setInt(++cnt, start);
			pstmt.setInt(++cnt, end);

			// SQL문 실행
			rs = pstmt.executeQuery();
			list = new ArrayList<QnaVO>();
			while (rs.next()) {
				QnaVO qna = new QnaVO();
				qna.setQ_num(rs.getInt("q_num"));
				qna.setHide_yn(rs.getString("hide_yn"));
				qna.setTitle(StringUtil.useNoHtml(rs.getString("title")));
				qna.setAnswer_yn(rs.getString("answer_yn"));
				qna.setMem_id(rs.getString("mem_id"));
				qna.setReg_date(rs.getDate("reg_date"));
				System.out.println("============================");
				System.out.println(rs.getInt("q_num"));
				System.out.println(StringUtil.useNoHtml(rs.getString("title")));
				System.out.println(rs.getString("answer_yn"));
				System.out.println(rs.getString("mem_id"));
				System.out.println(rs.getDate("reg_date"));
				list.add(qna);

			}

		} catch (Exception e) {
			throw new Exception(e);
		} finally {
			DBUtil.executeClose(rs, pstmt, conn);
		}

		return list;
	}

	public QnaVO getQNA(int q_num, String mem_id, int auth) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		QnaVO qna = null;
		String sql = null;

		try {
			// 커넥션풀로부터 커넥션을 할당
			conn = DBUtil.getConnection();
			// SQL문 작성
			// (주의)회원탈퇴하면 zmember_detail의 레코드가 존재하지 않기
			// 때문에 외부 조인을 사용해서 데이터 누락 방지
			if (auth == 9) {
				sql = "SELECT * FROM qna JOIN member USING(mem_num) " + "WHERE q_num=? ";
				// PreparedStatement 객체 생성
				pstmt = conn.prepareStatement(sql);
				// ?에 데이터 바인딩
				pstmt.setInt(1, q_num);
			} else {
				sql = "SELECT * FROM qna JOIN member USING(mem_num) " + "WHERE q_num=? AND member.mem_id=?";
				// PreparedStatement 객체 생성
				pstmt = conn.prepareStatement(sql);
				// ?에 데이터 바인딩
				pstmt.setInt(1, q_num);
				pstmt.setString(2, mem_id);
			}
			// SQL문 실행
			rs = pstmt.executeQuery();
			if (rs.next()) {
				qna = new QnaVO();
				qna.setContent(rs.getString("content"));
				qna.setAnswer_yn(rs.getString("answer_yn"));
				qna.setReg_date(rs.getDate("reg_date"));
				qna.setModify_date(rs.getDate("modify_date"));
				qna.setFilename(rs.getString("filename"));
				qna.setMem_num(rs.getInt("mem_num"));
			}
		} catch (Exception e) {
			throw new Exception(e);
		} finally {
			DBUtil.executeClose(rs, pstmt, conn);
		}
		return qna;
	}

	public QnaReplyVO getQnaReply(int q_num, int auth) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		QnaReplyVO qnaReply = null;
		String sql = null;

		try {
			// 커넥션풀로부터 커넥션을 할당
			conn = DBUtil.getConnection();
			// SQL문 작성
			// (주의)회원탈퇴하면 zmember_detail의 레코드가 존재하지 않기
			// 때문에 외부 조인을 사용해서 데이터 누락 방지
			sql = "SELECT * FROM qna_reply WHERE qna_reply.q_num=? ";
			// PreparedStatement 객체 생성
			pstmt = conn.prepareStatement(sql);
			// ?에 데이터 바인딩
			pstmt.setInt(1, q_num);
			// SQL문 실행
			rs = pstmt.executeQuery();
			if (rs.next()) {
				qnaReply = new QnaReplyVO();
				qnaReply.setQr_content(rs.getString("qr_content"));
				qnaReply.setReg_date(rs.getDate("reg_date"));
			}
		} catch (Exception e) {
			throw new Exception(e);
		} finally {
			DBUtil.executeClose(rs, pstmt, conn);
		}
		return qnaReply;
	}

	public QnaVO checkQNA(int q_num, String mem_id, int auth) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		QnaVO qna = null;
		String sql = null;

		try {
			// 커넥션풀로부터 커넥션 할당
			conn = DBUtil.getConnection();
			// SQL문 작성
			// member와 member_detail 조인시 member의 누락된 데이터가 보여야 id 중복 체크 가능
			if (auth == 9) {
				sql = "SELECT * FROM qna LEFT OUTER JOIN member USING(mem_num) WHERE q_num=? ";
				pstmt = conn.prepareStatement(sql);
				// ?에 데이터 바인딩
				pstmt.setInt(1, q_num);
			} else {
				sql = "SELECT * FROM qna LEFT OUTER JOIN member USING(mem_num) WHERE q_num=? AND member.mem_id=?";
				pstmt = conn.prepareStatement(sql);
				// ?에 데이터 바인딩
				pstmt.setInt(1, q_num);
				pstmt.setString(2, mem_id);
			} // PreparedStatement 객체 생성

			// SQL문 실행
			rs = pstmt.executeQuery();
			if (rs.next()) {
				qna = new QnaVO();
				qna.setMem_num(rs.getInt("mem_num"));
				qna.setMem_id(rs.getString("mem_id"));
				qna.setHide_yn(rs.getString("hide_yn"));
			}
		} catch (Exception e) {
			throw new Exception(e);
		} finally {
			DBUtil.executeClose(rs, pstmt, conn);
		}
		return qna;
	}

	public QnaVO checkQnaPassword(int q_num, String password, String mem_id) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		QnaVO qna = null;
		String sql = null;

		try {
			// 커넥션풀로부터 커넥션 할당
			conn = DBUtil.getConnection();
			// SQL문 작성
			// member와 member_detail 조인시 member의 누락된 데이터가 보여야 id 중복 체크 가능
			sql = "SELECT * FROM qna LEFT OUTER JOIN member USING(mem_num) WHERE q_num=? AND passwd=? AND member.mem_id=?";
			// PreparedStatement 객체 생성
			pstmt = conn.prepareStatement(sql);
			// ?에 데이터 바인딩
			pstmt.setInt(1, q_num);
			pstmt.setString(2, password);
			pstmt.setString(3, mem_id);
			// SQL문 실행
			rs = pstmt.executeQuery();
			if (rs.next()) {
				qna = new QnaVO();
				qna.setMem_num(rs.getInt("mem_num"));
				qna.setMem_id(rs.getString("mem_id"));
				qna.setHide_yn(rs.getString("hide_yn"));
			}
		} catch (Exception e) {
			throw new Exception(e);
		} finally {
			DBUtil.executeClose(rs, pstmt, conn);
		}
		return qna;
	}

	public void updateQnaAnawer(int q_num) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		String sql = null;

		try {
			conn = DBUtil.getConnection();
			sql = "UPDATE qna SET answer_yn = 'Y' WHERE q_num = " + q_num;
			pstmt = conn.prepareStatement(sql);
			pstmt.executeUpdate();
		} catch (Exception e) {
			throw new Exception(e);
		} finally {
			DBUtil.executeClose(null, pstmt, conn);
		}
	}
}