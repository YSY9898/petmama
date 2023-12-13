package kr.board2.action;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.codehaus.jackson.map.ObjectMapper;

import kr.board2.dao.BoardDAO2;
import kr.board2.vo.BoardVO2;
import kr.controller.Action;
import kr.util.FileUtil;

public class DeleteFileAction2 implements Action{

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
			
			BoardDAO2 dao = BoardDAO2.getInstance();
			BoardVO2 db_board = dao.getBoard(board_num);
			if(user_num!=db_board.getMem_num()) {
				mapAjax.put("result", "wrongAccess");
			}else {
				dao.deleteFile(board_num);
				
				FileUtil.removeFile(request, db_board.getFilename());
				
				mapAjax.put("result", "success");
			}
		}
		
		ObjectMapper mapper = new ObjectMapper();
		String ajaxData = mapper.writeValueAsString(mapAjax);
		
		request.setAttribute("ajaxData", ajaxData);
		
		return "/WEB-INF/views/common/ajax_view.jsp";
	}
	
}
