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
            border-bottom: 1px solid #BAB9AA; 
            width: calc(100% - 55px); 
            position: absolute; 
            top: 80px; 
            left: 25px; 
        }

        .answer-item {
            display: flex;
            flex-direction: column;
            align-items: flex-start;
            padding: 10px;
            margin-bottom: 5px;
            background-color: #f2f2f2;
            border: none;
            box-sizing: border-box;
            width: 90%; 
            position: relative; 
        }

        .answer-item img {
            width: 40px;
            height: 40px;
            margin-right: 10px;
            border-radius: 50%;
        }

        .answer-content {
            background-color: #f9f9f9;
            border: 1px solid #BAB9AA;
            padding: 10px;
            width: 90%;
        }

        .reanswer-form {
            display: flex;
            flex-direction: row;
            align-items: flex-start;
            padding: 10px;
            width: 90%;
            margin-top: 10px;
            background-color: #f9f9f9;
            border: 1px solid #BAB9AA;
        }

        .reanswer-input {
            width: 80%;
            margin-right: 10px;
            padding: 5px;
            border: 1px solid #BAB9AA;
            border-radius: 5px;
        }

        .reanswer-button {
            padding: 5px 10px;
            border: 1px solid #BAB9AA;
            border-radius: 5px;
            background-color: #f2f2f2;
            cursor: pointer;
        }

</style>

</head>
<h1 class="board-title">게시판</h1>
					<h2 class="board-recentpost"> | 최근게시물</h2>
					<button type="button" class="list-button" onclick="clickOpenBox('BoardList');" >목록</button>
					<div class="board-line"></div>
					
					<div class="board">
					
						<div class="bwrite-form" id="bwrite-form">
							<jsp:include page="bLatestPost.jsp" />
							
						
						
						</div>
						
						<div class="banswer-form" id="banswer-form">
							
						
						</div>
						
						<div class="wanswer-form">
							<input type="text" id="ansewerinput" placeholder="  게시판에 댓글을 남겨주세요.">
							<button type="button" onclick="baddAnswer()">등록</button>
						</div>
					</div>
	
	<script>
		
		<%-- function goToUserBoardList() {
		    var userId = "<%= UserId %>"; // 현재 로그인된 사용자 ID를 가져옴
		    if (userId) {
		        // boardList.jsp로 사용자 ID를 넘겨 이동
		        clickOpenBox('BoardList');
		        window.location.href = 'boardList.jsp?userId=' + encodeURIComponent(userId);
		        
		    }
		} --%>	
		
	
	
		
		
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
	                    
	                    bloadAnswers(<%= latestBoard.getBoard_num() %>); // 댓글을 추가한 후 댓글 목록을 다시 로드
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

	    function bloadAnswers(boardNum) {
	    	
	        var xhr = new XMLHttpRequest();
	        xhr.open("GET", "../seyoung/bLatestPostComments.jsp?board_num=" + encodeURIComponent(boardNum), true);

	        xhr.onreadystatechange = function () {
	            if (xhr.readyState === 4 && xhr.status === 200) {
	                var banswerForm = document.querySelector('.banswer-form');
	                banswerForm.innerHTML = xhr.responseText; // 서버로부터 받은 HTML을 그대로 삽입
	                banswerForm.style.display = 'flex'; // 댓글 폼 보이도록 설정
	            }
	        };

	        xhr.send();
	    }
	    
	    function extractLatestBoardNum() {
	        // bLatestPost.jsp에서 가져온 최신 게시물의 번호를 추출하는 함수
	        return document.querySelector('.bwrite-form [data-board-num]').getAttribute('data-board-num');
	    }
	    
	    // 답글을 서버에 저장하는 함수
	    function baddReAnswer(answerNum, replyText) {
	        var xhr = new XMLHttpRequest();
	        xhr.open("POST", "<%= cPath %>/seyoung/bReAnswerAddProc.jsp", true); // 서버 측 처리 파일 호출
	        xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");

	        xhr.onreadystatechange = function () {
	            if (xhr.readyState === 4 && xhr.status === 200) {
	                bloadAnswers(<%= latestBoard.getBoard_num() %>); // 답글 추가 후 전체 댓글 목록을 다시 로드
	            }
	        };

	        var answerId = "<%= UserId %>"; // 현재 로그인한 사용자 ID 가져오기
	        var params = "answer_num=" + encodeURIComponent(answerNum) +
	                     "&reanswer_content=" + encodeURIComponent(replyText) +
	                     "&reanswer_id=" + encodeURIComponent(answerId);
	        
	        console.log(params);
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
	    

	   
		
		

	    function bdeleteAnswer(answerNum) {
	        var xhr = new XMLHttpRequest();
	        xhr.open("POST", "<%= cPath %>/seyoung/bAnswerDelProc.jsp", true); // 서버 측 댓글 삭제 처리 파일
	        xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");

	        xhr.onreadystatechange = function () {
	            if (xhr.readyState === 4 && xhr.status === 200) {
	                if (xhr.responseText === 'success') {
	                    alert("댓글이 성공적으로 삭제되었습니다.");
	                    bloadAnswers(); 
	                } else {
	                    alert("댓글 삭제에 실패했습니다.");
	                }
	            }
	        };

	        var params = "answer_num=" + encodeURIComponent(answerNum); // 삭제할 댓글 번호
	        xhr.send(params);
	    }
	    
	    function extractLatestBoardNum() {
	        return <%= latestBoard.getBoard_num() %>;
	    }
	    
	 // 최신 게시글이 로드된 후 댓글을 불러오는 함수 호출
	    function loadLatestPost() {
	        var xhr = new XMLHttpRequest();
	        xhr.open("GET", "../seyoung/bLatestPost.jsp", true);

	        xhr.onreadystatechange = function () {
	            if (xhr.readyState === 4 && xhr.status === 200) {
	                document.querySelector(".bwrite-form").innerHTML = xhr.responseText;
	                var latestBoardNum = extractLatestBoardNum(); // 최신 게시글 번호 추출
	                if (latestBoardNum) {
	                    bloadAnswers(latestBoardNum); // 댓글 로드
	                }
	            }
	        };

	        xhr.send();
	    }

	    
	    
	    document.addEventListener('DOMContentLoaded', function () {
	    	bloadAnswers(<%= latestBoard.getBoard_num() %>); // 페이지가 로드될 때 댓글 목록을 불러오는 함수 호출
	    	loadLatestPost(); // 페이지가 로드될 때 최신 게시글을 불러옴
		})


    </script>
</body>
</html>
