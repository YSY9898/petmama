package kr.psboard.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.controller.Action;
import kr.psboard.dao.PSBoardDAO;
import kr.psboard.vo.PSBoardVO;

public class DetailListAction implements Action{

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		//펫시터 번호 반환
		int sis_num = Integer.parseInt(request.getParameter("sis_num"));
		
		PSBoardDAO dao = PSBoardDAO.getinstatnce();
		PSBoardVO vo = dao.getPSboard(sis_num);
		
		request.setAttribute("ps", vo);
		
		return "/WEB-INF/views/psboard/detail.jsp";
	}

}
