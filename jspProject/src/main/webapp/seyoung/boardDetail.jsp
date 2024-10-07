<%@ page import="board.BoardWriteMgr" %>
<%@ page import="board.BoardWriteBean" %>
<%@ page import="java.util.Vector" %>
<%@ page import="java.sql.Timestamp" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    int boardNum = Integer.parseInt(request.getParameter("boardNum"));
    BoardWriteMgr boardMgr = new BoardWriteMgr();
    BoardWriteBean board = null ;
    String board_id = request.getParameter("board_id");
    String UserId = (String) session.getAttribute("idKey"); // 현재 로그인한 사용자 ID
    
    // 조회수 증가 메서드 호출
    boardMgr.increaseViews(boardNum);
    
    // 특정 게시물 가져오기 (boardNum에 해당하는 게시물 정보)
    Vector<BoardWriteBean> boardList = boardMgr.getBoardList(boardNum);
    if(boardList != null && boardList.size() > 0) {
        board = boardList.get(0);
    }
%>

<!DOCTYPE html>
<html>
<head>
    <title>CloverStory</title>
</head>
<body>
	<h1 class="board-title">게시판</h1>
	<button type="button" onclick ="clickAllBoardList()" class="list-button">목록</button>
	<div class="board-line"></div>
	<div class="board">
					
		<div class="bwrite-form" id="bwrite-form">
	
							
						
						
	</div>
						
	<div class="banswer-form" id="banswer-form">
							
						
	</div>
						
	<div class="wanswer-form">
		<input type="text" id="ansewerinput" placeholder="  게시판에 댓글을 남겨주세요.">
		<button type="button" onclick="baddAnswer()">등록</button>
	</div>
	</div>
</body>
</html>