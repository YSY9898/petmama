package kr.member.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.controller.Action;
import kr.petsitter.dao.PetsitterDAO;

public class ReserveFormAction implements Action{

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		//전송된 데이터 인코딩 처리
		request.setCharacterEncoding("utf-8");
		
		HttpSession session = request.getSession();
		Integer user_num = (Integer)session.getAttribute("user_num");
		
		if(user_num == null) { //로그인이 되지 않은 경우
			return "redirect:/member/loginForm.do";
		}
		/*
		MemberDAO dao = MemberDAO.getInstance();
		회원 등급 정보 얻기
		int mem_auth = dao.getMemAuth(user_num);
		
		if(mem_auth == 0) {//탈퇴 회원
			request.setAttribute("accessMsg", "탈퇴한 회원입니다.");
			return "/WEB-INF/views/common/notice.jsp";
		}else if(mem_auth == 1) {//정지 회원
			request.setAttribute("accessMsg", "정지된 회원입니다.");
			return "/WEB-INF/views/common/notice.jsp";
		}*/
		
		//로그인이 된 경우
		String date = request.getParameter("date");
		String time = request.getParameter("time");

		//펫시터 일 유형
		int sis_num = Integer.parseInt(request.getParameter("sis_num")); //펫시터 번호
		PetsitterDAO PS = PetsitterDAO.getInstance();
		int sis_work = PS.getPSwork(sis_num);
		
		//애완동물 유무 체크
		
		request.setAttribute("date", date);
		request.setAttribute("time", time);
		request.setAttribute("sis_work", sis_work);
		
		return "/WEB-INF/views/member/reserveForm.jsp";
	}

}
