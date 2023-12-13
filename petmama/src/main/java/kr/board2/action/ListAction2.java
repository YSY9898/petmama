package kr.board2.action;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.board.dao.BoardDAO;
import kr.board2.dao.BoardDAO2;
import kr.board2.vo.BoardVO2;
import kr.controller.Action;
import kr.util.PageUtil;

public class ListAction2 implements Action{

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String pageNum = request.getParameter("pageNum");
		if(pageNum == null) pageNum = "1";
		
		String keyfield = request.getParameter("keyfield");
		String keyword = request.getParameter("keyword");
		
		BoardDAO2 dao = BoardDAO2.getInstance();
		int count = dao.getBoardCount(keyfield, keyword);
		
		PageUtil page = new PageUtil(keyfield,keyword,Integer.parseInt(pageNum),count,20,10,"list2.do");
		
		List<BoardVO2> list = null;
		if(count > 0) {
			list = dao.getListBoard(page.getStartRow(), page.getEndRow(), keyfield, keyword);
		}
		
		request.setAttribute("count", count);
		request.setAttribute("list", list);
		request.setAttribute("page", page.getPage());
	//JSP 경로 반환
	return "/WEB-INF/views/board2/list2.jsp";
	
	}
}