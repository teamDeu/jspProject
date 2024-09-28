<%@page import="miniroom.ItemBean"%>
<%@page import="java.util.Vector"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:useBean id="mgr" class ="miniroom.ItemMgr"/>
<%
	String user_id = (String)session.getAttribute("idKey");
	Vector<ItemBean> characterList = mgr.getHoldCharacter(user_id);
	Vector<ItemBean> backgroundList = mgr.getHoldBackgroundImg(user_id);
	ItemBean usingCharacter = mgr.getUsingCharacter(user_id);
	ItemBean usingBackground = mgr.getUsingBackground(user_id);
	if(usingBackground.getItem_path() == null){
		usingBackground.setItem_path("./img/backgroundImg.png");
	}
	int index = 0;
	if(request.getParameter("index") != null){
		index = Integer.parseInt(request.getParameter("index"));
	}
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
	::-webkit-scrollbar {
  display: none;
}
	.miniroom_design_header{
		width : 100%;
	}
	#miniroom_design{
	font-family: 'NanumTobak', sans-serif;
	width : 100%;
	padding : 40px;
	border-radius:50px;
	overflow-y : scroll;
	box-sizing : border-box;
	background-color : #F7F7F7;
	}
	.miniroom_header_section{
		display:flex;
		justify-content:space-between;
		align-items:center;
	}
	.miniroom_design_main{
		position:relative;
		display:flex;
		align-items:flex-end;
		justify-content : space-around;
		width : 100%;
		height : 359px;
		margin-bottom : 5px;
	}
	.miniroom_design_main_img{
		position:absolute;
		width : 100%;
    	height : 359px;
		object-fit : cover;
		border-radius: 10px;
		z-index:5;
	}
	.miniroom_design_main_character_box{
		z-index:6;
	}
	.miniroom_design_main_character{
		object-fit : cover;
    	z-index:6;
    	width : 80px;
	}
	.miniroom_design_character_div{
		display:flex;
		position:relative;
		gap : 25px;
		border : 1px dashed #8A8A8A;
		padding : 20px 40px;
		border-radius:10px;
		align-items:center;
		background-color : white;
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
		width:120px;
		object-fit :contain;
	}
	.miniroom_design_character_room:hover{
		opacity:0.5;
	}
	.miniroom_design_background_div{
		position:relative;
		display:flex;
		align-items:center;
		gap : 30px;
		border : 1px dashed #8A8A8A;
		justify-content : space-around;
		padding : 20px 40px;
		border-radius:10px;
		background-color : white;
		max-height : 500px;
	}
	
	.miniroom_design_background_room{
		width : 40%;
	}
	.miniroom_design_background_room:hover{
		opacity:0.5;
	}
	.miniroom_design_background{
		width:100%;
		height : 100%;
		object-fit :cover;
	}
	.miniroom_design_background_separator{
		border : 0.5px solid #BAB9AA;
		height : 170px;
	}
	.index_button{
		display:flex;
		position:absolute;
		justify-content:center;
		align-items:center;
		height : 30px;
		background :none;
		border : none;
		z-index:3;
	}
	.index_button_right{
		right:5px;
	}
	.index_button_left{
		left:5px;
	}
	.index_button_img{
		object-fit : cover;
	}
	.miniroom_saveBtn{
		position:relative;
		border : none;	
		border-radius:10px;
		width:87px;
		height:45px;
		top:5px;
	}
	.miniroom_saveBtn:hover{
		background-color : #9B9B9B;
	}
	.miniroom_design_title{
		font-size:24px;
	}
</style>
<script>
	let characterIndex = 0;
	let backgroundIndex = 0;
	function clickCharacterRoom(num,image){
		frm = document.frm
		frm.character.value = num;
		rooms = document.querySelectorAll(".miniroom_design_character_room");
		for(i = 0; i < rooms.length ; i ++){
			if(rooms[i].id == num){
				rooms[i].style.border = "1px solid green";
			}
			else{
				rooms[i].style.border = "1px solid #DCDCDC"
			}
		}
		document.querySelector(".miniroom_design_main_character").src = image;
	}
	function clickBackgroundRoom(num,image){
		frm = document.frm
		frm.background.value = num;
		rooms = document.querySelectorAll(".miniroom_design_background_room");
		for(i = 0; i < rooms.length ; i ++){
			if(rooms[i].id == num){
				rooms[i].style.border = "1px solid green";
			}
			else{
				rooms[i].style.border = "1px solid #DCDCDC"
			}
		}
		document.querySelector(".miniroom_design_main_img").src = image;
	}
	function clickSaveBtn(){
		document.frm.submit();
		document.querySelector("#miniroom_background").src = document.querySelector(".miniroom_design_main_img").src;
		document.querySelector("#<%=user_id%>").querySelector(".userCharacter").src = document.querySelector(".miniroom_design_main_character").src 
	}
	
</script>
</head>
<body>
	<div id ="miniroom_design">
		<div class ="miniroom_design_header">
		<div class ="miniroom_header_section">
		<font class = "miniroom_design_title" size = "18" color ="#80A46F">내 미니룸</font>
		<button onclick = "clickSaveBtn()" class="miniroom_saveBtn">저장</button>
		</div>
			<hr color = "#BAB9AA" width = "100%">
		</div>
		<div class ="miniroom_design_main">
			<img class ="miniroom_design_main_img" src ="<%=usingBackground.getItem_path()%>">
			<img class ="miniroom_design_main_character" src="<%=usingCharacter.getItem_path()%>">
			
		</div>
		<section class ="miniroom_design_character_section">
			<font class = "miniroom_design_title" size ="18" color ="#0C6FC0">내 캐릭터</font>
			<hr color = "#BAB9AA" width = "100%"/>
			<div class ="miniroom_design_character_div">
				<button onclick ="clickPrevIndex('character')"class ="index_button index_button_left"><img class ="index_button_img" src ="./img/Left.png"></button>
				<button onclick ="clickNextIndex('character')" class ="index_button index_button_right"><img class ="index_button_img" src ="./img/Right.png"></button>
			</div>
		</section>
		<section class ="miniroom_design_background_section">
			<font class = "miniroom_design_title" size ="18" color ="#0C6FC0">내 배경화면</font>
			<hr color = "#BAB9AA" width = "100%">
			<div class ="miniroom_design_background_div">
				<button onclick ="clickPrevIndex('background')"class ="index_button index_button_left"><img class ="index_button_img" src ="./img/Left.png"></button>
				<button onclick ="clickNextIndex('background')" class ="index_button index_button_right"><img class ="index_button_img" src ="./img/Right.png"></button>
			</div>
		</section>
		<form name = "frm" action = "miniroomDesignProc.jsp" method = "post"  target="_blank">
			<input type ="hidden" name ="user_id" value = "<%=user_id %>">
			<input type = "hidden" name = "character" value ="<%=usingCharacter.getItem_num()%>">
			<input type = "hidden" name = "background" value ="<%=usingBackground.getItem_num()%>">
		</form>
	</div>
	<script>
	characterArray = [];
	backgroundArray = [];
	<%
		for(int i = 0 ; i < characterList.size(); i++){
			
		ItemBean bean = characterList.get(i);
		String image = bean.getItem_path();
		int num = bean.getItem_num();
		String name = bean.getItem_name();
	%>
		characterArray.push({
			image : '<%=image%>',
			num : <%=num%>,			
			name : "<%=name%>"
		})
	<%
		}
	%>
	
	<%
	for(int i = 0 ; i < backgroundList.size(); i++){
		
	ItemBean bean = backgroundList.get(i);
	String image = bean.getItem_path();
	int num = bean.getItem_num();
	String name = bean.getItem_name();
%>
	backgroundArray.push({
		image : '<%=image%>',
		num : <%=num%> ,
		name : "<%=name%>"
	})
<%
	}
%>
	 function printBackground(index){
		div = document.querySelector(".miniroom_design_background_div");
		indexLeft = div.querySelector(".index_button_left");
		indexRight = div.querySelector(".index_button_right");
		div.innerHTML = "";
		div.appendChild(indexLeft);
		div.appendChild(indexRight);
		for(i = (index)*2 ; i < (index+1)*2 ; i++){
			if(i == backgroundArray.length){
				break;
			}
			if(i % 2 == 1){
				separator = document.createElement("div");
				separator.classList.add("miniroom_design_background_separator");
				div.appendChild(separator);
			}
			e = backgroundArray[i];
			backgroundRoom = document.createElement("div");
			backgroundImg = document.createElement("img");
			backgroundRoom.id = e.num;
			backgroundRoom.onclick = (function(num, image) {
		        return function() {
		            clickBackgroundRoom(num, image);
		        };
		    })(e.num, e.image);
			backgroundRoom.classList.add("miniroom_design_background_room");
			backgroundImg.id = e.num;
			backgroundImg.alt = e.name;
			backgroundImg.src = e.image;
			backgroundImg.classList.add("miniroom_design_background");
			backgroundRoom.appendChild(backgroundImg);
			div.appendChild(backgroundRoom);
		}
	}
	
	function printCharacter(index){
		div = document.querySelector(".miniroom_design_character_div");
		indexLeft = div.querySelector(".index_button_left");
		indexRight = div.querySelector(".index_button_right");
		div.innerHTML = "";
		div.appendChild(indexLeft);
		div.appendChild(indexRight);
		for(i = index*8 ; i < (index+1)*8; i++){
			if(i == characterArray.length){
				break;
			}
			e = characterArray[i];
			characterRoom = document.createElement("div");
			characterImg = document.createElement("img");
			characterRoom.id = e.num;
			characterRoom.onclick = (function(num, image) {
		        return function() {
		            clickCharacterRoom(num, image);
		        };
		    })(e.num, e.image);
			characterRoom.classList.add("miniroom_design_character_room");
			characterImg.id = e.num;
			characterImg.alt = e.name;
			characterImg.src = e.image;
			characterImg.classList.add("miniroom_design_character");
			characterRoom.appendChild(characterImg);
			div.appendChild(characterRoom);
		}
	}

	printCharacter(0);
	printBackground(0);
	
	function clickPrevIndex(type){
		
		if(type == "character"){
			if(characterIndex != 0){
				characterIndex --;
				printCharacter(characterIndex);
			}
		}
		else if(type == "background"){
			console.log(backgroundIndex);
			if(backgroundIndex != 0){
				backgroundIndex --;
				printBackground(backgroundIndex);
			}
		}
	}
	
	function clickNextIndex(type){
		if(type == "character"){
			if(characterIndex+1 < characterArray.length / 8){
				console.log(characterIndex , characterArray.length);
				characterIndex ++;
				printCharacter(characterIndex);
			}
		}
		else if(type == "background"){
			if(backgroundIndex+1 < backgroundArray.length / 2){
				backgroundIndex ++;
				printBackground(backgroundIndex);
			}
		}
		console.log(backgroundIndex);
	}
	</script>
</body>
</html>





