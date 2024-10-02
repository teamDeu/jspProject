<%@page import="report.ReportBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <jsp:useBean id="rMgr" class ="report.ReportMgr"/>
<%
	String report_senduserid = request.getParameter("report_senduserid");
	String report_receiveuserid = request.getParameter("report_receiveuserid");
	String report_type = request.getParameter("report_type");
	
	ReportBean bean = new ReportBean();
	
	bean.setReport_senduserid(report_senduserid);
	bean.setReport_receiveuserid(report_receiveuserid);
	bean.setReport_type(report_type);
	
	rMgr.insertReport(bean);
	
%>