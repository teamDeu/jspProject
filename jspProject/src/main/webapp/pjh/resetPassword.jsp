<%@ page contentType="text/html; charset=UTF-8" %>

<%
    String id = request.getParameter("id");
%>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>비밀번호 재설정</title>
    <style>
    	@font-face {
        font-family: 'NanumTobak';
        src: url('나눔손글씨 또박또박.TTF') format('truetype');
        }
        body {
            font-family: 'NanumTobak';
            background-color: #F8F6E3;
            text-align: center;
        }
        .container {
            margin-top: 100px;
        }
        .box {
            display: inline-block;
            padding: 40px;
            border: 1px solid #ccc;
            border-radius: 10px;
            background-color: #F8F6E3;
        }
        .box input {
            display: block;
            width: 250px;
            margin-bottom: 20px;
            padding: 10px;
            border: 1px solid #ccc;
            border-radius: 5px;
            font-size: 20px;
            font-family: 'NanumTobak';
        }
        .btn {
            padding: 10px 20px;
            background-color: #C0E5AF;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-size: 20px;
            font-family: 'NanumTobak';
        }
    </style>
</head>
<body>
    <div class="container">
    <div class="header-logo">
        <img src="./img/mainlogo.jpg" alt="CloverStory 로고" style="width:200px; height:100px;">
    </div>
        <div class="box">
            <h2>비밀번호 재설정</h2>
            <form action="processResetPassword.jsp" method="post">
                <input type="hidden" name="id" value="<%= id %>">
                <input type="password" name="new_password" placeholder="새 비밀번호" required>
                <input type="password" name="confirm_password" placeholder="비밀번호 확인" required>
                <input type="submit" class="btn" value="비밀번호 변경" style = "width:270px">
            </form>
        </div>
    </div>
</body>
</html>
