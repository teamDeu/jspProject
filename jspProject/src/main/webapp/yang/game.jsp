<%@page import="java.util.HashMap"%>
<%@page import="item.ItemBean"%>
<%@page import="java.util.Vector"%>
<%@ page import="java.sql.*, pjh.MemberBean, pjh.DBConnectionMgr"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" 
                  pageEncoding="UTF-8" isELIgnored="false" %>
<%@ page import="java.sql.*, pjh.MemberBean, pjh.DBConnectionMgr"%>
<jsp:useBean id="mgr" class="pjh.MemberMgr" />
<%
String user_id = (String) session.getAttribute("idKey");
System.out.println(user_id);

// 클로버 잔액을 가져오기 위한 변수
int user_clover = 0;
DBConnectionMgr pool = null;
Connection conn = null;
PreparedStatement pstmt = null;
ResultSet rs = null;

//아이템별 구매 횟수를 저장하는 맵
HashMap<Integer, Integer> purchaseCountMap = new HashMap<>();

try {
    if (user_id != null) {
        pool = DBConnectionMgr.getInstance();
        conn = pool.getConnection(); // Connection 가져오기

        if (conn != null) {
            String sql = "SELECT user_clover FROM user WHERE user_id = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, user_id);
            rs = pstmt.executeQuery();

            if (rs.next()) {
                user_clover = rs.getInt("user_clover");
            }
            rs.close();
            pstmt.close();

        } else {
            throw new Exception("DB 연결에 실패하였습니다.");
        }
    }
} catch (Exception e) {
    e.printStackTrace(); // 오류 로그 출력
} finally {
    try {
        if (rs != null)
            rs.close();
        if (pstmt != null)
            pstmt.close();
        if (conn != null)
            pool.freeConnection(conn); // Connection 반환
    } catch (SQLException e) {
        e.printStackTrace(); // 오류 로그 출력
    }
}
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>가로로 긴 네모 박스 레이아웃</title>
    <script>

        function game1show() {
            document.getElementById("main").style.display = "none";
            document.getElementById("game1-container").style.display = "block";
            document.getElementById("game2-container").style.display = "none";
        }
        
        function game2show() {
            document.getElementById("main").style.display = "none";
            document.getElementById("game1-container").style.display = "none";
            document.getElementById("game2-container").style.display = "block";
        }

        // 클로버 값 주기적으로 서버에서 가져오는 함수
        function updateCloverAmountFromServer() {
            $.ajax({
                url: '../yang/getCloverBalance.jsp',  // 클로버 값을 가져오는 경로
                type: 'POST',
                data: {
                    userId: '<%= user_id %>'
                },
                success: function(response) {
                    const serverCloverAmount = parseInt(response);
                    const currentCloverAmount = parseInt($('#cloverAmountDisplay2').text()) || 0;

                    // 서버에서 받은 클로버 값이 현재 화면에 표시된 값과 다를 경우 업데이트
                    if (serverCloverAmount !== currentCloverAmount) {
                        $('#cloverAmountDisplay2').text(serverCloverAmount);
                    }
                },
                error: function() {
                    console.log('서버에서 클로버 잔액을 가져오는 중 오류가 발생했습니다.');
                }
            });
        }

        // 1초마다 서버에서 클로버 값을 가져와 화면에 반영
        setInterval(updateCloverAmountFromServer, 1000);
        
    </script>
    <style>
        .box-container {
            width: 750px; /* 박스의 가로 길이 */
            height: 270px; /* 박스의 높이 */
            margin: 20px auto; /* 화면 중앙에 배치 */
            padding: 20px;
            display: flex; /* flex 레이아웃을 사용 */
            align-items: center;
            border: 2px solid #BAB9AA;
            border-radius: 10px; /* 모서리를 둥글게 */
            background-color: #eeeeee; /* 배경색 */
        }

        .game-title {
            width: 800px; /* 줄 길이 */
            height: 2px;  /* 줄의 높이 */
            background-color: #BAB9AA;
            margin: 0 auto;
            position: relative;
            margin-top: 0; /* 위쪽 여백 */
            margin-bottom: 20px; /* 줄과 사각형 사이에 공간 추가 */
        }
        
        .game-title span {
           color: #80A46F;
		   text-align: center;
		   font-size: 36px;
		   font-weight: 600;
		   position: absolute;
		   top: 20px;
		   left: 30px;
        }

        .box-image {
            width: 250px; /* 이미지 너비 */
            height: 250px; /* 이미지 높이 */
            object-fit: cover; /* 이미지가 박스에 맞도록 */
            margin-right: 20px; /* 이미지와 오른쪽 내용 간 간격 */
        }

        .box-content {
            flex: 1; /* 나머지 공간을 차지하도록 설정 */
            display: flex;
            flex-direction: column;
            justify-content: space-between;
        }

        .text-content {
            flex: 1;
            text-align: left; /* 제목과 설명을 왼쪽 정렬 */
        }

        .box-title {
            font-size: 45px; /* 큰 글자 (제목) */
            font-weight: bold;
            color: #333;
            margin-bottom: 10px;
        }

        .box-description {
            font-size: 30px; /* 작은 글자 (설명) */
            color: #555;
            margin-bottom: 20px;
        }

		.box-button {
		    padding: 5px 20px;
		    font-size: 30px;
		    background-color: white;
		    color: black;
		    border: 1px solid #c1c1c1; /* 테두리 */
		    border-radius: 5px;
		    cursor: pointer;
		    align-self: flex-end; /* 버튼을 오른쪽에 배치 */
		}

        .box-button:hover {
            background-color: #C0E5AF; /* 버튼에 마우스를 올렸을 때 색 변경 */
        }

        /* game2.jsp를 포함하는 컨테이너 */
        #game-container {
            display: none; /* 처음에는 숨겨진 상태 */
        }
        /* 클로버 금액 */
		.clover-amount1 {
			font-size: 30px;
			color: green;
			position: absolute;
			top: 20px;
			right: 60px;
		}
    </style>
</head>
<body>
    <!-- 메인 콘텐츠 -->
    <div id="main" style="text-align: center; margin-top: 50px;">
        <!-- 가로줄과 텍스트 -->
        <div class="game-title">
            <span>게임</span> <!-- 가로줄 위의 텍스트 -->
        </div>
        <!-- 클로버 금액 -->
		<div class="clover-amount1">
			<img src="./img/clover_icon.png" alt="클로버">
			<span id="cloverAmountDisplay2"><%=user_clover%></span>
			<!-- 여기서 클로버 값 출력 -->
		</div>

        <!-- 첫 번째 큰 네모 박스 -->
        <div class="box-container">
            <img src="img/g1.png" alt="Sample Image 1" class="box-image"> <!-- 왼쪽 사진 -->
            <div class="box-content">
                <div class="text-content">
                    <div class="box-title">사다리 게임</div> <!-- 제목 -->
                    <div class="box-description">참가자가 가로로 그려진 사다리 위의 세로 선을 타고 내려가며 가로로 그려진 연결선을 만나 방향을 바꿔 내려가면서 가장 밑의 상금을 얻는 게임</div> <!-- 설명 -->
                </div>
                <button class="box-button" onclick="game1show()">-> start</button> 
            </div>
        </div>

        <!-- 두 번째 큰 네모 박스 -->
        <div class="box-container">
            <img src="img/g2.png" alt="Sample Image 2" class="box-image"> <!-- 왼쪽 사진 -->
            <div class="box-content">
                <div class="text-content">
                    <div class="box-title">돌림판 게임</div> <!-- 제목 -->
                    <div class="box-description">참가자가 회전하는 원판을 돌려서 랜덤하게 상금을 얻는 게임</div> <!-- 설명 -->
                </div>
                <button class="box-button" onclick="game2show()">-> start</button>
            </div>
        </div>
    </div>


    <div id="game2-container" style="display: none">
        <jsp:include page="game2.jsp"></jsp:include>
    </div>
    <div id="game1-container" style="display: none">
        <jsp:include page="game1.jsp"></jsp:include>
    </div>
</body>
</html>
