package kr.reservation.action;

import java.util.ArrayList;
import java.util.List;
import java.util.ListIterator;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.controller.Action;
import kr.psboard.dao.PSBoardDAO;
import kr.psboard.vo.PSBoardVO;
import kr.reservation.dao.ReservationDAO;
import kr.reservation.vo.ReservationVO;
import kr.util.PageUtil;

public class ReservListAction implements Action{

	@SuppressWarnings("null")
	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String pageNum = request.getParameter("pageNum"); //처음 호출할때 pageNum이 없어서 null일때 1표시
		HttpSession session = request.getSession();

		Integer user_num = (Integer) session.getAttribute("user_num");
		Integer user_auth = (Integer) session.getAttribute("user_auth");
		
		if(pageNum == null) pageNum = "1";
		
		String keyfield = request.getParameter("keyfield");
		String keyword = request.getParameter("keyword");

		ReservationDAO dao = ReservationDAO.getInstance();
		int count = dao.getReservCount(user_num, keyfield, keyword);
		
		//페이지 처리
		PageUtil page = new PageUtil(keyfield,keyword,Integer.parseInt(pageNum),count,5,5,"list.do");
		
		List<ReservationVO> list = null;
		if(count > 0) {
			list = dao.getReservList(user_num, page.getStartRow(), page.getEndRow(), keyfield, keyword);
		}
		
		PSBoardVO list_p = new PSBoardVO();
		List<PSBoardVO> list2 = new ArrayList<PSBoardVO>();
		PSBoardDAO dao_p = PSBoardDAO.getInstance();
		
		if(list != null) {
			ListIterator<ReservationVO> iterator = list.listIterator();
		
			//정방향 출력
	        while(iterator.hasNext()){
	            list_p = dao_p.getPSboard(iterator.next().getSis_num());
	            list2.add(list_p);
	        }
		}
		
		request.setAttribute("count", count);
		request.setAttribute("list", list);
		request.setAttribute("list2", list2);
		request.setAttribute("page", page.getPage());
		
		//JSP 경로 반환
		return "/WEB-INF/views/mypage/reservationList.jsp";
	}
}