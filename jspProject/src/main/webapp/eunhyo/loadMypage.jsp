<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="mypage.MypageMgr, mypage.MypageBean" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<style>
	#mypage-form{
		width:100%;
	}
    .form-group {
        display: flex;
        align-items: center;
        margin-bottom: 10px;
        text-align: left;
    }
    .form-group label {
        width: 100px;
        margin-left:230px;
        margin-right:-10px;
        font-size: 24px;
        text-align: left;
    }
    #mypage-form input {
        margin-bottom: 10px;
        margin-left:-10px;
        padding: 8px;
        border-radius: 20px;
        border: 1px solid #ccc;
        width: 350px;
        height: 30px;
        font-size: 22px;
        text-align: left;
    }
    .edit-save-btn-container {
        text-align: center;
        margin-top: 20px;
    }
    #edit-btn, #save-btn {
    	margin-bottom:20px;
        font-size: 20px;
        background-color: #e8e8e8;
        color: black;
        border: none;
        border-radius: 10px;
        cursor: pointer;
        outline: none;
        width: 80px;
        height: 30px;
    }
    #save-btn {
        background-color: #dddddd;
        display: none;
    }
    .form-title {
        font-size: 30px;
        font-weight: bold;
        margin-bottom: 20px;
        text-align: center;
        color: #595959;
    }
</style>
</head>
<body>
<%
    // 세션에서 userId 가져오기
    String userId = (String) session.getAttribute("userId");
    MypageBean bean = null;

    if (userId != null && !userId.isEmpty()) {
        // MypageMgr를 통해 user 정보 가져오기
        MypageMgr mgr = new MypageMgr();
        bean = mgr.getUserInfo(userId);
    }
%>
<form id="mypage-form" method="post" enctype="application/x-www-form-urlencoded">
    <% if (bean != null) { %>
        <h2 class="form-title">내 정보</h2>
        <div class="form-group">
            <label for="userIdDisplay">아이디 :</label>
            <input type="text" id="userIdDisplay" name="userIdDisplay" value="<%= bean.getUserId() %>" readonly>
        </div>
        <div class="form-group">
            <label for="userName">이름 :</label>
            <input type="text" id="userName" name="userName" value="<%= bean.getUserName() %>" readonly>
        </div>
        <div class="form-group">
            <label for="userEmail">이메일 :</label>
            <input type="email" id="userEmail" name="userEmail" value="<%= bean.getUserEmail() %>" readonly>
        </div>
        <div class="form-group">
            <label for="userBirth">생일 :</label>
            <input type="date" id="userBirth" name="userBirth" value="<%= bean.getUserBirth() %>" readonly>
        </div>
        <div class="form-group">
            <label for="userPhone">전화번호 :</label>
            <input type="text" id="userPhone" name="userPhone" value="<%= bean.getUserPhone() %>" readonly>
        </div>
        <!-- hidden 필드로 userId를 수정 불가능하게 전송 -->
        <input type="hidden" name="userId" value="<%= bean.getUserId() %>">
        
        <div class="edit-save-btn-container">
            <button type="button" id="edit-btn" onclick="enableEditing()">수정</button>
            <button type="button" id="save-btn" onclick="updateMypage(event)">저장</button>
        </div>
    <% } else { %>
        <p>사용자 정보를 찾을 수 없습니다.</p>
    <% } %>
</form>
</body>
</html>
 