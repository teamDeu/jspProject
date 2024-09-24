<%@page import="pjh.MemberBean"%>
<%@ page contentType="text/html; charset=UTF-8" %>
<jsp:useBean id="mgr" class="pjh.MemberMgr"/>
<jsp:useBean id="member" scope = "session" class="pjh.MemberBean"/>
<%
	String cPath = request.getContextPath();
	String user_id = request.getParameter("user_id");
	String user_pwd = request.getParameter("user_pwd");
	String msg = "로그인에 실패 하였습니다.";
	String href = "login.jsp";
	
	// 로그인 처리
	int result = mgr.loginMember(user_id, user_pwd);  // 로그인 결과를 int로 반환
	
	if(result == 2){  // 로그인 성공 시
	  session.setAttribute("idKey", user_id);
	  msg = "로그인에 성공 하였습니다.";
	  
	  // 로그인 성공한 사용자의 정보를 DB에서 가져옴
	  MemberBean bean = mgr.getMemberById(user_id);  // 로그인한 사용자 정보 가져오기
	  
	  // 세션에 사용자 정보 저장
	  session.setAttribute("loggedInUser", bean);  // 'loggedInUser'로 세션에 저장
	  
	  href ="../pjh/main.jsp?url="+user_id;
	
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
