<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="board.BoardAnswerMgr"%>

<%
    String answerId = request.getParameter("answer_id");
    BoardAnswerMgr mgr = new BoardAnswerMgr();

    // answerId를 기반으로 answer_num을 가져옴
    int answerNum = mgr.getAnswerNumById(answerId);

    // 클라이언트에게 answer_num 반환
    out.print(answerNum);
%>