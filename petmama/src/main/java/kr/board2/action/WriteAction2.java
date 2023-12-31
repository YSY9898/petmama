package kr.board2.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.oreilly.servlet.MultipartRequest;

import kr.board2.dao.BoardDAO2;
import kr.board2.vo.BoardVO2;
import kr.controller.Action;
import kr.util.FileUtil;

public class WriteAction2 implements Action{

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		HttpSession session = request.getSession();
		Integer user_num = (Integer)session.getAttribute("user_num");
		if(user_num == null) {
			return "redirect:/member/loginForm.do";
		}
		
		MultipartRequest multi = FileUtil.createFile(request);
		BoardVO2 board1 = new BoardVO2();
		board1.setTitle(multi.getParameter("title"));
		board1.setContent(multi.getParameter("content"));
		board1.setFilename(multi.getFilesystemName("filename"));
		board1.setIp(request.getRemoteAddr());
		board1.setMem_num(user_num);
		
		BoardDAO2 dao1 = BoardDAO2.getInstance();
		dao1.insertBoard2(board1);
		
		return "/WEB-INF/views/board2/write2.jsp";
	}
	
}
