<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String color = request.getParameter("color");
	String id = request.getParameter("id");
	session.setAttribute("color", color);
%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>실시간 채팅</title>
    <script type="text/javascript">
        var ws;
        var user  = "<%= request.getRemoteHost()%>";
        var id = "<%=id%>";
        function connect() {
            ws = new WebSocket("ws://" + location.host + "<%= request.getContextPath() %>/chat");
            ws.onopen = function() {
                document.getElementById("status").textContent = "서버와 연결됨";
                message = "connect;" + "<%=id%>" +";" + "<%=color%>";
                ws.send(message);
            };

            ws.onmessage = function(event) {
                var chatArea = document.getElementById("chatArea");
              	rawdata = event.data.split(";");
              	command = rawdata[0];
              	data = rawdata[1];
              	
              	if(command == ("sendMessage")){
              		chatArea.value += data + "\n";
              	}
              	else if(command == ("init")){
              		printUser(data,rawdata[2]);
              	}
              	else if(command == ("connect")){
	              	chatArea.value += data + "님이 입장하셨습니다.\n";
	              	// create a new div element
            		  printUser(data,rawdata[2]);
              	}
              	else if(command == ("disconnect")){
              		chatArea.value += data + "님이 퇴장하셨습니다.\n";
              		user = document.getElementById(data);
              		user.remove();
              	}

                
            };
            ws.onclose = function() {
                document.getElementById("status").textContent = "서버 연결 끊김";
            };
        }

        function sendMessage() {
            var message = "sendMessage;" + user + ":" + document.getElementById("messageInput").value;
            if (message.trim() !== "") {
                ws.send(message);
                document.getElementById("messageInput").value = '';
            }
        }
        
        function printUser(id,color){
        	newDiv = document.createElement("div");
    		  // and give it some content
    		  // add the text node to the newly created div
    		  newDiv.id = id;
    		  if((color != "" && color != null)){
    			  newColor = rawdata[2];
    			  newDiv.classList.add(newColor);
    		  }
    		  newContent = document.createTextNode(id);
    		  newDiv.appendChild(newContent);
    		  
    		  newDiv.classList.add("user");
    		  // add the newly created element and its content into the DOM
    		  if(miniroom){
    			  miniroom.appendChild(newDiv);
    		  }
    		  else{
    			  alert("찾을수없음");
    		  }
        }
        function disconnect(){
        	var message = "disconnect;" + id;
        	ws.send(message);
        	ws.close();
        }
       	window.addEventListener("beforeunload",disconnect);
    </script>
    <style>
    	#miniroom{
    		width : 300px;
    		height : 300px;
    		border : 1px solid black;
    	}
    	.user{
    		width :100px;
    		height : 30px;
    		background-color : black;
    	}
    	.red{
    		background-color : red;
    	}
    	.blue{
    		background-color : blue;
    	}
    	
    </style>
</head>
<body onload="connect();">
    <h2>실시간 채팅</h2>
    <p id="status">서버에 연결되지 않음</p>
    <textarea id="chatArea" rows="10" cols="50" readonly></textarea><br>
    <input type="text" id="messageInput" onkeypress="if(event.keyCode==13) sendMessage();">
    <button onclick="sendMessage()">전송</button>
    <button onclick="disconnect()">연결끊기</button>
    <div id = "miniroom">
    	
    </div>
    <script>
    	miniroom = document.getElementById("miniroom");
    	console.log(miniroom);
    </script>
</body>
</html>
