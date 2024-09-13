<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>CloverStory 채팅방 접속</title>
    <script>
        // 버튼 클릭 시 AJAX 요청을 보내고, 응답을 받아 div 내용 변경
        function loadContent() {
            var xhr = new XMLHttpRequest();
            xhr.onreadystatechange = function() {
                if (xhr.readyState == 4 && xhr.status == 200) {
                    document.getElementById("contentDiv").innerHTML = xhr.responseText;
                }
            };
            xhr.open("GET", "chat.jsp", true);
            xhr.send();
        }
        function countUp(){
        	t = document.getElementById("test");
        	t.innerText = parseInt(t.innerText) + 1
        }
    </script>
</head>
<button onclick = "loadContent()">가져오기</button>
<div id = "contentDiv"></div>
<body align="center">
    <h1>CloverStory 채팅방 접속</h1>
    <form name = "goChat" action = "chat.jsp">
    이름 : <input type = "text" name = "id">
    이미지 : <select name ="character">
    	<%for(int i = 1 ; i <= 5 ; i++) {
    	String value = "character" + i + ".png";%>
    	<option value = "<%=value%>"><%=i %>번캐릭터</option>
    	<%} %>
    </select>
    <button type ="submit">접속</button>
    </form>
</body>
</html>