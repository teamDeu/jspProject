<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>프로필</title>
    <style>
    @font-face {
        font-family: 'NanumTobak';
        src: url('나눔손글씨 또박또박.TTF') format('truetype');
    }

    .profile-container-custom {
        background-color: white;
        padding: 20px;
        border-radius: 20px;
        width: 850px;
        height: 95%;
    }

    .profile-header-custom {
        font-size: 36px;
        font-weight: 600;
        color: #80A46F;
        margin-bottom: 20px;
        text-align: left;
        font-family: 'NanumTobak';
    }

    .profile-details-custom {
        display: flex;
        align-items: center;
        margin-bottom: 20px;
    }

    .profile-image-custom {
        width: 40%; 
        height: 40%; 
        border: 2px solid #BAB9AA; /* 변경된 선 색상 */
        overflow: hidden;
        margin-right: 20px;
        text-align: center;
        position: relative;
    }

    .profile-image-custom img {
        width: 100%;
        height: 100%;
        object-fit: cover;
        
    }

    .profile-image-custom input {
        display: none; /* 파일 선택 필드는 숨김 */
    }

    .profile-image-custom label {
        position: absolute;
        right: 10px;
        bottom: 10px;
        background-color: #DCDCDC;
        color: white;
        padding: 5px 10px;
        border-radius: 20px;
        font-family: 'NanumTobak';
        cursor: pointer;
        font-size: 24px;
    }

    .profile-info-custom {
        border: 2px dashed #BAB9AA; /* 변경된 선 색상 */
        padding: 10px;
        border-radius: 20px;
        position: relative;
        font-family: 'NanumTobak';
        width: 451px;
        height: 320px;	
        font-size: 36px;
    }

    .profile-info-custom div {
        margin-bottom: 25px;
    }

    .profile-info-custom div span {
        font-weight: bold;
    }

    .profile-btn-custom {
        display: inline-block;
        padding: 2px 10px;
        background-color: #DCDCDC;
        color: white;
        text-align: center;
        border-radius: 20px;
        text-decoration: none;
        margin-top: 10px;
        font-family: 'NanumTobak';
        font-size : 24px;
    }

    .profile-btn-custom:hover {
        background-color: #45a049;
    }

    .profile-status-message-custom {
        margin-top: 20px;
        text-align: left;
        font-family: 'NanumTobak';
    }

    .profile-status-message-custom textarea {
        width: 95%;
        height: 150px;
        border: 2px solid #BAB9AA; /* 변경된 선 색상 */
        padding: 10px;
        border-radius: 20px;
        resize: none;
        font-family: 'NanumTobak';
        font-size: 34px;
    }

    .profile-edit-btn-custom {
        position: absolute;
        right: 10px;
        bottom: 10px;
    }
    /* 실선 스타일 */
	.profile-line {
    border-bottom: 2px solid #BAB9AA; /* 실선 색상 및 두께 */
    width: 95%; /* 실선의 너비 */
    position: absolute;
    top: 70px;
    left: 15px;
}
    </style>
</head>
<body>
    <div class="profile-container-custom">
        <div class="profile-header-custom">프로필</div>
        <div class="profile-line"></div>
        <div class="profile-details-custom">
            <div class="profile-image-custom">
                <img id="profileImg" src="img/clover1.png" alt="Profile Image">
                <label for="imageUpload">사진 변경</label>
                <input type="file" id="imageUpload" name="imageUpload" accept="image/*" onchange="loadFile(event)">
            </div>
            <div class="profile-info-custom">
                <div><span>닉네임:</span> 흥길동동구리</div>
                <div><span>이메일:</span> aaa@naver.com</div>
                <div><span>생일:</span> 1980.10.02</div>
                <div><span>취미:</span> 코파기</div>
                <div><span>mbti:</span> ENFJ</div>
                <a href="#" class="profile-btn-custom profile-edit-btn-custom">수정</a>
            </div>
        </div>
        <div class="profile-status-message-custom">
            <label for="statusMessage">상태메시지</label>
            <textarea id="statusMessage" placeholder="상태메시지를 입력하세요">후배적 후배적</textarea>
            <a href="#" class="profile-btn-custom">수정</a>
        </div>
    </div>

    <script>
        // 사용자가 이미지를 선택할 때 해당 이미지를 미리보기로 보여주는 함수
        function loadFile(event) {
            var output = document.getElementById('profileImg');
            output.src = URL.createObjectURL(event.target.files[0]);
            output.onload = function() {
                URL.revokeObjectURL(output.src); // 메모리 해제
            }
        }

        document.querySelector('.profile-image-custom label').addEventListener('click', function() {
            document.querySelector('#imageUpload').click();
        });
    </script>
</body>
</html>
