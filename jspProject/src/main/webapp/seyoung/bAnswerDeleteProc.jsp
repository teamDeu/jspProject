
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="board.BoardAnswerMgr"%>
<%@page import="board.BoardAnswerBean"%>
<%
    // 요청으로 전달된 answer_num을 받아옵니다.
    String answerNumStr = request.getParameter("answer_num");

    // 예외 처리를 위해 초기 값을 설정합니다.
    if (answerNumStr == null || answerNumStr.isEmpty()) {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        out.print("{\"status\": \"error\", \"message\": \"Missing answer_num parameter\"}");
        out.flush();
        return;
    }

    // answer_num을 정수로 변환합니다.
    int answerNum = 0;
    try {
        answerNum = Integer.parseInt(answerNumStr);
    } catch (NumberFormatException e) {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        out.print("{\"status\": \"error\", \"message\": \"Invalid answer_num format: " + answerNumStr + "\"}");
        out.flush();
        return;
    }

    // 댓글 삭제를 위해 BoardAnswerMgr 인스턴스를 생성합니다.
    BoardAnswerMgr mgr = new BoardAnswerMgr();

    try {
        // 댓글 삭제 메서드를 호출합니다.
        mgr.deleteAnswer(answerNum);

        // 성공 응답을 보냅니다.
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        out.print("{\"status\": \"success\", \"message\": \"Comment deleted successfully\"}");
        out.flush();
    } catch (Exception e) {
        // 삭제 중 오류가 발생한 경우
        e.printStackTrace();
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        out.print("{\"status\": \"error\", \"message\": \"" + e.getMessage() + "\"}");
        out.flush();
    }
%>