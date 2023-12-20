<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<c:if test="${check}">
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원탈퇴 완료</title>
</head>
<body>
<div class="page-main">
	<jsp:include page="/WEB-INF/views/common/header.jsp"/>
	<div class="content-main">
	<div class="row align-items-center">
	<br><br><br><br><br>
	<br><br><br><br><br>
	<br><br><br><br><br>
		<div class="col"></div>
		<div class="card col" style="width: 18rem;">
		  <div class="card-body">
		    <h5 class="card-title text-center">회원탈퇴 완료</h5>
		    <p class="card-text fw-bold text-center">회원탈퇴가 완료되었습니다.</p>
		    <div class="d-flex justify-content-center">
		    	<input type="button" value="홈으로" class="btn btn-primary"
			 onclick="location.href='${pageContext.request.contextPath}/main/main.do'">
			</div>
		  </div>
		</div>
		<div class="col"></div>
	</div>
</div>	
</div>	
</body>
</html>
</c:if>
<c:if test="${!check}">
	<script>
		alert('입력한 정보가 정확하지 않습니다!');
		history.go(-1);
	</script>
</c:if>






