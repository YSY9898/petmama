package kr.customer.action;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.websocket.Session;

import org.codehaus.jackson.map.ObjectMapper;

import com.google.gson.Gson;

import kr.controller.Action;
import kr.qna.dao.QnaDAO;
import kr.qna.vo.QnaVO;
import kr.util.StringUtil;

public class QnaDetailAction implements Action{

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		int q_num = Integer.parseInt(request.getParameter("q_num"));

		Map<String, String> mapAjax = new HashMap<String, String>();
		HttpSession session = request.getSession();
		
		String user_id = (String) session.getAttribute("user_id"); 
		
		QnaDAO dao = QnaDAO.getInstance();
		QnaVO qna_chk = dao.checkQNA(q_num, user_id);
		
		if(qna_chk == null) {
			mapAjax.put("result", "empty");
		} else {
			if(qna_chk.getHide_yn().equals("Y")) {
				mapAjax.put("result", "password");
			} else {
				QnaVO qna = dao.getQNA(q_num, user_id);
				String json = new Gson().toJson(qna);
				mapAjax.put("result", "success");
				mapAjax.put("list", json);
			}
		}
		ObjectMapper mapper = new ObjectMapper();
		String ajaxData = mapper.writeValueAsString(mapAjax);
		request.setAttribute("ajaxData", ajaxData);
		
		return "/WEB-INF/views/common/ajax_view.jsp";
	}
}