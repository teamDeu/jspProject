<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>돌림판 게임</title>
    <style>
        .wheel-container-wrapper {
            width: 700px; /* 감싸는 사각형의 크기 */
            padding: 50px;
            margin: 0 auto;
            margin-bottom: 20px; /* 사각형과 줄 사이의 여백 */
            border: 3px solid #BAB9AA; 
            background-color: #f7f7f7; /* 사각형 배경색 */
            border-radius: 15px; /* 모서리를 둥글게 만듦 */
        }

        .wheel-container {
            position: relative;
            width: 500px; /* 크기 조금 키우기 */
            height: 500px; /* 크기 조금 키우기 */
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
            border-radius: 5px; /* 모서리를 둥글게 만듦 */
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
            width: 800px; /* 줄 길이 */
            height: 2px;  /* 줄의 높이 */
            background-color: #BAB9AA;
            margin: 0 auto;
            position: relative;
            margin-top: 0; /* 위쪽 여백 */
            margin-bottom: 20px; /* 줄과 사각형 사이에 공간 추가 */
        }
        
        .game-title span {
            position: absolute;
            top: -40px; /* 텍스트를 줄과 멀리 떨어뜨리기 */
            left: 0; /* 텍스트를 왼쪽 끝으로 이동 */
            font-size: 35px;
            color: #80A46F;
        }
        
        .long-box-container {
            display: flex;
            justify-content: space-between; /* 박스들이 양쪽에 위치하도록 설정 */
            align-items: center; /* 박스를 수평으로 맞추기 위해 중앙 정렬 */
            gap: 200px; /* 두 박스 사이의 간격 설정 */
            margin-top: -10px; /* 큰 네모박스와의 여백 */
        }
        
        .long-box {
            width: 250px; /* 긴 네모의 너비 */
            height: 30px; /* 긴 네모의 높이 */
            background-color: white; /* 긴 네모의 배경색 */
            border: 2px solid #BAB9AA; /* 테두리 */
            border-radius: 10px; /* 모서리를 둥글게 */
            display: flex;
            justify-content: center; /* 수평으로 가운데 정렬 */
            align-items: center; /* 수직으로 가운데 정렬 */
        }
        
        .long-box-with-image {
            display: flex;
            align-items: center; /* 이미지와 박스가 수직으로 가운데 정렬되도록 */
            gap: 10px; /* 이미지와 박스 사이의 간격 */
        }
        
        .box-image1 {
            width: 60px; /* 이미지의 너비 */
            height: 60px; /* 이미지의 높이 */
            object-fit: cover; /* 이미지의 크기를 박스에 맞춤 */
        }
        
        .input-box {
            width: 90%; /* 입력 필드가 박스 내에 맞도록 너비 설정 */
            height: 100%; /* 입력 필드 높이를 박스에 맞춤 */
            border: none;
            resize: none; /* 입력 필드 크기 조정 불가능하게 설정 */
            background-color: transparent; /* 배경색 투명 */
            font-size: 24px; /* 글자 크기 */
            outline: none; /* 입력할 때 테두리 제거 */
            text-align: center; /* 텍스트를 수평으로 가운데 정렬 */
            display: flex;
            justify-content: center;
            align-items: center;
            padding: 5px; /* 입력 필드 안쪽 여백 */
        }

        /* 게임 룰 박스 */
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
            border-bottom: 15px solid black; /* 기본적으로 똑바로 된 삼각형 */
            transition: transform 0.3s ease; /* 회전 애니메이션 추가 */
        }

        .triangle.rotate {
            transform: rotate(180deg); /* 역삼각형으로 회전 */
        }

        /* 게임 룰 설명 박스 */
        .game-rules-detail {
            display: none; /* 초기 상태는 숨김 */
            position: absolute;
            top: -326px; /* '게임 룰' 박스 바로 위에 위치 */
            left: 0;
            width: 250px;
            height: 300px;
            background-color: white;
            border: 2px solid #BAB9AA;
            border-radius: 10px;
            padding: 10px;
        }

        .game-rules-detail img {
            width: 230px; /* 이미지 크기 */
            height: 280px;
            object-fit: cover;
            margin-bottom: 10px;
        }
    </style>
</head>
<body>
    <!-- div에 직접 style 적용 -->
    <div style="text-align: center; margin-top: 50px;">
        <div class="game-title">
            <span>돌림판 게임</span>
        </div>

        <!-- 사각형을 감싸는 wrapper -->
        <div class="wheel-container-wrapper">
            <div class="wheel-container">
                <canvas id="wheel" width="400" height="400"></canvas> <!-- 크기 조금 키우기 -->
                <div class="pointer"></div>
                <div id="start-button">START</div>
            </div>
        </div>

        <div class="long-box-container">
            <!-- 게임 룰 박스 -->
            <div class="game-rules-box">
                <span>게임 룰</span>
                <div class="clickable-box">
                    <div class="triangle"></div>
                </div>
                <!-- 숨겨진 룰 설명 박스 -->
                <div class="game-rules-detail">
                    <img src="img/gamerule.png" alt="New Image"> <!-- 새로운 이미지 경로로 수정 -->
                </div>
            </div>

            <!-- 배팅 금액 입력 부분 -->
            <div class="long-box-with-image">
                <img src="img/clover1.png" alt="Sample Image" class="box-image1">
                <div class="long-box">
                    <textarea class="input-box" id="betAmount" placeholder="배팅 금액"></textarea>
                </div>
            </div>
        </div>
    </div>

    <script>
        const wheelCanvas = document.getElementById('wheel');
        const ctx = wheelCanvas.getContext('2d');
        const startButton = document.getElementById('start-button');
        const betAmountInput = document.getElementById('betAmount'); // 배팅 금액 입력 필드

        const clickableBox = document.querySelector(".clickable-box");
        const gameRulesDetail = document.querySelector(".game-rules-detail");

        let isSpinning = false;
        let currentAngle = 0;
        let spinSpeed = 0;

        // 섹션 8개 정의 (이미지 이름 배열로 변경)
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

        // 각 섹션의 각도 (라디안 값)
        const segmentAngle = (2 * Math.PI) / numSegments;

        // 색상 설정
        const colors = ['#FEFFF5', '#FFDDC1', '#FEFFF5', '#FFDDC1', '#FEFFF5', '#FFDDC1', '#FEFFF5', '#FFDDC1'];

        // 이미지 배열에 담을 변수
        let loadedImages = [];

        // 이미지 로드 함수
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
                img.onerror = () => { // 이미지가 로드되지 않을 경우
                    console.error("Image failed to load:", images[i]);
                    loadedImages[i] = null; // 이미지가 없으면 null로 설정
                    loadedCount++;
                    if (loadedCount === images.length) {
                        callback();
                    }
                };
            }
        }

        // 돌림판 그리기
        function drawWheel() {
            for (let i = 0; i < numSegments; i++) {
                ctx.beginPath();
                ctx.moveTo(200, 200);  // 중심 좌표 변경
                ctx.arc(200, 200, 200, i * segmentAngle, (i + 1) * segmentAngle); // 크기 조정
                ctx.fillStyle = colors[i];
                ctx.fill();
                ctx.stroke();
                ctx.save();

                // 이미지 표시
                ctx.translate(200, 200); // 중심 좌표 조정
                ctx.rotate((i + 0.5) * segmentAngle);
                if (loadedImages[i]) {
                    ctx.drawImage(loadedImages[i], 100, -35, 75, 75);  // 이미지 크기 조정
                } else {
                    // 이미지가 없을 경우, 섹션 중앙에 기본 텍스트 표시
                    ctx.fillStyle = 'black';
                    ctx.font = '14px Arial'; // 글자 크기 조정
                    ctx.fillText('NO IMG', 100, 5);
                }
                ctx.restore();
            }
        }

        // 돌림판 회전
        function rotateWheel() {
            currentAngle += spinSpeed;
            spinSpeed *= 0.98;  // 속도 감소
            ctx.clearRect(0, 0, 400, 400);
            ctx.save();
            ctx.translate(200, 200);  // 중심 좌표 변경
            ctx.rotate(currentAngle);
            ctx.translate(-200, -200);  // 중심 좌표 변경
            drawWheel();
            ctx.restore();

            if (spinSpeed > 0.01) {
                requestAnimationFrame(rotateWheel);
            } else {
                isSpinning = false;

                // 현재 각도를 0 ~ 2*PI 범위로 맞추기
                const normalizedAngle = (currentAngle % (2 * Math.PI));

                // 첫 번째 섹션이 12시에 오도록 90도(PI / 2) 보정
                const correctedAngle = (2 * Math.PI - normalizedAngle - Math.PI / 2) % (2 * Math.PI);

                // 당첨된 섹션 계산 (화살표가 가리키는 섹션)
                let winningSegment = Math.floor((correctedAngle / segmentAngle) % numSegments);
                if (winningSegment < 0) {
                    winningSegment += numSegments;
                }

                // 배팅 금액 가져오기
                let betAmount = parseInt(betAmountInput.value) || 0;
                let multiplier = 0;

                // 섹션에 따라 배수 설정
                if(images[winningSegment] == "img/bomb.png") {
                    multiplier = 0;
                } else if(images[winningSegment] == "img/clover1.png") {
                    multiplier = 1;
                } else if(images[winningSegment] == "img/clover2.png") {
                    multiplier = 2;
                } else if(images[winningSegment] == "img/clover3.png") {
                    multiplier = 3;
                }

                // 결과 계산 및 출력
                let totalAmount = betAmount * multiplier;
                alert("총 결과: " + totalAmount + " (배팅 금액: " + betAmount + " x " + multiplier + ")");
            }
        }

        // 작은 원 클릭 이벤트 처리
        startButton.addEventListener('click', () => {
            if (!isSpinning) {
                isSpinning = true;
                spinSpeed = Math.random() * 0.5 + 0.2;  // 랜덤 속도 설정
                rotateWheel();
            }
        });

        // 이미지 로드 후 돌림판 그리기
        loadImages(() => {
            drawWheel();
        });

        // 네모 박스 클릭 시 룰 표시/숨기기 및 삼각형 회전 처리
        clickableBox.addEventListener("click", () => {
            // 룰 박스 표시/숨기기
            if (gameRulesDetail.style.display === "none" || gameRulesDetail.style.display === "") {
                gameRulesDetail.style.display = "block";
            } else {
                gameRulesDetail.style.display = "none";
            }

            // 삼각형 회전 처리
            const triangle = document.querySelector(".triangle");
            triangle.classList.toggle("rotate"); // rotate 클래스를 추가하거나 제거
        });
    </script>
</body>
</html>
