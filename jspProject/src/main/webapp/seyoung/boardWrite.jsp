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


</style>

<script>
    // 파일 선택 창 열기 및 파일 선택 시 이미지 삽입
    function handleFileSelect() {
        document.getElementById('file-input').click(); // 숨겨진 파일 입력 필드를 클릭
    }

    // 파일 업로드 및 이미지 미리보기 설정
    function previewImage(event) {
        var file = event.target.files[0];
        if (file && file.type.match('image.*')) {
            var reader = new FileReader();
            reader.onload = function(e) {
                var boardContentDiv = document.getElementById('board-content');
                if (boardContentDiv) {
                    // div 내부에 이미지 삽입
                    boardContentDiv.innerHTML = "<img src='" + e.target.result + "' alt='첨부 이미지' style='max-width:100%;'><br>" + boardContentDiv.innerHTML;
                    boardContentDiv.classList.remove('empty'); // 이미지 삽입 후 빈 상태 제거
                }
            };
            reader.readAsDataURL(file); // 파일을 읽어 미리보기 설정
        } else {
            alert("이미지 파일만 업로드할 수 있습니다.");
        }
    }
    
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
            <div class="inner-box-1"></div>
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
                                    <img src="img/photo-icon.png" alt="첨부파일">첨부파일
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