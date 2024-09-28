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
			if(!mgr.insertFriendRequest(bean)){
				msg ="친구요청 실패.. 다시시도해주세요";
			}
			else if(mgr.checkDuplicateFriendRequest(senduserId, receiveuserId)){
				msg ="이미 친구가 되어있거나, 친구 요청한 사람입니다.";
			}
			else{
				msg ="친구요청에 성공하였습니다.";
			}
		}
	}
	else if(type.equals("receive")){
		msg = "친구 추가에 실패하였습니다.";
		String receive_type = request.getParameter("receive_type");
		bean = mgr.getFriendRequestItem(bean.getRequest_num());
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
    // msg 변수를 JavaScript에서 사용할 수 있도록 전달
    var message = "<%= msg != null ? msg : "" %>";
    if (message) {
        alert(message);
    }
</script>
