package kr.board2.action;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.codehaus.jackson.map.ObjectMapper;

import kr.board2.dao.BoardDAO2;
import kr.board2.vo.BoardScrapVO2;
import kr.controller.Action;

public class GetScrapAction2 implements Action{

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {

		request.setCharacterEncoding("utf-8");
		
		int board_num = Integer.parseInt(request.getParameter("board_num"));
		
		Map<String,Object> mapAjax = new HashMap<String,Object>();
		
		HttpSession session = request.getSession();
		Integer user_num = (Integer)session.getAttribute("user_num");
		
		BoardDAO2 dao = BoardDAO2.getInstance();
		if(user_num == null) {
			mapAjax.put("status", "noScrap");
		}else {
			BoardScrapVO2 boardScrap = 
					dao.selectScrap(new BoardScrapVO2(board_num,user_num));
			
			if(boardScrap != null) {
				mapAjax.put("status", "yesScrap");
			}else {
				mapAjax.put("status", "noScrap");
			}
		}
		mapAjax.put("count", dao.selectScrapCount(board_num));
		
		ObjectMapper mapper = new ObjectMapper();
		String ajaxData = mapper.writeValueAsString(mapAjax);
		
		request.setAttribute("ajaxData", ajaxData);
		
		return "/WEB-INF/views/common/ajax_view.jsp";
	}

}
