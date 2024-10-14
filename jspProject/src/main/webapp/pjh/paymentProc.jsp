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

	let currentClover = parseInt(opener.document.querySelectorAll('.clover-amount-span')[0].innerText);
	currentClover += <%=cloverAmount%>; // 환불된 클로버 금액 더하기
	console.log(opener.document.querySelectorAll('.clover-amount-span'));
	opener.document.querySelectorAll('.clover-amount-span').forEach((e) => e.innerText = currentClover);
	alert("결제성공");
	self.close();
</script>