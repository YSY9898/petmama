<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/customer/qna/style.css">
<script type="text/javascript">
	function searchQNA(kind, page_num) {
		let keyfield = $("#keyfield").val();
		let keyword = $("#keyword").val();
		let pageNum = (page_num == "")? 1 : page_num;
		
		if(kind == "all") {
			keyfield = 1;
			keyword = "";
		} else if(kind == "mine") {
			keyfield = 3;
		}

		$.ajax({
			url : '${pageContext.request.contextPath}/customer/search.do',
			type : 'post',
			data : {
				"keyfield" : keyfield,
				"keyword" : keyword,
				"pageNum" : pageNum
			},
			dataType : 'json',
			success : function(param) {
				$(".qnaListUnit").remove();
				let qna_list = JSON.parse(param.list);
				let qna_page = JSON.parse(param.page);
				let new_html = "";
				
				qna_list.forEach((data, index, array) => {
				    new_html += "<tr class='qnaListUnit'>";
				    new_html += "<td>" + data['q_num'] + "</td>";
				    if(data['answer_yn'] == 'Y') {		
				    	new_html += "<td>답변완료</td>";
				    } else {
				    	new_html += "<td>답변대기중</td>";
				    }
				    if(data['hide_yn'] == 'Y') {				    	
				    	new_html += "<td><a href='javascript:void(0)' onclick='showQNA(" + data['q_num'] + ", this)'>" + data['title'] + "<img src='/petmama/images/customer/qna_lock.png' width='25' height='25'></td>";
				    } else {					    	
				    	new_html += "<td><a href='javascript:void(0)' onclick='showQNA(" + data['q_num'] + ", this)'>" + data['title'] + "</td>";
				    }
				    if(data['mem_id']) {
				    	new_html += "<td>" + data['mem_id'] + "</td>";
				    } else {
				    	new_html += "<td></td>";
				    }
				    new_html += "<td>" + data['reg_date'] + "</td>";
				    new_html += "</tr>";			
				});
				$(".qnaListSection").html(new_html);
				$(".align-center").html(qna_page['page']);
			},
			error : function() {
				alert('네트워크 오류 발생');
			}
		});
	}
	
	function getPage(page_num) {
		searchQNA('keyword', page_num);
	}
	
	function showQNA(q_num, obj) {	
		$.ajax({
			url : '${pageContext.request.contextPath}/customer/detail.do',
			type : 'post',
			data : {
				"q_num" : q_num,
				'pwd_chk' : 'N'
			},
			dataType : 'json',
			success : function(param) {
				if(param.result == "password") {
					$(".popup-container").hide();
					$(obj).parent().append($(".popup-container")[0].outerHTML);
					$(obj).parent().find(".popup-container .submit-button:eq(0)").attr("onclick","showSecretQNA(" + q_num + ", this)");
					$(obj).parent().find(".popup-container").show();
				} else if(param.result == "empty") {
					alert("열람 권한이 없습니다.");
				} else {
					let qna_content = JSON.parse(param.list);
					let qnaReply_content = JSON.parse(param.r_list);
					if($(obj).parent().find(".qnaContent").length > 0) {
						$(obj).parent().find(".qnaContent").remove();
					} else {
						$(obj).parent().append($(".qnaContent")[0].outerHTML);
						$(obj).parent().find(".qnaContent p:eq(0)").html(qna_content.content);
						if(qnaReply_content == null) {
							$(obj).parent().find(".qnaContent p:eq(1)").html("");	
							if(param.auth == '9') {
								$(obj).parent().find(".qnaContent .answerContent").show();
							}
						} else {
							$(obj).parent().find(".qnaContent p:eq(1)").html(qnaReply_content.qr_content);	
							$(obj).parent().find(".qnaContent .answerContent").hide();
						}
						$(obj).parent().find(".qnaContent").show();
					}
				}
			},
			error : function() {
				alert('네트워크 오류 발생');
			}
		});
	}
	
	function showSecretQNA(q_num, obj) {	
		let password = $(obj).parent().find(".password-input").val();
		console.log(password);
		$.ajax({
			url : '${pageContext.request.contextPath}/customer/detail.do',
			type : 'post',
			data : {
				"q_num" : q_num,
				"pwd_chk" : 'Y',
				'password' : password
			},
			dataType : 'json',
			success : function(param) {
				if(param.result == "empty") {
					alert("열람 권한이 없습니다.");
				} else {
					obj = $(obj).parents(".qnaListUnit").find("a");
					let qna_content = JSON.parse(param.list);
					let qnaReply_content = JSON.parse(param.r_list);
					console.log(qnaReply_content);
					if($(obj).parent().find(".qnaContent").length > 0) {
						$(obj).parent().find(".qnaContent").remove();
					} else {
						$(obj).parent().append($(".qnaContent")[0].outerHTML);
						$(obj).parent().find(".qnaContent p:eq(0)").html(qna_content.content);
						if(qnaReply_content == null) {
							$(obj).parent().find(".qnaContent p:eq(1)").html("");	
							if(param.auth == '9') {
								$(obj).parent().find(".qnaContent .answerContent").show();
							}
						} else {
							$(obj).parent().find(".qnaContent p:eq(1)").html(qnaReply_content.qr_content);	
							$(obj).parent().find(".qnaContent .answerContent").hide();
						}
						$(obj).parent().find(".qnaContent").show();
					}
				}
			},
			error : function() {
				alert('네트워크 오류 발생');
			}
		});
	}
</script>
<div id="qontent-main">
	<h2>게시판 목록</h2>
	<ul class="search">
		<li><select name="keyfield" id="keyfield">
				<option value="1">제목</option>
				<option value="2">내용</option>
		</select></li>
		<li><input type="search" size="16" name="keyword" id="keyword"
			value="${param.keyword}" placeholder="내용을 입력해주세요."></li>
		<li><input type="button" value="검색"
			onclick="searchQNA('keyword', 1)"></li>
	</ul>
	<div class="list-space align-right">
		<input type="button" value="글쓰기"
			onclick="window.open('writeForm.do', '_blank', 'width=550, height=500'); return false;">
		<input type="button" value="전체 문의보기" onclick="searchQNA('all', 1)">
		<input type="button" value="나의 Q&A 조회" onclick="searchQNA('mine', 1)">
	</div>
	<table>
		<tr>
			<th>글번호</th>
			<th>답변상태</th>
			<th>제목</th>
			<th>문의자</th>
			<th>작성일</th>
		</tr>
		<tbody class="qnaListSection">
			<c:forEach var="qna" items="${list}">
				<tr class="qnaListUnit">
					<td>${qna.q_num}</td>
					<c:choose>
						<c:when test="${qna.answer_yn == 'Y'}">
							<td>답변완료</td>
						</c:when>
						<c:otherwise>
							<td>답변대기중</td>
						</c:otherwise>
					</c:choose>
					<c:choose>
						<c:when test="${qna.hide_yn == 'Y'}">
							<td><a href="javascript:void(0)"
								onclick="showQNA(${qna.q_num}, this)">${qna.title}</a> <img
								src="/petmama/images/customer/qna_lock.png" width="25"
								height="25"></td>
						</c:when>
						<c:otherwise>
							<td><a href="javascript:void(0)"
								onclick="showQNA(${qna.q_num}, this)">${qna.title}</a></td>
						</c:otherwise>
					</c:choose>
					<td>${qna.mem_id}</td>
					<td>${qna.reg_date}</td>
				</tr>
			</c:forEach>
		</tbody>
	</table>
	<div class="align-center">${page}</div>
</div>

<div class="qnaContent">
	<b>내용 : </b>
	<p>내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용</p>
	<b>답변 : </b>
	<p>답변답변답변답변답변답변답변답변답변답변답변답변답변답변답변답변</p>
	<div class="answerContent">
		<textarea rows="" cols=""></textarea>
		<button>확인</button>
	</div>
</div>

<div class="popup-container">
	<label for="password" style="font-size: 18px;">비밀번호를 입력하세요:</label> <input
		type="password" id="password" class="password-input" required>
	<br>
	<button class="submit-button" onclick="showSecretQNA()">확인</button>
	<button class="submit-button"
		onclick="javascript:$('.popup-container').hide()">취소</button>
</div>