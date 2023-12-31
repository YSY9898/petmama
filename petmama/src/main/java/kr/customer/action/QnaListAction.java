package kr.customer.action;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.codehaus.jackson.map.ObjectMapper;

import kr.controller.Action;
import kr.qna.dao.QnaDAO;
import kr.qna.vo.QnaVO;
import kr.util.PageUtil;
import kr.util.PageUtilForAjax;

public class QnaListAction implements Action{

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String pageNum = request.getParameter("pageNum"); //처음 호출할때 pageNum이 없어서 null일때 1표시
		
		if(pageNum == null) pageNum = "1";
		
		String keyfield = request.getParameter("keyfield");
		String keyword = request.getParameter("keyword");

		QnaDAO dao = QnaDAO.getInstance();
		int count = dao.getQnaCount(keyfield, keyword);
		
		//페이지 처리
		PageUtilForAjax page = new PageUtilForAjax(keyfield,keyword,Integer.parseInt(pageNum),count,20,10,"list.do");
		
		List<QnaVO> list = null;
		if(count > 0) {
			list = dao.getListQna(page.getStartRow(), page.getEndRow(), keyfield, keyword);
		}
		
		request.setAttribute("count", count);
		request.setAttribute("list", list);
		request.setAttribute("page", page.getPage());
		
		//JSP 경로 반환
		return "/WEB-INF/views/customer/questionList.jsp";
	}
}