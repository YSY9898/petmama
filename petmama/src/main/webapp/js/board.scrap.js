$(function(){
	//스크랩 선택 여부
	function selectScrap(){
		$.ajax({
			url:'getScrap.do',
			type:'post',
			data:{board_num:$('#output_scrap').attr('data-num')},
			dataType:'json',
			success:function(param){
				displayScrap(param);
			},
			error:function(){
				alert('네트워크 오류 발생');
			}
		})		
	};
	
	//스크랩 등록(및 삭제) 이벤트 연결
	$('#output_scrap').click(function(){
		$.ajax({
			url:'writeScrap.do',
			type:'post',
			data:{board_num:$(this).attr('data-num')},
			dataType:'json',
			success:function(param){
				if(param.result == 'logout'){
					alert('스크랩은 로그인 후 가능합니다.');
				}else if(param.result == 'success'){
					displayScrap(param);
				}else{
					alert('좋아요 등록 오류 발생');
				}
			},
			error:function(){
				alert('네트워크 오류 발생');
			}
		});
	});
	
	//스크랩 표시
	function displayScrap(param){
		let output;
		if(param.status=='yesScrap'){//좋아요 선택
			output = '../images/scrap2.png';
		}else{//좋아요 미선택
			output = '../images/scrap1.png';		
		}
		
		//문서 객체에 설정
		$('#output_scrap').attr('src',output);
	}
	
	//초기 데이터 호출
	selectScrap();
});