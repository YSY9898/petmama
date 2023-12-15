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

public class WriteScrapAction implements Action{

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		Map<String,Object> mapAjax = new HashMap<String,Object>();
		
		HttpSession session = request.getSession();
		Integer user_num = (Integer)session.getAttribute("user_num");
		if(user_num == null) {
			mapAjax.put("result", "logout");
		}else {
			request.setCharacterEncoding("utf-8");
			int board_num = Integer.parseInt(request.getParameter("board_num"));
			BoardScrapVO scrapVO = new BoardScrapVO();
			scrapVO.setBoard_num(board_num);
			scrapVO.setMem_num(user_num);
			
			BoardDAO dao = BoardDAO.getInstance();
			BoardScrapVO db_scrap = dao.selectScrap(scrapVO);
			
			if(db_scrap != null) {//스크랩 등록 O
				//스크랩 삭제
				dao.deleteScrap(db_scrap);
				mapAjax.put("status", "noScrap");
			}else {//스크랩 등록 X
				dao.insertScrap(scrapVO);
				mapAjax.put("status", "yesScrap");
			}
			mapAjax.put("result", "success");
		}
		
		//JSON 문자열 생성
		ObjectMapper mapper = new ObjectMapper();
		String ajaxData = mapper.writeValueAsString(mapAjax);
		
		request.setAttribute("ajaxData", ajaxData);
		
		return "/WEB-INF/views/common/ajax_view.jsp";
	}

}
