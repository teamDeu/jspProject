<%@page import="miniroom.UtilMgr"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <jsp:useBean id="aMgr" class ="alarm.AlarmMgr"/>
<%
	String id = (String)session.getAttribute("idKey");
	String type = request.getParameter("type");
	System.out.println("type : " + type);
	if(type.equals("read")){
		int num = UtilMgr.parseInt(request, "num");
		aMgr.updateReadAlarm(num);
	}
	else if(type.equals("deleteAll")){
		aMgr.deleteAllReadAlarm(id);
	}
	
	else if(type.equals("delete")){
		String content_type = request.getParameter("content_type");
		int content_num = UtilMgr.parseInt(request, "content_num");
		System.out.println("content_type : " + content_type);
		System.out.println("content_num : " + content_num);
		aMgr.deleteAlarmByContent(content_type, content_num);
	}
%>