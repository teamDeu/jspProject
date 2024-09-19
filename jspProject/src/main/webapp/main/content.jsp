<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script>
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
</script>
</head>
<body>
	<div class = "miniroom_box">
		김민석
<body>
		<div class = "miniroom_box">
	박정현 야이 나쁜놈들아 좀 되라 
	양지혁

	</div>
</body>
<div>
	TEST 김민석
	<span>김민석</span>
	<button onclick = "김민석">김민석</button>
</div>
<body>

</html>