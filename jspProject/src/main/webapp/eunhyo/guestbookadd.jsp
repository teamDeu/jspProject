<%@page import="alarm.AlarmMgr"%>
<%@page import="alarm.AlarmBean"%>
<%@page import="guestbook.GuestbookprofileBean"%>
<%@page import="java.util.TimeZone"%>
<%@page import="guestbook.GuestbookBean"%>
<%@page import="guestbook.GuestbookMgr"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page contentType="text/html; charset=UTF-8"%>

<jsp:useBean id="mgr" class="guestbook.GuestbookMgr" />
<jsp:useBean id="profileMgr" class="guestbook.GuestbookprofileMgr" />
<%
   TimeZone seoulTimeZone = TimeZone.getTimeZone("Asia/Seoul");
   TimeZone.setDefault(seoulTimeZone);
%>
<%

   out.clear();
   response.setContentType("application/json; charset=UTF-8");

    String content = request.getParameter("content");
    String ownerId = request.getParameter("ownerId");
    String writerId = (String) session.getAttribute("idKey");
    String secret = request.getParameter("secret"); // 비밀글 여부
    
    // 비밀글 여부에 따라 "1" 또는 "0"으로 설정
    String guestbookSecret = (secret != null && secret.equals("1")) ? "1" : "0";

    GuestbookBean entry = new GuestbookBean();
    entry.setGuestbookSecret(guestbookSecret); // 비밀 여부 설정
    entry.setOwnerId(ownerId);
    entry.setWriterId(writerId);
    entry.setGuestbookContent(content);

    
 // addGuestbookEntry 메서드 호출 후 guestbookNum 반환
    int guestbookNum = mgr.addGuestbookEntry(entry);

 // DB에서 해당 guestbookNum으로 작성된 시간을 가져옴
    if (guestbookNum > 0) {
    	//알람 설정
    	if(!(ownerId.equals(writerId))){
    		AlarmBean alarmBean = new AlarmBean();
            alarmBean.setAlarm_content_num(guestbookNum);
            alarmBean.setAlarm_type("방명록");
            alarmBean.setAlarm_user_id(ownerId);
            AlarmMgr alarmMgr = new AlarmMgr();
            alarmMgr.insertAlarm(alarmBean);
    	}
        // DB에서 해당 guestbookNum으로 작성된 시간을 가져와서 entry에 설정
        entry.setWrittenAt(mgr.getWrittenAt(guestbookNum));

     // SimpleDateFormat 인스턴스 생성 및 시간대 설정
        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");

        dateFormat.setTimeZone(seoulTimeZone);
        
        // 프로필 정보 가져오기
        GuestbookprofileBean profile = profileMgr.getProfileByUserId(writerId);
        String profileName = profile != null ? profile.getProfileName() : "";
        String profilePicture = profile != null ? profile.getProfilePicture() : "";
        
        // JSON 형태로 응답을 반환
        String jsonResponse = String.format(
            "{\"guestbookNum\": %d, \"writerId\": \"%s\", \"content\": \"%s\", \"writtenAt\": \"%s\", \"profileName\": \"%s\", \"profilePicture\": \"%s\"}",
            guestbookNum,
            writerId,
            content,
            dateFormat.format(entry.getWrittenAt()), // DB에서 가져온 날짜를 사용
            profileName,
            profilePicture
        );
        out.print(jsonResponse);
    } else {
        // 실패 시 에러 메시지 출력
        response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
        out.print("{\"error\": \"방명록 작성에 실패하였습니다.\"}");
    }
%>