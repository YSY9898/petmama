<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>후기 상세 정보</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/customer/board/style.css">
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.6.0.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/board2.fav.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/board2.scrap.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/board2.reply.js"></script>
</head>
<body>

<jsp:include page="/WEB-INF/views/common/header.jsp"/>
<div class="page-main">
		
	<div class="main-margin">
		<h2>${board.title}</h2>
		<ul class="detail-info list-unstyled">
			<li>
				<c:if test="${!empty board2.photo}">
				<img src="${pageContext.request.contextPath}/upload/${board2.photo}" 
				                           width="40" height="40" class="my-photo">	
				</c:if>
				<c:if test="${empty board2.photo}">
				<img src="${pageContext.request.contextPath}/images/face.png" 
				                           width="40" height="40" class="my-photo">	
				</c:if>
			</li>	
			<li>
				<c:if test="${!empty board.mem_nickname}">${board.mem_nickname}</c:if>
				<c:if test="${empty board.mem_nickname}">${board.mem_id}</c:if>
				<br>
				조회 : ${board.hit}
			</li>
			<li class="detail-title float-right">
				작성일 : ${board.reg_date}<br>
					<c:if test="${!empty board.modify_date}">
						(최근 수정일 : ${board.modify_date})
					</c:if>
			</li>
		</ul>
			    
		<hr size="0" noshade="noshade" width="100%">
		<c:if test="${!empty board.filename}">
		<div class="align-center">
			<img src="${pageContext.request.contextPath}/upload/${board.filename}" class="detail-img">
		</div>
		</c:if>
		<p>
			${board.content}
		</p>
		<hr size="1" noshade="noshade" width="100%">
		<ul class="detail-ul-height list-unstyled">
			<li class="float-left detail-ul-fav" style="margin-right:50px">
					<%-- 스크랩 --%>
					<img id="output_scrap" data-num="${board.board_num}" src="${pageContext.request.contextPath}/images/scrap1.png" width="20">
					스크랩
			</li>
			<li class="float-left">
					<%-- 좋아요 --%>
					<img id="output_fav" data-num="${board.board_num}" src="${pageContext.request.contextPath}/images/like1.png" width="20">
					좋아요
					<span id="output_fcount"></span>
			</li>
			<li class="float-right" style="margin-left: auto; margin-right: auto;">
				작성일 : ${board.reg_date}
				<%-- 로그인한 회원번호와 작성자 회원번호가 일치해야 수정,삭제 가능 --%>
				<input type="button" value="목록" class="btn btn-primary btn-sm" 
					onclick="location.href='list2.do'">     
				<c:if test="${user_num == board.mem_num}">
				<input type="button" value="수정" class="btn btn-primary btn-sm"
				 	onclick="location.href='updateForm2.do?board_num=${board.board_num}'">
				<input type="button" value="삭제" id="delete_btn" class="btn btn-primary btn-sm">
				</c:if> 
				<script type="text/javascript">
						let delete_btn = document.getElementById('delete_btn');
						delete_btn.onclick=function(){
							let choice = confirm('삭제하시겠습니까?');
							if(choice){
								location.replace('delete.do?board_num=${board.board_num}');
							}
						};
				</script>	
			</li>	
		</ul>
		<!-- 댓글 시작 -->
		<div id="reply_div">
			<span class="re-title">댓글 달기</span>
			<form id="re_form">
				<input type="hidden" name="board_num" 
				 value="${board.board_num}" id="board_num">
				<textarea rows="3" cols="50" name="re_content"
				  id="re_content" class="rep-content"
				  <c:if test="${empty user_num}">disabled="disabled"</c:if>><c:if test="${empty user_num}">로그인해야 작성할 수 있습니다.</c:if></textarea>
				<c:if test="${!empty user_num}">
				<div id="re_second" class="float-right">
					<input type="submit" value="전송" class="list-btn">
				</div>
				<div id="re_first">
					<span class="letter-count">300/300</span>
				</div>   
				
				</c:if>
			</form>
		</div>
		<!-- 댓글 목록 출력 시작 -->
		<div id="output"></div>
		<div class="paging-button" style="display:none;">
			<input type="button" value="다음글 보기" class="list-btn">
		</div>
		<div id="loading" style="display:none;">
			<img src="${pageContext.request.contextPath}/images/loading.gif" width="50" height="50">
		</div>
		<!-- 댓글 목록 출력 끝 -->
		<!-- 댓글 끝 -->
	</div>
</div>
</body>
</html>