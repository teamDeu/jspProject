<%@page import="board.BoardReAnswerMgr"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<jsp:useBean id="rMgr" class="board.BoardReAnswerMgr" />

<%
    String reanswerNum = request.getParameter("reanswer_num");
    boolean suc = false;

    if (reanswerNum != null && !reanswerNum.isEmpty()) {
        suc = rMgr.deleteReAnswer(Integer.parseInt(reanswerNum));
    }

    if (suc) {
        out.print("success");
    } else {
        out.print("failure");
    }
%>
