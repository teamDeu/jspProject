<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>관리자 페이지</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        body {
            font-family: 'Arial', sans-serif;
            display: flex;
            height: 100vh;
            background-color: #f5f5f5;
        }
        /* 사이드바 스타일 */
        .sidebar {
            background-color: #C0E5AF; /* 녹색 베이스 */
            width: 250px;
            height: 100vh;
            position: fixed;
            top: 0;
            left: 0;
            padding-top: 20px;
            box-shadow: 2px 0 5px rgba(0, 0, 0, 0.1);
        }
        .sidebar h2 {
            text-align: center;
            color: #fff;
            font-weight: bold;
            margin-bottom: 40px;
        }
        .sidebar ul {
            list-style-type: none;
            padding: 0;
        }
        .sidebar ul li {
            padding: 15px 20px;
            color: #fff;
            transition: background-color 0.3s ease;
            cursor: pointer;
        }
        .sidebar ul li:hover {
            background-color: #27ae60;
        }
        .sidebar ul li.active {
            background-color: #1abc9c;
        }
        /* 메인 콘텐츠 스타일 */
        .main-content {
            margin-left: 250px;
            padding: 20px;
            width: calc(100% - 250px);
            background-color: #fff;
            height: 100vh;
            overflow-y: auto;
            position: relative;
        }
        .main-content h1 {
            font-size: 28px;
            color: #333;
            margin-bottom: 20px;
        }
        .main-content .content-cards {
            display: grid;
            grid-template-columns: repeat(3, 1fr);
            gap: 20px;
        }
        .main-content .card {
            background-color: #fff;
            border-radius: 10px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            padding: 20px;
            text-align: center;
            transition: transform 0.3s ease;
        }
        .main-content .card:hover {
            transform: translateY(-10px);
        }
        .main-content .card h3 {
            font-size: 20px;
            color: #2ecc71;
            margin-bottom: 10px;
        }
        .main-content .card p {
            color: #666;
            font-size: 14px;
        }
        .content-container {
            display: none;
        }
        /* 상품 리스트 스타일 */
        .product-list {
            margin-top: 30px;
        }
        .product-list table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }
        .product-list table th, .product-list table td {
            border: 1px solid #ccc;
            padding: 10px;
            text-align: center;
        }
        .product-list table th {
            background-color: #A9D18E; /* 테이블 헤더 배경색 - 사이드바 색상과 조화 */
            color: #333; /* 글자색 */
        }
        .product-list table td button {
            padding: 5px 10px;
            background-color: #FF6B6B;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
        }
        .product-list table td button:hover {
            background-color: #FF4D4D;
        }
        /* 상품 추가 버튼 스타일 */
        .add-product-btn {
            margin-top: 20px;
            padding: 15px 20px;
            background-color: #A9D18E; /* 상품 추가 버튼 배경색 - 사이드바 색상과 조화 */
            color: #333;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-size: 16px;
            display: block;
            width: 150px;
            text-align: center;
        }
        .add-product-btn:hover {
            background-color: #8DB369; /* 버튼 호버 시 더 진한 녹색 */
        }
    </style>
</head>
<body>

    <!-- 사이드바 -->
    <div class="sidebar">
        <h2>관리자 패널</h2>
        <ul>
            <li onclick="showDashboard()"><i class="fa fa-home"></i> 대시보드</li>
            <li><i class="fa fa-users"></i> 사용자 관리</li>
            <li onclick="showStore()"><i class="fa fa-store"></i> 상점 관리</li>
            <li onclick="logout()"><i class="fa fa-sign-out-alt"></i> 로그아웃</li>
        </ul>
    </div>
	
    <!-- 메인 콘텐츠 -->
    <div class="main-content">
        <!-- 기본 대시보드 콘텐츠 -->
        <div id="dashboard" class="content-container" style="display: block;">
            <h1>대시보드</h1>
            <div class="content-cards">
                <div class="card">
                    <h3>사용자 수</h3>
                    <p>총 1,234명</p>
                </div>
                <div class="card">
                    <h3>오늘 접속자</h3>
                    <p>총 567명</p>
                </div>
                <div class="card">
                    <h3>신규 가입자</h3>
                    <p>총 78명</p>
                </div>
            </div>
        </div>

        <!-- 상점 관리 콘텐츠 -->
        <div id="store" class="content-container">
            <h1>상점 관리</h1>

            <!-- 상품 리스트 -->
            <div class="product-list">
                <h2>상품 목록</h2>
                <table>
                    <thead>
                        <tr>
                            <th>상품 이름</th>
                            <th>상품 가격</th>
                            <th>상품 타입</th>
                            <th>상품 파일</th>
                            <th>삭제</th>
                        </tr>
                    </thead>
                    <tbody>
                        <!-- 예시 상품 리스트 -->
                        <tr>
                            <td>Example Product 1</td>
                            <td>1000원</td>
                            <td>음악</td>
                            <td>/music/product1</td>
                            <td><button>삭제</button></td>
                        </tr>
                        <tr>
                            <td>Example Product 2</td>
                            <td>2000원</td>
                            <td>캐릭터</td>
                            <td>/character/product2</td>
                            <td><button>삭제</button></td>
                        </tr>
                    </tbody>
                </table>

                <!-- 상품 추가 버튼 -->
                <button class="add-product-btn" onclick="openStoreManage()">상품 추가</button>
            </div>   
        </div>
    </div>

    <!-- FontAwesome 아이콘 -->
    <script src="https://kit.fontawesome.com/a076d05399.js" crossorigin="anonymous"></script>

    <!-- UI 전환 함수 -->
    <script>
        function logout() {
            if (confirm('정말로 로그아웃 하시겠습니까?')) {
                window.location.href = 'logout.jsp';
            }
        }

        function showDashboard() {
            document.getElementById('dashboard').style.display = 'block';
            document.getElementById('store').style.display = 'none';
        }

        function showStore() {
            document.getElementById('dashboard').style.display = 'none';
            document.getElementById('store').style.display = 'block';
        }

        // 상품 추가 페이지를 새창으로 열기
        function openStoreManage() {
            window.open('storeManage.jsp', '_blank', 'width=600,height=600');
        }
    </script>
</body>
</html>
