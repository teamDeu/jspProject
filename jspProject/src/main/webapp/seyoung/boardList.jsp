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
<link rel="stylesheet" type="text/css" href="css/style.css">
<link rel="stylesheet" type="text/css" href="css/boardList.css">

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

.folder-input-container {
    display: none;
    align-items: center; 
    width: 80%;
    padding: 5px;
    background-color: #fff;
    border: 1px solid #ddd;
    border-radius: 5px;    
    position: absolute;
    top: 622px;
    left: 8%; 
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

.folder-input-container {
    display: none; /* 처음에는 숨겨져 있도록 설정 */
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
<body>
    <div class="container">
        <div class="header">
            <img src="img/logo2.png" alt="CloverStory Logo2" class="logo2">
            <div class="settings">
            <span></span>
                <a href="#">설정</a> <a href="#">로그아웃</a>
            </div>
        </div>
        <div class="dashed-box">
            <div class="solid-box">
                <div class="inner-box-1">
                    <jsp:include page="bInnerbox1.jsp"/>
                </div>
                <div class="image-box">
                    <img src="img/img1.png" alt="Image between boxes 1"
                        class="between-image"> <img src="img/img1.png"
                        alt="Image between boxes 2" class="between-image">
                </div>
                <div align="center" class="inner-box-2">
                    <form action="bDelProc.jsp" method="post">
                    <h1 class="board-title">게시판</h1>
                    <div class="button-group">
                        <button type="submit" class="delete-button2">삭제</button>
                        <a href="boardWrite.jsp">
                         <button type="button" class="write-button">작성</button>
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
                                    <th>조회</th>
                                </tr>
                            </thead>
                            <tbody>
                                <%
                                    // BoardWriteMgr 인스턴스 생성
                                    BoardWriteMgr boardMgr = new BoardWriteMgr();
                                    int folderNum = 30;

                                    if (folderNum > 0) {
                                        Vector<BoardWriteBean> boardList = boardMgr.getBoardList(folderNum);

                                        if (boardList != null && boardList.size() > 0) {
                                            for (BoardWriteBean board : boardList) {
                                                // 시간 데이터를 원하는 형식으로 변환
                                                String formattedDate = "";
									            try {
									                // getBoard_at()이 String 타입이 아니라면 변환 필요
									                Timestamp timestamp = Timestamp.valueOf(board.getBoard_at());
									                SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
									                formattedDate = sdf.format(timestamp);
									            } catch (Exception e) {
									                formattedDate = board.getBoard_at(); // getBoard_at()이 이미 String이라면 그대로 사용
									            }
                                %>
                                                <tr>
                                                    <td><input type="checkbox" name="boardNum" value="<%= board.getBoard_num() %>"></td>
                                                    <td><a href="boardDetail.jsp?boardNum=<%= board.getBoard_num() %>"><%= board.getBoard_title() %></a></td>
                                                    <td><%= board.getBoard_id() %></td>
                                                    <td><%= formattedDate %></td> <!-- 변환된 시간 출력 -->
                                                    <td><%= board.getBoard_views() %></td>
                                                </tr>
                                <%
                                            }
                                        } else {
                                %>
                                            <tr>
                                                <td colspan="5" style="text-align: center;">등록된 게시물이 없습니다.</td>
                                            </tr>
                                <%
                                        }
                                    } else {
                                %>
                                    <tr>
                                        <td colspan="5" style="text-align: center;">유효한 폴더를 선택하세요.</td>
                                    </tr>
                                <%
                                    }
                                %>
                            </tbody>
                        </table>
                    </div>
                    </form>                           
                </div>
            </div>
            <div class="button-container">
                <button class="custom-button">홈</button>
                <button class="custom-button">프로필</button>
                <button class="custom-button">미니룸</button>
                <button class="custom-button" style="background-color: #F7F7F7; font-weight: 600;" >게시판</button>
                <a href="../eunhyo/guestbook.jsp"><button class="custom-button">방명록</button></a>
                <button class="custom-button">상점</button>
                <button class="custom-button">게임</button>
                <button class="custom-button">음악</button>
            </div>
        </div>
    </div>
</body>
<script>
    document.getElementById("checkAll").onclick = function() {
        var checkboxes = document.getElementsByName("boardNum");
        for (var checkbox of checkboxes) {
            checkbox.checked = this.checked;
        }
    }
</script>


</html>




