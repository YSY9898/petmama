<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입 완료</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head> 
<body>
<div class="page-main">
	<jsp:include page="/WEB-INF/views/common/header.jsp"/>
	<div class="content-main">
		<div class="result-display">
			<div class="align-center">
				회원가입이 완료되었습니다.
				<p>
				<input type="button" value="홈으로" class="btn btn-primary btn-block btn-sm m-t-md"
						onclick="location.href='${pageContext.request.contextPath}/main/main.do'">
			</div>
		</div>
	</div>

</div>
</body>
</html>


