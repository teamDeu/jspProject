<%@page import="guestbook.GuestbookMgr"%>
<%@page import="guestbook.GuestbookBean"%>
<%@page import="guestbook.GuestbookprofileMgr"%>
<%@page import="guestbook.GuestbookprofileBean"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page contentType="application/json; charset=UTF-8"%>
<%
    String ownerId = request.getParameter("ownerId");
    int currentPage = Integer.parseInt(request.getParameter("page")); 
    int entriesPerPage = 3; // 한 페이지당 방명록 항목 수
    int startIndex = (currentPage - 1) * entriesPerPage;

    GuestbookMgr mgr = new GuestbookMgr();
    ArrayList<GuestbookBean> entries = mgr.getGuestbookEntries(ownerId, startIndex, entriesPerPage); 
    int totalPages = mgr.getTotalPages(ownerId);
    
    // 날짜 포맷터 생성
    SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");

    StringBuilder jsonBuilder = new StringBuilder();
    jsonBuilder.append("{");
    jsonBuilder.append("\"totalPages\":").append(totalPages).append(",");
    jsonBuilder.append("\"entries\":[");

    for (int i = 0; i < entries.size(); i++) {
        GuestbookBean entry = entries.get(i);
        String profileName = (entry.getProfileName() != null) ? entry.getProfileName() : "";
        String profilePicture = (entry.getProfilePicture() != null) ? entry.getProfilePicture() : "";

        jsonBuilder.append("{")
            .append("\"guestbookNum\":").append(entry.getGuestbookNum()).append(",")
            .append("\"writerId\":\"").append(entry.getWriterId()).append("\",")
            .append("\"content\":\"").append(entry.getGuestbookContent()).append("\",")
            // 작성일자 포맷팅
            .append("\"writtenAt\":\"").append(entry.getWrittenAt() != null ? dateFormat.format(entry.getWrittenAt()) : "").append("\",")
            .append("\"isSecret\":\"").append(entry.getGuestbookSecret()).append("\",")
            .append("\"profileName\":\"").append(profileName).append("\",")
            .append("\"profilePicture\":\"").append(profilePicture).append("\"")
            .append("}");

        if (i < entries.size() - 1) {
            jsonBuilder.append(",");
        }
    }
    
    jsonBuilder.append("]");
    jsonBuilder.append("}");
    
    out.print(jsonBuilder.toString());
%>
