package kr.customer.action;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.codehaus.jackson.map.ObjectMapper;

import com.google.gson.Gson;

import kr.controller.Action;
import kr.qna.dao.QnaDAO;
import kr.qna.vo.QnaReplyVO;
import kr.qna.vo.QnaVO;

public class QnaDetailAction implements Action {

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		int q_num = Integer.parseInt(request.getParameter("q_num"));
		String pwd_chk = request.getParameter("pwd_chk");

		Map<String, String> mapAjax = new HashMap<String, String>();
		HttpSession session = request.getSession();

		String user_id = (String) session.getAttribute("user_id");
		Integer user_auth = (Integer) session.getAttribute("user_auth");

		QnaDAO dao = QnaDAO.getInstance();

		if (pwd_chk.equals("Y")) {
			String password = request.getParameter("password");
			QnaVO qna_chk = dao.checkQnaPassword(q_num, password, user_id);

			if (qna_chk == null) {
				mapAjax.put("result", "mismatch");
			} else {
				QnaVO qna = dao.getQNA(q_num, user_id, user_auth);
				QnaReplyVO qnaReply = dao.getQnaReply(q_num, user_auth);
				String json = new Gson().toJson(qna);
				String json2 = new Gson().toJson(qnaReply);
				mapAjax.put("result", "success");
				mapAjax.put("auth", String.valueOf(user_auth));
				mapAjax.put("list", json);
				mapAjax.put("r_list", json2);
			}

		} else {
			QnaVO qna_chk = dao.checkQNA(q_num, user_id, user_auth);

			if (qna_chk == null) {
				mapAjax.put("result", "empty");
			} else {
				if (qna_chk.getHide_yn().equals("Y") && user_auth != 9) {
					mapAjax.put("result", "password");
				} else {
					QnaVO qna = dao.getQNA(q_num, user_id, user_auth);
					QnaReplyVO qnaReply = dao.getQnaReply(q_num, user_auth);
					String json = new Gson().toJson(qna);
					String json2 = new Gson().toJson(qnaReply);
					mapAjax.put("result", "success");
					mapAjax.put("auth", String.valueOf(user_auth));
					mapAjax.put("list", json);
					mapAjax.put("r_list", json2);
				}
			}
		}

		ObjectMapper mapper = new ObjectMapper();
		String ajaxData = mapper.writeValueAsString(mapAjax);
		request.setAttribute("ajaxData", ajaxData);

		return "/WEB-INF/views/common/ajax_view.jsp";
	}
}