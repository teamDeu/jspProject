<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="board.BoardReAnswerBean"%>
<%@page import="board.BoardReAnswerMgr"%>

<%
    String answer_num = request.getParameter("answer_num");
    String reanswer_content = request.getParameter("reanswer_content");
    String reanswer_id = request.getParameter("reanswer_id");

    // answer_num이 null이거나 빈 문자열인지 확인 후 처리
    if (answer_num != null && !answer_num.isEmpty()) {
        BoardReAnswerBean reAnswer = new BoardReAnswerBean();
        reAnswer.setAnswer_num(Integer.parseInt(answer_num));
        reAnswer.setReanswer_content(reanswer_content);
        reAnswer.setReanswer_id(reanswer_id);

        BoardReAnswerMgr mgr = new BoardReAnswerMgr();
        boolean success = mgr.addReAnswer(reAnswer);

        if (success) {
            out.print("답글 저장 성공");
        } else {
            out.print("답글 저장 실패");
        }
    } else {
        out.print("Invalid answer_num");
    }
%>