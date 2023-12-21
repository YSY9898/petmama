package kr.member.action;

import java.text.SimpleDateFormat;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.Calendar;
import java.util.Date;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.controller.Action;
import kr.reservation.dao.ReservationDAO;
import kr.reservation.vo.ReservationVO;

public class ReserveAction implements Action{

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		//전송된 데이터 인코딩 처리
		request.setCharacterEncoding("utf-8");
		
		//현재 로그인한 아이디
		HttpSession session = request.getSession();
		Integer user_num = (Integer)session.getAttribute("user_num");
		
		String time = request.getParameter("time");
		String date = request.getParameter("date");
		
		String td = date + " " + time; 
		
		//시간 계산
		SimpleDateFormat formatdate = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		Date DATE = formatdate.parse(td);
		String da = null;
		
		Calendar cal = Calendar.getInstance();
		cal.setTime(DATE);
		
		int fee = Integer.parseInt(request.getParameter("fee"));
		if(fee==1) {
			da = date + " 23:59:59";
		}else if(fee==2) {
			cal.add(Calendar.MINUTE, 30); //30분 후 
			da = formatdate.format(cal.getTime());
		}else if(fee==3) {
			cal.add(Calendar.HOUR, 1); //1시간 후 
			da = formatdate.format(cal.getTime());
		}else if(fee==4) {
			cal.add(Calendar.HOUR, 2); //2시간 후 
			da = formatdate.format(cal.getTime());
		}
		
		//자바빈 생성
		ReservationVO vo = new ReservationVO();
		vo.setMem_num(user_num);
		vo.setSis_num(Integer.parseInt(request.getParameter("sis_num")));
		vo.setSis_work(Integer.parseInt(request.getParameter("sis_work")));
		vo.setVisit_status(Integer.parseInt(request.getParameter("visit_status")));
		vo.setR_pet_note(request.getParameter("pet_note"));
		vo.setR_start(date + " " +time);
		vo.setR_end(da);
		
		ReservationDAO dao= ReservationDAO.getInstance();
		dao.reserve(vo);
		
		
		return "/WEB-INF/views/member/reserve.jsp";
	}

}
