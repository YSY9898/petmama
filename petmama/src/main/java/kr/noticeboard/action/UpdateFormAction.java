package kr.noticeboard.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.board.dao.BoardDAO;
import kr.board.vo.BoardVO;
import kr.controller.Action;
import kr.noticeboard.dao.NoticeBoardDAO;
import kr.noticeboard.vo.NoticeBoardVO;
import kr.util.StringUtil;

public class UpdateFormAction implements Action{

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
		
		//로그인한 회원번호와 작성자 회원번호 일치 여부 체크
		int notice_num = Integer.parseInt(request.getParameter("notice_num"));
		NoticeBoardDAO dao = NoticeBoardDAO.getInstance();
		NoticeBoardVO db_board = dao.getNoticeBoard(notice_num);
		
		if(user_num != db_board.getMem_num()) {
			return "/WEB-INF/views/common/notice.jsp";
		}
		
		db_board.setNotice_title(StringUtil.parseQuot(db_board.getNotice_title()));
		request.setAttribute("board", db_board);
		
		
		return "/WEB-INF/views/noticeboard/updateForm.jsp";
	}

}
