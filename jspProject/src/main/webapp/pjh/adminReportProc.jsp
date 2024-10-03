<%@page import="report.SuspensionBean"%>
<%@page import="report.ReportBean"%>
<%@page import="miniroom.UtilMgr"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <jsp:useBean id="reportMgr" class ="report.ReportMgr"/>
<%
	String type = request.getParameter("type");
	int reportNum = UtilMgr.parseInt(request, "report_num");
	if(type.equals("submit")){
		int suspension_period = UtilMgr.parseInt(request, "suspension_period");
		int suspension_type = UtilMgr.parseInt(request,"suspension_type");
		ReportBean reportBean = reportMgr.getReportBean(reportNum);
		SuspensionBean sBean = new SuspensionBean();
		sBean.setSuspension_id(reportBean.getReport_receiveuserid());
		sBean.setSuspension_reason(reportNum);
		sBean.setSuspension_type(suspension_type);
		sBean.setSuspension_date(UtilMgr.addDay(suspension_period));
		
		reportMgr.insertSuspension(sBean);
		reportMgr.updateReportComplete(reportNum);
	}
	else if(type.equals("reject")){
		reportMgr.updateReportComplete(reportNum);
	}
%>