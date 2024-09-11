<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>JSP Button Click Example</title>
    <script>
        // 버튼 클릭 시 AJAX 요청을 보내고, 응답을 받아 div 내용 변경
        function loadContent() {
            var xhr = new XMLHttpRequest();
            xhr.onreadystatechange = function() {
                if (xhr.readyState == 4 && xhr.status == 200) {
                    document.getElementById("contentDiv").innerHTML = xhr.responseText;
                }
            };
            xhr.open("GET", "content.jsp", true);
            xhr.send();
        }
    </script>
</head>
<body>
    <h1>JSP 버튼 클릭으로 내용 변경</h1>
    <button onclick="loadContent()">내용 불러오기</button>
    <div id="contentDiv">
        여기에 새로운 내용이 표시됩니다.
    </div>
    <form name = "goChat" action = "chat.jsp">
    id : <input type = "text" name = "id"><br>
    color : <input type ="text" name ="color"><br>
    <button type ="submit">가기</button>
    </form>
</body>
</html>