<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>펫시터 상세 프로필</title>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/petsitter/style.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/petsitter/jquery.datetimepicker.css">
<link rel="stylesheet" href="//code.jquery.com/ui/1.13.2/themes/base/jquery-ui.css">
</head>
<body>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.6.0.min.js"></script>
<script src="${pageContext.request.contextPath}/js/jquery.datetimepicker.full.min.js"></script>
<script src="https://code.jquery.com/ui/1.13.2/jquery-ui.js"></script>
<script>
  $( function() {
	  $('#datepicker').datepicker({ 
		  dateFormat:'yy-mm-dd',
		  closeText: "닫기",
		  currentText: "오늘",
		  prevText: '이전 달',
		  nextText: '다음 달',
		  monthNames: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'],
		  monthNamesShort: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'],
		  dayNames: ['일', '월', '화', '수', '목', '금', '토'],
		  dayNamesShort: ['일', '월', '화', '수', '목', '금', '토'],
		  dayNamesMin: ['일', '월', '화', '수', '목', '금', '토'],
		  weekHeader: "주",
		  yearSuffix: '년',
		  onSelect: function(dateString) {
		       $("#date").val(dateString);
	      }
	  });
   });
</script>
<div class="page-main">
	<jsp:include page="/WEB-INF/views/common/header.jsp"/>
	<form id="reserve_form" action="${pageContext.request.contextPath}/PSboard/reserveForm.do" method="post">
		<% int sis_num = Integer.parseInt(request.getParameter("sis_num")); %>

		<input type="hidden" id="sis_num" name="sis_num" value=<%=sis_num%>>
		<input type="text" id="datetimepicker" name="date2">
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
		
		<!-- 제가 추가한거 -->
		<p>예약날짜 : <input type="text" id="date" name="date"></p>
		<div id="datepicker"></div>
		<!-- 제가 추가한거 끝 -->
		
		<input type="submit" value="예약하기">
	</form>
</div>
</body>
</html>