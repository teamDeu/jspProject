<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.sql.*, pjh.DBConnectionMgr, pjh.MemberBean" %>

<%
    // 로그인된 사용자 정보 가져오기 (세션에서)
    MemberBean member = (MemberBean) session.getAttribute("loggedInUser");

    int userClover = 0; // 기본 클로버 값
    String userId = "";

    // 세션에서 사용자 정보가 존재하는 경우
    if (member != null) {
        userClover = member.getUser_clover(); // 사용자의 클로버 값을 가져옴
        userId = member.getUser_id();  // 사용자 ID도 가져옴
    } else {
        // 사용자 정보가 없으면 로그인 페이지로 이동
        response.sendRedirect("login.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>Clover Recharge</title>
    <style>
        /* 기존 스타일 유지 */
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
            justify-content: space-between;
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
        // 클로버 수량 증가 함수
        function increment(inputId, priceId) {
            var input = document.getElementById(inputId);
            input.value = parseInt(input.value) + 1;
            updatePrice(inputId, priceId);
        }

        // 클로버 수량 감소 함수
        function decrement(inputId, priceId) {
            var input = document.getElementById(inputId);
            if (parseInt(input.value) > 1) {
                input.value = parseInt(input.value) - 1;
                updatePrice(inputId, priceId);
            }
        }

        // 클로버 수량에 따른 가격 업데이트 함수
        function updatePrice(inputId, priceId) {
            var input = document.getElementById(inputId);
            var basePrice = parseInt(document.getElementById(priceId).getAttribute('data-base-price'));
            var newPrice = basePrice * parseInt(input.value);
            document.getElementById(priceId).textContent = newPrice + '원';
        }

        // 결제 처리 함수
        function submitForm(cloverAmount, inputId) {
            var form = document.createElement("form");
            form.method = "POST";
            form.action = "pay.jsp"; // 결제 페이지로 POST 요청

            // 총 가격 계산
            var quantity = parseInt(document.getElementById(inputId).value);
            var totalPrice = cloverAmount * quantity;

            // 세션에서 user_id 가져오기
            var userId = "<%= userId %>";

            // Form에 전송할 데이터 추가
            var hiddenFields = [
                { name: "cloverAmount", value: cloverAmount },
                { name: "quantity", value: quantity },
                { name: "totalPrice", value: totalPrice },
                { name: "user_id", value: userId }  // 사용자 아이디 추가
            ];

            hiddenFields.forEach(function (field) {
                var input = document.createElement("input");
                input.type = "hidden";
                input.name = field.name;
                input.value = field.value;
                form.appendChild(input);
            });

            document.body.appendChild(form);
            form.submit(); // Form 전송
        }
    </script>

</head>
<body>
<div class="container">
    <div class="header">
        <div class="recharge-title">클로버 충전</div> 
        <div class="balance">🍀 <%= userClover %></div> <!-- DB에서 가져온 클로버 잔액 표시 -->
    </div>

    <div class="item-grid">
        <%-- Item 1 --%>
        <div class="item">
            <div class="clover-count">🍀 10개</div>
            <div class="price" id="price1" data-base-price="10">10원</div>
            <div class="quantity-selector">
                <button onclick="decrement('quantity1', 'price1')">-</button>
                <input type="text" id="quantity1" value="1" readonly>
                <button onclick="increment('quantity1', 'price1')">+</button>
            </div>
            <button class="pay-btn" onclick="submitForm(10, 'quantity1')">결제하기</button>
        </div>

        <%-- Item 2 --%>
        <div class="item">
            <div class="clover-count">🍀 100개</div>
            <div class="price" id="price2" data-base-price="100">100원</div>
            <div class="quantity-selector">
                <button onclick="decrement('quantity2', 'price2')">-</button>
                <input type="text" id="quantity2" value="1" readonly>
                <button onclick="increment('quantity2', 'price2')">+</button>
            </div>
            <button class="pay-btn" onclick="submitForm(100, 'quantity2')">결제하기</button>
        </div>

        <%-- Item 3 --%>
        <div class="item">
            <div class="clover-count">🍀 500개</div>
            <div class="price" id="price3" data-base-price="500">500원</div>
            <div class="quantity-selector">
                <button onclick="decrement('quantity3', 'price3')">-</button>
                <input type="text" id="quantity3" value="1" readonly>
                <button onclick="increment('quantity3', 'price3')">+</button>
            </div>
            <button class="pay-btn" onclick="submitForm(500, 'quantity3')">결제하기</button>
        </div>

        <%-- Item 4 --%>
        <div class="item">
            <div class="clover-count">🍀 1,000개</div>
            <div class="price" id="price4" data-base-price="1000">1,000원</div>
            <div class="quantity-selector">
                <button onclick="decrement('quantity4', 'price4')">-</button>
                <input type="text" id="quantity4" value="1" readonly>
                <button onclick="increment('quantity4', 'price4')">+</button>
            </div>
            <button class="pay-btn" onclick="submitForm(1000, 'quantity4')">결제하기</button>
        </div>

        <%-- Item 5 --%>
        <div class="item">
            <div class="clover-count">🍀 5,000개</div>
            <div class="price" id="price5" data-base-price="5000">5,000원</div>
            <div class="quantity-selector">
                <button onclick="decrement('quantity5', 'price5')">-</button>
                <input type="text" id="quantity5" value="1" readonly>
                <button onclick="increment('quantity5', 'price5')">+</button>
            </div>
            <button class="pay-btn" onclick="submitForm(5000, 'quantity5')">결제하기</button>
        </div>

        <%-- Item 6 --%>
        <div class="item">
            <div class="clover-count">🍀 10,000개</div>
            <div class="price" id="price6" data-base-price="10000">10,000원</div>
            <div class="quantity-selector">
                <button onclick="decrement('quantity6', 'price6')">-</button>
                <input type="text" id="quantity6" value="1" readonly>
                <button onclick="increment('quantity6', 'price6')">+</button>
            </div>
            <button class="pay-btn" onclick="submitForm(10000, 'quantity6')">결제하기</button>
        </div>
    </div>
</div>
</body>
</html>
