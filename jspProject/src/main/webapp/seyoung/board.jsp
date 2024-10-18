<%@page import="board.BoardWriteBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<jsp:useBean id="mgr" class="board.BoardWriteMgr" />


<%
String cPath = request.getContextPath();
String board_id = request.getParameter("board_id");
String UserId = (String) session.getAttribute("idKey"); // 현재 로그인한 사용자 ID
//가장 최근 게시글 불러오기
BoardWriteBean latestBoard = mgr.getLatestBoard(board_id);
int answerType = latestBoard != null ? latestBoard.getBoard_answertype() : -1; // 댓글 허용 여부
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

.bwrite-header2 {
	display: flex;
	justify-content: space-between;
	width: 100%;
	margin-left: -2px;
}

.bwrite-header2 input {
	margin: 10px;
	font-size: 22px;
	font-weight: normal;
	white-space: nowrap;
	border: none;
	background-color: #F7F7F7;
}

.latestDel-btn {
	margin-right: 5px;
	background: none;
    color: #FF5A5A;
    border: none;
    font-family: 'NanumTobak', sans-serif;
	font-size: 22px;
}

.latestEdit-btn {
	margin-right: 5px;
	background: none;
    color: black;
    border: none;
    font-family: 'NanumTobak', sans-serif;
	font-size: 22px;
}

.submitbtn {
	margin-right: 5px;
	background: none;
    color: black;
    border: none;
    font-family: 'NanumTobak', sans-serif;
	font-size: 22px;
}

.canclebtn{
	margin-right: -20px;
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
					<h2 class="board-recentpost" id="board-recentpost3"></h2>
					<button type="button" onclick ="clickAllBoardList()" class="list-button">목록</button>
					<div class="board-line"></div>
					<div class="board">
					
						<div class="bwrite-form" id="bwrite-form">
							
						
						
						</div>
						
						<div class="banswer-form" id="banswer-form">
							
						
						</div>
						
						<div class="wanswer-form" id="wanswer-form" style="display: flex;">
							<input type="text" onkeypress = "baddAnswerEnter(event)" id="ansewerinput" placeholder="  게시판에 댓글을 남겨주세요.">
							<button type="button" onclick="baddAnswer()">등록</button>
						</div>
					</div>
	
	<script>
		var latestBoard = <%= latestBoard != null ? latestBoard.getBoard_num() : "null" %>;	
		
		
		
		
		function baddReAnswerEnter(event,num){
			if(event.keyCode == 13){
				baddReAnswer(num,event.target.value);
				return false;
			}
			else{
				return true;
			}
		}
		function baddAnswerEnter(e) {   
			 if(e.keyCode == 13) { // enter는 13이다!        
				baddAnswer();       
				return false; 
			// 추가적인 이벤트 실행을 방지하기 위해 false 리턴    
			} else {        
				return true;    
				}
		}
			
		function clickAllBoardList(){
			loadBoardListByPage(1);
			clickOpenBox('boardList');
		}
		
		function loadBoardListAll(userId){
	    	var xhr = new XMLHttpRequest();
	        xhr.open('GET', '../seyoung/getBoardListAll.jsp?board_id=' + encodeURIComponent(userId), true);
	        xhr.onreadystatechange = function() {
	            if (xhr.readyState === 4 && xhr.status === 200) {
	                // 받은 응답을 board-list-body에 넣어 게시물 목록 갱신
	                document.getElementById("board-recentpost").innerText = "| 전체게시글";
	                document.getElementById('board-list-body').innerHTML = xhr.responseText;
	                totalPagesValue = document.getElementById('boardList_totalPages').value;
	                updateBoardPaginationButtons(totalPagesValue,1)
	            }
	        };
	        xhr.send(); // 목록 로드 요청
	    }
		
	    document.querySelectorAll('.folder-item').forEach(function(folderItem) {
	        folderItem.addEventListener('click', function() {
	            var folderId = this.getAttribute('data-folder-id'); // 폴더 ID를 가져옴
	            if (folderId) {
	                // boardList.jsp로 폴더 번호를 넘겨 이동
	                window.location.href = 'boardList.jsp?folderId=' + encodeURIComponent(folderId);
	            }
	        });
	    });
	
		
	    // 게시글 삭제 함수
	    function bdellatestPost(boardNum) {
	        if (confirm("정말로 게시글을 삭제하시겠습니까?")) {
	            var xhr = new XMLHttpRequest();
	            xhr.open("POST", "<%= cPath %>/seyoung/bLatestDelProc.jsp", true); // 게시글 삭제 처리 JSP 호출
	            xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");

	            xhr.onreadystatechange = function () {
	                if (xhr.readyState === 4 && xhr.status === 200) {
	                	var response = xhr.responseText.trim();
	                    if (response.startsWith('success')) {
	                        alert("게시글이 삭제되었습니다.");
	                        loadLatestPost();
	                        bloadAnswers();
	                    } else {
	                        alert("게시글 삭제에 실패했습니다.");
	                    }
	                }
	            };

	            // 서버에 게시글 번호 전달
	            var params = "board_num=" + encodeURIComponent(boardNum);
	            xhr.send(params);
	        }
	    }
		
	    function beditlatestPost(boardNum) {
	        // 기존 내용을 수정 폼에 넣기
	        document.getElementById("editForm_" + boardNum).style.display = "block";
	        document.getElementById("editBoardNum_" + boardNum).value = boardNum;

	        var title = document.getElementById("boardTitle_" + boardNum).innerText;
	        var content = document.querySelector(".bwrite-content").innerText;
	        
	        document.getElementById("editBoardTitle_" + boardNum).value = title;
	        document.getElementById("editBoardContent_" + boardNum).value = content;

	        // 기존 제목과 내용을 숨기고 수정 폼을 표시
	        document.getElementById("bwriteHeader_" + boardNum).style.display = "none";
	        document.querySelector(".bwrite-content").style.display = "none";
	        var imageContainer = document.getElementById("boardImageContainer_" + boardNum);
	        if (imageContainer) {
	            imageContainer.style.display = "none";
	        }
	    }

	    function submitEdit(boardNum) {
	        var formData = new FormData(document.getElementById("editForm_" + boardNum));
	        var xhr = new XMLHttpRequest();
	        xhr.open("POST", "<%= cPath %>/seyoung/bLatestEditProc.jsp", true);
	        xhr.onreadystatechange = function () {
	            if (xhr.readyState === 4 && xhr.status === 200) {
	                alert("게시글이 수정되었습니다.");
	    			loadPost(boardNum);
	            }
	        };
	        xhr.send(formData); // 수정된 데이터 서버로 전송
	    }

	    function cancelEdit(boardNum) {
	        document.getElementById("editForm_" + boardNum).style.display = "none";
	        document.getElementById("bwriteHeader_" + boardNum).style.display = "flex";
	        document.querySelector(".bwrite-content").style.display = "block";
	        var imageContainer = document.getElementById("boardImageContainer_" + boardNum);
	        if (imageContainer) {
	            imageContainer.style.display = "block";
	        }
	    }
	    
	    //댓글 추가 함수
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
		                    alert("댓글이 작성되었습니다.");
		                    sendAlarm('<%=board_id%>');
	                }
	            };
				
	            // Ajax 요청 본문에 데이터 전달
	            var boardNum = document.querySelector(".bwrite-form").querySelector(".bwrite-content").id; // 최신 게시글 번호를 가져옴
	            var answerId = "<%= UserId %>"; 
	            var params = "board_num=" + encodeURIComponent(boardNum) +
	                         "&answer_content=" + encodeURIComponent(answerText) +
	                         "&answer_id=" + encodeURIComponent(answerId); 
	            xhr.send(params);
	        }
	    }

	    //댓글 로드 함수
	    function bloadAnswers() {
	    	
	        var bwriteContent = document.querySelector(".bwrite-form").querySelector(".bwrite-content");

	        if(bwriteContent == null){
	        	var banswerForm = document.querySelector('.banswer-form');
                banswerForm.innerHTML = ""; // 서버로부터 받은 HTML을 그대로 삽입
                var answerType = document.getElementById("answerTypeValue").value;
                if (answerType === "1") {
                    document.getElementById('wanswer-form').style.display = 'flex'; // 댓글 허용 시 표시
                } else {
                    document.getElementById('wanswer-form').style.display = 'none'; // 댓글 비허용 시 숨김
                }
	        	return;
	        }
	        var boardNum = bwriteContent.id;
	        var xhr = new XMLHttpRequest();
	        xhr.open("GET", "../seyoung/bLatestPostComments.jsp?board_num=" + boardNum, true);

	        xhr.onreadystatechange = function () {
	            if (xhr.readyState === 4 && xhr.status === 200) {
	                var banswerForm = document.querySelector('.banswer-form');
	                banswerForm.innerHTML = xhr.responseText; // 서버로부터 받은 HTML을 그대로 삽입
	                banswerForm.style.display = 'flex'; // 댓글 폼 보이도록 설정
	            }
	        };

	        xhr.send();
	    }
	    
        
	    
	    
	    //댓글 삭제 함수
	    function bdeleteAnswer(answerNum) {
	        var xhr = new XMLHttpRequest();
	        xhr.open("POST", "<%= cPath %>/seyoung/bAnswerDelProc.jsp", true); // 서버 측 댓글 삭제 처리 파일
	        xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");

	        xhr.onreadystatechange = function () {
	            if (xhr.readyState === 4 && xhr.status === 200) {
	                if (xhr.responseText.trim() === 'success') {
	                    alert("댓글이 삭제되었습니다.");
	                    bloadAnswers(); 
	                } else {
	                    alert("댓글 삭제에 실패했습니다.");
	                }
	            }
	        };

	        var params = "answer_num=" + encodeURIComponent(answerNum); // 삭제할 댓글 번호
	        xhr.send(params);
	    }
	    
	   
	    
	    
	    
	    // 답글을 서버에 저장하는 함수
	    function baddReAnswer(answerNum, replyText) {
	        var xhr = new XMLHttpRequest();
	        xhr.open("POST", "<%= cPath %>/seyoung/bReAnswerAddProc.jsp", true); // 서버 측 처리 파일 호출
	        xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");

	        xhr.onreadystatechange = function () {
	            if (xhr.readyState === 4 && xhr.status === 200) {
	                bloadAnswers(); // 답글 추가 후 전체 댓글 목록을 다시 로드
	                sendAlarm('<%=board_id%>');
	                alert("답글이 작성되었습니다.");
	            }
	        };
	        var answerId = "<%= UserId %>"; // 현재 로그인한 사용자 ID 가져오기
	        var params = "answer_num=" + encodeURIComponent(answerNum) +
	                     "&reanswer_content=" + encodeURIComponent(replyText) +
	                     "&reanswer_id=" + encodeURIComponent(answerId);
	        console.log(params);
	        xhr.send(params);
	    }
	    
	    function updateImageName(boardNum) {
	        var fileInput = document.getElementById("editBoardImage_" + boardNum);
	        if (fileInput.files.length > 0) { // 파일이 선택된 경우에만 이름 업데이트
	            var fileName = fileInput.files[0].name;
	            var label = document.getElementById("imageName_" + boardNum);
	            label.textContent = fileName; // 파일 이름을 라벨 옆에 표시
	        }
	    }
	    
	    
	    // 답글 삭제 함수
	    function bdeleteReAnswer(reAnswerNum) {
	        var xhr = new XMLHttpRequest();
	        xhr.open("POST", "<%= cPath %>/seyoung/bReAnswerDelProc.jsp", true);
	        xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");

	        xhr.onreadystatechange = function () {
	            if (xhr.readyState === 4 && xhr.status === 200) {
	            	console.log(xhr.responseText);  // 서버 응답 값 확인
	                if (xhr.responseText.trim() === 'success') {
	                    alert("답글이 삭제되었습니다.");
	                    // 해당 답글 DOM 요소를 삭제
	                    var reanswerElement = document.querySelector(`[data-reanswer-num="${reAnswerNum}"]`);
	                    if (reanswerElement) {
	                        reanswerElement.remove(); // 답글 삭제
	                    }
	                    bloadAnswers();
	                } else {
	                    alert("답글 삭제에 실패했습니다.");
	                }
	            }
	        };

	        var params = "reanswer_num=" + encodeURIComponent(reAnswerNum);
	        xhr.send(params);
	    }

	    function goBoard(id){
	    	   openBox = document.getElementById(id);
	    	   anotherBox = document.querySelectorAll(".inner-box-2");
	    	   anotherButton = document.querySelectorAll(".custom-button");
	    	   for(i = 0 ; i < anotherBox.length ; i++){
	    	      anotherBox[i].style.display ="none";
	    	   }
	    	   openBox.style.display = "flex";
	    	   anotherButton.forEach((e) => e.style.backgroundColor = "#C0E5AF")
	    	   if(id.includes("board")){
	    	      openButton = document.getElementById("custom-button-board");
	    	      document.getElementById("boardInnerBox").style.display = "block";
	    	      document.getElementById("normalInnerBox").style.display = "none";
	    	   }
	    	   else{
	    	      openButton = document.getElementById("custom-button-"+id);
	    	      document.getElementById("boardInnerBox").style.display = "none";
	    	      document.getElementById("normalInnerBox").style.display = "block";
	    	   }
	    	   openButton.style.backgroundColor = "#F7F7F7";
	    	   
	    	}
	    function clickBoard_boardNum(board_num){
			goBoard('board');
			loadPost(board_num);
			increaseloadPost(board_num);

		}
	    
	 	// 최신 게시글이 로드된 후 댓글을 불러오는 함수 호출
	    function loadLatestPost() {
	        var xhr = new XMLHttpRequest();
	        xhr.open("GET", "../seyoung/bLatestPost.jsp?type=latest&board_id="+encodeURIComponent('<%=board_id%>'), true);
	        xhr.onreadystatechange = function () {
	            if (xhr.readyState === 4 && xhr.status === 200) {
	                document.querySelector(".bwrite-form").innerHTML = xhr.responseText;
	                document.getElementById("board-recentpost3").innerHTML = "| 최근게시물";
	                //console.log(document.querySelector(".bwrite-form").querySelector(".bwrite-content").id);
	                // 서버에서 게시글에 대한 answer_type 값을 받아옴
	                var answerType = document.getElementById("answerTypeValue").value; // bLatestPost.jsp에서 answer_type 값을 전달받음
	                
	                // answer_type 값에 따라 wanswer-form 표시 여부 결정
	                if (answerType === "1") {
	                    document.getElementById('wanswer-form').style.display = 'flex'; // 댓글 허용 시 표시
	                } else {
	                    document.getElementById('wanswer-form').style.display = 'none'; // 댓글 비허용 시 숨김
	                }
	                
	                bloadAnswers(); // 댓글 로드
	            }
	        };

	        xhr.send();
	    }   
	 	
	    //게시글이 로드된 후 댓글을 불러오는 함수 호출
	    function loadPost(board_num) {
	        var xhr = new XMLHttpRequest();
	        xhr.open("GET", "../seyoung/bLatestPost.jsp?type=get&board_num="+board_num, true);
	        xhr.onreadystatechange = function () {
	            if (xhr.readyState === 4 && xhr.status === 200) {
	                document.querySelector(".bwrite-form").innerHTML = xhr.responseText;
	                console.log(document.querySelector(".bwrite-form").querySelector(".bwrite-content").id);
	                postFolderName = document.getElementById("latestBoard_folderName").value;
	                document.getElementById("board-recentpost3").innerHTML = "| " + postFolderName;
	                
	                // 서버에서 게시글에 대한 answer_type 값을 받아옴
	                var answerType = document.getElementById("answerTypeValue").value; // bLatestPost.jsp에서 answer_type 값을 전달받음
	                
	                // answer_type 값에 따라 wanswer-form 표시 여부 결정
	                if (answerType === "1") {
	                    document.getElementById('wanswer-form').style.display = 'flex'; // 댓글 허용 시 표시
	                } else {
	                    document.getElementById('wanswer-form').style.display = 'none'; // 댓글 비허용 시 숨김
	                }
	                
	                bloadAnswers(); // 댓글 로드
	                
	            }
	        };
	        xhr.send();
	    }
	    
	    document.addEventListener('DOMContentLoaded', function () {
	    	bloadAnswers();
	    	loadLatestPost(); // 페이지가 로드될 때 최신 게시글을 불러옴
		})


    </script>
</body>
</html>
