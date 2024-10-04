<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>CloverStory</title>
<!-- Linking the CSS file -->
<link rel="stylesheet" type="text/css" href="../seyoung/css/boardWrite.css">
<%
String board_id = request.getParameter("board_id");
String UserId = (String) session.getAttribute("idKey"); // 현재 로그인한 사용자 ID

%>
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

.board-form {
    display: flex;
    flex-direction: column;
    align-items: flex-start;
    padding: 10px;
	width: 780px; /* 너비 조정 */
	border: 1px solid #BAB9AA;
	padding: 20px; /* 내부 여백 */
    background-color: #F7F7F7; /* 배경 색상 */
    margin: 20px 32px; /* 위아래 간격 및 중앙 정렬 */
    height: 610px; 
    position:relative;
    top : 25px;
    
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
    font-size: 26px;
    cursor: pointer;
    color: #f46a6a;
    

    
}

.list-button {
    position: absolute; 
    top: 35px; 
    right: 45px; 
    background: none; 
    border: none; /* 테두리 색상 */
    font-family: 'NanumTobak', sans-serif;
    font-size: 28px; 
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

.button-options .button-group-write {
    display: flex;
    color: #424242; /* 폰트 컬러 추가 */
    margin: 0 -20px 0 0 ;
}

.button-options .button-group-write button {
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

.button-options .button-group-write button img {
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
    width: 14px; /* 쓰레기통 아이콘 크기 */
    height: 14px; 
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
	            // 이미지 미리보기 영역 표시
	            const imagePreviewContainer = document.getElementById('image-preview-container');
	            const imagePreview = document.getElementById('image-preview');
	            imagePreview.src = e.target.result;
	            imagePreviewContainer.style.display = 'block'; // 미리보기 영역 보이기
	        };
	        reader.readAsDataURL(file); // 파일 내용을 읽어 URL로 변환
	    } else {
	        alert("이미지 파일만 업로드할 수 있습니다."); // 유효하지 않은 파일에 대한 경고
	    }
	}


    // 폼 제출 시 폴더 번호와 제목 유효성 확인
    function validateForm() {
        var boardTitleInput = document.querySelector('input[name="board_title"]');
        var boardFolderInput = document.getElementById('board-folder');
        
        // 제목이 비어 있으면 경고 메시지 출력
        if (!boardTitleInput.value.trim()) {
            alert('제목을 입력해주세요.');
            boardTitleInput.focus();
            return false;
        }
        
        // 폴더가 선택되지 않았으면 경고 메시지 출력
        if (!boardFolderInput.value) {
            alert('폴더를 선택해 주세요.');
            return false;
        }
        
        return true;
    }

    
    document.addEventListener('DOMContentLoaded', function() {
        // 폼 제출 시 폴더 번호와 제목, 내용 복사 및 유효성 검사
        var form = document.querySelector('form');
        if (form) {
            form.addEventListener('submit', function(event) {
                if (!validateForm() || !copyContentToTextarea()) {
                    event.preventDefault(); // 유효성 검사를 통과하지 못하면 제출 중단
                }
            });
        }

        // 폴더 선택 시 이벤트 핸들러 추가
        var folderItems = document.querySelectorAll('.folder-item');
        folderItems.forEach(function(folderItem) {
            folderItem.addEventListener('click', function() {
                var folderNum = folderItem.getAttribute('data-folder-num');
                selectFolder(folderNum); // 폴더 선택 시 폴더 번호 설정
            });
        });
    });
    
    function submitbWrite() {
        var formData = new FormData(document.querySelector(".bWriteAddForm"));

        // AJAX 요청 생성
        var xhr = new XMLHttpRequest();
        xhr.open("POST", "../seyoung/bWriteAddProc.jsp", true);

        xhr.onreadystatechange = function() {
            if (xhr.readyState === 4 && xhr.status === 200) {
            	
            	

            	
            	
                // 성공적으로 게시글 등록 후 목록 갱신
                loadBoardList(formData.get('board_folder')); // 폴더 번호에 맞는 게시물 목록 로드
                clickOpenBox('boardList'); // 게시판 목록으로 돌아가기
                
                loadLatestPost(); 
                resetForm(); // 게시글 작성 후 폼 초기화
            }
        };

        xhr.send(formData); // 폼 데이터 전송
    }
    
    function resetForm() {
        document.querySelector(".bWriteAddForm").reset(); // 폼 초기화
        document.getElementById('image-preview-container').style.display = 'none'; // 이미지 미리보기 숨김
        document.getElementById('image-preview').src = ""; // 미리보기 이미지 초기화
    }
    
    
    
</script>


</head>
				<!-- 게시글 작성 폼 -->
                <form class = "bWriteAddForm"  method="post" enctype="multipart/form-data" target="blankifr" >
                    <h1 class="board-title">게시판</h1>
                    <button type="button" class="list-button" onclick="clickOpenBox('boardList')">목록</button>
					
					<input type="hidden" name="board_id" value="<%= UserId %>">
					
                    <!-- 폴더 선택 시 폴더 번호 저장 -->
                    <input type="hidden" name="board_folder" id="selectedFolderNum" value="">
                    
                    <div class="board-form">
                    	
                    	
                    
                        <div class="title-container">
                        
                            <!-- 게시글 제목 입력 -->
                            <input type="text" name="board_title" placeholder=" 제목을 입력해주세요.">
                            <!-- 등록 버튼 -->
                            <button onclick = "submitbWrite()" type="button" class="register-button">등록</button>
                        </div>          
						
						<div id="image-preview-container" style="width: 300px; height: 300px; display: none; border: 1px solid #ccc; margin-top: 10px;">
				            <img id="image-preview" style="width: 100%; height: 100%; object-fit: cover;" alt="사진 미리보기">
				        </div>
						
                        <!-- 게시글 내용 입력 -->
                        <textarea name="board_content" id="board-content-text" class="board_content" placeholder=" 내용을 입력해주세요." required></textarea>
                                           
                        <!-- 파일 입력 필드 -->
                        <input type="file" id="file-input" name="board_image" style="display:none;" accept="image/*" onchange="previewImage(event)">
                        
                        
                        <!-- 하단 옵션 -->
                        <div class="button-options">
                            <!-- 공개 설정 -->
                            <div class="options-group">
                                <label>공개 설정 |</label>
                                <input type="radio" name="board_visibility" value="0"> 전체
                                <input type="radio" name="board_visibility" value="1"> 일촌
                            </div>

                            <!-- 댓글 허용 여부 -->
                            <div class="options-group2">
                                <label>댓글 |</label>
                                <input type="radio" name="board_answertype" value="1"> 허용
                                <input type="radio" name="board_answertype" value="0"> 비허용
                            </div>

                            <!-- 파일 첨부 버튼 -->
                            <div class="button-group-write">
                                <button type="button" onclick="handleFileSelect()">
                                    <img src="../seyoung/img/photo-icon.png" alt="사진">사진
                                </button>
                            </div>
                        </div>
                    </div>
                </form>
</html>