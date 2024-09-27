<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	String type = request.getParameter("type");
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
	function clickCancelBtn(){
		document.getElementById("friend_request_modal_send").style.display = "none";
	}
	function clickSubmitBtn(){
		fr_form = document.friend_request_form_send;
		fr_form.request_comment.value = document.querySelector(".request_comment").value;
		fr_form.submit();
		document.getElementById("friend_request_modal_send").style.display = "none";
		if(fr_form.request_senduserid.value == fr_form.request_receiveuserid){
			alert("본인에게 친구요청 할 수 없습니다.")
			return;
		}
		alert("친구 요청 성공!");
	}
	function changeType(select){
		fr_form = document.friend_request_form_send;
		fr_form.request_type.value = select.value;
	}
</script>
</head>
<div class ="request_main_div">
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
					<select onchange ="changeType(this)">
						<option value ="1">일촌</option>
						<option value ="2">이촌</option>
					</select> 을 신청합니다.
				</div>
			</section>
		</div>
			<input class="request_comment" type="text" placeholder = "친구신청 메시지">
		<div>
			<button onclick = "clickCancelBtn()" class ="request_button">취소</button>
			<button onclick = "clickSubmitBtn()" class ="request_button">전송</button>
		</div>
	</div>
	<form name = "friend_request_form_send" action = "./friendRequestProc.jsp" target = "blankifr">
   		<input type ="hidden" name = "request_senduserid" value ="">
   		<input type ="hidden" name = "request_receiveuserid" value ="">
   		<input type ="hidden" name = "request_type" value ="1">
   		<input type ="hidden" name ="request_comment" value ="">
   		<input type ="hidden" name ="type" value ="send">
   </form>
       <iframe name='blankifr' style='display:none;'></iframe>
</div>
</html>