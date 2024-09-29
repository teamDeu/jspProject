<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
            width: 100%;
            padding: 10px;
            border: 1px solid #ccc;
            border-radius: 5px;
        }
        .form-group button {
            width: 100%;
            padding: 10px;
            background-color: #2ecc71;
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
<body>

    <h1>상품 관리</h1>

    <div class="form-container">
        <form action="storeAction.jsp" method="post" enctype="multipart/form-data">
            <!-- 상품 이름 -->
            <div class="form-group">
                <label for="item_name">상품 이름:</label>
                <input type="text" id="item_name" name="item_name" required>
            </div>

            <!-- 상품 가격 -->
            <div class="form-group">
                <label for="item_price">상품 가격:</label>
                <input type="number" id="item_price" name="item_price" required>
            </div>

            <!-- 파일 업로드 -->
            <div class="form-group">
                <label for="item_image">이미지:</label>
                <input type="file" id="item_image" name="item_image" accept="image/*" required>
            </div>

            <!-- 상품 타입 선택 -->
            <div class="form-group">
                <label for="item_type">상품 타입:</label>
                <select id="item_type" name="item_type" required>
                    <option value="music">음악</option>
                    <option value="character">캐릭터</option>
                    <option value="background">배경</option>
                </select>
            </div>

            <!-- 경로 입력 -->
            <div class="form-group">
                <label for="item_image">파일 :</label>
                <input type="file" id="item_image" name="item_image" accept="image/*" required>
            </div>

            <!-- 제출 버튼 -->
            <div class="form-group">
                <button type="submit">상품 추가</button>
            </div>
        </form>
    </div>

</body>
</html>
