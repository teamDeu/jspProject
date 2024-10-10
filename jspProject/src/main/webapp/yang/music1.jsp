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
    
    Vector<String> playlists = mgr.getUserPlaylists(user_id);
    
    Vector<MusicBean> popularMusicList = mgr.getPopularMusicList();
    
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
        
        .line1 {
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
            left: 50px;
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
            border-top: none;  /* 하단 테두리를 없앰 */
        }
        
        .top-box {
            width: 800px;
            height: 56px;
            border: 2px solid #BAB9AA;
            margin-top: 0px;
            position: relative;
            border-bottom: none;  /* 하단 테두리를 없앰 */
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
        
        /*정현이형 여기가!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!*/
		.center-buttons {
		    position: absolute;
		    bottom: 10px; /* 하단에 고정 */
		    left: 50%;
		    transform: translateX(-50%);
		    display: flex;
		    justify-content: center;
		    align-items: center;
		    background-color: #C0E5AF;
		    border-radius: 30px;
		    padding: 1px 10px;
		    gap: 5px;
		}
		.center-buttons span {
			padding: 10px;
			cursor: pointer;
		}
		
		.center-buttons span.active {
			color: red;
		}
        /*페이징 css코드에요!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!*/

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
        
        .music-title-select-wrapper {
		    position: absolute;
		    top: -40px; /* 위쪽 여백 */
		    right: 0;   /* 오른쪽 끝으로 배치 */
		}
		
		.music-title-select {
		    padding: 5px;
		    font-size: 20px;
		    font-weight: bold;"
		}

        .line {
            display: none;
        }
        .small-icon5 {
		    width: 30px; /* 원하는 크기로 설정 */
		    height: 30px;
		    margin-left: 0; /* 이미지를 아티스트 이름에 딱 붙이기 */
		    vertical-align: middle; /* 텍스트와 수평으로 맞추기 */
		}
		
		/* 팝업 기본 스타일 */
		.popup5 {
		    position: fixed;
		    bottom: -100%; /* 화면 아래에 숨겨짐 */
		    left: 45%; /* 화면의 가운데에 위치하게 설정 (30% 너비일 때) */
		    width: 20%; /* 팝업 너비를 30%로 설정 */
		    background-color: #fff;
		    box-shadow: 0 -2px 10px rgba(0, 0, 0, 0.2);
		    transition: bottom 0.5s ease; /* 애니메이션으로 팝업이 올라오는 효과 */
		    z-index: 1000; /* 팝업이 다른 요소 위에 표시되도록 */
		    padding: 20px;
		    border-radius: 10px;
		}
		
		/* 팝업이 활성화되었을 때 */
		.popup5.show5 {
		    bottom: 20%; /* 화면의 반 정도까지 올라오게 설정 */
		}
		
		.popup-content5 {
		    padding: 20px;
		    text-align: center;
		}
		
		.close-button5 {
		    background-color: #80A46F;
		    color: white;
		    padding: 10px;
		    border: none;
		    cursor: pointer;
		    border-radius: 5px;
		    font-size: 16px;
		    margin-top: 10px;
		}

		
    </style>

    <script>
    let currentIndex = 1;
    let selectedSongs = [];
    let selectedItemName = "";
    const pageSize = 10;
    const totalItems = <%= musicvlist.size() %>;
    const totalPages = Math.ceil(totalItems / pageSize);

    // 새로고침 시 저장된 정보로 음악 재생 재개
    document.addEventListener('DOMContentLoaded', function () {
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
        updateMusicPagination();
	})
	
	function updateMusicPagination() {
    const allLines = document.querySelectorAll('.line');
    const totalPages = Math.ceil(allLines.length / pageSize);
    const paginationContainer = document.querySelector('#center-buttons');
    paginationContainer.innerHTML = ''; // 기존 페이지네이션 제거

    for (let i = 1; i <= totalPages; i++) {
        const pageSpan = document.createElement('span');
        pageSpan.textContent = i;
        pageSpan.classList.add('page-span'); // 페이지 번호에 공통 클래스 추가
        pageSpan.onclick = () => showPage(i); // 페이지 클릭 이벤트 핸들러 추가
        paginationContainer.appendChild(pageSpan);
    }

    // 현재 페이지에 active 클래스 추가
    updateActivePage(currentIndex);
}
	
	function showPlaylist(playlistId) {
	    // 모든 big-box를 숨김
	    document.querySelectorAll('.big-box').forEach(box => {
	        box.style.display = 'none';
	    });
	
	    // 선택한 big-box만 보이도록 설정
	    document.getElementById(playlistId).style.display = 'block';
	
	    // top-box 체크박스 초기화 (해제)
	    document.getElementById('selectAll').checked = false;
	}


    function playSongs() {
        if (currentIndex >= selectedSongs.length) {
            currentIndex = 0; // 마지막 곡이 끝나면 처음으로 돌아감
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
        const allCheckboxes = document.querySelectorAll('.big-box .checkbox-wrapper input[type="checkbox"]');
        selectedSongs = [];

        allCheckboxes.forEach((checkbox) => {
            if (checkbox.checked) {
                const line = checkbox.closest('.line') || checkbox.closest('.line1'); // line 또는 line1 모두 확인
                const song = line.querySelector('.title').innerText;
                const artist = line.querySelector('.artist').innerText;
                const path = line.querySelector('.hidden').innerText;

                // 선택된 노래를 배열에 추가
                selectedSongs.push({ song, artist, path });
            }
        });

        if (selectedSongs.length > 0) {
            currentIndex = 0;
            playSongs(); // 첫 번째 노래부터 재생
        } else {
            alert('음악을 선택해 주세요.');
        }
    }
    
    function sortSongs(sortType) {
        // 'big-box' 클래스가 적용된 모든 박스를 찾습니다 (allMusic 및 각 playlist).
        const allBigBoxes = document.querySelectorAll('.big-box');

        allBigBoxes.forEach((bigBox) => {
            const allLines = bigBox.querySelectorAll('.line, .line1'); // 'line' 및 'line1' 클래스 모두 선택
            const linesArray = Array.from(allLines);

            if (sortType === 'popularity') {
                // 인기순으로 정렬
                linesArray.sort((a, b) => {
                    const userCountA = parseInt(a.querySelector('.user-count').innerText.trim());  // userCount 값을 가져옴
                    const userCountB = parseInt(b.querySelector('.user-count').innerText.trim());  // userCount 값을 가져옴
                    return userCountB - userCountA;  // 내림차순으로 정렬
                });

                // 페이지 2로 이동 후 다시 1로 이동
                showPage(2);
                showPage(1);
            } else if (sortType === 'alphabetical') {
                // 가나다순으로 정렬
                linesArray.sort((a, b) => {
                    const songA = a.querySelector('.title').innerText.trim();
                    const songB = b.querySelector('.title').innerText.trim();
                    return songA.localeCompare(songB, 'ko');
                });

                // 페이지 2로 이동 후 다시 1로 이동
                showPage(2);
                showPage(1);
            } else {
                // 기본 정렬 (data-index를 기준으로)
                linesArray.sort((a, b) => {
                    return parseInt(a.getAttribute('data-index')) - parseInt(b.getAttribute('data-index'));
                });

                showPage(2);
                showPage(1);
            }

            // 정렬된 노래 목록을 다시 렌더링
            bigBox.innerHTML = ''; // 기존 내용을 지움
            linesArray.forEach(line => bigBox.appendChild(line)); // 정렬된 내용을 추가
        });
    }
    
    

		////////////////////////////////////////////////////////////////////////////////////////////////////////////정현이형
        function showPage(page) {
		    const allLines = document.querySelectorAll('.line');
		    allLines.forEach(line => line.style.display = 'none');
		
		    const start = (page - 1) * pageSize;
		    const end = start + pageSize;
		
		    for (let i = start; i < end && i < totalItems; i++) {
		        allLines[i].style.display = 'flex';
		    }
		
		    // 현재 페이지를 업데이트하고 active 클래스 적용
		    currentIndex = page;
		    updateActivePage(page);
		}

		
		function updateActivePage(page) {
		    const allPageSpans = document.querySelectorAll('.page-span');
		    allPageSpans.forEach(span => {
		        span.classList.remove('active');
		    });
		    allPageSpans[page - 1].classList.add('active');
		}
		////////////////////////////////////////////////////////////////////////////////////////////////////////////////여기가 페이징 하는 함수에요
			

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
            // 현재 보여지고 있는 big-box만 선택 (style.display가 'block'인 요소)
            const visibleBigBox = document.querySelector('.big-box[style*="display: block"]');
            
            if (visibleBigBox) {
                const checkboxes = visibleBigBox.querySelectorAll('.checkbox-wrapper input[type="checkbox"]');
                checkboxes.forEach((checkbox) => {
                    checkbox.checked = source.checked;
                });
            }
        }

        
     	// 팝업을 여는 함수
        document.addEventListener('DOMContentLoaded', function () {
	        const icons = document.querySelectorAll('.small-icon5');
	        icons.forEach(function (icon) {
	            icon.addEventListener('click', function () {
	                const lineElement = icon.closest('.line, .line1');
	                const artist = lineElement.querySelector('.artist').innerText.trim();
	                const song = lineElement.querySelector('.title').innerText.trim();
	
	                selectedItemName = artist + " - " + song;
	
	                showPopup5();
	            });
	        });
	    });
	
	    function showPopup5() {
	        const popup = document.getElementById('popup5');
	        popup.classList.add('show5');
	    }
	
	    function closePopup5() {
	        const popup = document.getElementById('popup5');
	        popup.classList.remove('show5');
	    }
        
	    function addMusicToPlaylist(playlist) {
	        const user_id = '<%= user_id %>';  // 세션에서 가져온 user_id
	        const item_name = selectedItemName;  // 선택된 item_name

	        // AJAX 요청을 사용하여 서버에 데이터를 전송
	        if (playlist != null && item_name != null && user_id != null) {
	            var xhr = new XMLHttpRequest();
	            xhr.open("POST", "../yang/music1Proc.jsp", true);  // music1Proc.jsp로 POST 요청
	            xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
	            xhr.onreadystatechange = function() {
	                if (xhr.readyState === 4 && xhr.status === 200) {
	                    alert(xhr.responseText);  // 서버에서 응답이 도착하면 결과를 출력
	                    
	                    // 성공적으로 추가된 후 로컬 스토리지에 상태 저장
	                    if (xhr.responseText.includes("성공적으로 플레이리스트에 추가되었습니다.")) {
	                        localStorage.setItem('openBox', 'music');  // 로컬 스토리지에 저장
	                        location.reload();  // 페이지 새로고침
	                    }
	                }
	            };
	            var data = "playlist=" + encodeURIComponent(playlist) +
	                       "&item_name=" + encodeURIComponent(item_name) +
	                       "&user_id=" + encodeURIComponent(user_id);
	            xhr.send(data);  // 서버로 데이터 전송
	        }
	        closePopup5();  // 팝업 닫기
	    }

	    // 새로고침 후에 특정 함수 실행
	    document.addEventListener('DOMContentLoaded', function () {
	        const openBox = localStorage.getItem('openBox');
	        if (openBox === 'music') {
	            clickOpenBox('music');  // 새로고침 후에 실행할 함수 호출
	            localStorage.removeItem('openBox');  // 상태를 제거하여 중복 실행 방지
	        }
	    });
		
	    
	    //삭제함수
	    function deleteSelectedSongs() {
		    const visibleBigBox = document.querySelector('.big-box[style*="display: block"]'); // 현재 보이는 big-box
		    if (!visibleBigBox) {
		        alert("삭제할 음악이 없습니다.");
		        return;
		    }
		
		    // 체크된 항목을 가져옴
		    const checkboxes = visibleBigBox.querySelectorAll('.checkbox-wrapper input[type="checkbox"]:checked');
		    if (checkboxes.length === 0) {
		        alert("삭제할 항목을 선택하세요.");
		        return;
		    }
		
		    checkboxes.forEach((checkbox) => {
		        const line = checkbox.closest('.line') || checkbox.closest('.line1');
		        const artist = line.querySelector('.artist').innerText.trim();
		        const song = line.querySelector('.title').innerText.trim();
		        const item_name = artist + " - " + song;
		
		        if (visibleBigBox.id === "allMusic") {
		            // allMusic에서 삭제
		            deleteMusicByUserIdAndItemName(item_name);
		        } else if (visibleBigBox.id.startsWith("playlist-")) {
		            // playlist에서 삭제 (정확한 playlist 이름을 데이터 속성에서 추출)
		            const playlistName = visibleBigBox.getAttribute("data-playlist-name"); // data-playlist-name 속성에서 실제 이름을 가져옴
		            deleteMusicFromPlaylist(item_name, playlistName);
		        }
		    });
		}


	    function deleteMusicByUserIdAndItemName(item_name) {
	        const user_id = '<%= user_id %>';  // 세션에서 가져온 user_id
	        const xhr = new XMLHttpRequest();
	        xhr.open("POST", "../yang/deleteMusicProc.jsp", true);  // deleteMusicByUserIdAndItemName 처리하는 JSP 호출
	        xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
	        xhr.onreadystatechange = function() {
	            if (xhr.readyState === 4 && xhr.status === 200) {
	            	alert("삭제되었습니다.");
	                location.reload();  // 페이지 새로고침
	            }
	        };
	        xhr.send("user_id=" + encodeURIComponent(user_id) + "&item_name=" + encodeURIComponent(item_name));
	    }

	    function deleteMusicFromPlaylist(item_name, playlist) {
	        const user_id = '<%= user_id %>';  // 세션에서 가져온 user_id
	        const xhr = new XMLHttpRequest();
	        xhr.open("POST", "../yang/deleteMusicFromPlaylistProc.jsp", true);  // deleteMusicFromPlaylist 처리하는 JSP 호출
	        xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
	        xhr.onreadystatechange = function() {
	            if (xhr.readyState === 4 && xhr.status === 200) {
	            	alert("삭제되었습니다.");
	                location.reload();  // 페이지 새로고침
	            }
	        };
	        xhr.send("user_id=" + encodeURIComponent(user_id) + "&item_name=" + encodeURIComponent(item_name) + "&playlist=" + encodeURIComponent(playlist));
	    }
	    

    </script>
    
    
</head>
<body>    
    <div class="music-title">
	    <span>내 음악</span>
	    <!-- 새로운 셀렉트 박스 추가 -->
	    <div class="music-title-select-wrapper">
	        <select class="music-title-select" onchange="sortSongs(this.value)">
	            <option value="default">기본 정렬</option>
	            <option value="alphabetical">가나다순</option>
	            <option value="popularity">인기순</option>
	        </select>
	    </div>
	</div>

    <div class="top-box">
        <div class="checkbox-wrapper" style="margin-top:20px;">
            <input type="checkbox" id="selectAll" onclick="toggleAllCheckboxes(this)"> <!-- 제일 위 체크박스 -->
        </div>
        <div class="title" style="margin-top:10px; font-weight: bold;">곡명</div>
        <div class="artist" style="margin-top:10px; font-weight: bold;">아티스트</div>
    </div>
    

    <div class="big-box" id="allMusic" style="display: block;">
    
        <%
	        for (int i = 0; i < musicvlist.size(); i++) {
	            MusicBean music = musicvlist.get(i);
	            String[] songInfo = music.getItem_name().split("-", 2);
	            String artist = songInfo.length > 1 ? songInfo[0].trim() : "";
	            String song = songInfo.length > 1 ? songInfo[1].trim() : songInfo[0];
	            
	            // 기본 user_count를 0으로 초기화
	            int userCount = 0;
	
	            // popularMusicList에서 같은 곡이 있는지 확인
	            for (int j = 0; j < popularMusicList.size(); j++) {
	                MusicBean popularMusic = popularMusicList.get(j);
	                String[] popularSongInfo = popularMusic.getItem_name().split("-", 2);
	                String popularSong = popularSongInfo.length > 1 ? popularSongInfo[1].trim() : popularSongInfo[0];
	
	                // song과 popularSong이 같은지 비교
	                if (song.equals(popularSong)) {
	                    userCount = popularMusic.getUserCount(); // user_count 값을 가져옴
	                    break; // 일치하는 곡을 찾았으므로 루프 종료
	                }
	            }
	    %>
        <div class="line" data-index="<%= i %>">
            <div class="checkbox-wrapper">
                <input type="checkbox">
            </div>
            <div class="title">
                <%= song %>
            </div>
            <div class="artist">
                <%= artist %>
                <img src="../miniroom/img/musicicon.png" alt="icon" class="small-icon5">
            </div>
            <div class="user-count" style="display:none;">
	            <%= userCount %>  <!-- 일치하는 user_count 값을 출력 -->
	        </div>
            <div class="hidden">
                <%= music.getItem_path() %>
            </div>
        </div>
        <%
            }
        %>
    </div>

    <!-- 플레이리스트별로 곡 출력 -->
    <%
        for (int p = 0; p < playlists.size(); p++) {
            String playlistName = playlists.get(p);
            
            // 각 플레이리스트에 해당하는 음악 리스트 가져오기
            Vector<MusicBean> musicplayvlist = mgr.getMusicListByPlaylist(user_id, playlistName);
            
    %>

    <div class="big-box" id="playlist-<%= p %>" data-playlist-name="<%= playlistName %>" style="display: none;">
        <!-- 플레이리스트에 해당하는 음악 리스트 출력 -->
        <%
	        for (int i = 0; i < musicplayvlist.size(); i++) {
	            MusicBean music = musicplayvlist.get(i);
	            String[] songInfo = music.getItem_name().split("-", 2);
	            String artist = songInfo.length > 1 ? songInfo[0].trim() : "";
	            String song = songInfo.length > 1 ? songInfo[1].trim() : songInfo[0];
	
	            // 기본 user_count를 0으로 초기화
	            int userCount = 0;
	
	            // popularMusicList에서 같은 곡이 있는지 확인
	            for (int j = 0; j < popularMusicList.size(); j++) {
	                MusicBean popularMusic = popularMusicList.get(j);
	                String[] popularSongInfo = popularMusic.getItem_name().split("-", 2);
	                String popularSong = popularSongInfo.length > 1 ? popularSongInfo[1].trim() : popularSongInfo[0];
	
	                // song과 popularSong이 같은지 비교
	                if (song.equals(popularSong)) {
	                    userCount = popularMusic.getUserCount(); // user_count 값을 가져옴
	                    break; // 일치하는 곡을 찾았으므로 루프 종료
	                }
	            }
	    %>
        <div class="line1" data-index="<%= i %>">
            <div class="checkbox-wrapper">
                <input type="checkbox">
            </div>
            <div class="title">
                <%= song %>
            </div>
            <div class="artist">
                <%= artist %>
            </div>
	        <div class="user-count" style="display:none;">
	            <%= userCount %>  <!-- 일치하는 user_count 값을 출력 -->
	        </div>
            <div class="hidden">
                <%= music.getItem_path() %>
            </div>
        </div>
        <%
            }
        %>
    </div>

    <%
        }
    %>

    <div class="small-box">
    	<div class="top-right-buttons">
    		<button onclick="deleteSelectedSongs()">삭제</button>
            <button onclick="setBackgroundMusic()">배경음악 설정</button>
            
        </div>
        <!-- 정현이형!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! -->
		<!-- 페이지네이션 -->
		<div style ="display:flex ; align-items:center">
			<div id ="center-buttons" class="center-buttons">
			</div>
		</div>
        <!-- 페이지버튼이에요!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! -->
        
        
        
        <!-- 팝업 HTML 구조 -->  
    </div>
    <div class="popup5" id="popup5">
		<div class="popup-content5">
		    <div id="playlist-content">
            <%
			    // 세션에서 user_id를 가져와 플레이리스트를 출력
			    if (user_id != null) {
			        Vector<String> playlists1 = mgr.getUserPlaylists(user_id);
			
			        // 플레이리스트를 화면에 출력
			        if (playlists1 != null && playlists1.size() > 0) {
			            for (int i = 0; i < playlists1.size(); i++) {
			                String playlist = playlists1.get(i);
			%>
			                <div class="playlist-item" onclick="addMusicToPlaylist('<%= playlist %>')">
			                    <img src="../seyoung/img/folder.png" width="50" height="50" alt="folder icon" />
			                    <span><%= playlist %></span>
			                </div>
			<%
			            }
			        } else {
			%>
			            <p>플레이리스트가 없습니다.</p>
			<%
			        }
			    } 
			%>

        </div>
		    <button class="close-button5" onclick="closePopup5()">닫기</button>
		</div>
	</div>
	
</body>
</html>
