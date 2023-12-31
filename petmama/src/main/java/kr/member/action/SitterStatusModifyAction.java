package kr.member.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.controller.Action;
import kr.petsitter.dao.PetsitterDAO;
import kr.petsitter.vo.PetsitterVO;

public class SitterStatusModifyAction implements Action{

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		HttpSession session = request.getSession();
		Integer user_num = (Integer)session.getAttribute("user_num");
		
		if(user_num == null) {//로그인 되지 않은 경우
			return "redirect:/member/loginForm.do";
		}
		Integer user_auth = (Integer)session.getAttribute("user_auth");
		if(user_auth != 9) {//관리자로 로그인하지 않은 경우
			return "/WEB-INF/views/common/notice.jsp";
		}
		
		//전송된 데이터 인코딩 처리
		request.setCharacterEncoding("utf-8");
		
		PetsitterVO vo = new PetsitterVO();
		vo.setSis_condition(Integer.parseInt(request.getParameter("status")));
		vo.setSis_num(Integer.parseInt(request.getParameter("sis_num")));
		
		PetsitterDAO dao = PetsitterDAO.getInstance();
		
		dao.updatePetsitterStatus(vo);
		
		request.setAttribute("notice_msg", "정상적으로 수정되었습니다.");
		request.setAttribute("notice_url", request.getContextPath()+"/member/sitterAdminDetail.do?sis_num="+vo.getSis_num());
		
		return "/WEB-INF/views/common/alert_singleView.jsp";
	}

}
