<%@ page contentType="text/html; charset=UTF-8" %>
<%
    String id = (String)session.getAttribute("idKey");
%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>Clover Story Login</title>
    <link href="style.css" rel="stylesheet" type="text/css">
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
        .logo {

            margin-bottom: 30px;
            margin-left: 40px;
        }
        .login-box {
            background-color: #F8F6E3;
            border-radius: 30px;
            padding: 30px;
            width: 360px;
            margin-top: 15px; 
            border: 1px solid #ccc; /* 회색 테두리 추가 */
            margin-left: 535px;
            
        }
        
        
        input[type="text"], input[type="password"] {
            width: 90%;
            padding: 10px;
            margin: 10px 0;
            border: 1px solid #ccc;
            border-radius: 37.75px;
            background-color: #F7FFF4;
            font-size: 24px;
            font-family: 'NanumTobak';
        }
        input[type="button"] {
            background-color: #C0E5AF;
            border: none;
            color: black;
            padding: 12px 130px;
            text-align: center;
            display: inline-block;
            font-size: 24px;
            margin: 0px 0px;
            cursor: pointer;
            border-radius: 37.75px;
            font-family: 'NanumTobak';
        }
        .links {
            margin-top: 10px;
            font-size: 25px;
            font-family: 'NanumTobak';
            margin-left: 70px;
        }
        .links a {
            text-decoration: none;
            color: black;
            margin: 0 10px;
        }
        /* 관리자 로그인 체크박스 왼쪽 배치 */
        .admin-checkbox {
            text-align: left;
            padding-left: 2%;
            
        }
    </style>
    <script type="text/javascript">
        function loginCheck() {
            if (document.loginFrm.user_id.value == "") {
                alert("아이디를 입력해 주세요.");
                document.loginFrm.user_id.focus();
                return;
            }
            if (document.loginFrm.user_pwd.value == "") {
                alert("비밀번호를 입력해 주세요.");
                document.loginFrm.user_pwd.focus();
                return;
            }
            
            // 관리자 체크박스 체크 여부 확인
            if (document.loginFrm.isAdmin.checked) {
                // 관리자인 경우 adminProc.jsp로 전송
                document.loginFrm.action = "adminProc.jsp";
            } else {
                // 일반 사용자인 경우 loginProc.jsp로 전송
                document.loginFrm.action = "../miniroom/main.jsp?url="+document.loginFrm.user_id.value;
            }
            
            document.loginFrm.submit();
        }
    </script>
</head>
<body>
<div class="container">
    <div class="logo">
        <img src="./img/mainlogo.jpg" style="width:340px; height:120px;">
    </div>
    <br/><br/>
    <div class="login-box">
        <form name="loginFrm" method="post">
            <input type="text" name="user_id" placeholder=" 아이디를 입력하세요">
            <input type="password" name="user_pwd" placeholder=" 비밀번호를 입력하세요">
            <br/>
            <div class="admin-checkbox">
                <label>
                    <input type="checkbox" name="isAdmin" value="yes"> 관리자 로그인
                </label>
            </div>
            <br/><br/>
            <input type="button" value="로그인" onclick="loginCheck()" style="margin-top: -20px; width: 340px;">
        </form>
    </div>
    <div class="links">
        <a href="ifind.jsp">아이디 찾기</a> |
        <a href="pfind.jsp">비밀번호 찾기</a> |
        <a href="member.jsp">회원가입</a>
    </div>
</div>
</body>
</html>
