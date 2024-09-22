<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="pjh.MemberMgr" %>

<%
    String id = request.getParameter("id");
    String name = request.getParameter("name");
    String phone = request.getParameter("phone");
    String verificationCode = request.getParameter("verificationCode");
    
    String storedVerificationCode = (String) session.getAttribute("authCode"); // 세션에 저장된 인증번호

    if (storedVerificationCode != null && storedVerificationCode.equals(verificationCode)) {
        MemberMgr memberMgr = new MemberMgr();
        boolean isValidUser = memberMgr.verifyUserForPasswordReset(id, name, phone);
        
        if (isValidUser) {
            // 비밀번호 재설정 페이지로 이동
            response.sendRedirect("resetPassword.jsp?id=" + id);
        } else {
            out.println("<script>alert('해당 정보로 등록된 사용자가 없습니다.'); history.back();</script>");
        }
    } else {
        out.println("<script>alert('인증번호가 일치하지 않습니다.'); history.back();</script>");
    }
%>
