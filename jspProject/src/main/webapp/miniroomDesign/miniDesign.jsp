<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
	.miniroom_design_main_img{
		width:100%;
		object-fit :cover;
		border-radius: 10px;
	}
</style>
</head>
<body>
	<div id ="miniroom_design">
		<div class ="miniroom_header">
			<font size = "24" color ="#80A46F">내 미니룸</font>
			<hr color = "#BAB9AA" width = "100%">
		</div>
		<div class ="miniroom_design_main">
			<img class ="miniroom_design_main_img" src = "./img/backgroundImg.png">
		</div>
		<section class ="miniroom_design_character_section">
			<font size ="24" color ="#0C6FC0">내 캐릭터</font>
			<hr color = "#BAB9AA" width = "100%"/>
			<div class ="miniroom_design_character_box">
				<% %>
			</div>
		</section>
		<section class ="miniroom_design_background_section">
			<font size ="24" color ="#0C6FC0">내 배경화면</font>
			<hr color = "#BAB9AA" width = "100%">
			<div class ="miniroom_design_background_box">
			</div>
		</section>
		
	</div>
</body>
</html>