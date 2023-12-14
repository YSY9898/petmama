package kr.board2.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.board.dao.BoardDAO;
import kr.controller.Action;
import kr.util.PageUtil;

public class ListReplyAction2 implements Action{

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {

		request.setCharacterEncoding("utf-8");
		
		String pageNum = request.getParameter("pageNum");
		if(pageNum == null) {
			pageNum = "1";
		}
		
		String rowCount = request.getParameter("rowCount");
		if(rowCount == null) {
			rowCount = "10";
		}
		
		int board_num = Integer.parseInt(
				request.getParameter("board_num"));
		
		BoardDAO dao = BoardDAO.getInstance();
		//int count = dao.getReplyBoardCount(board_num);
		
		//PageUtil page = new PageUtil(Integer.parseInt(pageNum),count,Integer.parseInt(rowCount));
		
		
		return null;
	}

}
