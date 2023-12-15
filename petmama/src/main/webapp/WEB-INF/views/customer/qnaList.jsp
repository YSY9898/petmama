<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
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
				//"kind" : kind,
				"keyfield" : keyfield,
				"keyword" : keyword,
				"pageNum" : pageNum
			},
			dataType : 'json',
			success : function(param) {
				console.log(JSON.parse(param.page));
				
				$(".qnaListUnit").remove();
				let qna_list = JSON.parse(param.list);
				let qna_page = JSON.parse(param.page);
				let new_html = "";
				
				qna_list.forEach((data, index, array) => {
				    new_html += "<tr class='qnaListUnit'>";
				    new_html += "<td>" + data['q_num'] + "</td>";
				    new_html += "<td>" + data['answer_yn'] + "</td>";
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
				console.log(qna_page['page']);
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
		
		// ajax 
		// 1. 비밀글 처리
		// 2. 답변 관련 처리
		$.ajax({
			url : '${pageContext.request.contextPath}/customer/detail.do',
			type : 'post',
			data : {
				"q_num" : q_num,
			},
			dataType : 'json',
			success : function(param) {
				
			},
			error : function() {
				alert('네트워크 오류 발생');
			}
		});
		
		// ajax return 값 붙이기
		if($(obj).parent().find(".qnaContent").length > 0) {
			$(obj).parent().find(".qnaContent").remove();
		} else {
			$(obj).parent().append($(".qnaContent")[0].outerHTML);
		}
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
					<td>${qna.answer_yn}</td>
					<c:if test="${qna.hide_yn == 'Y'}">
						<td><a href="javascript:void(0)"
						onclick="showQNA(${qna.q_num}, this)">${qna.title}</a>
						<img src="/petmama/images/customer/qna_lock.png" width="25" height="25" >
						</td>
					</c:if> 
					<td><a href="javascript:void(0)"
						onclick="showQNA(${qna.q_num}, this)">${qna.title}</a></td>
					<td>${qna.mem_id}</td>
					<td>${qna.reg_date}</td>
				</tr>
			</c:forEach>
		</tbody>
	</table>
	<div class="align-center">${page}</div>
</div>

<div class="qnaContent">
	<p>제목제목제목제목제목제목제목제목제목제목제목제목제목제목제목제목</p>
	<p>답변답변답변답변답변답변답변답변답변답변답변답변답변답변답변답변</p>
</div>