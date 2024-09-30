<%@ page import="java.util.Vector"%>
<%@ page import="pjh.ItemBean, pjh.AItemMgr" %>
<%@ page import="java.util.List" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"%>

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
        .sidebar {
            background-color: #C0E5AF;
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
        .product-list {
            margin-top: 30px;
            max-width: 1200px;
            margin-left: auto;
            margin-right: auto;
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
            background-color: #C0E5AF;
            color: #333;
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
        .add-product-btn {
            margin-top: 20px;
            padding: 15px 20px;
            background-color: #C0E5AF;
            color: #333;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-size: 16px;
            display: block;
            text-align: center;
            margin-left: auto;
            margin-right: auto;
            width: 150px;
        }
        .add-product-btn:hover {
            background-color: #8DB369;
        }
        .pagination {
            margin-top: 20px;
            text-align: center;
        }
        .pagination a {
            margin: 0 5px;
            padding: 8px 16px;
            text-decoration: none;
            color: #333;
            background-color: #eee;
            border-radius: 5px;
        }
        .pagination a.current-page {
            background-color: #C0E5AF;
            color: white;
        }
        .pagination a:hover {
            background-color: #8DB369;
            color: white;
        }
    </style>
</head>
<body>

    <!-- 사이드바 -->
    <div class="sidebar">
        <h2>관리자 패널</h2>
        <ul>
            <li onclick="showDashboard()" id="dashboardTab" class="active"><i class="fa fa-home"></i> 대시보드</li>
            <li onclick="showStore()" id="storeTab"><i class="fa fa-store"></i> 상점 관리</li>
            <li onclick="logout()"><i class="fa fa-sign-out-alt"></i> 로그아웃</li>
        </ul>
    </div>

    <!-- 대시보드 섹션 -->
    <div id="dashboard" class="main-content">
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

    <!-- 상점 관리 섹션 -->
    <div id="store" class="main-content" style="display: none;">
        <h1>상점 관리</h1>

        <!-- 검색 폼 -->
        <form method="get" action="adminMain.jsp">
            <select name="keyField">
                <option value="item_name">상품 이름</option>
                <option value="item_type">상품 타입</option>
            </select>
            <input type="text" name="keyWord" placeholder="검색어 입력" />
            <input type="submit" value="검색" />
        </form>

        <!-- 상품 목록 출력 및 페이징 -->
        <div class="product-list">
            <h2>상품 목록</h2>
            <table>
                <thead>
                    <tr>
                        <th>상품 번호</th>
                        <th>상품 이름</th>
                        <th>상품 이미지</th>
                        <th>상품 가격</th>
                        <th>상품 타입</th>
                        <th>상품 파일</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        // 현재 페이지와 검색 조건을 받아옴
                        String pageStr = request.getParameter("page");
                        int currentPage = (pageStr != null) ? Integer.parseInt(pageStr) : 1;
                        int itemsPerPage = 10;
                        int start = (currentPage - 1) * itemsPerPage;

                        // 검색어와 검색 필드를 받아옴
                        String keyField = request.getParameter("keyField");
                        String keyWord = request.getParameter("keyWord");

                        // 총 상품 수 계산
                        AItemMgr itemMgr = new AItemMgr();
                        int totalItems = itemMgr.getTotalItemCount(keyField, keyWord);

                        // 상품 목록 가져오기 (start와 itemsPerPage 적용)
                        Vector<ItemBean> items = itemMgr.getItemList(keyField, keyWord, start, itemsPerPage);

                        // 총 페이지 수 계산
                        int totalPages = (int) Math.ceil(totalItems / (double) itemsPerPage);

                        if (items.size() > 0) {
                            for (ItemBean item : items) {
                    %>
                    <tr>
                        <td><%= item.getItem_num() %></td>
                        <td><%= item.getItem_name() %></td>
                        <td><%= item.getItem_image() %></td>
                        <td><%= item.getItem_price() %>원</td>
                        <td><%= item.getItem_type() %></td>
                        <td><%= item.getItem_path() %></td>
                    </tr>
                    <%
                            }
                        } else {
                    %>
                    <tr>
                        <td colspan="6">표시할 항목이 없습니다.</td>
                    </tr>
                    <%
                        }
                    %>
                </tbody>
            </table>

            <!-- 상품 추가 버튼 -->
            <button class="add-product-btn" onclick="openStoreManage()">상품 추가</button>

            <!-- 페이징 처리 -->
            <div class="pagination">
                <%
                    for (int i = 1; i <= totalPages; i++) {
                %>
                <a href="adminMain.jsp?page=<%= i %>&keyField=<%= keyField != null ? keyField : "" %>&keyWord=<%= keyWord != null ? keyWord : "" %>"
                   class="<%= (i == currentPage) ? "current-page" : "" %>">
                    <%= i %>
                </a>
                <%
                    }
                %>
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

        // 페이지 로드 시 대시보드 표시
        window.onload = function () {
            var urlParams = new URLSearchParams(window.location.search);
            if (urlParams.has('keyWord') || urlParams.has('page')) {
                showStore();
            } else {
                showDashboard();
            }
        };
    </script>
</body>
</html>
