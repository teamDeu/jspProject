<%@ page import="board.BoardWriteMgr" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    BoardWriteMgr boardMgr = new BoardWriteMgr();
    String[] boardNums = request.getParameterValues("boardNums");

    boolean isDeleted = false;

    if (boardNums != null && boardNums.length > 0) {
        int[] numsToDelete = new int[boardNums.length];
        for (int i = 0; i < boardNums.length; i++) {
            numsToDelete[i] = Integer.parseInt(boardNums[i]);
        }
        isDeleted = boardMgr.deleteMultipleBoards(numsToDelete); // 여러 게시물 삭제 메서드 호출
    }

    // 삭제 성공 여부에 따라 응답 반환
    if (isDeleted) {
        out.print("success");
    } else {
        out.print("fail");
    }
%>
