<%@page import="board.BoardWriteBean"%>
<%@page import="board.BoardWriteMgr"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
    String boardNum = request.getParameter("board_num"); // 게시글 번호 가져오기
    BoardWriteMgr mgr = new BoardWriteMgr();
    BoardWriteBean board = mgr.getBoard(Integer.parseInt(boardNum));

    if (board != null) {
        out.print(board.getBoard_answertype()); // 댓글 허용 여부 출력 (0: 비허용, 1: 허용)
    } else {
        out.print(0); // 게시글이 없으면 댓글 허용 안함
    }
%>
