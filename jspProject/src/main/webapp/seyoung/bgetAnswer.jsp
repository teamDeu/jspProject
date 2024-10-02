<%@page import="java.util.Vector"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="board.BoardAnswerMgr"%>
<%@page import="board.BoardAnswerBean"%>
<%
    // 파라미터로 board_num 가져오기
    String boardNum = request.getParameter("board_num");

    // 댓글 목록 불러오기
    BoardAnswerMgr answerMgr = new BoardAnswerMgr();
    Vector<BoardAnswerBean> answerList = answerMgr.bgetAnswers(Integer.parseInt(boardNum));

    // 댓글 데이터를 JSON 형식으로 출력
    response.setContentType("application/json");
    response.setCharacterEncoding("UTF-8");
    StringBuilder json = new StringBuilder();
    json.append("[");
    
    for (int i = 0; i < answerList.size(); i++) {
        BoardAnswerBean answer = answerList.get(i);
        json.append("{");
        json.append("\"answer_id\":\"" + answer.getAnswerId() + "\",");
        json.append("\"answer_content\":\"" + answer.getAnswerContent() + "\",");
        json.append("\"answer_at\":\"" + answer.getAnswerAt() + "\"");
        json.append("}");
        if (i < answerList.size() - 1) {
            json.append(",");
        }
    }
    json.append("]");
    
    out.print(json.toString());
%>