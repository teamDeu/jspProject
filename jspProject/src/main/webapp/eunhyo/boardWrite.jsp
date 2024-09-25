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
                    <form>
                        <h1 class="board-title">게시판</h1>
                        <a href="boardList.jsp">
                            <button type="button" class="list-button">목록</button>
                        </a>

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
                                        <img src="img/photo-icon.png" alt="첨부파일">사진
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
            <a href="guestbook.jsp"><button class="custom-button">방명록</button></a>
            <button class="custom-button">상점</button>
            <button class="custom-button">게임</button>
            <button class="custom-button">음악</button>
        </div>
    </div>

    <script>
        // 현재 선택된 이미지 컨테이너
        let currentSelected = null;

        // 파일 선택 창 열기
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
            const boardContentDiv = document.getElementById('board-content');
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
            const boardContentDiv = document.getElementById('board-content');
            boardContentDiv.addEventListener('input', checkPlaceholder);
            checkPlaceholder(); // 초기 상태 확인
        });
    </script>
</body>
</html>
