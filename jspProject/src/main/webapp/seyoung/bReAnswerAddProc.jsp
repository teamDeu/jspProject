<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="board.BoardReAnswerBean"%>
<%@page import="board.BoardReAnswerMgr"%>

<%
    String answer_num = request.getParameter("answer_num").trim();
    String reanswer_content = request.getParameter("reanswer_content");
    String reanswer_id = request.getParameter("reanswer_id");

    // answer_num 값이 제대로 전달되고 있는지 확인
    out.println("Received answer_num: " + answer_num + "<br>");
    out.println("Received reanswer_content: " + reanswer_content + "<br>");
    out.println("Received reanswer_id: " + reanswer_id + "<br>");

    // answer_num 값이 null 또는 비어있지 않은지 확인
    if (answer_num != null && !answer_num.isEmpty()) {
        try {
        	int parsedAnswerNum = Integer.parseInt(answer_num.trim());
            out.println("Parsed answer_num: " + parsedAnswerNum + "<br>"); // 변환된 숫자 확인
            
            BoardReAnswerBean reAnswer = new BoardReAnswerBean();
            reAnswer.setAnswer_num(parsedAnswerNum);
            reAnswer.setReanswer_content(reanswer_content);
            reAnswer.setReanswer_id(reanswer_id);

            BoardReAnswerMgr mgr = new BoardReAnswerMgr();
            boolean success = mgr.addReAnswer(reAnswer);

            if (success) {
                out.print("답글 저장 성공");
            } else {
                out.print("답글 저장 실패");
            }
        } catch (NumberFormatException e) {
            out.print("Invalid answer_num format: " + answer_num); // 변환 실패 시 메시지 출력
        }
    } else {
        out.print("필수 데이터 누락");
    }
%>