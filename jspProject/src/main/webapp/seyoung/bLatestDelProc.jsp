<%@page import="board.BoardWriteBean"%>
<%@page import="board.BoardWriteMgr"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
    String boardNum = request.getParameter("board_num");
    boolean suc3 = false;
    BoardWriteBean nextBoard = null;

    if (boardNum != null && !boardNum.isEmpty()) {
        int boardNumInt = Integer.parseInt(boardNum);
        BoardWriteMgr mgr = new BoardWriteMgr();
        suc3 = mgr.deletePostAndComments(boardNumInt); // 게시글 및 댓글, 대댓글 삭제

        if (suc3) {
            nextBoard = mgr.getNextLatestBoard(boardNumInt); // 다음 최신 게시글 불러오기
        }
    }

    if (suc3 && nextBoard != null) {
        out.print("success;" + nextBoard.getBoard_num() + ";" + nextBoard.getBoard_title() + ";" +
                  nextBoard.getBoard_content() + ";" + nextBoard.getBoard_at());
    } else {
        out.print("failure");
    }
%>
