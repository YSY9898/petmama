package kr.noticeboard.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.oreilly.servlet.MultipartRequest;

import kr.board.dao.BoardDAO;
import kr.board.vo.BoardVO;
import kr.controller.Action;
import kr.noticeboard.dao.NoticeBoardDAO;
import kr.noticeboard.vo.NoticeBoardVO;
import kr.util.FileUtil;

public class WriteAction implements Action{

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		HttpSession session = request.getSession();
		Integer user_num = (Integer)session.getAttribute("user_num");
		Integer user_auth = (Integer)session.getAttribute("user_auth");
		if(user_num == null) {//로그인이 되지 않은 경우
			return "redirect:/member/loginForm.do";
		}
		if(user_auth != 9) {//관리자로 로그인하지 않은 경우
			return "/WEB-INF/views/common/notice.jsp";
		}
		
		//로그인이 된 경우
		MultipartRequest multi = FileUtil.createFile(request);
		NoticeBoardVO board = new NoticeBoardVO();
		board.setNotice_title(multi.getParameter("title"));
		board.setNotice_content(multi.getParameter("content"));
		board.setNotice_filename(multi.getFilesystemName("filename"));
		board.setNotice_ip(request.getRemoteAddr());
		board.setMem_num(user_num);
		
		NoticeBoardDAO dao = NoticeBoardDAO.getInstance();
		dao.insertNoticeBoard(board);
		
		request.setAttribute("notice_msg", "게시글을 등록하였습니다.");
		request.setAttribute("notice_url", request.getContextPath()+"/noticeboard/list.do");
		
		return "/WEB-INF/views/common/alert_singleView.jsp";
	}

}
