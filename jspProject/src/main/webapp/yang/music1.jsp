<%@page import="java.util.HashMap"%>
<%@page import="music.MusicBean"%>
<%@page import="java.util.Vector"%>
<%@ page import="com.google.gson.Gson" %>

<%@ page language="java" contentType="text/html; charset=UTF-8" 
                  pageEncoding="UTF-8" isELIgnored="false" %>
<%@ page import="java.sql.*, pjh.MemberBean, pjh.DBConnectionMgr"%>
<jsp:useBean id="mgr" class="music.MusicMgr" />
<%
    // 세션에서 user_id를 가져옴
    String user_id = request.getParameter("music_id");
   

    // user_id에 해당하는 음악 리스트를 가져옴
    Vector<MusicBean> musicvlist = mgr.getMusicList(user_id);
    
    Vector<String> playlists = mgr.getUserPlaylists(user_id);
    
    Vector<MusicBean> popularMusicList = mgr.getPopularMusicList();
    
    Vector<MusicBean> usedMusicList = mgr.getUsedItemsByUser(user_id);
    Gson gson = new Gson();
    String usedMusicJson = gson.toJson(usedMusicList);
    
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
            border: 1px solid #BAB9AA;
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
            height: 60px;
            border: 1px solid #BAB9AA;
            margin-top: 0px;
            position: relative;
            border-top: none;  /* 하단 테두리를 없앰 */
        }
        
        .top-box {
            width: 800px;
            height: 50px;
            border: 1px solid #BAB9AA;
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
            width: 830px;
            height: 1px;
            background-color: #BAB9AA;
            margin: 0 auto;
            position: relative;
            margin-top: 70px;
         margin-bottom: 20px;
        }

        .music-title span {
            position: absolute;
            top: -45px;
            left: 0;
            font-size: 36px;
          font-weight: 600;
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
          background-color: #F7F7F7; /* 배경색 설정 */
          border-radius: 10px; /* 꼭짓점 둥글게 */
          border: 1px solid #ccc; /* 선택박스 테두리 */
          appearance: none; /* 기본 셀렉트박스 스타일 제거 (브라우저마다 다를 수 있음) */
          width: 100px;
          text-align: center; /* 텍스트 중앙 정렬 */
          text-align-last: center; /* IE 및 Firefox에서의 텍스트 정렬 */
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
    let currentIndex = 0;
    let currentIndex1 = 1;
    let selectedSongs = [];
    let selectedItemName = "";
    const pageSize = 10;
    const totalItems = <%= musicvlist.size() %>;
    const totalPages = Math.ceil(totalItems / pageSize);
    const audioPlayer = document.getElementById('audioPlayer');
    const titleElement = document.querySelector('.title');
    const artistElement = document.querySelector('.artist');
    const usedMusicList = <%= usedMusicJson %>;

    // URL 기반으로 로컬 스토리지에서 노래 목록 가져오기 또는 DB에서 가져오기
    document.addEventListener('DOMContentLoaded', function () {
    const currentUrl = window.location.href;  // 쿼리 파라미터를 포함한 전체 URL
    const initialUrl = localStorage.getItem('initialUrl');
    const audioPlayer = document.getElementById('audioPlayer');
    const titleElement = document.querySelector('.title');
    const artistElement = document.querySelector('.artist');

    console.log('초기 URL:', initialUrl);  // 디버그용 로그 출력
    console.log('현재 URL:', currentUrl);  // 디버그용 로그 출력

    // 초기 URL이 저장되어 있지 않으면, 현재 URL을 저장 (최초 접속한 URL)
    if (!initialUrl) {
        localStorage.setItem('initialUrl', currentUrl);
    }

    // 초기 URL로 돌아왔을 때는 로컬 스토리지에서 노래를 불러옴
    if (currentUrl === initialUrl) {
        console.log('처음 접속한 URL입니다. 로컬 스토리지에서 노래를 불러옵니다.');
        const savedSelectedSongs = localStorage.getItem('selectedSongs');
        const savedSong = localStorage.getItem('currentSong');
        const savedTime = localStorage.getItem('savedTime');
        const savedTitle = localStorage.getItem('currentSongTitle');
        const savedArtist = localStorage.getItem('currentArtist');
        const savedIndex = localStorage.getItem('currentIndex');
        
        

        if (savedSelectedSongs) {
            selectedSongs = JSON.parse(savedSelectedSongs);  // 로컬 스토리지에서 노래 목록 가져오기
            currentIndex = savedIndex ? parseInt(savedIndex) : 0;  // 인덱스를 로드, 없으면 0으로 설정
            playSongs(currentIndex);
        }

        if (savedSong && savedTime) {
            // 이전에 저장된 노래 정보 및 시간 불러오기
            audioPlayer.src = savedSong;
            titleElement.innerText = savedTitle || '제목 없음';
            artistElement.innerText = savedArtist || '아티스트 없음';
            audioPlayer.currentTime = parseFloat(savedTime);

            // 자동 재생 시작
            audioPlayer.play();
        }
    } else {
        // 다른 URL일 경우 DB에서 item_using이 1인 항목을 가져옴
        console.log('다른 URL입니다. DB에서 노래 목록을 가져옵니다.');
        const usedMusicList = <%= new Gson().toJson(usedMusicList) %>;  // JSP에서 JavaScript로 데이터 전송
     // DB에서 item_using이 1인 항목을 가져옴
        if (usedMusicList && usedMusicList.length > 0) {
            selectedSongs = [];  // 다른 URL에선 로컬 스토리지의 영향을 받지 않음
            usedMusicList.forEach((music) => {
                // 아티스트와 곡명을 '-'로 분리
                const songInfo = music.item_name.split('-');  
                const artist = songInfo.length > 1 ? songInfo[0].trim() : "";  // 아티스트
                const song = songInfo.length > 1 ? songInfo[1].trim() : songInfo[0];  // 곡 제목

                // song과 artist가 있는 데이터를 선택 목록에 추가
                selectedSongs.push({
                    song: song,
                    artist: artist,
                    path: music.item_path  // 경로
                });
            });
            playSongs(0);  // 첫 번째 곡부터 재생
        } else {
            console.log('DB에서 가져온 노래가 없습니다.');
        }

    }

    // 현재 재생 시간을 주기적으로 로컬 스토리지에 저장 (로컬에서만 동작)
    audioPlayer.ontimeupdate = function () {
        localStorage.setItem('savedTime', audioPlayer.currentTime);
        localStorage.setItem('currentIndex', currentIndex);  // currentIndex를 로컬 스토리지에 저장
    };

    // 음악이 끝나면 다음 곡 재생
    audioPlayer.onended = function () {
        playNextSong();
    };
});


   




   
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
        updateActivePage(currentIndex1);
    }

   
    function showPlaylist(playlistId) {
       // 모든 big-box를 숨기고 체크박스를 해제
       document.querySelectorAll('.big-box').forEach(box => {
           // big-box를 숨김
           box.style.display = 'none';
   
           // 숨긴 big-box 안의 모든 체크박스를 해제
           const checkboxes = box.querySelectorAll('.checkbox-wrapper input[type="checkbox"]');
           checkboxes.forEach((checkbox) => {
               checkbox.checked = false; // 체크 해제
           });
       });
   
       // 선택한 playlistId에 해당하는 big-box가 존재하는지 확인
       let selectedPlaylist = document.getElementById(playlistId);
   
       if (!selectedPlaylist) {
           // playlistId가 없으면 새로운 big-box를 생성하여 추가
           selectedPlaylist = document.createElement('div');
           selectedPlaylist.className = 'big-box'; // 기존 big-box 클래스 적용
           selectedPlaylist.id = playlistId; // id를 playlistId로 설정
           selectedPlaylist.innerHTML = `<!-- playlist에 곡이 없을 때 표시할 내용 -->`;
   
           // small-box 위에 big-box를 추가
           const smallBox = document.querySelector('.small-box');
           smallBox.parentNode.insertBefore(selectedPlaylist, smallBox); // small-box 위에 추가
       }
   
       // 선택한 big-box를 보이도록 설정
       selectedPlaylist.style.display = 'block';
   
       // top-box 체크박스 초기화 (해제)
       document.getElementById('selectAll').checked = false;
   }



    function playSongs(index) {
        if (index >= selectedSongs.length) {
            currentIndex = 0;  // 마지막 곡이면 처음으로 돌아감
        } else if (index < 0) {
            currentIndex = selectedSongs.length - 1;  // 첫 곡이면 마지막 곡으로 이동
        }

        const currentSong = selectedSongs[currentIndex];
        const audioPlayer = document.getElementById('audioPlayer');
        const titleElement = document.querySelector('.title');
        const artistElement = document.querySelector('.artist');

        // 노래 정보 재생
        audioPlayer.src = currentSong.path;
        titleElement.innerText = currentSong.song;
        artistElement.innerText = currentSong.artist || '아티스트';

        // 재생 시작
        audioPlayer.play();

        localStorage.setItem('currentSong', currentSong.path);
        localStorage.setItem('currentSongTitle', currentSong.song);
        localStorage.setItem('currentArtist', currentSong.artist || '');
        localStorage.setItem('currentIndex', currentIndex);  // 곡 재생 시 currentIndex 저장
    }

    // 음악이 끝났을 때 다음 곡 재생
    function playNextSong() {
        currentIndex++;
        playSongs(currentIndex);
    }

    // 이전 곡 재생 함수
    function playPreviousSong() {
        currentIndex--;
        playSongs(currentIndex);
    }
        

    function setBackgroundMusic() {
        const allCheckboxes = document.querySelectorAll('.big-box .checkbox-wrapper input[type="checkbox"]');
        selectedSongs = []; // 선택된 노래를 담을 배열 초기화

        // 먼저 사용자의 모든 item_using 값을 0으로 설정
        const user_id = '<%= user_id %>';  // 세션에서 가져온 user_id
        resetAllItemUsage(user_id);

        allCheckboxes.forEach((checkbox) => {
            if (checkbox.checked) {  // 체크박스가 체크되었는지 확인
                const line = checkbox.closest('.line') || checkbox.closest('.line1'); // line 또는 line1 모두 확인
                const originalDisplay = line.style.display;
                line.style.display = "flex"; // 노래가 표시되도록 설정

                // 곡명, 아티스트, 경로 정보 가져오기
                const song = line.querySelector('.title').innerText.trim();
                const artist = line.querySelector('.artist').innerText.trim();
                const path = line.querySelector('.hidden').innerText.trim();

                // 콘솔에 로그를 찍어서 값이 제대로 들어오는지 확인
                console.log(`Selected Song: ${song}, Artist: ${artist}, Path: ${path}`);

                // 기존 display 상태 복원
                line.style.display = originalDisplay;

                // 선택된 노래 정보를 배열에 추가
                selectedSongs.push({
                    song: song,
                    artist: artist,
                    path: path
                });

                // 체크된 각 노래에 대해 item_using 값을 1로 설정
                updateSingleItemUsage(user_id, path);
            }
        });

        // 선택된 노래가 있는지 확인
        if (selectedSongs.length > 0) {
            // 선택된 노래가 있으면 로컬 스토리지에 저장
            localStorage.setItem('selectedSongs', JSON.stringify(selectedSongs));
            alert('배경음악이 설정되었습니다.');

            // 첫 번째 노래를 재생
            currentIndex = 0;
            playSongs(currentIndex);
        } else {
            alert('음악을 선택해 주세요.');
        }
    }
    
    
    function afterReloadFunction() {
        // id가 custom-button-chatBox인 네모박스 배경색 변경
        const chatBoxElement = document.getElementById('custom-button-chatBox');
        if (chatBoxElement) {
            chatBoxElement.style.backgroundColor = '#C0E5AF';
        }

        // id가 custom-button-music인 네모박스 배경색 변경
        const musicBoxElement = document.getElementById('custom-button-music');
        if (musicBoxElement) {
            musicBoxElement.style.backgroundColor = '#F7F7F7';
        }
    }



    function resetAllItemUsage(user_id) {
        // AJAX 요청을 사용하여 resetAllItemUsage를 서버에 전송
        var xhr = new XMLHttpRequest();
        xhr.open("POST", "../yang/resetAllItemUsageProc.jsp", true); // resetAllItemUsage를 처리하는 JSP 호출
        xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
        xhr.send("user_id=" + encodeURIComponent(user_id));
    }

    function updateSingleItemUsage(user_id, item_path) {
        // AJAX 요청을 사용하여 updateSingleItemUsage를 서버에 전송
        var xhr = new XMLHttpRequest();
        xhr.open("POST", "../yang/updateSingleItemUsageProc.jsp", true); // updateSingleItemUsage를 처리하는 JSP 호출
        xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
        xhr.onreadystatechange = function() {
            if (xhr.readyState === 4 && xhr.status === 200) {
                console.log("업데이트 완료: " + xhr.responseText);  // 서버 응답 출력 (디버깅 용도)
            }
        };
        xhr.send("user_id=" + encodeURIComponent(user_id) + "&item_path=" + encodeURIComponent(item_path));
    }




    // 페이지가 로드될 때, 로컬 스토리지에서 선택한 노래 리스트를 불러옴
    document.addEventListener('DOMContentLoaded', function () {
        const audioPlayer = document.getElementById('audioPlayer');

        // 재생 시간 저장
        audioPlayer.ontimeupdate = function () {
            localStorage.setItem('savedTime', audioPlayer.currentTime);
        };

        // 음악이 끝나면 다음 곡 재생
        audioPlayer.onended = function () {
            playNextSong();
        };
    });

    
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
            } else if (sortType === 'alphabetical') {
                // 가나다순으로 정렬
                linesArray.sort((a, b) => {
                    const songA = a.querySelector('.title').innerText.trim();
                    const songB = b.querySelector('.title').innerText.trim();
                    return songA.localeCompare(songB, 'ko');
                });
            } else {
                // 기본 정렬 (data-index를 기준으로)
                linesArray.sort((a, b) => {
                    return parseInt(a.getAttribute('data-index')) - parseInt(b.getAttribute('data-index'));
                });
            }

            // 정렬된 노래 목록을 다시 렌더링
            bigBox.innerHTML = ''; // 기존 내용을 지움
            linesArray.forEach(line => bigBox.appendChild(line)); // 정렬된 내용을 추가

            // 한 페이지인 경우에도 1페이지를 보여주도록 호출
            showPage(1); // 항상 첫 페이지를 다시 보여줌

            // 만약 두 페이지 이상이라면, 페이지 2로 이동 후 다시 1로 이동하여 전체 리스트를 갱신
            if (totalPages > 1) {
                showPage(2);
                showPage(1);
            }
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
          currentIndex1 = page;
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
        	updateMusicPagination();
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
                    	   localStorage.setItem('executeAfterReload', 'true');
                           localStorage.setItem('openBox', 'music');  // 로컬 스토리지에 'music' 저장
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
               localStorage.removeItem('openBox');  // 값을 바로 삭제하여 남아있지 않게 처리
               clickOpenBox('music');  // 새로고침 후에 실행할 함수 호출
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
            	   localStorage.setItem('executeAfterReload', 'true');
                   localStorage.setItem('openBox', 'music');  // 로컬 스토리지에 'music' 저장
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
            	   localStorage.setItem('executeAfterReload', 'true');
                   localStorage.setItem('openBox', 'music');  // 로컬 스토리지에 'music' 저장
                   location.reload();  // 페이지 새로고침
               }
           };
           xhr.send("user_id=" + encodeURIComponent(user_id) + "&item_name=" + encodeURIComponent(item_name) + "&playlist=" + encodeURIComponent(playlist));
       }
       

    </script>
    
    
</head>
<body>    
    <div class="music-title">
       <span style="margin-bottom: 100px;">내 음악</span>
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
                <img src="../yang/img/folderplus.png" alt="icon" class="small-icon5">
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
                             <img src="../yang/img/folderplus.png" width="50" height="50" alt="folder icon" />
                             <span><%= playlist %></span>
                         </div>
         <%
                     }
                 } else {
         %>
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