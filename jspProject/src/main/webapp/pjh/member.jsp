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
            background-color: #FFFAF0;
            font-family: 'NanumTobak', sans-serif;
        }
        .container {
            text-align: center;
            margin-top: 50px;
        }
        .form-box {
            background-color: #FFFAF0;
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
            background-color: #90EE90;
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
    </style>
    <script type="text/javascript" src="script.js"></script>
    <script type="text/javascript">
        function idCheck(id) {
            if(id==""){
                alert("아이디를 입력하세요.");
                document.regFrm.id.focus();
                return;
            }
            url = "idCheck.jsp?id="+id;
            window.open(url, "ID 중복체크", "width=300, height=150, top=100, left=100");
        }
        function inputCheck() {
            alert("회원가입을 완료합니다.");
        }
    </script>
</head>
<body onLoad="regFrm.id.focus()">
    <div class="container">
        <div class="logo">
            <img src="logo2.png" align="center" style="width:200px; height:100px;">
        </div>
        <h1>회원가입</h1>
        <div class="form-box">
            <form name="regFrm" method="post" action="memberProc.jsp">
                <!-- 아이디와 중복확인 버튼 -->
                <div class="form-group">
                    <input type="text" name="id" placeholder="아이디">
                    <input type="button" class="button-small" value="중복확인" onClick="idCheck(this.form.id.value)">
                </div>

                <!-- 비밀번호 -->
                <div class="form-group">
                    <input type="password" name="pwd" placeholder="비밀번호">
                </div>

                <!-- 비밀번호 확인 -->
                <div class="form-group">
                    <input type="password" name="repwd" placeholder="비밀번호 확인">
                </div>

                <!-- 전화번호와 인증번호 버튼 -->
                <div class="form-group">
                    <input type="text" name="phone" placeholder="전화번호">
                    <input type="button" class="button-small" value="인증번호">
                </div>

                <!-- 인증번호 입력과 재전송 버튼 -->
                <div class="form-group">
                    <input type="text" name="number" placeholder="인증번호">
                    <input type="button" class="button-small" value="재전송">
                </div>

                <!-- 이메일 -->
                <div class="form-group">
                    <input type="email" name="email" placeholder="이메일">
                </div>

                <!-- 이름 -->
                <div class="form-group">
                    <input type="text" name="name" placeholder="이름">
                </div>

                <!-- 생년월일 -->
                <div class="form-group">
                    <input type="text" name="birthday" placeholder="생년월일">
                </div>

                <!-- 회원가입 버튼 -->
                <input type="button" value="회원가입" onClick="inputCheck()">
            </form>
        </div>
    </div>
</body>
</html>
