<%@page import="java.util.Map"%>
<%@page import="java.util.ArrayList"%>
<%@ page import="java.util.Vector"%>
<%@ page import="pjh.ItemBean, pjh.AItemMgr" %>
<%@ page import="java.util.List" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="pjh.MemberMgr"%>
<% String type = request.getParameter("type"); 
		//MemberMgr 인스턴스 생성
		MemberMgr memberMgr = new MemberMgr();
		
		// 전체 방문자 수 가져오기 (visitcount 테이블의 visit_count의 총합)
		int totalVisitors = memberMgr.getTotalVisitorCountForAll();
		
		// 오늘 방문자 수 가져오기 (visitcount 테이블에서 오늘 접속한 총 횟수)
		int todayVisitors = memberMgr.getTodayVisitorCountForAll();
		
		// type 값을 받는다.
		String typeString = request.getParameter("type");
		if (type == null || type.isEmpty()) {
		    type = "monthly"; // 기본값 설정
		}
		
		// 방문자 데이터를 가져옴 (월별, 시간대별)
	    Map<String, Integer> monthlyVisitorData = memberMgr.getMonthlyVisitorCount();
	    Map<String, Integer> hourlyVisitorData = memberMgr.getHourlyVisitorCount();

	    // 데이터를 자바스크립트로 전달하기 위해 준비
	    List<String> monthlyLabels = new ArrayList<>(monthlyVisitorData.keySet());
	    List<Integer> monthlyValues = new ArrayList<>(monthlyVisitorData.values());

	    List<String> hourlyLabels = new ArrayList<>(hourlyVisitorData.keySet());
	    List<Integer> hourlyValues = new ArrayList<>(hourlyVisitorData.values());
%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>관리자 페이지</title>
    <style>
            #chartContainer {
            margin-top: 30px;
            max-width: 800px;
            margin-left: auto;
            margin-right: auto;
        }
    </style>
    <link rel="stylesheet" href="./css/admin.css" />
     <!-- 차트.js CDN -->
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
</head>
<body>

    <!-- 사이드바 -->
    <div class="sidebar">
        <h2>관리자 패널</h2>
        <ul>
            <li onclick="showCategory(event)" data = "adminMain.jsp" class ="active" id="dashboardTab"><i class="fa fa-home"></i> 대시보드</li>
            <li onclick="showCategory(event)" data = "adminUser.jsp" >유저관리</li>
            <li onclick="showCategory(event)" data = "adminStore.jsp" id="storeTab"><i class="fa fa-store"></i>상점관리</li>
            <li onclick="showCategory(event)" data = "adminReport.jsp" >신고관리</li>
            <li onclick="logout()"><i class="fa fa-sign-out-alt"></i> 로그아웃</li>
        </ul>
    </div>

    <!-- 대시보드 섹션 -->
    <div id="dashboard" class="main-content">
        <h1>대시보드</h1>
        <div class="content-cards">
            <div class="card" id="totalVisitorsCard">
                <h3>총 접속자</h3>
                <p>총 <%= totalVisitors %>명</p>
            </div>
            <div class="card" id="todayVisitorsCard">
                <h3>오늘 접속자</h3>
                <p>총 <%= todayVisitors %>명</p>
            </div>
            <div class="card">
                <h3>신규 가입자</h3>
                <p>총 78명</p>
            </div>
        </div>

        <!-- 차트 컨테이너 -->
        <div id="chartContainer" style="display: none;">
            <canvas id="visitorChart" width="400" height="200"></canvas>
        </div>
    </div>

    <script>
        var chart; // 차트 인스턴스 변수

        // JSP에서 전달된 데이터를 자바스크립트 배열로 변환
        var monthlyLabels = <%= new org.json.JSONArray(monthlyLabels).toString() %>;
        var monthlyValues = <%= new org.json.JSONArray(monthlyValues).toString() %>;

        var hourlyLabels = <%= new org.json.JSONArray(hourlyLabels).toString() %>;
        var hourlyValues = <%= new org.json.JSONArray(hourlyValues).toString() %>;

        document.getElementById('totalVisitorsCard').onclick = function() {
            drawChart('monthly', monthlyLabels, monthlyValues);
        };

        document.getElementById('todayVisitorsCard').onclick = function() {
            drawChart('hourly', hourlyLabels, hourlyValues);
        };

        function drawChart(type, labels, values) {
            // 차트가 이미 존재하면 파괴
            if (chart) {
                chart.destroy();
            }

            // 차트 컨테이너 표시
            document.getElementById('chartContainer').style.display = 'block';

            var ctx = document.getElementById('visitorChart').getContext('2d');
            chart = new Chart(ctx, {
                type: 'bar',  // 차트 유형: 막대 그래프
                data: {
                    labels: labels,  // x축 레이블
                    datasets: [{
                        label: type === 'monthly' ? '월별 접속자 수' : '4시간 단위 접속자 수',
                        data: values,  // y축 데이터
                        backgroundColor: 'rgba(75, 192, 192, 0.2)',
                        borderColor: 'rgba(75, 192, 192, 1)',
                        borderWidth: 1
                    }]
                },
                options: {
                    scales: {
                        y: {
                            beginAtZero: true
                        }
                    }
                }
            });
        }
    </script>

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
    </script>
</body>
</html>
