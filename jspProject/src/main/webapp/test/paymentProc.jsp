<!-- paymentProc.jsp -->
<%@page import="friend.UtilMgr"%>
<%@page import="pjh.MemberMgr"%>
<%@page contentType="text/html; charset=UTF-8"%>
<%
	int cloverAmount = UtilMgr.parseInt(request, "cloverAmount") ;
	MemberMgr mgr = new MemberMgr();
	mgr.updateCloverBalance("als981209", cloverAmount);
%>
<script>
	alert("결제성공");
	location.href="<%=request.getContextPath()%>/test/payForm.jsp";
</script>
