<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<head>

<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/Swiper/3.4.1/css/swiper.min.css">

<script type="text/javascript"src="${pageContext.request.contextPath}/js/jquery-3.6.0.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/Swiper/3.4.1/js/swiper.min.js"></script>

<style>
	.circle {
		margin:7;
		width: 80px;
		height:80px;
		border-radius: 50%;
		color:darkgray;
		text-align:center;
		line-height:5;
		border:1px solid darkgray;
		background-color: white;
	}
	.circle.active {
		color:white;
		border:1px solid white;
		background-color: #6A92FE;
	}
	.circle p {
		font-size:13px;
		margin: -18px 0 0 2px;
		color:darkgray;
	}
	.time_fee {
		display: flex;
	}
</style>

<script>

$(function() {
	$(".circle").on("click", function() {
		if($(this).hasClass("active")) {
			$(this).removeClass("active");
		} else {
			$(".circle").removeClass("active");
			$(this).addClass("active");
		}
		console.log("asadasd");
	});
})
</script>

<style>
h1, p {
	text-align: center;
}

.input-wrapper {
	text-align: center;
}

input {
	font-size: 1.5rem;
	text-align: center;
}

.picker {
	box-sizing: border-box;
	position: relative;
	width: 300px;
	overflow: hidden;
	margin: 1rem auto 0;
	outline: 1px solid #ccc;
	padding: 0 30px;
	background-color: #fff;
	color: #252525;
}

.swiper-container {
	width: 80px;
	height: 210px;
	float: left;
}

.swiper-slide {
	text-align: center;
	font-size: 2rem;
	/* Center slide text vertically */
	display: flex;
	justify-content: center;
	align-items: center;
	user-select: none;
	opacity: 0.25;
	transition: opacity 0.3s ease;
	cursor: default;
	font-weight: bold;
	-webkit-tap-highlight-color: transparent;
}

.swiper-slide-prev, .swiper-slide-next {
	cursor: pointer;
}

.swiper-slide-active {
	opacity: 1;
}

.vizor {
	border-top: 1px solid #ccc;
	border-bottom: 1px solid #ccc;
	height: 70px;
	position: absolute;
	top: 50%;
	left: 1rem;
	right: 1rem;
	transform: translateY(-50%);
	font-size: 2rem;
	line-height: 62px;
}

.vizor:before, .vizor:after {
	content: ':';
	display: inline-block;
	line-height: inherit;
	height: 100%;
	position: absolute;
	top: 0;
	transform: translateX(-50%);
}

.vizor:before {
	left: 95px;
}

.vizor:after {
	left: 175px;
}

.arrows .swiper-container:after, .arrows .swiper-container:before {
	content: "";
	position: absolute;
	left: 50%;
	transform: translateX(-50%);
	width: 0;
	height: 0;
	border-style: solid;
	border-width: 4px;
	border-color: transparent;
	opacity: 0.5;
}

.arrows .swiper-container:before {
	top: 0.5rem;
	border-top-width: 0;
	border-bottom-color: currentColor;
}

.arrows .swiper-container:after {
	bottom: 0.5rem;
	border-bottom-width: 0;
	border-top-color: currentColor;
}
</style>

</head>

<body>


<div class="time-picker">
	<div class="input-wrapper">
		예약시간 : <input type="text" id="time" value="12:00:00" readonly />
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

<div class="time_fee">
	<a href="#"><div class="circle" value="1440">종일<p>시간별요금제</p></div></a>
	<a href="#"><div class="circle" value="30">30분<p>19,500~</p></div></a>
	<a href="#"><div class="circle" value="60">60분<p>28,500~</p></div></a>
	<a href="#"><div class="circle" value="120">120분<p>42,000~</p></div></a>
</div>

</body>
</html>