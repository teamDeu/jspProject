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
		
		<div class="wheel-container-wrapper">
            <!-- 윗부분 버튼 -->
            <div class="button1-container">
                <button><img src="img/choice.png" alt="Button 1"></button>
                <button><img src="img/choice.png" alt="Button 2"></button>
                <button><img src="img/choice.png" alt="Button 3"></button>
                <button><img src="img/choice.png" alt="Button 4"></button>
                <button><img src="img/choice.png" alt="Button 5"></button>
            </div>

            <!-- 세로줄 5개 -->
            <div class="vertical-line" style="left: 95px;"></div>
            <div class="vertical-line" style="left: 250px;"></div>
            <div class="vertical-line" style="left: 405px;"></div>
            <div class="vertical-line" style="left: 560px;"></div>
            <div class="vertical-line" style="left: 715px;"></div>

            <!-- 아래 이미지 -->
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
		function checkMaxValue(element) {
	        let max = 100;
	        if (parseInt(element.value) > max) {
	          element.value = max;
	        }
	      }
        // 버튼 클릭 시 게임 룰 표시/숨기기
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
	</script>
    
</body>
</html>
