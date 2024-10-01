<%@page import="board.BoardWriteBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<jsp:useBean id="mgr" class="board.BoardWriteMgr" />


<%
String cPath = request.getContextPath();

String board_id = request.getParameter("board_id");
String UserId = (String) session.getAttribute("idKey"); // 현재 로그인한 사용자 ID

//가장 최근 게시글 불러오기
BoardWriteBean latestBoard = mgr.getLatestBoard();
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>CloverStory</title>
<!-- Linking the CSS file -->
<link rel="stylesheet" type="text/css" href="../seyoung/css/board.css">
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
    cursor: pointer;
    width: 14px;
    height: 14px;
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
	overflow-y: auto; /* 내용이 많을 경우 세로 스크롤 가능하게 설정 */
	overflow-x: hidden; /* 가로 스크롤 숨기기 */
}

.bwrite-content {
	margin-top: 15px;
	padding: 10px;
	font-size: 20px;
	line-height: 1.6;
	color: #333;
	background-color: none;
	border: none;
	width: 100%;
	text-align: left; /* 내용의 텍스트를 왼쪽 정렬 */
}

.bwrite-header {
	display: flex;
	justify-content: space-between;
	width: 100%;
}

.bwrite-header h3 {
	margin: 10px;
	font-size: 22px;
	font-weight: normal;
	white-space: nowrap;
}

.bwrite-header span {
	font-size: 20px;
	margin: 10px 15px 10px 10px;
	color: #666;
	white-space: nowrap;
}

.delete-btn {
	margin-right: 5px;
	background: none;
    color: #FF5A5A;
    border: none;
    font-family: 'NanumTobak', sans-serif;
	font-size: 22px;
}

.brite-content {
	margin: 10px;

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
<h1 class="board-title">게시판</h1>
					<h2 class="board-recentpost"> | 최근게시물</h2>
					<button type="button" class="list-button" onclick="clickOpenBox('boardList')">목록</button>
					<div class="board-line"></div>
					
					<div class="board">
					
						<div class="bwrite-form" id="bwrite-form">
							<jsp:include page="bLatestPost.jsp" />
							
						
						
						</div>
						
						<div class="banswer-form">
							
						
						</div>
						
						<div class="wanswer-form">
							<input type="text" id="ansewerinput" placeholder="  게시판에 댓글을 남겨주세요.">
							<button type="button" onclick="addAnswer()">등록</button>
						</div>
					</div>
	
	<script>
		// 폴더 클릭 시 폴더에 맞는 boardList.jsp로 이동
	    document.querySelectorAll('.folder-item').forEach(function(folderItem) {
	        folderItem.addEventListener('click', function() {
	            var folderId = this.getAttribute('data-folder-id'); // 폴더 ID를 가져옴
	            if (folderId) {
	                // boardList.jsp로 폴더 번호를 넘겨 이동
	                window.location.href = 'boardList.jsp?folderId=' + encodeURIComponent(folderId);
	            }
	        });
	    });
	
	    // 최신 게시글을 다시 로드하는 함수
	    function loadLatestPost() {
	        var xhr = new XMLHttpRequest();
	        xhr.open("GET", "<%= cPath %>/seyoung/bLatestPost.jsp", true); // 최신 게시글을 가져오는 JSP 파일
	        xhr.onreadystatechange = function () {
	            if (xhr.readyState === 4 && xhr.status === 200) {
	                // bwrite-form 영역에 최신 게시글을 삽입
	                document.getElementById("bwrite-form").innerHTML = xhr.responseText;
	            }
	        };
	        xhr.send();
	    }
	    
	    function addAnswer() {
	        var input = document.getElementById('ansewerinput');
	        var answerText = input.value.trim();
	        if (answerText !== '') {
	            // Ajax 요청을 사용하여 서버에 댓글 데이터를 전달
	            var xhr = new XMLHttpRequest();
	            xhr.open("POST", "<%= cPath %>/seyoung/bAnswerAddProc.jsp", true); // 서버 측 처리 파일 호출
	            xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");

	            xhr.onreadystatechange = function () {
	                if (xhr.readyState === 4 && xhr.status === 200) {
	                    input.value = ''; // 입력 필드를 비움
	                    loadAnswers(); // 댓글을 추가한 후 댓글 목록을 다시 로드
	                }
	            };

	            // Ajax 요청 본문에 데이터 전달
	            var boardNum = <%= latestBoard.getBoard_num() %>; // 최신 게시글 번호를 가져옴
	            var answerId = '1234'; // answer_id를 1234로 고정
	            var params = "board_num=" + encodeURIComponent(boardNum) +
	                         "&answer_content=" + encodeURIComponent(answerText) +
	                         "&answer_id=" + encodeURIComponent(answerId); // 고정된 answer_id 사용
	            xhr.send(params);
	        }
	    }

	    window.onload = function() {
	        loadAnswers(); // 페이지가 로드될 때 댓글 목록을 불러오는 함수 호출
	    }

	    function loadAnswers() {
	        var boardNum = <%= latestBoard.getBoard_num() %>; // 현재 게시글 번호 가져오기
	        var xhr = new XMLHttpRequest();
	        xhr.open("GET", "<%= cPath %>/seyoung/bgetAnswer.jsp?board_num=" + encodeURIComponent(boardNum), true);
	        xhr.onreadystatechange = function () {
	            if (xhr.readyState === 4 && xhr.status === 200) {
	                var answerForm = document.querySelector('.banswer-form');
	                answerForm.style.display = 'flex'; // 댓글 영역을 보여줌
	                var answers = JSON.parse(xhr.responseText); // JSON 형식으로 응답을 파싱

	                // 기존 댓글 내용을 초기화
	                answerForm.innerHTML = '';

	                // 서버에서 받은 댓글 데이터를 화면에 추가
	                answers.forEach(function(answer) {
	                    var answerItem = document.createElement('div');
	                    answerItem.className = 'answer-item';
	                    answerItem.style.display = 'flex';
	                    answerItem.style.alignItems = 'flex-start';
	                    answerItem.style.marginBottom = '10px';
	                    answerItem.style.width = '100%';

	                    var userImage = document.createElement('img');
	                    userImage.src = 'img/character2.png';
	                    userImage.alt = '사용자 이미지';
	                    userImage.className = 'user-image';

	                    var answerContent = document.createElement('div');
	                    answerContent.className = 'answer-content';
	                    answerContent.style.backgroundColor = '#f9f9f9';
	                    answerContent.style.border = '1px solid #BAB9AA';
	                    answerContent.style.padding = '10px';
	                    answerContent.style.width = '535px';
	                    answerContent.style.display = 'flex';
	                    answerContent.style.flexDirection = 'column';

	                    var answerHeader = document.createElement('div');
	                    answerHeader.style.display = 'flex';
	                    answerHeader.style.alignItems = 'center';
	                    answerHeader.style.marginBottom = '5px';

	                    var userName = document.createElement('div');
	                    userName.className = 'user-name';
	                    userName.textContent = '홍길동'; // 댓글 작성자 이름 (이 예시에서는 고정값, 서버에서 값을 받을 수도 있음)
	                    userName.style.fontWeight = 'bold';
	                    userName.style.marginRight = '10px';

	                    var answerTime = document.createElement('div');
	                    answerTime.className = 'answer-time';
	                    answerTime.textContent = answer.answer_at; // 댓글 작성 시간
	                    answerTime.style.fontSize = '15px';
	                    answerTime.style.color = 'black';

	                    answerHeader.appendChild(userName);
	                    answerHeader.appendChild(answerTime);

	                    var answerTextNode = document.createElement('div');
	                    answerTextNode.className = 'answer-text';
	                    answerTextNode.textContent = answer.answer_content; // 댓글 내용
	                    answerTextNode.style.fontSize = '18px';
	                    answerTextNode.style.color = 'black';
	                    answerTextNode.style.marginTop = '5px';
	                    answerTextNode.style.textAlign = 'left';

	                    answerContent.appendChild(answerHeader);
	                    answerContent.appendChild(answerTextNode);

	                    // 수정 및 삭제 버튼 추가
	                    var answerActions = document.createElement('div');
	                    answerActions.className = 'answer-actions';
	                    answerActions.style.display = 'flex';
	                    answerActions.style.flexDirection = 'column'; // 세로로 정렬
	                    answerActions.style.alignItems = 'flex-start'; // 왼쪽 정렬
	                    answerActions.style.marginLeft = '15px'; // 약간의 왼쪽여백 추가
	                    answerActions.style.maginTop = '5px';

	                    var editButton = document.createElement('button');
	                    editButton.textContent = '수정';
	                    editButton.style.color = '#2D8E00';
	                    editButton.onclick = function() {
	                        // 수정 기능 로직을 추가합니다.
	                        alert('수정 기능');
	                    };
	                    answerActions.appendChild(editButton);

	                    var deleteButton = document.createElement('button');
	                    deleteButton.textContent = '삭제';
	                    deleteButton.style.color = '#FF5A5A';
	                    

	                    answerActions.appendChild(deleteButton);

	                    // 수정/삭제 버튼을 answerContent에 추가
	                    answerItem.appendChild(userImage);
	                    answerItem.appendChild(answerContent);
	                    answerItem.appendChild(answerActions); // 여기에서 추가
	                    answerForm.appendChild(answerItem);
	                });
	            }
	        };
	        xhr.send();
	    }

		
		
	
    </script>
</body>
</html>
