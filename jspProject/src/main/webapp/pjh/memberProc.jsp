<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="pjh.MemberMgr, pjh.MemberBean" %>
<jsp:useBean id="bean" class="pjh.MemberBean"/>
<jsp:setProperty property="*" name="bean"/>

<%
    String user_id = request.getParameter("user_id");
    String user_pwd = request.getParameter("user_pwd");
    String user_repwd = request.getParameter("user_repwd");
    String user_name = request.getParameter("user_name");
    String user_birth = request.getParameter("user_birth"); // 변경: request.getParameter("user_birthday") -> user_birth로 통일
    String user_phone = request.getParameter("user_phone");
    String user_email = request.getParameter("user_email");
    

    // 비밀번호 확인
    if (!user_pwd.equals(user_repwd)) {
        out.println("<script>alert('비밀번호가 일치하지 않습니다.'); history.back();</script>");
        return;
    }

    // 현재 날짜를 설정하여 user_date 필드에 추가
    java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("yyyy-MM-dd");
    String user_date = sdf.format(new java.util.Date());
    bean.setUser_date(user_date);

    // DB 저장
    MemberMgr mgr = new MemberMgr();
    boolean result = mgr.insertMember(bean);

    // 회원가입 성공 여부에 따라 처리
    if (result) {
        out.println("<script>alert('회원가입이 완료되었습니다.'); location.href='login.jsp';</script>");
    } else {
        out.println("<script>alert('회원가입에 실패하였습니다. 다시 시도해 주세요.'); history.back();</script>");
    }
%>
