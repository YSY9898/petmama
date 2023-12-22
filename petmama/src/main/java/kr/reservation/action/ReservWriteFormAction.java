package kr.reservation.action;

import java.util.ArrayList;
import java.util.List;
import java.util.ListIterator;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.controller.Action;
import kr.pet.dao.PetDAO;
import kr.pet.vo.PetVO;
import kr.psboard.dao.PSBoardDAO;
import kr.psboard.vo.PSBoardVO;
import kr.reservation.dao.ReservationDAO;
import kr.reservation.vo.ReservationVO;

public class ReservWriteFormAction implements Action{
	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		HttpSession session = request.getSession();

		Integer user_num = (Integer) session.getAttribute("user_num");
		Integer r_num = Integer.parseInt(request.getParameter("r_num"));

		ReservationDAO dao = ReservationDAO.getInstance();
		
		List<ReservationVO> list = null;
		list = dao.getReservDetail(user_num, r_num);
		
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
		
		PetDAO dao_pet = PetDAO.getInstance();
		
		List<PetVO> list3 = null;
		list3 = dao_pet.checkPet(user_num);
		
		request.setAttribute("list", list);
		request.setAttribute("list2", list2);
		request.setAttribute("list3", list3);
		
		//로그인이 된 경우
		return "/WEB-INF/views/mypage/reservationWriteForm.jsp";
	}
}
