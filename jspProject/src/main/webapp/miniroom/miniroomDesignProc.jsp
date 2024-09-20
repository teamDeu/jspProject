
<%@page import="miniroom.UtilMgr"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:useBean id="mgr" class ="miniroom.ItemMgr"/>
<%
	String msg ="업데이트에 실패하였습니다.";
	int character = UtilMgr.parseInt(request, "character");
	int background = UtilMgr.parseInt(request, "background");
	String user_id = request.getParameter("user_id");
	if(mgr.updateMiniroom(background, character, user_id)){
		msg ="업데이트에 성공하였습니다.";
	}
%>

<script>
	alert("<%=msg%>");
	location.href = "miniDesign.jsp";
</script>
