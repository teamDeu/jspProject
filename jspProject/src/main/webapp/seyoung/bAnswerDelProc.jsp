
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="board.BoardAnswerMgr"%>
<%@page import="board.BoardAnswerBean"%>
<%
    String answerNum = request.getParameter("answer_num");
    boolean success = false;
    
    if (answerNum != null && !answerNum.isEmpty()) {
    	
    	int answerNumInt = Integer.parseInt(answerNum);
    	
    	BoardAnswerMgr mgr = new BoardAnswerMgr();
    	success = mgr.bdeleteAnswer(Integer.parseInt(answerNum));
    	
    }
    	

    if (success) {
        out.print("success");
    } else {
        out.print("failure");
    }
%>