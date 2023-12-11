<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!-- header 시작 -->
<nav class="navbar navbar-expand-lg bg-body-tertiary">
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
						<li><a class="dropdown-item" href="#">Action</a></li>
						<li><a class="dropdown-item" href="#">Another action</a></li>
					</ul></li>
				<li class="nav-item dropdown"><a
					class="nav-link dropdown-toggle" href="#" role="button"
					data-bs-toggle="dropdown" aria-expanded="false"> 커뮤니티 </a>
					<ul class="dropdown-menu">
						<li><a class="dropdown-item" href="#">Action</a></li>
						<li><a class="dropdown-item" href="#">Another action</a></li>
					</ul></li>
				<li class="nav-item dropdown"><a
					class="nav-link dropdown-toggle" href="#" role="button"
					data-bs-toggle="dropdown" aria-expanded="false"> 지원 </a>
					<ul class="dropdown-menu">
						<li><a class="dropdown-item" href="#">Action</a></li>
						<li><a class="dropdown-item" href="#">Another action</a></li>
					</ul></li>
				<li class="nav-item dropdown"><a
					class="nav-link dropdown-toggle" href="#" role="button"
					data-bs-toggle="dropdown" aria-expanded="false"> 고객센터 </a>
					<ul class="dropdown-menu">
						<li><a class="dropdown-item" href="#">Action</a></li>
						<li><a class="dropdown-item" href="#">Another action</a></li>
					</ul></li>

				<li class="nav-item"><a class="nav-link active"
					aria-current="page" href="/petmama/member/loginForm.do">Mypage</a></li>
			</ul>
		</div>
	</div>
	<c:if test="${!empty user_num && !empty user_photo}">
		<li class="menu-profile"><img
			src="${pageContext.request.contextPath}/upload/${user_photo}"
			width="25" height="25" class="my-photo"></li>
	</c:if>
	<c:if test="${!empty user_num && empty user_photo}">
		<li class="menu-profile"><img
			src="${pageContext.request.contextPath}/images/face.png" width="25"
			height="25" class="my-photo"></li>
	</c:if>
	<c:if test="${!empty user_num}">
		<li class="menu-logout">[<span>${user_id}</span>] <a
			href="${pageContext.request.contextPath}/member/logout.do">로그아웃</a>
		</li>
	</c:if>
	<c:if test="${empty user_num}">
		<li><a
			href="${pageContext.request.contextPath}/member/registerUserForm.do">회원가입</a></li>
		<li><a
			href="${pageContext.request.contextPath}/member/loginForm.do">로그인</a></li>
	</c:if>
</nav>
<!-- header 끝 -->