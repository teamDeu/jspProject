<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="guestbook.GuestbookMgr"%>
<%
    String guestbookSecret = request.getParameter("guestbookSecret") != null ? "Y" : "N";
    String guestbookContent = request.getParameter("guestbookContent");
    String ownerId = request.getParameter("ownerId");
    String loggedInUserId = (String) session.getAttribute("loggedInUserId");

    // 디버깅용 출력
    System.out.println("guestbookSecret: " + guestbookSecret);
    System.out.println("guestbookContent: " + guestbookContent);
    System.out.println("ownerId: " + ownerId);
    System.out.println("loggedInUserId: " + loggedInUserId);

    // 유효성 검사 추가
    if (ownerId == null || loggedInUserId == null) {
        System.out.println("ownerId 또는 loggedInUserId가 null입니다.");
    }

    GuestbookMgr guestbookMgr = new GuestbookMgr();
    boolean success = false;

    if (guestbookContent != null && ownerId != null && loggedInUserId != null) {
        // DB에 방명록 항목 등록
        success = guestbookMgr.writeGuestbook(guestbookSecret, ownerId, loggedInUserId, guestbookContent);
    }

    // 성공 여부에 따라 응답을 전송
    if (success) {
        out.print("success");
    } else {
        out.print("fail");
    }
%>
