<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Music Player</title>
    <style>
        .main_profile_music {
            width: 295px;
            height: 75px;
            background-color: #707070;
            margin-bottom: 5px;
            display: flex;
            align-items: center;
            padding: 10px;
        }

        .music-controls {
            display: flex;
            align-items: center;
            gap: 15px;
        }

        .music-button {
            width: 30px;
            height: 30px;
            background-color: white;
            border: none;
            cursor: pointer;
            font-size: 20px;
            display: flex;
            justify-content: center;
            align-items: center;
            border-radius: 5px;
        }

        .progress-bar-container {
            flex: 1;
            height: 4px;
            background-color: #ccc;
            border-radius: 2px;
            position: relative;
            cursor: pointer;
        }

        .progress-bar {
            height: 100%;
            background-color: #ff6f61;
            width: 0;
        }

        .time-labels {
            font-size: 12px;
            color: white;
            margin-left: 10px;
        }
    </style>
</head>
<body>

    <!-- 오디오 플레이어 -->
    <audio id="audioPlayer" src="../yang/music/die.mp3"></audio> <!-- MP3 파일 경로 설정 -->

    <div class="main_profile_music">
        <div class="music-controls">
            <!-- 처음으로 버튼 (네모) -->
            <button class="music-button" id="restartButton">■</button>

            <!-- 일시정지/재생 버튼 (세모) -->
            <button class="music-button" id="playPauseButton">▶</button>
        </div>

        <!-- 재생 시간 바 -->
        <div class="progress-bar-container" id="progressBarContainer">
            <div class="progress-bar" id="progressBar"></div>
        </div>

        <!-- 재생된 시간과 총 시간 -->
        <div class="time-labels">
            <span id="currentTime">0:00</span> / <span id="totalTime">0:00</span>
        </div>
    </div>

    <script>
        const playPauseButton = document.getElementById('playPauseButton');
        const restartButton = document.getElementById('restartButton');
        const progressBar = document.getElementById('progressBar');
        const progressBarContainer = document.getElementById('progressBarContainer');
        const currentTimeLabel = document.getElementById('currentTime');
        const totalTimeLabel = document.getElementById('totalTime');
        const audioPlayer = document.getElementById('audioPlayer');

        let isPlaying = false;

        // 시간 형식을 0:00 형태로 변환하는 함수
        function formatTime(seconds) {
            const minutes = Math.floor(seconds / 60);
            const secs = Math.floor(seconds % 60);
            return `${minutes}:${secs < 10 ? '0' : ''}${secs}`;
        }

        // MP3 파일 메타데이터가 로드될 때 총 시간 표시
        audioPlayer.addEventListener('canplaythrough', () => {
            const duration = audioPlayer.duration;
            if (duration && !isNaN(duration)) {
                totalTimeLabel.textContent = formatTime(duration);  // 총 시간 설정
            } else {
                totalTimeLabel.textContent = '0:00';  // 만약 메타데이터를 못 불러올 경우
            }
        });

        // 재생 및 일시정지 버튼 동작
        playPauseButton.addEventListener('click', () => {
            if (isPlaying) {
                audioPlayer.pause();
                playPauseButton.textContent = '▶'; // 재생 아이콘
            } else {
                audioPlayer.play();
                playPauseButton.textContent = '⏸'; // 일시정지 아이콘
            }
            isPlaying = !isPlaying;
        });

        // 처음으로 버튼 동작
        restartButton.addEventListener('click', () => {
            audioPlayer.currentTime = 0; // 오디오를 처음으로
            progressBar.style.width = '0%';
            currentTimeLabel.textContent = formatTime(audioPlayer.currentTime);
            playPauseButton.textContent = '▶'; // 재생 아이콘
            audioPlayer.pause();
            isPlaying = false;
        });

        // 재생 시간 업데이트 (현재 재생 시간에 따라 바 업데이트)
        audioPlayer.addEventListener('timeupdate', () => {
            const currentTime = audioPlayer.currentTime;
            const duration = audioPlayer.duration;
            if (duration > 0) {
                const progressPercentage = (currentTime / duration) * 100;
                progressBar.style.width = `${progressPercentage}%`;
                currentTimeLabel.textContent = formatTime(currentTime); // 현재 시간 업데이트
            }
        });

        // 오디오 종료 시, 재생 버튼을 초기 상태로 변경
        audioPlayer.addEventListener('ended', () => {
            playPauseButton.textContent = '▶'; // 재생 아이콘
            isPlaying = false;
        });

        // 진행 바 클릭 시, 클릭한 위치에 맞게 재생 시간을 변경
        progressBarContainer.addEventListener('click', (event) => {
            const containerWidth = progressBarContainer.offsetWidth;
            const clickX = event.offsetX;
            const duration = audioPlayer.duration;

            if (duration > 0) {
                const newTime = (clickX / containerWidth) * duration;
                audioPlayer.currentTime = newTime;
                const progressPercentage = (newTime / duration) * 100;
                progressBar.style.width = `${progressPercentage}%`;
                currentTimeLabel.textContent = formatTime(newTime);

                if (!isPlaying) {
                    audioPlayer.play(); // 클릭하면 자동으로 재생되게 설정
                    playPauseButton.textContent = '⏸'; // 재생 중 상태로 변경
                    isPlaying = true;
                }
            }
        });
    </script>

</body>
</html>
