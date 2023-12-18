package kr.board2.action;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.codehaus.jackson.map.ObjectMapper;

import kr.board2.dao.BoardDAO2;
import kr.board2.vo.BoardReplyVO2;
import kr.controller.Action;

public class DeleteReplyAction2 implements Action{

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		request.setCharacterEncoding("utf-8");
		int re_num = Integer.parseInt(request.getParameter("re_num"));
		
		Map<String,String> mapAjax = new HashMap<String,String>();
		
		BoardDAO2 dao = BoardDAO2.getInstance();
		BoardReplyVO2 db_reply = dao.getReplyBoard(re_num);
		
		HttpSession session = request.getSession();
		Integer user_num = (Integer)session.getAttribute("user_num");
		
		if(user_num == null) {
			mapAjax.put("result", "logout");
		}else if(user_num != null && user_num == db_reply.getMem_num()) {
			
			dao.deleteReplyBoard(re_num);
			
			mapAjax.put("result", "success");
		}else {
			mapAjax.put("result", "wrongAccess");
		}
	
		ObjectMapper mapper = new ObjectMapper();
		String ajaxData = mapper.writeValueAsString(mapAjax);
		
		request.setAttribute("ajaxData", ajaxData);
		
		return "/WEB-INF/views/common/ajax_view.jsp";
	}

}
