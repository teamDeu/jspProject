<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="board.BoardReAnswerBean"%>
<%@page import="board.BoardReAnswerMgr"%>

<%
	String answer_num = request.getParameter("answer_num");
	String reanswer_content = request.getParameter("reanswer_content");
	String reanswer_id = request.getParameter("reanswer_id");
	
	int answerNumInt = 0; // 기본값 설정
	
	// answer_num이 null이거나 변환이 불가능한 경우 예외 처리
	try {
	    if (answer_num != null && !answer_num.isEmpty()) {
	        answerNumInt = Integer.parseInt(answer_num);
	    } else {
	        throw new NumberFormatException("answer_num 값이 유효하지 않습니다.");
	    }
	} catch (NumberFormatException e) {
	    out.print("답글 저장 실패: 잘못된 answer_num 값");
	    return; // 잘못된 값이 있을 경우 더 이상 진행하지 않음
	}
	
	// reanswer_content 또는 reanswer_id가 null인 경우 처리
	if (reanswer_content == null || reanswer_content.isEmpty() || reanswer_id == null || reanswer_id.isEmpty()) {
	    out.print("답글 저장 실패: reanswer_content 또는 reanswer_id 값이 유효하지 않습니다.");
	    return;
	}
	
	BoardReAnswerBean reAnswer = new BoardReAnswerBean();
	reAnswer.setAnswer_num(answerNumInt);
	reAnswer.setReanswer_content(reanswer_content);
	reAnswer.setReanswer_id(reanswer_id);
	
	BoardReAnswerMgr mgr = new BoardReAnswerMgr();
	boolean success = mgr.addReAnswer(reAnswer);
	
	if (success) {
	    out.print("답글 저장 성공");
	} else {
	    out.print("답글 저장 실패: 데이터베이스 오류");
	}
%>