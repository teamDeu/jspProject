<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>상품 관리</title>
    <style>
        body {
            font-family: 'Arial', sans-serif;
            background-color: #f5f5f5;
            padding: 20px;
        }
        h1 {
            color: #2ecc71;
            text-align: center;
            margin-bottom: 20px;
        }
        .form-container {
            max-width: 600px;
            margin: 0 auto;
            padding: 20px;
            background-color: #fff;
            border-radius: 10px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }
        .form-group {
            margin-bottom: 15px;
            width: 95%
            text-align: center;
        }
        .form-group label {
            display: block;
            font-weight: bold;
            margin-bottom: 5px;
        }
        .form-group input[type="text"],
        .form-group input[type="number"],
        .form-group input[type="file"],
        .form-group select {
            width: 95%;
            padding: 10px;
            border: 1px solid #ccc;
            border-radius: 5px;
        }
        .form-group button {
            width: 99%;
            padding: 10px;
            background-color: #C0E5AF;
            color: #fff;
            border: none;
            border-radius: 5px;
            cursor: pointer;
        }
        .form-group button:hover {
            background-color: #27ae60;
        }
    </style>
</head>
<script>
    function changeItemType(select) {
        value = select.value;
        itemPathInput = document.getElementById("item_path")
        if (value == "음악") {
            itemPathInput.required = true;
            itemPathInput.disabled = false;
        } else {
            itemPathInput.required = false;
            itemPathInput.disabled = true;
        }
    }
</script>
<body>

<h1>상품 수정</h1>

<div class="form-container">
    <%
        String item_num = request.getParameter("item_num");
        String item_name = request.getParameter("item_name");
        String item_image = request.getParameter("item_image");
        String item_price = request.getParameter("item_price");
        String item_type = request.getParameter("item_type");
        String item_path = request.getParameter("item_path");
    %>

    <form action="storeAction2.jsp" method="post" enctype="multipart/form-data">
        <!-- 상품 번호 (수정 시 필요) -->
        <input type="hidden" name="item_num" value="<%= item_num != null ? item_num : "" %>">

        <!-- 상품 이름 -->
        <div class="form-group">
            <label for="item_name">상품 이름:</label>
            <input type="text" id="item_name" name="item_name" value="<%= item_name != null ? item_name : "" %>" required>
        </div>

        <!-- 파일 업로드 -->
        <div class="form-group">
            <label for="item_image">이미지:</label>
            <input type="file" id="item_image" name="item_image" accept="image/*">
            <% if (item_image != null) { %>
            <p>현재 이미지: <%= item_image %></p>
            <% } %>
        </div>

        <!-- 상품 가격 -->
        <div class="form-group">
            <label for="item_price">상품 가격:</label>
            <input type="number" id="item_price" name="item_price" value="<%= item_price != null ? item_price : "" %>" required> 원
        </div>

        <!-- 상품 타입 선택 -->
        <div class="form-group">
            <label for="item_type">상품 타입:</label>
            <select onchange="changeItemType(this)" id="item_type" name="item_type" required>
                <option value="음악" <%= "음악".equals(item_type) ? "selected" : "" %>>음악</option>
                <option value="캐릭터" <%= "캐릭터".equals(item_type) ? "selected" : "" %>>캐릭터</option>
                <option value="배경화면" <%= "배경화면".equals(item_type) ? "selected" : "" %>>배경</option>
            </select>
        </div>

        <!-- 파일 입력 (음악일 경우) -->
        <div class="form-group">
            <label for="item_path">파일 :</label>
            <input type="file" id="item_path" name="item_path" accept="audio/*" <%= "음악".equals(item_type) ? "" : "disabled" %>>
            <% if (item_path != null && "음악".equals(item_type)) { %>
            <p>현재 파일: <%= item_path %></p>
            <% } %>
        </div>

        <!-- 제출 버튼 -->
        <div class="form-group">
            <button type="submit">상품 수정</button>
        </div>
    </form>
</div>

</body>
</html>
