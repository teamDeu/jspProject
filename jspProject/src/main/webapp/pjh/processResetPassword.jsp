<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="pjh.MemberMgr" %>

<%
    String id = request.getParameter("id");
    String newPassword = request.getParameter("new_password");
    String confirmPassword = request.getParameter("confirm_password");

    if (!newPassword.equals(confirmPassword)) {
        out.println("<script>alert('비밀번호가 일치하지 않습니다.'); history.back();</script>");
    } else {
        MemberMgr memberMgr = new MemberMgr();
        boolean isUpdated = memberMgr.updatePassword(id, newPassword);
        
        if (isUpdated) {
            out.println("<script>alert('비밀번호가 성공적으로 변경되었습니다.'); location.href='login.jsp';</script>");
        } else {
            out.println("<script>alert('비밀번호 변경에 실패했습니다. 다시 시도해 주세요.'); history.back();</script>");
        }
    }
%>
