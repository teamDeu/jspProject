
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="board.BoardAnswerMgr"%>
<%@page import="board.BoardAnswerBean"%>
<%
    String answerNum = request.getParameter("answer_num");
    boolean suc2 = false;
    
    if (answerNum != null && !answerNum.isEmpty()) {
    	
    	int answerNumInt = Integer.parseInt(answerNum);
    	
    	BoardAnswerMgr mgr = new BoardAnswerMgr();
    	suc2 = mgr.bdeleteAnswer(Integer.parseInt(answerNum));
    	
    }
    	

    if (suc2) {
        out.print("success");
    } else {
        out.print("failure");
    }
%>