package kr.board2.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.board2.dao.BoardDAO2;
import kr.board2.vo.BoardVO2;
import kr.controller.Action;
import kr.util.FileUtil;

public class DeleteAction2 implements Action{

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		HttpSession session = request.getSession();
		Integer user_num = (Integer)session.getAttribute("user_num");
		if(user_num == null) {
			return "redirect:/member/loginForm.do";
		}

		int board_num = Integer.parseInt(
                request.getParameter("board_num"));
		BoardDAO2 dao = BoardDAO2.getInstance();
		BoardVO2 db_board = dao.getBoard(board_num);
		if(user_num != db_board.getMem_num()) {
			//로그인한 회원번호와 작성자 회원번호가 불일치
			return "/WEB-INF/views/common/notice.jsp";
		}
		
		//로그인한 회원번호와 작성자 회원번호가 일치
		dao.deleteBoard(board_num);
		//파일 삭제
		FileUtil.removeFile(request, db_board.getFilename());
				
		return "redirect:/board2/list2.do";
		
	}
	
}
