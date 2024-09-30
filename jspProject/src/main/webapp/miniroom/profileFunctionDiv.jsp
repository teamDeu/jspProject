<%@page import="friend.FriendMgr"%>
<%@page import="miniroom.ItemMgr"%>
<%@page import="pjh.MemberBean"%>
<%@page import="pjh.MemberMgr"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%
	String connectId = (String) session.getAttribute("idKey");
	if (connectId == null) {
		response.sendRedirect("../pjh/login.jsp");
		return;
	}
	MemberMgr mgr = new MemberMgr();
	ItemMgr imgr = new ItemMgr();
	FriendMgr fmgr = new FriendMgr();
	String profileId = request.getParameter("profileId");
	MemberBean user = mgr.getMember(profileId);
	String name = user.getUser_name();
	String userId = user.getUser_id();
	String userCharacter = imgr.getUsingCharacter(userId).getItem_path();
%>
<!DOCTYPE html>
<html>
<head>
<script>
	function onclickAddFriend(requestSendUser, requestReciveUser,character,name) {
            fr_modal = document.getElementById("friend_request_modal_send");
            fr_form = document.friend_request_form_send;
            fr_form.request_senduserid.value = requestSendUser;
            fr_form.request_receiveuserid.value = requestReciveUser;
            fr_modal.style.display = "flex";
            fr_modal.querySelector(".request_comment").value = "";
            fr_modal.querySelector(".request_user_name_font").innerText = name;
            fr_modal.querySelector(".request_profile_img").src = character;
        };
  function onclickGoHomePage(id){
          location.href = "http://"+location.host+"/jspProject/miniroom/main.jsp?url=" + id;   
     };
  function onclickDeleteFriend(senduserid,receiveuserid,name){
	  	fr_form = document.friend_delete_form;
	  	console.log(fr_form);
	  	fr_form.request_senduserid.value = senduserid;
	  	fr_form.request_receiveuserid.value = receiveuserid;
	  	fr_form.submit();
	  	friend_items = friend_items.filter((e) => e.querySelector(".main_profile_friends_name").innerText != name);
	  	friend_displayItems();
  }
	</script>
<style>
.profile_function_div_main{
	display:none;
	
}
.profile_function_div {
	display: flex;
	z-index:3;
	flex-direction: column;
	position: absolute;
	width: 120px;
	padding: 10px;
	gap: 10px;
	border-radius: 10px;
	box-sizing: border-box;
	background-color: #FFFEF3;
	left:0px;
	top: -120px;
	border: 2px solid #BAB9AA;
}

.profile_function_div button {
	padding: 2px 10px;
	border: 1px solid #DCDCDC;
	background-color: #FFFFFF;
	font-size: 16px;
	border-radius: 10px;
}

.profile_function_div span {
	align-self: center;
	font-size: 20px;
}
</style>
</head>
<div class="profile_function_div_main" style ="display : none">
	<div class="profile_function_div">
		<span><%=name%></span>
		<%if(fmgr.isFriend(connectId,userId)){ %>
			<button onclick = "onclickDeleteFriend('<%=connectId %>','<%=userId%>','<%=name%>')">친구삭제</button>
		<%}else{ %>
		<button onclick="onclickAddFriend('<%=connectId%>','<%=userId%>','<%=userCharacter%>','<%=name%>')">친구추가</button>
		<%} %>
		<button onclick="onclickGoHomePage('<%=userId%>')">미니룸 구경가기</button>
	</div>
</div>
</html>