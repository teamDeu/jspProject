<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="board.BoardAnswerMgr"%>
<%@page import="board.BoardAnswerBean"%>
<%
    // 파라미터 값 가져오기
    String boardNum = request.getParameter("board_num");
    String answerContent = request.getParameter("answer_content");
    String answerId = request.getParameter("answer_id");

    // 댓글 데이터 저장
    BoardAnswerBean answerBean = new BoardAnswerBean();
    answerBean.setBoardNum(Integer.parseInt(boardNum));
    answerBean.setAnswerContent(answerContent);
    answerBean.setAnswerId(answerId);

    BoardAnswerMgr mgr = new BoardAnswerMgr();
    mgr.insertAnswer(answerBean);

    // 성공적으로 저장되었다고 응답
    out.print("success");
%>