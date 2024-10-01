<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	String connectId = (String)session.getAttribute("idKey");
	
%>
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
	display:flex;
	
	align-items:center;
	width: 360px;
	height: 300px;
	background-color : #F7F7F7;
	justify-content:center;
	border : 1px solid #BAB9AA;
	padding: 40px 20px;
	box-sizing : border-box;
	border-radius:20px;
}
.request_main_div *{
	    font-size : 24px;
}
.request_div{
	display:flex;
	position:relative;
	width : 100%;
	align-items:center;
	flex-direction:column;
	justify-content:center;
	background-color : #FFFFFF;
	border : 1px solid #DCDCDC;
	border-radius:20px;
	padding : 30px 20px;
	box-sizing : border-box;
	gap:10px;
}
.request_header {
	position : relative;
	display: flex;
	align-items: center;
	gap:20px;
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
	margin:0px;
	border : 0.5px solid #DCDCDC;
	box-sizing : border-box;
}
.request_user_name_font{
	font-weight : bold;
}
.request_button{
	padding: 5px 20px;
    border-radius: 15px;
    border: 0.5px solid #DCDCDC;
}
.request_button:hover{
	background-color : #E8E8E8;
}
</style>
<script>
function frequest_receive_clickCancelBtn(){
	document.getElementById("friend_request_modal_receive").style.display = "none";
	fr_form = document.friend_request_form_receive;
	fr_form.request_num.value = document.querySelector(".request_num").value;
	fr_form.receive_type.value = "reject";
	fr_form.submit();
	alert("친구요청을 거절했습니다.");
	alarmRenewal();
}
	function frequest_receive_clickSubmitBtn(){
		
		fr_form = document.friend_request_form_receive;
		fr_form.request_num.value = document.querySelector(".request_num").value;
		fr_form.receive_type.value = "accept";
		fr_form.submit();
		document.getElementById("friend_request_modal_receive").style.display = "none";
		
		alarmRenewal();
	    fr_modal = document.getElementById("friend_request_modal_receive");
	    
	   	userId = fr_modal.querySelector(".request_senduserid").value;
	   	userName = fr_modal.querySelector(".request_user_name_font").innerText;
	   	userCharacter = fr_modal.querySelector(".request_profile_img").src;
	   	requestType = fr_modal.querySelector('.request_type_span').innerText;
	   	connectId = '<%=connectId%>'
	   	
		if(!isFriend(connectId,userId)){
			if(url == userId){
				submitFriendRequest(connectId,localName,localCharacter,requestType);
			}
			else if(url == connectId){
				submitFriendRequest(userId,userName,userCharacter,requestType);
			}
			
		}
	    
	}
	function alarmRenewal(){
		alarm_items = alarm_items.filter((e) => e.querySelector('input[name="num"]').value != fr_form.request_num.value);
		
		var xhr = new XMLHttpRequest();
	    xhr.open("GET", "../miniroom/alarmProc.jsp?type=delete&content_type=친구요청&content_num="+document.querySelector(".request_num").value, true); // Alarm 갱신Proc
	    xhr.onreadystatechange = function () {
	        if (xhr.readyState === 4 && xhr.status === 200) {
	        	
	        }
	    };
	    xhr.send();
		displayalarm_items();
	    alarm_updatePagination();
	}
	function frequest_receive_clickCloseBtn(){
		document.getElementById("friend_request_modal_receive").style.display = "none";
	}
</script>
</head>
<div class ="request_main_div">
	<div class="request_div">
	<button style = "position:absolute; right : 0px ; top: 0px ; font-size : 10px;" onclick ="frequest_receive_clickCloseBtn()">X</button>
		<div class="request_header">
			<section class="request_profile_section">
				<img src="./img/character1.png" class="request_profile_img">
			</section>
			<section class="request_title_section">
				<div>
					<font class="request_user_name_font"> 신짱구 </font>님이 <br>
				</div>
				<div>
					<span class="request_type_span"></span> 을 신청합니다.
				</div>
			</section>
		</div>
			<input class="request_comment" type="text" placeholder = "친구신청 메시지">
			<input type ="hidden" class = "request_num" value ="">
			<input type ="hidden" class ="request_senduserid" value ="">
		<div>
			<button onclick = "frequest_receive_clickSubmitBtn()" class ="request_button">수락</button>
			<button onclick = "frequest_receive_clickCancelBtn()" class ="request_button">거절</button>
		</div>
	</div>
	<form name = "friend_request_form_receive" target = "blankifr" action = "./friendRequestProc.jsp">
   		<input type ="hidden" name = "request_num" value ="">
   		<input type ="hidden" name = "receive_type" value ="">
   		<input type ="hidden" name = "type" value ="receive">
   </form>
       <iframe name='blankifr' style='display:none;'></iframe>
</div>
</html>