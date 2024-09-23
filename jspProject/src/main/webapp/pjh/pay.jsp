<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>Clover Recharge</title>
    <style>
        @font-face {
            font-family: 'NanumTobak';
            src: url('나눔손글씨 또박또박.TTF') format('truetype');
        }
        .container {
            width: 30%;
            margin: 0 auto;
            text-align: center;
        }
        .header {
            display: flex;
            justify-content: space-between; /* 양쪽 정렬을 위해 사용 */
            align-items: center;
            margin: 20px 0;
            font-family: 'NanumTobak';
        }
        .balance {
            font-size: 18px;
            font-family: 'NanumTobak';
        }
        .recharge-title {
            font-size: 18px;
            font-family: 'NanumTobak';
            font-weight: bold;
        }
        .item-grid {
            display: grid;
            grid-template-columns: repeat(3, 1fr);
            gap: 20px;
        }
        .item {
            border: 1px solid #ccc;
            border-radius: 10px;
            padding: 20px;
            background-color: #f8f8f8;
            box-shadow: 0 2px 8px rgba(0,0,0,0.1);
        }
        .clover-count {
            font-size: 24px;
            margin-bottom: 10px;
            font-family: 'NanumTobak';
        }
        .price {
            color: #888;
            font-size: 24px;
            margin-bottom: 10px;
            font-family: 'NanumTobak';
        }
        .quantity-selector {
            display: flex;
            justify-content: center;
            align-items: center;
            margin-bottom: 10px;
            background-color: #F8F6E3;
            border-radius: 5px;
        }
        .quantity-selector button {
            background-color: #F8F6E3;
            border: none;
            padding: 5px;
            cursor: pointer;
            font-size: 18px;
            font-family: 'NanumTobak';
        }
        .quantity-selector input {
            width: 40px;
            text-align: center;
            border: none;
            background-color: #F8F6E3;
            font-size: 18px;
            font-family: 'NanumTobak';
        }
        .pay-btn {
            width: 140px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-family: 'NanumTobak';
            font-size: 18px;
            background-color: #FFFFFF;
        }
    </style>

    <script>
        // 함수: 숫자를 증가
        function increment(inputId) {
            var input = document.getElementById(inputId);
            input.value = parseInt(input.value) + 1;
        }

        // 함수: 숫자를 감소
        function decrement(inputId) {
            var input = document.getElementById(inputId);
            if (parseInt(input.value) > 1) {
                input.value = parseInt(input.value) - 1;
            }
        }
    </script>

</head>
<body>
<div class="container">
    <div class="header">
        <div class="recharge-title">클로버 충전</div> <!-- 왼쪽 상단에 클로버 충전 추가 -->
        <div class="balance">🍀 20,000</div> <!-- 오른쪽 잔액 표시 -->
    </div>

    <div class="item-grid">
        <%-- Item 1 --%>
        <div class="item">
            <div class="clover-count">🍀 10개</div>
            <div class="price">4,900원</div>
            <div class="quantity-selector">
                <button onclick="decrement('quantity1')">-</button>
                <input type="text" id="quantity1" value="1" readonly>
                <button onclick="increment('quantity1')">+</button>
            </div>
            <button class="pay-btn">결제하기</button>
        </div>

        <%-- Item 2 --%>
        <div class="item">
            <div class="clover-count">🍀 100개</div>
            <div class="price">49,000원</div>
            <div class="quantity-selector">
                <button onclick="decrement('quantity2')">-</button>
                <input type="text" id="quantity2" value="1" readonly>
                <button onclick="increment('quantity2')">+</button>
            </div>
            <button class="pay-btn">결제하기</button>
        </div>

        <%-- Item 3 --%>
        <div class="item">
            <div class="clover-count">🍀 500개</div>
            <div class="price">239,000원</div>
            <div class="quantity-selector">
                <button onclick="decrement('quantity3')">-</button>
                <input type="text" id="quantity3" value="1" readonly>
                <button onclick="increment('quantity3')">+</button>
            </div>
            <button class="pay-btn">결제하기</button>
        </div>

        <%-- Item 4 --%>
        <div class="item">
            <div class="clover-count">🍀 1,000개</div>
            <div class="price">469,000원</div>
            <div class="quantity-selector">
                <button onclick="decrement('quantity4')">-</button>
                <input type="text" id="quantity4" value="1" readonly>
                <button onclick="increment('quantity4')">+</button>
            </div>
            <button class="pay-btn">결제하기</button>
        </div>

        <%-- Item 5 --%>
        <div class="item">
            <div class="clover-count">🍀 5,000개</div>
            <div class="price">2,290,000원</div>
            <div class="quantity-selector">
                <button onclick="decrement('quantity5')">-</button>
                <input type="text" id="quantity5" value="1" readonly>
                <button onclick="increment('quantity5')">+</button>
            </div>
            <button class="pay-btn">결제하기</button>
        </div>

        <%-- Item 6 --%>
        <div class="item">
            <div class="clover-count">🍀 10,000개</div>
            <div class="price">4,590,000원</div>
            <div class="quantity-selector">
                <button onclick="decrement('quantity6')">-</button>
                <input type="text" id="quantity6" value="1" readonly>
                <button onclick="increment('quantity6')">+</button>
            </div>
            <button class="pay-btn">결제하기</button>
        </div>
    </div>
</div>
</body>
</html>
