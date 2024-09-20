<%@page import="miniroom.ItemBean"%>
<%@page import="java.util.Vector"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:useBean id="mgr" class ="miniroom.ItemMgr"/>
<%
	Vector<ItemBean> characterList = mgr.getHoldCharacter("als981209");
	Vector<ItemBean> backgroundList = mgr.getHoldBackgroundImg("als981209");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
	@font-face {
    font-family: 'NanumTobak';
    src: url('나눔손글씨 또박또박.TTF') format('truetype');
	}
	#miniroom_design{
	font-family: 'NanumTobak', sans-serif;
	width : 70%;
	overflow-y : scroll;
	}
	.miniroom_design_main_img{
		width:100%;
		object-fit :cover;
		border-radius: 10px;
	}
	.miniroom_design_character_div{
		display:flex;
		gap : 25px;
		border : 1px dashed #8A8A8A;
		padding : 20px;
		border-radius:10px;
	}
	.miniroom_design_character_room{
		display:flex;
		align-items:center;
		justify-content:center;
		width : 160px;
		height : 190px;
		border : 1px solid #DCDCDC;
		border-radius : 10px;
	}
	.miniroom_design_character{
		width:90%;
		object-fit :contain;
	}
	.miniroom_design_background_div{
		display:flex;
		gap : 25px;
		border : 1px dashed #8A8A8A;
		padding : 20px;
		border-radius:10px;
	}
	
	.miniroom_design_background_room{
		width:482px;
		height : 280px;
	}
	
	.miniroom_design_background{
		width:100%;
		height : 100%;
		object-fit :cover;
	}
	.miniroom_design_background_separator{
		border : 0.5px solid #BAB9AA;
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
			<img class ="miniroom_design_main_img" src ="./img/backgroundImg.png">
		</div>
		<section class ="miniroom_design_character_section">
			<font size ="24" color ="#0C6FC0">내 캐릭터</font>
			<hr color = "#BAB9AA" width = "100%"/>
			<div class ="miniroom_design_character_div">
				<% for(int i = 0 ; i < characterList.size() ; i ++){
					ItemBean characterBean = characterList.get(i);
					String image = characterBean.getItem_path();
				%>
					<div class = "miniroom_design_character_room">
						<img class = "miniroom_design_character" src='<%=image%>'">
					</div>
				<%} %>
			</div>
		</section>
		<section class ="miniroom_design_background_section">
			<font size ="24" color ="#0C6FC0">내 배경화면</font>
			<hr color = "#BAB9AA" width = "100%">
			<div class ="miniroom_design_background_div">
				<% for(int i = 0 ; i < backgroundList.size() ; i ++){
					ItemBean backgroundBean = backgroundList.get(i);
					String image = backgroundBean.getItem_path();
				%>
					<div class = "miniroom_design_background_room">
						<img class = "miniroom_design_background" src='<%=image%>'">
					</div>
					<div class = "miniroom_design_background_separator"></div>
				<%} %>
			</div>
		</section>
	</div>
</body>
</html>