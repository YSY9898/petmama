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
</head>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!-- header 시작 -->
	<jsp:include page="/WEB-INF/views/common/header.jsp"/>
<!-- header 끝 -->
<!-- sidebar 시작 -->
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
			
				<li><p>펫정보</p></li>
				
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