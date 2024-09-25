<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String profileImg = request.getParameter("profileImg");
	String profileName = request.getParameter("profileName");
%>
<div class ="main_profile_friends_div">
						<img class ="main_profile_friends" src="<%=profileImg%>"> <span><%=profileName%></span>
</div>