package kr.noticeboard.action;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.codehaus.jackson.map.ObjectMapper;

import kr.board.dao.BoardDAO;
import kr.board.vo.BoardVO;
import kr.controller.Action;
import kr.util.FileUtil;

public class DeleteFileAction implements Action{

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		Map<String,String> mapAjax = new HashMap<String,String>();
		
		HttpSession session = request.getSession();
		Integer user_num = (Integer)session.getAttribute("user_num");
		
		if(user_num == null) {
			mapAjax.put("result", "logout");
		}else {
			request.setCharacterEncoding("utf-8");
			
			int board_num = Integer.parseInt(request.getParameter("board_num"));
			
			BoardDAO dao = BoardDAO.getInstance();
			BoardVO db_board = dao.getBoard(board_num);
			
			if(user_num!=db_board.getMem_num()) {
				mapAjax.put("result", "wrongAccess");
			}else {
				dao.deleteFile(board_num);
				
				FileUtil.removeFile(request, db_board.getFilename());
				
				mapAjax.put("result", "success");
			}
		}
		
		//JSON 데이터 생성
		ObjectMapper mapper = new ObjectMapper();
		String ajaxDate = mapper.writeValueAsString(mapAjax);
		
		request.setAttribute("ajaxData", ajaxDate);
		
		return "/WEB-INF/views/common/ajax_view.jsp";
	}

}
