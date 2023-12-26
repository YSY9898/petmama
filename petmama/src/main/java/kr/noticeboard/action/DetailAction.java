package kr.noticeboard.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.board.dao.BoardDAO;
import kr.board.vo.BoardVO;
import kr.controller.Action;
import kr.noticeboard.dao.NoticeBoardDAO;
import kr.noticeboard.vo.NoticeBoardVO;
import kr.util.StringUtil;

public class DetailAction implements Action{

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		//글번호 반환
		int notice_num = Integer.parseInt(request.getParameter("notice_num"));
		
		NoticeBoardDAO dao = NoticeBoardDAO.getInstance();
		
		//조회수 증가
		dao.upNoticeBoardcount(notice_num);
		
		NoticeBoardVO board = dao.getNoticeBoard(notice_num);
		
		//HTML을 허용하지 않음
		board.setNotice_title(StringUtil.useNoHtml(board.getNotice_title()));
		//HTML을 허용하지 않으면서 줄바꿈 처리
		board.setNotice_content(StringUtil.useBrNoHtml(board.getNotice_content()));
		
		request.setAttribute("board", board);
		
		return "/WEB-INF/views/noticeboard/detail.jsp";
	}

}
