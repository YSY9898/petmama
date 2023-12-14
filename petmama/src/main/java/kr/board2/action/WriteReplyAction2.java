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

public class WriteReplyAction2 implements Action{

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		Map<String,String> mapAjax = new HashMap<String,String>();
		
		HttpSession session = request.getSession();
		Integer user_num = (Integer)session.getAttribute("user_num");
		if(user_num == null) {
			mapAjax.put("result", "logout");
		}else {
			request.setCharacterEncoding("utf-8");
			
			BoardReplyVO2 reply = new BoardReplyVO2();
			reply.setMem_num(user_num);
			reply.setRe_content(request.getParameter("re_content"));
			reply.setRe_ip(request.getRemoteAddr());
			reply.setBoard_num(Integer.parseInt(
					request.getParameter("board_num")));
			
			BoardDAO2 dao = BoardDAO2.getInstance();
			dao.insertReplyBoard(reply);
			
			mapAjax.put("result", "success");
		}
		
		ObjectMapper mapper = new ObjectMapper();
		String ajaxData = mapper.writeValueAsString(mapAjax);
		
		request.setAttribute("ajaxData", ajaxData);
		
		return "/WEB-INF/view/common/ajax_view.jsp";
	}

}
