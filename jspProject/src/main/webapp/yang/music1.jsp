<%@page import="java.util.HashMap"%>
<%@page import="music.MusicBean"%>
<%@page import="java.util.Vector"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" 
                  pageEncoding="UTF-8" isELIgnored="false" %>
<%@ page import="java.sql.*, pjh.MemberBean, pjh.DBConnectionMgr"%>
<jsp:useBean id="mgr" class="music.MusicMgr" />
<%
    // 세션에서 user_id를 가져옴
    String user_id = (String) session.getAttribute("idKey");

    // user_id에 해당하는 음악 리스트를 가져옴
    Vector<MusicBean> musicvlist = mgr.getMusicList(user_id);
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Music Player</title>
    <style>
        .music-player {
		    width: 100%;
		    max-width: 500px;
		    height: 75px;
		    background-color: #e0e0e0;
		    border-radius: 15px;
		    display: flex;
		    align-items: center;
		    justify-content: space-between;
		    padding: 10px 20px;
		    box-sizing: border-box;
		    position: relative; /* 재생바의 절대 위치 설정을 위해 */
		}
		
		.play-button {
		    width: 50px;
		    height: 50px;
		    border: 2px solid gray;
		    border-radius: 50%;
		    display: flex;
		    justify-content: center;
		    align-items: center;
		    cursor: pointer;
		    background-color: transparent;
		}
		
		.play-button.play:before {
		    content: '';
		    border-style: solid;
		    border-width: 10px 0 10px 18px;
		    border-color: transparent transparent transparent gray;
		}
		
		.play-button.pause:before {
		    content: '❚❚';
		    font-size: 20px;
		    color: gray;
		}
		
		.song-info {
		    display: flex;
		    flex-direction: column;
		    text-align: center;
		    margin-left: 20px;
		    margin-right: auto; /* 텍스트 왼쪽 정렬 */
		}
		
		.song-info .title {
		    font-size: 24px;
		    font-weight: bold;
		    margin-top: -30px;
		    left:95px;
		    text-align: center;
		    white-space: nowrap;
		}
		
		.song-info .artist {
		    font-size: 24px;
		    margin-top: -10px;
		    left:120px;
		    text-align: center;
		    white-space: nowrap;
		}
		
		/* 재생바를 맨 아래에 배치 */
		.progress-bar {
		    height: 2px;
		    background-color: gray;
		    width: 200px;
		    position: absolute;
		    bottom: 10px;
		    left: 45px;
		}


        .big-box {
            width: 800px;
            height: 600px;
            border: 2px solid #BAB9AA;
            position: relative;
            overflow-y: auto; /* 스크롤 가능하도록 */
        }

        .line {
            width: 100%;
            height: 54px; 
            border-bottom: 1px dashed #BAB9AA;
            box-sizing: border-box;
            position: relative;
            display: flex;
            align-items: center;
        }

        .line.first {
            border-bottom: 2px solid #BAB9AA;
            display: flex;
            align-items: center;
        }

        .checkbox-wrapper {
            position: absolute;
            left: 150px;
            display: flex;
            align-items: center;
        }

        .checkbox-wrapper input[type="checkbox"] {
            width: 24px;
            height: 24px;
            margin-right: 10px;
            cursor: pointer;
        }

        .title, .artist {
            position: absolute;
            font-size: 18px;
        }

        .title {
            left: 30%;
            width: 45%;
            text-align: left;
            font-weight: bold;
            font-size: 30px;
        }

        .artist {
            right: 50px;
            width: 25%;
            text-align: left;
            font-size: 30px;
        }

        .hidden {
            display: none;
        }

        .small-box {
            width: 800px;
            height: 72px;
            border: 2px solid #BAB9AA;
            margin-top: 0px;
            position: relative;
        }

        .center-buttons {
            position: absolute;
            bottom: 10px;
            left: 50%;
            transform: translateX(-50%);
        }

        .center-buttons button {
            padding: 10px;
            margin: 0 5px;
            border: none;
            background-color: #80A46F;
            color: white;
            font-size: 16px;
            cursor: pointer;
            border-radius: 12px;
        }

        .top-right-buttons {
            position: absolute;
            top: 10px;
            right: 10px;
        }

        .top-right-buttons button {
            padding: 10px;
            margin-left: 10px;
            border: none;
            background-color: #BAB9AA;
            color: white;
            font-size: 16px;
            cursor: pointer;
            border-radius: 12px;
        }

        .music-title {
            width: 810px;
            height: 2px;
            background-color: #BAB9AA;
            margin: 0 auto;
            position: relative;
            margin-top: 40px;
            margin-bottom: 20px;
        }

        .music-title span {
            position: absolute;
            top: -40px;
            left: 0;
            font-size: 35px;
            color: #80A46F;
        }
    </style>

    <script>
        let currentIndex = 0;
        let selectedSongs = [];

        // 선택된 음악의 순서대로 배경 음악을 재생하는 함수
        function playSongs() {
            if (currentIndex >= selectedSongs.length) {
                currentIndex = 0;  // 모든 곡이 재생되면 처음으로 돌아옴
                return;
            }

            const currentSong = selectedSongs[currentIndex];
            const audioPlayer = document.getElementById('audioPlayer');
            const playButton = document.getElementById('playButton');
            const titleElement = document.querySelector('.title');
            const artistElement = document.querySelector('.artist');

            // 현재 선택된 곡을 오디오 플레이어에 설정
            audioPlayer.src = currentSong.path;
            titleElement.innerText = currentSong.song;  // 곡명
            artistElement.innerText = currentSong.artist;  // 아티스트

            // 재생 시작
            audioPlayer.play();
            playButton.classList.remove('play');
            playButton.classList.add('pause');

            // 다음 곡 재생 준비
            currentIndex++;
        }

        // 음악이 끝나면 다음 곡 재생
        document.getElementById('audioPlayer').addEventListener('ended', () => {
            playSongs();
        });

        // 배경 음악 설정 버튼 클릭 시
        function setBackgroundMusic() {
            const checkboxes = document.querySelectorAll('.checkbox-wrapper input[type="checkbox"]:checked');
            selectedSongs = [];

            // 선택된 곡들의 정보를 배열에 저장
            checkboxes.forEach((checkbox) => {
                const line = checkbox.closest('.line');
                const song = line.querySelector('.title').innerText;
                const artist = line.querySelector('.artist').innerText;
                const path = line.querySelector('.hidden').innerText;

                selectedSongs.push({ song, artist, path });
            });

            if (selectedSongs.length > 0) {
                currentIndex = 0;
                playSongs();  // 첫 번째 곡부터 재생 시작
            } else {
                alert('음악을 선택해 주세요.');
            }
        }
        
        document.addEventListener('DOMContentLoaded', function() {
            const playButton = document.getElementById('playButton');
            const audioPlayer = document.getElementById('audioPlayer');
            let isPlaying = false;

            // 클릭 이벤트를 처리하여 재생/일시정지 기능을 구현
            playButton.addEventListener('click', () => {
                if (isPlaying) {
                    audioPlayer.pause();
                    playButton.classList.remove('pause');
                    playButton.classList.add('play');
                } else {
                    audioPlayer.play();
                    playButton.classList.remove('play');
                    playButton.classList.add('pause');
                }
                isPlaying = !isPlaying; // 상태 변경
            });

            // 노래가 끝나면 일시정지 버튼을 다시 재생 버튼으로 변경
            audioPlayer.addEventListener('ended', () => {
                playButton.classList.remove('pause');
                playButton.classList.add('play');
                isPlaying = false;
            });
        });

        // 체크박스 모두 선택/해제
        function toggleAllCheckboxes(source) {
            const checkboxes = document.querySelectorAll('.checkbox-wrapper input[type="checkbox"]');
            checkboxes.forEach((checkbox) => {
                checkbox.checked = source.checked;
            });
        }
    </script>
</head>
<body>

    <div class="music-title">
        <span>음악</span>
    </div>

    <div class="big-box">
        <!-- 첫 번째 줄, 체크박스, 곡명, 아티스트 -->
        <div class="line first">
            <div class="checkbox-wrapper">
                <input type="checkbox" id="selectAll" onclick="toggleAllCheckboxes(this)"> <!-- 제일 위 체크박스 -->
            </div>
            <div class="title">곡명</div>
            <div class="artist">아티스트</div>
        </div>

        <!-- 음악 리스트를 반복문으로 출력 -->
        <%
            for (int i = 0; i < musicvlist.size(); i++) {
                MusicBean music = musicvlist.get(i);
                String[] songInfo = music.getItem_name().split("-", 2);  // "-"로 분리
                String artist = songInfo.length > 1 ? songInfo[0].trim() : "";  // 아티스트
                String song = songInfo.length > 1 ? songInfo[1].trim() : songInfo[0];  // 곡명
        %>
        <div class="line">
            <div class="checkbox-wrapper">
                <input type="checkbox">  <!-- 각 줄마다 체크박스 추가 -->
            </div>
            <div class="title">
                <%= song %>  <!-- 곡명 출력 -->
            </div>
            <div class="artist">
                <%= artist %>  <!-- 아티스트 출력 -->
            </div>
            <div class="hidden">
                <%= music.getMusic_path() %>  <!-- 숨긴 music_path -->
            </div>
        </div>
        <%
            }
        %>
    </div>

    <div class="small-box">
        <!-- 오른쪽 상단 버튼 -->
        <div class="top-right-buttons">
            <button onclick="setBackgroundMusic()">배경음악 설정</button>
        </div>

        <!-- 가운데 아래 버튼 -->
        <div class="center-buttons">
            <button onclick="changeColor(this)">1</button>
            <button onclick="changeColor(this)">2</button>
            <button onclick="changeColor(this)">3</button>
            <button onclick="changeColor(this)">4</button>
        </div>
    </div>
</body>
</html>