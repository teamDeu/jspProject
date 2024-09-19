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
            background-color: #FFFAF0; /* 이미지와 같은 배경색 */
            font-family: 'NanumTobak';
        }
        .container {
            text-align: center;
            margin-top: 140px;
        }
        .logo {
            font-size: 36px;
            font-weight: bold;
        }
        .login-box {
            background-color: #FFFAF0;
            border-radius: 10px;
            padding: 30px;
            width: 300px;
            margin: 0 auto;

        }
        input[type="text"], input[type="password"] {
            width: 90%;
            padding: 10px;
            margin: 10px 0;
            border: 1px solid #ccc;
            border-radius: 5px;
        }
        input[type="button"] {
            background-color: #90EE90;
            border: none;
            color: white;
            padding: 10px 120px;
            text-align: center;
            text-decoration: none;
            display: inline-block;
            font-size: 16px;
            margin: 10px 2px;
            cursor: pointer;
            border-radius: 5px;
        }
        .links {
            margin-top: 10px;
            font-size: 25px;
        }
        .links a {
            text-decoration: none;
            color: #333;
            margin: 0 10px;
        }
    </style>
    <script type="text/javascript">
        function loginCheck() {
            if (document.loginFrm.id.value == "") {
                alert("아이디를 입력해 주세요.");
                document.loginFrm.id.focus();
                return;
            }
            if (document.loginFrm.pwd.value == "") {
                alert("비밀번호를 입력해 주세요.");
                document.loginFrm.pwd.focus();
                return;
            }
            document.loginFrm.submit();
        }
    </script>
</head>
<body>
<div class="container">
    <div class="logo">
        <img src="logo2.png" style="width:200px; height:80px;">
 
    </div>
    <br/><br/>
    <% if(id!=null){ %>
    <b><%=id%></b>님 환영합니다.<br/>
    제한된 기능을 사용 할 수가 있습니다.<br/>
    <a href="logout.jsp">로그아웃</a>&nbsp;
    <a href="memberUpdate.jsp">회원수정</a>
    <% } else {
        id = request.getParameter("id");
    %>
    <div class="login-box">
        <form name="loginFrm" method="post" action="loginProc.jsp">
            <input type="text" name="id" placeholder="아이디" value="<%=(id!=null)?id:""%>">
            <input type="password" name="pwd" placeholder="비밀번호" value="">
            <input type="button" value="로그인" onclick="loginCheck()" >
           
        </form>
    </div>
    <div class="links">
        <a href="#">아이디 찾기</a> |
        <a href="#">비밀번호 찾기</a> |
        <a href="member.jsp">회원가입</a>
    </div>
    <% } %>
</div>
</body>
</html>
