package kr.board2.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.oreilly.servlet.MultipartRequest;

import kr.board.vo.BoardVO;
import kr.board2.dao.BoardDAO2;
import kr.board2.vo.BoardVO2;
import kr.controller.Action;
import kr.util.FileUtil;

public class UpdateAction2 implements Action{

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		HttpSession session = request.getSession();
		Integer user_num = (Integer)session.getAttribute("user_num");
		if(user_num == null) {
			return "redirect:/member/loginForm.do";
		}
		
		MultipartRequest multi = FileUtil.createFile(request);
		int board_num = Integer.parseInt(multi.getParameter("board_num"));
		String filename = multi.getFilesystemName("filename");
		
		BoardDAO2 dao = BoardDAO2.getInstance();
		BoardVO2 db_board = dao.getBoard(board_num);
		if(user_num != db_board.getMem_num()) {
			FileUtil.removeFile(request, filename);
			return "/WEB-INF/views/common/notice.jsp";
		}
		
		BoardVO2 board = new BoardVO2();
		board.setBoard_num(board_num);
		board.setTitle(multi.getParameter("title"));
		board.setContent(multi.getParameter("content"));
		board.setIp(request.getRemoteAddr());
		board.setFilename(filename);
		
		dao.updateBoard(board);
		
		if(filename!=null) {
			FileUtil.removeFile(request, db_board.getFilename());
		}

		return "/redirect:/board2/detail2.do?board_num=" + board_num;
	}

}
