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
        

        .big-box {
            width: 800px;
            height: 546px;
            border: 2px solid #BAB9AA;
            position: relative;
            overflow-y: auto;
        }

        .line {
            width: 100%;
            height: 55px;
            border-bottom: 1px dashed #BAB9AA;
            box-sizing: border-box;
            position: relative;
            display: flex;
            align-items: center;
        }

        .checkbox-wrapper {
            position: absolute;
            left: 150px;
            display: flex;
            align-items: center;
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
        
        .top-box {
            width: 800px;
            height: 56px;
            border: 2px solid #BAB9AA;
            margin-top: 0px;
            position: relative;
        }
        .right-buttons {
            position: absolute;
            bottom: 10px;
            right: 10px;
        }
        .right-buttons button {
            padding: 10px;
            border: none;
            background-color: #80A46F;
            color: white;
            font-size: 16px;
            cursor: pointer;
            border-radius: 12px;
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

        .line {
            display: none;
        }
    </style>

    <script>
    let currentIndex = 0;
    let selectedSongs = [];
    const pageSize = 10;
    const totalItems = <%= musicvlist.size() %>;
    const totalPages = Math.ceil(totalItems / pageSize);

    // 새로고침 시 저장된 정보로 음악 재생 재개
    document.addEventListener("DOMContentLoaded", function () {
    const savedSong = localStorage.getItem('currentSong');
    const savedTime = localStorage.getItem('savedTime');
    const savedArtist = localStorage.getItem('currentArtist');

    const audioPlayer = document.getElementById('audioPlayer');
    const titleElement = document.querySelector('.title');
    const artistElement = document.querySelector('.artist');

    if (savedSong && savedTime) {
        // 이전에 저장된 노래 정보 및 시간 불러오기
        audioPlayer.src = savedSong;
        titleElement.innerText = localStorage.getItem('currentSongTitle');
        artistElement.innerText = savedArtist || '아티스트';
        audioPlayer.currentTime = parseFloat(savedTime);

        // 자동 재생 시작
        audioPlayer.play();
    }

    // Unmute the audio after starting
    audioPlayer.muted = false;
});

    function playSongs() {
        if (currentIndex >= selectedSongs.length) {
            currentIndex = 0;
            return;
        }

        const currentSong = selectedSongs[currentIndex];
        const audioPlayer = document.getElementById('audioPlayer');
        const titleElement = document.querySelector('.title');
        const artistElement = document.querySelector('.artist');

        // 노래 정보 설정 및 재생
        audioPlayer.src = currentSong.path;
        titleElement.innerText = currentSong.song;
        artistElement.innerText = currentSong.artist;

        // localStorage에 현재 노래 정보 저장
        localStorage.setItem('currentSong', currentSong.path);
        localStorage.setItem('currentSongTitle', currentSong.song);
        localStorage.setItem('currentArtist', currentSong.artist);

        audioPlayer.play();

    }
    
    function playNextSong() {
        currentIndex++;
        if (currentIndex < selectedSongs.length) {
            playSongs();
        } else {
            currentIndex = 0; // 마지막 곡이 끝나면 처음으로 돌아감
        }
    }
        

    function setBackgroundMusic() {
        const checkboxes = document.querySelectorAll('.checkbox-wrapper input[type="checkbox"]:checked');
        selectedSongs = [];

        checkboxes.forEach((checkbox) => {
            const line = checkbox.closest('.line');
            const song = line.querySelector('.title').innerText;
            const artist = line.querySelector('.artist').innerText;
            const path = line.querySelector('.hidden').innerText;

            selectedSongs.push({ song, artist, path });
        });

        if (selectedSongs.length > 0) {
            currentIndex = 0;
            playSongs();
        } else {
            alert('음악을 선택해 주세요.');
        }
    }

        function showPage(page) {
            const allLines = document.querySelectorAll('.line');
            allLines.forEach(line => line.style.display = 'none');

            const start = (page - 1) * pageSize;
            const end = start + pageSize;

            for (let i = start; i < end && i < totalItems; i++) {
                allLines[i].style.display = 'flex';
            }
        }

        document.addEventListener('DOMContentLoaded', function () {
            showPage(1);
        });
        
        document.addEventListener('DOMContentLoaded', function () {
            const audioPlayer = document.getElementById('audioPlayer');

            // 현재 재생 시간을 주기적으로 저장
            audioPlayer.ontimeupdate = function () {
                localStorage.setItem('savedTime', audioPlayer.currentTime);
            };

         // 음악이 끝나면 다음 곡 재생
            audioPlayer.onended = function () {
                playNextSong();
            };
        });

        document.addEventListener('DOMContentLoaded', function() {
            const playButton = document.getElementById('playButton');
            const audioPlayer = document.getElementById('audioPlayer');
            let isPlaying = false;

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
                isPlaying = !isPlaying;
            });

            audioPlayer.addEventListener('ended', () => {
                playButton.classList.remove('pause');
                playButton.classList.add('play');
                isPlaying = false;
            });
        });

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
    <div class="top-box">
        <div class="checkbox-wrapper">
            <input type="checkbox" id="selectAll" style="margin-top:20px;" onclick="toggleAllCheckboxes(this)"> <!-- 제일 위 체크박스 -->
        </div>
        <div class="title" style=" font-size:40px; ">곡명</div>
        <div class="artist" style=" font-size:40px;">아티스트</div>
    </div>
    

    <div class="big-box">
        <!-- 음악 리스트를 반복문으로 출력 -->
        <%
            for (int i = 0; i < musicvlist.size(); i++) {
                MusicBean music = musicvlist.get(i);
                String[] songInfo = music.getItem_name().split("-", 2);
                String artist = songInfo.length > 1 ? songInfo[0].trim() : "";
                String song = songInfo.length > 1 ? songInfo[1].trim() : songInfo[0];
        %>
        <div class="line">
            <div class="checkbox-wrapper">
                <input type="checkbox">
            </div>
            <div class="title">
                <%= song %>
            </div>
            <div class="artist">
                <%= artist %>
            </div>
            <div class="hidden">
                <%= music.getItem_path() %>
            </div>
        </div>
        <%
            }
        %>
    </div>

    <div class="small-box">
    	<div class="top-right-buttons">
    		<button onclick="deleteSelectedSongs()">삭제</button>
            <button onclick="setBackgroundMusic()">배경음악 설정</button>
            
        </div>
        <div class="center-buttons">
            <button onclick="showPage(1)">1</button>
            <button onclick="showPage(2)">2</button>
            <button onclick="showPage(3)">3</button>
            <button onclick="showPage(4)">4</button>
        </div>
    </div>

</body>
</html>
