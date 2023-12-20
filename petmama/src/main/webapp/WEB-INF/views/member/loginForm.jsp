<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인</title>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/js/jquery-3.6.0.min.js"></script>
<script type="text/javascript">
	$(function() {
		$('#login_form').submit(function() {
			if ($('#id').val().trim() == '') {
				alert('아이디를 입력하세요');
				$('#id').val('').focus();
				return false;
			}
			if ($('#passwd').val().trim() == '') {
				alert('비밀번호를 입력하세요');
				$('#passwd').val('').focus();
				return false;
			}
		});
	});
</script>
</head>
<body>
	<div>
		<jsp:include page="/WEB-INF/views/common/header.jsp" />
		<div class="content-main">
			<div class="container d-flex justify-content-center">
	<br>
	<div class="col-6 col6md-4">
			<form id="login_form" action="login.do" method="post">
			<br><br><br><br><br><br>
			<h4 class="fw-bold">로그인</h4>
			<br><br>
				<ul class="list-unstyled">
					<li class="form-floating mb-3">
						<input type="text" name="id" id="id" maxlength="12" 
						placeholder="ID" autocomplete="off"
						class="input-check form-control rounded-3 bg-body-tertiary border-0">
						<label for="id">아이디</label>
					</li>
					<li class="form-floating mb-3">
						<input type="password" name="passwd" id="passwd" maxlength="12"  
						value="${member.passwd}" placeholder="비밀번호"
						class="input-check form-control rounded-3 bg-body-tertiary border-0" >
						<label for="passwd">비밀번호</label>
					</li>
				</ul>
				<div class="align-center">
					<input type="submit" value="로그인" class="btn btn-primary">
					<input type="button" value="홈으로" class="btn btn-primary"
						onclick="location.href='${pageContext.request.contextPath}/main/main.do'">
				</div>
			</form>
		</div>
	</div>
</div>
</div>	
</body>
</html>