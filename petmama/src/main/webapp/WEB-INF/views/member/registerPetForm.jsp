<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입</title>
<!-- Bootstrap CSS -->
<link rel="stylesheet"
	href="http://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css">
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.6.0.min.js"></script>
<script type="text/javascript">
	$(function(){
		let idChecked=0; //0은 중복체크 미실행 또는 중복, 1은 미중복
	//아이디 중복체크
	$('#id_check').click(function(){
		if(!/^[A-Za-z0-9]{4,12}$/.test($('#id').val())){
			alert('영문 또는 숫자 사용 최소 4자 ~ 최대 12자를 사용하세요');
			$('#id').val('').focus();
			return false;
			}
			
			//서버와 통신
			$.ajax({
				url:'checkDuplicatedId.do',
				type:'post',
				data:{mem_id:$('#id').val()},
				dataType:'json',
				success:function(param){
					if(param.result == 'idNotFound'){
						idChecked = 1; //미중복
						$('#message_id').css('color','#000000').text('등록 가능ID');
					}else if(param.result == 'idDuplicated'){
						idChecked = 0; //중복
						$('#message_id').css('color','red').text('중복된 ID');
						$('#id').val('').focus();
					}else{
						idChecked = 0;
						alert('아이디 중복 체크 오류 발생');
					}
				},
				error:function(){
					idChecked=0;
					alert('네트워크 오류 발생');
				}
			})
			
		});//end of click
		
		//아이디 중복 안내 메시지 초기화 및 아이디 중복 값 초기화
		$('#register_form #id').keydown(function(){
			idChecked = 0;
			$('#message_id').text('');
		});//end of keydown
		
		//회원 정보 등록 유효성 체크
		$('#register_form').submit(function(){
			let items = document.querySelectorAll('.input-check');
			for(let i =0;i<items.length;i++){
				if(items[i].value.trim()==''){
					let label = document.querySelector('label[for="'+items[i].id+'"]')
					alert(label.textContext + ' 항목은 필수 입력');
					items[i].value='';
					items[i].focus();
					return false;
				}//end of if
				
				if(items[i].id=='id' && !/^[A-Za-z0-9]{4,12}$/.test($('#id').val())){
					alert('영문 또는 숫자 사용, 최소 4자 ~ 최대 12자를 사용하세요');
					$('#id').val('').focus();
					return false;
				}
				
				if(items[i].id=='id' && idChecked==0){
					alert('아이디 중복체크 필수');
					return false;
				}
				
				if(items[i].id== 'zipcode'&& !/^[0-9]{5}$/.test($('#zipcode').val())){
					alert('우편번호를 입력하세요(숫자 5자리)');
					$('#zipcode').val('').focus();
					return false;
				}
				
			}//end fo for
		});//end of submit
		
	});

</script> 
</head>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!-- header 시작 -->
	<jsp:include page="/WEB-INF/views/common/header.jsp"/>
<!-- header 끝 -->
<!-- sidebar 시작 -->
	<jsp:include page="/WEB-INF/views/common/sidebar.jsp"/>
<!-- sidebar 끝 -->

</body>
<body>  
<div class="page-main">
	<div class="content-main">
	<div class="container">
	<br>

		 <h2>회원가입</h2>
		 <br>
		 <br>
		   <div class="col-8 col8md-4">
         
			<form id="register_form" accept-charset="UTF-8" role="form" action="registerUser.do" method="post">
			
				<legend>펫정보</legend>
				
				<br>
				<br>
				
				<div class="form-group">
				
				<div class="form-floating mb-3">
					<input type="text" name="pet_name" id="pet_name" maxlength="12" 
						class="input-check form-control rounded-3 bg-body-tertiary border-0" placeholder="펫 이름">
					<label for="pet_name">펫 이름</label>
				</div>	
						
				<div class="form-floating mb-3">
					<input type="text" name="pet_age" id="pet_age" maxlength="10" 
						class="input-check form-control rounded-3 bg-body-tertiary border-0" placeholder="펫 나이">
					<label for="pet_age">펫 나이</label>
				</div>	
				
				<div class="form-floating mb-3">
					<input type="file" name="pet_photo" id="pet_photo" 
					accept="image/gif,image/png,image/jpeg" class="input-check form-control rounded-3 bg-body-tertiary border-0"
					placeholder="image">
					<label for="pet_photo">펫 사진</label>
				</div>	
				
				
				
				<div class="form-floating mb-3">
						<input type="radio" name="pet_note" value="3" 
							id="note3" <c:if test="${member.pet_note == 3}"></c:if>>산책
					<input type="radio" name="pet_note" value="4" 
							id="note4" <c:if test="${member.pet_note == 4}"></c:if>>돌봄
					<input type="radio" name="pet_note" value="5" 
							id="note5" <c:if test="${member.pet_note == 5}"></c:if>>둘 다
					<label for="mem_email">희망 반려생활</label>
				</div>
			
			
				</div>	
					
				<div class="form-group">
				 	<div class="align-center">
				<input type="submit" value="등록">
				<input type="button" value="홈으로" onclick="${pageContext.request.contextPath}/main/main.do">
					</div>
	            </div>
	           
			</form>

			</div>
		</div>
	</div>
</div>
</body>
</html>