package kr.board2.action;

import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.codehaus.jackson.map.ObjectMapper;

import kr.board2.dao.BoardDAO2;
import kr.board2.vo.BoardReplyVO2;
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
		
		BoardDAO2 dao = BoardDAO2.getInstance();
		int count = dao.getReplyBoardCount(board_num);
		
		PageUtil page = new PageUtil(Integer.parseInt(pageNum),count,Integer.parseInt(rowCount));
		
		List<BoardReplyVO2> list = null;
		if(count > 0) {
			list = dao.getListReplyBoard(page.getStartRow(), page.getEndRow(), board_num);
		}else {
			list = Collections.emptyList();
		}
		
		HttpSession session = request.getSession();
		Integer user_num = (Integer)session.getAttribute("user_num");
		
		Map<String,Object> mapAjax = new HashMap<String,Object>();
		mapAjax.put("count", count);
		mapAjax.put("list", list);
		mapAjax.put("user_num", user_num);
		
		ObjectMapper mapper = new ObjectMapper();
		String ajaxData = mapper.writeValueAsString(mapAjax);
		
		request.setAttribute("ajaxData", ajaxData);
		
		return "/WEB-INF/views/common/ajax_view.jsp";
	}

}
