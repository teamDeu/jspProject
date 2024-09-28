<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
            width: 800px;
            height: 2px;
            background-color: #BAB9AA;
            margin: 0 auto;
            position: relative;
            margin-top: 0;
            margin-bottom: 20px;
        }
        .game-title span {
            position: absolute;
            top: -40px;
            left: 0;
            font-size: 35px;
            color: #80A46F;
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
        /* 팝업창 스타일 */
        #popup {
            display: none;
            position: fixed;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
            width: 400px;
            height: 300px;
            background-color: white;
            border: 2px solid #BAB9AA;
            border-radius: 15px;
            text-align: center;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
            z-index: 100;
        }
        
        #popup-title {
		    font-size: 40px;
		    margin: 0;
		}
		
		#title-image {
		    margin-left: 10px;
		    width: 50px;
		    height: 50px;
		}

        #popup h2 {
            margin-top: 20px;
            font-size:40px;
        }

        #popup img {
            margin-top: 10px;
        }

        #popup button {
            margin-top: 20px;
            padding: 10px 20px;
            border-radius: 10px;
            border: 2px solid black;
            background-color: #FFFECC;
            font-size: 18px;
            cursor: pointer;
        }
		.popup-content {
		    display: flex;
		    justify-content: center;
		    align-items: center;
		    margin-top: 20px;
		    gap: 10px; /* 이미지와 배수 사이 간격 설정 */
		    font-size:40px;
		}
		
		.popup-image {
		    width: 60px;
		    height: 60px;
		}
		
		.popup-multiplier {
		    font-size: 40px;
		    font-weight: bold;
		}
    </style>
</head>
<body>

    <div style="text-align: center; margin-top: 50px;">
        <div class="game-title">
            <span>사다리게임</span>
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
                    <textarea class="input-box" id="betAmount" placeholder="배팅 금액" oninput="checkMaxValue(this)"></textarea>
                </div>
            </div>
        </div>
        <div id="popup">
		    <h2 id="popup-title"></h2>
		    <img id="popup-image" src="" alt="Popup Image" />
		    <div>
		        <span>배수: </span><span id="popup-multiplier"></span>
		    </div>
		    <div>
		        <span>총 금액: </span><span id="popup-total-amount"></span>
		    </div>
		    <button id="confirmButton">확인</button>
		</div>
    </div>
    
    <script>
        function generateLines() {
            const container = document.getElementById('gameContainer');
            const verticalLinePositions = [95, 250, 405, 560, 715]; 

            const fixedTops = [
                110, 200, 300, 400,
                130, 220, 320, 420,
                150, 240, 340, 440,
                170, 260, 360, 460
            ];

            const lineDistribution = [
                [0, 1, 2, 3],  
                [0, 2, 4, 6],  
                [1, 3, 5, 7],  
                [0, 2, 4, 6]   
            ];

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

        function startGame(buttonIndex) {
            const container = document.getElementById('gameContainer');
            const verticalLinePositions = [95, 250, 405, 560, 715]; 
            const horizontalLines = generateLines(); 

            let topPosition = 30; 
            let currentXPosition = verticalLinePositions[buttonIndex]; 
            let currentVerticalLineIndex = buttonIndex; 
            let isOnHorizontalLine = false; 
            let lastPassedLine = null; 

            const topImage = document.createElement('img');
            topImage.src = './img/character1.png'; 
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
                const betAmount = parseInt(document.getElementById('betAmount').value) || 0; // 배팅 금액 가져오기
                
                if (topPosition >= 510) { // 바닥에 도달하면 게임 종료
                    clearInterval(intervalId);
                    
                    if (currentVerticalLineIndex == 0 || currentVerticalLineIndex == 3) {
                        multiplier = 0;
                        showPopup("실패", "img/bomb.png", 0, betAmount * multiplier);
                    } else if (currentVerticalLineIndex == 1) {
                        multiplier = 3;
                        showPopup("당첨", "img/clover3.png", 3, betAmount * multiplier);
                    } else if (currentVerticalLineIndex == 2) {
                        multiplier = 2;
                        showPopup("당첨", "img/clover2.png", 2, betAmount * multiplier);
                    } else if (currentVerticalLineIndex == 4) {
                        multiplier = 1;
                        showPopup("당첨", "img/clover1.png", 1, betAmount * multiplier);
                    }
                    
                    topImage.remove();
                }
            }

            let intervalId = setInterval(moveDown, 20);
        }

        function showPopup(result, picture, multiplier, totalAmount) {
            const popup = document.getElementById('popup');
            const popupTitle = document.getElementById('popup-title');
            const popupImage = document.getElementById('popup-image');
            const popupMultiplier = document.getElementById('popup-multiplier');
            const popupTotalAmount = document.getElementById('popup-total-amount');

            popupTitle.textContent = result;
            popupImage.src = picture;
            popupMultiplier.textContent = multiplier;
            popupTotalAmount.textContent = totalAmount;

            popup.style.display = 'block';
        }

        document.getElementById('confirmButton').addEventListener('click', () => {
            document.getElementById('popup').style.display = 'none';
        });

    </script>

</body>
</html>
