package kr.board.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.board.dao.BoardDAO;
import kr.board.vo.BoardVO;
import kr.controller.Action;
import kr.util.FileUtil;

public class DeleteAction implements Action{

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		HttpSession session = request.getSession();
		Integer user_num = (Integer)session.getAttribute("user_num");
		Integer user_auth = (Integer)session.getAttribute("user_auth");
		
		if(user_num == null) {
			return "redirect:/member/loginForm.do";
		}
		
		int board_num = Integer.parseInt(request.getParameter("board_num"));
		
		BoardDAO dao = BoardDAO.getInstance();
		BoardVO db_board = dao.getBoard(board_num);
		
		if(user_num != db_board.getMem_num() && user_auth != 9) {
			return "/WEB-INF/views/common/notice.jsp";
		}
		
		dao.deleteBoard(board_num);
		
		FileUtil.removeFile(request, db_board.getFilename());
		
		request.setAttribute("notice_msg", "게시글을 삭제하였습니다.");
		request.setAttribute("notice_url", request.getContextPath()+"/board/list.do");
		
		return "/WEB-INF/views/common/alert_singleView.jsp";
	}

}
