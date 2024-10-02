<%@page import="java.util.Vector"%>
<%@page import="report.ChatLogBean"%>
<%@page import="miniroom.UtilMgr"%>
<%@page import="report.ReportBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:useBean id="suspensionBean" class ="report.SuspensionBean"/>
<jsp:useBean id="reportMgr" class ="report.ReportMgr"/>
<%
	int suspension_num = UtilMgr.parseInt(request, "suspension_num");
	suspensionBean = reportMgr.getSuspension(suspension_num);
	ReportBean reportBean = reportMgr.getReportBean(suspensionBean.getSuspension_reason());
	Vector<ChatLogBean> chatLogList = new Vector<ChatLogBean>();
	if(reportBean.getReport_type().equals("chat")){
		chatLogList = reportMgr.getChatLogByReport(reportBean);
	}
	System.out.println("suspensionBean" + reportBean.getReport_type());
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>계정정지</title>
<style>
	body{
		display:flex;
		align-items:center;
		justify-content : center;
	}
	.suspension_main{
		display:flex;
		flex-direction:column;
		width: 40vw;
		padding : 20px;
		box-sizing : border-box;
		border : 1px solid black;
	}
	.report_chatLogBox{
			display:flex;
			flex-direction:column;
			background-color : white;
			width : 550px;
			padding : 20px;
			gap : 5px;
			border : 1px solid black;
		}
	.suspension_table{
		align-self : center;
	}
	.suspension_table td{
		padding : 20px;
		text-align : center;
	}
		.report_chatLogBox_exitBtn{
			position:absolute;
			right:5px;
			top:5px;
			cursor : pointer;
		}
		.report_chatLogBox_content{
			display:flex;
			align-items :center;
			width : 100%;
		}
		.report_chatLogBox_content div{
			padding : 5px;
			box-sizing : border-box;
		}
		.report_chatLogBox_content_box{
			border : 1px solid black;
			display:flex;
			flex-direction : column;
			gap : 5px;
			max-height : 400px;
			overflow-y : scroll;
			padding : 10px;
			margin : 10px 0px;
		}
		.suspension_title{
			align-self : center;
		}
		.suspennsion_btn{
			align-self : center;
			padding : 10px 50px;
			
		}
</style>
</head>
<body>
	<div class ="suspension_main">
	<h1 class ="suspension_title">사용자님의 계정은 아래의 사유로 정지 되었습니다.</h1>
	<table class ="suspension_table">
		<tr>
			<td>사유</td><td><%=reportBean.getReport_type() %></td>
		</tr>
		<tr>
			<td>신고 날짜</td><td><%=reportBean.getReport_at() %></td>
		</tr>
		<tr>
			<td>정지 기간</td><td><%=suspensionBean.getSuspension_date()%> 까지</td>
		</tr>
	</table>
	<%if(reportBean.getReport_type().equals("chat")){ %>
		<h1>채팅 내역</h1>
		<div class ="report_chatLogBox_content_box">
							<%if(chatLogList.size() == 0){ %>
								<div class ="report_chatLogBox_content"> 
								채팅내역이 없습니다.
								</div>
							<%} else{%>
							<%for(int i = 0 ; i < chatLogList.size() ; i++) {
							ChatLogBean chatLogBean = chatLogList.get(i);%>
							<div class ="report_chatLogBox_content">
								<%=chatLogBean.getChatlog_id() %> : <%=chatLogBean.getChatlog_content() %>
							</div>
							<%} }%>
						</div>
	<%} %>
	<button class ="suspennsion_btn" onclick = "location.href = '../pjh/login.jsp'">확인하였습니다.</button>
	</div>
</body>
</html>