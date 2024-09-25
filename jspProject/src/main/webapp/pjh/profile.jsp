<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>프로필</title>
    <style>
        @font-face {
            font-family: 'NanumTobak';
            src: url('나눔손글씨 또박또박.TTF') format('truetype');
        }
        body {
            font-family: 'NanumTobak', sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f9f9f9;
        }
        .profile-container {
            width: 500px;
            margin: 50px auto;
            padding: 20px;
            background-color: white;
            border-radius: 10px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            text-align: center;
            border: 1px dashed #ccc;
        }
        .profile-container h2 {
            text-align: left;
            margin-bottom: 20px;
        }
        .profile-img {
            width: 100px;
            height: 100px;
            border-radius: 10px;
            border: 2px solid #ddd;
        }
        .user-info {
            text-align: left;
            display: inline-block;
            margin-left: 20px;
            border: 1px dashed #ccc;
            padding: 10px;
            width: 220px;
            position: relative;
        }
        .user-info p {
            margin: 5px 0;
            font-size: 16px;
        }
        .status-msg {
            margin-top: 20px;
            border: 1px dashed #ccc;
            padding: 10px;
            position: relative;
        }
        .status-msg textarea {
            width: 100%;
            height: 50px;
            border: 1px solid #ddd;
            border-radius: 5px;
            padding: 10px;
            font-family: 'NanumTobak';
            font-size: 14px;
        }
        .edit-btn {
            margin-top: 20px;
            text-align: right;
        }
        button, .edit-btn input[type="submit"] {
            padding: 10px 20px;
            background-color: #90EE90;
            border: none;
            color: white;
            cursor: pointer;
            border-radius: 20px;
            font-size: 14px;
        }
        .edit-btn input[type="submit"] {
            background-color: #ccc;
            color: black;
        }
        .photo-btn {
            margin-top: 10px;
            display: inline-block;
            background-color: #90EE90;
            color: white;
            padding: 10px 20px;
            border-radius: 20px;
            cursor: pointer;
        }
        .user-info .edit-profile {
            position: absolute;
            right: 10px;
            bottom: 10px;
        }
    </style>
</head>
<body>
    <div class="profile-container">
        <h2>프로필</h2>
        <div>
            <img src="img/character5.png" alt="프로필 이미지" class="profile-img">
            <div class="photo-btn">사진 변경</div>
        </div>
        <div class="user-info">
            <p>닉네임 : 홍길똥동구리</p>
            <p>이메일 : aaa@naver.com</p>
            <p>생일 : 1980.10.02</p>
            <p>취미 : 코파기</p>
            <p>MBTI : ENFJ</p>
            <div class="edit-profile">
                <input type="submit" value="수정">
            </div>
        </div>

        <div class="status-msg">
            <label>상태메세지</label><br>
            <textarea name="statusMessage">후비적 후비적</textarea>
            <div class="edit-btn">
                <input type="submit" value="수정">
            </div>
        </div>
    </div>
</body>
</html>
