<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>My페이지</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.6.0.min.js"></script>
<script type="text/javascript">
$(function(){
	$('#photo_btn').click(function(){
		$('#photo_choice').show();
		$(this).hide();//수정버튼 감추기	
	});
	
	//이미지 미리 보기
	//처음 화면에 보여지는 이미지 읽기
	let photo_path = $('.pet-photo').attr('src');
	$('#photo').change(function(){
		let pet_photo = this.files[0];
		if(!pet_photo){
			//선택을 취소하면 원래 처음 화면으로 되돌림
			$('.pet-photo').attr('src',photo_path);
			return;
		}
		if(pet_photo.size > 1024 * 1024){
			alert(Math.round(pet_photo.size/1024)
					+ 'kbytes(1024kbytes까지만 업로드 가능)');
			$('.pet-photo').attr('src',photo_path);
			$(this).val('');//선택한 파일 정보 지우기
			return;
		}
		
		//화면에서 이미지 미리 보기
		const reader = new FileReader();
		reader.readAsDataURL(my_photo);
		
		reader.onload=function(){
			$('.pet-photo').attr('src',reader.result);
		};
	});//end of change
	
	//이미지 전송
	$('#photo_submit').click(function(){
		if($('#photo').val()==''){
			alert('파일을 선택하세요');
			$('#photo').focus();
			return;
		}
		//파일 전송
		const form_data = new FormData();
		/*
		자바스크립트로 호출 doxument.getElementById('photo').files[0]
		jquery로 호출 $('#photo')[0].files[0]
		*/
		form_data.append('photo',$('#photo')[0].files[0]);
		$.ajax({
			url:'updatePetPhoto.do',
			type:'post',
			data:form_data,
			dataType:'json',
			contentType:false, //데이터 객체를 문자열로 바꿀지에 대한 값. true 일반문자
			processData:false, //해당 타입을 true로 하면 일반 text로 구분
			success:function(param){
				if(param.result == 'logout'){
					alert('로그인 후 사용하세요');	
				}else if(param.result == 'success'){
					alert('프로필 사진이 수정 되었습니다');
					//수정된 이미지 정보 저장
					photo_path = $('.pet-photo').attr('src');
					$('#photo').val('');
					$('#photo_choice').hide('');
					$('#photo_btn').show('');//수정 버튼 표시
				}else{
					alert('파일 전송 오류 발생');
				}
			},
			error:function(){
				alert('네트워크 오류 발생');
			}
		});
	}); //end of click
	
	//이미지 미리보기 취소
	$('#photo_reset').click(function(){
		//초기 이미지 표시
	$('.pet-photo').attr('src',photo_path);//이미지 미리보기 전 이미지로 되돌리기
	$('#photo').val('');
	$('#photo_choice').hide();
	$('#photo_btn').show();//수정 버튼 표시
	});
});
</script>
</head>
<body>
<div class="page-main">
	<jsp:include page="/WEB-INF/views/common/header.jsp"/>
	<div class="content-main">
		<h2>회원정보</h2>
		<div class="mypage-div">
			<h3>펫 사진</h3>
			<ul>
				<li>
					<c:if test="${empty member.pet_photo}">
					<img src="${pageContext.request.contextPath}/images/face.png" 
					                  width="200" height="200" class="pet-photo">
					</c:if>
					<c:if test="${!empty member.pet_photo}">
					<img src="${pageContext.request.contextPath}/upload/${member.pet-photo}"
					                  width="200" height="200" class="pet-photo">
					</c:if>
				</li>
				<li>
					<div class="align-center">
						<input type="button" value="수정" id="photo_btn">
					</div>
					<div id="photo_choice" style="display:none;">
						<input type="file" id="pet_photo" 
						  accept="image/gif,image/png,image/jpeg"><br>
						<input type="button" value="전송" id="photo_submit">
						<input type="button" value="취소" id="photo_reset">  
					</div>
				</li>
			</ul>
			<h3>
				상세정보
				<input type="button" value="상세정보 수정"
				 onclick="location.href='modifyUserForm.do'">
			</h3>
			<ul>
				<li>이름 : ${member.mem_name}</li>
				<li>닉네임 : ${member.mem_nickname}</li>				
				<li>전화번호 : ${member.mem_cell}</li>
				<li>이메일 : ${member.mem_email}</li>
				<li>우편번호 : ${member.mem_zipcode}</li>
				<li>주소 : ${member.mem_address1} ${member.mem_address2}</li>
				<li>가입일 : ${member.mem_rdate}</li>
				<c:if test="${!empty member.mem_mdate}">
				<li>최근 정보 수정일 : ${member.mem_mdate}</li>
				</c:if>
			</ul>
			<h3>
				비밀번호 수정
				<input type="button" value="비밀번호 수정"
				       onclick="location.href='modifyPasswordForm.do'">
			</h3>
			<h3>
				회원탈퇴
				<input type="button" value="회원탈퇴"
				      onclick="location.href='deleteUserForm.do'">
			</h3>
		</div>
		<div class="mypage-div">
			<h3>저장한 게시물 목록</h3>
			<table>
				<tr>
					<th>제목</th>
					<th>작성자</th>
					<th>등록일</th>
				</tr>
				<c:forEach var="board" items="${boardList}">
				<tr>
					<td><a href="${pageContext.request.contextPath}/board/detail.do?board_num=${board.board_num}" target="_blank">${fn:substring(board.title,0,12)}</a></td>
					<td>${board.mem_nickname}</td>
					<td>${board.reg_date}</td>
				</tr>
				</c:forEach>
			</table>
		</div>
	</div>
</div>
</body>
</html>



