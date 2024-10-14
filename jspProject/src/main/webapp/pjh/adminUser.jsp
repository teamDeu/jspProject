<%@page import="miniroom.ItemMgr"%>
<%@page import="pjh.MemberMgr"%>
<%@page import="pjh.MemberBean"%>
<%@page import="miniroom.UtilMgr"%>
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
	<style>
         .main-content {
            flex: 1;
            display: flex;
            flex-direction: column;
            justify-content: flex-start; /* 유저 목록을 상단에 고정 */
            min-height: 100vh; /* 전체 화면 높이 */
            padding-bottom: 60px; /* 페이징 영역을 위해 여유 공간 확보 */
        }

        .admin_userList {
            flex-grow: 1;
            margin-top: 20px;
        }

        .admin_userList table {
            width: 100%;
            border-collapse: collapse;
        }

        .admin_userList table th, .admin_userList table td {
            padding: 10px;
            border: 1px solid #ddd;
            text-align: center;
        }

        .admin_userList_user_img {
            width : 20px;
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
            padding: 10px;
            background-color: #C0E5AF;
            border-radius: 10px;
        }

        .pagination-container a.current-page {
            font-weight: bold;
            color: #007bff;
            background-color: #27ae60;
        }

        .admin_userList {
            flex-grow: 1;
            margin-top: 20px;
        }

        .admin_userList table {
            width: 100%;
            border-collapse: collapse;
        }

        .admin_userList table th, .admin_userList table td {
            padding: 10px;
            border: 1px solid #ddd;
            text-align: center;
        }

        .admin_userList_user_img {
            width : 20px;
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
.alarm_button{
	    position: absolute;
    right: 20px;
    top: 160px;
    padding:5px;
    background : none;
    border : 1px solid black;
    border-radius : 10px;
    cursor : pointer;
}
.alarm_button:hover{
	background-color : rgba(0,0,0,0.2);
}
	</style>
	<link
    rel="stylesheet"
    href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.8.2/css/all.min.css"
  />
</head>
<body>

    <!-- 사이드바 -->
    <div class="sidebar">
        <h2>관리자 패널</h2>
        <ul>
            <li onclick="showCategory(event)" data="adminMain.jsp"  id="dashboardTab"><i class="fa fa-home"></i> 대시보드</li>
            <li onclick="showCategory(event)" data="adminUser.jsp" class="active" id="userTab"><i class="fa fa-users"></i> 유저관리</li> <!-- 유저관리 아이콘 추가 -->
            <li onclick="showCategory(event)" data="adminStore.jsp" id="storeTab"><i class="fa fa-store"></i> 상점관리</li>
            <li onclick="showCategory(event)" data="adminReport.jsp" id="reportTab"><i class="fa fa-exclamation-triangle"></i> 신고관리</li> <!-- 신고관리 아이콘 추가 -->
            <li onclick="logout()"><i class="fa fa-sign-out-alt"></i> 로그아웃</li>
        </ul>
    </div>
	<div class ="main-content">
		<h1>유저 관리</h1>
		<!-- 검색 폼 -->
		<form method="get" action="adminUser.jsp">
			<select class = "admin_select" name="user_keyField">
				<option value="user_id">유저 ID</option>
				<option value="user_name">유저 이름</option>
				<option value="user_phone">유저 번호</option>
			</select> <input class = admin_input type="text" name="user_keyWord" placeholder="검색어 입력" /> <input
				type="submit" class = "admin_submitBtn" value="검색" />
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
					</tr>
				</thead>
				<tbody>
					<%
					// 현재 페이지와 검색 조건을 받아옴
					String pageStr = request.getParameter("page");
					int userCurrentPage = (pageStr != null) ? Integer.parseInt(pageStr) : 1;
					int userItemsPerPage = 10;
					int start = (userCurrentPage - 1) * userItemsPerPage;

					// 검색어와 검색 필드를 받아옴
					String keyField = request.getParameter("user_keyField");
					String keyWord = request.getParameter("user_keyWord");

					// 총 상품 수 계산
					MemberMgr userMgr = new MemberMgr();
					ItemMgr itemMgr = new ItemMgr();
					int totalUsers = userMgr.getTotalUserCount(keyField, keyWord);

					// 상품 목록 가져오기 (start와 itemsPerPage 적용)
					Vector<MemberBean> users = userMgr.getUserList(keyField, keyWord, start, userItemsPerPage);

					// 총 페이지 수 계산
					int totalPages = (int) Math.ceil(totalUsers / (double) userItemsPerPage);

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
						<td class ="admin_userList_user_img_box"><img class ="admin_userList_user_img"src='<%=userChracter%>'></td>
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
			<div class="pagination-container">
				<%
				for (int i = 1; i <= totalPages; i++) {
				%>
				<a
					href="adminUser.jsp?page=<%=i%>&keyField=<%=keyField != null ? keyField : ""%>&keyWord=<%=keyWord != null ? keyWord : ""%>&type=user"
					class="<%=(i == userCurrentPage) ? "current-page" : ""%>"> <%=i%>
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
