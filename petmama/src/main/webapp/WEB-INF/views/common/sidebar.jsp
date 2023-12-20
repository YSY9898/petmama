<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!-- side bar 시작 -->
<div class="offcanvas offcanvas-start show" tabindex="-1" id="offcanvas" aria-labelledby="offcanvasLabel">
  <div class="offcanvas-header">
    <h4 class="offcanvas-title" id="offcanvasLabel">My Page</h4>
    <button type="button" class="btn-close" data-bs-dismiss="offcanvas" aria-label="Close"></button>
    </div>
  <div class="offcanvas-body">
   	<p><a href="${pageContext.request.contextPath}/member/modifyUserForm.do" class="dropdown-item">내 정보 수정</a></p>
	<p><a href="#" class="dropdown-item">펫 정보 수정</a></p>
	<p><a href="${pageContext.request.contextPath}/reservation/list.do" class="dropdown-item">내 예약 현황</a></p>
	<p><a href="#" class="dropdown-item">내가 쓴 글</a></p>
  </div>
</div>

<c:if test="${!empty user_num && user_auth == 9}">
  <div class="offcanvas offcanvas-start show" tabindex="-1" id="offcanvas" aria-labelledby="offcanvasLabel">
  <div class="offcanvas-header">
    <h4 class="offcanvas-title" id="offcanvasLabel">My Page</h4>
    </div>
  <div class="offcanvas-body">
   	<p><a href="${pageContext.request.contextPath}/member/modifyUserForm.do" class="dropdown-item">내 정보 수정</a></p>
	<p><a href="${pageContext.request.contextPath}/member/adminList.do" class="dropdown-item">회원 관리</a></p>
	<p><a href="#" class="dropdown-item">게시글 관리</a></p>
  </div>
</div>
				</c:if>	

<!-- side bar 끝 -->