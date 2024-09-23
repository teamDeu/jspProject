<%@ page contentType="text/html; charset=UTF-8" %>
<jsp:useBean id="mgr" class="pjh.MemberMgr"/>
<%
	  String cPath = request.getContextPath();
	  String user_id = request.getParameter("user_id");
	  String user_pwd = request.getParameter("user_pwd");
	  String msg = "로그인에 실패 하였습니다.";
	  String href = "login.jsp";
	  int result = mgr.loginMember(user_id, user_pwd);  // boolean이 아닌 int로 반환
	  if(result == 2){  // 로그인 성공 시
	    session.setAttribute("idKey", user_id);
	    msg = "로그인에 성공 하였습니다.";
	    href ="../miniroom/main.jsp";
	  } else if (result == 1) {  // 비밀번호 불일치
	    msg = "비밀번호가 일치하지 않습니다.";
	  } else if (result == 0) {  // 아이디가 존재하지 않음
	    msg = "존재하지 않는 아이디입니다.";
	  }
%>
<script>
	alert("<%=msg%>");
	location.href = "<%=href%>";
</script>
