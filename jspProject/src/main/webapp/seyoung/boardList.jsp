<%@page import="board.BoardWriteMgr"%>
<%@page import="board.BoardWriteBean"%>
<%@page import="java.util.Vector"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.sql.Timestamp"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Clover Story</title>
<link rel="stylesheet" type="text/css" href="../seyoung/css/boardList.css">

<style>
@font-face {
    font-family: 'NanumTobak';
    src: url('../나눔손글씨 또박또박.TTF') format('truetype');
}
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

.boardlist-line {
    border-bottom: 1px solid #BAB9AA;
    width: calc(100% - 55px);
    position: absolute; 
    top: 80px; 
    left: 25px; 
}

.inner-box-2 {
    display: flex;
    justify-content: center;
    align-items: center;
    position: relative;
} 

.board-box {
    background-color: #F7F7F7;
    border: 1px solid #BAB9AA;
    width: 820px;
    height: 570px; 
    margin-top:20px;
}

.board-table {
    width: 100%;
    border-collapse: collapse;
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

.folder-container {
    width: 230px;
    height: 700px;
    margin: 10px 11px 100px 10px;
    padding: 20px;
    border: 2px dashed #bbb;  
    border-radius: 30px;      
    background-color: #F7F7F7; 
    flex-direction: column-reverse;
    align-items: flex-start;
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

.folder-input-container input {
    font-family: 'NanumTobak', sans-serif;
    font-size: 18px;
}

.folder-item {
    display: flex;
    align-items: center;
    justify-content: space-between;
    margin-bottom: 8px;
    margin-right: -120px;
    width: 80%;
    padding: 5px;
    border: none;  
}

.folder-item img {
    width: 27px;
    height: 27px;
    margin-right: 7px;
}

.folder-item span {
    font-size: 20px;
    font-weight: 500;
    text-align: left; 
    flex: 2;
}

.folder-item .delete-button {
    cursor: pointer;
    width: 14px;
    height: 14px; 
}

.board-table th {
    border-bottom: 1px dotted #BAB9AA;
    padding: 10px;
    text-align: center;
    font-size: 25px; 
    background-color: #F7F7F7;
    border-bottom: 1px solid #BAB9AA;
}


.board-table th:nth-child(2) {
    padding-right: 25px;
}

input[type="checkbox"] {
    transform: scale(1.5);
}

input[type="checkbox"]:checked {
    accent-color: #545454;
}

.button-group {
    position: absolute;
    top: 35px;
    right: 30px;
    display: flex;
    gap: 10px;
}

.button-group button {
    background: none;
    color: #808080; 
    border: none;
    font-family: 'NanumTobak';
    font-size: 25px; 
    cursor: pointer;
    border-radius: 5px; 
    width: 70px; 
    height: 30px;
}

.button-group .delete-button2 {
    color: #FF5A5A;
}

.button-group .write-button {
    color: black;
}

td {
    text-align: center;
    padding-top: 12px;
    padding-bottom: 12px;
    font-size: 19px;
    border-bottom: 1px dotted #BAB9AA;
}

td a {
    color: black;
    text-decoration: none;
}

.folder-input-container input {
    width: 70%;
    padding: 5px;
    border: none;
    outline: none;
    
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
</style>
</head>

<form class = "bListForm" action="../seyoung/bDelProc.jsp" method="post" onsubmit="return delbList();">
                    <h1 class="board-title">게시판</h1>
                    <div class="button-group">
                        <button onclick = "delbList()" type="submit" class="delete-button2">삭제</button>
                         <button onclick ="clickOpenBox('boardWrite')" type="button" class="write-button">작성</button>
                        </a>
                    </div>
                    <div class="boardlist-line"></div>
                    <div class="board-box">
                        <table class="board-table">
                            <thead>
                                <tr>
                                    <th class="checkbox-cell"><input type="checkbox" id="checkAll"></th>
                                    <th>제목</th>
                                    <th>작성자</th>
                                    <th>작성일</th>
                                    <th>조회수</th>
                                </tr>
                            </thead>
                            <tbody id="board-list-body">
                            	
                            </tbody>
                        </table>
                    </div>
                    </form>     
    <script>     
    
    var currentFolderNum = 1;
	// 체크박스 모두 선택/해제
    document.getElementById("checkAll").onclick = function() {
        var checkboxes = document.getElementsByName("boardNum");
        for (var checkbox of checkboxes) {
            checkbox.checked = this.checked;
        }
    }

    // 게시글 삭제 함수 (AJAX 사용)
    function delbList() {
        var checkboxes = document.querySelectorAll('input[name="boardNum"]:checked');
        if (checkboxes.length === 0) {
            alert('삭제할 게시글을 선택해주세요.');
            return false;
        }
        
        // 버튼을 비활성화하여 중복 요청 방지
        var deleteButton = document.querySelector('.delete-button2');
        deleteButton.disabled = true; // 버튼 비활성화

        // 선택한 게시글의 번호를 수집
        var selectedIds = [];
        checkboxes.forEach(function(checkbox) {
            selectedIds.push(checkbox.value);
        });

        // AJAX 요청을 통해 게시글 삭제
        var xhr = new XMLHttpRequest();
        xhr.open("POST", "../seyoung/bDelProc.jsp", true);
        xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");

        // 삭제할 게시글 번호를 서버로 전송
        xhr.onreadystatechange = function() {
            if (xhr.readyState === 4 && xhr.status === 200) {
            	console.log("응답 내용: " + xhr.responseText.trim());  // 응답 내용을 콘솔에 출력
                var responseText = xhr.responseText.trim();  // 공백 제거 후 응답 확인
                if (responseText === "success") {

                    loadBoardList(currentFolderNum);
                    alert("게시글이 삭제되었습니다.");
                } else {
                	alert("게시글 삭제에 실패했습니다.");
                }
            }
        };

        // 선택한 게시글 번호들을 전송
        xhr.send("boardNums=" + encodeURIComponent(selectedIds.join(',')));

        return false; // 폼 제출 방지 (페이지 새로고침 방지)
    }

    function loadBoardList(folderNum) {
        var xhr = new XMLHttpRequest();
        xhr.open('GET', '../seyoung/getBoardList.jsp?folderNum=' + encodeURIComponent(folderNum), true);
        xhr.onreadystatechange = function() {
            if (xhr.readyState === 4 && xhr.status === 200) {
                // 받은 응답을 board-list-body에 넣어 게시물 목록 갱신
                document.getElementById('board-list-body').innerHTML = xhr.responseText;
            }
        };
        xhr.send(); // 목록 로드 요청
    }

    
</script>


</html>

