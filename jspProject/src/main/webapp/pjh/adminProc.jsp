<%@ page import="pjh.AdminMgr"%>
<%@ page import="pjh.AdminBean"%>
<%@ page contentType="text/html; charset=UTF-8" %>

<%
    // AdminMgr 객체 생성
    AdminMgr adminMgr = new AdminMgr();
    
    String admin_id = request.getParameter("user_id");  // 로그인 폼에서 전달된 관리자 ID
    String admin_pwd = request.getParameter("user_pwd");  // 로그인 폼에서 전달된 관리자 비밀번호
    String msg = "로그인에 실패하였습니다.";  // 기본 메시지
    String href = "login.jsp";  // 기본 리다이렉션 페이지
    
    // 관리자 로그인 처리
    int result = adminMgr.loginAdmin(admin_id, admin_pwd);  // 로그인 결과를 반환
    
    if (result == 2) {  // 로그인 성공 시
        session.setAttribute("admin_id", admin_id);
        msg = "관리자 로그인에 성공하였습니다.";
        
        // 로그인 성공한 관리자의 정보를 DB에서 가져옴
        AdminBean adminInfo = adminMgr.getAdminById(admin_id);
        
        // 세션에 관리자 정보 저장
        session.setAttribute("loggedInAdmin", adminInfo);
        
        href = "adminMain.jsp";  // 성공 시 관리자 페이지로 이동
        
    } else if (result == 1) {  // 비밀번호 불일치
        msg = "비밀번호가 일치하지 않습니다.";
    } else if (result == 0) {  // 아이디가 존재하지 않음
        msg = "존재하지 않는 관리자 아이디입니다.";
    }
%>

<script>
    alert("<%= msg %>");
    location.href = "<%= href %>";
</script>
