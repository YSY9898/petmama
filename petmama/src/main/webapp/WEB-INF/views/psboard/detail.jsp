<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>펫시터 상세 프로필</title>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/petsitter/style.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/petsitter/jquery.datetimepicker.css">
</head>
<body>

<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.6.0.min.js"></script>
<script src="${pageContext.request.contextPath}/js/jquery.datetimepicker.full.min.js"></script>
<div class="page-main">
	<jsp:include page="/WEB-INF/views/common/header.jsp"/>
	<input type="text" id="datetimepicker" name="date">
	<script>
		$('#datetimepicker').datetimepicker();
	</script>
	
	<input type="text" id="datetimepicker5" name="date5">
	<script>
		jQuery('#datetimepicker5').datetimepicker({
  	  	datepicker:false,
   	 	allowTimes:[
        	'12:00','13:00','15:00'
    	]
	});
</script>
</div>
</body>
</html>