<%@ page import="board.BoardWriteMgr" %>
<%@ page import="board.BoardWriteBean" %>
<%@ page import="java.util.Vector" %>
<%@ page import="java.sql.Timestamp" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
String boardNumStr = request.getParameter("boardNum");

if (boardNumStr != null && !boardNumStr.isEmpty()) {
    int boardNum = Integer.parseInt(boardNumStr); // boardNum 값이 null이 아니면 변환
    BoardWriteMgr boardMgr = new BoardWriteMgr();
    
    // 조회수 증가 메서드 호출
    boardMgr.increaseViews(boardNum);
} else {
    out.println("게시글 번호가 전달되지 않았습니다.");
}
%>
