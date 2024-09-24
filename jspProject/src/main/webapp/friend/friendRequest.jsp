<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
String requestSendUser = request.getParameter("requestSendUser");
String requestReciveUser = request.getParameter("requestReciveUser");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
@font-face {
    font-family: 'NanumTobak';
    src: url('./나눔손글씨 또박또박.TTF') format('truetype');
}

* {
    font-family: 'NanumTobak', sans-serif;
    font-size : 24px;
}
body {
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
</head>
<body>
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
					<select>
						<option>일촌</option>
						<option>이촌</option>
					</select> 을 신청합니다.
				</div>
			</section>
		</div>
			<input class="request_comment" type="text">
		<div>
			<button class ="request_button">취소</button>
			<button class ="request_button">전송</button>
		</div>
	</div>
</body>
</html>