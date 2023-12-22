package kr.member.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.controller.Action;
import kr.member.dao.MemberDAO;
import kr.member.vo.MemberVO;
import kr.pet.vo.PetVO;

public class RegisterUserAction implements Action{

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		//전송된 데이터 인코딩 처리
		request.setCharacterEncoding("utf-8");
		//자바빈(VO) 생성
		MemberVO member = new MemberVO();
		member.setMem_id(request.getParameter("mem_id")); 
		member.setMem_name(request.getParameter("mem_name"));
		member.setMem_nickname(request.getParameter("mem_nickname"));
		member.setMem_pw(request.getParameter("mem_pw"));
		member.setMem_cell(request.getParameter("mem_cell"));
		member.setMem_email(request.getParameter("mem_email"));
		member.setMem_zipcode(request.getParameter("mem_zipcode"));
		member.setMem_address1(request.getParameter("mem_address1"));
		member.setMem_address2(request.getParameter("mem_address2"));
		
		PetVO pet = new PetVO();
		pet.setPet_name(request.getParameter("pet_name"));
		pet.setPet_age(Integer.parseInt(request.getParameter("pet_age")));
		pet.setPet_photo(request.getParameter("pet_photo"));
		pet.setPet_note(request.getParameter("pet_note"));
		
		MemberDAO dao = MemberDAO.getInstance();
		dao.insertMember(member,pet);
		
		// jsp 경로 반환
		return "/WEB-INF/views/member/registerUser.jsp";
	}

}
