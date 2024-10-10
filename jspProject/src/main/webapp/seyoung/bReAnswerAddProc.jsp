<%@page import="board.BoardWriteMgr"%>
<%@page import="board.BoardAnswerMgr"%>
<%@page import="alarm.AlarmMgr"%>
<%@page import="alarm.AlarmBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="board.BoardReAnswerBean"%>
<%@page import="board.BoardReAnswerMgr"%>    

<%

	// 파라미터 값을 가져옴
    String answerNum = request.getParameter("answer_num");
    String reAnswerContent = request.getParameter("reanswer_content");
    String reAnswerId = request.getParameter("reanswer_id");

    // BoardReAnswerBean 인스턴스 생성 후 값을 설정
    BoardReAnswerBean reAnswerBean = new BoardReAnswerBean();
    reAnswerBean.setAnswer_num(Integer.parseInt(answerNum));
    reAnswerBean.setReanswer_content(reAnswerContent);
    reAnswerBean.setReanswer_id(reAnswerId);
    
    
    
    
    
    // BoardReAnswerMgr를 통해 데이터베이스에 답글 삽입
    BoardReAnswerMgr mgr = new BoardReAnswerMgr();
    boolean result = mgr.addReAnswer(reAnswerBean);
    
    // 결과 출력
    if (result) {
        out.print("답글이 등록되었습니다.");
        
      //알람기능
        AlarmBean alarmBean = new AlarmBean();
        BoardAnswerMgr baMgr = new BoardAnswerMgr();
        int boardNum = baMgr.getBoardByAnswersNum(Integer.parseInt(answerNum));
        BoardWriteMgr bMgr = new BoardWriteMgr();
        String id = bMgr.getBoard(boardNum).getBoard_id();
        alarmBean.setAlarm_content_num(boardNum);
        alarmBean.setAlarm_type("게시판 답글");
        alarmBean.setAlarm_user_id(id);
        AlarmMgr alarmMgr = new AlarmMgr();
        alarmMgr.insertAlarm(alarmBean);
        
    } else {
        out.print("답글 등록에 실패하였습니다.");
    }
%>