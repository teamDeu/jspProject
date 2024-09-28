<%@page import="guestbook.GuestbookMgr"%>
<%@page contentType="text/html; charset=UTF-8"%>

<jsp:useBean id="mgr" class="guestbook.GuestbookMgr" />
<%
    int guestbookNum = Integer.parseInt(request.getParameter("guestbookNum"));
    boolean deleted = mgr.deleteGuestbookEntry(guestbookNum);
    String message = deleted ? "방명록이 삭제되었습니다." : "방명록 삭제에 실패하였습니다.";
    
    // 결과를 출력 (AJAX 응답)
    out.print(message);
%>

