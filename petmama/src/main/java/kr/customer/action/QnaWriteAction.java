//package kr.customer.action;
//
//import java.util.HashMap;
//import java.util.Map;
//
//import javax.servlet.http.HttpServletRequest;
//import javax.servlet.http.HttpServletResponse;
//import javax.servlet.http.HttpSession;
//
//import org.codehaus.jackson.map.ObjectMapper;
//
//import com.oreilly.servlet.MultipartRequest;
//
//import kr.board.dao.BoardDAO;
//import kr.board.vo.BoardVO;
//import kr.controller.Action;
//import kr.qna.dao.QnaDAO;
//import kr.qna.vo.QnaVO;
//import kr.util.FileUtil;
//
//public class QnaWriteAction implements Action {
//
//	@Override
//	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
//		HttpSession session = request.getSession();
//		Map<String, String> mapAjax = new HashMap<String, String>();
//
//		Integer user_num = (Integer) session.getAttribute("user_num");
//		String user_id = (String) session.getAttribute("user_id");
//		if (user_num == null) {// 로그인이 되지 않은 경우
//			mapAjax.put("result", "logout");
//			ObjectMapper mapper = new ObjectMapper();
//			String ajaxData = mapper.writeValueAsString(mapAjax);
//			request.setAttribute("ajaxData", ajaxData);
//
//			return "/WEB-INF/views/common/ajax_view.jsp";
//		}
//
//		// 로그인이 된 경우
//		int sis_num = 0;
//		if (request.getParameter("sis_num") != null) {
//			sis_num = Integer.parseInt(request.getParameter("sis_num"));
//		}
//		String title = request.getParameter("title");
//		String content = request.getParameter("content");
//		String hide_yn = request.getParameter("hideYN");
//		int passwd = 0;
//		if (hide_yn.equals("Y") && request.getParameter("passwd") != null) {
//			passwd = Integer.parseInt(request.getParameter("passwd"));
//		}
//
//		System.out.println(sis_num);
//		System.out.println(title);
//		System.out.println(content);
//		System.out.println(passwd);
//		System.out.println(hide_yn);
//
//		QnaVO qna = new QnaVO();
//		qna.setMem_num(user_num);
//		qna.setMem_id(user_id);
//		qna.setSis_num(sis_num);
//		qna.setTitle(title);
//		qna.setContent(content);
//		qna.setPasswd(passwd);
////		qna.setFilename(null);
//		qna.setHide_yn(hide_yn);
//
//		QnaDAO dao = QnaDAO.getInstance();
//		boolean insertChk = dao.insertQna(qna);
//
//		if (insertChk) {
//			mapAjax.put("result", "success");
//		} else {
//			mapAjax.put("result", "error");
//		}
//
//		ObjectMapper mapper = new ObjectMapper();
//		String ajaxData = mapper.writeValueAsString(mapAjax);
//		request.setAttribute("ajaxData", ajaxData);
//
//		return "/WEB-INF/views/common/ajax_view.jsp";
//	}
//}