<%@page import="java.util.HashMap"%>
<%@page import="guestbook.GuestbookprofileBean"%>
<%@page import="item.ItemBean"%>
<%@page import="java.util.Vector"%>
<%@ page import="java.sql.*, pjh.MemberBean, pjh.DBConnectionMgr"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false" %>
<%@ page import="java.sql.*, pjh.MemberBean, pjh.DBConnectionMgr"%>
<jsp:useBean id="mgr" class="pjh.MemberMgr" />
<jsp:useBean id="profileMgr" class="guestbook.GuestbookprofileMgr"/>
<%
String user_id = (String) session.getAttribute("idKey");
int user_clover = 0;

if (user_id != null) {
    try {
        // 사용자의 현재 클로버 잔액 가져오기
        user_clover = mgr.getCloverBalance(user_id);
    } catch (Exception e) {
        e.printStackTrace();
    }
}
GuestbookprofileBean profileBean = profileMgr.getProfileByUserId(user_id);
%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>사다리게임</title>
    <style>
        .wheel-container-wrapper {
            width: 700px;
            height: 500px;
            padding: 50px;
            margin: 0 auto;
            margin-bottom: 20px;
            border: 3px solid #BAB9AA;
            background-color: #f7f7f7;
            border-radius: 15px;
            position: relative;
        }
        .game-title {
            width: 830px; /* 줄 길이 */
            height: 1px;  /* 줄의 높이 */
            background-color: #BAB9AA;           
            position: relative;
            margin-top: 30px; /* 위쪽 여백 */
            margin-bottom: 10px; /* 줄과 사각형 사이에 공간 추가 */
        }
        .game-title span {
           color: #80A46F;
		   text-align: center;
		   font-weight: 600;
		   position: absolute;
		   top: -50px;
		   left: 0px;
		   font-size: 40px;
        }
        .long-box-container {
            display: flex;
            justify-content: space-between;
            align-items: center;
            gap: 200px;
            margin-top: -10px;
        }
        .long-box {
            width: 250px;
            height: 30px;
            background-color: white;
            border: 2px solid #BAB9AA;
            border-radius: 10px;
            display: flex;
            justify-content: center;
            align-items: center;
        }
        .long-box-with-image {
            display: flex;
            align-items: center;
            gap: 10px;
        }
        .box-image1 {
            width: 60px;
            height: 60px;
            object-fit: cover;
        }
        .input-box {
            width: 90%;
            height: 100%;
            border: none;
            resize: none;
            background-color: transparent;
            font-size: 24px;
            outline: none;
            text-align: center;
            display: flex;
            justify-content: center;
            align-items: center;
            padding: 5px;
        }
        .vertical-line {
            width: 5px;
            background-color: #BAB9AA;
            position: absolute;
            top: 100px;
            bottom: 100px;
        }
        .horizontal-line {
            height: 5px;
            background-color: #BAB9AA;
            position: absolute;
        }
        .button1-container {
            display: flex;
            justify-content: space-between;
            position: absolute;
            top: 30px;
            left: 50px;
            right: 50px;
        }
        .button1-container button {
            width: 85px;
            height: 60px;
            border: none;
            background-color: transparent;
        }
        .button1-container img {
            width: 100%;
            height: 100%;
            object-fit: cover;
        }
        .bottom1-image-container {
            display: flex;
            justify-content: space-between;
            position: absolute;
            bottom: 30px;
            left: 50px;
            right: 50px;
        }
        .bottom1-image-container img {
            width: 60px;
            height: 60px;
            object-fit: cover;
        }
        .game1-rules-box {
            display: flex;
            align-items: center;
            justify-content: space-between;
            width: 250px;
            height: 30px;
            background-color: white;
            border: 2px solid #BAB9AA;
            border-radius: 10px;
            padding: 5px 10px;
            position: relative;
            cursor: pointer;
            font-size: 30px;
        }
        .game1-clickable-box {
            width: 30px;
            height: 30px;
            background-color: #BAB9AA;
            display: flex;
            align-items: center;
            justify-content: center;
            cursor: pointer;
            border-radius: 5px;
            position: absolute;
            right: 10px;
            top: 5px;
        }
        .game1-triangle {
            width: 0;
            height: 0;
            border-left: 10px solid transparent;
            border-right: 10px solid transparent;
            border-bottom: 15px solid black;
            transition: transform 0.3s ease;
        }
        .game1-triangle.rotate {
            transform: rotate(180deg);
        }
        .game1-rules-detail {
            display: none;
            position: absolute;
            top: -326px;
            left: 0;
            width: 250px;
            height: 300px;
            background-color: white;
            border: 2px solid #BAB9AA;
            border-radius: 10px;
            padding: 10px;
        }
        .game1-rules-detail img {
            width: 230px;
            height: 280px;
            object-fit: cover;
            margin-bottom: 10px;
        }
        #popup1 {
            display: none;
            position: fixed;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
            width: 400px;
            height: 340px;
            background-color: white;
            border: 2px solid #BAB9AA;
            border-radius: 15px;
            text-align: center;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
            z-index: 100;
        }
        #popup-title1 {
            font-size: 40px;
            margin: 0;
        }
        #popup-image1 {
            margin-top: 10px;
        }
        #popup1 h21 {
            margin-top: 20px;
            font-size:40px;
        }
        #title-image1 {
            margin-left: 10px;
            width: 50px;
            height: 50px;
        }
        #popup1 img {
            margin-top: 10px;
        }
        #popup1 button {
            margin-top: 20px;
            padding: 10px 20px;
            border-radius: 10px;
            border: 2px solid black;
            background-color: #FFFECC;
            font-size: 18px;
            cursor: pointer;
        }
        .popup-content1 {
            display: flex;
            justify-content: center;
            align-items: center;
            margin-top: 20px;
            gap: 10px;
            font-size:40px;
        }
        .popup-image1 {
            width: 60px;
            height: 60px;
        }
        .popup-multiplier1 {
            font-size: 40px;
            font-weight: bold;
            
        }
        /* 클로버 금액 */
        .clover-amount1 {
            font-size: 30px;
            color: green;
            position: absolute;
            top: 30px;
            right: 56px;
        }
    </style>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
</head>
<body>

    <div style="text-align: center; margin-top: 50px;">
        <div class="game-title">
            <span>사다리게임</span>
        </div>
        <!-- 클로버 금액 -->
        <div class="clover-amount1">
            <img src="./img/clover_icon.png" alt="클로버">
            <span class="clover-amount-span" id="cloverAmountDisplay"><%=user_clover%></span>
        </div>
        
        <div class="wheel-container-wrapper" id="gameContainer">
            <div class="button1-container">
                <button onclick="startGame(0)"><img src="img/choice.png" alt="Button 1"></button>
                <button onclick="startGame(1)"><img src="img/choice.png" alt="Button 2"></button>
                <button onclick="startGame(2)"><img src="img/choice.png" alt="Button 3"></button>
                <button onclick="startGame(3)"><img src="img/choice.png" alt="Button 4"></button>
                <button onclick="startGame(4)"><img src="img/choice.png" alt="Button 5"></button>
            </div>

            <div class="vertical-line" style="left: 95px;"></div>
            <div class="vertical-line" style="left: 250px;"></div>
            <div class="vertical-line" style="left: 405px;"></div>
            <div class="vertical-line" style="left: 560px;"></div>
            <div class="vertical-line" style="left: 715px;"></div>

            <div class="bottom1-image-container">
                <img src="img/bomb.png" alt="Bottom Image 1">
                <img src="img/clover3.png" alt="Bottom Image 2">
                <img src="img/clover2.png" alt="Bottom Image 3">
                <img src="img/bomb.png" alt="Bottom Image 4">
                <img src="img/clover1.png" alt="Bottom Image 5">
            </div>
        </div>
        
        <div class="long-box-container">
            <div class="game1-rules-box">
                <span>게임 룰</span>
                <div class="game1-clickable-box">
                    <div class="game1-triangle"></div>
                </div>
                <div class="game1-rules-detail">
                    <img src="img/gamerule1.png" alt="New Image">
                </div>
            </div>

            <div class="long-box-with-image">
                <img src="img/clover1.png" alt="Sample Image" class="box-image1">
                <div class="long-box">
                    <textarea class="input-box" id="betAmount1" placeholder="배팅 금액" oninput="checkMaxValue(this)"></textarea>
                </div>
            </div>
        </div>
    </div>
    
    <div id="popup1">
        <div style="display: flex; align-items: center; justify-content: center;">
            <h2 id="popup-title1" style="font-size: 40px; margin: 0;">당첨</h2>
            <img id="title-image1" src="" alt="Title Image" class="title-image1">
        </div>
        <div class="popup-content">
            <img id="popup-image1" src="" alt="Winning Image" class="popup-image">
            <span class="popup-multiplier">x <span id="popup-multiplier1"></span></span>
        </div>
        <div style="display: flex; align-items: center; justify-content: center; gap: 10px; margin-top: 20px;">
            <img src="img/clover1.png" alt="Clover Image" style="width: 50px; height: 50px; object-fit: contain;">
            <div style="border: 2px solid #BAB9AA; border-radius: 10px; width: 100px; height: 30px; display: flex; align-items: center; justify-content: center;">
                <span id="popup-total-amount1" style="font-size: 30pt; line-height: 1;">0</span>
            </div>
        </div>

        <button id="confirm-button1">확인</button>
    </div>
    
    <script>
        function generateLines() {
            const container = document.getElementById('gameContainer');
            const verticalLinePositions = [95, 250, 405, 560, 715]; 
            const fixedTops = [110, 200, 300, 400, 130, 220, 320, 420, 150, 240, 340, 440, 170, 260, 360, 460];
            const lineDistribution = [[0, 1, 2, 3], [0, 2, 4, 6], [1, 3, 5, 7], [0, 2, 4, 6]];

            const existingLines = document.querySelectorAll('.horizontal-line');
            existingLines.forEach(line => line.remove());

            let counter = 0;
            const generatedLines = [];

            for (let j = 0; j < lineDistribution.length; j++) {
                const randomIndex = Math.floor(Math.random() * lineDistribution[j].length);
                const selectedTop = fixedTops[counter + randomIndex];
                
                const horizontalLine = document.createElement('div');
                horizontalLine.classList.add('horizontal-line');
                horizontalLine.style.top = selectedTop + 'px';
                horizontalLine.style.left = verticalLinePositions[j] + 'px';
                horizontalLine.style.width = (verticalLinePositions[j + 1] - verticalLinePositions[j]) + 'px';

                container.appendChild(horizontalLine);
                generatedLines.push({
                    top: selectedTop,
                    left: verticalLinePositions[j],
                    width: verticalLinePositions[j + 1] - verticalLinePositions[j]
                });
                counter += lineDistribution[j].length;
            }

            while (generatedLines.length < 10) {
                const randomIndex = Math.floor(Math.random() * fixedTops.length);
                if (!generatedLines.some(line => line.top === fixedTops[randomIndex])) { 
                    const j = Math.floor(randomIndex / 4); 
                    const horizontalLine = document.createElement('div');
                    horizontalLine.classList.add('horizontal-line');
                    horizontalLine.style.top = fixedTops[randomIndex] + 'px';
                    horizontalLine.style.left = verticalLinePositions[j] + 'px';
                    horizontalLine.style.width = (verticalLinePositions[j + 1] - verticalLinePositions[j]) + 'px';

                    container.appendChild(horizontalLine);
                    generatedLines.push({
                        top: fixedTops[randomIndex],
                        left: verticalLinePositions[j],
                        width: verticalLinePositions[j + 1] - verticalLinePositions[j]
                    });
                }
            }
            return generatedLines;
        }

        // 게임 시작 시 배팅 금액에 따른 클로버 잔액 차감 및 게임 진행
        function startGame(buttonIndex) {
            const betAmount = parseInt(document.getElementById('betAmount1').value) || 0;

            if (betAmount > 0) {
                // 클로버 차감 후 게임 시작
                $.ajax({
                    url: '../yang/updateClover.jsp',  // AJAX 요청 경로
                    type: 'POST',
                    data: {
                        userId: '<%= user_id %>',
                        cloverAmount: -betAmount  // 배팅 금액만큼 클로버 차감
                    },
                    success: function(response) {
                        const newCloverAmount = parseInt(response);
                        document.querySelectorAll('.clover-amount-span').forEach((e) => e.innerText = newCloverAmount);
   
                        // 사다리 게임 진행
                        playGame(buttonIndex);  // 클로버 업데이트 후 게임 진행
                    },
                    error: function() {
                        alert('클로버 잔액 업데이트 중 오류가 발생했습니다.');
                    }
                });
            } else {
                alert('배팅 금액을 입력하세요.');
            }
        }

        function playGame(buttonIndex) {
            const betAmount = parseInt(document.getElementById('betAmount1').value) || 0; // 배팅 금액

            if (betAmount <= 0) {
                alert('유효한 배팅 금액을 입력하세요.');
                return;
            }

            const container = document.getElementById('gameContainer');
            const verticalLinePositions = [95, 250, 405, 560, 715]; 
            const horizontalLines = generateLines(); 

            let topPosition = 30; 
            let currentXPosition = verticalLinePositions[buttonIndex]; 
            let currentVerticalLineIndex = buttonIndex; 
            let isOnHorizontalLine = false; 
            let lastPassedLine = null; 

            const topImage = document.createElement('img');
            topImage.src = "./<%=profileBean.getProfilePicture()%>"
            topImage.style.position = 'absolute';
            topImage.style.width = '60px'; 
            topImage.style.height = '60px';
            topImage.style.left = currentXPosition - 30 + 'px'; 
            topImage.style.top = (topPosition - 30) + 'px'; 
            container.appendChild(topImage);

            function moveDown() {
                topPosition += 5;
                topImage.style.top = (topPosition - 30) + 'px'; 

                horizontalLines.forEach((line) => {
                    const tolerance = 3; 
                    if (lastPassedLine !== line && topPosition >= line.top && topPosition <= line.top + 5 && Math.abs(currentXPosition - line.left) <= tolerance) {
                        isOnHorizontalLine = true; 
                        lastPassedLine = line; 
                        clearInterval(intervalId); 

                        let horizontalMoveId = setInterval(() => {
                            currentXPosition += 5; 
                            topImage.style.left = currentXPosition - 30 + 'px'; 

                            if (currentXPosition >= line.left + line.width) {
                                clearInterval(horizontalMoveId); 
                                currentVerticalLineIndex++;
                                isOnHorizontalLine = false; 
                                intervalId = setInterval(moveDown, 20); 
                            }
                        }, 20);
                    } else if (lastPassedLine !== line && topPosition >= line.top && topPosition <= line.top + 5 && Math.abs(currentXPosition - (line.left + line.width)) <= tolerance) {
                        isOnHorizontalLine = true; 
                        lastPassedLine = line; 
                        clearInterval(intervalId); 

                        let horizontalMoveId = setInterval(() => {
                            currentXPosition -= 5; 
                            topImage.style.left = currentXPosition - 30 + 'px'; 

                            if (currentXPosition <= line.left) {
                                clearInterval(horizontalMoveId); 
                                currentVerticalLineIndex--;
                                isOnHorizontalLine = false; 
                                intervalId = setInterval(moveDown, 20); 
                            }
                        }, 20);
                    }
                });

                let multiplier = 0;

                // 게임이 끝났을 때 승리 여부에 따른 multiplier 설정
                if (topPosition >= 510) {
                    clearInterval(intervalId);

                    if (currentVerticalLineIndex == 0 || currentVerticalLineIndex == 3) {
                        multiplier = 0;
                        showPopup1("실패", "img/bomb.png", 0, betAmount * multiplier);
                    } else if (currentVerticalLineIndex == 1) {
                        multiplier = 3;
                        showPopup1("당첨", "img/clover3.png", 3, betAmount * multiplier);
                    } else if (currentVerticalLineIndex == 2) {
                        multiplier = 2;
                        showPopup1("당첨", "img/clover2.png", 2, betAmount * multiplier);
                    } else if (currentVerticalLineIndex == 4) {
                        multiplier = 1;
                        showPopup1("당첨", "img/clover1.png", 1, betAmount * multiplier);
                    }

                    topImage.remove();
                }
            }

            let intervalId = setInterval(moveDown, 20);
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
                    const currentCloverAmount = parseInt($('#cloverAmountDisplay').text()) || 0;

                    // 서버에서 받은 클로버 값이 현재 화면에 표시된 값과 다를 경우 업데이트
                    if (serverCloverAmount !== currentCloverAmount) {
                        document.querySelectorAll('.clover-amount-span').forEach((e) => e.innerText = currentCloverAmount);
                    }
                },
                error: function() {
                    console.log('서버에서 클로버 잔액을 가져오는 중 오류가 발생했습니다.');
                }
            });
        }

        // 1초마다 서버에서 클로버 값을 가져와 화면에 반영
        setInterval(updateCloverAmountFromServer, 1000);


        function showPopup1(result, picture, multiplier, totalAmount) {
            const popup = document.getElementById('popup1');
            const popupTitle = document.getElementById('popup-title1');
            const popupImage = document.getElementById('popup-image1');
            const popupMultiplier = document.getElementById('popup-multiplier1');
            const popupTotalAmount = document.getElementById('popup-total-amount1');
            const titleImage1 = document.getElementById('title-image1');

            if (result === "당첨") {
                titleImage1.src = "img/wow.png";
            } else if (result === "실패") {
                titleImage1.src = "img/sad.png";
            }

            popupTitle.textContent = result;
            popupImage.src = picture;
            popupMultiplier.textContent = multiplier;

            // totalAmount가 NaN일 경우 0으로 처리
            const validTotalAmount = Number.isNaN(totalAmount) ? 0 : totalAmount;
            popupTotalAmount.textContent = validTotalAmount;

            popup.style.display = 'block';

            // 확인 버튼에 이벤트 중복 등록 방지
            $('#confirm-button1').off('click').on('click', function () {
                // 팝업창 닫기
                popup.style.display = 'none';

                // totalAmount를 클로버 잔액에 더하기
                const currentCloverAmount = parseInt($('#cloverAmountDisplay').text()) || 0;
                const newCloverAmount = currentCloverAmount + validTotalAmount;

                // 클라이언트 화면에 클로버 잔액 업데이트
                    document.querySelectorAll('.clover-amount-span').forEach((e) => e.innerText = newCloverAmount);

                // 서버에 클로버 잔액 업데이트 요청
                if (validTotalAmount > 0) {
                    $.ajax({
                        url: '../yang/updateClover.jsp',  // 클로버 업데이트 경로
                        type: 'POST',
                        data: {
                            userId: '<%= user_id %>',
                            cloverAmount: validTotalAmount  // 승리 금액 더하기
                        },
                        success: function(response) {
                            const updatedCloverAmount = parseInt(response);
                            document.querySelectorAll('.clover-amount-span').forEach((e) => e.innerText = updatedCloverAmount);
                        },
                        error: function() {
                            alert('클로버 잔액 업데이트 중 오류가 발생했습니다.');
                        }
                    });
                }

                // 팝업 닫기
                popup.style.display = 'none';
            });
        }
        
        document.querySelector('.game1-clickable-box').addEventListener('click', function() {
            const detailBox = document.querySelector('.game1-rules-detail');
            const triangle = document.querySelector('.game1-triangle');
            if (detailBox.style.display === 'none' || !detailBox.style.display) {
                detailBox.style.display = 'block';
                triangle.classList.add('rotate');
            } else {
                detailBox.style.display = 'none';
                triangle.classList.remove('rotate');
            }
        });

        document.addEventListener("DOMContentLoaded", function () {
            document.getElementById('confirm-button1').addEventListener('click', () => {
                document.getElementById('popup1').style.display = 'none';
                
                // 가로줄을 모두 제거하여 세로줄만 남기기
                const horizontalLines = document.querySelectorAll('.horizontal-line');
                horizontalLines.forEach(line => line.remove());
            });
        });
    </script>

</body>
</html>
