package kr.member.action;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.board.dao.BoardDAO;
import kr.board.vo.BoardVO;
import kr.board2.dao.BoardDAO2;
import kr.board2.vo.BoardVO2;
import kr.controller.Action;
import kr.member.dao.MemberDAO;
import kr.member.vo.MemberVO;

public class MyPageAction implements Action{

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		HttpSession session = request.getSession();
		Integer user_num = (Integer)session.getAttribute("user_num");
		System.out.println("user_num : " + user_num);
		if(user_num == null) {//로그인이 되지 않은 경우
			return "redirect:/member/loginForm.do";
		}
		//로그인 된 경우
		//회원정보
		MemberDAO dao = MemberDAO.getInstance();
		MemberVO member = dao.getMember(user_num);
		
		//관심 게시물 정보(자유)
		BoardDAO boardDao = BoardDAO.getInstance();
		List<BoardVO> boardList = boardDao.getListBoardScrap(1, 5, user_num);
		
		//관심 게시물 정보(후기)
		BoardDAO2 boardDao2 = BoardDAO2.getInstance();
		List<BoardVO2> boardList2 = boardDao2.getListBoardScrap(1, 5, user_num);

		
		request.setAttribute("member", member);
		request.setAttribute("boardList", boardList);
		request.setAttribute("boardList2", boardList2);
		
		//JSP 경로 반환
		return "/WEB-INF/views/member/myPage.jsp";
	}
}



