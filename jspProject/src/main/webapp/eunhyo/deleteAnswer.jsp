<%@page import="guestbook.GuestbookanswerMgr"%>
<%@page contentType="application/json; charset=UTF-8"%>

<jsp:useBean id="answerMgr" class="guestbook.GuestbookanswerMgr" />
<%
    // 응답을 JSON 형식으로 설정
    response.setContentType("application/json; charset=UTF-8");
    
    try {
        // 클라이언트에서 보낸 ganswerNum 파라미터를 가져옴
        String ganswerNumStr = request.getParameter("ganswerNum");
        
        // ganswerNum 파라미터가 null이 아니고 숫자인지 확인
        if (ganswerNumStr != null && ganswerNumStr.matches("\\d+")) {
            int ganswerNumParsed = Integer.parseInt(ganswerNumStr); // 정수로 변환
            
            // 답글 매니저 객체 생성
            GuestbookanswerMgr answerManager = new GuestbookanswerMgr();
            
            // 답글 삭제 수행
            boolean isDeleted = answerManager.deleteAnswer(ganswerNumParsed);
            
            if (isDeleted) {
                // 삭제 성공 시 클라이언트에 성공 메시지 전송
                out.print("{\"status\": \"success\"}");
            } else {
                // 삭제 실패 시 클라이언트에 실패 메시지 전송
                response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
                out.print("{\"status\": \"error\", \"message\": \"답글 삭제에 실패했습니다.\"}");
            }
        } else {
            // ganswerNum이 잘못되었을 경우의 처리
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            out.print("{\"status\": \"error\", \"message\": \"잘못된 파라미터입니다.\"}");
        }
    } catch (Exception e) {
        // 예외 발생 시 오류 메시지 전송
        response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
        out.print("{\"status\": \"error\", \"message\": \"" + e.getMessage() + "\"}");
        e.printStackTrace();
    }
%>
