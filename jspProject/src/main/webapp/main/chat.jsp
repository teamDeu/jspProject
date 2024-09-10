<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>실시간 채팅</title>
    <script type="text/javascript">
        var ws;
        function connect() {
            ws = new WebSocket("ws://" + location.host + "<%= request.getContextPath() %>/chat");
            ws.onopen = function() {
                document.getElementById("status").textContent = "서버와 연결됨";
            };

            ws.onmessage = function(event) {
                var chatArea = document.getElementById("chatArea");
                chatArea.value += event.data + "\n";
            };

            ws.onclose = function() {
                document.getElementById("status").textContent = "서버 연결 끊김";
            };
        }

        function sendMessage() {
            var message = document.getElementById("messageInput").value;
            if (message.trim() !== "") {
                ws.send(message);
                document.getElementById("messageInput").value = '';
            }
        }
    </script>
</head>
<body onload="connect();">
    <h2>실시간 채팅</h2>
    <p id="status">서버에 연결되지 않음</p>
    <textarea id="chatArea" rows="10" cols="50" readonly></textarea><br>
    <input type="text" id="messageInput" onkeypress="if(event.keyCode==13) sendMessage();">
    <button onclick="sendMessage()">전송</button>
</body>
</html>
