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
<script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/js/bootstrap.bundle.min.js" type="text/javascript"></script>
<script type = "text/javascript">
$(document).ready(function(){
	$("input[name='time_option']").change(function(){
		var option = $("input[name='time_option']:checked").val();
		
		time = ${time}.split(':');
		
		if(option == "0"){
			$('#end_time').text();
		}else if(option == "1"){
			$('#end_time').text('값2');
		}else if(option == "2"){
			$('#end_time').text('값3');
		}
	});
});
function AddMin(time, min) {
	
    return result;
}
</script>
<div class="page_main">
	<jsp:include page="/WEB-INF/views/common/header.jsp"/>
	<div class="content-main">
		<h4>펫시터 예약하기</h4>
		<form>
			<ul>
				<li>
					<label>예약 방식</label>
					<input type="radio" name="visit_status" value="0" checked>펫시터 집으로 부르기
					<input type="radio" name="visit_status"	value="1">펫시터 집에 맡기기
				</li>
				<li>
					<div>시작 시간 : ${time}</div>
				</li>
				<li>
					
				</li>
			</ul>
		</form>
	</div>
</div>
</body>
</html>