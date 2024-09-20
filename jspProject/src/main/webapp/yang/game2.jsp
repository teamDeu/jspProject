<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%

%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>CloverStory</title>
    <!-- Linking the CSS file -->
    <link rel="stylesheet" type="text/css" href="css/style.css">
    <style>
        .wheel-container {
            position: relative;
            width: 600px;
            height: 600px;
            margin: 50px auto;
        }

        #wheel {
            width: 100%;
            height: 100%;
            border-radius: 50%;
            border: 5px solid #333;
            box-shadow: 0px 0px 15px rgba(0,0,0,0.5);
            cursor: pointer;
        }

        .pointer {
            position: absolute;
            top: -45px;
            left: 50%;
            width: 0;
            height: 0;
            border-left: 30px solid transparent;
            border-right: 30px solid transparent;
            border-top: 60px solid red;
            transform: translateX(-50%);
        }

        /* 수정된 부분: START 버튼을 원 가운데 배치 */
        #start-button {
            position: absolute;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
            width: 100px;
            height: 100px;
            border-radius: 50%;
            background-color: #FFFECC;
            color: red;
            font-weight: bold;
            font-size: 24px;
            display: flex;
            align-items: center;
            justify-content: center;
            cursor: pointer;
            border: 2px solid black;
        }
    </style>
    <script>
    function loadContent(url) {
        var xhr = new XMLHttpRequest();
        xhr.onreadystatechange = function() {
            if (xhr.readyState == 4 && xhr.status == 200) {
                document.getElementById("anotherBox").innerHTML = xhr.responseText;
            }
        };
        xhr.open("GET", url, true);
        xhr.send();
        chatOff();
    }
    </script>
</head>
<body>
    <div class="container">
        <div class="header">
            <img src="img/logo2.png" alt="CloverStory Logo2" class="logo2">
            <div class="settings">
                <span></span> <a href="#">설정</a> <a href="#">로그아웃</a>
            </div>
        </div>
        <!-- 큰 점선 테두리 상자 -->
        <div class="dashed-box">
            <!-- 테두리 없는 상자 -->
            <div class="solid-box">
                <div class="inner-box-1"></div>
                <!-- 이미지가 박스 -->
                <div class="image-box">
                    <img src="img/img1.png" alt="Image between boxes 1"
                        class="between-image"> <img src="img/img1.png"
                        alt="Image between boxes 2" class="between-image">
                </div>
                <div id="chatBox" class="inner-box-2">
                    <!-- inner-box-2 안에 돌림판 삽입 -->
                    <div class="wheel-container">
                        <canvas id="wheel" width="600" height="600"></canvas>
                        <div class="pointer"></div>
                        <div id="start-button">START</div>
                    </div>
                </div>
                <div id="anotherBox" class="inner-box-2" style="display: none">
                </div>
            </div>
            <!-- 버튼 -->
            <div class="button-container">
                <button onclick="javascript:chatOpen()" class="custom-button">홈</button>
                <button onclick="javascript:loadContent('index.jsp')"
                    class="custom-button">프로필</button>
                <button class="custom-button">미니룸</button>
                <button class="custom-button">게시판</button>
                <button class="custom-button">방명록</button>
                <button class="custom-button">상점</button>
                <button class="custom-button">게임</button>
                <button class="custom-button">음악</button>
            </div>
        </div>
    </div>

    <!-- 돌림판 관련 스크립트 추가 -->
    <script>
        const wheelCanvas = document.getElementById('wheel');
        const ctx = wheelCanvas.getContext('2d');
        const startButton = document.getElementById('start-button');
        
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
                ctx.moveTo(300, 300);
                ctx.arc(300, 300, 300, i * segmentAngle, (i + 1) * segmentAngle);
                ctx.fillStyle = colors[i];
                ctx.fill();
                ctx.stroke();
                ctx.save();

                ctx.translate(300, 300);
                ctx.rotate((i + 0.5) * segmentAngle);
                if (loadedImages[i]) {
                    ctx.drawImage(loadedImages[i], 150, -50, 100, 100);
                } else {
                    ctx.fillStyle = 'black';
                    ctx.font = '20px Arial';
                    ctx.fillText('NO IMG', 150, 10);
                }
                ctx.restore();
            }
        }

        function rotateWheel() {
            currentAngle += spinSpeed;
            spinSpeed *= 0.98;
            ctx.clearRect(0, 0, 600, 600);
            ctx.save();
            ctx.translate(300, 300);
            ctx.rotate(currentAngle);
            ctx.translate(-300, -300);
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

                if(images[winningSegment]=="img/bomb.png")
                    alert("클로버 x 0");
                else if(images[winningSegment]=="img/clover1.png")
                    alert("클로버 x 1");
                else if(images[winningSegment]=="img/clover2.png")
                    alert("클로버 x 2");
                else if(images[winningSegment]=="img/clover3.png")
                    alert("클로버 x 3");
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
    </script>
</body>
</html>
