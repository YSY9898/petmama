<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!-- side bar 시작 -->
<button class="btn btn btn-outline-primary"
	style="position: absolute; z-index: 9999; background-color: white; margin: -16px 20px 20px 303px;"
	type="button" data-bs-toggle="offcanvas"
	data-bs-target="#offcanvasScrolling" aria-controls="offcanvasScrolling">
	Side 
</button>


<c:if test="${!empty user_num && user_auth != 9}">
	<div class="offcanvas offcanvas-start" data-bs-scroll="true"
		data-bs-backdrop="false" tabindex="-1" id="offcanvasScrolling"
		aria-labelledby="offcanvasScrollingLabel">
		<div class="offcanvas-header">
			<h4 class="offcanvas-title" id="offcanvasLabel">My Page</h4>
			<button type="button" class="btn-close" data-bs-dismiss="offcanvas"
				aria-label="Close"></button>
		</div>
		<div class="offcanvas-body">
			<p>
				<a
					href="${pageContext.request.contextPath}/member/modifyUserForm.do"
					class="dropdown-item">내 정보 & 펫 정보 수정</a>
			</p>
			<p>
				<a href="${pageContext.request.contextPath}/reservation/list.do?keyfield=ing"
					class="dropdown-item">내 예약 현황</a>
			</p>
			<p>
				<a href="${pageContext.request.contextPath}/mypage/myWriteList.do"
					class="dropdown-item">내가 쓴 글</a>
			</p>
		</div>
	</div>

</c:if>
<c:if test="${!empty user_num && user_auth == 9}">
	<div class="offcanvas offcanvas-start" data-bs-scroll="true"
		data-bs-backdrop="false" tabindex="-1" id="offcanvasScrolling"
		aria-labelledby="offcanvasScrollingLabel">
		<div class="offcanvas-header">
			<h4 class="offcanvas-title" id="offcanvasLabel">My Page</h4>
			<button type="button" class="btn-close" data-bs-dismiss="offcanvas"
				aria-label="Close"></button>
		</div>
		<div class="offcanvas-body">
			<p>
				<a
					href="${pageContext.request.contextPath}/member/modifyUserForm.do"
					class="dropdown-item">내 정보 수정</a>
			</p>
			<p>
				<a href="${pageContext.request.contextPath}/member/adminList.do"
					class="dropdown-item">회원 관리</a>
			</p>
			<p>
				<a href="${pageContext.request.contextPath}/member/sitterAdminList.do"
					class="dropdown-item">시터 관리</a>
			</p>
			<p>
				<a href="${pageContext.request.contextPath}/board/list.do" 
				class="dropdown-item">자유게시글 관리</a>
			</p>
			<p>
				<a href="${pageContext.request.contextPath}/board2/list2.do" 
				class="dropdown-item">후기게시글 관리</a>
			</p>
		</div>
	</div>
</c:if>

<!-- side bar 끝 -->