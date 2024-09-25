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
    width: 100%; /* 전체 너비 차지 */
    position: relative; /* 내부 요소의 위치 조정 */
}

.answer-item img {
    width: 40px;
    height: 40px;
    margin-right: 10px;
    border-radius: 50%;
}

.answer-content {
    display: flex;
    flex-direction: column; /* 이름과 내용을 수직으로 배치 */
    align-items: flex-start; /* 왼쪽 정렬 */
    flex: 1; /* 나머지 공간을 차지하도록 설정 */
}



.user-name {
    font-size: 16px;
    font-weight: bold;
    margin-bottom: 3px;
}

.user-image {
    width: 40px;
    height: 40px;
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
    font-family: 'NanumTobak', sans-serif; /* 원하는 폰트 스타일 적용 */
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
                    <div class="folder-container">
                      	
                      	<div class="folder-input-container" id="folderInputContainer">
                            <img src="img/folder.png" alt="Folder Icon">
                            <input type="text" id="folderNameInput" placeholder="폴더명을 입력하세요.">
                            <button onclick="addFolder()">
                            	<img src="img/plus.png">
                            </button>
                        </div>
    	
                        <button class="folder-manage-button" onclick="toggleFolderInput()">폴더 관리 하기</button>
					</div>	
				
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
	
		        // 사용자 이미지 요소 생성
		        var userImage = document.createElement('img');
		        userImage.src = 'img/character2.png'; // 사용자 이미지 경로 설정
		        userImage.alt = '사용자 이미지'; // 대체 텍스트
		        userImage.className = 'user-image'; // 이미지에 클래스 추가
	
		        // 댓글 내용과 사용자 이름을 포함할 컨텐츠 생성
		        var answerContent = document.createElement('div');
		        answerContent.className = 'answer-content';
	
		        // 사용자 이름 추가
		        var userName = document.createElement('div');
		        userName.className = 'user-name';
		        userName.textContent = '홍길동'; // 사용자 이름
	
		        // 댓글 내용 추가
		        var answerTextNode = document.createElement('div');
		        answerTextNode.className = 'answer-text';
		        answerTextNode.textContent = answerText;
	
		        answerContent.appendChild(userName); // 이름 추가
		        answerContent.appendChild(answerTextNode); // 댓글 내용 추가
	
		        // 삭제 및 답글 버튼 생성
		        var answerActions = document.createElement('div');
		        answerActions.className = 'answer-actions';
	
		        var replyButton = document.createElement('button');
		        replyButton.textContent = '답글';
	
		        var deleteButton = document.createElement('button');
		        deleteButton.textContent = '삭제';
		        deleteButton.onclick = function() {
		            answerItem.remove();
		            separator.remove(); // 댓글 삭제 시 구분선도 삭제
		        };
	
		        answerActions.appendChild(replyButton);
		        answerActions.appendChild(deleteButton);
	
		        // 요소들을 answerItem에 추가
		        answerItem.appendChild(userImage); // 이미지 추가
		        answerItem.appendChild(answerContent); // 컨텐츠 추가
		        answerItem.appendChild(answerActions); // 버튼 추가
	
		        // 구분선 추가
		        var separator = document.createElement('div');
		        separator.style.width = '100%';
		        separator.style.height = '1px';
		        separator.style.backgroundColor = '#ccc';
		        separator.style.margin = '3px 0'; // 상하 여백 추가
	
		        answerForm.appendChild(answerItem); // 댓글 추가
		        answerForm.appendChild(separator); // 구분선 추가
	
		        input.value = ''; // 입력 필드 초기화
		    }
		}




	
		function toggleFolderInput() {
		    var inputContainer = document.getElementById('folderInputContainer');
		    var deleteButtons = document.querySelectorAll('.delete-button');
	
		    if (inputContainer.style.display === 'flex') {
		        inputContainer.style.display = 'none';
		        
		        // 삭제 버튼 숨기기
		        deleteButtons.forEach(function(button) {
		            button.style.display = 'none';
		        });
		    } else {
		        inputContainer.style.display = 'flex';
		        
		        // 삭제 버튼 보이기
		        deleteButtons.forEach(function(button) {
		            button.style.display = 'inline-block';
		        });
		    }
		}

        
        function addFolder() {
            var folderNameInput = document.getElementById('folderNameInput');
            var folderName = folderNameInput.value.trim();

            if (folderName !== '') {
                var folderContainer = document.querySelector('.folder-container');

                // 기존 폴더 아이템의 수를 계산하여 새로운 폴더의 top 값을 결정
                var folderItems = folderContainer.querySelectorAll('.folder-item');
                var baseTop = 13; // 첫 번째 폴더 아이템의 기본 top 값 (상단에서 10px 아래)
                var folderHeight = 27; // 폴더 아이템의 높이
                var folderGap = 7; // 폴더 아이템 간의 간격
                var newTop = baseTop + folderItems.length * (folderHeight + folderGap); // 새로운 폴더의 top 값

                // 새로운 폴더 아이템 생성
                var folderItem = document.createElement('div');
                folderItem.classList.add('folder-item');

                var folderIcon = document.createElement('img');
                folderIcon.src = 'img/folder.png';
                folderIcon.alt = 'Folder Icon';

                var folderNameSpan = document.createElement('span');
                folderNameSpan.textContent = folderName;

                // 삭제 버튼 생성
                var deleteButton = document.createElement('img');
                deleteButton.src = 'img/trashcan.png'; // 쓰레기통 이미지 경로 설정
                deleteButton.alt = 'Delete';
                deleteButton.classList.add('delete-button');
                deleteButton.onclick = function() {
                    folderItem.remove(); // 폴더 항목 삭제
                    updateFolderPositions(); // 폴더 위치 재조정
                };

                // 폴더 아이템에 요소 추가
                folderItem.appendChild(folderIcon);
                folderItem.appendChild(folderNameSpan);
                folderItem.appendChild(deleteButton);

                // 폴더 아이템의 위치를 컨테이너의 (newLeft, newTop)으로 설정
                var newLeft = 20; // 폴더 아이템을 오른쪽으로 20px 이동
                folderItem.style.position = 'absolute'; // 절대 위치 지정
                folderItem.style.top = newTop + 'px'; // 위쪽 위치
                folderItem.style.left = newLeft + 'px'; // 왼쪽 위치 (오른쪽으로 이동)

                // 폴더 아이템을 컨테이너에 추가
                folderContainer.appendChild(folderItem);

                // 입력 필드 초기화
                folderNameInput.value = '';
            }
        }


        function updateFolderPositions() {
            var folderContainer = document.querySelector('.folder-container');
            var folderItems = folderContainer.querySelectorAll('.folder-item');
            var baseTop = 13; // 첫 번째 폴더 아이템의 기본 top 값 (상단에서 10px 아래)
            var folderHeight = 27; // 폴더 아이템의 높이
            var folderGap = 7; // 폴더 아이템 간의 간격
            var newLeft = 20; // 폴더 아이템을 오른쪽으로 20px 이동
            
            folderItems.forEach(function(folderItem, index) {
                var newTop = baseTop + index * (folderHeight + folderGap); // 새로운 top 계산
                folderItem.style.top = newTop + 'px';
                folderItem.style.left = newLeft + 'px'; // 위치 조정
            });
        }
    </script>
</body>
</html>
