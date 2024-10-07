<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="pjh.MemberMgr, pjh.ProfileBean" %>
<%
    // 세션에서 로그인된 유저 ID 가져오기
    String userId = (String) session.getAttribute("idKey");
    // URL에서 조회하려는 사용자 ID 가져오기
    String pageOwnerId = request.getParameter("url");

    // url 파라미터가 없으면 자기 자신의 프로필로 설정
    if (pageOwnerId == null || pageOwnerId.trim().isEmpty()) {
        pageOwnerId = userId;
    }

    // 유저 ID로 DB에서 프로필 정보 가져오기
    MemberMgr mgr = new MemberMgr();
    ProfileBean profileBean = mgr.getProfileByUserId(pageOwnerId);

    // 자신의 프로필인지 확인
    boolean isOwnProfile = userId.equals(pageOwnerId);
%>
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
            background-color: #F7F7F7;
            padding: 20px;
            border-radius: 20px;
            width: 850px;
            height: 75%;
            border-radius: 30px;
        }

        .profile-header-custom {
           color: #80A46F;
		   text-align: center;
		   font-size: 36px;
		   font-weight: 600;
		   position: absolute;
		   top: 20px;
		   left: 30px;
		}

        .profile-details-custom {
            display: flex;
            align-items: center;
            margin-bottom: 20px;
        }

        .profile-image-custom {
            width: 400px;
            height: 340px;
            border: 2px solid #BAB9AA;
            overflow: hidden;
            margin-right: 20px;
            text-align: center;
            position: relative;
        }

        .profile-image-custom img {
            width: 100%;
            height: 100%;
            object-fit: contain;
            display: block;
        }

        .profile-image-custom input {
            display: none;
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
            border: 2px dashed #BAB9AA;
            padding: 10px;
            border-radius: 20px;
            position: relative;
            font-family: 'NanumTobak';
            width: 451px;
            height: 320px;    
            font-size: 36px;
        }

        .profile-info-custom .info-row {
            display: flex;
            align-items: center;
            margin-bottom: 25px;
        }

        .profile-info-custom .info-row span {
            font-weight: bold;
            width: 120px;
            display: inline-block;
            margin-right: 10px;
        }

        .profile-info-custom input {
            border: none;
            outline: none;
            background-color: transparent;
            font-family: 'NanumTobak';
            font-size: 36px;
            width: 100%;
        }

        .profile-info-custom input::placeholder {
            color: #BAB9AA;
        }

        .profile-status-message-custom {
            margin-top: 20px;
            text-align: left;
            font-family: 'NanumTobak';
        }

        .profile-status-message-custom textarea {
            width: 95%;
            height: 150px;
            border: 2px solid #BAB9AA;
            padding: 10px;
            border-radius: 20px;
            resize: none;
            font-family: 'NanumTobak';
            font-size: 34px;
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
            font-size: 24px;
            position: relative;
            right: -91%;
        }

        .profile-btn-custom:hover {
            background-color: #45a049;
        }
        .profile-line {
		   border-bottom: 2px solid #BAB9AA; /* 실선 색상 및 두께 */
		   width: 96%; /* 실선의 너비 */
		   position: absolute;
		   top: 70px;
		   left: 18px;
		}
    </style>
</head>
<body>
    <div class="profile-container-custom">
        <form id="profileForm" enctype="multipart/form-data">
            <div class="profile-header-custom">프로필</div>
            <div class="profile-line"></div>
            <div class="profile-details-custom">
                <div class="profile-image-custom">
                    <img id="profileImg" src="../miniroom/<%= profileBean.getProfile_picture() %>" alt="Profile Image">
                    <% if (isOwnProfile) { %>
                    <label for="imageUpload">사진 변경</label>
                    <input type="file" id="imageUpload" name="profile_picture" accept="image/*" onchange="loadFile(event)">
                    <% } %>
                </div>
                <div class="profile-info-custom">
                    <div class="info-row"><span>닉네임:</span> <input type="text" name="profile_name" id="profile_name" value="<%= profileBean.getProfile_name() %>" <% if (!isOwnProfile) { %> readonly <% } %>></div>
                    <div class="info-row"><span>이메일:</span> <input type="email" name="profile_email" id="profile_email" value="<%= profileBean.getProfile_email() %>" <% if (!isOwnProfile) { %> readonly <% } %>></div>
                    <div class="info-row"><span>생일:</span> <input type="date" name="profile_birth" id="profile_birth" value="<%= profileBean.getProfile_birth() %>" <% if (!isOwnProfile) { %> readonly <% } %>></div>
                    <div class="info-row"><span>취미:</span> <input type="text" name="profile_hobby" id="profile_hobby" value="<%= profileBean.getProfile_hobby() %>" <% if (!isOwnProfile) { %> readonly <% } %>></div>
                    <div class="info-row"><span>MBTI:</span> <input type="text" name="profile_mbti" id="profile_mbti" value="<%= profileBean.getProfile_mbti() %>" <% if (!isOwnProfile) { %> readonly <% } %>></div>
                </div>
            </div>
            <div class="profile-status-message-custom">
                <label for="statusMessage">상태 메시지</label>
                <textarea id="statusMessage" name="profile_content" placeholder="상태 메시지를 입력하세요" <% if (!isOwnProfile) { %> readonly <% } %>><%= profileBean.getProfile_content() %></textarea>
                <% if (isOwnProfile) { %>
                <button type="button" class="profile-btn-custom" onclick="submitProfile()">수정</button>
                <% } %>
            </div>
        </form>
    </div>

    <script>
        // 이미지 미리보기 함수
        function loadFile(event) {
            var output = document.getElementById('profileImg');
            output.src = URL.createObjectURL(event.target.files[0]);
            output.onload = function() {
                URL.revokeObjectURL(output.src); // 메모리 해제
            }
        }

        // 프로필 수정 제출 함수
        function submitProfile() {
            var formData = new FormData(document.getElementById("profileForm"));

            // AJAX 요청을 사용하여 데이터 전송
            var xhr = new XMLHttpRequest();
            xhr.open("POST", "../pjh/updateProfile.jsp", true);

            xhr.onreadystatechange = function () {
                if (xhr.readyState == 4 && xhr.status == 200) {
                    // 응답이 성공적으로 왔을 때
                    var response = JSON.parse(xhr.responseText);
                    if (response.success) {
                        alert(response.message);  // 수정 완료 메시지
                        // 이미지 미리보기 업데이트
                        var newImagePath = response.updatedImagePath;
                        if (newImagePath) {
                            document.getElementById('profileImg').src = "../" + newImagePath;
                        }
                    } else {
                        alert(response.message);  // 에러 메시지
                    }
                }
            };

            xhr.send(formData);
        }
    </script>
</body>
</html>
