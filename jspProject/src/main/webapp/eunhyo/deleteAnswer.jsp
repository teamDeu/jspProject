<%@page import="guestbook.GuestbookanswerMgr"%>
<%@page contentType="application/json; charset=UTF-8"%>

<%
    String answerNumStr = request.getParameter("answerNum");
    String guestbookNumStr = request.getParameter("guestbookNum");
    
    boolean isSuccess = false;

    if (answerNumStr != null && guestbookNumStr != null) {
        int answerNum = Integer.parseInt(answerNumStr);
        
        // 답글 삭제 처리
        GuestbookanswerMgr answerMgr = new GuestbookanswerMgr();
        isSuccess = answerMgr.deleteGuestbookAnswer(answerNum);
    }

    // JSON 형태로 응답 반환
    out.print("{\"success\": " + isSuccess + "}");
%>
