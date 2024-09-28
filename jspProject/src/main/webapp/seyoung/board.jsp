<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>CloverStory</title>
<!-- Linking the CSS file -->
<link rel="stylesheet" type="text/css" href="css/style.css">
<link rel="stylesheet" type="text/css" href="css/board.css">
<style>

.board-recentpost {
    color: black; 
    text-align: center; 
    font-size: 24px; 
    font-weight: 300; 
    position: absolute; 
    top: 15px; 
    left: 100px;
    display: inline-block; 
}

.board-line {
    border-bottom: 1px solid #BAB9AA; /* 실선 색상 및 두께 */
    width: calc(100% - 55px); /* 실선의 너비 */
    position: absolute; 
    top: 80px; 
    left: 25px; 
}

.folder-container {
    width: 230px;
    height: 700px;
    margin: 10px 11px 100px 10px;
    padding: 20px;
    border: 2px dashed #bbb;  
    border-radius: 30px;      
    background-color: #F7F7F7; 
    flex-direction: column-reverse; /* 아래에서 위로 정렬 */
    align-items: flex-start; /* 좌측 정렬 */ 
    position: relative;
    
}



.folder-manage-button {
	font-family: 'NanumTobak', sans-serif;
    font-size: 22px;
    width: 85%;
    margin-left: 20px;
    margin-bottom: 20px;
    padding: 10px;
    background-color: #f7f7f7;
    border: 1.5px solid #ddd;
    text-align: center;
    cursor: pointer;
    position: absolute;
    bottom: 0;
	left: 0;
	border-radius: 10px;
}

.folder-input-container {
    display: none; /* 처음에는 숨겨져 있도록 설정 */
    align-items: center; 
    width: 80%;
    /* padding: 5px; */
    background-color: #fff;
    border: 1px solid #ddd;
    border-radius: 5px;    
  	position: absolute; /* 요소를 부모 기준으로 절대 위치에 배치 */
    top: 615px; /* 하단에서 40px 위로 */
 	left: 49%; 
    
}

.folder-input-container img {
    width: 27px; 
    height: 27px;
    margin-right: 10px; 
    border: none;
    outline: none;
}


.folder-input-container input {
	font-family: 'NanumTobak', sans-serif;
	font-size: 18px;
}

.folder-item {
    display: flex;
    align-items: center;
    justify-content: space-between; /* 폴더명과 삭제 버튼 사이의 간격 조정 */    
    margin-bottom: 8px;
    margin-right: -120px;
    width: 80%;
    padding: 5px; /* 폴더 항목 여백 */
    border: none;  
}

.folder-item img {
    width: 27px; /* 아이콘 크기 조정 */
    height: 27px; /* 아이콘 크기 조정 */
    margin-right: 7px; /* 폴더명과 간격 */
}

.folder-item span {
    font-size: 20px;
    font-weight: 500;
    text-align: left; 
    flex: 2;
}

.folder-input-container button {
    background: none; 
    border: none; 
    padding: 0;
    cursor: pointer; 
}

.folder-input-container button img {
	top: 5px;
    width: 25px; 
    height: 25px; 
}


.folder-item .delete-button {
    cursor: pointer; /* 커서 변경 */
    width: 24px; /* 쓰레기통 아이콘 크기 */
    height: 24px; 
}

.bwrite-form {
	display: flex;
	flex-direction: column;
	align-items: flex-start;
	padding: 10px;
	position: absolute;
	top: 5px;
	width: 710px;
	border: 1px solid #BAB9AA;
	background-color: #F7F7F7;
	margin: 20px 32px;
	height: 300px;
}

.board {
	display: flex;
    flex-direction: column;
    align-items: flex-start;
    
    position: absolute;
    top: 100px;
    width: 800px;
    height: 640px;
    border: 1px solid #BAB9AA;
    background-color: #F7F7F7;
    
}


.banswer-form {
    display: none;
    flex-direction: column;
    align-items: flex-start;
    padding: 10px;
    position: absolute;
    top: 340px;
    width: 710px;
    height: 150px; /* 높이 고정 */
    border: 1px solid #BAB9AA;
    background-color: #f2f2f2;
    margin: 20px 32px;
    overflow-y: auto; /* 내용이 높이를 넘을 때만 세로 스크롤 */
    overflow-x: hidden; /* 가로 스크롤 숨기기 */
}

.answer-item {
    display: flex;
    align-items: flex-start; /* 이미지와 컨텐츠가 위쪽에 맞춰지도록 설정 */
    padding: 10px;
    margin-bottom: 5px;
    background-color: #f2f2f2;
    border: none;
    box-sizing: border-box;
    width: 90%; /* 전체 너비 차지 */
    position: relative; /* 내부 요소의 위치 조정 */
}

.answer-item img {
    width: 40px;
    height: 40px;
    margin-right: 10px;
    border-radius: 50%;
}




.user-name {
    font-size: 16px;
    font-weight: bold;
    margin-bottom: 3px;
}

.user-image {
    width: 20px;
    height: 20px;
    border-radius: 50%;
    margin-right: 15px; /* 이미지와 컨텐츠 사이 간격 */
    margin-top: 10px; /* 이미지의 위치를 약간 아래로 이동 */
}


.answer-text {
    font-size: 23px; 
    color: #333; 
    margin-top: 3px; 
}
.answer-actions {
    display: flex;
    align-items: center;
    position: absolute; /* 위치를 고정하여 댓글 내용과 간격 조절 */
    top: 10px; /* 상단에서 떨어진 위치 */
    right: 10px; /* 오른쪽 끝에서 떨어진 위치 */
}

.answer-actions button {
    background: none;
    border: none;
    cursor: pointer;
    font-size: 21px;
    color: #424242;
    font-family: 'NanumTobak', sans-serif; 
    margin-right: 20px;
}

.wanswer-form {
	display: flex;
	align-items: center;
	padding: 10px;
	position: absolute;
	top: 523px;
	width: 710px;
	border: 1px solid #BAB9AA;
	background: #F2F2F2;
	margin: 20px 32px;
	height: 50px;
	
}

.wanswer-form input {
	width: 700px;
	border: 1px solid #BAB9AA;
	background-color: #FFFFFF;
	font-family: 'NanumTobak', sans-serif;
	font-size: 20px;
	border-radius: 5px; 
	margin-top: -2px;
	margin-right: 10px;
	height: 30px;
}


.wanswer-form button {
    width: 50px;
    height: 35px;
    background-color: #FFFFFF;
    color: black;
    border: 1px solid #BAB9AA;
    border-radius: 5px;
    cursor: pointer;
    font-size: 20px;
    font-family: 'NanumTobak', sans-serif;
    margin-top: -2px;
}

.reply-form {
    display: flex;
    flex-direction: row;
    align-items: center;
    width: 660px; /* 부모 요소의 가로 길이와 동일하게 설정 */
    margin-bottom: 10px; /* 아래쪽 여백 */
    background-color: #f5f5f5; /* 배경색 설정 */
    border: 1px solid #BAB9AA; /* 테두리 설정 */
    padding: 10px; /* 내용 여백 */
}

.reply-input {
    width: 90%; /* 입력창 너비를 조정하여 버튼과 균형 맞추기 */
    flex: 1; /* 입력창이 공간을 최대한 차지하도록 설정 */
    margin-right: 10px; /* 버튼과 입력창 사이 여백 */
    padding: 8px; /* 입력창 내 여백 */
    font-size: 15px; /* 글자 크기 설정 */
    height: 10px; /* 입력창의 세로 길이 설정 */
    font-family: 'NanumTobak', sans-serif;
    border: 1px solid #BAB9AA; /* 테두리 설정 */
    border-radius: 5px;
    background-color: #f9f9f9;
}


.reply-button {
    padding: 4px 8px; /* 버튼 여백 설정 */
    font-size: 17px; /* 버튼 글자 크기 */
    cursor: pointer; /* 커서 모양 설정 */
    height: 28px; /* 버튼의 세로 길이 입력창과 동일하게 설정 */
    width: 55px; /* 버튼의 가로 길이 조정 */
    border: 1px solid #BAB9AA; /* 테두리 설정 */
    border-radius: 5px;
    background-color: #f9f9f9; /* 배경색 설정 */
}
</style>

</head>
<body>
	<div class="container">
		<div class="header">
			<img src="img/logo2.png" alt="CloverStory Logo2" class="logo2">
			<div class="settings">
			<span></span>
				<a href="#">설정</a> <a href="#">로그아웃</a>
			</div>
		</div>
		<!-- 큰 점선 테두리 상자 -->
		<div class="dashed-box">
			<!-- 테두리 없는 상자 -->
			<div class="solid-box">
				<div class="inner-box-1">
					<!-- 폴더 관리하기 섹션 -->
                    <jsp:include page="bInnerbox1.jsp"/>
				
				</div>
				<!-- 이미지가 박스 -->
				<div class="image-box">
					<img src="img/img1.png" alt="Image between boxes 1"
						class="between-image"> <img src="img/img1.png"
						alt="Image between boxes 2" class="between-image">
				</div>
				<div align = "center" class="inner-box-2">
				
					<h1 class="board-title">게시판</h1>
					<h2 class="board-recentpost"> | 최근게시물</h2>
					<div class="board-line"></div>
					
					<div class="board">
					
						<div class="bwrite-form">
							
							
						
						
						</div>
						
						<div class="banswer-form">
							
						
						</div>
						
						<div class="wanswer-form">
							<input type="text" id="ansewerinput" placeholder="  게시판에 댓글을 남겨주세요.">
							<button type="button" onclick="addAnswer()">등록</button>
						</div>
					</div>
												
				</div>
			</div>
			<!-- 버튼 -->
			<div class="button-container">
				<button class="custom-button">홈</button>
				<button class="custom-button">프로필</button>
				<button class="custom-button">미니룸</button>
				<button class="custom-button" style="background-color: #F7F7F7; font-weight: 600;" >게시판</button>
				<button class="custom-button">방명록</button>
				<button class="custom-button">상점</button>
				<button class="custom-button">게임</button>
				<button class="custom-button">음악</button>
			</div>



		</div>
	</div>
	
	<script>
		function addAnswer() {
		    var input = document.getElementById('ansewerinput');
		    var answerText = input.value.trim();
		    if (answerText !== '') {
		        var answerForm = document.querySelector('.banswer-form');
	
		        // 댓글 폼을 표시
		        answerForm.style.display = 'flex';
	
		        // 새로운 댓글 요소 생성
		        var answerItem = document.createElement('div');
		        answerItem.className = 'answer-item';
		        answerItem.style.display = 'flex';
		        answerItem.style.alignItems = 'flex-start'; // 댓글과 버튼 정렬을 위해 추가
		        answerItem.style.marginBottom = '10px'; // 각 댓글 간의 간격 설정
		        answerItem.style.width = '100%'; // 전체 너비 설정
		        
	
		        // 사용자 이미지 요소 생성
		        var userImage = document.createElement('img');
		        userImage.src = 'img/character2.png'; // 사용자 이미지 경로 설정
		        userImage.alt = '사용자 이미지'; // 대체 텍스트
		        userImage.className = 'user-image'; // 이미지에 클래스 추가
	
		        // 댓글 내용과 사용자 이름을 포함할 컨텐츠 생성
		        var answerContent = document.createElement('div');
		        answerContent.className = 'answer-content';
		        answerContent.style.backgroundColor = '#f9f9f9'; // 배경색 설정
		        answerContent.style.border = '1px solid #BAB9AA'; // 테두리 설정
		        answerContent.style.padding = '10px'; // 내용 여백 설정
		        answerContent.style.width = '546px';
		        answerContent.style.display = 'flex';
		        answerContent.style.flexDirection = 'column';
		        
		        var answerHeader = document.createElement('div');
		        answerHeader.style.display = 'flex';
		        answerHeader.style.alignItems = 'center'; // 수직 정렬
		        answerHeader.style.marginBottom = '5px'; // 헤더 아래 여백 추가
		        
		        var userNameContainer = document.createElement('div');
		        userNameContainer.style.display = 'flex'; // 수평 정렬
		        userNameContainer.style.alignItems = 'center'; // 수직 정렬
		        
	
		        // 사용자 이름 추가
		        var userName = document.createElement('div');
		        userName.className = 'user-name';
		        userName.textContent = '홍길동'; // 사용자 이름
		        userName.style.fontWeight = 'bold'; // 굵게 설정
		        userName.style.marginRight = '10px'; // 오른쪽 여백 추가
		        
		        var answerTime = document.createElement('div');
		        answerTime.className = 'answer-time';
		        var currentTime = new Date().toLocaleString(); // 현재 시간
		        answerTime.textContent = currentTime; // 현재 시간을 텍스트로 추가
		        answerTime.style.fontSize = '15px'; // 글자 크기 설정
		        answerTime.style.color = 'black'; // 글자 색상 설정
		        
		        answerHeader.appendChild(userName);
		        answerHeader.appendChild(answerTime);
	
		        // 댓글 내용 추가
		        var answerTextNode = document.createElement('div');
		        answerTextNode.className = 'answer-text';
		        answerTextNode.textContent = answerText;
		        answerTextNode.style.fontSize = '18px'; // 글자 크기 설정
		        answerTextNode.style.color = 'black'; // 글자 색상 설정
		        answerTextNode.style.marginTop = '5px'; // 약간의 위쪽 여백
		        answerTextNode.style.marginLeft = '0px'; 
		        answerTextNode.style.textAlign = 'left'; // 왼쪽 정렬
	
		        
	
		        // 삭제 및 답글 버튼 생성
		        var answerActions = document.createElement('div');
		        answerActions.className = 'answer-actions';
		        answerActions.style.display = 'flex'; // 버튼들을 가로로 배치
		        answerActions.style.flexDirection = 'column'; // 버튼들을 세로로 배치
		        answerActions.style.alignItems = 'center'; // 오른쪽 정렬
		        answerActions.style.marginLeft = '3px'; // answerContent와 버튼 사이 간격 설정
		        
		        var replyButton = document.createElement('button');
		        replyButton.textContent = '답글';
		        replyButton.onclick = function() {
		            toggleReplyForm(answerItem); // 답글 입력 폼을 토글하는 함수 호출
		        };
		        
		        replyButton.style.marginBottom = '7px'; // 버튼 간 간격 설정
		        replyButton.style.fontSize = '20px'; // 버튼 글자 크기 설정
	
		        var deleteButton = document.createElement('button');
		        deleteButton.textContent = '삭제';
		        deleteButton.onclick = function() {
		            // 댓글과 해당 댓글의 모든 답글을 함께 삭제
		            var replyItems = answerItem.parentNode.querySelectorAll('.reply-item');
		            replyItems.forEach(function(replyItem) {
		                if (replyItem.getAttribute('data-parent-id') === answerItem.getAttribute('data-id')) {
		                    replyItem.remove();
		                }
		            });
		            answerItem.remove(); // 댓글 삭제
		        };
		        deleteButton.style.fontSize = '20px'; // 버튼 글자 크기 설정
		        deleteButton.style.color = '#F36060'; // 버튼 텍스트 색상 설정
	
		     // 버튼들을 answerActions에 추가
		        answerActions.appendChild(replyButton);
		        answerActions.appendChild(deleteButton);

		        // 요소들을 answerItem에 추가
		        answerContent.appendChild(answerHeader);
		        answerContent.appendChild(answerTextNode);

		        answerItem.appendChild(userImage); // 이미지 추가
		        answerItem.appendChild(answerContent); // 컨텐츠 추가
		        answerItem.appendChild(answerActions); // 버튼 추가

		        // 댓글 아이템을 댓글 폼에 추가
		        answerForm.appendChild(answerItem);
		        
		        // 입력 필드 초기화
		        input.value = '';
		        answerForm.scrollTop = answerForm.scrollHeight; // 새 댓글 추가 후 스크롤 하단으로 이동
		    }
		}

		// 답글 입력 폼 토글 함수
		function toggleReplyForm(answerItem) {
		    // 현재 클릭된 댓글 아이템 내에 답글 입력 폼이 있는지 확인
		    var existingReplyForm = answerItem.querySelector('.reply-form');

		    if (existingReplyForm) {
		        // 답글 입력 폼이 이미 존재하면 해당 폼 제거 (숨김)
		        existingReplyForm.remove();
		    } else {
		    	
		    	 // 모든 답글 입력 폼을 제거 (다른 폼 닫기)
		        var allReplyForms = document.querySelectorAll('.reply-form');
		        allReplyForms.forEach(function(form) {
		            form.remove();
		        });
		    	
		        // 새 답글 입력 폼 생성
		        var replyForm = document.createElement('div');
		        replyForm.className = 'reply-form';
		        

		        var replyInput = document.createElement('input');
		        replyInput.type = 'text';
		        replyInput.placeholder = ' 답글을 입력하세요.';
		        replyInput.className = 'reply-input';
		        replyInput.style.width = '90%'; // 입력창 너비를 조정하여 버튼과 균형 맞추기
		        replyInput.style.flex = '1'; // 입력창이 공간을 최대한 차지하도록 설정
		        replyInput.style.marginRight = '10px'; // 버튼과 입력창 사이 여백
		        replyInput.style.padding = '8px'; // 입력창 내 여백
		        replyInput.style.fontSize = '15px'; // 글자 크기 설정
		        replyInput.style.height = '10px'; // 입력창의 세로 길이 설정 (버튼과 동일한 높이로 조정)
		        replyInput.style.fontFamily = "'NanumTobak', sans-serif";
		        replyInput.style.border = '1px solid #BAB9AA'; // 테두리 설정
		        replyInput.style.borderRadius = '5px';
		        replyInput.style.backgroundColor = '#f9f9f9';
		        
		        var replyButton = document.createElement('button');
		        replyButton.textContent = '등록';
		        replyButton.style.fontFamily = "'NanumTobak', sans-serif";
		        replyButton.onclick = function() {
		            addReply(answerItem, replyInput.value.trim());
		            replyForm.remove(); // 답글 등록 후 입력 폼 제거
		        };
		        replyButton.style.padding = '4px 8px'; // 버튼 여백 설정
		        replyButton.style.fontSize = '17px'; // 버튼 글자 크기
		        replyButton.style.cursor = 'pointer'; // 커서 모양 설정
		        replyButton.style.height = '28px'; // 버튼의 세로 길이 입력창과 동일하게 설정 (중요)
		        replyButton.style.width = '55px'; // 버튼의 가로 길이 조정
		        replyButton.style.border = '1px solid #BAB9AA'; // 테두리 설정
		        replyButton.style.borderRadius = '5px';
		        replyButton.style.backgroundColor = '#f9f9f9'; // 배경색 설정
		        
		        replyForm.appendChild(replyInput);
		        replyForm.appendChild(replyButton);

		        // 댓글 요소 바로 아래에 답글 폼을 추가
		        answerItem.parentNode.insertBefore(replyForm, answerItem.nextSibling);
		    }
		}

		// 답글 추가 함수
		function addReply(answerItem, replyText) {
		    if (replyText !== '') {
		        // 답글 요소 생성
		        var replyItem = document.createElement('div');
		        replyItem.className = 'reply-item';
		        replyItem.style.display = 'flex';
		        replyItem.style.marginLeft = '30px'; // 답글의 들여쓰기
		        replyItem.style.alignItems = 'center'; // 답글 컨텐츠 정렬
		        replyItem.style.marginBottom = '10px'; // 아래쪽 여백
		        
		        
		        var replyIcon = document.createElement('img');
		        replyIcon.src = 'img/reply-icon.png'; // 답글 아이콘 이미지 경로 설정
		        replyIcon.className = 'reply-icon'; // 답글 아이콘 클래스 추가
		        replyIcon.style.width = '20px'; // 아이콘 크기 설정
		        replyIcon.style.height = '20px';
		        replyIcon.style.marginRight = '10px'; // 아이콘과 내용 사이 여백

		        var userImage = document.createElement('img');
		        userImage.src = 'img/character5.png'; // 짱구 캐릭터 이미지 경로 설정
		        userImage.className = 'user-image'; // 이미지에 클래스 추가
		        userImage.style.width = '35px'; // 이미지 크기 설정
		        userImage.style.height = '35px';
		        userImage.style.borderRadius = '50%'; // 원형 이미지 설정
		        userImage.style.marginRight = '10px'; // 이미지와 내용 사이 여백

		        var replyContent = document.createElement('div');
		        replyContent.className = 'reply-content';
		        replyContent.style.backgroundColor = '#f9f9f9'; // 배경색 설정
		        replyContent.style.border = '1px solid #BAB9AA'; // 테두리 설정
		        replyContent.style.padding = '10px'; // 내용 여백 설정
		        replyContent.style.width = '500px';
		        replyContent.style.display = 'flex';
		        replyContent.style.flexDirection = 'column';
		       
		        var replyHeader = document.createElement('div');
		        replyHeader.style.display = 'flex';
		        replyHeader.style.alignItems = 'center'; // 수직 정렬
		        replyHeader.style.marginBottom = '5px'; // 헤더 아래 여백 추가
		        
		        var userNameContainer = document.createElement('div');
		        userNameContainer.style.display = 'flex'; // 수평 정렬
		        userNameContainer.style.alignItems = 'center'; // 수직 정렬
		        
		        var userName = document.createElement('div');
		        userName.className = 'user-name';
		        userName.textContent = '짱구'; // 사용자 이름
		        userName.style.fontSize = '15px'; // 글자 크기 설정
		        userName.style.fontWeight = 'bold'; // 굵게 설정
		        userName.style.marginRight = '10px'; // 오른쪽 여백 추가
		        
		        var replyTime = document.createElement('div');
		        replyTime.className = 'reply-time';
		        var currentTime = new Date().toLocaleString(); // 현재 시간
		        replyTime.textContent = currentTime; // 현재 시간을 텍스트로 추가
		        replyTime.style.fontSize = '15px'; // 글자 크기 설정
		        replyTime.style.color = 'black'; // 글자 색상 설정
		        
		        
		        replyHeader.appendChild(userName);
		        replyHeader.appendChild(replyTime);
		        
		 
		        var replyTextNode = document.createElement('div');
		        replyTextNode.className = 'reply-text';
		        replyTextNode.textContent = replyText;
		        replyTextNode.style.fontSize = '18px'; // 글자 크기 설정
		        replyTextNode.style.color = 'black'; // 글자 색상 설정
		        replyTextNode.style.marginTop = '5px'; // 약간의 위쪽 여백
		        replyTextNode.style.marginLeft = '0px'; 
		        replyTextNode.style.textAlign = 'left'; // 왼쪽 정렬
		        
		        // 삭제 버튼 추가
		        var deleteReplyButton = document.createElement('button');
		        deleteReplyButton.textContent = '삭제';
		        deleteReplyButton.style.fontSize = '20px';
		        deleteReplyButton.style.marginLeft = '2px';
		        deleteReplyButton.style.border = 'none';
		        deleteReplyButton.style.color = '#F36060'; // 버튼 텍스트 색상 설정
		        deleteReplyButton.style.fontFamily = "'NanumTobak', sans-serif";
		        deleteReplyButton.onclick = function() {
		            replyItem.remove(); // 답글 삭제
		        };

		        replyContent.appendChild(replyHeader);
		        replyContent.appendChild(replyTextNode);

		        replyItem.appendChild(replyIcon);
		        replyItem.appendChild(userImage);
		        replyItem.appendChild(replyContent);
		        replyItem.appendChild(deleteReplyButton); // 삭제 버튼 추가
		        
		        // 답글을 댓글 아래에 추가
		        answerItem.parentNode.insertBefore(replyItem, answerItem.nextSibling);
		    }
		}
	
    </script>
</body>
</html>
