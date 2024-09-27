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
            position: relative; /* 자식 요소들의 절대 위치를 위해 필요 */
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
        /* 세로줄을 위한 스타일 */
        .vertical-line {
            width: 5px;
            background-color: #BAB9AA;
            position: absolute;
            top: 100px; /* 세로줄의 시작점 */
            bottom: 100px; /* 세로줄의 끝점 */
        }
        .horizontal-line {
            height: 5px;
            background-color: #BAB9AA;
            position: absolute;
        }
        /* 버튼 컨테이너 */
        .button1-container {
            display: flex;
            justify-content: space-between;
            position: absolute;
            top: 30px; /* 위쪽 버튼 위치 */
            left: 50px;
            right: 50px;
        }
        /* 각 버튼 */
        .button1-container button {
            width: 85px;
            height: 60px;
            border: none;
            background-color: transparent;
        }
        .button1-container img {
		    width: 100%; /* 이미지가 버튼 크기에 맞게 채워지도록 설정 */
		    height: 100%;
		    object-fit: cover; /* 이미지가 버튼 크기에 맞게 비율을 유지하며 채워지도록 설정 */
		}
        /* 아래 이미지 컨테이너 */
        .bottom1-image-container {
            display: flex;
            justify-content: space-between;
            position: absolute;
            bottom: 30px; /* 아래쪽 이미지 위치 */
            left: 50px;
            right: 50px;
        }
        /* 아래 이미지 */
        .bottom1-image-container img {
            width: 60px;
            height: 60px;
            object-fit: cover;
        }
        /* 게임 룰 박스 */
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
        /* 게임 룰 설명 박스 */
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
            <!-- 게임 룰 박스 -->
            <div class="game1-rules-box">
                <span>게임 룰</span>
                <div class="game1-clickable-box">
                    <div class="game1-triangle"></div>
                </div>
                <!-- 숨겨진 룰 설명 박스 -->
                <div class="game1-rules-detail">
                    <img src="img/gamerule1.png" alt="New Image">
                </div>
            </div>

            <!-- 배팅 금액 입력 부분 -->
            <div class="long-box-with-image">
                <img src="img/clover1.png" alt="Sample Image" class="box-image1">
                <div class="long-box">
                    <textarea class="input-box" id="betAmount" placeholder="배팅 금액" oninput="checkMaxValue(this)"></textarea>
                </div>
            </div>
        </div>
    </div>
	
	<script>
	    function generateLines() {
	        const container = document.getElementById('gameContainer');
	        const verticalLinePositions = [95, 250, 405, 560, 715]; // 각 세로줄의 x 좌표
	
	        // 고정된 가로줄의 y 좌표를 배열로 설정, 높이를 다르게 배치
	        const fixedTops = [
	            110, 200, 300, 400,
	            130, 220, 320, 420,
	            150, 240, 340, 440,
	            170, 260, 360, 460
	        ];
	
	        // 각 세로줄 사이에 고르게 분포시킴
	        const lineDistribution = [
	            [0, 1, 2, 3],  // 첫 번째 세로줄 사이 (1번과 2번)
	            [0, 2, 4, 6],  // 두 번째 세로줄 사이 (2번과 3번)
	            [1, 3, 5, 7],  // 세 번째 세로줄 사이 (3번과 4번)
	            [0, 2, 4, 6]   // 네 번째 세로줄 사이 (4번과 5번)
	        ];
	
	        // 이전에 생성된 가로줄이 있으면 모두 삭제
	        const existingLines = document.querySelectorAll('.horizontal-line');
	        existingLines.forEach(line => line.remove());
	
	        let counter = 0;
	        const generatedLines = [];
	
	        // 각 세로줄 사이에서 최소 1개의 가로줄을 생성
	        for (let j = 0; j < lineDistribution.length; j++) {
	            // 각 세로줄 사이에서 고정적으로 하나의 가로줄을 생성
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
	
	        // 총 10개의 가로줄을 생성하기 위해 나머지 6개의 가로줄을 랜덤으로 선택
	        while (generatedLines.length < 10) {
	            const randomIndex = Math.floor(Math.random() * fixedTops.length);
	            if (!generatedLines.some(line => line.top === fixedTops[randomIndex])) { // 중복 방지
	                const j = Math.floor(randomIndex / 4); // 세로줄 구간 계산
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
	        const verticalLinePositions = [95, 250, 405, 560, 715]; // 각 세로줄의 x 좌표
	        const horizontalLines = generateLines(); // 가로줄 생성 후 위치 정보 저장
	
	        let topPosition = 30; // 이미지 시작 위치
	        let currentXPosition = verticalLinePositions[buttonIndex]; // 시작 세로줄의 x 좌표
	        let currentVerticalLineIndex = buttonIndex; // 현재 세로줄 인덱스
	        
	        const topImage = document.createElement('img');
	        topImage.src = './img/character1.png'; // 표시할 이미지 경로
	        topImage.classList.add('top-image');
	        topImage.style.position = 'absolute';
	        topImage.style.width = '60px';
	        topImage.style.height = '60px';
	        topImage.style.left = currentXPosition - 30 + 'px'; // 중앙에 맞추기 위해 x 좌표 조정
	        topImage.style.top = topPosition + 'px'; // 이미지 초기 위치 설정
	        container.appendChild(topImage);
	
	        // 이미지가 세로줄을 타고 내려가는 함수
	        const intervalId = setInterval(() => {
	            topPosition += 5; // 5px씩 내려감
	            topImage.style.top = topPosition + 'px';
	            
	            // 가로줄과 충돌했는지 확인
	            horizontalLines.forEach((line) => {
	                if (topPosition >= line.top && topPosition <= line.top + 5 && currentXPosition === line.left) {
	                    // 가로줄을 타고 오른쪽으로 이동
	                    currentXPosition = line.left + line.width;
	                    topImage.style.left = currentXPosition - 30 + 'px'; // 이미지의 x 좌표 업데이트
	                    currentVerticalLineIndex++;
	                    topPosition += 5; // 이동 후 다시 세로줄 타고 내려가게끔 함
	                } else if (topPosition >= line.top && topPosition <= line.top + 5 && currentXPosition === line.left + line.width) {
	                    // 가로줄을 타고 왼쪽으로 이동
	                    currentXPosition = line.left;
	                    topImage.style.left = currentXPosition - 30 + 'px'; // 이미지의 x 좌표 업데이트
	                    currentVerticalLineIndex--;
	                    topPosition += 5; // 이동 후 다시 세로줄 타고 내려가게끔 함
	                }
	            });
	
	            // 이미지가 맨 아래에 도달하면 게임 종료
	            if (topPosition >= 480) { // 끝 지점 y 좌표 (아래 세로줄 끝)
	                clearInterval(intervalId); // 애니메이션 정지
	                const resultImage = document.querySelectorAll('.bottom1-image-container img')[currentVerticalLineIndex];
	                alert(`게임 종료! 결과: ${resultImage.alt}`); // 결과를 alert로 출력
	            }
	        }, 20); // 20ms마다 실행
	    }

	</script>

</body>
</html>
