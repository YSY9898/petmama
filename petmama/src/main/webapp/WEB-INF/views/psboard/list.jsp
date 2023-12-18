<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>펫시터 프로필 리스트</title>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/petsitter/style.css">
</head>
<body>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/js/bootstrap.bundle.min.js" type="text/javascript"></script>
<div class="page_list">
	<jsp:include page="/WEB-INF/views/common/header.jsp"/>
	<div>
		<h4>펫시터 목록</h4>
			<table>
				<c:forEach var="PSlist" items="${list}">
					<div class="content-top">
						<div class="content">
							<img src="${pageContext.request.contextPath}/upload/${PSlist.photo2}" class="bg_img">
							<a href="${pageContext.request.contextPath}/PSboard/detail.do?sis_num=${PSlist.sis_num}" class="profile">
								<div class="profile_header">
									<div style="flex-grow:1">
										<p>${PSlist.name} 펫시터</p>
										<h2>${PSlist.title} </h2>
									</div>
									<img src="${pageContext.request.contextPath}/upload/${PSlist.photo1}" class="profile_img">
								</div>
								<div class="profile_body">
									<span>${PSlist.tag} </span>
								</div>
								<div class="profile_foot">
									<div class="rating_box">
   										 <div class="rating">
     										★★★★★ 
   										 </div>
   										 ${PSlist.rating}
 									</div>
									<div class="rate_reviewNum">
										<p>후기</p>
									</div>
								</div>
								
							</a>
							
						</div>
					</div>
					
				</c:forEach>
			</table>
	</div>
</div>
</body>
</html>