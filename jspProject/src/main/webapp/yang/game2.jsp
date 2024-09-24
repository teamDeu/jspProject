<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>돌림판게임</title>
    <style>
        .wheel-container-wrapper {
            width: 700px;
            padding: 50px;
            margin: 0 auto;
            margin-bottom: 20px;
            border: 3px solid #BAB9AA;
            background-color: #f7f7f7;
            border-radius: 15px;
        }

        .wheel-container {
            position: relative;
            width: 500px;
            height: 500px;
            margin: 0 auto;
        }

        #wheel {
            width: 100%;
            height: 100%;
            border-radius: 50%;
            border: 2px solid #333;
            box-shadow: 0px 0px 10px #f7f7f7;
            cursor: pointer;
        }

        .pointer {
            position: absolute;
            top: -30px;
            left: 50%;
            width: 0;
            height: 0;
            border-left: 20px solid transparent;
            border-right: 20px solid transparent;
            border-top: 40px solid red;
            transform: translateX(-50%);
            border-radius: 5px;
        }

        #start-button {
            position: absolute;
            top: 50%;
            left: 50%;
            width: 100px;
            height: 100px;
            border-radius: 50%;
            background-color: #FFFECC;
            color: red;
            font-weight: bold;
            font-size: 30px;
            display: flex;
            align-items: center;
            justify-content: center;
            transform: translate(-50%, -50%);
            cursor: pointer;
            border: 2px solid black;
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

        .game-rules-box {
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

        .clickable-box {
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

        .triangle {
            width: 0;
            height: 0;
            border-left: 10px solid transparent;
            border-right: 10px solid transparent;
            border-bottom: 15px solid black;
            transition: transform 0.3s ease;
        }

        .triangle.rotate {
            transform: rotate(180deg);
        }

        .game-rules-detail {
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

        .game-rules-detail img {
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
            <span>돌림판게임</span>
        </div>

        <div class="wheel-container-wrapper">
            <div class="wheel-container">
                <canvas id="wheel" width="400" height="400"></canvas>
                <div class="pointer"></div>
                <div id="start-button">START</div>
            </div>
        </div>

        <div class="long-box-container">
            <div class="game-rules-box">
                <span>게임 룰</span>
                <div class="clickable-box">
                    <div class="triangle"></div>
                </div>
                <div class="game-rules-detail">
                    <img src="img/gamerule.png" alt="New Image">
                </div>
            </div>

            <div class="long-box-with-image">
                <img src="img/clover1.png" alt="Sample Image" class="box-image1">
                <div class="long-box">
                    <textarea class="input-box" id="betAmount" placeholder="배팅 금액"></textarea>
                </div>
            </div>
        </div>
    </div>

	<div id="popup">
	    <h2 id="popup-title"></h2>
	    <div class="popup-content">
	        <img id="popup-image" src="" alt="Winning Image" class="popup-image">
	        <span class="popup-multiplier">x <span id="popup-multiplier"></span></span>
	    </div>
	    <div style="display: flex; align-items: center; justify-content: center; gap: 10px; margin-top: 20px;">
	        <img src="img/clover1.png" alt="Clover Image" style="width: 50px; height: 50px;">
	        <div style="border: 2px solid #BAB9AA; border-radius: 10px; width: 100px; height: 30px; display: flex; align-items: center; justify-content: center;">
	            <span id="popup-total-amount" style="font-size : 30pt;"></span>
	        </div>
	    </div>
	    <button id="confirm-button">확인</button>
	</div>

    <script>
        const wheelCanvas = document.getElementById('wheel');
        const ctx = wheelCanvas.getContext('2d');
        const startButton = document.getElementById('start-button');
        const betAmountInput = document.getElementById('betAmount');

        const clickableBox = document.querySelector(".clickable-box");
        const gameRulesDetail = document.querySelector(".game-rules-detail");

        const popup = document.getElementById('popup');
        const popupTitle = document.getElementById('popup-title');
        const popupImage = document.getElementById('popup-image');
        const popupMultiplier = document.getElementById('popup-multiplier');
        const popupTotalAmount = document.getElementById('popup-total-amount');
        const confirmButton = document.getElementById('confirm-button');

        let isSpinning = false;
        let currentAngle = 0;
        let spinSpeed = 0;

        const images = [
            "img/bomb.png",
            "img/clover1.png",
            "img/clover3.png",
            "img/bomb.png",
            "img/clover2.png",
            "img/clover1.png",
            "img/bomb.png",
            "img/clover2.png"
        ];
        const numSegments = images.length;
        const segmentAngle = (2 * Math.PI) / numSegments;
        const colors = ['#FEFFF5', '#FFDDC1', '#FEFFF5', '#FFDDC1', '#FEFFF5', '#FFDDC1', '#FEFFF5', '#FFDDC1'];
        let loadedImages = [];

        function loadImages(callback) {
            let loadedCount = 0;
            for (let i = 0; i < images.length; i++) {
                const img = new Image();
                img.src = images[i];
                img.onload = () => {
                    loadedImages[i] = img;
                    loadedCount++;
                    if (loadedCount === images.length) {
                        callback();
                    }
                };
                img.onerror = () => {
                    console.error("Image failed to load:", images[i]);
                    loadedImages[i] = null;
                    loadedCount++;
                    if (loadedCount === images.length) {
                        callback();
                    }
                };
            }
        }

        function drawWheel() {
            for (let i = 0; i < numSegments; i++) {
                ctx.beginPath();
                ctx.moveTo(200, 200);
                ctx.arc(200, 200, 200, i * segmentAngle, (i + 1) * segmentAngle);
                ctx.fillStyle = colors[i];
                ctx.fill();
                ctx.stroke();
                ctx.save();

                ctx.translate(200, 200);
                ctx.rotate((i + 0.5) * segmentAngle);
                if (loadedImages[i]) {
                    ctx.drawImage(loadedImages[i], 100, -35, 75, 75);
                } else {
                    ctx.fillStyle = 'black';
                    ctx.font = '14px Arial';
                    ctx.fillText('NO IMG', 100, 5);
                }
                ctx.restore();
            }
        }

        function rotateWheel() {
            currentAngle += spinSpeed;
            spinSpeed *= 0.98;
            ctx.clearRect(0, 0, 400, 400);
            ctx.save();
            ctx.translate(200, 200);
            ctx.rotate(currentAngle);
            ctx.translate(-200, -200);
            drawWheel();
            ctx.restore();

            if (spinSpeed > 0.01) {
                requestAnimationFrame(rotateWheel);
            } else {
                isSpinning = false;

                const normalizedAngle = (currentAngle % (2 * Math.PI));
                const correctedAngle = (2 * Math.PI - normalizedAngle - Math.PI / 2) % (2 * Math.PI);
                let winningSegment = Math.floor((correctedAngle / segmentAngle) % numSegments);

                if (winningSegment < 0) {
                    winningSegment += numSegments;
                }

                let betAmount = parseInt(betAmountInput.value) || 0;
                let multiplier = 0;
                let picture;
                let result;

                if (images[winningSegment] === "img/bomb.png") {
                    multiplier = 0;
                    picture = "img/bomb.png";
                    result = "실패";
                } else if (images[winningSegment] === "img/clover1.png") {
                    multiplier = 1;
                    picture = "img/clover1.png";
                    result = "당첨";
                } else if (images[winningSegment] === "img/clover2.png") {
                    multiplier = 2;
                    picture = "img/clover2.png";
                    result = "당첨";
                } else if (images[winningSegment] === "img/clover3.png") {
                    multiplier = 3;
                    picture = "img/clover3.png";
                    result = "당첨";
                }

                let totalAmount = betAmount * multiplier;

                showPopup(result, picture, multiplier, totalAmount);
            }
        }

        startButton.addEventListener('click', () => {
            if (!isSpinning) {
                isSpinning = true;
                spinSpeed = Math.random() * 0.5 + 0.2;
                rotateWheel();
            }
        });

        loadImages(() => {
            drawWheel();
        });

        clickableBox.addEventListener("click", () => {
            if (gameRulesDetail.style.display === "none" || gameRulesDetail.style.display === "") {
                gameRulesDetail.style.display = "block";
            } else {
                gameRulesDetail.style.display = "none";
            }
            const triangle = document.querySelector(".triangle");
            triangle.classList.toggle("rotate");
        });

        function showPopup(result, picture, multiplier, totalAmount) {
            // 결과에 따라 다른 이미지를 설정
            if (result === "당첨") {
                popupImage.src = picture;  // 당첨 이미지
            } else if (result === "실패") {
                popupImage.src = "img/clover1.png";  // 실패 이미지 경로
            }
            
            popupTitle.textContent = result;
            popupMultiplier.textContent = multiplier;
            popupTotalAmount.textContent = totalAmount;
            popup.style.display = 'block';
        }


        confirmButton.addEventListener('click', () => {
            popup.style.display = 'none';
        });
    </script>
</body>
</html>
