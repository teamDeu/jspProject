<%@ page import="board.BoardWriteMgr" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    // BoardWriteMgr 인스턴스 생성
    BoardWriteMgr boardMgr = new BoardWriteMgr();
    // 삭제할 boardNum 파라미터 가져오기
    String[] boardNums = request.getParameterValues("boardNum");

    boolean isDeleted = false;

    if (boardNums != null && boardNums.length > 0) {
        int[] numsToDelete = new int[boardNums.length];
        for (int i = 0; i < boardNums.length; i++) {
            numsToDelete[i] = Integer.parseInt(boardNums[i]);
        }
        isDeleted = boardMgr.deleteMultipleBoards(numsToDelete); // 여러 게시물 삭제 메서드 호출
    }

    if (isDeleted) {
        out.println("<script>alert('게시물이 성공적으로 삭제되었습니다.'); location.href='boardList.jsp';</script>");
    } else {
        out.println("<script>alert('게시물 삭제에 실패하였습니다. 다시 시도해주세요.'); history.back();</script>");
    }
%>
