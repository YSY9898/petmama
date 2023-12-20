<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>비밀번호 수정</title>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.6.0.min.js"></script>
<script type="text/javascript">
$(function(){
	//이벤트 연결
	$('#password_form').submit(function(){
		let items = document.querySelectorAll(
				'input[type="text"],input[type="password"]');
		for(let i=0;i<items.length;i++){
			if(items[i].value.trim()==''){
				let label = document.querySelector(
				           'label[for="'+items[i].id+'"]');
				alert(label.textContent + ' 항목은 필수 입력');
				items[i].value = '';
				items[i].focus();
				return false;
			}
		}
		
		if($('#passwd').val()!=$('#cpasswd').val()){
			alert('새비밀번호와 새비밀번호 확인이 불일치');
			$('#passwd').val('').focus();
			$('#cpasswd').val('');
			return false;
		}
	});
});
</script>
</head>
<body>
<div class="page-main">
	<jsp:include page="/WEB-INF/views/common/header.jsp"/>
	<div class="content-main">
	<div class="container d-flex justify-content-center">
	<br>
	
	<div class="col-6 col6md-4">
		<form action="modifyPassword.do" method="post" id="password_form">
		<br><br><br><br><br><br>
			<h4 class="fw-bold">비밀번호 수정</h4>
			<br><br>
			
			<ul class="list-unstyled">
				<li class="form-floating mb-3">
					<input type="text" name="mem_id" id="mem_id" maxlength="12"  value="${member.mem_id}"
						class="input-check form-control rounded-3 bg-body-tertiary border-0" placeholder="ID">
					<label for="mem_id">아이디</label>
				</li>
				
				<li class="form-floating mb-3">
					<input type="password" name="origin_passwd" id="origin_passwd" maxlength="12"  
					value="${member.origin_passwd}" placeholder="현재 비밀번호"
					class="input-check form-control rounded-3 bg-body-tertiary border-0" >
					<label for="origin_passwd">현재 비밀번호</label>
				</li>
				
				<li class="form-floating mb-3">
					<input type="password" name="passwd" id="passwd" maxlength="12"  
					value="${member.passwd}" placeholder="새 비밀번호"
					class="input-check form-control rounded-3 bg-body-tertiary border-0" >
					<label for="origin_passwd">새비밀번호</label>
				</li>
				
				<li class="form-floating mb-3">
					<input type="password" name="cpasswd" id="cpasswd" maxlength="12"  
					value="${member.cpasswd}" placeholder="새 비밀번호"
					class="input-check form-control rounded-3 bg-body-tertiary border-0" >
					<label for="ㅊpasswd">새비밀번호 확인</label>
				</li>
			</ul> 
			<br>
			<div class="align-center">
				<input type="submit" value="비밀번호 수정" class="btn btn-primary">
				<input type="button" value="My페이지" class="btn btn-primary"
				                   onclick="location.href='myPage.do'">
			</div>                          
		</form>
	</div>
</div>
</div>
</div>
</body>
</html>



