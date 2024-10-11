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
            zoom:1.1;
        }

        .container {
        	text-align: center;
            margin-top: 140px;
        }

        .box {
            background-color: #F8F6E3;
            border-radius: 30px;
            padding: 30px;
            width: 380px;
            margin-top:-22px; 
            border: 1px solid #ccc; /* 회색 테두리 추가 */
            margin-left: 680px;
        }
        
        .box h2 {
        	margin-top: -20px;
        	font-weight: normal;
        	font-size: 25px;
        	margin-left: -10px;
        }

        .box input {
            width: 80%;
            padding: 10px;
            margin-top: 10px;
            margin-left: -65px;
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
            padding: 10px 60px;
            text-align: center;
            font-size: 24px;
            
            cursor: pointer;
            border-radius: 37.75px;
            font-family: 'NanumTobak';
            
        }

        .header-logo {

            margin-bottom: 30px;
            margin-left: 40px;
        }	

        


        .footer-links {
            margin-top: 10px;
            font-size: 25px;
            font-family: 'NanumTobak';
            margin-left: 105px;
        }

        .footer-links a {
            text-decoration: none;
		    color: black;
		    margin: 0 10px;
        }

        .verification-container {
            display: flex;
		    align-items: center;
		    justify-content: flex-start;
		    
		    margin-top: 4px;
		    margin-left: 68px;
        }

     	.verification-container input {
     		width: 300px;
     	}

        .btn-resend {
            margin-left: 10px;
            background-color: #FFFFFF;
            color: #808080;
            border: 1px solid #ccc;
            border-radius: 8.34px;
            padding: 5px 10px;
            cursor: pointer;
            font-family: 'NanumTobak';
            font-size: 16px;
            
        }


    </style>
</head>
<body>

<div class="container">
    <div class="header-logo">
        <img src="./img/mainlogo.jpg" alt="CloverStory 로고" style="width:340px; height:120px;       ">
    </div>

    <div class="box">
        <h2>아이디 찾기</h2>
        <form action="processFindID.jsp" method="post">
            <input type="text" name="name" placeholder=" 이름을 입력하세요" required>

            <input type="text" name="phone" placeholder=" 전화번호를 입력하세요" style="margin-left: -5px; " required>
            <button type="button" class="btn-resend" id="resendBtn" >전송</button>
            <div class="verification-container">
                <input style =" "type="text" name="verificationCode" placeholder=" 인증번호를 입력하세요" required>
                
            </div>
            <br>
            <button type="submit"  class="btn">아이디 찾기</button>
        </form>
    </div>

    <div class="footer-links">
        <a href="login.jsp">로그인</a> |
        <a href="member.jsp">회원가입</a> |
        <a href="pfind.jsp">비밀번호 찾기</a>
    </div>
</div>

<script>
var authCode = ""; // 서버로부터 받은 인증번호를 저장할 변수

// 인증번호 요청
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
