<%@page import="report.ChatLogBean"%>
<%@page import="report.ReportBean"%>
<%@page import="report.ReportMgr"%>
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
		.admin_userList_user_img{
			width : 120px;
		}
		.report_num_span{
			cursor : pointer;
		}
		.report_chatLogBox{
			position:absolute;
			display:flex;
			flex-direction:column;
			background-color : white;
			width : 550px;
			padding : 20px;
			gap : 5px;
			border : 1px solid black;
		}
		.report_chatLogBox_exitBtn{
			position:absolute;
			right:5px;
			top:5px;
			cursor : pointer;
		}
		.report_chatLogBox_content{
			display:flex;
			align-items :center;
			width : 100%;
		}
		.report_chatLogBox_content div{
			padding : 5px;
			box-sizing : border-box;
		}
		.report_chatLogBox_Header{
			font-size : 24px;
		}
		.report_chatLogBox_content_box{
			border : 1px solid black;
			display:flex;
			flex-direction : column;
			gap : 5px;
			max-height : 300px;
			overflow-y : scroll;
			padding : 10px;
		}
		.admin_input{
			padding : 6px;
			border-radius:5px;
			border : 1px solid black;
			box-sizing:border-box;
		}
		.admin_select{
			padding : 5px;
			border-radius:5px;
			border : 1px solid black;
			box-sizing:border-box;
		}
		.admin_submitBtn{
			padding : 4px;
			background : none;
			border-radius:5px;
			box-sizing:border-box;
			border : 1px solid black;
		}
		.product-list-table td,
		.product-list-table th{
			border : none;
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
            <li onclick="showCategory(event)" data = "adminStore.jsp" id="storeTab"><i class="fa fa-store"></i>상점관리</li>
            <li onclick="showCategory(event)" data = "adminReport.jsp" class ="active">신고관리</li>
            <li onclick="logout()"><i class="fa fa-sign-out-alt"></i> 로그아웃</li>
        </ul>
    </div>
	<div class ="main-content">
		<h1>유저 관리</h1>
		<!-- 검색 폼 -->
		<form method="get" action="adminReport.jsp">
			<select class ="admin_select" name="user_keyField">
				<option value="report_type">신고 타입</option>
				<option value="report_senduserid">신고 유저</option>
				<option value="report_receiveuserid">피신고 유저</option>
			</select> <input class ="admin_input" type="text" name="user_keyWord" placeholder="검색어 입력" /> <input
				type="submit" class ="admin_submitBtn" value="검색" />
		</form>
		<!-- 상품 목록 출력 및 페이징 -->
		<div class="product-list">
			<h2>신고 목록</h2>
			<table class ="product-list-table">
				<thead>
					<tr>
						<th>신고번호</th>
						<th>신고 유저</th>
						<th>피신고 유저</th>
						<th>신고 시간</th>
						<th>신고 타입</th>
						<th>관리</th>
					</tr>
				</thead>
				<tbody>
					<%
					// 현재 페이지와 검색 조건을 받아옴
					String pageStr = request.getParameter("page");
					int userCurrentPage = (pageStr != null) ? Integer.parseInt(pageStr) : 1;
					int userItemsPerPage = 15;
					int start = (userCurrentPage - 1) * userItemsPerPage;

					// 검색어와 검색 필드를 받아옴
					String keyField = request.getParameter("user_keyField");
					String keyWord = request.getParameter("user_keyWord");

					// 총 상품 수 계산
					ReportMgr reportMgr = new ReportMgr();
					ItemMgr itemMgr = new ItemMgr();
					int totalUsers = reportMgr.getTotalReportCount(keyField, keyWord);

					// 상품 목록 가져오기 (start와 itemsPerPage 적용)
					Vector<ReportBean> reports = reportMgr.getReportList(keyField, keyWord, start, userItemsPerPage);
					

					// 총 페이지 수 계산
					int totalPages = (int) Math.ceil(totalUsers / (double) userItemsPerPage);

					if (reports.size() > 0) {
						for (int j = 0 ; j < reports.size() ; j ++) {
							ReportBean report = reports.get(j);
							int reportNum = report.getReport_num();
							String reportSendUserId = report.getReport_senduserid();
							String reportReceiveUserId = report.getReport_receiveuserid();
							String reportAt = report.getReport_at();
							String reportType = report.getReport_type();
							Vector<ChatLogBean> chatLogList = reportMgr.getChatLogByReport(report);
					%>
					<tr>
						
						<td>
						<div class ="report_chatLogBox" id = "chatLogBox-<%=reportNum %>" style = "display : none">
							<div class ="report_chatLogBox_exitBtn" onclick = "clickReportChatLogBoxExitBtn('chatLogBox-<%=reportNum%>')">X</div>
							<div class ="report_chatLogBox_Header">채팅 내역</div>
							<div class ="report_chatLogBox_content_box">
							<%if(chatLogList.size() == 0){ %>
								<div class ="report_chatLogBox_content"> 
								채팅내역이 없습니다.
								</div>
							<%} else{%>
							<%for(int i = 0 ; i < chatLogList.size() ; i++) {
							ChatLogBean chatLogBean = chatLogList.get(i);%>
							<div class ="report_chatLogBox_content">
								<%=chatLogBean.getChatlog_id() %> : <%=chatLogBean.getChatlog_content() %>
							</div>
							<%} }%>
							</div>
						</div>
						<span class ="report_num_span" onclick ="clickReportChatLogBoxOpenBtn('chatLogBox-<%=reportNum%>')"><%=reports.size() - j%></span>
						</td>
						<td><%=reportSendUserId%></td>
						<td><%=reportReceiveUserId%></td>
						<td><%=reportAt%></td>
						<td><%=reportType%></td>
						<td>
							<!-- 삭제 버튼 -->
							<form action="deleteItem.jsp" method="post"
								onsubmit="return confirm('정말로 이 상품을 삭제하시겠습니까?');">
								<input type="hidden" name="user_id" value="<%=reportNum%>">
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
					href="adminReport.jsp?page=<%=i%>&keyField=<%=keyField != null ? keyField : ""%>&keyWord=<%=keyWord != null ? keyWord : ""%>&type=user"
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
        
        function clickReportChatLogBoxExitBtn(id){
        	document.getElementById(id).style.display = "none";
        }
        function clickReportChatLogBoxOpenBtn(id){
        	document.querySelectorAll(".report_chatLogBox").forEach((e) => e.style.display = "none");
        	document.getElementById(id).style.display = "flex";
        }
    </script>
</body>
</html>
