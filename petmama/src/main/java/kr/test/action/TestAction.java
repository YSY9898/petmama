package kr.test.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.controller.Action;

public class TestAction implements Action {
	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {

		// JSP 경로 반환
		return "/WEB-INF/views/psboard/list_helper.jsp";
	}
}