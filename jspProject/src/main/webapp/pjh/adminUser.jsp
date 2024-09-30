<%@page import="miniroom.UtilMgr"%>
<%@page import="miniroom.ItemMgr"%>
<%@page import="pjh.MemberBean"%>
<%@page import="java.util.Vector"%>
<%@page import="pjh.MemberMgr"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
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
        .admin_userList_user_img{
        	width : 120px;
        }
    </style>
</head>
<body>
	<div>
		<h1>유저 관리</h1>
		<!-- 검색 폼 -->
		<form method="get" action="adminUser.jsp">
			<select name="user_keyField">
				<option value="user_id">유저 ID</option>
				<option value="user_name">유저 이름</option>
				<option value="user_phone">유저 번호</option>
			</select> <input type="text" name="user_keyWord" placeholder="검색어 입력" /> <input
				type="submit" value="검색" />
		</form>

		<!-- 상품 목록 출력 및 페이징 -->
		<div class="product-list">
			<h2>유저 목록</h2>
			<table>
				<thead>
					<tr>
						<th>ID</th>
						<th>비밀번호</th>
						<th>닉네임</th>
						<th>생년월일</th>
						<th>전화번호</th>
						<th>이메일</th>
						<th>클로버</th>
						<th>캐릭터</th>
						<th>관리</th>
					</tr>
				</thead>
				<tbody>
					<%
					// 현재 페이지와 검색 조건을 받아옴
					String pageStr = request.getParameter("page");
					int currentPage = (pageStr != null) ? Integer.parseInt(pageStr) : 1;
					int itemsPerPage = 4;
					int start = (currentPage - 1) * itemsPerPage;

					// 검색어와 검색 필드를 받아옴
					String keyField = request.getParameter("user_keyField");
					String keyWord = request.getParameter("user_keyWord");

					// 총 상품 수 계산
					MemberMgr userMgr = new MemberMgr();
					ItemMgr itemMgr = new ItemMgr();
					int totalUsers = userMgr.getTotalUserCount(keyField, keyWord);

					// 상품 목록 가져오기 (start와 itemsPerPage 적용)
					Vector<MemberBean> users = userMgr.getUserList(keyField, keyWord, start, itemsPerPage);

					// 총 페이지 수 계산
					int totalPages = (int) Math.ceil(totalUsers / (double) itemsPerPage);

					if (users.size() > 0) {
						for (MemberBean user : users) {
							String userId = user.getUser_id();
							String userPwd = user.getUser_pwd();
							String userName = user.getUser_name();
							String userBirth = user.getUser_birth();
							String userPhone = UtilMgr.phoneFormat(user.getUser_phone());
							String userEmail = user.getUser_email();
							int userClover = user.getUser_clover();
							String userChracter = itemMgr.getItemPath(user.getUser_character());
					%>
					<tr>
						<td><%=userId%></td>
						<td>*****</td>
						<td><%=userName%></td>
						<td><%=userBirth%></td>
						<td><%=userPhone%></td>
						<td><%=userEmail%></td>
						<td><%=userClover%></td>
						<td><img class ="admin_userList_user_img"src='<%=userChracter%>'></td>
						<td>
							<!-- 삭제 버튼 -->
							<form action="deleteItem.jsp" method="post"
								onsubmit="return confirm('정말로 이 상품을 삭제하시겠습니까?');">
								<input type="hidden" name="user_id" value="<%=userId%>">
								<button type="submit"
									style="padding: 5px 10px; background-color: #FF6B6B; color: white; border: none; border-radius: 5px; cursor: pointer;">삭제</button>
							</form>
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
			<!-- 페이징 처리 -->
			<div class="pagination">
				<%
				for (int i = 1; i <= totalPages; i++) {
				%>
				<a
					href="adminMain.jsp?page=<%=i%>&keyField=<%=keyField != null ? keyField : ""%>&keyWord=<%=keyWord != null ? keyWord : ""%>&type=user"
					class="<%=(i == currentPage) ? "current-page" : ""%>"> <%=i%>
				</a>
				<%
				}
				%>
			</div>
		</div>
	</div>
</body>
</html>