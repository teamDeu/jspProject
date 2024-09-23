<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>가로로 긴 네모 박스 레이아웃</title>
    <script>
	function clickOpenBox(id){
		openBox = document.getElementById(id);
		anotherBox = document.querySelectorAll(".inner-box-2");
		for(i = 0 ; i < anotherBox.length ; i++){
			anotherBox[i].style.display ="none";
		}
		openBox.style.display = "flex";
	}

</script>
    <style>
        .box-container {
            width: 750px; /* 박스의 가로 길이 */
            height: 270px; /* 박스의 높이 */
            margin: 20px auto; /* 화면 중앙에 배치 */
            padding: 20px;
            display: flex; /* flex 레이아웃을 사용 */
            align-items: center;
            border: 2px solid #BAB9AA;
            border-radius: 10px; /* 모서리를 둥글게 */
            background-color: #eeeeee; /* 배경색 */
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

        .box-image {
            width: 250px; /* 이미지 너비 */
            height: 250px; /* 이미지 높이 */
            object-fit: cover; /* 이미지가 박스에 맞도록 */
            margin-right: 20px; /* 이미지와 오른쪽 내용 간 간격 */
        }

        .box-content {
            flex: 1; /* 나머지 공간을 차지하도록 설정 */
            display: flex;
            flex-direction: column;
            justify-content: space-between;
        }

        .text-content {
            flex: 1;
            text-align: left; /* 제목과 설명을 왼쪽 정렬 */
        }

        .box-title {
            font-size: 45px; /* 큰 글자 (제목) */
            font-weight: bold;
            color: #333;
            margin-bottom: 10px;
        }

        .box-description {
            font-size: 30px; /* 작은 글자 (설명) */
            color: #555;
            margin-bottom: 20px;
        }

		.box-button {
		    padding: 5px 20px;
		    font-size: 20px;
		    background-color: white;
		    color: black;
		    border: 1px solid #c1c1c1; /* 테두리 빨간색 */
		    border-radius: 5px;
		    cursor: pointer;
		    align-self: flex-end; /* 버튼을 오른쪽에 배치 */
		}

        .box-button:hover {
            background-color: #C0E5AF; /* 버튼에 마우스를 올렸을 때 색 변경 */
        }
    </style>
</head>
<body>
    <div id="main" style="text-align: center; margin-top: 50px;">
        <!-- 가로줄과 텍스트 -->
        <div class="game-title">
            <span>게임</span> <!-- 가로줄 위의 텍스트 -->
        </div>

        <!-- 첫 번째 큰 네모 박스 -->
        <div class="box-container">
            <img src="img/g1.png" alt="Sample Image 1" class="box-image"> <!-- 왼쪽 사진 -->
            <div class="box-content">
                <div class="text-content">
                    <div class="box-title">사다리 게임</div> <!-- 제목 -->
                    <div class="box-description">참가자가 가로로 그려진 사다리 위의 세로 선을 타고 내려가며 가로로 그려진 연결선을 만나 방향을 바꿔 내려가면서 가장 밑의 상금을 얻는 게임</div> <!-- 설명 -->
                </div>
                <button class="box-button">-> start</button> <!-- 버튼 -->
            </div>
        </div>

        <!-- 두 번째 큰 네모 박스 -->
        <div class="box-container">
            <img src="img/g2.png" alt="Sample Image 2" class="box-image"> <!-- 왼쪽 사진 -->
            <div class="box-content">
                <div class="text-content">
                    <div class="box-title">돌림판 게임</div> <!-- 제목 -->
                    <div class="box-description">참가자가 회전하는 원판을 돌려서 랜덤하게 상금을 얻는 게임</div> <!-- 설명 -->
                </div>
                <button class="box-button">-> start</button> <!-- 버튼 -->
            </div>
        </div>
    </div>
</body>
</html>
