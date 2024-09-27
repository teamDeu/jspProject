<%@page import="guestbook.GuestbookanswerMgr"%>
<%@page contentType="application/json; charset=UTF-8"%>

<jsp:useBean id="answerMgr" class="guestbook.GuestbookanswerMgr" />
<%
    int ganswerNum = Integer.parseInt(request.getParameter("ganswerNum"));

    boolean isDeleted = answerMgr.deleteAnswer(ganswerNum);

    // JSON 형태로 응답 반환
    if (isDeleted) {
        out.print("{\"success\": true}");
    } else {
        response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
        out.print("{\"error\": \"답글 삭제에 실패하였습니다.\"}");
    }
%>
