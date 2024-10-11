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
            background-color: #F8F6E3;
            font-family: 'NanumTobak';
            zoom:1.1;	
            text-align: center;
        }
        .container {
            text-align: center;
            margin-top: 140px;
        }
        .box {
            background-color: #F8F6E3;
            border-radius: 30px;
            padding: 30px;
            width: 360px;
            margin-top: -25px; 
            border: 1px solid #ccc; /* 회색 테두리 추가 */
            margin-left: 680px;
        }
        .box input {
            width: 90%;
            padding: 10px;
            margin: 10px 0;
            border: 1px solid #ccc;
            border-radius: 37.75px;
            background-color: #F7FFF4;
            font-size: 24px;
            font-family: 'NanumTobak';
        }
        .btn {
            background-color: #C0E5AF;
            border: none;
            color: black;
            padding: 12px 130px;
            text-align: center;
            display: inline-block;
            font-size: 24px;
            margin: 10px 0px;
            cursor: pointer;
            border-radius: 37.75px;
            font-family: 'NanumTobak';
        }
        .header-logo {

            display: flex;
            margin-bottom: 30px;
            margin-left: 715px;
        }
        
        .box h2 {
        	margin-top: -20px;
        	font-weight: normal;
        	font-size: 25px;
        	margin-left: -10px;
        }
    </style>
</head>
<body>
    <div class="container">
    <div class="header-logo">
        <img src="./img/mainlogo.jpg" alt="CloverStory 로고" style="width:340px; height:120px;">
    </div>
        <div class="box">
            <h2>비밀번호 재설정</h2>
            <form action="processResetPassword.jsp" method="post">
                <input type="hidden" name="id" value="<%= id %>">
                <input type="password" name="new_password" placeholder=" 새 비밀번호를 입력하세요" required>
                <input type="password" name="confirm_password" placeholder=" 새비밀번호를 다시 한번 입력하세요" required>
                <button type="submit" class="btn">비밀번호 변경</button>
            </form>
        </div>
    </div>
</body>
</html>
