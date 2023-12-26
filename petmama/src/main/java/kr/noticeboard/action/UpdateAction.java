package kr.noticeboard.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.oreilly.servlet.MultipartRequest;

import kr.board.dao.BoardDAO;
import kr.board.vo.BoardVO;
import kr.controller.Action;
import kr.noticeboard.dao.NoticeBoardDAO;
import kr.noticeboard.vo.NoticeBoardVO;
import kr.util.FileUtil;

public class UpdateAction implements Action{

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		HttpSession session = request.getSession();
		Integer user_num = (Integer)session.getAttribute("user_num");
		Integer user_auth = (Integer)session.getAttribute("user_auth");
		
		if(user_num == null) {
			return "redirect:/member/loginForm.do";
		}
		if(user_auth != 9) {//관리자로 로그인하지 않은 경우
			return "/WEB-INF/views/common/notice.jsp";
		}
		
		MultipartRequest multi = FileUtil.createFile(request);
		int notice_num = Integer.parseInt(multi.getParameter("notice_num"));
		String filename = multi.getFilesystemName("notice_filename");
		
		NoticeBoardDAO dao = NoticeBoardDAO.getInstance();
		
		//수정 전 데이터 반환
		NoticeBoardVO db_board = dao.getNoticeBoard(notice_num);
		
		if(user_num != db_board.getMem_num()) {
			//로그인한 회원번호와 작성자 회원번호가 불일치
			FileUtil.removeFile(request, filename);
			return "/WEB-INF/views/common/notice.jsp";
		}
		
		//로그인한 회원번호와 작성자 회원번호가 일치
		NoticeBoardVO board = new NoticeBoardVO();
		board.setNotice_num(notice_num);
		board.setNotice_title(multi.getParameter("notice_title"));
		board.setNotice_content(multi.getParameter("notice_content"));
		board.setNotice_ip(request.getRemoteAddr());
		board.setNotice_status(Integer.parseInt(multi.getParameter("notice_status")));
		board.setNotice_filename(filename);
		
		dao.updateNoticeBoard(board);
		
		if(filename!=null) {//새 파일로 교체할 때 원래 파일 제거
			FileUtil.removeFile(request, db_board.getNotice_filename());
		}
		
		return "redirect:/noticeboard/noticedetail.do?notice_num=" + notice_num;
	}

}
