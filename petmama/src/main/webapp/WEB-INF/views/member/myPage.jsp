<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>My페이지</title>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.6.0.min.js"></script>
<script type="text/javascript">
$(function(){
	$('#photo_btn').click(function(){
		$('#photo_choice').show();
		$(this).hide();//수정버튼 감추기	
	});
	
	//이미지 미리 보기
	//처음 화면에 보여지는 이미지 읽기
	let photo_path = $('.my-photo').attr('src');
	$('#photo').change(function(){
		let my_photo = this.files[0];
		if(!my_photo){
			//선택을 취소하면 원래 처음 화면으로 되돌림
			$('.my-photo').attr('src',photo_path);
			return;
		}
		if(my_photo.size > 1024 * 1024){
			alert(Math.round(my_photo.size/1024)
					+ 'kbytes(1024kbytes까지만 업로드 가능)');
			$('.my-photo').attr('src',photo_path);
			$(this).val('');//선택한 파일 정보 지우기
			return;
		}
		
		//화면에서 이미지 미리 보기
		const reader = new FileReader();
		reader.readAsDataURL(my_photo);
		
		reader.onload=function(){
			$('.my-photo').attr('src',reader.result);
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
					photo_path = $('.my-photo').attr('src');
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
	$('.my-photo').attr('src',photo_path);//이미지 미리보기 전 이미지로 되돌리기
	$('#photo').val('');
	$('#photo_choice').hide();
	$('#photo_btn').show();//수정 버튼 표시
	});
});
</script>
</head>

<!-- header 시작 -->
	<jsp:include page="/WEB-INF/views/common/header.jsp"/>
<!-- header 끝 -->
<!-- side bar 시작 -->
	<jsp:include page="/WEB-INF/views/common/sidebar.jsp"/>
<!-- side bar 끝 -->
<body>
<div class="page-main d-flex justify-content-around">
	<div class="content-main">
		<br><br>
		<h2 class="text-center fw-bold">회원정보</h2>
		<br>
		<br>
		<div class="mypage-div gird">
		<div class="container-fluid bg-dark text-white" style="padding:100px 20px;">
		
		<h3 class="fw-bold">${member.pet_name}의 동반자, ${member.mem_nickname}님!</h3>
		<br><br>
		<div class="row">
			
			<ul class="col-md-6 list-unstyled d-flex justify-content-center">
				<li class="d-none d-lg-inline">
					<c:if test="${empty member.pet_photo}">
					<img src="${pageContext.request.contextPath}/images/face.png" 
					                  width="150" height="150" class="my-photo">
					</c:if>
					<c:if test="${!empty member.pet_photo}">
					<img src="${pageContext.request.contextPath}/upload/${member.pet_photo}"
					                  width="150" height="150" class="my-photo">
					</c:if>
				</li>
				<li>
					<div>
						<input type="button" value="수정" id="photo_btn"
						 class="btn btn-primary btn-block btn-sm m-t-md">
					</div>
					<div id="photo_choice" style="display:none;">
						<input type="file" id="photo" 
						  accept="image/gif,image/png,image/jpeg"><br>
						<input type="button" value="전송" id="photo_submit"
						 class="btn btn-primary btn-block btn-sm m-t-md">
						<input type="button" value="취소" id="photo_reset"
						 class="btn btn-primary btn-block btn-sm m-t-md">	
					</div>
				</li>
			</ul>
			
			<div class="col-md-6">
				<h5 class="text-center" style="font-family: sans-serif;">♡ 펫 정보 ♡</h5>	
				<div class="card mx-auto" style="width:18rem;">
				<ul class="list-group list-unstyled">
					<li class="list-group-item">펫이름 : ${member.pet_name}</li>
					<li class="list-group-item">펫나이 : ${member.pet_age}</li>				
					<c:if test="${!empty member.mem_mdate}">
					<li>최근 정보 수정일 : ${member.mem_mdate}</li>
					</c:if>
					</ul>
					</div>
					</div>
				</div>
				
			</div>
		
			<br><br><br><br><hr>
			
			</div>
			
			<br><br><br><br>
			
			<h4 class="fw-bold text-center" style="font-family: sans-serif;">
				회원 상세정보
				<input type="button" value="상세정보 수정"  class="btn btn-dark btn-block btn-sm m-t-md"
				 onclick="location.href='modifyUserForm.do'">
			</h4>
			<div class="card mx-auto" style="width:50rem;">
			<ul class="list-group list-unstyled">
				<li class="list-group-item">이름 : ${member.mem_name}</li>
				<li class="list-group-item">닉네임 : ${member.mem_nickname}</li>				
				<li class="list-group-item">전화번호 : ${member.mem_cell}</li>
				<li class="list-group-item">이메일 : ${member.mem_email}</li>
				<li class="list-group-item">우편번호 : ${member.mem_zipcode}</li>
				<li class="list-group-item">주소 : ${member.mem_address1} ${member.mem_address2}</li>
				<li class="list-group-item">가입일 : ${member.mem_rdate}</li>
				<li class="list-group-item">
					<p class="fw-bold">
					비밀번호 수정
					<input type="button" value="비밀번호 수정"  class="btn btn-primary btn-block btn-sm m-t-md"
					       onclick="location.href='modifyPasswordForm.do'">
					</p></li>	
				<c:if test="${!empty member.mem_mdate}">
				<li>최근 정보 수정일 : ${member.mem_mdate}</li>
				</c:if>
				</ul>
				</div>
								
			
			
		<br><br><br><br><hr>
		<br><br><br><br>
		
		
		<div class="mypage-div">
		
		
			<h4 class="fw-bold text-center">스크랩한 자유게시물 목록</h4>
			<table class="table table-striped">
				<thead class="thead-dark">
				<tr>
					<th class="text-center" scope="col">제목</th>
					<th scope="col">작성자</th>
					<th scope="col">등록일</th>
				</tr>
				</thead>
				<tbody>
				<c:forEach var="board" items="${boardList}">
				<tr>
					<td class="text-center">
					<a href="${pageContext.request.contextPath}/board/detail.do?board_num=${board.board_num}" 
					target="_blank">${fn:substring(board.title,0,12)}</a></td>
					<td>${board.mem_nickname}</td>
					<td>${board.reg_date}</td>
				</tr>
				</c:forEach>
				</tbody>
			</table>
			
			<br><br>
			
			<h4 class="fw-bold text-center">스크랩한 후기게시물 목록</h4>
			<table class="table table-striped">
				<thead class="thead-dark">
				<tr>
					<th class="text-center" scope="col">제목</th>
					<th class="text-center" scope="col">작성자</th>
					<th class="text-center" scope="col">등록일</th>
				</tr>
				</thead>
				<tbody>
				<c:forEach var="board2" items="${boardList2}">
				<tr>
					<td class="text-center">
					<a href="${pageContext.request.contextPath}/board2/detail2.do?board_num=${board2.board_num}" 
					target="_blank">${fn:substring(board2.title,0,12)}</a></td>
					<td class="text-center">${board2.mem_nickname}</td>
					<td class="text-center">${board2.reg_date}</td>
				</tr>
				</c:forEach>
				</tbody>
			</table>
		
		</div>

		<br><br><br><br><hr>
		<br><br><br><br>
		
		<p class="btn btn-sm">
		회원탈퇴
		<input type="button" value="회원탈퇴"
				  onclick="location.href='deleteUserForm.do'">    
		</p>
		
		
	</div>
</div>
</div>
</body>
</html>



