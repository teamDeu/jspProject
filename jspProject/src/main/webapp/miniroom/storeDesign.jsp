<%@ page contentType="text/html; charset=UTF-8" %>
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
        }
        .item {
            background-color: #FFF;
            border-radius: 10px;
            padding: 10px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            text-align: center;
            border: 1px solid #ccc; /* 상품에 네모난 테두리 추가 */
        }
        .item img {
            width: 100%;
            height: 70%;
            border-radius: 10px;
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
        let items = []; // 모든 아이템을 담을 배열

        // 페이지를 바꾸는 함수
        function changePage(page) {
            currentPage = page;
            displayItems();
            updatePagination();
        }

        // 아이템을 보여주는 함수
        function displayItems() {
            const start = (currentPage - 1) * itemsPerPage;
            const end = start + itemsPerPage;
            const visibleItems = items.slice(start, end);

            const itemsContainer = document.getElementById('allItems');
            itemsContainer.innerHTML = ''; // 기존 아이템 제거

            visibleItems.forEach(item => {
                itemsContainer.appendChild(item);
            });
        }

        // 페이지네이션 업데이트 함수
        function updatePagination() {
            const totalPages = Math.ceil(items.length / itemsPerPage);
            const paginationContainer = document.querySelector('.pagination');
            paginationContainer.innerHTML = ''; // 기존 페이지네이션 제거

            for (let i = 1; i <= totalPages; i++) {
                const pageSpan = document.createElement('span');
                pageSpan.textContent = i;
                pageSpan.classList.toggle('active', i === currentPage);
                pageSpan.onclick = () => changePage(i);
                paginationContainer.appendChild(pageSpan);
            }
        }

       

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
    </script>
</head>
<div class="store">

    <div class="storecontainer">
        <!-- 상점 제목 -->
        <div class="store-title">상점</div>

        <!-- 클로버 금액 -->
        <div class="clover-amount">
            <img src="clover_icon.png" alt="클로버">
            20,000
        </div>

        <!-- 카테고리 탭 -->
        <ul class="nav-tabs">
            <li onclick="clickOpenType('allItems', this)" class="active">전체</li>
            <li onclick="clickOpenType('musicItems', this)">음악</li>
            <li onclick="clickOpenType('characterItems', this)">캐릭터</li>
            <li onclick="clickOpenType('backgroundItems', this)">배경</li>
        </ul>

        <!-- 인기순, 가격순 및 클로버 충전 -->
        <div class="sort-options">
            <div class="sort-buttons">
                <span class="active">인기순</span>
                <span>가격순</span>
            </div>
            <div class="search">
                <button onclick="window.open('pay.jsp', '_blank', )">클로버 충전</button>

            </div>
        </div>

        <!-- 전체상품목록 -->
        <div id="allItems" class="items-container">
            <div class="item">
                <img src="img/눈의꽃.jfif" alt="박효신">
                <div class="item-title">박효신 - 꽃</div>
                <div class="item-price">
                    <img src="clover_icon.png" alt="클로버"> 5개
                </div>
            </div>
            <div class="item">
                <img src="img/하루하루.jfif" alt="BIGBANG">
                <div class="item-title">BIGBANG - 하루 하루</div>
                <div class="item-price">
                    <img src="clover_icon.png" alt="클로버"> 5개
                </div>
            </div>
            <div class="item">
                <img src="img/프리스타일.jfif" alt="프리스타일">
                <div class="item-title">프리스타일 - Y</div>
                <div class="item-price">
                    <img src="clover_icon.png" alt="클로버"> 5개
                </div>
            </div>
            <div class="item">
                <img src="img/박봄.jfif" alt="박봄">
                <div class="item-title">박봄 - YOU AND I</div>
                <div class="item-price">
                    <img src="clover_icon.png" alt="클로버"> 5개
                </div>
            </div>
            <div class="item">
                <img src="img/죽일놈.jfif" alt="다이나믹듀오">
                <div class="item-title">다이나믹듀오 - 죽일놈</div>
                <div class="item-price">
                    <img src="clover_icon.png" alt="클로버"> 5개
                </div>
            </div>
            <div class="item">
                <img src="img/마법의성.jfif" alt="MC 스나이퍼">
                <div class="item-title">MC 스나이퍼 - 마법의 성</div>
                <div class="item-price">
                    <img src="clover_icon.png" alt="클로버"> 5개
                </div>
            </div>
            <div class="item">
                <img src="img/핑크배경.png" alt="배경 1">
                <div class="item-title">배경 1</div>
                <div class="item-price">
                    <img src="clover_icon.png" alt="클로버"> 5개
                </div>
            </div>
            <div class="item">
                <img src="img/backgroundImg.png" alt="배경 2">
                <div class="item-title">배경 2</div>
                <div class="item-price">
                    <img src="clover_icon.png" alt="클로버"> 5개
                </div>
            </div>
            <div class="item">
                <img src="img/backgroundImg22.png" alt="배경 3">
                <div class="item-title">배경 3</div>
                <div class="item-price">
                    <img src="clover_icon.png" alt="클로버"> 5개
                </div>
            </div>                        
            <div class="item">
                <img src="img/포차코.jfif" alt="포차코">
                <div class="item-title">포차코</div>
                <div class="item-price">
                    <img src="clover_icon.png" alt="클로버"> 7개
                </div>
            </div>
            <div class="item">
                <img src="img/마미미.png" alt="마미미">
                <div class="item-title">마미미</div>
                <div class="item-price">
                    <img src="clover_icon.png" alt="클로버"> 5개
                </div>
            </div>
    
        </div>

        <!-- 음악 상품 목록 -->
        <div id="musicItems" class="items-container" style="display: none;">
            <div class="item">
                <img src="img/눈의꽃.jfif" alt="박효신">
                <div class="item-title">박효신 - 꽃</div>
                <div class="item-price">
                    <img src="clover_icon.png" alt="클로버"> 5개
                </div>
            </div>
            <div class="item">
                <img src="img/하루하루.jfif" alt="BIGBANG">
                <div class="item-title">BIGBANG - 하루 하루</div>
                <div class="item-price">
                    <img src="clover_icon.png" alt="클로버"> 5개
                </div>
            </div>        
            <div class="item">
                <img src="img/프리스타일.jfif" alt="프리스타일">
                <div class="item-title">프리스타일 - Y</div>
                <div class="item-price">
                    <img src="clover_icon.png" alt="클로버"> 5개
                </div>
            </div>
            <div class="item">
                <img src="img/박봄.jfif" alt="박봄">
                <div class="item-title">박봄 - YOU AND I</div>
                <div class="item-price">
                    <img src="clover_icon.png" alt="클로버"> 5개
                </div>
            </div>
            <div class="item">
                <img src="img/죽일놈.jfif" alt="다이나믹듀오">
                <div class="item-title">다이나믹듀오 - 죽일놈</div>
                <div class="item-price">
                    <img src="clover_icon.png" alt="클로버"> 5개
                </div>
            </div>
            <div class="item">
                <img src="img/마법의성.jfif" alt="MC 스나이퍼">
                <div class="item-title">MC 스나이퍼 - 마법의 성</div>
                <div class="item-price">
                    <img src="clover_icon.png" alt="클로버"> 5개
                </div>
            </div>
        </div>

        <!-- 캐릭터 상품 목록 -->
        <div id="characterItems" class="items-container" style="display: none;">
            <div class="item">
                <img src="img/포차코.jfif" alt="포차코">
                <div class="item-title">포차코</div>
                <div class="item-price">
                    <img src="clover_icon.png" alt="클로버"> 7개
                </div>
            </div>
            <div class="item">
                <img src="img/마미미.png" alt="마미미">
                <div class="item-title">마미미</div>
                <div class="item-price">
                    <img src="clover_icon.png" alt="클로버"> 5개
                </div>
            </div>
        </div>

        <!-- 배경 상품 목록 -->
        <div id="backgroundItems" class="items-container" style="display: none;">
            <div class="item">
                <img src="img/핑크배경.png" alt="배경 1">
                <div class="item-title">배경 1</div>
                <div class="item-price">
                    <img src="clover_icon.png" alt="클로버"> 5개
                </div>
            </div>
            <div class="item">
                <img src="img/backgroundImg.png" alt="배경 2">
                <div class="item-title">배경 2</div>
                <div class="item-price">
                    <img src="clover_icon.png" alt="클로버"> 5개
                </div>
            </div>
            <div class="item">	
                <img src="img/backgroundImg22.png" alt="배경 3">
                <div class="item-title">배경 3</div>
                <div class="item-price">
                    <img src="clover_icon.png" alt="클로버"> 5개
                </div>
            </div>                        
        </div>

 <!-- 페이지네이션 -->
        <div class="pagination">
            <!-- 페이지 번호가 여기에 표시됩니다 -->
        </div>
    </div>

</div>
</html>
