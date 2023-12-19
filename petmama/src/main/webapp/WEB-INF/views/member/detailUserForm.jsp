<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원 정보 수정(관리자 전용)</title>
</head>
<body>
	<div class="page-main">
		<jsp:include page="/WEB-INF/views/common/header.jsp"/>
		<div class="content-main">
			<br>
			<h2 class="fw-bold">${member.mem_id}의 회원정보 (관리자 전용)</h2>
			<br>
			
			<form action="adminUser.do" method="post" id="detail_form">
				<input type="hidden" name="mem_num" value="${member.mem_num}">	
				<ul class="list-unstyled">
					<li>
						<label class="badge text-bg-primary mx-4">등급</label>
						<c:if test="${member.mem_auth !=9}">
						<input type="radio" name="mem_auth" value="1" 
							id="auth1" <c:if test="${member.mem_auth == 1}">checked</c:if>>정지
						<input type="radio" name="mem_auth" value="2" 
							id="auth2" <c:if test="${member.mem_auth == 2}">checked</c:if>>일반
						</c:if>
						<c:if test="${member.mem_auth ==9}">
						<input type="radio" name="mem_auth" value="9" id="auth3" checked>관리
						</c:if>
					</li>
				</ul>
				<div class="align=center">
					<c:if test="${member.mem_auth != 9}">
					<input type="submit" value="수정" 
					class="btn btn-primary btn-block btn-sm m-t-md">
					</c:if>
					<input type="button" value="목록" 
					onclick="location.href='adminList.do'" class="btn btn-primary btn-block btn-sm m-t-md">
				</div>
				
				<br><br><br>
				<div class="card mx-auto" style="width:50rem;">
				<ul class="list-group">
					<li class="list-group-item">
						<label>이름 : </label> ${member.mem_name}
					</li>	
					<li class="list-group-item">
						<label>닉네임 : </label> ${member.mem_nickname}
					</li>
					<li class="list-group-item">
						<label>전화번호 : </label> ${member.mem_cell}
					</li>	
					<li class="list-group-item">
						<label>이메일 : </label> ${member.mem_email}
					</li>	
					<li class="list-group-item">
						<label>우편번호 : </label> ${member.mem_zipcode}
					</li>	
					<li class="list-group-item">
						<label>주소 : </label> ${member.mem_address1} ${member.mem_address2}
					</li>	
				</ul>
				</div>
				
			</form>
		</div>
	</div>

</body>
</html>