package kr.member.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.oreilly.servlet.MultipartRequest;

import kr.controller.Action;
import kr.petsitter.dao.PetsitterDAO;
import kr.petsitter.vo.PetsitterVO;
import kr.util.FileUtil;

public class ApplyPetsitterAction implements Action{

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		//전송된 데이터 인코딩 처리
		request.setCharacterEncoding("utf-8");
		//파일 업로드
		MultipartRequest multi = FileUtil.createFile(request);
		//현재 로그인한 아이디
		HttpSession session = request.getSession();
		Integer user_num = (Integer)session.getAttribute("user_num");
		//자바빈(VO) 생성
		PetsitterVO vo = new PetsitterVO();
		vo.setMem_num(user_num);
		
		System.out.println(vo.getMem_num());
		
		vo.setSis_condition(0); // 대기 상태
		vo.setSis_name(multi.getParameter("sis_name"));
		vo.setSis_work(Integer.parseInt(multi.getParameter("sis_work")));
		vo.setSis_phone(multi.getParameter("sis_phone"));
		vo.setSis_email(multi.getParameter("sis_email"));
		vo.setSis_zipcode(multi.getParameter("zipcode"));
		vo.setSis_address1(multi.getParameter("address1"));
		vo.setSis_address2(multi.getParameter("address2"));
		vo.setSis_photo1(multi.getFilesystemName("photo1"));
		vo.setSis_photo2(multi.getFilesystemName("photo2"));
		vo.setTitle(multi.getParameter("title"));
		vo.setTag(multi.getParameter("tag"));
		
		PetsitterDAO dao = PetsitterDAO.getInstance();
		dao.applyPetsitter(vo);
		
		//JSP 경로 반환
		return "/WEB-INF/views/member/applyPetsitter.jsp";
	}

}
