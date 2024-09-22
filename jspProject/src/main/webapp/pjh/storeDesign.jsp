<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>스토어</title>
    <style>
        body {
            font-family: 'Nanum Gothic', sans-serif;
            background-color: #F5F5F5;
            text-align: center;
        }
        .container {
            width: 90%;
            margin: 0 auto;
        }
        .header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 20px;
        }
        .header .balance {
            font-size: 20px;
            color: green;
        }
        .store-title {
            font-size: 24px;
            color: black;
            font-weight: bold;
            margin-bottom: 10px;
        }
        .nav-tabs {
            display: flex;
            justify-content: center;
            list-style: none;
            padding: 0;
            margin-top: 10px;
            margin-bottom: 20px;
        }
        .nav-tabs li {
            padding: 10px 30px;
            cursor: pointer;
            font-size: 18px;
            border-bottom: 2px solid transparent;
            color: gray;
        }
        .nav-tabs li.active {
            color: black;
            border-bottom: 2px solid green;
        }
        .items-container {
            display: grid;
            grid-template-columns: repeat(4, 1fr);
            gap: 20px;
            padding: 20px;
        }
        .item {
            background-color: #FFF;
            border-radius: 10px;
            padding: 10px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }
        .item img {
            width: 100%;
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
        /* 인기순, 가격순 버튼 스타일 */
        .sort-buttons {
            display: flex;
            justify-content: flex-end;
            align-items: center;
            gap: 20px;
            margin-bottom: 20px;
        }
        .sort-buttons button {
            padding: 10px 20px;
            background-color: #EEE;
            border: none;
            cursor: pointer;
            font-size: 16px;
        }
        .sort-buttons button.active {
            background-color: #90EE90;
            color: white;
        }
    </style>
</head>
<body>

<div class="container">
    <!-- 상점 제목 -->
    <div class="store-title">상점</div>

    <!-- 탭 메뉴 -->
    <ul class="nav-tabs">
        <li class="active">전체</li>
        <li>음악</li>
        <li>캐릭터</li>
        <li>배경</li>
    </ul>

    <!-- 인기순, 가격순 및 클로버 충전 -->
    <div class="header">
        <div class="sort-buttons">
            <button class="active">인기순</button>
            <button>가격순</button>
        </div>
        <div class="search">
            <button>클로버 충전</button>
        </div>
    </div>

    <!-- 상품 목록 -->
    <div class="items-container">
        <div class="item">
            <img src="박효신.jpg" alt="박효신">
            <div class="item-title">박효신 - 꽃</div>
            <div class="item-price">
                <img src="clover_icon.png" alt="클로버">
                5개
            </div>
        </div>
        <div class="item">
            <img src="bigbang.jpg" alt="BIGBANG">
            <div class="item-title">BIGBANG - 하루 하루</div>
            <div class="item-price">
                <img src="clover_icon.png" alt="클로버">
                5개
            </div>
        </div>
        <div class="item">
            <img src="프리스타일.jpg" alt="프리스타일">
            <div class="item-title">프리스타일 - Y</div>
            <div class="item-price">
                <img src="clover_icon.png" alt="클로버">
                5개
            </div>
        </div>
        <div class="item">
            <img src="박봄.jpg" alt="박봄">
            <div class="item-title">박봄 - YOU AND I</div>
            <div class="item-price">
                <img src="clover_icon.png" alt="클로버">
                5개
            </div>
        </div>
        <div class="item">
            <img src="다이나믹듀오.jpg" alt="다이나믹듀오">
            <div class="item-title">다이나믹듀오 - 죽일놈</div>
            <div class="item-price">
                <img src="clover_icon.png" alt="클로버">
                5개
            </div>
        </div>
        <div class="item">
            <img src="mc스나이퍼.jpg" alt="MC 스나이퍼">
            <div class="item-title">MC 스나이퍼 - 마법의 성</div>
            <div class="item-price">
                <img src="clover_icon.png" alt="클로버">
                5개
            </div>
        </div>
        <div class="item">
            <img src="핑크배경.jpg" alt="핑크 배경">
            <div class="item-title">핑크 배경</div>
            <div class="item-price">
                <img src="clover_icon.png" alt="클로버">
                5개
            </div>
        </div>
        <div class="item">
            <img src="포차코.jpg" alt="포차코">
            <div class="item-title">포차코</div>
            <div class="item-price">
                <img src="clover_icon.png" alt="클로버">
                7개
            </div>
        </div>
        <div class="item">
            <img src="마미미.jpg" alt="마미미">
            <div class="item-title">마미미</div>
            <div class="item-price">
                <img src="clover_icon.png" alt="클로버">
                5개
            </div>
        </div>
    </div>

    <!-- 페이지네이션 -->
    <div class="pagination">
        <span class="active">1</span>
        <span>2</span>
        <span>3</span>
        <span>4</span>
    </div>
</div>

</body>
</html>
