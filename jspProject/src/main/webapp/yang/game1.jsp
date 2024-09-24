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
            height:500px;
            padding: 50px;
            margin: 0 auto;
            margin-bottom: 20px; /* 사각형과 줄 사이의 여백 */
            border: 3px solid #BAB9AA; 
            background-color: #f7f7f7; /* 사각형 배경색 */
            border-radius: 15px; /* 모서리를 둥글게 만듦 */
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
            <span>사다리 타기</span>
        </div>
		
		<div class="wheel-container-wrapper">
            
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
	

    
</body>
</html>
