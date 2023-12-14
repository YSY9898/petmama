package kr.board2.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.board2.dao.BoardDAO2;
import kr.board2.vo.BoardVO2;
import kr.controller.Action;
import kr.util.StringUtil;

public class DetailAction2 implements Action{

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {

		int board_num = Integer.parseInt(request.getParameter("board_num"));
		
		BoardDAO2 dao = BoardDAO2.getInstance();
		
		dao.updateReadCount(board_num);
		
		BoardVO2 board = dao.getBoard(board_num);
		
		board.setTitle(StringUtil.useNoHtml(board.getTitle()));
		board.setContent(StringUtil.useBrNoHtml(board.getContent()));
		
		request.setAttribute("board", board);
		
		return "/WEB-INF/views/board2/detail2.jsp";
	}

}
