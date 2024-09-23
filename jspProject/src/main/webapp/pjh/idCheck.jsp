<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="pjh.MemberMgr" %>

<%
    String id = request.getParameter("id");
    MemberMgr mgr = new MemberMgr();
    boolean isDuplicate = mgr.checkId(id);

    if (isDuplicate) {
        out.println("<script>alert('이미 사용 중인 아이디입니다.'); window.close();</script>");
    } else {
        out.println("<script>alert('사용 가능한 아이디입니다.'); window.close();</script>");
    }
%>
