<!-- paymentProc.jsp -->
<%@page contentType="text/html; charset=UTF-8"%>
<%
		int apply_num = Integer.parseInt(request.getParameter("apply_num"));
		int paid_amount = Integer.parseInt(request.getParameter("paid_amount"));
		String msg = "카드승인번호 및 승인금액 : " + apply_num + " : " + paid_amount;
%>
<script>
	alert("<%=msg%>");
	location.href="<%=request.getContextPath()%>/iamport/payForm.jsp";
</script>
