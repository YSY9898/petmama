package kr.member.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.controller.Action;
import kr.member.dao.MemberDAO;
import kr.member.vo.MemberVO;

public class RegisterUserAction implements Action{

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		//전송된 데이터 인코딩 처리
		request.setCharacterEncoding("utf-8");
		//자바빈(VO) 생성
		MemberVO vo = new MemberVO();
		vo.setMem_id(request.getParameter("mem_id"));
		vo.setMem_name(request.getParameter("mem_name"));
		vo.setMem_nickname(request.getParameter("mem_nickname"));
		vo.setMem_pw(request.getParameter("mem_pw"));
		vo.setMem_cell(request.getParameter("mem_cell"));
		vo.setMem_email(request.getParameter("mem_email"));
		vo.setMem_zipcode(request.getParameter("mem_zipcode"));
		vo.setMem_address1(request.getParameter("mem_address1"));
		vo.setMem_address2(request.getParameter("mem_address2"));
		
		vo.setPet_name(request.getParameter("pet_name"));
		vo.setPet_age(Integer.parseInt(request.getParameter("pet_age")));
		vo.setFilename(request.getParameter("filename"));
		vo.setPet_note(request.getParameter("pet_note"));
		
		MemberDAO dao = MemberDAO.getInstance();
		dao.insertMember(vo);
		
		// jsp 경로 반환
		return "/WEB-INF/views/member/registerUser.jsp";
	}

}
