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
    margin: 10px 11px 10px 10px;
    padding: 20px;
    border: 2px dashed #bbb;  
    border-radius: 30px;      
    background-color: #F7F7F7; 
    display: flex;
    justify-content: center;
    align-items: center;
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
    margin-bottom: 8px;
    width: 100%;
}

.folder-item img {
    width: 27px; /* 아이콘 크기 조정 */
    height: 27px; /* 아이콘 크기 조정 */
    margin-right: 10px; /* 폴더명과 간격 */
}

.folder-item span {
    font-size: 16px;
    font-weight: 500;
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
                
                // 새로운 폴더 아이템 생성
                var folderItem = document.createElement('div');
                folderItem.classList.add('folder-item');

                var folderIcon = document.createElement('img');
                folderIcon.src = 'img/folder.png';
                folderIcon.alt = 'Folder Icon';

                var folderNameSpan = document.createElement('span');
                folderNameSpan.textContent = folderName;

                folderItem.appendChild(folderIcon);
                folderItem.appendChild(folderNameSpan);

                // 폴더 컨테이너에 추가
                folderContainer.insertBefore(folderItem, folderContainer.children[folderContainer.children.length - 1]);

                // 입력 필드 초기화
                folderNameInput.value = '';
            }
        }
        
    </script>
</body>
</html>
