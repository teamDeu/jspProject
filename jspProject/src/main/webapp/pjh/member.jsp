<%@page contentType="text/html; charset=UTF-8" %>

<!doctype html>
<html>
<head>
    <meta charset="UTF-8">
    <title>회원가입</title>
    <link href="style.css" rel="stylesheet" type="text/css">
    <style>
        @font-face {
            font-family: 'NanumTobak';
            src: url('나눔손글씨 또박또박.TTF') format('truetype');
        }
        body {
            background-color: #F8F6E3;
            font-family: 'NanumTobak', sans-serif;
        }
        .container {
            text-align: center;
            margin-top: 50px;
        }
        
        .logo {
        	margin-bottom: 30px;
            margin-left: 40px;
            
        }
        
        .form-box h2 {
        	margin-top: -20px;
        	font-weight: normal;
        	font-size: 25px;
        	margin-left: -10px;
        }
        
        .form-box {
            background-color: #F8F6E3;
            border-radius: 30px;
            padding: 30px;
            width: 440px;
            margin-top: 80px; 
            border: 1px solid #ccc; /* 회색 테두리 추가 */
            margin-left: 510px;
        }
        .form-group {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 5px;
        }
        .form-group input[type="text"], .form-group input[type="password"], .form-group input[type="email"] {
            width: 80%;
            padding: 10px;
            margin-top: 10px;
            margin-left: -5px;
            border: 1px solid #ccc;
            border-radius: 37.75px;
            background-color: #F7FFF4;
            font-size: 24px;
            font-family: 'NanumTobak';
        }
        .form-group .button-small {
            
            border: 1px solid #CCCCCC;
            padding: 5px 10px;
            font-size: 16px;
            cursor: pointer;
            margin-top: 5px;
        }
        input[type="button"], input[type="reset"] {
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
        input[type="submit"], input[type="reset"] {
            background-color: #C0E5AF;
            border: none;
            color: white;
            padding: 10px 20px;
            text-align: center;
            text-decoration: none;
            display: inline-block;
            font-size: 16px;
            margin: 10px 2px;
            cursor: pointer;
            border-radius: 5px;
            font-family: 'NanumTobak', sans-serif;
        }
        
        .form-box button {
            background-color: #C0E5AF;
            border: none;
            color: black;
            padding: 10px 60px;
            text-align: center;
            font-size: 24px;
            margin-top: 10px;
            cursor: pointer;
            border-radius: 37.75px;
            font-family: 'NanumTobak';
        }
    </style>
    <script type="text/javascript" src="script.js"></script>
    <script type="text/javascript">
        var authCode = ""; // 서버로부터 받은 인증번호를 저장할 변수

        // 인증번호 요청
        function requestAuthCode() {
            var phoneNumber = document.regFrm.user_phone.value;

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
                    alert("인증번호가 발송되었습니다.");
                }
            };
            xhr.send("phoneNumber=" + phoneNumber);
        }

        // 인증번호 확인
        function verifyAuthCode() {
            var inputCode = document.regFrm.number.value;

            if (inputCode == authCode) {
                alert("인증이 완료되었습니다.");
            } else {
                alert("인증번호가 일치하지 않습니다.");
            }
        }

        function idCheck(id) {
            if (id == "") {
                alert("아이디를 입력하세요.");
                document.regFrm.id.focus();
                return;
            }
            url = "idCheck.jsp?id=" + id;
            window.open(url, "ID 중복체크", "width=470, height=150, top=100, left=700");
        }

        function inputCheck() {
            // 입력 검증 로직 추가 가능
            alert("회원가입을 완료합니다.");
            document.regFrm.submit();  // 폼 제출
        }
    </script>
</head>
<body onLoad="regFrm.id.focus()">
    <div class="container">
        <div class="logo">
            <img src="./img/mainlogo.jpg"  style="width:340px; height:120px;">
        </div>
        
        <div class="form-box">
        	<h2>회원가입</h2>
            <form name="regFrm" method="post" action="memberProc.jsp">
                <!-- 아이디와 중복확인 버튼 -->
                <div class="form-group">
                    <input type="text" name="user_id" placeholder=" 아이디를 입력하세요">
                    <input type="button" class="button-small" value="중복확인" onClick="idCheck(this.form.user_id.value)">
                </div>

                <!-- 비밀번호 -->
                <div class="form-group">
                    <input type="password" name="user_pwd" placeholder=" 비밀번호를 입력하세요">
                </div>

                <!-- 비밀번호 확인 -->
                <div class="form-group">
                    <input type="password" name="user_repwd" placeholder=" 비밀번호를 다시 한번 입력하세요">
                </div>
                <!-- 이름 -->
                <div class="form-group">
                    <input type="text" name="user_name" placeholder=" 이름을 입력하세요"> 
                </div>

                <!-- 생년월일 -->
                <div class="form-group">
                    <input type="text" name="user_birth" placeholder=" 생년월일을 입력하세요">
                </div>

                <!-- 전화번호와 인증번호 버튼 -->
                <div class="form-group">
                    <input type="text" name="user_phone" placeholder=" 전화번호를 입력하세요"> 
                    <input type="button" class="button-small" value="인증번호" onClick="requestAuthCode()">
                </div>

                <!-- 인증번호 입력과 확인 버튼 -->
                <div class="form-group">
                    <input type="text" name="number" placeholder=" 인증번호를 입력하세요">
                </div>

                <!-- 이메일 -->
                <div class="form-group">
                    <input type="email" name="user_email" placeholder=" 이메일을 입력하세요">
                </div>

                <!-- 회원가입 버튼 -->
                <button type="submit" class="btn"  onClick="inputCheck()">회원가입</button>
            </form>
        </div>
    </div>
</body>
</html>
