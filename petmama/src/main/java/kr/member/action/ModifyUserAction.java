package kr.member.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.controller.Action;
import kr.member.dao.MemberDAO;
import kr.member.vo.MemberVO;
import kr.pet.vo.PetVO;

public class ModifyUserAction implements Action{

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		HttpSession session = request.getSession();
		Integer user_num = (Integer)session.getAttribute("user_num");
		
		if(user_num == null) {//로그인이 되지 않은 경우
			return "redirect:/member/loginForm.do";
		}
		//로그인이 된 경우
		//전송된 데이터 인코딩 처리
		request.setCharacterEncoding("utf-8");
		
		//자바빈(VO) 생성
		MemberVO member= new MemberVO();

		member.setMem_num(user_num);//회원 번호
		member.setMem_name(request.getParameter("mem_name"));
		member.setMem_nickname(request.getParameter("mem_nickname"));
		member.setMem_cell(request.getParameter("mem_cell"));
		member.setMem_email(request.getParameter("mem_email"));
		member.setMem_zipcode(request.getParameter("mem_zipcode"));
		member.setMem_address1(request.getParameter("mem_address1"));
		member.setMem_address2(request.getParameter("mem_address2"));
		
		//자바빈(VO) 생성
		PetVO pet = new PetVO();
		
		pet.setPet_name(request.getParameter("pet_name"));
		pet.setPet_age(Integer.parseInt(request.getParameter("pet_age")));
		pet.setPet_note(request.getParameter("pet_note"));
		
		MemberDAO dao = MemberDAO.getInstance();
		dao.updateMember(member, pet);
		
		//jsp 경로 반환
		return "/WEB-INF/views/member/modifyUser.jsp";
}

	
}	