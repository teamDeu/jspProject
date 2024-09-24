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
    width: 100%;
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
        function toggleFolderInput() {
            var inputContainer = document.getElementById('folderInputContainer');
            if (inputContainer.style.display === 'flex') {
                inputContainer.style.display = 'none';
            } else {
                inputContainer.style.display = 'flex';
            }
        }
        
        function addFolder() {
            var folderNameInput = document.getElementById('folderNameInput');
            var folderName = folderNameInput.value.trim();

            if (folderName !== '') {
                var folderContainer = document.querySelector('.folder-container');

                // 기존 폴더 아이템의 수를 계산하여 새로운 폴더의 top 값을 결정
                var folderItems = folderContainer.querySelectorAll('.folder-item');
                var newTop = folderItems.length * 32; // 각 폴더 높이 27px + 간격 5px = 32px

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

                // 폴더 아이템의 위치를 컨테이너의 (0, newTop)으로 설정
                folderItem.style.position = 'absolute'; // 절대 위치 지정
                folderItem.style.top = newTop + 'px'; // 위쪽 위치
                folderItem.style.left = '0'; // 왼쪽 위치

                // 폴더 아이템을 컨테이너에 추가
                folderContainer.appendChild(folderItem);

                // 입력 필드 초기화
                folderNameInput.value = '';
            }
        }

        // 폴더 위치를 재조정하는 함수
        function updateFolderPositions() {
            var folderContainer = document.querySelector('.folder-container');
            var folderItems = folderContainer.querySelectorAll('.folder-item');
            
            folderItems.forEach(function(folderItem, index) {
                var newTop = index * 32; // 각 폴더 높이 27px + 간격 5px = 32px
                folderItem.style.top = newTop + 'px';
            });
        }




        
    </script>
</body>
</html>
