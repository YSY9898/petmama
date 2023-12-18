package kr.board2.action;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.codehaus.jackson.map.ObjectMapper;

import kr.board2.dao.BoardDAO2;
import kr.board2.vo.BoardFavVO2;
import kr.controller.Action;

public class GetFavAction2 implements Action{

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		request.setCharacterEncoding("utf-8");
		
		int board_num = Integer.parseInt(request.getParameter("board_num"));
		
		Map<String,Object> mapAjax = new HashMap<String,Object>();
		
		HttpSession session = request.getSession();
		Integer user_num = (Integer)session.getAttribute("user_num");
		
		BoardDAO2 dao = BoardDAO2.getInstance();
		if(user_num == null) {
			mapAjax.put("status", "noFav");
		}else {
			BoardFavVO2 boardFav =
					dao.selectFav(new BoardFavVO2(board_num,user_num));
			
			if(boardFav!=null) {
				mapAjax.put("status","yesFav");
			}else {
				mapAjax.put("status", "noFav");
			}
		}
		mapAjax.put("count", dao.selectFavCount(board_num));
		
		ObjectMapper mapper = new ObjectMapper();
		String ajaxData = mapper.writeValueAsString(mapAjax);
		
		request.setAttribute("ajaxData", ajaxData);
		
		return "/WEB-INF/views/common/ajax_view.jsp";
	}

}
