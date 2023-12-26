package kr.board.action;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.board.dao.BoardDAO;
import kr.board.vo.BoardVO;
import kr.controller.Action;
import kr.noticeboard.dao.NoticeBoardDAO;
import kr.noticeboard.vo.NoticeBoardVO;
import kr.util.PageUtil;

public class ListAction implements Action{

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String pageNum = request.getParameter("pageNum"); //처음 호출할때 pageNum이 없어서 null일때 1표시
		if(pageNum == null) pageNum = "1";
		
		String keyfield = request.getParameter("keyfield");
		String keyword = request.getParameter("keyword");
		
		BoardDAO dao = BoardDAO.getInstance();
		NoticeBoardDAO daono = NoticeBoardDAO.getInstance();
		int count = dao.getBoardCount(keyfield, keyword);
		
		//페이지 처리
		PageUtil page = new PageUtil(keyfield,keyword,Integer.parseInt(pageNum),count,20,10,"list.do");
		
		List<BoardVO> list = null;
		List<NoticeBoardVO> listno = null;
		if(count > 0) {
			list = dao.getListBoard(page.getStartRow(), page.getEndRow(), keyfield, keyword);
			listno = daono.getNoticeListBoard(page.getStartRow(), page.getEndRow(), keyfield, keyword, 1);//notice_status가 2인 것 표시
		}
		
		System.out.println(list);
		
		request.setAttribute("count", count);
		request.setAttribute("list", list);
		request.setAttribute("noticelist", listno);
		request.setAttribute("page", page.getPage());
		
		//JSP 경로 반환
		return "/WEB-INF/views/board/list.jsp";
	}

}
