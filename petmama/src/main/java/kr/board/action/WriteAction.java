package kr.board.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.oreilly.servlet.MultipartRequest;

import kr.board.dao.BoardDAO;
import kr.board.vo.BoardVO;
import kr.controller.Action;
import kr.util.FileUtil;

public class WriteAction implements Action{

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		HttpSession session = request.getSession();
		Integer user_num = (Integer)session.getAttribute("user_num");
		String user_nickname = (String)session.getAttribute("user_nickname");
		if(user_num == null) {//로그인이 되지 않은 경우
			return "redirect:/member/loginForm.do";
		}
		
		//로그인이 된 경우
		MultipartRequest multi = FileUtil.createFile(request);
		BoardVO board = new BoardVO();
		board.setTitle(multi.getParameter("title"));
		board.setContent(multi.getParameter("content"));
		board.setFilename(multi.getFilesystemName("filename"));
		board.setIp(request.getRemoteAddr());
		board.setMem_num(user_num);
		board.setMem_nickname(user_nickname);
		
		BoardDAO dao = BoardDAO.getInstance();
		dao.insertBoard(board);
		
		return "/WEB-INF/views/board/write.jsp";
	}

}
