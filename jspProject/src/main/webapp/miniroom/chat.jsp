<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String backgroundImg = request.getParameter("backgroundImg");
	String id = (String)session.getAttribute("idKey");
	String url = request.getParameter("url");
%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>실시간 채팅</title>
    <%-- <script type="text/javascript">
        var ws;
        var sayBoxId = 0;
        let userNum = 0;
        var localId = "<%=id%>";
        function connect() {
            ws = new WebSocket("ws://" + location.host + "<%= request.getContextPath() %>/chat");
            ws.onopen = function() {
                document.getElementById("status").textContent = "서버와 연결됨";
                if(localId == "null") localId = "비회원";
                message = "connect;" + localId +";" + "<%=character%>";
                ws.send(message);
            };

            ws.onmessage = function(event) {
              	rawdata = event.data.split(";");
              	command = rawdata[0];
              	data = rawdata[1];
              	
              	if(command == ("sendMessage")){
              		comment = data.split(":")[1];
              		user = data.split(":")[0];
              		if(comment == "") return;
              		printSayBox(user);
         			printChatBox(user,comment,"chat");
      			  	
              	}
              	else if(command == ("init")){
              		userNum ++;
              		printUser(data,rawdata[2]);
              		
              	}
              	else if(command == ("connect")){
	              	// create a new div element
	              	userNum ++;
            		printUser(data,rawdata[2]);
            		printChatBox(data,data+"님이 입장하셨습니다.","notice");
	              	
              	}
              	else if(command == ("disconnect")){
              		printChatBox(data,data+"님이 퇴장하셨습니다.","notice");
              		user = document.getElementById(data);
              		user.remove();
              		userNum --;
              	}
            };
            ws.onclose = function() {
                document.getElementById("status").textContent = "서버 연결 끊김";
            };
        }

        function sendMessage() {
            var message = "sendMessage;" + localId + ":" + document.getElementById("messageInput").value;
            if (message.trim() !== "") {
                ws.send(message);
                document.getElementById("messageInput").value = '';
                
            }
        }
        
        function printUser(id,character){
        	newDiv = document.createElement("div");
        	newImg = document.createElement("img");
        	newImg.classList.add("userCharacter");
        	newImg.src ="img/"+character;
        	nowvisit = document.getElementById("nowvisit");
        	nowvisit.innerText = "Now " + userNum; 
    		  // and give it some content
    		  // add the text node to the newly created div
    		  newDiv.id = id;
    		  newContent = document.createTextNode(id);
    		  newDiv.appendChild(newContent);
    		  newDiv.appendChild(newImg);
    		  newDiv.classList.add("user");
    		  // add the newly created element and its content into the DOM
    		  if(miniroom){
    			  miniroom.appendChild(newDiv);
    		  }
    		  else{
    			  alert("찾을수없음");
    		  }
        }
        
        function printSayBox(id){
      		miniroom = document.getElementById("miniroom");
      		newDiv = document.createElement("div");
      		newContent = document.createTextNode(comment);
      		newDiv.appendChild(newContent);
      		userDiv = document.getElementById(id);
      		userRect = userDiv.getBoundingClientRect();
      		newDiv.classList.add("sayBox");
      		newDiv.id = sayBoxId;
      		miniroom.appendChild(newDiv);
			newDivTop = userRect.top - newDiv.offsetHeight;
      		newDivLeft = userRect.left + 30;
      		newDiv.style.top = newDivTop+"px"
      		newDiv.style.left = newDivLeft+"px"
      	  	sleep(5000).then(() => document.getElementById(sayBoxId).remove());
        }
        
        function printChatBox(id,comment,type){
        	chatArea2 = document.getElementById("chatArea2");
        	chatBoxDiv = document.createElement("div");
        	newContent = document.createTextNode(comment);
        	chatDiv = document.createElement("div");
        	chatDiv.appendChild(newContent);
        	chatBoxDiv.appendChild(chatDiv);
        	if(id == localId){
        		chatDiv.classList.add("myChat");
        		chatBoxDiv.classList.add("myChatBox");
        	}
        	else{
        		chatDiv.classList.add("otherChat");
        		chatBoxDiv.classList.add("otherChatBox");
        	}

        	chatDiv.classList.add(type);
        	userNameDiv = document.createElement("div");
        	let today = new Date();
    		userNameContent = document.createTextNode(today.toLocaleString() + "  " + id);
    		
    		userNameDiv.appendChild(userNameContent);
    		userNameDiv.classList.add("chatName");
    		chatBoxDiv.appendChild(userNameDiv);
    		//
        	chatBoxDiv.classList.add("chatBox");
        	chatArea2.appendChild(chatBoxDiv);
        	chatArea2.scrollTop = chatArea2.scrollHeight;
        }
        function sleep(ms) {
        	  return new Promise((r) => setTimeout(r, ms));
        	}
        
        function disconnect(){
        	var message = "disconnect;" + localId;
        	location.href ="index.jsp";
        	ws.send(message);
        	ws.close();
        }
       	window.addEventListener("beforeunload",disconnect);
    </script> --%>
	<link href="./css/chat.css" rel="stylesheet" />
	<style>
	.miniroom_header_title{
		display:flex;
		justify-content : space-between;
		align-items:center;
	}
	.miniroom_board_title{
	    color: #80A46F;
	    text-align: center;
	    font-size: 38px;
	    font-weight: 600;
	    position: absolute;
	    top: 27px;
	    left: 30px;
	    display: inline-block;
	}
	.miniroom_board_line{
	    border-bottom: 1px solid #BAB9AA;
	    margin : 15px 0px 10px -20px;
    	width: 830px;
	}
	
	.miniroom_header_title span{
		margin-left: 730px;
		margin-top: 40px;    
	    font-family: 'NanumTobak', sans-serif;
	    font-size: 20px;
	    cursor: pointer;
	    color: black;
	}
	
	.setting button{
		font-family: 'NanumTobak', sans-serif;
	    font-size: 18px;
	    cursor: pointer;
	    color: black;
	    border: none;
	    background: none;
	    margin-top: -5px;
	}
	
	.nowvisit {
		font-family: 'NanumTobak', sans-serif;
	    font-size: 18px;
	}
	
	#chatArea2 {
		width: 736px;
	    height: 200px;
	    border: 1px solid #BAB9AA;
	    border-radius: 5px;
	    display: flex;
	    flex-direction: column;
	    background-color: #F2F2F2;
	    overflow-y: scroll;
	    margin: 8px 0px;
	}
	
	#miniroom_background {
		position: absolute;
		object-fit: cover;
		width: 736px;
		height: 359px;
		z-index: 1;
		border-radius: 10px;
		border: 1px solid #BAB9AA;
	}
	
	#inputArea {
		width: 735px;
		padding: 10px;
		border: 1px solid #BAB9AA;
		border-radius: 5px;
		box-sizing: border-box;
	}
	
	#messageInput {
		width: 590px;
		height: 20px;
		font-size: 16px;
		margin: 0px 10px;
		border: 1px solid #BAB9AA;
		border-radius: 5px;
		
	}
	
	#inputArea button {
		font-family: 'NanumTobak', sans-serif;
	    font-size: 16px;
	    color: black;
	    border: 1px solid #BAB9AA;
	    background-color: #F2f2f2;
	    border-radius: 5px;
	    padding: 2px 6px;

	}
	
	#miniroom {
		display: flex;
		align-items: flex-end;
		justify-content: space-around;
		width: 736px;
		height: 359px;
		border: none;
		border-radius: 5px;
		z-index: 5;
		
		
	}
	
	.sayBox {
		position: absolute;
		border: 1px solid #BAB9AA;
		background-color: white;
		padding: 5px;
		border-radius: 5px;
		animation: fadeout 1.5s;
		-moz-animation: fadeout 1.5s; /* Firefox */
		-webkit-animation: fadeout 1.5s; /* Safari and Chrome */
		-o-animation: fadeout 1.5s; /* Opera */
		animation-fill-mode: forwards;
		overflow-x: hidden;
		word-break: break-all;
		word-wrap: break-word;
		font-size:20px;
		z-index: 6;
	}
	
	</style>
</head>
<body onload="connect();">
	<div class ="miniroom_header">
	<div class ="miniroom_header_title">
	<font class ="miniroom_board_title">미니룸</font>
	<span id="status">서버에 연결되지 않음</span>
	</div>	
    	<div class="miniroom_board_line"></div>
	</div>
    <div id = "miniroom">
    	<img id ="miniroom_background" src="<%=backgroundImg%>">
    </div>
    <div class ="setting">
    	<%if(url.equals(id)){ %>
    	<button onclick = "clickOpenBox('inner-box-2-miniroom')">미니룸 설정</button>
    	<%} %>
    	<div id ="nowvisit">NOW 0</div>
    </div>
    <div id ="chatArea2"></div>
    <div id="inputArea">
    <span class ="input_title">Friend Say</span>
    <input type="text" placeholder =" 일촌과 나누고 싶은 이야기를 남겨보세요!" id="messageInput" onkeypress="if(event.keyCode==13) sendMessage();">
    <button onclick="sendMessage()">전송</button>
    </div>
    <script>
    	miniroom = document.getElementById("miniroom");
    	document.addEventListener('DOMContentLoaded', function () {
    		if(isSuspension){
    			document.getElementById("messageInput").disabled = true;
    			document.getElementById("messageInput").placeholder = "채팅이 정지된 계정입니다.";
    		}
    	})
    </script>
</body>
</html>
