<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Q&A 작성하기</title>
</head>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/js/jquery-3.6.0.min.js"></script>
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/js/bootstrap.bundle.min.js"
	type="text/javascript"></script>
<script type="text/javascript">
	function saveQna() {
		let title = $("#title").val();
		let content = $("#qna_content").val();
		let passwd = $("#passwd").val();
		let hideYN = ($("#hide_yn")[0].checked) ? 'Y' : 'N';

		if (title === "") {
			alert('제목을 입력해주세요.');
			return false;
		}

		if (content === "") {
			alert('내용을 입력해주세요.');
			return false;
		}

		if (hideYN == 'Y' && passwd === "") {
			alert('비밀번호를 입력해주세요.');
			return false;
		}

		$.ajax({
			url : '${pageContext.request.contextPath}/customer/write.do',
			type : 'post',
			data : {
				"title" : title,
				"content" : content,
				"hideYN" : hideYN,
				"passwd" : passwd
			},
			dataType : 'json',
			success : function(param) {
				if (param.result == 'logout') {
					alert('로그인 후 글을 작성해주세요.');
				} else if (param.result == 'success') {
					alert('글을 작성했습니다.');
					self.close();
				}
			},
			error : function() {
				alert('네트워크 오류 발생');
			}
		});
		//기본 이벤트 제거
		event.preventDefault();
	}

	$(function() {
		$('#hide_yn').change(function() {
			if ($("#hide_yn")[0].checked) {
				$("#passwd").show();
			} else {
				$("#passwd").hide();
			}
		});
	});
</script>
<style>
body {
	background-color: #F7F8FA;
}

#title {
	width: 550px;
}

#qna_content {
	width: 550px;
	height: 250px;
}

.inquery_section div {
	border-top: 1px solid #e4e4e4;
}

input[type=button] {
	background: #6A92FE;
	color: #FFFFFF;
	border: none;
	border-radius: 10px;
	padding: 6px 12px;
	cursor: pointer;
}
.btns {
	padding-top:10px;
}
</style>
<body>
	<div class="inquery_section">
		제목 :
		<div>
			<input type="text" id="title">
		</div>
		내용 :
		<div>
			<textarea id="qna_content" rows="" cols=""
				placeholder="문의하실 내용을 입력하세요."></textarea>
		</div>
		<div>
			비공개 : <input type="checkbox" id="hide_yn">
		</div>
		<div>
			비밀번호 : <input type="text" id="passwd" style="display: none;">
		</div>
		<div class="btns">
			<input type="button" value="취소" onclick="self.close()"> <input
				type="button" value="입력" onclick="saveQna()">
		</div>
	</div>
</body>
</html>