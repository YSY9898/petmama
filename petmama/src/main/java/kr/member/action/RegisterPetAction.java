package kr.member.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.controller.Action;
import kr.member.dao.MemberDAO;
import kr.member.vo.MemberVO;

public class RegisterPetAction implements Action{

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		//전송된 데이터 인코딩 처리
		request.setCharacterEncoding("utf-8");
		//자바빈(VO) 생성
		MemberVO vo = new MemberVO();
		vo.setPet_name(request.getParameter("pet_name"));
		vo.setPet_age(Integer.parseInt(request.getParameter("pet_age")));
		vo.setPet_photo(request.getParameter("pet_photo"));
		vo.setPet_note(request.getParameter("pet_note"));
		
		MemberDAO dao = MemberDAO.getInstance();
		dao.insertMember(vo);
		
		// jsp 경로 반환
		return "/WEB-INF/views/member/registerPet.jsp";
	}

}
