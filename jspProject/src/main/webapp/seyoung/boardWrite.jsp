<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>CloverStory</title>
<!-- Linking the CSS file -->
<link rel="stylesheet" type="text/css" href="css/style.css">
<link rel="stylesheet" type="text/css" href="css/boardWrite.css">


<style>
/* inner-box-2의 게시판 텍스트 스타일 */
.board-title {
    color: #80A46F; 
    text-align: center; 
    font-size: 36px; 
    font-weight: 600; 
    position: absolute; 
    top: 0px; 
    left: 30px; 
    display: inline-block;
}


/* inner-box-2의 내용이 가운데 정렬*/
.inner-box-2 {
    display: flex;
    justify-content: left;
    align-items: center;
}

.board-form {
    display: flex;
    flex-direction: column;
    align-items: flex-start;
    padding: 10px;
    position: absolute;
    top: 55px; 
	width: 780px; /* 너비 조정 */
	border: 1px solid #BAB9AA;
	padding: 20px; /* 내부 여백 */
    background-color: #F7F7F7; /* 배경 색상 */
    margin: 20px 32px; /* 위아래 간격 및 중앙 정렬 */
    height: 610px; 
    
}

.board-form input[type="text"] {
	font-family: 'NanumTobak', sans-serif;
    width: 530px;
    height: 30px;
    margin: 1px 220px 1px 0;
    border: 1.5px solid #ccc;
    font-size: 20px;
    background-color: #fff; 
    box-sizing: border-box; /* padding과 border를 포함하여 요소 크기 계산 */
    
}

.board-form input[type="text"]::placeholder,
.board-form textarea::placeholder {
	font-family: 'NanumTobak', sans-serif;
	font-size: 20px;
    color: #999; 
}

.board-form .register-button {
    font-family: 'NanumTobak', sans-serif;
    height: 36px;
    padding: 0;
    background: none;
    border: none;
    font-size: 28px;
    cursor: pointer;
    color: #f46a6a;
    

    
}

.list-button {
    position: absolute; 
    top: 25px; 
    right: 30px; 
    background: none; 
    border: none; /* 테두리 색상 */
    font-family: 'NanumTobak', sans-serif;
    font-size: 30px; 
    cursor: pointer; 
    text-decoration: none; 
    color: black; 
}


.board-form .title-container {
    display: flex;
    align-items: center; 
    width: 100%; 
    margin-bottom: 10px; /* 제목과 하단 요소 사이의 간격 설정 */
    padding-bottom: 10px; /* 제목 박스 하단 여백 설정 */
    border-bottom: 1px solid #BAB9AA; /* 하단 테두리 추가 */
     
    
}




.board_content {
    font-family: 'NanumTobak', sans-serif;
    width: 765px;
    margin: 10px 0;
    border: 1.5px solid #ccc;
    font-size: 20px;
    background-color: #fff;
    padding: 5px;
    resize: none; /* 사용자가 크기 조절하지 못하도록 설정 */
    height: 460px; /* 텍스트 에어리어 높이 설정 */
    overflow-y: auto;
    text-align: left;
    position: relative;
}

.board_content.empty:before {
    content: attr(data-placeholder); /* data-placeholder 속성 값으로 대체 */
    font-family: 'NanumTobak', sans-serif;
    font-size: 20px;
    color: #999;
    position: absolute;
    top: 10px;
    left: 10px;
    pointer-events: none; /* 마우스 이벤트 무시 */
}

.image-preview {
	width: 100%;
	height: auto;
	max-width: 200px;
	display: none;
	margin-bottom: 10px;
}

/* 하단 버튼 및 설정 스타일 */
.button-options {
    display: flex;
    justify-content: space-between;
    width: 100%;
    background-color: #F7F7F7; /* 배경색 */
    padding: 10px 20px;
    box-sizing: border-box;
    border-top: 1px solid #BAB9AA;
    margin: 5px 0; 
    color: #424242; /* 폰트 컬러 추가 */
}

.button-options .options-group{
    display: flex;
    align-items: center;
    width: 180px;
    color: #424242; /* 폰트 컬러 추가 */
    border: 1px solid #ccc;
    height: 35px;
    background-color: #fff;
    margin:0 0 0 -20px;
    
    
}

.button-options .options-group2 {
	display: flex;
	align-items: center;
	width: 160px;
	color: #424242;
	border: 1px solid #ccc;
	height: 35px;
	background-color: #fff;
	margin:0 40px 0 -200px; 
}


.button-options .options-group label,
.button-options .options-group2 label {
    font-size: 21px;
    margin-right: 10px;
    margin-left: 10px;
    color: #424242; /* 폰트 컬러 추가 */
    
}



.button-options .options-group input[type="checkbox"],
.button-options .options-group2 input[type="checkbox"] {
	border: 1px solid #424242;
    margin: 0 7px 0 7px;
    color: #424242; /* 폰트 컬러 추가 */
}

.button-options .button-group {
    display: flex;
    color: #424242; /* 폰트 컬러 추가 */
    margin: 0 -20px 0 0 ;
}

.button-options .button-group button {
    display: flex;
    align-items: center;
    justify-content: center;
    width: 100px;
    height: 35px;
    margin-left: 10px;
    background-color: #fff;
    border: 1px solid #ccc;
    cursor: pointer;
    font-size: 20px;
    font-family: 'NanumTobak', sans-serif;
    color: #424242; 
    
}

.button-options .button-group button img {
    margin-right: 5px;
    width: 20px;
    height: 20px;
}

.folder-input-container input {
    width: 70%;
    padding: 5px;
    border: none;
    outline: none;
}

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
    display: flex; /* 처음에는 숨겨져 있도록 설정 */
    align-items: center; 
    width: 80%;
    padding: 5px;
    background-color: #fff;
    border: 1px solid #ddd;
    border-radius: 5px;    
  	position: absolute; /* 요소를 부모 기준으로 절대 위치에 배치 */
    top: 622px; /* 하단에서 40px 위로 */
 	left: 8%; 
    
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


/* 이미지 컨테이너 스타일 */
        .img-container {
            position: relative;
            display: inline-block;
            overflow: hidden;
            /* 초기 너비 설정 */
            width: 200px;
            /* 최소 너비 설정 */
            min-width: 50px;
            /* 커서 변경 */
            cursor: nwse-resize;
            /* 선택 방지 */
            user-select: none;
            /* 테두리 없애기 */
            border: none;
        }

        /* 선택 시 컨테이너에 테두리 추가 */
        .img-container.selected {
            border: 2px dashed #007BFF;
        }

        /* 이미지 스타일 */
        .img-container img {
            display: block;
            width: 100%;
            height: auto;
            object-fit: contain;
        }

        /* 콘텐츠 에디터 스타일 */
        .board_content.empty::before {
            content: attr(data-placeholder);
            color: #aaa;
            pointer-events: none;
            display: block;
        }


</style>

<script>
	//현재 선택된 이미지 컨테이너
	let currentSelected = null;
    // 파일 선택 창 열기 및 파일 선택 시 이미지 삽입
    function handleFileSelect() {
        document.getElementById('file-input').click(); // 숨겨진 파일 입력 필드를 클릭
    }

	 // 파일 업로드 및 이미지 미리보기 설정
    function previewImage(event) {
        const file = event.target.files[0];
        if (file && file.type.match('image.*')) {
            const reader = new FileReader();
            reader.onload = function(e) {
                const boardContentDiv = document.getElementById('board-content');
                if (boardContentDiv) {
                    // 현재 커서 위치 가져오기
                    const selection = window.getSelection();
                    if (!selection.rangeCount) return;
                    const range = selection.getRangeAt(0);

                    // 이미지가 들어갈 컨테이너 div 생성
                    const imgContainer = document.createElement('div');
                    imgContainer.className = 'img-container';
                    imgContainer.style.width = '200px'; // 초기 너비 설정

                    // 이미지 요소 생성
                    const imgElement = document.createElement('img');
                    imgElement.src = e.target.result;
                    imgElement.alt = '첨부 이미지';

                    // 이미지 로드 시 비율 계산
                    imgElement.onload = function() {
                        const aspectRatio = imgElement.naturalWidth / imgElement.naturalHeight;
                        imgContainer.style.height = (imgContainer.offsetWidth / aspectRatio) + 'px';
                        imgContainer.dataset.aspectRatio = aspectRatio.toFixed(2);
                    };

                    // 이미지에 mousedown 이벤트 추가
                    imgElement.addEventListener('mousedown', function(e) {
                        e.preventDefault();
                        selectImage(imgContainer);
                        startResizing(e, imgContainer);
                    });

                    // 이미지에 클릭 이벤트 추가 (선택 토글)
                    imgElement.addEventListener('click', function(e) {
                        e.stopPropagation();
                        selectImage(imgContainer);
                    });

                    // 이미지 컨테이너에 이미지 삽입
                    imgContainer.appendChild(imgElement);

                    // 커서 위치에 이미지 삽입
                    range.insertNode(imgContainer);

                    // 이미지 삽입 후 커서를 다음 줄로 이동
                    range.setStartAfter(imgContainer);
                    range.collapse(true);
                    selection.removeAllRanges();
                    selection.addRange(range);

                    // 줄바꿈 추가
                    const br = document.createElement('br');
                    range.insertNode(br);

                    boardContentDiv.classList.remove('empty');
                }
            };
            reader.readAsDataURL(file);
        } else {
            alert("이미지 파일만 업로드할 수 있습니다.");
        }
    }
    
 	// 이미지 선택 함수
    function selectImage(container) {
        if (currentSelected && currentSelected !== container) {
            currentSelected.classList.remove('selected');
        }
        currentSelected = container;
        container.classList.toggle('selected');
    }

    // 크기 조절 시작
    function startResizing(e, container) {
        const aspectRatio = parseFloat(container.dataset.aspectRatio);
        const startX = e.clientX;
        const startWidth = container.offsetWidth;

        function doResize(e) {
            const deltaX = e.clientX - startX;
            let newWidth = startWidth + deltaX;
            if (newWidth < 50) newWidth = 50; // 최소 너비 설정
            container.style.width = newWidth + 'px';
            container.style.height = (newWidth / aspectRatio) + 'px';
        }

        function stopResize() {
            document.removeEventListener('mousemove', doResize);
            document.removeEventListener('mouseup', stopResize);
        }

        document.addEventListener('mousemove', doResize);
        document.addEventListener('mouseup', stopResize);
    }

    // 클릭 시 이미지 선택 해제
    document.addEventListener('click', function(e) {
        if (currentSelected) {
            currentSelected.classList.remove('selected');
            currentSelected = null;
        }
    });
	// div가 비어 있는지 확인하고 placeholder를 보여주는 함수
    function checkPlaceholder() {
        var boardContentDiv = document.getElementById('board-content');
        if (boardContentDiv) {
            if (boardContentDiv.innerHTML.trim() === '') {
                boardContentDiv.classList.add('empty'); // 내용이 비어 있으면 클래스 추가
            } else {
                boardContentDiv.classList.remove('empty'); // 내용이 있으면 클래스 제거
            }
        }
    }

    // contenteditable div 내용 변경 시 호출
    document.addEventListener('DOMContentLoaded', function() {
        var boardContentDiv = document.getElementById('board-content');
        boardContentDiv.addEventListener('input', checkPlaceholder);
        checkPlaceholder(); // 초기 상태 확인
    });
    
    
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



</head>
<body>
<div class="container">
    <div class="header">
        <img src="img/logo2.png" alt="CloverStory Logo2" class="logo2">
        <div class="settings">
            <a href="#">설정</a> 
            <a href="#">로그아웃</a>
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
                <img src="img/img1.png" alt="Image between boxes 1" class="between-image"> 
                <img src="img/img1.png" alt="Image between boxes 2" class="between-image">
            </div>
            <div align="center" class="inner-box-2">
                <!-- 게시글 작성 폼 -->
                <form >
                    <h1 class="board-title">게시판</h1>
                    <button type="button" class="list-button">목록</button>

                    <div class="board-form">
                        <div class="title-container">
                            <!-- 게시글 제목 입력 -->
                            <input type="text" name="board_title" placeholder=" 제목을 입력해주세요." required>
                            <!-- 등록 버튼 -->
                            <button type="submit" class="register-button">등록</button>
                        </div>          

                        <!-- 게시글 내용 입력 -->
                        <div name="board_content" id="board-content" class="board_content empty" data-placeholder=" 내용을 입력해주세요." contenteditable="true"></div>

                        <!-- 파일 입력 필드 -->
                        <input type="file" id="file-input" name="image-file" style="display:none;" accept="image/*" onchange="previewImage(event)">
                        
                        <!-- 하단 옵션 -->
                        <div class="button-options">
                            <!-- 공개 설정 -->
                            <div class="options-group">
                                <label>공개 설정 |</label>
                                <input type="radio" name="board_visibility" value="0" required> 전체
                                <input type="radio" name="board_visibility" value="1"> 일촌
                            </div>

                            <!-- 댓글 허용 여부 -->
                            <div class="options-group2">
                                <label>댓글 |</label>
                                <input type="radio" name="board_answertype" value="1" required> 허용
                                <input type="radio" name="board_answertype" value="0"> 비허용
                            </div>

                            <!-- 파일 첨부 버튼 -->
                            <div class="button-group">
                                <button type="button" onclick="handleFileSelect()">
                                    <img src="img/photo-icon.png" alt="사진">사진
                                </button>
                            </div>
                        </div>
                    </div>
                </form>
            </div>          
        </div>
    </div>
    
    <!-- 버튼 -->
    <div class="button-container">
        <button class="custom-button">홈</button>
        <button class="custom-button">프로필</button>
        <button class="custom-button">미니룸</button>
        <button class="custom-button" style="background-color: #F7F7F7; font-weight: 600;">게시판</button>
        <button class="custom-button">방명록</button>
        <button class="custom-button">상점</button>
        <button class="custom-button">게임</button>
        <button class="custom-button">음악</button>
    </div>
</div>
</body>


</html>