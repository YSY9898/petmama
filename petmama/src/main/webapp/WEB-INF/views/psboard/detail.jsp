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
		$(function(){
			$("#option1").click(function(){
				$("#fee").val("1");
			});
			$("#option2").click(function(){
				$("#fee").val("2");
			});
			$("#option3").click(function(){
				$("#fee").val("3");
			});
			$("#option4").click(function(){
				$("#fee").val("4");
			});
			
		});
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
				<div class="row">
					<div class="col">{프로필}</div>
					<div class="col">
						{요금선택}
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
					</div>
				</div>
				<div class="row">
					<div class="col">{경력}</div>
					<div class="col">
						{달력&시간}
						<!-- 제가 추가한거 -->
						<p>
							예약날짜 : <input type="text" id="date" name="date">
						</p>
						<div id="datepicker"></div>
						<!-- 제가 추가한거 끝 -->

						<!-- swiper 시작 -->
						<div class="time-picker">
							<div class="input-wrapper">
								예약시간 : <input type="text" id="time" name="time" value="12:00:00"
									readonly />
							</div>
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

						<input type="submit" id="btn" value="예약하기">
						<!-- swiper 끝 -->
					</div>
				</div>
				<div class="row">
					<div class="col">{후기게시판}</div>
				</div>
			</form>
		</div>
	</div>
</body>
</html>