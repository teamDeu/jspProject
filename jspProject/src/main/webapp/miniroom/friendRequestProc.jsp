<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:useBean id="mgr" class ="friend.FriendMgr"/>
<jsp:useBean id="bean" class ="friend.FriendRequestBean"/>
<jsp:setProperty property="*" name="bean"/>
<%
	String type = request.getParameter("type");
	String msg = null;
	if(type.equals("send")){
		String receiveuserId = bean.getRequest_receiveuserid();
		String senduserId = bean.getRequest_senduserid();
		msg = "본인에게 친구요청 할 수 없습니다.";
		if(!(receiveuserId.equals(senduserId))){
			if(mgr.insertFriendRequest(bean)){
				msg = "친구요청 성공!";
			}
			else{
				msg ="친구요청 실패.. 다시시도해주세요";
			}
		}
	}
	else if(type.equals("receive")){
		msg = "친구 추가에 실패하였습니다.";
		System.out.println(bean.getRequest_num());
		bean = mgr.getFriendRequestItem(bean.getRequest_num());
		if(mgr.insertFriendInfo(bean)){
			mgr.updateFriendRequestComplete(bean.getRequest_num());
			msg ="친구 추가 성공!";
		}
		else{
			msg ="친구 추가 실패!";
		}
	}
	
%>
<script>
	alert('<%=msg%>');
	self.close();
</script>

