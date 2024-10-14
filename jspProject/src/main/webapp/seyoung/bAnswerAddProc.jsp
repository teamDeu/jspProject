<%@page import="board.BoardWriteBean"%>
<%@page import="alarm.AlarmMgr"%>
<%@page import="board.BoardWriteMgr"%>
<%@page import="alarm.AlarmBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="board.BoardAnswerBean"%>
<%@page import="board.BoardAnswerMgr"%>

<%
    // 파라미터 값을 가져옴
    String boardNum = request.getParameter("board_num");
    String answerContent = request.getParameter("answer_content");
    String answerId = request.getParameter("answer_id");

    // 게시글 정보를 불러와서 board_answertype을 확인
    BoardWriteMgr bMgr = new BoardWriteMgr();
    BoardWriteBean board = bMgr.getBoard(Integer.parseInt(boardNum));
    

    
        // BoardAnswerBean 인스턴스 생성 후 값을 설정
        BoardAnswerBean answerBean = new BoardAnswerBean();
        answerBean.setBoardNum(Integer.parseInt(boardNum));
        answerBean.setAnswerContent(answerContent);
        answerBean.setAnswerId(answerId);

        // BoardAnswerMgr를 통해 데이터베이스에 댓글 삽입
        BoardAnswerMgr mgr = new BoardAnswerMgr();
        mgr.binsertAnswer(answerBean);

        // 알람 기능 처리
        AlarmBean alarmBean = new AlarmBean();
        String id = board.getBoard_id();
        if (!(id.equals(answerId))) {
            alarmBean.setAlarm_content_num(Integer.parseInt(boardNum));
            alarmBean.setAlarm_type("게시판 댓글");
            alarmBean.setAlarm_user_id(id);
            AlarmMgr alarmMgr = new AlarmMgr();
            alarmMgr.insertAlarm(alarmBean);
        }

        
    
%>
