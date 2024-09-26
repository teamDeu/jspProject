<%@page import="pjh.MemberBean"%>
<%@page import="friend.FriendRequestBean"%>
<%@page import="java.util.Vector"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:useBean id="fMgr" class ="friend.FriendMgr"/>
<jsp:useBean id="uMgr" class ="pjh.MemberMgr"/>
<%
	String id = (String)session.getAttribute("id");
	String url = request.getParameter("url");
	Vector<FriendRequestBean> vlist = fMgr.getFriendRequest(url);
%>
<div class ="alarmlist_top_div">
	<div class ="alarmlist_main_div">
		<div class ="alarmlist_main_div_header">
		</div>
		<ul class ="alarmlist_main_div_list">
			<%for(int i = 0 ; i < vlist.size() ; i ++){ 
				FriendRequestBean bean = vlist.get(i);
				MemberBean user = uMgr.getMember(bean.getRequest_senduserid());
				
				%>
				<li class ="alarmlist_main_div_item">
					<span class ="alarmlist_main_div_item_readbool">읽음</span>
					<span class ="alarmlist_main_div_item_title"><%=user.getUser_name() %>님이 <%=bean.getRequest_type()== 1 ? "일촌" : "이촌" %> 요청을 보냈습니다.</span>
					<span class ="alarmlist_main_div_item_requestAt"><%=bean.getRequest_at() %></span>
				</li>
			<%} %>
		</ul>
		<div></div>
	</div>
</div>