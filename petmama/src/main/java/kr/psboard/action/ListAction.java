package kr.psboard.action;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.controller.Action;
import kr.psboard.dao.PSBoardDAO;
import kr.psboard.vo.PSBoardVO;


public class ListAction implements Action{

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		//펫시터 프로필 표시
		PSBoardDAO dao = PSBoardDAO.getinstatnce();
		List<PSBoardVO> list = dao.getListPS();
		
		request.setAttribute("list", list);
		//JSP 경로 반환
		return "/WEB-INF/views/psboard/list.jsp";
	}

}
