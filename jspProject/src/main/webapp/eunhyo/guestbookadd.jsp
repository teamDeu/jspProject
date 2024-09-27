<%@page import="guestbook.GuestbookBean"%>
<%@page import="guestbook.GuestbookMgr"%>
<%@page contentType="text/html; charset=UTF-8"%>

<jsp:useBean id="mgr" class="guestbook.GuestbookMgr" />
<%
    String content = request.getParameter("content");
    String ownerId = request.getParameter("ownerId");
    String writerId = (String) session.getAttribute("idKey");

    GuestbookBean entry = new GuestbookBean();
    entry.setGuestbookSecret("N"); // Assuming not secret
    entry.setOwnerId(ownerId);
    entry.setWriterId(writerId);
    entry.setGuestbookContent(content);

    boolean added = mgr.addGuestbookEntry(entry);

    // JSON 형태로 응답을 반환
    if (added) {
        // 작성된 방명록의 정보를 JSON으로 전달
        String jsonResponse = String.format(
            "{\"guestbookNum\": %d, \"writerId\": \"%s\", \"content\": \"%s\", \"writtenAt\": \"%s\"}",
            entry.getGuestbookNum(),
            writerId,
            content,
            new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new java.util.Date())
        );
        out.print(jsonResponse);
    } else {
        // 실패 시 에러 메시지 출력
        response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
        out.print("{\"error\": \"방명록 작성에 실패하였습니다.\"}");
    }
%>
