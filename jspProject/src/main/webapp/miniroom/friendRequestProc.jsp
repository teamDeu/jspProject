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
		String receive_type = request.getParameter("receive_type");
		System.out.println(bean.getRequest_num());
		bean = mgr.getFriendRequestItem(bean.getRequest_num());
		System.out.println("여기는 옴");
		if(receive_type.equals("accept")){
			if(mgr.insertFriendInfo(bean)){
				msg ="친구 추가 성공!";
				mgr.updateFriendRequestComplete(bean.getRequest_num());
			}
			else{
				msg ="친구 추가 실패!";
			}
		}
		else if(receive_type.equals("reject")){
			mgr.updateFriendRequestComplete(bean.getRequest_num());
		}
		
	}
	
%>
<script>
	
</script>

