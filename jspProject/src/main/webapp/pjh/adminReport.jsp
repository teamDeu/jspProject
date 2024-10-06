<%@page import="report.SuspensionBean"%>
<%@page import="report.ChatLogBean"%>
<%@page import="report.ReportBean"%>
<%@page import="report.ReportMgr"%>
<%@page import="miniroom.ItemMgr"%>
<%@page import="pjh.MemberMgr"%>
<%@page import="pjh.MemberBean"%>
<%@page import="miniroom.UtilMgr"%>
<%@ page import="java.util.Vector"%>
<%@ page import="pjh.ItemBean, pjh.AItemMgr"%>
<%@ page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%
String type = request.getParameter("type");
%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>관리자 페이지</title>
<link rel="stylesheet" href="./css/admin.css" />
<script src="https://cdn.jsdelivr.net/npm/axios/dist/axios.min.js"></script>
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
    justify-content: flex-start; /* 신고 목록을 상단에 고정 */
    min-height: 100vh; /* 전체 화면 높이 */
    padding-bottom: 60px; /* 페이징 영역을 위해 여유 공간 확보 */
}

.product-list {
    flex-grow: 1;
    margin-top: 20px;
}

.product-list-table {
    width: 100%;
    border-collapse: collapse;
}

.product-list-table th, .product-list-table td {
    padding: 10px;
    border: 1px solid #ddd;
    text-align: center;
}

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
.admin_userList_user_img {
	width: 120px;
}

.report_chatLogModal {
	position: absolute;
	top: 0px;
	left: 0px;
	width: 100%;
	height: 100%;
	display: flex;
	align-items: center;
	justify-content: center;
	box-sizing: border-box;
}

.report_chatLogBox {
	display: flex;
	position: relative;
	flex-direction: column;
	background-color: white;
	width: 550px;
	height: 500px;
	padding: 20px;
	gap: 5px;
	border: 1px solid black;
}

.report_chatLogBox_exitBtn {
	position: absolute;
	right: 5px;
	top: 5px;
	cursor: pointer;
}

.report_chatLogBox_content {
	display: flex;
	align-items: center;
	width: 100%;
}

.report_chatLogBox_content div {
	padding: 5px;
	box-sizing: border-box;
}

.report_chatLogBox_Header {
	font-size: 24px;
}

.report_chatLogBox_content_box {
	border: 1px solid black;
	display: flex;
	flex-direction: column;
	gap: 5px;
	max-height: 300px;
	overflow-y: scroll;
	padding: 10px;
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

.suspension_period {
	padding: 5px;
	width: 200px;
}

.product-list-table td, .product-list-table th {
	border: none;
}

.report_manage_div {
	display: flex;
	flex-direction: column;
	justify-self: flex-end;
	align-items: center;
	gap: 5px;
}

.suspension_type {
	cursor: pointer;
	padding: 5px;
	border: 1px solid black;
	border-radius: 5px;
}

.suspension_type.active {
	border: 1px solid blue; /* 활성화된 라벨의 경계선 색상 */
	background-color: #e0f0ff; /* 활성화된 라벨의 배경색 */
}

.suspension_setting_section {
	display: flex;
	align-items: center;
	gap: 5px;
}
.pagination {
            display: flex;
            justify-content: center;
            margin-top: 20px;
            margin-bottom: 20px;
        }

        .pagination a {
            margin: 0 5px;
            text-decoration: none;
            color: #000;
        }

        .pagination a.current-page {
            font-weight: bold;
            color: #007bff;
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
            <li onclick="showCategory(event)" data="adminMain.jsp" id="dashboardTab"><i class="fa fa-home"></i> 대시보드</li>
            <li onclick="showCategory(event)" data="adminUser.jsp" id="userTab"><i class="fa fa-users"></i> 유저관리</li> <!-- 유저관리 아이콘 추가 -->
            <li onclick="showCategory(event)" data="adminStore.jsp" id="storeTab"><i class="fa fa-store"></i> 상점관리</li>
            <li onclick="showCategory(event)" data="adminReport.jsp" class = "active" id="reportTab"><i class="fa fa-exclamation-triangle"></i> 신고관리</li> <!-- 신고관리 아이콘 추가 -->
            <li onclick="logout()"><i class="fa fa-sign-out-alt"></i> 로그아웃</li>
        </ul>
	</div>
	<div class="main-content">
		<h1>유저 관리</h1>
		<!-- 검색 폼 -->
		<form method="get" action="adminReport.jsp">
			<select class="admin_select" name="user_keyField">
				<option value="report_type">신고 타입</option>
				<option value="report_senduserid">신고 유저</option>
				<option value="report_receiveuserid">피신고 유저</option>
			</select> <input class="admin_input" type="text" name="user_keyWord"
				placeholder="검색어 입력" /> <input type="submit"
				class="admin_submitBtn" value="검색" />
		</form>
		<!-- 상품 목록 출력 및 페이징 -->
		<div class="product-list">
			<h2>신고 목록</h2>
			<table class="product-list-table">
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
					int userItemsPerPage = 12;
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
						for (int j = 0; j < reports.size(); j++) {
							ReportBean report = reports.get(j);
							int reportNum = report.getReport_num();
							String reportSendUserId = report.getReport_senduserid();
							String reportReceiveUserId = report.getReport_receiveuserid();
							String reportAt = report.getReport_at();
							String reportType = report.getReport_type();
							boolean reportComplete = report.isReport_complete();
							Vector<ChatLogBean> chatLogList = reportMgr.getChatLogByReport(report);
							Vector<SuspensionBean> suspensionList = reportMgr.getSuspesionList(reportReceiveUserId);
					%>
					<tr>

						<td>
							<div class="report_chatLogModal" id="chatLogBox-<%=reportNum%>"
								style="display: none">
								<div class="report_chatLogBox">
									<div class="report_chatLogBox_Header">채팅 내역</div>
									<div class="report_chatLogBox_content_box">
										<%
										if (chatLogList.size() == 0) {
										%>
										<div class="report_chatLogBox_content">채팅내역이 없습니다.</div>
										<%
										} else {
										%>
										<%
										for (int i = 0; i < chatLogList.size(); i++) {
											ChatLogBean chatLogBean = chatLogList.get(i);
										%>
										<div class="report_chatLogBox_content">
											<%=chatLogBean.getChatlog_id()%>
											:
											<%=chatLogBean.getChatlog_content()%>
										</div>
										<%
										}
										}
										%>
									</div>
									<div class="report_chatLogBox_Header">정지 내역</div>
									<div class="report_chatLogBox_content_box">
										<%
										if (suspensionList.size() == 0) {
										%>
										<div class="report_chatLogBox_content">정지내역이 없습니다.</div>
										<%
										} else {
										%>
										<%
										for (int i = 0; i < suspensionList.size(); i++) {
											SuspensionBean suspensionBean = suspensionList.get(i);
										%>
										<div class="report_chatLogBox_content">
											<%=suspensionBean.getSuspension_date()%> 까지 
											<%=suspensionBean.getSuspension_type() == 1 ? "계정" : "채팅"%> 정지
										</div>
										<%
										}
										}
										%>
									</div>
									<div class="report_manage_div">
										<section class="suspension_setting_section" id ="settingSection-<%=reportNum%>">
											<select class="suspension_period">
												<option value=3>3일</option>
												<option value=5>5일</option>
												<option value=7>7일</option>
												<option value=30>30일</option>
											</select>
											<div class="suspension_type_box">
												<input name="suspension_type" id="suspension_type0<%=j%>"
													onchange="onchangeType(event)" type="radio" value=0
													hidden="true"><label class="suspension_type"
													for="suspension_type0<%=j%>">채팅정지</label> <input
													name="suspension_type" id="suspension_type1<%=j%>"
													onchange="onchangeType(event)" type="radio" value=1
													hidden="true"><label class="suspension_type"
													for="suspension_type1<%=j%>">계정정지</label>
											</div>
										</section>
										<div class="report_manage_div_btn_box">
											<button onclick="clickReportSubmit('<%=reportNum%>')"
												class="report_manage_div_btn_submit">제출하기</button>
											<button onclick="clickReportReject('<%=reportNum%>')">신고반려</button>
											<button
												onclick="clickReportChatLogBoxExitBtn('chatLogBox-<%=reportNum%>')"
												class="report_manage_div_btn_cancel">취소하기</button>

										</div>
									</div>
								</div>

							</div> <span class="report_num_span"
							onclick="clickReportChatLogBoxOpenBtn('chatLogBox-<%=reportNum%>')"><%=reports.size() - j%></span>
						</td>
						<td><%=reportSendUserId%></td>
						<td><%=reportReceiveUserId%></td>
						<td><%=reportAt%></td>
						<td><%=reportType%></td>
						<td>
							<%
							if (reportComplete) {
							%> <span>처리된 신고</span> <%
 } else {
 %>
							<button
								onclick="clickReportChatLogBoxOpenBtn('chatLogBox-<%=reportNum%>')">관리하기</button>
						</td>
						<%
						}
						%>
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
	<script src="https://kit.fontawesome.com/a076d05399.js"
		crossorigin="anonymous"></script>

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
        	document.querySelectorAll(".report_chatLogModal").forEach((e) => e.style.display = "none");
        	document.getElementById(id).style.display = "flex";
        }
        
        function onchangeType(event) {
            // 모든 라벨에서 active 클래스를 제거
            const labels = document.querySelectorAll('.suspension_type');
            labels.forEach(label => {
                label.classList.remove('active');
            });

            // 선택된 라디오 버튼에 해당하는 라벨에 active 클래스 추가
            const selectedLabel = document.querySelector("label[for='"+event.target.id+"']");
            if (selectedLabel) {
                selectedLabel.classList.add('active');
            }
        }
        
        function clickReportSubmit(reportNum){
        	var xhr = new XMLHttpRequest();
       		const settingSection = document.getElementById("settingSection-"+reportNum);
       		const suspension_period = settingSection.querySelector('.suspension_period').value;
       		if(settingSection.querySelector("input[name=suspension_type]:checked") == null){
       			alert("제재 방식을 결정해주세요.")
       			return;
       		}
       		const suspension_type = settingSection.querySelector("input[name=suspension_type]:checked").value
       		console.log(suspension_period , suspension_type);
       		
  	    	xhr.open("GET", "../pjh/adminReportProc.jsp?type=submit&report_num="+reportNum+"&suspension_period="+suspension_period+"&suspension_type="+suspension_type, true); // Alarm 갱신Proc
  	    	xhr.onreadystatechange = function () {
	  	        if (xhr.readyState === 4 && xhr.status === 200) {
	  	        	alert("제재가 완료되었습니다");
	  	        	location.href = location.href;
	  	        }
  	    	};
  	    	xhr.send();
  	    	
        }
        
        function clickReportReject(reportNum){
        	var xhr = new XMLHttpRequest();
        	xhr.open("GET","../pjh/adminReportProc.jsp?type=reject&report_num="+reportNum);
        	xhr.onreadystatechange = function(){
        		if(xhr.readyState === 4 && xhr.status === 200){
        			alert("신고가 반려되었습니다.")
        			location.href = location.href;
        		}
        	};
        	xhr.send();
        }
    </script>
</body>
</html>
