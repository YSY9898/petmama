package kr.board.action;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.codehaus.jackson.map.ObjectMapper;

import kr.board.dao.BoardDAO;
import kr.board.vo.BoardScrapVO;
import kr.controller.Action;

public class GetScrapAction implements Action{

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		request.setCharacterEncoding("utf-8");
		
		int board_num = Integer.parseInt(request.getParameter("board_num"));
		
		Map<String,Object> mapAjax = new HashMap<String,Object>();
		
		HttpSession session = request.getSession();
		Integer user_num = (Integer)session.getAttribute("user_num");
		
		BoardDAO dao = BoardDAO.getInstance();
		if(user_num == null) {
			mapAjax.put("status", "noScrap");
		}else {
			BoardScrapVO boardScrap = dao.selectScrap(new BoardScrapVO(board_num,user_num));
			
			if(boardScrap!=null) {//좋아요 표시
				mapAjax.put("status", "yesScrap");
			}else {//좋아요 미표시
				mapAjax.put("status", "noScrap");
			}
		}
		//JSON 문자열 생성
		ObjectMapper mapper = new ObjectMapper();
		String ajaxData = mapper.writeValueAsString(mapAjax);
		
		request.setAttribute("ajaxData", ajaxData);
		return "/WEB-INF/views/common/ajax_view.jsp";
	}

}
