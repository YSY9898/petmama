<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!-- header 시작 -->
	<jsp:include page="/WEB-INF/views/common/header.jsp"/>
<!-- header 끝 -->

<div class="container-fluid bg-info bg-opacity-50" style="padding:150px 20px;"></div>

<div class="container-fluid" style="padding:200px 20px;">
  <div class="row">
    <div class="col text-center">
    <br>
      <h2 class="fw-bold">언제 어디서든</h2>
      <h2 class="fw-bold">펫시터를 부르세요</h2>
    </div>
    <div class="col text-right">
      <p>혼자 남겨진 반려동물을 생각하며, 외출을 망설인 적이 있으신가요?</p>
	  <p>이제는 펫마마 펫시터에게 맡기고, 여러분의 소중한 일상을 마음 편히 보내세요</p>
	
	  <p>바로 돌봄, 예약 돌봄, 정기 돌봄까지 언제 어디서든 원하시는 방법으로/<p>
	  <p>‘펫마마’ 방문 펫시터 서비스를 예약할 수 있어요</p>
    </div>
 </div>
</div>

<div class="container-fluid bg-secondary bg-opacity-75 text-white" style="padding:80px 20px;">

<div class="row">
    <div class="col text-center">
      <h2 class="fw-bold">지금까지 5,325마리의</h2>
      <h2 class="fw-bold">아이들이 펫마마 펫시터의</h2>
      <h2 class="fw-bold">도움을 받았어요!</h2>
    </div>
    <div class="col col-lg-5">
    <br>
      <h5>펫마마 누적 예약수</h5>
	  <h2 class="fw-bold">9,834,759회</h2>
    </div>
 </div>
</div>

<div class="container-fluid bg-info bg-opacity-50" style="padding:200px 20px;"></div>

<div class="container-fluid" style="padding:200px 20px;">
  <div class="row">
    <div class="col text-center">
   	  <img src="${pageContext.request.contextPath}/images/check-mark-2025986_1280.png" 
   	  		style="width:30px; height:30px;">
      <h2 class="fw-bold">엄선된 펫시터가</h2>
      <h2 class="fw-bold">방문합니다</h2>
    </div>
    <div class="col text-right">
      <p>와요의 모든 펫시터는 신분증 사본, 등초본, 신원보증 부대까지 3단계로</p>
	  <p>까다롭게 신원을 검증하며, 전문적인 돌봄 서비스를 제공할 수 있도록,</p>
	  <p>공신력 있는 전문 기관 (한국 애견 연맹 KKF / 한국 애견 협회 KKC)의 인증 및<p>
	  <p>본사의 4단계의 심사를 통과한 현업 훈련사가 펫시터 교육을 함께합니다.</p>
    </div>
 </div>
</div>

<div class="container-fluid bg-info bg-opacity-50" style="padding:200px 20px;"></div>

<div class="container-fluid" style="padding:200px 20px;">
  <div class="row">
    <div class="col text-center">
    <br><br>
      <h2 class="fw-bold">안전한 산책과 함께,</h2>
      <h2 class="fw-bold">깔끔한 마무리</h2>
    </div>
    <div class="col text-right">
      <p>와요의 모든 도그워커는 펫피플 교육 아카데미의 산책 전문 교육을 수료하였으며,</p>
	  <p>산책 안전 매뉴얼에 따라 산책하며, 안전을 위해 2중 가드줄을 착용하고 있어요</p>
	  <p>산책이 종료된 후에는, 집이 더러워지지 않도록 발을 깨끗이 닦아 마무리해요<p>
	  <br>
	  <p class="text-secondary">* 산책 30분의 경우에는 시간 관계상, 물티슈로 발닦기만 가능하며</p>
	  <p class="text-secondary">산책 60분, 120분의 경우에는 물로 씻기 + 닦기 등을 요청할 수 있습니다</p>
    </div>
 </div>
</div>


<div class="container-fluid bg-info bg-opacity-50" style="padding:80px 20px;">
<br><br>
<h1 class="fw-bold text-center">어떤 펫시터가 방문하나요?</h1>
<br><br><br><br><br>
<div class="row row-cols-1 row-cols-md-3 g-4">
  <div class="col">
    <div class="card h-100">
      <img src="${pageContext.request.contextPath}/images/petsitter pic1.png" class="card-img-top" alt="...">
      <div class="card-body">
        <h5 class="card-title fw-bold text-center">김◯규 훈련사</h5>
        <br>
        <p class="card-text"><span class="badge bg-primary">대표 경력</span> 방문훈련 전문, 동물병원근무</p>
        <p class="card-text"><span class="badge bg-primary">전문 분야</span> 공격성 교육 전문, 소/중형견 전문</p>
		<hr><br>
		<ul>
			<li>KKC 인증 3급 훈련사</li>
			<li>반려동물관리사 1급</li>
			<li>반려동물행동교정사 1급</li>
			<li>반려동물장례지도사 1급</li>
			<li>축산기능사</li>
			<li>서정대학교 애완동물과 졸업</li>
		</ul>
		<br><br>
		<div class="d-grid gap-2 col-6 mx-auto">
		<input type="button" value="자세히 보기" 
  		class="btn btn-secondary text-light align-center"
		onclick="location.href='${pageContext.request.contextPath}/PSboard/petsitterList.do'">  
		<br>
		</div>   
      </div>
    </div>
  </div>
  <div class="col">
    <div class="card h-100">
      <img src="${pageContext.request.contextPath}/images/petsitter pic2.png" class="card-img-top" alt="...">
      <div class="card-body">
        <h5 class="card-title fw-bold text-center">이◯우 훈련사</h5>
        <br>
        <p class="card-text"><span class="badge bg-primary">대표 경력</span> 훈련 경기 대회 수상 다수, 방송</p>
        <p class="card-text"><span class="badge bg-primary">전문 분야</span> 분리 불안 전문, 산책 교육 전문</p>
		<hr><br>
		<ul>
			<li>KKC 인증 2급 반려견 지도사</li>
			<li>KKF 인증 3등 훈련사</li>
			<li>반려동물관리사 2급</li>
			<li>핸들러 3급</li>
			<li>반려견행동상담사 3급</li>
			<li>KPA - Dog Trainer Foundation</li>
		</ul>
		<br><br>
		<div class="d-grid gap-2 col-6 mx-auto">
		<input type="button" value="자세히 보기" 
  		class="btn btn-secondary text-light align-center"
		onclick="location.href='${pageContext.request.contextPath}/PSboard/petsitterList.do'">  
		<br>
		</div>   
      </div>
    </div>
  </div>
  <div class="col">
    <div class="card h-100">
      <img src="${pageContext.request.contextPath}/images/petsitter pic3.png" class="card-img-top" alt="...">
      <div class="card-body">
        <h5 class="card-title fw-bold text-center">조◯현 훈련사</h5>
        <br>
        <p class="card-text"><span class="badge bg-primary">대표 경력</span> 반려동물 훈련-관리사 교육 강사</p>
        <p class="card-text"><span class="badge bg-primary">전문 분야</span> 행동 분석 전문, 산책 교육 전문</p>
		<hr><br>
		<ul>
			<li>KKF 인증 3등 훈련사</li>
			<li>반려동물행동교정사</li>
			<li>반려동물관리사</li>
		</ul>
		<br><br><br><br><br>
		<div class="d-grid gap-2 col-6 mx-auto">
		<input type="button" value="자세히 보기" 
  		class="btn btn-secondary text-light align-center"
		onclick="location.href='${pageContext.request.contextPath}/PSboard/petsitterList.do'">  
		<br>
		</div>   
      </div>
    </div>
  </div>
</div>
<br><br><br><br><br><br><br>
<div class="d-grid gap-2 col-6 mx-auto">
  <input type="button" value="+ 펫시터 프로필에서 더 많은 펫시터를 확인할 수 있어요!" 
  	class="btn btn-outline-primary btn-light text-dark fw-bold"
	onclick="location.href='${pageContext.request.contextPath}/PSboard/petsitterList.do'">
<br><br>	
</div>
</div>


<div class="container-fluid" style="padding:200px 20px;">
  <div class="row">
    <div class="col col-lg-5 text-end">
	    <br><br><br><br><br>
	      <h2 class="fw-bold">편리한 예약 방식</h2>
	      <h2 class="fw-bold">펫시팅 후기</h2>
    </div>
    <div class="col">
      <img src="${pageContext.request.contextPath}/images/pic2.png">
    </div>
 </div>
</div>

<div class="container-fluid" style="padding:200px 20px;">
  <div class="row">
    <div class="col">
    	<img src="${pageContext.request.contextPath}/images/pic1.png"">
    </div>
    <div class="col col-lg-5">
      <br><br><br><br><br>
      <br><br><br><br><br>
      <h2 class="fw-bold">지역 별로 확인할 수 있는</h2>
      <h2 class="fw-bold">펫시팅 후기</h2>
    </div>
 </div>
</div>

<div class="container-fluid bg-secondary bg-opacity-75 text-white" style="padding:200px 20px;">
  <div class="row">
    <div class="col col-lg-5 text-end">
    <br><br><br><br><br><br><br>
      <img src="${pageContext.request.contextPath}/images/callout-29388_1280.png" 
   	  		style="width:80px; height:80px;">
      <h2 class="fw-bold">우리끼리 자유로운 소통,</h2>
      <h2 class="fw-bold">자유 게시판</h2>
    </div>
    <div class="col col-lg-5">
      <img src="${pageContext.request.contextPath}/images/pic1.png"">
    </div>
 </div>
</div>


<div class="container-fluid bg-info bg-opacity-50" style="padding:200px 20px;">
  <div class="row">
    <div class="col text-end">
      <img src="${pageContext.request.contextPath}/images/open.png" 
   	  		style="width:30px; height:30px;">
    </div>
    <div class="col-5">
      <h1 class="fw-bold text-center">펫마마는 여러분을 환영합니다</h1>
    </div>
    <div class="col">
      <img src="${pageContext.request.contextPath}/images/close.png" 
   	  		style="width:30px; height:30px;">
    </div>
  </div>
  </div>


