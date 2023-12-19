<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!-- header 시작 -->
<style>
.nav-item.dropdown, .spacing {
	padding: 8px 19px 8px 76px;
}

.rightmenu.header_logout, .rightmenu.header_login {
	width : 109px;
	list-style: none;	
	padding: 8px 19px 8px 12px;
}
.rightmenu.header_profile {
	list-style: none;	
}
.rightmenu a { 
	color: black;
}

a:link {
	text-decoration: none;
}

a:visited {
	text-decoration: none;
}

a:hover {
	text-decoration: none;
}
</style>
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css">
<script
src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/js/bootstrap.bundle.min.js"
type="text/javascript"></script>
<nav class="navbar navbar-expand-lg bg-white">
	<div class="container-fluid justify-content-end">
		<button class="navbar-toggler justify-content-end" type="button"
			data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent"
			aria-controls="navbarSupportedContent" aria-expanded="false"
			aria-label="Toggle navigation">
			<span class="navbar-toggler-icon"></span>
		</button>
		<div class="justify-content-end" id="navbarSupportedContent">
			<ul class="navbar-nav me-auto mb-2 mb-lg-0">
				<li class="nav-item dropdown"><a
					class="nav-link dropdown-toggle" href="#" role="button"
					data-bs-toggle="dropdown" aria-expanded="false"> 펫시터 </a>
					<ul class="dropdown-menu">
						<li><a class="dropdown-item"
							href="${pageContext.request.contextPath}/views/common/serviceIntro.do">펫시터
								서비스 소개</a></li>
						<li><a class="dropdown-item"
							href="${pageContext.request.contextPath}/PSboard/petsitterList.do">펫시터
								프로필</a></li>
					</ul></li>
				<li class="nav-item dropdown"><a
					class="nav-link dropdown-toggle" href="#" role="button"
					data-bs-toggle="dropdown" aria-expanded="false"> 커뮤니티 </a>
					<ul class="dropdown-menu">
						<li><a class="dropdown-item"
							href="${pageContext.request.contextPath}/board/list.do">자유게시판</a></li>
						<li><a class="dropdown-item"
							href="${pageContext.request.contextPath}/board2/list2.do">후기게시판</a></li>
					</ul></li>
				<li class="nav-item dropdown"><a
					class="nav-link dropdown-toggle" href="#" role="button"
					data-bs-toggle="dropdown" aria-expanded="false"> 지원 </a>
					<ul class="dropdown-menu">
						<li><a class="dropdown-item"
							href="${pageContext.request.contextPath}/member/applyPetsitterForm.do">펫시터
								지원하기</a></li>
					</ul></li>
				<li class="nav-item spacing"><a class="nav-link active"
					aria-current="page" href="/petmama/customer/questions.do">고객센터</a></li>

				<li class="nav-item spacing" style="margin-right:35px;"><a class="nav-link active"
					aria-current="page" href="/petmama/member/myPage.do">MyPage</a></li>
			</ul>
		</div>
	</div>

	<c:if test="${!empty user_num && !empty user_photo}">
		<li class="rightmenu header_profile"><img
			src="${pageContext.request.contextPath}/upload/${user_photo}"
			width="25" height="25" class="my-photo"></li>
	</c:if>
	<c:if test="${!empty user_num && empty user_photo}">
		<li class="rightmenu header_profile"><img
			src="${pageContext.request.contextPath}/images/face.png" width="25"
			height="25" class="my-photo"></li>
	</c:if>
	<c:if test="${!empty user_num}">
		<li class="rightmenu header_logout">[<span>${user_id}</span>] <br><a
			href="${pageContext.request.contextPath}/member/logout.do">로그아웃</a>
		</li>
	</c:if>
	<c:if test="${empty user_num}">
		<li class="rightmenu header_login"><a
			href="${pageContext.request.contextPath}/member/registerUserForm.do">회원가입</a></li>
		<li class="rightmenu header_login"><a
			href="${pageContext.request.contextPath}/member/loginForm.do">로그인</a></li>
	</c:if>
</nav>
<!-- header 끝 -->