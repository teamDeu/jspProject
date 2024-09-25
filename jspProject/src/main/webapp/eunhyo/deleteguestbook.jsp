<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="guestbook.GuestbookMgr" %>

<%
    int guestbookNum = Integer.parseInt(request.getParameter("guestbook_num")); // 삭제할 방명록의 guestbook_num

    GuestbookMgr guestbookMgr = new GuestbookMgr();
    boolean isDeleted = guestbookMgr.deleteGuestbook(guestbookNum); // DB에서 삭제 수행

    if (isDeleted) {
        out.println("success"); // 성공 시 응답
    } else {
        out.println("failure"); // 실패 시 응답
    }
%>
