<%@page import="org.apache.catalina.filters.ExpiresFilter.XServletOutputStream"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>펫시터 상세 프로필</title>
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/petsitter/style.css">
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/css/petsitter/jquery.datetimepicker.css">
<link rel="stylesheet"
	href="//code.jquery.com/ui/1.13.2/themes/base/jquery-ui.css">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/Swiper/3.4.1/css/swiper.min.css">
</head>
<body>
	<script type="text/javascript"
		src="${pageContext.request.contextPath}/js/jquery-3.6.0.min.js"></script>
	<script
		src="${pageContext.request.contextPath}/js/jquery.datetimepicker.full.min.js"></script>
	<script
		src="https://cdnjs.cloudflare.com/ajax/libs/Swiper/3.4.1/js/swiper.min.js"></script>
	<script src="https://code.jquery.com/ui/1.13.2/jquery-ui.js"></script>
	<script>
		$(function() {
			$('#datepicker').datepicker(
					{
						dateFormat : 'yy-mm-dd',
						closeText : "닫기",
						currentText : "오늘",
						prevText : '이전 달',
						nextText : '다음 달',
						monthNames : [ '1월', '2월', '3월', '4월', '5월', '6월',
								'7월', '8월', '9월', '10월', '11월', '12월' ],
						monthNamesShort : [ '1월', '2월', '3월', '4월', '5월', '6월',
								'7월', '8월', '9월', '10월', '11월', '12월' ],
						dayNames : [ '일', '월', '화', '수', '목', '금', '토' ],
						dayNamesShort : [ '일', '월', '화', '수', '목', '금', '토' ],
						dayNamesMin : [ '일', '월', '화', '수', '목', '금', '토' ],
						weekHeader : "주",
						yearSuffix : '년',
						minDate:0,
						onSelect : function(dateString) {
							$("#date").val(dateString);
						}
						
					});

			$(".circle").on("click", function() {
				if ($(this).hasClass("active")) {
					$(this).removeClass("active");
				} else {
					$(".circle").removeClass("active");
					$(this).addClass("active");
				}
				console.log("asadasd");
			});
		});

		$(function() {
			var defaults = {
				pagination : '.swiper-pagination',
				slidesPerView : 3,
				freeMode : true,
				freeModeSticky : true,
				freeModeMomentumRatio : 0.25,
				freeModeVelocityRatio : 0.25,
				freeModeMinimumVelocity : 0.1,
				loop : true,
				loopAdditionalSlides : 5,
				direction : 'vertical',
				slideToClickedSlide : true,
				centeredSlides : true,
				onSlideChangeEnd : updateInput
			};

			var hours = Swiper('.swiper-container.hours', Object.assign({},
					defaults, {
						initialSlide : 12
					}));
			hours.on('slideChangeEnd', function() {

			})

			var minutes = Swiper('.swiper-container.minutes', Object.assign({},
					defaults, {
						initialSlide : 00
					}));

			var seconds = Swiper('.swiper-container.seconds', defaults);

			var input = document.getElementById('time');
			input.addEventListener('focus', moveLeft);

			input.addEventListener('click', function(evt) {
				var start = input.selectionStart;
				var mod = start % 3;
				start -= mod;
				input.setSelectionRange(start, start + 2);
			});

			input.addEventListener('keydown', function(evt) {
				evt.preventDefault();
				switch (evt.keyCode) {
				case 38:
					change(true);
					break;
				case 40:
					change();
					break;
				case 37:
					moveLeft();
					break;
				case 39:
					moveRight();
					break;
				}
			});

			function moveLeft(e) {
				var start = input.selectionStart;
				var end = input.selectionEnd;

				var invalidSelection = (end - start !== 2) || (start % 3 !== 0);

				if (invalidSelection) {
					input.setSelectionRange(0, 2);
				} else if (start > 0) {
					start -= 3;
					input.setSelectionRange(start, start + 2);
				}
			}

			function moveRight() {
				var start = input.selectionStart;
				var end = input.selectionEnd;

				if (end - start !== 2) {
					input.setSelectionRange(0, 2);
				}

				if (end < input.value.length) {
					start += 3;
				}

				input.setSelectionRange(start, start + 2);
			}

			function findPart() {
				var start = input.selectionStart;
				var mod = start % 3;
				start -= mod;

				if (start === 6) {
					return seconds;
				} else if (start === 3) {
					return minutes;
				}

				return hours;
			}

			function change(direction) {
				var part = findPart();
				direction ? part.slideNext(true, 50) : part.slidePrev(true, 50);
			}

			function updateInput() {
				if (!input) {
					return false;
				}

				var start = input.selectionStart;
				var end = input.selectionEnd;
				input.value = pad(hours.realIndex) + ':'
						+ pad(minutes.realIndex) + ':' + pad(seconds.realIndex);
				input.setSelectionRange(start, end);
			}

			function pad(v) {
				return v > 9 ? v : "0" + String(v);
			}

			input.focus();
		});
		
		/* 요금 버튼 이벤트 */
		var prev_num = 0;
		var num;
		$(function(){
			
			$("#option1").click(function(){
				$("#fee").val("1");
				num = 1;
				check();
			});
			$("#option2").click(function(){
				$("#fee").val("2");
				num = 2;
				check();
			});
			$("#option3").click(function(){
				$("#fee").val("3");
				num = 3;
				check();
			});
			$("#option4").click(function(){
				$("#fee").val("4");
				num = 4;
				check();
			});
			
			
		});
		//요금 체크해제 확인
		function check(){
			if(num == prev_num){
				$("#fee").val("0");
				prev_num=0;
			}else{
				prev_num = num;
			}
		}
		//유효성 검사
		function valid_check(){
			if($("#fee").val()=="0"){
				alert("요금을 골라주세요.");
				return false;
			}
			if($("#date").val()==''){
				alert("예약 날짜를 선택해주세요.");
				return false;
			}
			if($("#time").val()==''){
				alert("예약 시간을 선택해주세요.");
				return false;
			}
			
			/* 예약 시간이 현재 시간과 같거나 이후인지 확인 */
			//현재 날짜
			let today = new Date();
			//예약 시간 변환
			let t = $("#time").val();
			let time = new Date(today.toDateString() + " " + t);
			
			if(today > time){
				alert("예약 시간을 현재 시간 이후로 설정해주세요.");
				return false;
			}
			
			
			let hours = today.getHours(); //시
			let minutes = today.getMinutes(); //분
			let seconds = today.getSeconds(); //초
		}
	</script>

	<div class="container text-center">
		<jsp:include page="/WEB-INF/views/common/header.jsp" />
		<div class="container text-center">

			<form id="reserve_form"
				action="${pageContext.request.contextPath}/member/reserveForm.do"
				method="post">
				<%
				int sis_num = Integer.parseInt(request.getParameter("sis_num"));
				%>
				<input type="hidden" id="sis_num" name="sis_num" value=<%=sis_num%>>
				<input type="hidden" id="fee" name="fee" value="0">
<!-- 시작 -->				
				<div><!-- 전체 페이지 시작(헤더 제외) -->
					<div class="bg_photo_outline"> <!-- 소개 사진 틀 -->
						<div style="width: 62.5%; height: 580px; overflow: hidden;">
							<img width="900" height="580" class="bg_photo" src="${pageContext.request.contextPath}/upload/${ps.photo2}">
						</div>
						<!-- 작은 소개 사진 2장 -->
						<div style="display: flex; flex-grow: 1; width: 37.5%; height: 580px; flex-direction: column;">
							<!-- 상단 이미지 -->
							<div style="width: 100%; height: 290px; overflow: hidden">
								<img height="290" style="object-fit: cover; user-select: none; cursor: pointer; width: 100%"
								src="${pageContext.request.contextPath}/upload/${ps.photo3}">
							</div>
							<!-- 하단 이미지 -->
							<div style="width: 100%; height: 290px; overflow: hidden">
								<img height="290" style="object-fit: cover; user-select: none; cursor: pointer; width: 100%"
								src="${pageContext.request.contextPath}/upload/${ps.photo4}">
							</div>
						</div>
					</div>
					<div class="ps_info_outline"><!-- 프로필 상세 정보 시작 -->
						<div style="width: 570px; position: relative; padding-bottom: 150px;">
							<div class="profile_photo_outline"><!-- 프로필 사진 -->
								<img class="profile_photo" src="${pageContext.request.contextPath}/upload/${ps.photo1}">
							</div>
							<div class="profile_title"> <!-- 펫시터 소개 시작 -->
								<h2>${ps.title}</h2>
								<div class="profile_detail">
									<p>${ps.name} 펫시터님</p>
								</div>
								<div style="display: flex; align-items: center;">
									<img style="width: 12px; height: 12px; margin-right: 4px;" 
									src="${pageContext.request.contextPath}/images/petsitter/one star.png">
									<p class="rating">${ps.rating}</p>
									<!-- 미구현 -->
									<!-- 
									<p class="review_num">리뷰 수</p> 
									-->
								</div>
							</div>
							
							<!-- 대표 경력, 전문 분야, 방문 지역 -->
							<div style="margin-top: 39px; padding-bottom: 48px; border-bottom: 1px solid #EBEBEB;"> 
								<div class="career">
									<img src = "${pageContext.request.contextPath}/images/petsitter/대표 경력.png">
										<div style="margin-top: 4px; margin-left: 18px;">
											<p style="font-weight: 500; font-size: 17px; color: #333333; letter-spacing: -0.2px; text-align:left;">대표 경력</p>
											<p style="ont-size: 15px; color: #777777; line-height: 20px; margin-top: 10px;">${ps.tag}</p>
										</div>
								</div>
								<div class="career">
									<img src = "${pageContext.request.contextPath}/images/petsitter/전문 분야.png">
										<div style="margin-top: 4px; margin-left: 18px;">
											<p style="font-weight: 500; font-size: 17px; color: #333333; letter-spacing: -0.2px; text-align:left;">전문 분야</p>
											<p style="ont-size: 15px; color: #777777; line-height: 20px; margin-top: 10px;">${ps.field}</p>
										</div>
								</div>
								<div class="career">
									<img src = "${pageContext.request.contextPath}/images/petsitter/방문 지역.png">
										<div style="margin-top: 4px; margin-left: 18px;">
											<p style="font-weight: 500; font-size: 17px; color: #333333; letter-spacing: -0.2px; text-align:left;">방문 지역</p>
											<p style="ont-size: 15px; color: #777777; line-height: 20px; margin-top: 10px;">서울특별시</p>
										</div>
								</div>
								<div>
									<img src = "${pageContext.request.contextPath}/upload/${ps.career_image}">
								</div>
							</div>
							
							<!-- 해당 펫시터로 온 문의 시작 -->
							<!-- 
							<div style="margin-top: 50px;">
								<jsp:include page="/WEB-INF/views/customer/qnaList.jsp">
									<jsp:param name="sis_num" value="${sis_num}"/>
								</jsp:include>
							</div>
							-->
							<!-- 끝 -->
						</div>
						<div class="right_menu"><!-- 오른쪽 메뉴 -->
							<!-- 시간 -->
							<div class="time_fee">
							<a href="javascript:void(0)" id="option1"><div class="circle" value="1440">
									종일
									<p>시간별요금제</p>
								</div></a> <a href="javascript:void(0)" id="option2"><div class="circle" value="30">
									30분
									<p>19,500~</p>
								</div></a> <a href="javascript:void(0)" id="option3"><div class="circle" value="60">
									60분
									<p>28,500~</p>
								</div></a> <a href="javascript:void(0)" id="option4"><div class="circle"
									value="120">
									120분
									<p>42,000~</p>
								</div></a>
							</div>
							<!-- 달력 -->
							<p>
								예약날짜 : <input type="text" id="date" name="date">
							</p>
							<div id="datepicker"></div>
							
							<!-- 달력&시간 -->
							<div class="time-picker">
							<div class="input-wrapper">
								예약시작시간 : <input type="text" id="time" name="time" value="12:00:00"
									readonly />
							</div>
							<!-- swiper 시작 -->
							<div class="picker arrows">
								<div class="swiper-container hours">
									<div class="swiper-wrapper">
										<div class="swiper-slide">00</div>
										<div class="swiper-slide">01</div>
										<div class="swiper-slide">02</div>
										<div class="swiper-slide">03</div>
										<div class="swiper-slide">04</div>
										<div class="swiper-slide">05</div>
										<div class="swiper-slide">06</div>
										<div class="swiper-slide">07</div>
										<div class="swiper-slide">08</div>
										<div class="swiper-slide">09</div>
										<div class="swiper-slide">10</div>
										<div class="swiper-slide">11</div>
										<div class="swiper-slide">12</div>
										<div class="swiper-slide">13</div>
										<div class="swiper-slide">14</div>
										<div class="swiper-slide">15</div>
										<div class="swiper-slide">16</div>
										<div class="swiper-slide">17</div>
										<div class="swiper-slide">18</div>
										<div class="swiper-slide">19</div>
										<div class="swiper-slide">20</div>
										<div class="swiper-slide">21</div>
										<div class="swiper-slide">22</div>
										<div class="swiper-slide">23</div>
									</div>
								</div>
								<div class="swiper-container minutes">
									<div class="swiper-wrapper">
										<div class="swiper-slide">00</div>
										<div class="swiper-slide">01</div>
										<div class="swiper-slide">02</div>
										<div class="swiper-slide">03</div>
										<div class="swiper-slide">04</div>
										<div class="swiper-slide">05</div>
										<div class="swiper-slide">06</div>
										<div class="swiper-slide">07</div>
										<div class="swiper-slide">08</div>
										<div class="swiper-slide">09</div>
										<div class="swiper-slide">10</div>
										<div class="swiper-slide">11</div>
										<div class="swiper-slide">12</div>
										<div class="swiper-slide">13</div>
										<div class="swiper-slide">14</div>
										<div class="swiper-slide">15</div>
										<div class="swiper-slide">16</div>
										<div class="swiper-slide">17</div>
										<div class="swiper-slide">18</div>
										<div class="swiper-slide">19</div>
										<div class="swiper-slide">20</div>
										<div class="swiper-slide">21</div>
										<div class="swiper-slide">22</div>
										<div class="swiper-slide">23</div>
										<div class="swiper-slide">24</div>
										<div class="swiper-slide">25</div>
										<div class="swiper-slide">26</div>
										<div class="swiper-slide">27</div>
										<div class="swiper-slide">28</div>
										<div class="swiper-slide">29</div>
										<div class="swiper-slide">30</div>
										<div class="swiper-slide">31</div>
										<div class="swiper-slide">32</div>
										<div class="swiper-slide">33</div>
										<div class="swiper-slide">34</div>
										<div class="swiper-slide">35</div>
										<div class="swiper-slide">36</div>
										<div class="swiper-slide">37</div>
										<div class="swiper-slide">38</div>
										<div class="swiper-slide">39</div>
										<div class="swiper-slide">40</div>
										<div class="swiper-slide">41</div>
										<div class="swiper-slide">42</div>
										<div class="swiper-slide">43</div>
										<div class="swiper-slide">44</div>
										<div class="swiper-slide">45</div>
										<div class="swiper-slide">46</div>
										<div class="swiper-slide">47</div>
										<div class="swiper-slide">48</div>
										<div class="swiper-slide">49</div>
										<div class="swiper-slide">50</div>
										<div class="swiper-slide">51</div>
										<div class="swiper-slide">52</div>
										<div class="swiper-slide">53</div>
										<div class="swiper-slide">54</div>
										<div class="swiper-slide">55</div>
										<div class="swiper-slide">56</div>
										<div class="swiper-slide">57</div>
										<div class="swiper-slide">58</div>
										<div class="swiper-slide">59</div>
									</div>
								</div>
								<div class="swiper-container seconds">
									<div class="swiper-wrapper">
										<div class="swiper-slide">00</div>
										<div class="swiper-slide">01</div>
										<div class="swiper-slide">02</div>
										<div class="swiper-slide">03</div>
										<div class="swiper-slide">04</div>
										<div class="swiper-slide">05</div>
										<div class="swiper-slide">06</div>
										<div class="swiper-slide">07</div>
										<div class="swiper-slide">08</div>
										<div class="swiper-slide">09</div>
										<div class="swiper-slide">10</div>
										<div class="swiper-slide">11</div>
										<div class="swiper-slide">12</div>
										<div class="swiper-slide">13</div>
										<div class="swiper-slide">14</div>
										<div class="swiper-slide">15</div>
										<div class="swiper-slide">16</div>
										<div class="swiper-slide">17</div>
										<div class="swiper-slide">18</div>
										<div class="swiper-slide">19</div>
										<div class="swiper-slide">20</div>
										<div class="swiper-slide">21</div>
										<div class="swiper-slide">22</div>
										<div class="swiper-slide">23</div>
										<div class="swiper-slide">24</div>
										<div class="swiper-slide">25</div>
										<div class="swiper-slide">26</div>
										<div class="swiper-slide">27</div>
										<div class="swiper-slide">28</div>
										<div class="swiper-slide">29</div>
										<div class="swiper-slide">30</div>
										<div class="swiper-slide">31</div>
										<div class="swiper-slide">32</div>
										<div class="swiper-slide">33</div>
										<div class="swiper-slide">34</div>
										<div class="swiper-slide">35</div>
										<div class="swiper-slide">36</div>
										<div class="swiper-slide">37</div>
										<div class="swiper-slide">38</div>
										<div class="swiper-slide">39</div>
										<div class="swiper-slide">40</div>
										<div class="swiper-slide">41</div>
										<div class="swiper-slide">42</div>
										<div class="swiper-slide">43</div>
										<div class="swiper-slide">44</div>
										<div class="swiper-slide">45</div>
										<div class="swiper-slide">46</div>
										<div class="swiper-slide">47</div>
										<div class="swiper-slide">48</div>
										<div class="swiper-slide">49</div>
										<div class="swiper-slide">50</div>
										<div class="swiper-slide">51</div>
										<div class="swiper-slide">52</div>
										<div class="swiper-slide">53</div>
										<div class="swiper-slide">54</div>
										<div class="swiper-slide">55</div>
										<div class="swiper-slide">56</div>
										<div class="swiper-slide">57</div>
										<div class="swiper-slide">58</div>
										<div class="swiper-slide">59</div>
									</div>
								</div>
								<div class="vizor"></div>
							</div>
						</div>
						<!-- swiper 끝 -->
						<input type="submit" onclick="return valid_check()" value="예약하기">
						
						</div>
						
					</div>
				</div><!-- 전체 페이지 끝 -->
<!-- 끝 -->				
			</form>
		</div>
	</div>
</body>
</html>