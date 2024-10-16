<%@page import="guestbook.GuestbookBean"%>
<%@page import="alarm.AlarmMgr"%>
<%@page import="alarm.AlarmBean"%>
<%@page import="guestbook.GuestbookprofileMgr"%>
<%@page import="guestbook.GuestbookprofileBean"%>
<%@page import="guestbook.GuestbookanswerBean"%>
<%@page import="guestbook.GuestbookanswerMgr"%>
<%@page contentType="text/html; charset=UTF-8"%>

<jsp:useBean id="answerMgr" class="guestbook.GuestbookanswerMgr" />
<jsp:useBean id="profileMgr" class="guestbook.GuestbookprofileMgr" />
<jsp:useBean id="guestbookMgr" class ="guestbook.GuestbookMgr"/>
<%
    out.clear();
    response.setContentType("application/json; charset=UTF-8");

    String comment = request.getParameter("comment");
    int guestbookNum = Integer.parseInt(request.getParameter("guestbookNum"));
    String ganswerId = (String) session.getAttribute("idKey");

    GuestbookanswerBean answer = new GuestbookanswerBean();
    GuestbookBean guestbook = guestbookMgr.getGuestbookEntry(guestbookNum);
    answer.setGuestbookNum(guestbookNum);
    answer.setGanswerComment(comment);
    answer.setGanswerId(ganswerId);

    // 답글 추가
    boolean isSuccess = answerMgr.addGuestbookAnswer(answer);

    if (isSuccess) {
        // 답글 작성자의 프로필 정보 가져오기
        GuestbookprofileBean profile = profileMgr.getProfileByUserId(ganswerId);
        String profileName = profile != null ? profile.getProfileName() : "";
        
        if(!(guestbook.getOwnerId().equals(ganswerId))){
        	AlarmBean alarmBean = new AlarmBean();
            alarmBean.setAlarm_content_num(answerMgr.getLatestGuestbookAnswer());
            alarmBean.setAlarm_type("방명록댓글");
            alarmBean.setAlarm_user_id(guestbook.getOwnerId());
            AlarmMgr alarmMgr = new AlarmMgr();
            alarmMgr.insertAlarm(alarmBean);
        }
        

        // 성공적으로 추가되었을 경우 JSON 응답 생성
        String jsonResponse = String.format(
            "{\"answerNum\": %d, \"guestbookNum\": %d, \"ganswerId\": \"%s\", \"ganswerComment\": \"%s\", \"ganswerAt\": \"%s\", \"profileName\": \"%s\"}",
            answer.getGanswerNum(), // 생성된 답글 ID를 응답에 포함
            guestbookNum,
            ganswerId,
            comment,
            new java.sql.Date(System.currentTimeMillis()).toString(), // 작성 시간 포함
            profileName // 프로필 이름 포함
        );
        out.print(jsonResponse);
    } else {
        // 실패 시 에러 메시지 출력
        response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
        out.print("{\"error\": \"답글 작성에 실패하였습니다.\"}");
    }
%>
