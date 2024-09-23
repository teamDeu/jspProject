<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="pjh.MemberMgr" %>

<%
    String name = request.getParameter("name");
    String phone = request.getParameter("phone");
    String verificationCode = request.getParameter("verificationCode");
    
    String storedVerificationCode = (String) session.getAttribute("authCode"); // 세션에 저장된 인증번호

    if (storedVerificationCode != null && storedVerificationCode.equals(verificationCode)) {
        MemberMgr memberMgr = new MemberMgr();
        String userId = memberMgr.findUserIdByNameAndPhone(name, phone);
        
        if (userId != null) {
            out.println("<script>alert('아이디는 " + userId + " 입니다.'); location.href='login.jsp';</script>");
        } else {
            out.println("<script>alert('해당 정보로 등록된 아이디가 없습니다.'); history.back();</script>");
        }
    } else {
        out.println("<script>alert('인증번호가 일치하지 않습니다.'); history.back();</script>");
    }
%>
