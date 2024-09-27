<%@page import="friend.UtilMgr"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String profileImg = request.getParameter("profileImg");
	String profileName = request.getParameter("profileName");
	String profileId = request.getParameter("profileId");
	String type = null;
	if(UtilMgr.parseInt(request, "type") == 2){
		type = "friends_type_second";
	}
	else{
		type = "friends_type_first";
	}
%>

<div onclick = "location.href = 'main.jsp?url=<%=profileId%>'" class ="main_profile_friends_div <%=type%>">
	<img class ="main_profile_friends" src="<%=profileImg%>"> <span class ="main_profile_friends_name"><%=profileName%></span>
</div>