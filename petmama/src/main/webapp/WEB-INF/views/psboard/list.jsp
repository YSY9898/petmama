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
<style type="text/css">
.page_list{
	width: 100%;
    display: flex;
    flex-direction: column;
    justify-content: center;
    align-items: center;
    margin-top: 75px;
    padding-top: 45px;
    background-color: #F7F8FA;
}
.bg_img{
	width: 433px;
	height: 254px;
	border-radius: 3px;
	object-fit: cover;
	position: relative;
	margin-left: 10px;
}
.content-top{
	display: flex;
	margin-top: 55px;
}
.content{
	width: 1000px;
	height: 274px;
	border: 1px solid #EBEBEB;
	display: flex;
	box-shadow: 0px 0px 12px 0px rgba(0,0,0,0.07);
	border-radius: 8px;
	position: relative;
	align-items: center;
	background-color: white;
}
.profile{
	padding: 30px 45px 0 45px;
	height: 100%;
	display: flex;
	flex-grow: 1;
	flex-direction: column;
	justify-content: space-between;
	align-items: center;
}
.profile_header{
	width: 100%;
	display: flex;
	flex-direction: row;
	border-bottom: 1px solid #EBEBEB;
	padding-bottom: 18px;
}
.profile p{
	font-size: 13px;
	letter-spacing: -0.2px;
	font-weight: 500;
	color: #777777;
	line-height:15px;
}
.profile h2{
	font-size: 19px;
	letter-spacing: -0.2px;
	font-weight: 500;
	color: #393C47;
	margin-top : 8px;
	line-height:29px;
}
.profile_img{
	width:70px;
	height:70px;
	border-radius:45px;
	margin-left:45px;
}
.profile_body{
	display: flex;
	width: 100%;
	margin-top: 12px;
}
.profile_body span{
	font-size: 13px;
    color: #999999;
    letter-spacing: -0.2px;
    line-height: 21px;
}


</style>
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
							<div class="profile">
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
							</div>
						</div>
					</div>
					
				</c:forEach>
			</table>
	</div>
</div>
</body>
</html>