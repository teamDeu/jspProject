<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
        background-color: #f7f7f7; 
        border: 1px solid #BAB9AA; 
        padding: 20px;
        font-size: 24px;
        display: flex;
        flex-direction: column;
        align-items: center;
        justify-content: center;
        overflow-y: auto;
    }
    .s-button-container {
        position: relative;
        top: 105px;
        left: 101px;
        text-align: left;
    }
    .mypage-btn, .category-btn {
        margin-right: -10px;
        padding: 10px 20px;
        font-size: 22px;
        background-color: #f7f7f7;
        border: 1px solid #BAB9AA;
        cursor: pointer;
        width: 100px;
    }
    .active-btn {
        background-color: #e3e3e3;
    } 
</style>
<script>
document.addEventListener("DOMContentLoaded", function() {
    // 기본적으로 마이페이지 내용 로드
    loadContent("../eunhyo/loadMypage.jsp");
    
    var mypageBtn = document.querySelector(".mypage-btn");
    var categoryBtn = document.querySelector(".category-btn");

    // 버튼 클릭 이벤트 설정
    mypageBtn.addEventListener("click", function() {
        setActiveButton(mypageBtn, categoryBtn);
        loadContent("../eunhyo/loadMypage.jsp");
    });

    categoryBtn.addEventListener("click", function() {
        setActiveButton(categoryBtn, mypageBtn);
        loadContent("../eunhyo/loadCategory.jsp");
    });
});

// 활성화 버튼 설정 함수
function setActiveButton(activeBtn, inactiveBtn) {
    activeBtn.classList.add("active-btn");
    inactiveBtn.classList.remove("active-btn");
}

// custom-box에 페이지 내용을 로드하는 함수
function loadContent(url) {
    var xhr = new XMLHttpRequest();
    xhr.onreadystatechange = function() {
        if (xhr.readyState == 4 && xhr.status == 200) {
            document.getElementById("custom-box").innerHTML = xhr.responseText;
        }
    };
    xhr.open("GET", url, true);
    xhr.send();
}
function enableEditing() {
    // userIdDisplay를 제외한 모든 input 필드를 활성화
    var inputs = document.querySelectorAll("#mypage-form input:not([name='userIdDisplay'])");
    inputs.forEach(function(input) {
        input.removeAttribute("readonly");
    });

    document.getElementById("edit-btn").style.display = "none";
    document.getElementById("save-btn").style.display = "inline-block";
}


function updateMypage(event) {
    event.preventDefault(); // 폼 제출 기본 동작 중단

    var form = document.getElementById("mypage-form");
    var formData = new FormData(form);

    var xhr = new XMLHttpRequest();
    xhr.onreadystatechange = function() {
        if (xhr.readyState == 4 && xhr.status == 200) {
            if (xhr.responseText.trim() === "success") {
                alert("정보가 성공적으로 업데이트되었습니다.");
                disableEditing(); // 저장 후 필드 비활성화
            } else {
                alert("업데이트에 실패했습니다.");
            }
        }
    };
    xhr.open("POST", "../eunhyo/updateMypage.jsp", true);
    xhr.send(new URLSearchParams(formData));
}

function disableEditing() {
    // 모든 input 필드를 다시 비활성화
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
    <button class="mypage-btn active-btn">마이페이지</button>
    <button class="category-btn">카테고리</button>
</div>
<div id="custom-box" class="custom-box">
    <!-- 로드된 내용이 이곳에 표시됨 -->
</div>
</body>
</html>
