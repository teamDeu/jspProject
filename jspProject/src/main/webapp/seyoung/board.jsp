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
							<button type="button" onclick="baddAnswer()">등록</button>
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
	    
	    function baddAnswer() {
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
	                    bloadAnswers(); // 댓글을 추가한 후 댓글 목록을 다시 로드
	                }
	            };

	            // Ajax 요청 본문에 데이터 전달
	            var boardNum = <%= latestBoard.getBoard_num() %>; // 최신 게시글 번호를 가져옴
	            var answerId = "<%= UserId %>"; 
	            var params = "board_num=" + encodeURIComponent(boardNum) +
	                         "&answer_content=" + encodeURIComponent(answerText) +
	                         "&answer_id=" + encodeURIComponent(answerId); 
	            xhr.send(params);
	        }
	    }

<<<<<<< HEAD
	    
	 // 답글 버튼을 클릭하면 answer_num을 가져와서 콘솔에 출력
	    function toggleReAnswerForm(button) {
	        var answerItem = button.closest('.answer-item');

	        // answer_id를 기반으로 answer_num을 가져오는 Ajax 요청
	        var answerId = answerItem.querySelector('.user-name').textContent.trim(); // answer_id 가져오기

=======
	    function loadAnswers() {
	        var boardNum = <%= latestBoard.getBoard_num() %>; // 현재 게시글 번호 가져오기
>>>>>>> branch 'main' of https://github.com/teamDeu/jspProject.git
	        var xhr = new XMLHttpRequest();
	        xhr.open("POST", "<%= cPath %>/seyoung/getAnswerNum.jsp", true); // 서버에 answer_num을 요청하는 JSP 파일
	        xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");

	        // 요청 성공 시 answer_num을 콘솔에 출력
	        xhr.onreadystatechange = function () {
	            if (xhr.readyState === 4 && xhr.status === 200) {
	                console.log("Received answer_num: " + xhr.responseText); // 응답 받은 answer_num 출력
	                var receivedAnswerNum = xhr.responseText;

	                // 이후 receivedAnswerNum을 이용해 답글 폼을 추가하거나 다른 작업을 진행할 수 있음
	                addReplyForm(button, receivedAnswerNum); // 폼 추가하는 함수 호출
	            }
	        };

	        // Ajax 요청 본문에 answer_id를 전달
	        var params = "answer_id=" + encodeURIComponent(answerId);
	        xhr.send(params);
	    }

	    
	    

	    // 답글 버튼을 클릭하면 답글 폼을 생성 또는 삭제하는 함수
	    function addReplyForm(button, answerNum) {

	        var answerItem = button.closest('.answer-item');
	        
	        var existingForm = answerItem.nextElementSibling; // answer-item 아래에 있는 요소를 확인
	        
	        if (existingForm && existingForm.classList.contains('reanswer-form')) {
	            // 이미 답글 폼이 존재하면 폼을 제거
	            existingForm.remove();
	        } else {
	            // 답글 폼이 없으면 새로 생성하여 추가
	            var reAnswerForm = document.createElement('div');
	            reAnswerForm.className = 'reanswer-form';
	            reAnswerForm.style.display = 'flex';
	            reAnswerForm.style.flexDirection = 'row';
	            reAnswerForm.style.alignItems = 'flex-start';
	            reAnswerForm.style.padding = '10px';
	            reAnswerForm.style.width = '640px';
	            reAnswerForm.style.marginTop = '-5px';
	            reAnswerForm.style.marginBottom = '10px';
	            reAnswerForm.style.marginLeft = '10px';
	            reAnswerForm.style.border = '1px solid #BAB9AA';
	            reAnswerForm.style.backgroundColor = '#f9f9f9';

	            var reAnswerInput = document.createElement('input');
	            reAnswerInput.type = 'text';
	            reAnswerInput.placeholder = ' 답글을 입력하세요.';
	            reAnswerInput.style.width = '90%';
	            reAnswerInput.style.marginBottom = '5px';
	            reAnswerInput.style.padding = '5px';
	            reAnswerInput.style.border = '1px solid #BAB9AA';
	            reAnswerInput.style.borderRadius = '5px';
	            reAnswerInput.style.fontSize = '15px';

	            var reAnswerButton = document.createElement('button');
	            reAnswerButton.textContent = '등록';
	            reAnswerButton.style.padding = '5px 10px';
	            reAnswerButton.style.border = '1px solid #BAB9AA';
	            reAnswerButton.style.borderRadius = '5px';
	            reAnswerButton.style.backgroundColor = '#f2f2f2';
	            reAnswerButton.style.cursor = 'pointer';
	            reAnswerButton.style.margin = '0px 10px';
	            reAnswerButton.style.fontSize = '15px';
	            reAnswerButton.style.height = '29px';
	            reAnswerButton.style.width = '40px';

	            // 답글 등록 버튼 클릭 시 서버로 전달하는 부분
	            reAnswerButton.onclick = function() {
	                var replyText = reAnswerInput.value.trim();
	                if (replyText !== '') {
	                    baddReAnswer(answerNum, replyText); // selectedAnswerNum을 전달
	                    reAnswerForm.remove(); // 답글 입력 폼 제거
	                }
	            };

	            reAnswerForm.appendChild(reAnswerInput);
	            reAnswerForm.appendChild(reAnswerButton);

	            // answerItem 아래에 답글 폼 추가
	            answerItem.parentNode.insertBefore(reAnswerForm, answerItem.nextSibling);
	        }
	    } 


		// Ajax로 답글을 추가하는 함수
	    function baddReAnswer(answerNum, replyText) {
	        var xhr = new XMLHttpRequest();
	        xhr.open("POST", "<%= cPath %>/seyoung/bReAnswerAddProc.jsp", true);
	        xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");

	        
	        var reanswer_id = "<%= UserId %>";  // 세션에서 사용자 ID를 가져옴
	        var params = "answer_num=" + encodeURIComponent(answerNum) +
	                     "&reanswer_content=" + encodeURIComponent(replyText) +
	                     "&reanswer_id=" + encodeURIComponent(reanswer_id);
	        
	        
	        console.log("Sending answer_num: " + answerNum);
	        
	        xhr.onreadystatechange = function () {
	            if (xhr.readyState === 4 && xhr.status === 200) {
	                // 답글 추가 성공 후 동작을 정의 (필요 시 추가 기능 구현 가능)
	                console.log("Response: " + xhr.responseText);
	                
	                if (xhr.responseText.includes("답글 저장 성공")) {
	                    alert("답글이 성공적으로 저장되었습니다.");
	                } else {
	                    alert("답글 저장 실패: " + xhr.responseText);
	                }
	            }
	        };
	        
	        
	        
	        
	        xhr.send(params);
	    }
		
	   

	    
	    
	    // 답글을 answerItem 아래에 추가하는 함수
	    function baddReply(answerItem, replyText) {
	        var replyItem = document.createElement('div');
	        replyItem.className = 'reply-item';
	        replyItem.style.display = 'flex';
	        replyItem.style.alignItems = 'flex-start';
	        replyItem.style.marginLeft = '60px'; // 부모 댓글에서 약간 들여쓰기
	        replyItem.style.marginBottom = '10px';
	        replyItem.style.width = '100%';

	        // 화살표 이미지 추가
	        var replyIcon = document.createElement('img');
	        replyIcon.src = '<%= request.getContextPath() %>/seyoung/img/reanswer.png'; 
	        replyIcon.alt = 'reply icon';
	        replyIcon.style.width = '20px';
	        replyIcon.style.height = '20px';
	        replyIcon.style.marginRight = '10px';

	        var replyContent = document.createElement('div');
	        replyContent.className = 'reply-content';
	        replyContent.style.backgroundColor = '#f9f9f9';
	        replyContent.style.border = '1px solid #BAB9AA';
	        replyContent.style.padding = '10px';
	        replyContent.style.width = '515px';
	        replyContent.style.display = 'flex';
	        replyContent.style.flexDirection = 'column';

	        var replyHeader = document.createElement('div');
	        replyHeader.style.display = 'flex';
	        replyHeader.style.alignItems = 'center';
	        replyHeader.style.marginBottom = '5px';
	        
	        
	        var reuserImage = document.createElement('img');
	        reuserImage.src = '<%= request.getContextPath() %>/seyoung/img/character4.png'; // 사용자 이미지 경로
	        reuserImage.style.width = '30px'; // 이미지 크기 설정
	        reuserImage.style.height = '30px';
	        reuserImage.style.marginRight = '10px'; // 사용자 이름과 이미지 간격 설정
	        reuserImage.style.borderRadius = '50%'; // 둥근 이미지로 설정
	        

	        var reuserName = document.createElement('div');
	        reuserName.className = 'reuser-name';
	        reuserName.textContent = '사용자'; // 여기에 실제 사용자 이름을 넣을 수 있음
	        reuserName.style.fontWeight = 'bold';
	        reuserName.style.marginRight = '10px';
	        reuserName.style.fontSize = '16px';

	        var replyTime = document.createElement('div');
	        replyTime.className = 'reply-time';
	        replyTime.textContent = new Date().toLocaleString(); // 현재 시간
	        replyTime.style.fontSize = '15px';
	        replyTime.style.color = 'black';
	        replyTime.style.marginTop = '5px';

	        replyHeader.appendChild(reuserImage);
	        replyHeader.appendChild(reuserName);
	        replyHeader.appendChild(replyTime);

	        var replyTextNode = document.createElement('div');
	        replyTextNode.className = 'reply-text';
	        replyTextNode.textContent = replyText;
	        replyTextNode.style.fontSize = '18px';
	        replyTextNode.style.color = 'black';
	        replyTextNode.style.marginTop = '5px';
	        replyTextNode.style.textAlign = 'left';

	        replyContent.appendChild(replyHeader); // 사용자 이름과 시간 추가
	        replyContent.appendChild(replyTextNode);

	        replyItem.appendChild(replyIcon); // 화살표 이미지 추가
	        replyItem.appendChild(replyContent);

	        // 답글을 answerItem 바로 아래에 추가
	        answerItem.parentNode.insertBefore(replyItem, answerItem.nextSibling);
	    }
	    

	    // 기존 댓글 로드 함수에 답글 버튼 이벤트 연결 추가
	    function bloadAnswers() {
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
		                answerItem.style.marginBottom = '5px';
		                answerItem.style.width = '100%';
		                answerItem.style.flexDirection = 'row'; // 세로 정렬
		                
		                
		                // answer_num을 answerItem에 data 속성으로 저장
	                    answerItem.setAttribute('data-answer-num', answer.answer_num);
		
		                var userImage = document.createElement('img');
		                userImage.src = 'img/character2.png';
		                userImage.alt = '사용자 이미지';
		                userImage.className = 'user-image';
		
		                var answerContent = document.createElement('div');
		                answerContent.className = 'answer-content';
		                answerContent.style.backgroundColor = '#f9f9f9';
		                answerContent.style.border = '1px solid #BAB9AA';
		                answerContent.style.padding = '10px';
		                answerContent.style.width = '545px';
		                answerContent.style.display = 'flex';
		                answerContent.style.flexDirection = 'column';
		
		                var answerHeader = document.createElement('div');
		                answerHeader.style.display = 'flex';
		                answerHeader.style.alignItems = 'center';
		                answerHeader.style.marginBottom = '5px';
		
		                var userName = document.createElement('div');
		                userName.className = 'user-name';
		                userName.textContent = answer.answer_id; 
		                userName.style.fontWeight = 'bold';
		                userName.style.marginRight = '10px';
		                userName.style.fontSize = '16px';
		
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
		
		                // 답글 및 삭제 버튼 추가
		                var answerActions = document.createElement('div');
		                answerActions.className = 'answer-actions';
		                answerActions.style.display = 'flex';
		                answerActions.style.flexDirection = 'column'; // 세로로 정렬
		                answerActions.style.alignItems = 'flex-start'; // 왼쪽 정렬
		                answerActions.style.marginLeft = '7px'; // 약간의 왼쪽여백 추가
		                answerActions.style.marginTop = '5px';
		
		                var beditButton = document.createElement('button');
		                beditButton.textContent = '답글';
		                beditButton.onclick = function() {
		                	var answerNum = answerItem.getAttribute('data-answer-num');
		                    toggleReAnswerForm(beditButton, answerNum); // answer_num 전달
		                };
		                answerActions.appendChild(beditButton);
		
		                var delButton = document.createElement('button');
		                delButton.textContent = '삭제';
		                delButton.style.color = '#FF5A5A';
		                delButton.style.marginTop = '7px';
		
		                answerActions.appendChild(delButton);
		
		                // 수정/삭제 버튼을 answerContent에 추가
		                answerItem.appendChild(userImage);
		                answerItem.appendChild(answerContent);
		                answerItem.appendChild(answerActions);
		                answerForm.appendChild(answerItem);
		            });
		        }
		    };
		    xhr.send();
		}

	    window.onload = function() {
	        bloadAnswers(); // 페이지가 로드될 때 댓글 목록을 불러오는 함수 호출
	    };

    </script>
</body>
</html>
