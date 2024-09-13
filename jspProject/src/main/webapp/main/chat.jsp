<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String character = request.getParameter("character");
	String id = request.getParameter("id");
%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>실시간 채팅</title>
    <script type="text/javascript">
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
    </script>
    <style>
    	body{
    		display:flex;
    		flex-direction : column;
    		align-items:center;
    	}
    	.userCharacter{
    		object-fit : cover;
    		width : 80px;
    		heigth : 120px;
    	}
    	#miniroom{
    		display:flex;
    		align-items:flex-end;
    		justify-content:space-around;
    		width : 736px;
    		height : 359px;
    		border : 1px solid black;
    		border-radius : 10px
    	}
    	#miniroom_background{
    		position:absolute;
    		z-index : -1;
    		object-fit : cover;
 			width : 736px;
 			height :359px;
 			
    	}
    	#chatArea{
    		width:736px;
    		heigth : 214px;
    		border-radius : 5px;
    		padding : 10px;
    		display:flex;
    		align-items:center;
    		box-sizing : border-box;
    	}
    	.setting{
    		display:flex;
    		width : 736px;
    		justify-content:space-between;
    	}
    	.user{
    		display:flex;
    		flex-direction:column;
    		align-items:center;
     	}
    	.sayBox{
    		position : absolute;
    		max-width : 150px;
    		border :1px solid black;
    		background-color : white;
    		padding:5px;
    		border-radius : 5px;
    		animation: fadeout 3s;
			  -moz-animation: fadeout 3s; /* Firefox */
			  -webkit-animation: fadeout 3s; /* Safari and Chrome */
			  -o-animation: fadeout 3s; /* Opera */
			  animation-fill-mode: forwards;
			overflow-x : hidden;
			word-break: break-all;
			word-wrap:break-word;
    	}
    	#inputArea{
    		width : 736px;
    		padding : 10px;
    		border : 1px solid black;
    		border-radius : 5px;
    		box-sizing : border-box;
    	}
		@keyframes fadeout {
		    from {
		        opacity: 1;
		    }
		    to {
		        opacity: 0;
		    }
		}
		@-moz-keyframes fadeout { /* Firefox */
		    from {
		        opacity: 1;
		    }
		    to {
		        opacity: 0;
		    }
		}
		@-webkit-keyframes fadeout { /* Safari and Chrome */
		    from {
		        opacity: 1;
		    }
		    to {
		        opacity: 0;
		    }
		}
		@-o-keyframes fadeout { /* Opera */
		    from {
		        opacity: 1;
		    }
		    to {
		        opacity: 0;
		    }
		}
		.input_title{
			font-size : 20px;
			color : #80A46F;
		}
		input[type=text] {
		width: 500px ;
		height: 20px ;
		font-size: 12px ;
		margin: 0px 10px;
		}
		#chatArea2{
			width : 736px;
			height : 200px;
			border : 1px solid black;
			border-radius : 5px;
			display:flex;
			flex-direction : column;
			background-color : #F2F2F2;
			overflow-y : scroll;
		}

		.chat{
			max-width : 200px;
			padding : 5px;
			border-radius : 10px;
			display:flex;
			word-break: break-all;
			word-wrap:break-word;
		}
		.myChatBox{
			align-self : flex-end;
			
		}
		.otherChatBox{
			align-self : flex-start;
			
		}
		.myChat{
			align-self : flex-end;
			background-color : #F8F6E3;
		
		}
		.otherChat{
			align-self : flex-start;
			background-color : #FEFEFE;
		}
		.chatBox{
			display:flex;
			flex-direction :column;
			background-color : none;
			margin : 5px 10px;
		}
		.chatName{
			font-size : 10px;
			margin : 5px 10px;
			align-self :inherit;
		}
		.notice{
			max-width : 200px;
			padding : 5px;
			border-radius : 10px;
			display:flex;
			word-break: break-all;
			word-wrap:break-word;
			background-color : #C0E5AF;
		}
    </style>
</head>
<body onload="connect();">
    <h2>실시간 채팅</h2>
    <p id="status">서버에 연결되지 않음</p>
    <div id = "miniroom">
    	<img id ="miniroom_background" src="img/backgroundImg.png">
    </div>
    <div class ="setting">
    	<button>미니룸 설정</button>
    	<div id ="nowvisit">NOW 0</div>
    </div>
    <div id ="chatArea2"></div>
    <div id="inputArea">
    <span class ="input_title">Friend Say</span>
    <input type="text" placeholder ="일촌과 나누고 싶은 이야기를 남겨보세요~" id="messageInput" onkeypress="if(event.keyCode==13) sendMessage();">
    <button onclick="sendMessage()">전송</button>
    </div>
    
    <button onclick="disconnect()">연결끊기</button>
    <script>
    	miniroom = document.getElementById("miniroom");
    </script>
</body>
</html>
