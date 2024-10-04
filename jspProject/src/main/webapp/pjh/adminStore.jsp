<%@ page import="java.util.Vector"%>
<%@ page import="pjh.ItemBean, pjh.AItemMgr" %>
<%@ page import="java.util.List" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<% String type = request.getParameter("type"); %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>관리자 페이지</title>
	 <link rel="stylesheet" href="./css/admin.css" />
	 <style>
	  html, body {
            height: 100%;
            margin: 0;
            display: flex;
            flex-direction: column;
        }

        /* 메인 콘텐츠가 화면 전체 높이를 차지하고 페이징이 하단에 고정되도록 설정 */
        .main-content {
            flex: 1;
            display: flex;
            flex-direction: column;
            justify-content: flex-start; /* 상품 목록을 상단에 고정 */
            min-height: 100vh; /* 전체 화면 높이 */
            padding-bottom: 60px; /* 페이징 영역을 위해 여유 공간 확보 */
        }

        .product-list {
            flex-grow: 1;
            margin-top: 20px;
        }

        .product-list table {
            width: 100%;
            border-collapse: collapse;
        }

        .product-list table th, .product-list table td {
            padding: 10px;
            border: 1px solid #ddd;
            text-align: center;
        }

        /* 페이징 영역을 화면 하단에 고정 */
        .pagination-container {
            position: absolute;
            bottom: 30px;
            width: 100%;
            padding: 10px;
            display: flex;
            justify-content: center;
        }

        .pagination-container a {
            margin: 0 5px;
            text-decoration: none;
            color: #000;
            padding : 10px;
            background-color : #C0E5AF;
            border-radius : 10px;
        }

        .pagination-container a.current-page {
            font-weight: bold;
            color: #007bff;
            background-color : #27ae60;
        }

    .admin_input {
	padding: 6px;
	border-radius: 5px;
	border: 1px solid black;
	box-sizing: border-box;
}

.admin_select {
	padding: 5px;
	border-radius: 5px;
	border: 1px solid black;
	box-sizing: border-box;
}

.admin_submitBtn {
	padding: 4px;
	background: none;
	border-radius: 5px;
	box-sizing: border-box;
	border: 1px solid black;
}
	 </style>
</head>
<body>

    <!-- 사이드바 -->
    <div class="sidebar">
        <h2>관리자 패널</h2>
        <ul>
            <li onclick="showCategory(event)" data = "adminMain.jsp" id="dashboardTab"><i class="fa fa-home"></i> 대시보드</li>
            <li onclick="showCategory(event)" data = "adminUser.jsp" >유저관리</li>
            <li onclick="showCategory(event)" data = "adminStore.jsp" class="active" id="storeTab"><i class="fa fa-store">상점관리</li>
            <li onclick="showCategory(event)" data = "adminReport.jsp">신고관리</li>
            <li onclick="logout()"><i class="fa fa-sign-out-alt"></i> 로그아웃</li>
            
        </ul>
    </div>
    <!-- 상점 관리 섹션 -->
    <div id="store" class="main-content">
        <h1>상점 관리</h1>

        <form method="get" action="adminStore.jsp">
    <select class="admin_select" name="keyField">
        <option value="item_name">상품 이름</option>
        <option value="item_type">상품 타입</option>
    </select> 
    <input class="admin_input" type="text" name="keyWord" placeholder="검색어 입력" /> 
    <input type="submit" class="admin_submitBtn" value="검색" />
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
                        <th>관리</th>
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
                        <td style="width: 150px; text-align: center;">
			    
			    <div style="display: flex; justify-content: center; gap: 5px;">
			        <!-- 수정 버튼 -->
			        <form action="storeManage2.jsp" method="get" style="display:inline;">
			            <input type="hidden" name="item_num" value="<%= item.getItem_num() %>">
			            <input type="hidden" name="item_name" value="<%= item.getItem_name() %>">
			            <input type="hidden" name="item_image" value="<%= item.getItem_image() %>">
			            <input type="hidden" name="item_price" value="<%= item.getItem_price() %>">
			            <input type="hidden" name="item_type" value="<%= item.getItem_type() %>">
			            <input type="hidden" name="item_path" value="<%= item.getItem_path() %>">
			            <button type="submit" style="padding: 5px 10px;">수정</button>
			        </form>
			        
			        <!-- 삭제 버튼 -->
			        <form action="deleteItem.jsp" method="post" onsubmit="return confirm('정말로 이 상품을 삭제하시겠습니까?');" style="display:inline;">
			            <input type="hidden" name="item_num" value="<%= item.getItem_num() %>">
			            <button type="submit" style="padding: 5px 10px;">삭제</button>
			        </form>
			    </div>
			</td>


                    </tr>
                    <%
                            }
                        } else {
                    %>
                    <tr>
                        <td colspan="7">표시할 항목이 없습니다.</td>
                    </tr>
                    <%
                        }
                    %>
                </tbody>
            </table>

            <!-- 상품 추가 버튼 -->
            <button class="add-product-btn" onclick="openStoreManage()">상품 추가</button>

            <!-- 페이징 처리 -->
            <div class="pagination-container">
                <%
                    for (int i = 1; i <= totalPages; i++) {
                %>
                <a href="adminStore.jsp?page=<%= i %>&keyField=<%= keyField != null ? keyField : "" %>&keyWord=<%= keyWord != null ? keyWord : "" %>&type=store"
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
		function showCategory(event){
			console.dir(event.target);
			location.href = event.target.getAttribute("data");
		}
        // 상품 추가 페이지를 새창으로 열기
        function openStoreManage() {
            window.open('storeManage.jsp', '_blank', 'width=600,height=600');
        }
    </script>
</body>
</html>
