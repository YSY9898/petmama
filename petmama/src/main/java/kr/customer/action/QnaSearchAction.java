//package kr.customer.action;
//
//import java.util.HashMap;
//import java.util.List;
//import java.util.Map;
//
//import javax.servlet.http.HttpServletRequest;
//import javax.servlet.http.HttpServletResponse;
//import javax.servlet.http.HttpSession;
//
//import org.codehaus.jackson.map.ObjectMapper;
//
//import com.google.gson.Gson;
//
//import kr.controller.Action;
//import kr.qna.dao.QnaDAO;
//import kr.qna.vo.QnaVO;
//import kr.util.PageUtilForAjax;
//
//public class QnaSearchAction implements Action {
//	@Override
//	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
//		String pageNum = request.getParameter("pageNum"); //처음 호출할때 pageNum이 없어서 null일때 1표시
//		
//		HttpSession session = request.getSession();
//		Map<String, String> mapAjax = new HashMap<String, String>();
//
//		if(pageNum == null) pageNum = "1";
//		
//		String keyfield = request.getParameter("keyfield");
//		String keyword = request.getParameter("keyword");
//		
//		if(keyfield.equals("3")) {
//			keyword = (String) session.getAttribute("user_id");
//		}
//		
//		QnaDAO dao = QnaDAO.getInstance();
//		int count = dao.getQnaCount(keyfield, keyword);
//		
//		//페이지 처리
//		PageUtilForAjax page = new PageUtilForAjax(keyfield,keyword,Integer.parseInt(pageNum),count,20,10,"list.do");
//		
//		List<QnaVO> list = null;
//		if(count > 0) {
//			list = dao.getListQna(page.getStartRow(), page.getEndRow(), keyfield, keyword);
//		}
//		
//		String json = new Gson().toJson(list);
//		String json2 = new Gson().toJson(page);
//		
//		mapAjax.put("result", "success");
//		mapAjax.put("count", String.valueOf(count));
//		mapAjax.put("list", json);
//		mapAjax.put("page", json2);
//		ObjectMapper mapper = new ObjectMapper();
//		String ajaxData = mapper.writeValueAsString(mapAjax);
//		request.setAttribute("ajaxData", ajaxData);
//
//		return "/WEB-INF/views/common/ajax_view.jsp";
//	}
//}