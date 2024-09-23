<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="pjh.MemberMgr" %>

<%
    String phoneNumber = request.getParameter("phoneNumber");
    MemberMgr memberMgr = new MemberMgr();
    String authCode = memberMgr.generateAuthCode(); // 인증번호 생성
    boolean isSent = memberMgr.sendAuthCode(phoneNumber, authCode); // 인증번호 전송

    if (isSent) {
        session.setAttribute("authCode", authCode); // 인증번호를 세션에 저장
        out.print(authCode); // 클라이언트로 인증번호 전송
    } else {
        out.print(""); // 전송 실패 시 빈 문자열 반환
    }
%>
