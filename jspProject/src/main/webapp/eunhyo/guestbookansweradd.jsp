<%@page import="guestbook.GuestbookanswerMgr"%>
<%@page import="guestbook.GuestbookanswerBean"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page contentType="application/json; charset=UTF-8"%>

<jsp:useBean id="answerMgr" class="guestbook.GuestbookanswerMgr" />
<%
    String guestbookNum = request.getParameter("guestbookNum");
    String comment = request.getParameter("ganswerComment");
    String userId = (String) session.getAttribute("idKey"); // 현재 로그인된 사용자 ID 가져오기

    // 답글 생성
    GuestbookanswerBean answer = new GuestbookanswerBean();
    answer.setGuestbookNum(Integer.parseInt(guestbookNum));
    answer.setGanswerComment(comment);
    answer.setGanswerId(userId);

    // DB에 답글 추가하고 생성된 답글 번호 가져오기
    int ganswerNum = answerMgr.addAnswer(answer);
    
    if (ganswerNum > 0) {
        // 날짜 형식 지정
        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        String currentTime = dateFormat.format(new java.util.Date());

        // JSON 형태로 응답 반환 (comment 내용에 이스케이프 처리 추가)
        String jsonResponse = String.format(
            "{\"ganswerNum\": %d, \"ganswerId\": \"%s\", \"ganswerComment\": \"%s\", \"ganswerAt\": \"%s\"}",
            ganswerNum, userId, comment.replace("\"", "\\\""), currentTime
        );
        response.setContentType("application/json; charset=UTF-8");
        out.print(jsonResponse);
    } else {
        response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
        response.setContentType("application/json; charset=UTF-8");
        out.print("{\"error\": \"답글 등록에 실패하였습니다.\"}");
    }
%>
