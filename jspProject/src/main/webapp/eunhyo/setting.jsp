<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>MyPage Settings</title>
<style>
    .custom-box {
        position: relative;
        margin: 100px auto;
        width: 80%; 
        height: 450px; 
        background-color: #F7F7F7; 
        border: 1px solid #9F9F9F; 
        padding: 20px;
        font-size: 24px;
        
        /* 중앙 정렬을 위한 추가 스타일 */
        display: flex;
        flex-direction: column;
        align-items: center; /* 수평 중앙 정렬 */
        justify-content: center; /* 수직 중앙 정렬 */
    }
    .form-group {
        display: flex; /* 레이블과 입력 필드를 같은 줄에 배치 */
        align-items: center;
        justify-content: center; /* 레이블과 입력 필드 그룹 자체를 가운데 정렬 */
        margin-bottom: 10px;
    }

    .form-group label {
        width: 100px;
        margin-right: 10px;
        text-align: left; /* 레이블의 텍스트를 왼쪽 정렬 */
        font-size: 24px;
        /* 레이블을 왼쪽으로 고정 */
        margin-right: auto;
        padding-left: 50px;
    }

    .custom-box input {
        margin-bottom: 30px; /* 입력 필드의 상하 여백 제거 */
        padding: 8px;
        border-radius: 20px; /* 입력 필드의 모서리를 둥글게 */
        border: 1px solid #ccc; /* 입력 필드의 테두리 색 */
        width: 350px;
        height: 30px;
        font-size: 22px;
        text-align: left;
        /* 입력 필드 가운데 정렬 */
        margin-left: auto;
    }
    .s-button-container {
        position: relative;
        top: 105px;
        left: 101px;
        text-align: left; /* 마이페이지 버튼은 왼쪽 정렬 */
    }
    .mypage-btn {
        margin-right: 10px;
        padding: 10px 20px;
        font-size: 22px;
        background-color: #F7F7F7;
        border: 1px solid #9F9F9F;
    }
    .edit-save-btn-container {
        text-align: center; /* 수정/저장 버튼을 가운데 정렬 */
    }
    #edit-btn, #save-btn {
        margin-top: 10px;
        font-size: 20px;
        background-color: #e4e4e4;
        color: black;
        border: none;
        border-radius: 10px;
        cursor: pointer;
        outline: none;
        width: 80px;
        height:30px;
   
    }
    #save-btn {
        background-color: #ffffff;
        display: none;
    }
</style>
<script>
document.addEventListener("DOMContentLoaded", function() {
    loadMypage();
});

function loadMypage() {
    var xhr = new XMLHttpRequest();
    xhr.onreadystatechange = function() {
        if (xhr.readyState == 4 && xhr.status == 200) {
            document.getElementById("mypage-form-container").innerHTML = xhr.responseText;
            disableEditing();
        }
    };
    xhr.open("GET", "../eunhyo/loadMypage.jsp", true);
    xhr.send();
}

function enableEditing() {
    var inputs = document.querySelectorAll("#mypage-form input");
    inputs.forEach(function(input) {
        if (input.name !== "userIdDisplay") {
            input.removeAttribute("readonly");
        }
    });
    
    document.getElementById("save-btn").style.display = "inline-block";
    document.getElementById("edit-btn").style.display = "none";
}

function updateMypage(event) {
    event.preventDefault();

    var form = document.getElementById("mypage-form");
    var formData = new FormData(form);

    var xhr = new XMLHttpRequest();
    xhr.onreadystatechange = function() {
        if (xhr.readyState == 4 && xhr.status == 200) {
            console.log('Response Text:', xhr.responseText);

            if (xhr.responseText.trim() === "success") {
                alert("정보가 성공적으로 업데이트되었습니다.");
                disableEditing();
            } else {
                alert("업데이트에 실패했습니다.");
            }
        }
    };
    xhr.open("POST", "../eunhyo/updateMypage.jsp", true);
    xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
    xhr.send(new URLSearchParams(formData).toString());
}

function disableEditing() {
    var inputs = document.querySelectorAll("#mypage-form input");
    inputs.forEach(function(input) {
        input.setAttribute("readonly", "readonly");
    });
    
    document.getElementById("edit-btn").style.display = "inline-block";
    document.getElementById("save-btn").style.display = "none";
}

</script>
</head>
<body>
<div class="s-button-container">
    <!-- 마이페이지 버튼은 왼쪽에 고정 -->
    <button class="mypage-btn" onclick="loadMypage()">마이페이지</button>
</div>

<div id="custom-box" class="custom-box">
    <form id="mypage-form" method="post" enctype="application/x-www-form-urlencoded">
        <div id="mypage-form-container">
            <!-- 레이블과 입력 필드의 그룹화 -->
            <div class="form-group">
                <label for="userId">아이디:</label>
                <input type="text" id="userId" name="userIdDisplay" readonly>
            </div>
            <div class="form-group">
                <label for="userName">이름:</label>
                <input type="text" id="userName" name="userName" readonly>
            </div>
            <div class="form-group">
                <label for="userEmail">이메일:</label>
                <input type="email" id="userEmail" name="userEmail" readonly>
            </div>
            <div class="form-group">
                <label for="userBirth">생일:</label>
                <input type="date" id="userBirth" name="userBirth" readonly>
            </div>
            <div class="form-group">
                <label for="userPhone">전화번호:</label>
                <input type="text" id="userPhone" name="userPhone" readonly>
            </div>
        </div>
        <div class="edit-save-btn-container">
            <button type="button" id="edit-btn" onclick="enableEditing()">수정</button>
            <button type="button" id="save-btn" onclick="updateMypage(event)">저장</button>
        </div>
    </form>
</div>
</body>
</html>
