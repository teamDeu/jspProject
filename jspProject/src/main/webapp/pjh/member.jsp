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
        .form-box {
            background-color: #F8F6E3;
            border-radius: 10px;
            padding: 30px;
            width: 350px;
            margin: 0 auto;
        }
        .form-group {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 10px;
        }
        .form-group input[type="text"], .form-group input[type="password"], .form-group input[type="email"] {
            width: 70%;
            padding: 10px;
            margin: 10px 0;
            border: 1px solid #ccc;
            border-radius: 5px;
            font-size: 20px;
            font-family: 'NanumTobak', sans-serif; /* 입력칸 안의 텍스트 폰트 적용 */
        }
        .form-group .button-small {
            background-color: #C0E5AF;
            border: 1px solid #CCCCCC;
            padding: 5px 15px;
            font-size: 20px;
            cursor: pointer;
        }
        input[type="button"], input[type="reset"] {
            background-color: #90EE90;
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
            <img src="./img/mainlogo.jpg" align="center" style="width:320px; height:80px;">
        </div>
        <h1>회원가입</h1>
        <div class="form-box">
            <form name="regFrm" method="post" action="memberProc.jsp">
                <!-- 아이디와 중복확인 버튼 -->
                <div class="form-group">
                    <input type="text" name="user_id" placeholder="아이디">
                    <input type="button" class="button-small" value="중복확인" onClick="idCheck(this.form.user_id.value)">
                </div>

                <!-- 비밀번호 -->
                <div class="form-group">
                    <input type="password" name="user_pwd" placeholder="비밀번호">
                </div>

                <!-- 비밀번호 확인 -->
                <div class="form-group">
                    <input type="password" name="user_repwd" placeholder="비밀번호 확인">
                </div>
                <!-- 이름 -->
                <div class="form-group">
                    <input type="text" name="user_name" placeholder="이름">
                </div>

                <!-- 생년월일 -->
                <div class="form-group">
                    <input type="text" name="user_birth" placeholder="생년월일">
                </div>

                <!-- 전화번호와 인증번호 버튼 -->
                <div class="form-group">
                    <input type="text" name="user_phone" placeholder="전화번호">
                    <input type="button" class="button-small" value="인증번호" onClick="requestAuthCode()">
                </div>

                <!-- 인증번호 입력과 확인 버튼 -->
                <div class="form-group">
                    <input type="text" name="number" placeholder="인증번호">
                </div>

                <!-- 이메일 -->
                <div class="form-group">
                    <input type="email" name="user_email" placeholder="이메일">
                </div>

                <!-- 회원가입 버튼 -->
                <input type="submit" value="회원가입" onClick="inputCheck()">
            </form>
        </div>
    </div>
</body>
</html>
