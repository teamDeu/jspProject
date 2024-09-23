<%@page import="miniroom.UtilMgr"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	int num = UtilMgr.parseInt(request, "num");
	String image = request.getParameter("image");
	String name = request.getParameter("name");
%>
<div id = "<%=num %>" onclick ="clickCharacterRoom(this,'<%=num%>','<%=image %>') " class = "miniroom_design_character_room">
						<img  id = "<%=num %>" class = "miniroom_design_character" alt = '<%=name %>' src='<%=image%>'">
</div>