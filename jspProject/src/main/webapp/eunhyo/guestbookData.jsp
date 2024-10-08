<%@page import="guestbook.GuestbookMgr"%>
<%@page import="guestbook.GuestbookBean"%>
<%@page import="guestbook.GuestbookprofileMgr"%>
<%@page import="guestbook.GuestbookprofileBean"%>
<%@page import="guestbook.GuestbookanswerMgr"%>
<%@page import="guestbook.GuestbookanswerBean"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page contentType="application/json; charset=UTF-8"%>

<%
    String ownerId = request.getParameter("ownerId");
    int currentPage = Integer.parseInt(request.getParameter("page")); 
    int entriesPerPage = 3; // 한 페이지당 방명록 항목 수
    int startIndex = (currentPage - 1) * entriesPerPage;

    // 현재 로그인한 사용자 ID 가져오기
    String sessionUserId = (String) session.getAttribute("idKey");

    GuestbookMgr mgr = new GuestbookMgr();
    GuestbookanswerMgr answerMgr = new GuestbookanswerMgr();
    ArrayList<GuestbookBean> entries = mgr.getGuestbookEntries(ownerId, startIndex, entriesPerPage); 
    int totalPages = mgr.getTotalPages(ownerId);
    
    // 날짜 포맷터 생성
    SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");

    StringBuilder jsonBuilder = new StringBuilder();
    jsonBuilder.append("{");
    jsonBuilder.append("\"totalPages\":").append(totalPages).append(",");
    jsonBuilder.append("\"sessionUserId\":\"").append(sessionUserId).append("\",");
    jsonBuilder.append("\"entries\":[");

    for (int i = 0; i < entries.size(); i++) {
        GuestbookBean entry = entries.get(i);
        String profileName = (entry.getProfileName() != null) ? entry.getProfileName() : "";
        String profilePicture = (entry.getProfilePicture() != null) ? entry.getProfilePicture() : "";

        // 비밀글 여부 확인
        boolean isSecret = "1".equals(entry.getGuestbookSecret());
        boolean canViewSecret = sessionUserId != null && (sessionUserId.equals(entry.getWriterId()) || sessionUserId.equals(ownerId));

        // 비밀글 처리 - 비밀글이고 권한이 없는 경우
        String contentToShow = isSecret && !canViewSecret ? "비밀글입니다." : entry.getGuestbookContent();

        // 답글 목록 가져오기
        ArrayList<GuestbookanswerBean> answers = answerMgr.getAnswersForGuestbook(entry.getGuestbookNum());
        
        jsonBuilder.append("{")
            .append("\"guestbookNum\":").append(entry.getGuestbookNum()).append(",")
            .append("\"writerId\":\"").append(entry.getWriterId()).append("\",")
            .append("\"content\":\"").append(contentToShow).append("\",") // 컨텐츠 처리 후 추가
            .append("\"writtenAt\":\"").append(entry.getWrittenAt() != null ? dateFormat.format(entry.getWrittenAt()) : "").append("\",")
            .append("\"isSecret\":\"").append(entry.getGuestbookSecret()).append("\",")
            .append("\"profileName\":\"").append(profileName).append("\",")
            .append("\"profilePicture\":\"").append(profilePicture).append("\",")
            .append("\"answers\":[");

        for (int j = 0; j < answers.size(); j++) {
            GuestbookanswerBean answer = answers.get(j);
            jsonBuilder.append("{")
                .append("\"answerNum\":").append(answer.getGanswerNum()).append(",")
                .append("\"ganswerId\":\"").append(answer.getGanswerId()).append("\",")
                .append("\"ganswerComment\":\"").append(answer.getGanswerComment()).append("\",")
                .append("\"ganswerAt\":\"").append(answer.getGanswerAt()).append("\",")
                .append("\"profileName\":\"").append(answer.getProfileName()).append("\"")
                .append("}");
            if (j < answers.size() - 1) {
                jsonBuilder.append(",");
            }
        }
        jsonBuilder.append("]}");
        
        if (i < entries.size() - 1) {
            jsonBuilder.append(",");
        }
    }
    
    jsonBuilder.append("]");
    jsonBuilder.append("}");
    
    out.print(jsonBuilder.toString());
%>
