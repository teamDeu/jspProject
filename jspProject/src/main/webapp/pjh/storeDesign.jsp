<%@page import="java.util.HashMap"%>
<%@page import="item.ItemBean"%>
<%@page import="java.util.Vector"%>
<%@ page import="java.sql.*, pjh.MemberBean, pjh.DBConnectionMgr"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" 
                  pageEncoding="UTF-8" isELIgnored="false" %>
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
    background-color: #F7F7F7;
    text-align: center;
    margin: 0;
    padding: 0;	
    border-radius: 30px;
}

.storecontainer {
    width: 98%;
    margin: 0 auto;
    padding: 10px;
    border-radius: 10px;
    position: relative;
    padding-bottom: 30px; /* 페이지네이션을 위한 공간 확보 */
    height: 660px; /* vh에서 px로 변경 */
    max-height: 700px; /* 최대 높이 역시 px로 변경 */
    border-radius: 30px;
}

/* 상점 제목 */
.store-title {

    color: #80A46F; 
    text-align: center; 
    font-size: 36px; 
    font-weight: 600; 
    position: absolute; 
    top: -5px; 
    left: 30px; 
    
    display: inline-block;

  
}


/* 클로버 금액 */
.clover-amount {
    font-size: 30px;
    color: green;
    position: absolute;
    top: 0px;
    right: 49px;
}

/* 카테고리 탭 */
.nav-tabs {
    display: flex;
    justify-content: left;
    list-style: none;
    padding: 0;
    margin-bottom: 20px;
    margin-top: 40px;
    border-bottom: 1px solid #BAB9AA;
}

.nav-tabs li {
    padding: 5px 30px;
    cursor: pointer;
    font-size: 20px;
    color: black;
    transition: color 0.3s ease;
    border: 1px solid #BAB9AA;
    border-bottom: none;
    border-right: none;
    
}

.nav-tabs li:last-child{
    border-right:1px solid #BAB9AA;
}

.nav-tabs li.active {
    
    background-color: #e3e3e3;
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
}

.sort-buttons span {
    font-size: 18px;
    cursor: pointer;
    color: black;
    padding: 0 10px;
    border-left: 1px solid #BAB9AA;
}

.sort-buttons span:first-child {
    border-left: none;
}

.sort-buttons span.active {
    color: green;
}

.search button {
    padding: 5px 20px;
    background-color: #C0E5AF;
    border: none;
    color: white;
    cursor: pointer;
    border-radius: 10px;
    font-size: 18px;
}
/* 상품 목록 */
.items-container {
    display: grid;
    grid-template-columns: repeat(4, 1fr);
    gap: 20px;
    padding: 20px;
    border: 1px solid #BAB9AA;
    min-height: 300px;
}

.item {
    background-color: #FFF;
    border-radius: 10px;
    padding: 10px;
    box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
    text-align: center;
    border: 1px solid #BAB9AA;
}

.product-img {
    width: 165px;
    height: 130px;
    border-radius: 10px;
}

.clover-icon {
    width: 20px;
    height: 20px;
    margin-right: 5px;
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
.store-pagination {
    position: absolute;
    bottom: -12px; /* 하단에 고정 */
    left: 50%;
    transform: translateX(-50%);
    display: flex;
    justify-content: center;
    align-items: center;
    background-color: #C0E5AF;
    border-radius: 30px;
    padding: 1px 10px;
    gap: 5px;
}
.store-pagination span {
	padding: 10px;
	cursor: pointer;
}

.store-pagination span.active {
	color: red;
}

/* 팝업 */
.popup {
    position: fixed;
    top: 50%;
    left: 50%;
    transform: translate(-50%, -50%);
    background-color: white;
    padding: 20px;
    border-radius: 10px;
    box-shadow: 0 0 10px rgba(0, 0, 0, 0.5);
    text-align: center;
    z-index: 1000;
    display: flex;
    align-items: center;
}

.popup-image {
    width: 100px;
    height: 100px;
    border-radius: 10px;
    margin-right: 20px;
}

.popup-info {
    font-family: 'NanumTobak';
}

.popup-info h2 {
    font-size: 20px;
    margin: 0;
    margin-bottom: 10px;
}

.popup-info p {
    font-size: 16px;
    margin: 5px 0;
}

/* 배경 모자이크 효과를 위한 클래스 */
.mosaic-background {
    filter: blur(8px);
    transition: filter 0.3s ease;
}

.buylistItems {
    cursor: pointer;
    pointer-events: auto; /* 이 속성을 명시적으로 추가 */
}

</style>

<script type="text/javascript">

const storeItemsPerPage = 8; // 페이지당 8개 아이템
let currentStorePage = 1; // 현재 페이지
let currentStoreItems = []; // 현재 선택된 카테고리의 아이템들
let allStoreItems = []; // 전체 아이템 배열
let musicStoreItems = []; // 음악 아이템 배열
let characterStoreItems = []; // 캐릭터 아이템 배열
let backgroundStoreItems = []; // 배경 아이템 배열
let buylistStoreItems = []; // 구매목록 아이템 배열
let storeSortMode = 'default'; // 정렬 모드 ('default', 'popularity', 'price')
let storeSortOrder = 'desc'; // 정렬 순서 ('desc', 'asc')

// 카테고리 타입 변경 시 호출되는 함수
function changeStoreItemType(event, itemType) {
    // 모든 탭의 active 클래스 제거
    document.querySelectorAll('.nav-tabs li').forEach(tab => tab.classList.remove('active'));
    // 클릭된 탭에 active 클래스 추가
    event.target.classList.add('active');

    // 모든 아이템 컨테이너 숨기기
    document.querySelectorAll('.items-container').forEach(container => container.style.display = 'none');

    // 선택된 카테고리에 따라 items 배열을 설정하고 아이템 컨테이너 보이기
    if (itemType === 'all') {
        currentStoreItems = allStoreItems;
        document.getElementById("allItems").style.display = "grid";
    } else if (itemType === 'music') {
        currentStoreItems = musicStoreItems;
        document.getElementById("musicItems").style.display = "grid";
    } else if (itemType === 'character') {
        currentStoreItems = characterStoreItems;
        document.getElementById("characterItems").style.display = "grid";
    } else if (itemType === 'background') {
        currentStoreItems = backgroundStoreItems;
        document.getElementById("backgroundItems").style.display = "grid";
    } else if (itemType === 'buylist') {
        // 여기서 구매 목록을 클릭했을 때 서버에서 구매 목록을 가져오도록 처리
        loadBuylist();  // 구매 목록을 새로고침 없이 업데이트
        document.getElementById("buylistItems").style.display = "grid";
    }

    // 페이지 초기화 및 아이템 표시
    currentStorePage = 1;
    displayStoreItems(); // 아이템을 다시 렌더링
}

//정렬 모드를 변경하는 함수
function changeStoreSortMode(mode) {
    if (storeSortMode === mode) {
        // 같은 모드에서 다시 클릭하면 정렬 순서를 반대로 변경
        storeSortOrder = storeSortOrder === 'desc' ? 'asc' : 'desc';
    } else {
        // 새로운 모드로 변경하면 기본 순서로 설정
        storeSortMode = mode;
        storeSortOrder = 'desc';
    }
    applyStoreSort();
}

// 정렬을 적용하는 함수
function applyStoreSort() {
    if (storeSortMode === 'popularity') {
        // 인기순 정렬
        currentStoreItems.sort((a, b) => {
            const countA = parseInt(a.dataset.purchaseCount);
            const countB = parseInt(b.dataset.purchaseCount);
            return storeSortOrder === 'desc' ? countB - countA : countA - countB;
        });
    } else if (storeSortMode === 'price') {
        // 가격순 정렬
        currentStoreItems.sort((a, b) => {
            const priceA = parseInt(a.dataset.price);
            const priceB = parseInt(b.dataset.price);
            return storeSortOrder === 'desc' ? priceB - priceA : priceA - priceB;
        });
    }
    displayStoreItems();
}

// 페이지를 변경하는 함수
function changeStorePage(page) {
    currentStorePage = page;
    displayStoreItems();
}

//아이템을 화면에 보여주는 함수
function displayStoreItems() {
    const start = (currentStorePage - 1) * storeItemsPerPage;
    const end = start + storeItemsPerPage;
    const visibleItems = currentStoreItems.slice(start, end);

    // 현재 선택된 카테고리의 컨테이너를 명시적으로 설정
    let itemsContainer;
    if (currentStoreItems === allStoreItems) {
        itemsContainer = document.getElementById('allItems');
    } else if (currentStoreItems === musicStoreItems) {
        itemsContainer = document.getElementById('musicItems');
    } else if (currentStoreItems === characterStoreItems) {
        itemsContainer = document.getElementById('characterItems');
    } else if (currentStoreItems === backgroundStoreItems) {
        itemsContainer = document.getElementById('backgroundItems');
    } else if (currentStoreItems === buylistStoreItems) {  // 구매 목록 처리
        itemsContainer = document.getElementById('buylistItems');
    }

    itemsContainer.innerHTML = ''; // 기존 아이템 제거

    // 선택된 아이템들을 화면에 추가
    visibleItems.forEach(item => {
        itemsContainer.appendChild(item);
    });

    // 페이지네이션 업데이트
    updateStorePagination();
}

//페이지네이션 업데이트 함수
function updateStorePagination() {
    const totalPages = Math.ceil(currentStoreItems.length / storeItemsPerPage);
    const paginationContainer = document.querySelector('#store_pagination');
    paginationContainer.innerHTML = ''; // 기존 페이지네이션 제거

    for (let i = 1; i <= totalPages; i++) {
        const pageSpan = document.createElement('span');
        pageSpan.textContent = i;
        pageSpan.classList.toggle('active', i === currentStorePage); // 현재 페이지 강조
        pageSpan.onclick = () => changeStorePage(i);
        paginationContainer.appendChild(pageSpan);
    }
}

// DOM이 로드되면 초기화
document.addEventListener('DOMContentLoaded', function () {
    // 각 카테고리의 아이템을 올바르게 배열에 저장
    allStoreItems = Array.from(document.querySelectorAll('.allItems'));
    musicStoreItems = Array.from(document.querySelectorAll('.musicItems'));
    characterStoreItems = Array.from(document.querySelectorAll('.characterItems'));
    backgroundStoreItems = Array.from(document.querySelectorAll('.backgroundItems'));
    buylistStoreItems = Array.from(document.querySelectorAll('.buylistItems')); // 구매목록 클래스 기준으로 배열 저장

    // 기본적으로 전체 아이템을 선택하고 표시
    currentStoreItems = allStoreItems;
    displayStoreItems();  // 첫 로딩 시 전체 아이템을 표시
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

function buyStoreItem(itemNum, itemPrice, itemName, itemImage) {
    // 구매 확인 메시지 추가
    if (!confirm("정말로 구매하시겠습니까?")) {
        return; // 취소하면 함수 종료
    }

    console.log("Item Name: ", itemName);
    console.log("Item Image: ", itemImage);
    console.log("Item Price: ", itemPrice);

    if (<%= user_clover %> < itemPrice) {
        alert("클로버가 부족합니다.");
        return;
    }

    const xhr = new XMLHttpRequest();
    xhr.open("POST", "../pjh/buyItem.jsp", true);
    xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
    xhr.onreadystatechange = function() {
        if (xhr.readyState == 4 && xhr.status == 200) {
            if (xhr.responseText.trim() === 'SUCCESS') {
                // 구매 완료 팝업 표시
                showPurchaseCompletePopup(itemName, itemImage, itemPrice);

                // 클로버 잔액 UI 업데이트
                let currentClover = parseInt(document.querySelector('.clover-amount-span').innerText);
                currentClover -= itemPrice;
                document.querySelector('.clover-amount-span').innerText = currentClover;

                // 구매한 아이템을 구매 목록에 즉시 추가
                addToBuylist(itemNum, itemPrice, itemName, itemImage);
            } else if (xhr.responseText.trim() === 'NOT_ENOUGH_CLOVER') {
                alert("클로버가 부족합니다.");
            } else {
                alert("구매에 실패했습니다. 다시 시도해 주세요.");
            }
        }
    };
    xhr.send("item_num=" + itemNum + "&item_price=" + itemPrice);
}

function loadBuylist() {
    const xhr = new XMLHttpRequest();
    xhr.open("GET", "../pjh/loadBuylist.jsp", true);  // loadBuylist.jsp는 구매 목록을 불러오는 서버 스크립트
    xhr.onreadystatechange = function() {
        if (xhr.readyState == 4 && xhr.status == 200) {
            const buylistContainer = document.getElementById("buylistItems");
            buylistContainer.innerHTML = xhr.responseText;  // 구매 목록을 업데이트
            
            // 구매 목록 아이템을 배열로 저장 (페이징 처리를 위해)
            buylistStoreItems = Array.from(document.querySelectorAll('.buylistItems'));

            // 구매 목록을 페이지로 나눠서 보여줌
            currentStoreItems = buylistStoreItems; // 현재 카테고리를 구매 목록으로 설정
            displayStoreItems();  // 구매 목록 렌더링
        }
    };
    xhr.send();
}

function showPurchaseCompletePopup(itemName, itemImage, itemPrice) {
    console.log("Popup Item Name: ", itemName); // 이름 확인
    console.log("Popup Item Image: ", itemImage); // 이미지 경로 확인
    console.log("Popup Item Price: ", itemPrice); // 가격 확인

    // 페이지 전체에 모자이크 효과 적용
    document.querySelector('.storecontainer').classList.add('mosaic-background');

    const popupHTML = 
        '<div id="purchasePopup" class="popup">' +
            '<img src="' + itemImage + '" alt="' + itemName + '" class="popup-image" />' +
            '<div class="popup-info">' +
                '<h2>' + itemName + '</h2>' +
                '<p>클로버: ' + itemPrice + '개</p>' +
                '<p>구매가 완료되었습니다!</p>' +
            '</div>' +
        '</div>';
    document.body.insertAdjacentHTML('beforeend', popupHTML);

    // 팝업이 2초 후에 자동으로 사라지고 배경의 모자이크 효과를 제거
    setTimeout(() => {
        document.getElementById('purchasePopup').remove();
        // 배경에서 모자이크 효과 제거
        document.querySelector('.storecontainer').classList.remove('mosaic-background');
    }, 1000); // 2초 후에 팝업 제거 및 모자이크 해제
}

function refundStoreItem(itemNum, itemPrice) {
    console.log("환불 함수 호출됨:", itemNum, itemPrice);  // 이 부분을 추가해서 호출 여부 확인
    if (confirm("정말로 환불하시겠습니까?")) {
        // 환불 처리 AJAX 요청
        const xhr = new XMLHttpRequest();
        xhr.open("POST", "../pjh/refundItem.jsp", true);
        xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
        xhr.onreadystatechange = function() {
            if (xhr.readyState == 4 && xhr.status == 200) {
                if (xhr.responseText.trim() === 'SUCCESS') {
                    alert("환불이 완료되었습니다!");

                    // 클로버 잔액 업데이트
                    let currentClover = parseInt(document.querySelector('.clover-amount-span').innerText);
                    currentClover += itemPrice; // 환불된 클로버 금액 더하기
                    document.querySelector('.clover-amount-span').innerText = currentClover;

                    // 구매 목록을 즉시 업데이트
                    loadBuylist();  // 환불 후 즉시 구매 목록을 새로고침
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
			<span class="clover-amount-span">
			<%=user_clover%>
			</span>
			
			<!-- 여기서 클로버 값 출력 -->
		</div>

		<!-- 카테고리 탭 -->
		<ul class="nav-tabs">
			<li onclick="changeStoreItemType(event, 'all')" class="active">전체</li>
			<li onclick="changeStoreItemType(event, 'music')">음악</li>
			<li onclick="changeStoreItemType(event, 'character')">캐릭터</li>
			<li onclick="changeStoreItemType(event, 'background')">배경</li>
			<li onclick="changeStoreItemType(event, 'buylist')">구매목록</li>
			
		</ul>

		<!-- 인기순, 가격순 및 클로버 충전 -->
        <div class="sort-options">
            <div class="sort-buttons">
                <span onclick="changeStoreSortMode('popularity')">인기순</span>
                <span onclick="changeStoreSortMode('price')">가격순</span>
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
            <div class="allItems" data-purchase-count="<%= purchaseCount %>" data-price="<%=bean.getItem_price()%>" onclick="buyStoreItem(<%=bean.getItem_num()%>, <%=bean.getItem_price()%>, '<%=bean.getItem_name()%>', '<%=bean.getItem_image()%>')">
 <!-- 전체 아이템 클래스 -->
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
            <div class="musicItems" data-purchase-count="<%= purchaseCount %>" data-price="<%=bean.getItem_price()%>" onclick="buyStoreItem(<%=bean.getItem_num()%>, <%=bean.getItem_price()%>, '<%=bean.getItem_name()%>', '<%=bean.getItem_image()%>')"> <!-- 음악 아이템 클래스 -->
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
            <div class="characterItems" data-purchase-count="<%= purchaseCount %>" data-price="<%=bean.getItem_price()%>" onclick="buyStoreItem(<%=bean.getItem_num()%>, <%=bean.getItem_price()%>, '<%=bean.getItem_name()%>', '<%=bean.getItem_image()%>')"> <!-- 캐릭터 아이템 클래스 -->
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
            <div class="backgroundItems" data-purchase-count="<%= purchaseCount %>" data-price="<%=bean.getItem_price()%>" onclick="buyStoreItem(<%=bean.getItem_num()%>, <%=bean.getItem_price()%>, '<%=bean.getItem_name()%>', '<%=bean.getItem_image()%>')"> <!-- 배경 아이템 클래스 -->
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
    <div class="buylistItems" onclick="refundStoreItem(<%= rs.getInt("item_num") %>, <%= rs.getInt("item_price") %>)">
    <img src="<%= rs.getString("item_image") %>" alt="<%= rs.getString("item_name") %>" style="width:186px;height:145px;"/>
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
		<div style ="display:flex ; align-items:center">
		<div id ="store_pagination" class="store-pagination"></div>
		</div>
	</div>

</div>