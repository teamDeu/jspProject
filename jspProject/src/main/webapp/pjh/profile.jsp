<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="pjh.MemberMgr, pjh.ProfileBean" %>
<%
    // 세션에서 유저 ID 가져오기
    String userId = (String) session.getAttribute("idKey");

    if (userId == null) {
        // 로그인이 안 되어 있을 때 처리
        out.println("<script>alert('로그인 후 이용해주세요.'); location.href='login.jsp';</script>");
        return;
    }

    // 유저 ID로 DB에서 프로필 정보 가져오기
    MemberMgr mgr = new MemberMgr();
    ProfileBean profileBean = mgr.getProfileByUserId(userId);
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
            width: 63%;
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

        /* 입력 필드에서 박스만 제거하고 폰트 크기를 36px로 설정 */
        .profile-info-custom input {
            border: none;
            outline: none;
            background-color: transparent;
            font-family: 'NanumTobak';
            font-size: 36px;
            width: 100%;
        }

        .profile-info-custom input::placeholder {
            color: #BAB9AA; /* Placeholder 색상 변경 */
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
    </style>
</head>
<body>
    <div class="profile-container-custom">
        <form id="profileForm" method="POST" enctype="multipart/form-data">
            <div class="profile-header-custom">프로필</div>
            <div class="profile-details-custom">
                <div class="profile-image-custom">
                    <!-- DB에서 가져온 이미지 경로 설정 -->
                    <img id="profileImg" src="<%= profileBean.getProfile_picture() %>" alt="Profile Image">
                    <label for="imageUpload">사진 변경</label>
                    <input type="file" id="imageUpload" name="profile_picture" accept="image/*" onchange="loadFile(event)">
                </div>
                <div class="profile-info-custom">
                    <div class="info-row"><span>닉네임:</span> <input type="text" name="profile_name" id="profile_name" value="<%= profileBean.getProfile_name() %>"></div>
                    <div class="info-row"><span>이메일:</span> <input type="email" name="profile_email" id="profile_email" value="<%= profileBean.getProfile_email() %>"></div>
                    <div class="info-row"><span>생일:</span> <input type="date" name="profile_birth" id="profile_birth" value="<%= profileBean.getProfile_birth() %>"></div>
                    <div class="info-row"><span>취미:</span> <input type="text" name="profile_hobby" id="profile_hobby" value="<%= profileBean.getProfile_hobby() %>"></div>
                    <div class="info-row"><span>MBTI:</span> <input type="text" name="profile_mbti" id="profile_mbti" value="<%= profileBean.getProfile_mbti() %>"></div>
                </div>
            </div>
            <div class="profile-status-message-custom">
                <label for="statusMessage">상태 메시지</label>
                <textarea id="statusMessage" name="profile_content" placeholder="상태 메시지를 입력하세요"><%= profileBean.getProfile_content() %></textarea>
                <button type="button" onclick="updateProfile()" class="profile-btn-custom">저장</button>
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

        // 프로필 업데이트 함수
        async function updateProfile() {
            const formData = new FormData(document.getElementById('profileForm'));

            try {
                const response = await fetch('<%=request.getContextPath()%>/pjh/updateProfile.jsp', {
                    method: 'POST',
                    body: formData
                });

                if (response.ok) {
                    const result = await response.json();
                    if (result.success) {
                        alert('프로필이 성공적으로 업데이트되었습니다.');
                        location.reload();  // 페이지 새로고침
                    } else {
                        alert(result.message || '프로필 업데이트에 실패했습니다.');
                    }
                } else {
                    alert('서버 오류 발생');
                }
            } catch (error) {
                console.error('오류 발생:', error);
                alert('프로필 업데이트 중 오류가 발생했습니다.');
            }
        }
    </script>
</body>
</html>
