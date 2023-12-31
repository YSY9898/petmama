<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>펫시터 프로필 리스트</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/petsitter/style.css">
</head>
<body>
	<jsp:include page="/WEB-INF/views/common/header.jsp"/>
<div class="page_list">
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
   										 <div class="star-rating">
									        <span style="width:${(PSlist.rating/5*100)/2}%"></span>
								         </div>
									     <p class="rating_number">${PSlist.rating}</p>
								    </div>  
								   
									<div class="rate_reviewNum">
										 <!--<p>후기</p>-->
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