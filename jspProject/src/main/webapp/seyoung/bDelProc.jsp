<%@ page import="board.BoardWriteMgr" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    BoardWriteMgr boardMgr = new BoardWriteMgr();
    String boardNumsParam = request.getParameter("boardNums");

    boolean isDeleted = false;

    if (boardNumsParam != null && !boardNumsParam.isEmpty()) {
        String[] boardNumsArray = boardNumsParam.split(","); // 콤마로 구분된 문자열을 배열로 변환
        int[] numsToDelete = new int[boardNumsArray.length];
        
        try {
            for (int i = 0; i < boardNumsArray.length; i++) {
                numsToDelete[i] = Integer.parseInt(boardNumsArray[i].trim()); // 각 값을 정수로 변환
            }
            isDeleted = boardMgr.deleteMultipleBoards(numsToDelete); // 여러 게시물 삭제 메서드 호출
        } catch (NumberFormatException e) {
            // 숫자로 변환 중 예외 처리
            e.printStackTrace();
        }
    }

    // 삭제 성공 여부에 따라 응답 반환
    if (isDeleted) {
        out.print("success");
    } else {
        out.print("fail");
    }
%>