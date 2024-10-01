<%@page import="alarm.AlarmBean"%>
<%@page import="friend.FriendRequestBean"%>
<%@page import="miniroom.UtilMgr"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:useBean id="mgr" class ="friend.FriendMgr"/>
<jsp:useBean id="bean" class ="friend.FriendRequestBean"/>
<jsp:setProperty property="*" name="bean"/>
<jsp:useBean id="aMgr" class ="alarm.AlarmMgr"/>
<%
	String type = request.getParameter("type");
	String msg = null;
	String receiveuserId = null;
	String senduserId = null;
	int num = 0;
	if(!(request.getParameter("request_num") == null)){
		if(request.getParameter("request_num").equals("")){
			num = mgr.getLastFriendRequest().getRequest_num();
		}
		else{
			num = UtilMgr.parseInt(request, "request_num");
		}
	}

	
	if(type.equals("send")){
		receiveuserId = bean.getRequest_receiveuserid();
		senduserId= bean.getRequest_senduserid();
		if((receiveuserId.equals(senduserId))){
			msg = "본인에게 친구신청 할 수 없습니다.";
		}
		else if(mgr.checkDuplicateFriendRequest(senduserId, receiveuserId)){
			msg = "이미 친구거나, 친구요청을 했습니다.";
		}
		else{
			if(!mgr.insertFriendRequest(bean)){
				msg ="친구요청 실패.. 다시시도해주세요";
			}
			else{
				msg ="친구요청에 성공하였습니다.";
				AlarmBean aBean = new AlarmBean();
				FriendRequestBean fBean = mgr.getLastFriendRequest();
				aBean.setAlarm_content_num(fBean.getRequest_num());
				aBean.setAlarm_type("친구요청");
				aBean.setAlarm_user_id(fBean.getRequest_receiveuserid());
				System.out.println("fBean ID" + fBean.getRequest_receiveuserid());
				System.out.println("aBean ID" + aBean.getAlarm_user_id());
				aMgr.insertAlarm(aBean);
			}
		}
	}
	else if(type.equals("receive")){
		String receive_type = request.getParameter("receive_type");
		bean = mgr.getFriendRequestItem(num);
		if(receive_type.equals("accept")){
			if(mgr.checkDuplicateFriendRequest(senduserId, receiveuserId)){
				msg = "이미 친구거나, 친구요청을 했습니다.";
			}
			else if(mgr.insertFriendInfo(bean)){
				msg ="친구 추가 성공!";
				mgr.updateFriendRequestComplete(num);
			}
			else{
				msg ="친구 추가 실패!";
			}
		}
		else if(receive_type.equals("reject")){
			mgr.updateFriendRequestComplete(num);
			msg ="친구 신청을 거절했습니다.";
		}
	}
	else if(type.equals("delete")){
		receiveuserId = bean.getRequest_receiveuserid();
		senduserId= bean.getRequest_senduserid();
		if(mgr.deleteFriend(senduserId, receiveuserId)){
			msg ="친구가 삭제되었습니다.";
		}
		else{
			msg = "친구삭제 실패";
		}
	}
%>
<script>
    // msg 변수를 JavaScript에서 사용할 수 있도록 전달
    message = '<%=msg%>';
    if (message) {
        alert(message);
    }
</script>
