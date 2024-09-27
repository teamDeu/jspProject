<%@ page contentType="text/html; charset=UTF-8"%>
<%
    
%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>아이디 찾기</title>
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
            display: inline-block;
            padding: 10px 0;
            width: 250px;
            background-color: #C0E5AF;
            color: white;
            text-decoration: none;
            border-radius: 5px;
            cursor: pointer;
            font-size: 20px;
            text-align: center;
            border: none;
            font-family: 'NanumTobak';
            
        }

        .btn:active {
            background-color: #7bb77a;
        }

        .header-logo {
            display: flex;
            justify-content: center;
            align-items: center;
            margin-bottom: 30px;
        }

        .header-logo img {
            width: 300px;
            margin-right: 10px;
        }

        .header-logo h1 {
            font-size: 24px;
            color: #005720;
            font-family: 'NanumTobak';
        }

        .footer-links {
            margin-top: 20px;
            font-size: 25px;
        }

        .footer-links a {
            text-decoration: none;
            color: #999;
            margin-right: 10px;
            font-family: 'NanumTobak';
        }

        .verification-container {
            display: flex;
            align-items: center;
            justify-content: space-between;
        }

        .verification-container input {
            width: 140px; /* 인증번호 칸의 너비를 줄임 */
        }

        .btn-resend {
            width: 100px;
            margin-left: 10px; /* 인증번호 칸과 재전송 버튼 사이에 간격 */
            background-color: #98D193;
            color: white;
            border: none;
            border-radius: 5px;
            padding: 10px;
            cursor: pointer;
            font-family: 'NanumTobak';
            font-size: 16px;
        }

        .btn-resend:active {
            background-color: #7bb77a;
        }
    </style>
</head>
<body>

<div class="container">
    <div class="header-logo">
        <img src="mainlogo.jpg" alt="CloverStory 로고" style="width:320px; height:100px;">
    </div>

    <div class="box">
        <h2>비밀번호 찾기</h2>
        <form action="processFindPWD.jsp" method="post">
        	<input type="text" name="id" placeholder="아이디" required>
            <input type="text" name="name" placeholder="이름" required>

            <input type="text" name="phone" placeholder="전화번호" required>
            <div class="verification-container">
                <input style ="margin:0px;"type="text" name="verificationCode" placeholder="인증번호" required>
                <button type="button" class="btn-resend" id="resendBtn" style = "background-color: #C0E5AF;">전송</button>
            </div>
            <br>
            <input type="submit"  class="btn" value="비밀번호찾기" style = "width :270px;">
        </form>
    </div>

    <div class="footer-links">
        <a href="login.jsp">로그인</a> |
        <a href="member.jsp">회원가입</a> |
        <a href="ifind.jsp">아이디 찾기</a>
    </div>
</div>

<script>
var authCode = ""; // 서버로부터 받은 인증번호를 저장할 변수

//인증번호 요청
document.getElementById('resendBtn').addEventListener('click', function() {
 var phoneNumber = document.querySelector('input[name="phone"]').value;

 if (phoneNumber == "") {
     alert("전화번호를 입력하세요.");
     return;
 }

 // 서버로 인증번호 요청 (Ajax로 처리)
 var xhr = new XMLHttpRequest();
 xhr.open("POST", "authCodeSend.jsp", true);
 xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
 xhr.onreadystatechange = function() {
     if (xhr.readyState == 4 && xhr.status == 200) {
         authCode = xhr.responseText.trim(); // 서버에서 받은 인증번호 저장
         if (authCode !== "") {
             alert("인증번호가 발송되었습니다.");
         } else {
             alert("인증번호 발송에 실패했습니다.");
         }
     }
 };
 xhr.send("phoneNumber=" + phoneNumber);
});
</script>

</body>
</html>
