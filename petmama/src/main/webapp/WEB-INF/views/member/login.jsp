<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<c:choose>
	<c:when test="${mem_auth == 1}">
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인 정보</title>
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
		    <h5 class="card-title text-center">회원 정보</h5>
		    <p class="card-text fw-bold text-center">정지된 회원 아이디입니다.</p>
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
	</c:when>
	<%--mem_auth가 1이 아닌 경우 --%>
	<c:otherwise>
		<script type="text/javascript">
			alert('아이디 또는 비밀번호가 불일치합니다.');
			history.go(-1);
		</script>
		
	</c:otherwise>
</c:choose>	