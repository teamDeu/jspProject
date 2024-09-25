<%@page import="friend.UtilMgr"%>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="pjh.MemberMgr" %>

<%
	String userId = (String)session.getAttribute("idKey");
	int cloverAmount = UtilMgr.parseInt(request, "cloverAmount");
	int totalPrice = UtilMgr.parseInt(request, "totalPrice");
	MemberMgr mgr = new MemberMgr();
	mgr.updateCloverBalance(userId, cloverAmount);
%>
<script>
	alert("결제성공");
	self.close();
</script>