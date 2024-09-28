<%@ page import="board.BoardWriteMgr" %>
<%@ page import="board.BoardWriteBean" %>
<%@ page import="java.util.Vector" %>
<%@ page import="java.sql.Timestamp" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    int boardNum = Integer.parseInt(request.getParameter("boardNum"));
    BoardWriteMgr boardMgr = new BoardWriteMgr();
    BoardWriteBean board = null;
    
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
    <title><%= board.getBoard_title() %></title>
    <link rel="stylesheet" type="text/css" href="css/style.css">
</head>
<body>
    <div class="container">
        <h1><%= board.getBoard_title() %></h1>
        <p>작성자: <%= board.getBoard_id() %></p>
        <p>작성일: <%= board.getBoard_at() %></p>
        <p>조회수: <%= board.getBoard_views() %></p> <!-- 조회수 표시 -->
        <p><%= board.getBoard_content() %></p>
    </div>
</body>
</html>