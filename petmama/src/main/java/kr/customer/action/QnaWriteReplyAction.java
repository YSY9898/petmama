package kr.customer.action;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.codehaus.jackson.map.ObjectMapper;

import kr.controller.Action;
import kr.qna.dao.QnaDAO;
import kr.qna.vo.QnaReplyVO;
import kr.qnareply.dao.QnaReplyDAO;

public class QnaWriteReplyAction implements Action {

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		HttpSession session = request.getSession();
		Map<String, String> mapAjax = new HashMap<String, String>();

		int q_num = Integer.parseInt(request.getParameter("q_num")); 
		String content = request.getParameter("qr_content");
		Integer user_num = (Integer) session.getAttribute("user_num");
		
		if (user_num == null) {// 로그인이 되지 않은 경우
			mapAjax.put("result", "logout");
			ObjectMapper mapper = new ObjectMapper();
			String ajaxData = mapper.writeValueAsString(mapAjax);
			request.setAttribute("ajaxData", ajaxData);

			return "/WEB-INF/views/common/ajax_view.jsp";
		}
		
		QnaReplyVO qnaReply = new QnaReplyVO();
		qnaReply.setQ_num(q_num);
		qnaReply.setMem_num(user_num);
		qnaReply.setQr_content(content);
		qnaReply.setQr_ip(request.getRemoteAddr());

		QnaReplyDAO dao = QnaReplyDAO.getInstance();
		boolean insertChk = dao.insertQnaReply(qnaReply);

		if (insertChk) {
			QnaDAO qna_dao = QnaDAO.getInstance();
			qna_dao.updateQnaAnawer(q_num);
			mapAjax.put("result", "success");
		} else {
			mapAjax.put("result", "error");
		}

		ObjectMapper mapper = new ObjectMapper();
		String ajaxData = mapper.writeValueAsString(mapAjax);
		request.setAttribute("ajaxData", ajaxData);

		return "/WEB-INF/views/common/ajax_view.jsp";
	}
}