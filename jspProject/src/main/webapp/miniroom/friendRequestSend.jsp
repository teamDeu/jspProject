<%@page import="friend.FriendInfoBean"%>
<%@page import="java.util.Vector"%>
<%@page import="friend.FriendRequestBean"%>
<%@page import="friend.FriendMgr"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
String id = (String)session.getAttribute("idKey");
String type = request.getParameter("type");
FriendMgr fmgr = new FriendMgr();
Vector<FriendRequestBean> frvlist = fmgr.getAllFriendRequest();
Vector<FriendInfoBean> fivlist = fmgr.getALLFriendList();
%>
<script>

</script>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>친구추가</title>
<style>
@font-face {
	font-family: 'NanumTobak';
	src: url('./나눔손글씨 또박또박.TTF') format('truetype');
}

* {
	font-family: 'NanumTobak', sans-serif;
}

.request_main_div {
	display: flex;
	align-items: center;
	width: 360px;
	height: 300px;
	background-color: #F7F7F7;
	justify-content: center;
	border: 1px solid #BAB9AA;
	padding: 40px 20px;
	box-sizing: border-box;
	border-radius: 20px;
}

.request_main_div * {
	font-size: 24px;
}

.request_div {
	display: flex;
	width: 100%;
	align-items: center;
	flex-direction: column;
	justify-content: center;
	background-color: #FFFFFF;
	border: 1px solid #DCDCDC;
	border-radius: 20px;
	padding: 30px 20px;
	box-sizing: border-box;
	gap: 10px;
}

.request_header {
	display: flex;
	align-items: center;
	gap: 20px;
}

.request_profile_section {
	width: 80px;
}

.request_profile_img {
	object-fit: cover;
	width: 100%;
}

.request_title_section {
	display: flex;
	flex-direction: column;
	align-items: center;
}

.request_comment {
	padding: 15px;
	width: 100%;
	border-radius: 18px;
	margin: 0px;
	border: 0.5px solid #DCDCDC;
	box-sizing: border-box;
}

.request_user_name_font {
	font-weight: bold;
}

.request_button {
	padding: 5px 20px;
	border-radius: 15px;
	border: 0.5px solid #DCDCDC;
}

.request_button:hover {
	background-color: #E8E8E8;
}
</style>
<script>
	FriendRequest = [];
	FriendInfo = [];
	<%for (int i = 0; i < frvlist.size(); i++) {
	FriendRequestBean bean = frvlist.get(i);%>
		FriendRequest.push({
			sendId : '<%=bean.getRequest_senduserid()%>',
			receiveId : '<%=bean.getRequest_receiveuserid()%>'
		})
	<%}%>
	<%for (int i = 0; i < fivlist.size(); i++) {
	FriendInfoBean bean = fivlist.get(i);%>
		FriendInfo.push({
			userId1 : '<%=bean.getUser_id1()%>',
			userId2 : '<%=bean.getUser_id2()%>'
		})
	<%}%>
	function clickCancelBtn(){
		document.getElementById("friend_request_modal_send").style.display = "none";
	}
	function isFriend(sendId,receiveId){
		let flag = false;
		FriendInfo.forEach((e) => {
			if((e.userId1 == sendId && e.userId2 == receiveId) || (e.userId1 == receiveId && e.userId2 == sendId)){
				flag = true;
				console.log(e.userId1 , sendId , e.userId2,receiveId);
			} 
		})
		return flag;
	}
	function clickSubmitBtn(){
		fr_form = document.friend_request_form_send;
		fr_form.request_comment.value = document.querySelector(".request_comment").value;
		fr_form.submit();
		document.getElementById("friend_request_modal_send").style.display = "none";
		sendId = '<%=id%>'
		receiveId = fr_form.request_receiveuserid.value;
		flag = false;
		FriendRequest.forEach((e) => {
			if((e.sendId == sendId && e.receiveId == receiveId) || (e.sendId == receiveId && e.receiveId == sendId)){
				flag = true;
			} 
		})
		if(isFriend(sendId,receiveId)) flag = true;
		if(sendId == receiveId) flag = true;
		if(!flag){
			sendFriendRequest(receiveId,fr_form.request_type.value,fr_form.request_comment.value);
		}
	}
	function changeType(select){
		fr_form = document.friend_request_form_send;
		fr_form.request_type.value = select.value;
	}
</script>
</head>
<div class="request_main_div">
	<div class="request_div">
		<div class="request_header">
			<section class="request_profile_section">
				<img src="./img/character1.png" class="request_profile_img">
			</section>
			<section class="request_title_section">
				<div>
					<font class="request_user_name_font"> 신짱구 </font>님께 <br>
				</div>
				<div>
					<select onchange="changeType(this)">
						<option value="1">일촌</option>
						<option value="2">이촌</option>
					</select> 을 신청합니다.
				</div>
			</section>
		</div>
		<input class="request_comment" type="text" placeholder="친구신청 메시지">
		<div>
			<button onclick="clickCancelBtn()" class="request_button">취소</button>
			<button onclick="clickSubmitBtn()" class="request_button">전송</button>
		</div>
	</div>
	<form name="friend_request_form_send" action="./friendRequestProc.jsp"
		target="blankifr">
		<input type="hidden" name="request_senduserid" value=""> <input
			type="hidden" name="request_receiveuserid" value=""> <input
			type="hidden" name="request_type" value="1"> <input
			type="hidden" name="request_comment" value=""> <input
			type="hidden" name="type" value="send">
	</form>
	<iframe name='blankifr' style="display: none"></iframe>
</div>
</html>