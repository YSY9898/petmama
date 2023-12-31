<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입</title>
<!-- Bootstrap CSS -->
<script type="text/javascript"
	src="${pageContext.request.contextPath}/js/jquery-3.6.0.min.js"></script>
<script type="text/javascript">
	$(function(){
		let idChecked=0; //0은 중복체크 미실행 또는 중복, 1은 미중복
	//아이디 중복체크
	$('#id_check').click(function(){
		if(!/^[A-Za-z0-9]{4,12}$/.test($('#mem_id').val())){
			alert('영문 또는 숫자 사용 최소 4자 ~ 최대 12자를 사용하세요');
			$('#mem_id').val('').focus();
			return false;
			}
			
			//서버와 통신
			$.ajax({
				url:'checkDuplicatedId.do',
				type:'post',
				data:{id:$('#mem_id').val()},
				dataType:'json',
				success:function(param){
					if(param.result == 'idNotFound'){
						idChecked = 1; //미중복
						$('#message_id').css('color','#000000').text('등록 가능ID');
					}else if(param.result == 'idDuplicated'){
						idChecked = 0; //중복
						$('#message_id').css('color','red').text('중복된 ID');
						$('#mem_id').val('').focus();
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
<jsp:include page="/WEB-INF/views/common/header.jsp" />
<!-- header 끝 -->
</body>
<body>
	<div class="page-main">
		<div class="content-main">
			<div class="container d-flex justify-content-center">
				<div class="col-8 col8md-4">
					<form id="register_form" accept-charset="UTF-8" role="form"
						action="registerUser.do" method="post">
						<h2>회원가입</h2>
						<br>
						<h4 class="fw-bold">회원정보</h4>

						<br>

						<div class="form-group">

							<div class="form-floating mb-3">
								<input type="text" name="mem_id" id="mem_id" maxlength="12"
									autocomplete="off"
									class="input-check form-control rounded-3 bg-body-tertiary border-0"
									placeholder="ID"> <label for="mem_id">ID</label> <span
									class="input-group-btn">
									<button class="btn btn-primary" type="button" id="id_check">ID중복체크</button>
									<span id="message_id"></span>
								</span>


								<div class="form-notice">*영문 또는 숫자(4자~12자)</div>
							</div>

							<div class="form-floating mb-3">
								<input type="text" name="mem_name" id="mem_name" maxlength="12"
									class="input-check form-control rounded-3 bg-body-tertiary border-0"
									placeholder="이름"> <label for="mem_name">이름</label>
							</div>

							<div class="form-floating mb-3">
								<input type="text" name="mem_nickname" id="mem_nickname"
									maxlength="12"
									class="input-check form-control rounded-3 bg-body-tertiary border-0"
									placeholder="닉네임"> <label for="mem_nickname">닉네임</label>
							</div>

							<div class="form-floating mb-3">
								<input type="password" name="mem_pw" id="mem_pw" maxlength="12"
									class="input-check form-control rounded-3 bg-body-tertiary border-0"
									placeholder="password"> <label for="mem_pw">비밀번호</label>
							</div>

							<br>
							<hr>
							<br>

							<div class="form-floating mb-3">
								<input type="text" name="mem_cell" id="mem_cell" maxlength="15"
									class="input-check form-control rounded-3 bg-body-tertiary border-0"
									placeholder="phone"> <label for="mem_cell">전화번호</label>
							</div>

							<div class="form-floating mb-3">
								<input type="text" name="mem_email" id="mem_email"
									maxlength="30"
									class="input-check form-control rounded-3 bg-body-tertiary border-0"
									placeholder="name@example.com"> <label for="mem_email">이메일</label>
							</div>

							<br>
							<hr>
							<br>

							<div class="form-floating mb-3">
								<input type="text" name="mem_zipcode" id="zipcode" maxlength="5"
									autocomplete="off"
									class="input-check form-control rounded-3 bg-body-tertiary border-0"
									placeholder="우편번호"> <label for="zipcode">우편번호</label> <input
									type="button" onclick="execDaumPostcode()" value="우편번호 찾기"
									class="btn btn-primary">
							</div>

							<div class="form-floating mb-3">
								<input type="text" name="mem_address1" id="address1"
									maxlength="30"
									class="input-check form-control rounded-3 bg-body-tertiary border-0"
									placeholder="주소"> <label for="address1">주소</label>
							</div>

							<div class="form-floating mb-3">
								<input type="text" name="mem_address2" id="address2"
									maxlength="30"
									class="input-check form-control rounded-3 bg-body-tertiary border-0"
									placeholder="mem_address2"> <label for="address2">나머지
									주소</label>
							</div>

							<br>

							<div class="alert alert-secondary">
								※위 방법으로 인증이 불가능할 경우, 고객센터로 연락 주시면 회원가입을 도와드리겠습니다.<br> *메일
								문의 및 전화 문의는 하단에 명시된 고객센터 정보를 확인해 주세요.
							</div>
						</div>

						<br>
						<br>
						<br>
						<hr>
						<br>
						<br>
						<br>

						<h4 class="fw-bold">펫 정보</h4>

						<br>
						<br>

						<div class="form-group">
							<div class="form-floating mb-3">
								<input type="text" name="pet_name" id="pet_name" maxlength="12"
									class="input-check form-control rounded-3 bg-body-tertiary border-0"
									placeholder="펫 이름"> <label for="pet_name">펫 이름</label>
							</div>

							<div class="form-floating mb-3">
								<input type="text" name="pet_age" id="pet_age" maxlength="10"
									class="input-check form-control rounded-3 bg-body-tertiary border-0"
									placeholder="펫 나이"> <label for="pet_age">펫 나이</label>
							</div>

							<div class="form-floating mb-3">
								<input type="file" name="pet_photo" id="pet_photo"
									accept="image/gif,image/png,image/jpeg"
									class="input-check form-control rounded-3 bg-body-tertiary border-0"
									placeholder="image"> <label for="pet_photo">펫
									사진</label>
							</div>

							<br>

							<div>
								<label for="mem_email">희망 반려생활</label> <br> <input
									type="radio" name="pet_note" value="3" id="note3"
									<c:if test="${member.pet_note == 3}"></c:if>>산책 <input
									type="radio" name="pet_note" value="4" id="note4"
									<c:if test="${member.pet_note == 4}"></c:if>>돌봄 <input
									type="radio" name="pet_note" value="5" id="note5"
									<c:if test="${member.pet_note == 5}"></c:if>>둘 다
							</div>

						</div>

						<br>
						<br>
						<br>

						<div class="form-group">
							<div class="align-center">
								<input type="submit" value="등록" class="btn btn-primary">
								<a href="${pageContext.request.contextPath}/main/main.do"><input
									type="button" value="홈으로" class="btn btn-primary"
									>
									</a>
								<br>
								<br>
								<br>
							</div>
						</div>

					</form>

				</div>
			</div>

			<!-- 우편번호 검색 시작 -->
			<!-- iOS에서는 position:fixed 버그가 있음, 적용하는 사이트에 맞게 position:absolute 등을 이용하여 top,left값 조정 필요 -->
			<div id="layer"
				style="display: none; position: fixed; overflow: hidden; z-index: 1; -webkit-overflow-scrolling: touch;">
				<img src="//t1.daumcdn.net/postcode/resource/images/close.png"
					id="btnCloseLayer"
					style="cursor: pointer; position: absolute; right: -3px; top: -3px; z-index: 1"
					onclick="closeDaumPostcode()" alt="닫기 버튼">
			</div>

			<script
				src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
			<script>
    // 우편번호 찾기 화면을 넣을 element
    var element_layer = document.getElementById('layer');

    function closeDaumPostcode() {
        // iframe을 넣은 element를 안보이게 한다.
        element_layer.style.display = 'none';
    }

    function execDaumPostcode() {
        new daum.Postcode({
            oncomplete: function(data) {
                // 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

                // 각 주소의 노출 규칙에 따라 주소를 조합한다.
                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                var addr = ''; // 주소 변수
                var extraAddr = ''; // 참고항목 변수

                //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
                if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                    addr = data.roadAddress;
                } else { // 사용자가 지번 주소를 선택했을 경우(J)
                    addr = data.jibunAddress;
                }

                // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
                if(data.userSelectedType === 'R'){
                    // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                    // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                    if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                        extraAddr += data.bname;
                    }
                    // 건물명이 있고, 공동주택일 경우 추가한다.
                    if(data.buildingName !== '' && data.apartment === 'Y'){
                        extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                    }
                    // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                    if(extraAddr !== ''){
                        extraAddr = ' (' + extraAddr + ')';
                    }
                    //(주의)address1에 참고항목이 보여지도록 수정
                    // 조합된 참고항목을 해당 필드에 넣는다.
                    //(수정) document.getElementById("address2").value = extraAddr;
                
                } 
                //(수정) else {
                //(수정)    document.getElementById("address2").value = '';
                //(수정) }

                // 우편번호와 주소 정보를 해당 필드에 넣는다.
                document.getElementById('zipcode').value = data.zonecode;
                //(수정) + extraAddr를 추가해서 address1에 참고항목이 보여지도록 수정
                document.getElementById("address1").value = addr + extraAddr;
                // 커서를 상세주소 필드로 이동한다.
                document.getElementById("address2").focus();

                // iframe을 넣은 element를 안보이게 한다.
                // (autoClose:false 기능을 이용한다면, 아래 코드를 제거해야 화면에서 사라지지 않는다.)
                element_layer.style.display = 'none';
            },
            width : '100%',
            height : '100%',
            maxSuggestItems : 5
        }).embed(element_layer);

        // iframe을 넣은 element를 보이게 한다.
        element_layer.style.display = 'block';

        // iframe을 넣은 element의 위치를 화면의 가운데로 이동시킨다.
        initLayerPosition();
    }

    // 브라우저의 크기 변경에 따라 레이어를 가운데로 이동시키고자 하실때에는
    // resize이벤트나, orientationchange이벤트를 이용하여 값이 변경될때마다 아래 함수를 실행 시켜 주시거나,
    // 직접 element_layer의 top,left값을 수정해 주시면 됩니다.
    function initLayerPosition(){
        var width = 300; //우편번호서비스가 들어갈 element의 width
        var height = 400; //우편번호서비스가 들어갈 element의 height
        var borderWidth = 5; //샘플에서 사용하는 border의 두께

        // 위에서 선언한 값들을 실제 element에 넣는다.
        element_layer.style.width = width + 'px';
        element_layer.style.height = height + 'px';
        element_layer.style.border = borderWidth + 'px solid';
        // 실행되는 순간의 화면 너비와 높이 값을 가져와서 중앙에 뜰 수 있도록 위치를 계산한다.
        element_layer.style.left = (((window.innerWidth || document.documentElement.clientWidth) - width)/2 - borderWidth) + 'px';
        element_layer.style.top = (((window.innerHeight || document.documentElement.clientHeight) - height)/2 - borderWidth) + 'px';
    }
</script>
			<!-- 우편번호 검색 끝 -->

		</div>
	</div>
</body>
</html>