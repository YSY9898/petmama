//package kr.customer.action;
//
//import javax.servlet.http.HttpServletRequest;
//import javax.servlet.http.HttpServletResponse;
//
//import kr.controller.Action;
//import kr.qna.dao.QnaDAO;
//import kr.qna.vo.QnaVO;
//import kr.util.StringUtil;
//
//public class QnaDetailAction implements Action{
//
//	@Override
//	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
//		int q_num = Integer.parseInt(request.getParameter("q_num"));
//		
//		QnaDAO dao = QnaDAO.getInstance();
//
//		dao.checkQNA(q_num);
//		
//		QnaVO qna = dao.getQNA(q_num);
//		
//		
//		//HTML를 허용하지 않음
////		board.setTitle(StringUtil.useNoHtml(board.getTitle()));
//		//HTML를 허용하지 않으면서 줄바꿈 처리
////		board.setContent(StringUtil.useBrNoHtml(board.getContent()));
//		
////		request.setAttribute("board", board);
//		
//		return "/WEB-INF/views/board/detail.jsp";
//	}
//}