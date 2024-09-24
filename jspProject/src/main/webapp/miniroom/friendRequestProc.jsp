<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:useBean id="mgr" class ="friend.FriendMgr"/>
<jsp:useBean id="bean" class ="friend.FriendRequestBean"/>
<jsp:setProperty property="*" name="bean"/>
<%
	String receiveuserId = bean.getRequest_receiveuserid();
	String senduserId = bean.getRequest_senduserid();
	String msg = "본인에게 친구요청 할 수 없습니다.";
	if(!(receiveuserId.equals(senduserId))){
		if(mgr.insertFriendRequest(bean)){
			msg = "친구요청 성공!";
		}
		else{
			msg ="친구요청 실패.. 다시시도해주세요";
		}
	}
%>
<script>
	alert('<%=msg%>');
	self.close();
</script>

