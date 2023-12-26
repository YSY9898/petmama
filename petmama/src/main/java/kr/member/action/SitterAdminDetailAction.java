package kr.member.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.controller.Action;
import kr.petsitter.dao.PetsitterDAO;
import kr.petsitter.vo.PetsitterVO;

public class SitterAdminDetailAction implements Action{

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		HttpSession session = request.getSession();
		Integer user_num = (Integer)session.getAttribute("user_num");
		Integer user_auth = (Integer)session.getAttribute("user_auth");
		
		if(user_num == null) {
			return "redirect:/member/loginForm.do";
		}
		if(user_auth != 9) {//관리자로 로그인하지 않은 경우
			return "/WEB-INF/views/common/notice.jsp";
		}
		
		int sis_num = Integer.parseInt(request.getParameter("sis_num"));
		PetsitterDAO dao = PetsitterDAO.getInstance();
		PetsitterVO vo = dao.getApply(sis_num);

		request.setAttribute("list", vo);
		//로그인한 회원ㅂㄴ호와 
		return "/WEB-INF/views/member/sitterAdminDetail.jsp";
	}

}
