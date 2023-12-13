package kr.member.action;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.codehaus.jackson.map.ObjectMapper;

import kr.controller.Action;
import kr.member.dao.MemberDAO;
import kr.member.vo.MemberVO;

public class CheckDuplicatedIdAction implements Action{

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		//전송된 ㄷ이터 인코딩 처리
		request.setCharacterEncoding("utf-8");
		
		String id = request.getParameter("id");
		
		MemberDAO dao = MemberDAO.getInstance(); 
		MemberVO member = dao.checkMember(id);
		
		Map<String,String> mapAjax = new HashMap<String,String>();
		if(member == null) {
			mapAjax.put("result", "idNotFound");
		}else {
			mapAjax.put("result", "idDuplicated");
		}
		
		ObjectMapper mapper = new ObjectMapper();
		String ajaxData = mapper.writeValueAsString(mapAjax);
		
		request.setAttribute("ajaxData", ajaxData);
		
		//jsp 경로 반환
		return "/WEB-INF/views/common/ajax_view.jsp";
	}

}