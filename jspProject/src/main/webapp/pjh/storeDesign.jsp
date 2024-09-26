<%@page import="java.util.HashMap"%>
<%@page import="item.ItemBean"%>
<%@page import="java.util.Vector"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page import="java.sql.*, pjh.MemberBean, pjh.DBConnectionMgr"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page import="java.sql.*, pjh.MemberBean, pjh.DBConnectionMgr"%>
<jsp:useBean id="mgr" class="item.ItemMgr" />
<%
Vector<ItemBean> Allvlist = mgr.getAllItems();
Vector<ItemBean> Musicvlist = mgr.getMusicItems();
Vector<ItemBean> Charactervlist = mgr.getCharacterItems();
Vector<ItemBean> Backgroundvlist = mgr.getBackgroundItems();

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

            // 각 아이템의 구매 횟수를 가져오는 쿼리
            String purchaseCountSQL = "SELECT item_num, COUNT(*) AS purchase_count FROM itemhold GROUP BY item_num";
            pstmt = conn.prepareStatement(purchaseCountSQL);
            rs = pstmt.executeQuery();
            while (rs.next()) {
                purchaseCountMap.put(rs.getInt("item_num"), rs.getInt("purchase_count"));
            }
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
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>스토어</title>
<style>
@font-face {
	font-family: 'NanumTobak';
	src: url('나눔손글씨 또박또박.TTF') format('truetype');
}

.store {
	font-family: 'NanumTobak';
	background-color: #F5F5F5;
	text-align: center;
	margin: 0;
	padding: 0;
	overflow: scroll;
}

.storecontainer {
	width: 95%;
	margin: 0 auto;
	padding: 20px;
	background-color: #FFF;
	border-radius: 10px;
	box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
	position: relative;
}
/* 상점 제목 */
.store-title {
	font-size: 30px;
	color: black;
	font-weight: bold;
	text-align: left;
	margin-bottom: 10px;
	position: absolute;
	top: 20px;
	left: 20px;
	border-bottom: 2px solid #ccc; /* 제목 아래 줄 추가 */
}
/* 클로버 금액 */
.clover-amount {
	font-size: 18px;
	color: green;
	position: absolute;
	top: 20px;
	right: 60px;
}
/* 카테고리 탭 */
.nav-tabs {
	display: flex;
	justify-content: left;
	list-style: none;
	padding: 0;
	margin-bottom: 20px;
	margin-top: 80px;
	border-bottom: 2px solid #ccc; /* 카테고리 아래 줄 추가 */
}

.nav-tabs li {
	padding: 10px 30px;
	cursor: pointer;
	font-size: 18px;
	color: #888;
	transition: color 0.3s ease;
}

.nav-tabs li.active {
	color: green;
	border-bottom: 2px solid green;
}
/* 인기순, 가격순, 클로버 충전 */
.sort-options {
	display: flex;
	justify-content: flex-end;
	align-items: center;
	gap: 20px;
	margin-bottom: 20px;
	margin-right: 20px;
}

.sort-buttons {
	display: flex;
	gap: 20px;
}

.sort-buttons span {
	font-size: 18px;
	cursor: pointer;
	color: #888;
}

.sort-buttons span.active {
	color: green;
}

.search button {
	padding: 10px 20px;
	background-color: #90EE90;
	border: none;
	color: white;
	cursor: pointer;
	border-radius: 20px;
}
/* 상품 목록 */
.items-container {
    display: grid;
    grid-template-columns: repeat(4, 1fr);
    gap: 20px;
    padding: 20px;
    border: 1px solid #ccc;
    min-height: 300px; /* 최소 높이 설정 */
}


.item {
	background-color: #FFF;
	border-radius: 10px;
	padding: 10px;
	box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
	text-align: center;
	border: 1px solid #ccc; /* 상품에 네모난 테두리 추가 */
}

.product-img {
   	width: 165px;
    height: 150px;
    border-radius: 10px; /* 상품 이미지 모서리 둥글게 */
}

.clover-icon {
    width: 20px; /* 클로버 아이콘 크기 */
    height: 20px;
    margin-right: 5px; /* 텍스트와 약간의 간격 */
}


.item-title {
	font-size: 16px;
	margin-top: 10px;
}

.item-price {
	display: flex;
	justify-content: center;
	align-items: center;
	margin-top: 10px;
}

.item-price img {
	width: 20px;
	margin-right: 5px;
}
/* 페이지네이션 */
.pagination {
	display: flex;
	justify-content: center;
	padding: 20px;
}

.pagination span {
	padding: 5px 10px;
	margin: 0 5px;
	cursor: pointer;
	border: 1px solid #ccc;
	border-radius: 5px;
}

.pagination span.active {
	background-color: green;
	color: #FFF;
	border-color: green;
}
</style>

<script type="text/javascript">

const itemsPerPage = 8; // 페이지당 8개 아이템
let currentPage = 1; // 현재 페이지
let items = []; // 현재 선택된 카테고리의 아이템들
let itemsAll = []; // 전체 아이템 배열
let itemsMusic = []; // 음악 아이템 배열
let itemsCharacter = []; // 캐릭터 아이템 배열
let itemsBackground = []; // 배경 아이템 배열
let itemsBuylist = []; // 구매목록 아이템 배열
let sortMode = 'default'; // 정렬 모드 ('default', 'popularity', 'price')
let sortOrder = 'desc'; // 정렬 순서 ('desc', 'asc')

// 카테고리 타입 변경 시 호출되는 함수
function changeItemType(event, itemType) {
    // 모든 탭의 active 클래스 제거
    document.querySelectorAll('.nav-tabs li').forEach(tab => tab.classList.remove('active'));
    // 클릭된 탭에 active 클래스 추가
    event.target.classList.add('active');

    // 모든 아이템 컨테이너 숨기기
    document.querySelectorAll('.items-container').forEach(container => container.style.display = 'none');

    // 선택된 카테고리에 따라 items 배열을 설정하고 아이템 컨테이너 보이기
    if (itemType === 'all') {
        items = itemsAll;
        document.getElementById("allItems").style.display = "grid";
    } else if (itemType === 'music') {
        items = itemsMusic;
        document.getElementById("musicItems").style.display = "grid";
    } else if (itemType === 'character') {
        items = itemsCharacter;
        document.getElementById("characterItems").style.display = "grid";
    } else if (itemType === 'background') {
        items = itemsBackground;
        document.getElementById("backgroundItems").style.display = "grid";
    } else if (itemType === 'buylist') {
        items = itemsBuylist;
        document.getElementById("buylistItems").style.display = "grid";
    }

    // 페이지 초기화 및 아이템 표시
    currentPage = 1;
    displayItems(); // 아이템을 다시 렌더링
}
//정렬 모드를 변경하는 함수
function changeSortMode(mode) {
    if (sortMode === mode) {
        // 같은 모드에서 다시 클릭하면 정렬 순서를 반대로 변경
        sortOrder = sortOrder === 'desc' ? 'asc' : 'desc';
    } else {
        // 새로운 모드로 변경하면 기본 순서로 설정
        sortMode = mode;
        sortOrder = 'desc';
    }
    applySort();
}

// 정렬을 적용하는 함수
function applySort() {
    if (sortMode === 'popularity') {
        // 인기순 정렬
        items.sort((a, b) => {
            const countA = parseInt(a.dataset.purchaseCount);
            const countB = parseInt(b.dataset.purchaseCount);
            return sortOrder === 'desc' ? countB - countA : countA - countB;
        });
    } else if (sortMode === 'price') {
        // 가격순 정렬
        items.sort((a, b) => {
            const priceA = parseInt(a.dataset.price);
            const priceB = parseInt(b.dataset.price);
            return sortOrder === 'desc' ? priceB - priceA : priceA - priceB;
        });
    }
    displayItems();
}




// 페이지를 변경하는 함수
function changePage(page) {
    currentPage = page;
    displayItems();
}

// 다음 페이지로 이동하는 함수
function clickNext() {
    if (items.length > currentPage * itemsPerPage) {
        changePage(currentPage + 1);
    }
}

// 이전 페이지로 이동하는 함수
function clickPrev() {
    if (currentPage > 1) {
        changePage(currentPage - 1);
    }
}


//아이템을 화면에 보여주는 함수
function displayItems() {
    const start = (currentPage - 1) * itemsPerPage;
    const end = start + itemsPerPage;
    const visibleItems = items.slice(start, end);

    // 현재 선택된 카테고리의 컨테이너를 명시적으로 설정
    let itemsContainer;
    if (items === itemsAll) {
        itemsContainer = document.getElementById('allItems');
    } else if (items === itemsMusic) {
        itemsContainer = document.getElementById('musicItems');
    } else if (items === itemsCharacter) {
        itemsContainer = document.getElementById('characterItems');
    } else if (items === itemsBackground) {
        itemsContainer = document.getElementById('backgroundItems');
    } else if (items === itemsBuylist) {  // 구매 목록 처리
        itemsContainer = document.getElementById('buylistItems');
    }

    itemsContainer.innerHTML = ''; // 기존 아이템 제거

    // 선택된 아이템들을 화면에 추가
    visibleItems.forEach(item => {
        itemsContainer.appendChild(item);
    });

    // 페이지네이션 업데이트
    updatePagination();
}





//페이지네이션 업데이트 함수
function updatePagination() {
    const totalPages = Math.ceil(items.length / itemsPerPage);
    const paginationContainer = document.querySelector('.pagination');
    paginationContainer.innerHTML = ''; // 기존 페이지네이션 제거

    for (let i = 1; i <= totalPages; i++) {
        const pageSpan = document.createElement('span');
        pageSpan.textContent = i;
        pageSpan.classList.toggle('active', i === currentPage); // 현재 페이지 강조
        pageSpan.onclick = () => changePage(i);
        paginationContainer.appendChild(pageSpan);
    }
}

// 페이지를 변경하는 함수
function changePage(page) {
    currentPage = page;
    displayItems();
}

//DOM이 로드되면 초기화
document.addEventListener('DOMContentLoaded', function () {
    // 각 카테고리의 아이템을 올바르게 배열에 저장
    itemsAll = Array.from(document.querySelectorAll('.allItems'));
    itemsMusic = Array.from(document.querySelectorAll('.musicItems'));
    itemsCharacter = Array.from(document.querySelectorAll('.characterItems'));
    itemsBackground = Array.from(document.querySelectorAll('.backgroundItems'));
    itemsBuylist = Array.from(document.querySelectorAll('.buylistItems')); // 구매목록 클래스 기준으로 배열 저장

    // 기본적으로 전체 아이템을 선택하고 표시
    items = itemsAll;
    displayItems();  // 첫 로딩 시 전체 아이템을 표시
});



        // 탭 클릭 시 active 클래스 적용
        function clickOpenType(id, clickedTab) {
            const openBox = document.getElementById(id);
            const anotherBox = document.querySelectorAll(".items-container");
            const tabs = document.querySelectorAll('.nav-tabs li');

            // 모든 컨테이너 숨기기
            anotherBox.forEach(box => {
                box.style.display = "none";
            });

            // 선택된 탭에 active 클래스 적용하고 나머지 탭에서 제거
            tabs.forEach(tab => {
                tab.classList.remove('active');
            });
            clickedTab.classList.add('active');

            // 선택된 아이템 컨테이너만 보이기
            openBox.style.display = "grid";
        }
        
        function buyItem(itemNum, itemPrice) {
            // 클로버 잔액 체크
            if (<%= user_clover %> < itemPrice) {
                alert("클로버가 부족합니다.");
                return;
            }

            // 구매 처리 AJAX 요청
            const xhr = new XMLHttpRequest();
            xhr.open("POST", "../pjh/buyItem.jsp", true);
            xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
            xhr.onreadystatechange = function() {
                if (xhr.readyState == 4 && xhr.status == 200) {
                    if (xhr.responseText.trim() === 'SUCCESS') {
                        alert("구매가 완료되었습니다!");
                        location.reload(); // 페이지 새로고침하여 클로버 업데이트
                    } else if (xhr.responseText.trim() === 'NOT_ENOUGH_CLOVER') {
                        alert("클로버가 부족합니다.");
                    } else {
                        alert("구매에 실패했습니다. 다시 시도해 주세요.");
                    }
                }
            };
            xhr.send("item_num=" + itemNum + "&item_price=" + itemPrice);
        }

        
        function refundItem(itemNum, itemPrice) {
            if (confirm("정말로 환불하시겠습니까?")) {
                // 환불 처리 AJAX 요청
                const xhr = new XMLHttpRequest();
                xhr.open("POST", "../pjh/refundItem.jsp", true);
                xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
                xhr.onreadystatechange = function() {
                    if (xhr.readyState == 4 && xhr.status == 200) {
                        if (xhr.responseText.trim() === 'SUCCESS') {
                            alert("환불이 완료되었습니다!");
                            location.reload(); // 페이지 새로고침하여 클로버 업데이트
                        } else {
                            alert("환불에 실패했습니다. 다시 시도해 주세요.");
                        }
                    }
                };
                xhr.send("item_num=" + itemNum + "&item_price=" + itemPrice);
            }
        }







    </script>
</head>
<div class="store">

	<div class="storecontainer">
		<!-- 상점 제목 -->
		<div class="store-title">상점</div>

		<!-- 클로버 금액 -->
		<div class="clover-amount">
			<img src="./img/clover_icon.png" alt="클로버">
			<%=user_clover%>
			<!-- 여기서 클로버 값 출력 -->
		</div>

		<!-- 카테고리 탭 -->
		<ul class="nav-tabs">
			<li onclick="changeItemType(event, 'all')" class="active">전체</li>
			<li onclick="changeItemType(event, 'music')">음악</li>
			<li onclick="changeItemType(event, 'character')">캐릭터</li>
			<li onclick="changeItemType(event, 'background')">배경</li>
			<li onclick="changeItemType(event, 'buylist')">구매목록</li>
			
		</ul>

		<!-- 인기순, 가격순 및 클로버 충전 -->
        <div class="sort-options">
            <div class="sort-buttons">
                <span onclick="changeSortMode('popularity')">인기순</span>
                <span onclick="changeSortMode('price')">가격순</span>
            </div>
            <div class="search">
                <button onclick="window.open('../pjh/pay.jsp', '_blank', )">클로버 충전</button>
            </div>
        </div>

		<!-- 전체 상품 목록 -->
        <div id="allItems" class="items-container">
            <%
            for (int i = 0; i < Allvlist.size(); i++) {
                ItemBean bean = Allvlist.get(i);
                int purchaseCount = purchaseCountMap.containsKey(bean.getItem_num()) ? purchaseCountMap.get(bean.getItem_num()) : 0;
            %>
            <div class="allItems" data-purchase-count="<%= purchaseCount %>" data-price="<%=bean.getItem_price()%>" onclick="buyItem(<%=bean.getItem_num()%>, <%=bean.getItem_price()%>)"> <!-- 전체 아이템 클래스 -->
                <jsp:include page="../pjh/shopItem.jsp">
                    <jsp:param value="<%=bean.getItem_image()%>" name="item_img" />
                    <jsp:param value="<%=bean.getItem_name()%>" name="item_name" />
                    <jsp:param value="<%=bean.getItem_price()%>" name="item_price" />
                </jsp:include>
            </div>
            <%
            }
            %>
        </div>

        <!-- 음악 상품 목록 -->
        <div id="musicItems" class="items-container" style="display:none;">
            <%
            for (int i = 0; i < Musicvlist.size(); i++) {
                ItemBean bean = Musicvlist.get(i);
                int purchaseCount = purchaseCountMap.containsKey(bean.getItem_num()) ? purchaseCountMap.get(bean.getItem_num()) : 0;
            %>
            <div class="musicItems" data-purchase-count="<%= purchaseCount %>" data-price="<%=bean.getItem_price()%>" onclick="buyItem(<%=bean.getItem_num()%>, <%=bean.getItem_price()%>)"> <!-- 음악 아이템 클래스 -->
                <jsp:include page="../pjh/shopItem.jsp">
                    <jsp:param value="<%=bean.getItem_image()%>" name="item_img" />
                    <jsp:param value="<%=bean.getItem_name()%>" name="item_name" />
                    <jsp:param value="<%=bean.getItem_price()%>" name="item_price" />
                </jsp:include>
            </div>
            <%
            }
            %>
        </div>

        <!-- 캐릭터 상품 목록 -->
        <div id="characterItems" class="items-container" style="display:none;">
            <%
            for (int i = 0; i < Charactervlist.size(); i++) {
                ItemBean bean = Charactervlist.get(i);
                int purchaseCount = purchaseCountMap.containsKey(bean.getItem_num()) ? purchaseCountMap.get(bean.getItem_num()) : 0;
            %>
            <div class="characterItems" data-purchase-count="<%= purchaseCount %>" data-price="<%=bean.getItem_price()%>" onclick="buyItem(<%=bean.getItem_num()%>, <%=bean.getItem_price()%>)"> <!-- 캐릭터 아이템 클래스 -->
                <jsp:include page="../pjh/shopItem.jsp">
                    <jsp:param value="<%=bean.getItem_image()%>" name="item_img" />
                    <jsp:param value="<%=bean.getItem_name()%>" name="item_name" />
                    <jsp:param value="<%=bean.getItem_price()%>" name="item_price" />
                </jsp:include>
            </div>
            <%
            }
            %>
        </div>

        <!-- 배경 상품 목록 -->
        <div id="backgroundItems" class="items-container" style="display:none;">
            <%
            for (int i = 0; i < Backgroundvlist.size(); i++) {
                ItemBean bean = Backgroundvlist.get(i);
                int purchaseCount = purchaseCountMap.containsKey(bean.getItem_num()) ? purchaseCountMap.get(bean.getItem_num()) : 0;
            %>
            <div class="backgroundItems" data-purchase-count="<%= purchaseCount %>" data-price="<%=bean.getItem_price()%>" onclick="buyItem(<%=bean.getItem_num()%>, <%=bean.getItem_price()%>)"> <!-- 배경 아이템 클래스 -->
                <jsp:include page="../pjh/shopItem.jsp">
                    <jsp:param value="<%=bean.getItem_image()%>" name="item_img" />
                    <jsp:param value="<%=bean.getItem_name()%>" name="item_name" />
                    <jsp:param value="<%=bean.getItem_price()%>" name="item_price" />
                </jsp:include>
            </div>
            <%
            }
            %>
        </div>

<!-- 구매목록 상품 목록 -->
<div id="buylistItems" class="items-container" style="display:none;">
    <%
    String getUserItemsSQL = "SELECT i.item_name, i.item_image, i.item_price, h.item_num FROM item i JOIN itemhold h ON i.item_num = h.item_num WHERE h.user_Id = ?";
    pstmt = conn.prepareStatement(getUserItemsSQL);
    pstmt.setString(1, user_id);
    rs = pstmt.executeQuery();

    // 구매한 아이템을 루프 돌며 표시
    while (rs.next()) {
    %>
    <div class="buylistItems" onclick="refundItem(<%= rs.getInt("item_num") %>, <%= rs.getInt("item_price") %>)">
        <img src="<%= rs.getString("item_image") %>" alt="<%= rs.getString("item_name") %>" style="width:186px;height:165px;"/>
        <div class="item-title"><%= rs.getString("item_name") %></div>
        <div class="item-price">
            <img src="./img/clover_icon.png" alt="클로버" style="width:20px; height:20px;"> <%= rs.getInt("item_price") %>개
        </div>
    </div>
    <%
    }
    rs.close();
    pstmt.close();
    %>
</div>


		<!-- 페이지네이션 -->
		<div class="pagination"></div>
	</div>

</div>