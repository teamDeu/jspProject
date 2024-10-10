<%@ page import="java.util.HashMap"%>
<%@ page import="music.MusicBean"%>
<%@ page import="java.util.Vector"%>
<%@page import="board.BoardFolderMgr"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" 
          pageEncoding="UTF-8" isELIgnored="false" %>
<%@ page import="java.sql.*, pjh.MemberBean, pjh.DBConnectionMgr"%>
<jsp:useBean id="mgr1" class="music.MusicMgr" />
<%
	BoardFolderMgr mgr = new BoardFolderMgr();
	int latestNum = mgr.getLatestBoardFolder().getFolder_num();
	String id = (String)session.getAttribute("idKey");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Playlist</title>

    <style>

        .pli-top-content {
            display: flex;
            margin-bottom: 20px;
        }

        .pli-text-left,
        .pli-text-right {
        	margin-left: 80px;
            font-size: 25px;
            color: #333;
            transition: color 0.3s ease;
            cursor: pointer;
        }

        .pli-text-left:hover,
        .pli-text-right:hover {
            color: #FF6347;
        }

        .pli-vertical-line {
            width: 1px;
            height: 36px;
            background-color: #BAB9AA;
            margin: 0 10px;
        }

        .pli-horizontal-line {
            border: none;
            height: 1px;
            background-color: #BAB9AA;
            margin-top: -20px;
        }

        .playlist-item {
            display: flex;
            align-items: center;
            margin-top: 10px;
            cursor: pointer;
        }

        .playlist-item:hover {
            color: #FF6347;
        }

        .playlist-item img {
            margin-right: 10px;
        }

        .playlist-item span {
            font-size: 25px;
            font-weight: bold;
            transition: color 0.3s ease;
        }

        .playlist-item:hover span {
            color: #FF6347;
        }

        /* 클릭된 상태에서 색을 유지하는 스타일 */
        .playlist-item.active span {
            color: #FF6347; /* 클릭 후 색상 유지 */
        }
        /* 전체음악에 active 클래스를 적용했을 때 빨간색으로 유지 */
		.pli-text-left.active {
		    color: #FF6347;
		}
        
    </style>

    <script>
        let currentActive = null;
		
     	// 전체음악 클릭 시 active 클래스를 적용하는 함수
        function setAllMusicActive(element) {
            // 이전에 선택된 항목에서 active 클래스를 제거
            if (currentActive) {
                currentActive.classList.remove('active');
            }

            // 전체음악에 active 클래스를 추가
            element.classList.add('active');
            currentActive = element; // 현재 활성화된 항목을 저장
        }

        //플레이리스트 이름을 서버로 보냄
        function setPlaylist(playlistName, element) {
            // 서버에 선택한 플레이리스트 이름을 전송하는 AJAX 요청
            fetch('../yang/music1.jsp', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/x-www-form-urlencoded'
                },
                body: 'playlistName=' + encodeURIComponent(playlistName)
            })
            .then(response => response.text())
            .then(data => {
                console.log(data);
            });

            // 이전에 선택된 항목에서 active 클래스를 제거
            if (currentActive) {
                currentActive.classList.remove('active');
            }

            // 현재 클릭된 항목에 active 클래스를 추가
            element.classList.add('active');
            currentActive = element; // 현재 활성화된 항목을 저장
        }

        function showPlaylist(playlistId) {
            // 선택한 플레이리스트를 화면에 보여주는 함수
            console.log("선택된 playlistId: " + playlistId);
        }
        var userId = '<%=id%>'; // 실제로는 세션에서 사용자 ID를 가져와야 합니다.
        var selectedFolderItem = null; // 현재 선택된 폴더를 저장할 변수
    	var latestNum = <%=latestNum%>;
    	
    	///////////////////////////////////////////////////////////////////////////////////////////////////
    	///////////////////////////////////////////////////////////////////////////////////////////////////
    	
        function toggleFolderInput1() {
		    var inputContainer = document.getElementById('folderInputContainer1');
		    var deleteButtons = document.querySelectorAll('.delete-button1'); // 모든 삭제 버튼을 선택
		
		    // 폴더 입력 컨테이너의 표시 여부를 토글
		    if (inputContainer.style.display === 'flex') {
		        inputContainer.style.display = 'none'; // 입력 컨테이너 숨김
		        // 모든 삭제 버튼을 숨김
		        deleteButtons.forEach(function(button) {
		            button.style.display = 'none';
		        });
		    } else {
		        inputContainer.style.display = 'flex'; // 입력 컨테이너 표시
		        // 모든 삭제 버튼을 표시
		        deleteButtons.forEach(function(button) {
		            button.style.display = 'flex';
		        });
		    }
		}

		
        //폴더 추가
        function addFolder1() {
		    var folderName = document.getElementById('folderNameInput1').value.trim();
		
		    if (folderName === '') {
		        alert('폴더명을 입력하세요.');
		        return;
		    }
		
		    // 서버로 폴더명을 전송하는 AJAX 요청
		    fetch('../yang/addFolder.jsp', {
		        method: 'POST',
		        headers: {
		            'Content-Type': 'application/x-www-form-urlencoded'
		        },
		        body: 'folderName=' + encodeURIComponent(folderName) + '&userId=' + encodeURIComponent(userId)
		    })
		    .then(response => response.text())
		    .then(data => {
		        if (data === 'success') {
		            // 새로운 폴더를 동적으로 추가
		            addFolderToDOM1(folderName);
		            document.getElementById('folderNameInput1').value = ''; // 입력창 초기화
		        } else {
		        	addFolderToDOM1(folderName);
		            document.getElementById('folderNameInput1').value = ''; // 입력창 초기화
		        }
		    })
		    .catch(error => {
		        console.error('Error:', error);
		        alert('오류가 발생했습니다.');
		    });
		}
		
        function addFolderToDOM1(folderName) {
            var playlistContent = document.getElementById('playlist-content');

            var newFolderDiv = document.createElement('div');
            newFolderDiv.className = 'playlist-item';
            newFolderDiv.style.position = 'relative';

            // 클릭 시 폴더를 선택하고 플레이리스트를 표시
            newFolderDiv.onclick = function() {
                setPlaylist(folderName, newFolderDiv);
                showPlaylist('playlist-' + folderName);
            };

            // 이미지 추가 (폴더 아이콘)
            var folderImg = document.createElement('img');
            folderImg.src = '../seyoung/img/folder.png';
            folderImg.width = 50;
            folderImg.height = 50;
            folderImg.alt = 'folder icon';

            // 폴더명 텍스트 추가
            var folderSpan = document.createElement('span');
            folderSpan.textContent = folderName;
            folderSpan.style.fontSize = '25px';
            folderSpan.style.fontWeight = 'bold';

            // 삭제 버튼 추가
            var deleteButton = document.createElement('img');
            deleteButton.src = '../seyoung/img/trashcan.png'; // 삭제 버튼 이미지 경로
            deleteButton.width = 30;
            deleteButton.height = 30;
            deleteButton.alt = 'delete icon';
            deleteButton.className = 'delete-button'; // 삭제 버튼에 클래스 추가
            deleteButton.style.position = 'absolute';
            deleteButton.style.right = '10px';
            deleteButton.style.cursor = 'pointer';

            // 삭제 버튼 클릭 시 폴더 삭제 처리
            deleteButton.onclick = function(event) {
                event.stopPropagation(); // 부모 요소의 클릭 이벤트 방지
                deleteFolder1(folderName, newFolderDiv); // 폴더 삭제 기능 호출
            };

            // 새 요소들을 div에 추가
            newFolderDiv.appendChild(folderImg);
            newFolderDiv.appendChild(folderSpan);
            newFolderDiv.appendChild(deleteButton);

            // playlist-content에 새로운 div를 추가
            playlistContent.appendChild(newFolderDiv);
        }


        function deleteFolder1(folderName, folderElement) {
            // 서버로 삭제 요청을 보내는 AJAX 요청
            fetch('../yang/deleteFolder.jsp', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/x-www-form-urlencoded'
                },
                body: 'userId=' + encodeURIComponent(userId) + '&playlist=' + encodeURIComponent(folderName)
            })
            .then(response => response.text())
            .then(data => {
                if (data === 'success') {
                    // 삭제가 성공하면 해당 폴더를 DOM에서 제거
                    folderElement.remove();
                } else {
                	folderElement.remove();
                }
            })
            .catch(error => {
                console.error('Error:', error);
                alert('오류가 발생했습니다.');
            });
        }










        
    </script>
    

</head>
<body>
    <div class="folder-container">
        <div class="pli-top-content">
            <span onclick="setAllMusicActive(this); showPlaylist('allMusic')" class="pli-text-left" style="font-weight: bold;">전체음악</span>
        </div>
        <hr class="pli-horizontal-line">

        <div id="playlist-content">
            <%
			    // 세션에서 user_id를 가져와 플레이리스트를 출력
			    if (id != null) {
			        Vector<String> playlists = mgr1.getUserPlaylists(id);
			
			        // 플레이리스트를 화면에 출력
			        if (playlists != null && playlists.size() > 0) {
			            for (int i = 0; i < playlists.size(); i++) {
			                String playlist = playlists.get(i);
			%>
			                <div class="playlist-item" style="position: relative;" onclick="setPlaylist('<%= playlist %>', this); showPlaylist('playlist-<%= i %>')">
			                    <img src="../seyoung/img/folder.png" width="50" height="50" alt="folder icon" />
			                    <span style="font-size: 25px; font-weight: bold;"><%= playlist %></span>
			
			                    <!-- 삭제 버튼 추가 -->
			                    <img src="../seyoung/img/trashcan.png" width="30" height="30" alt="delete icon"
								     class="delete-button1" style="position: absolute; right: 10px; cursor: pointer; display: none;"
								     onclick="event.stopPropagation(); deleteFolder1('<%= playlist %>', this.parentElement);" />

			                </div>
			<%
			            }
			        } else {
			%>
			            <p>플레이리스트가 없습니다.</p>
			<%
			        }
			    } else {
			%>
			        <p>로그인이 필요합니다.</p>
			<%
			    }
			%>

        </div>
        <div class="folder-input-container" id="folderInputContainer1">
	        <img src="../seyoung/img/folder.png" alt="Folder Icon">
	        <input type="text" id="folderNameInput1" placeholder="폴더명을 입력하세요.">
	        <button onclick="addFolder1()">
	            <img src="../seyoung/img/plus.png">
	        </button>
	    </div>     
    <button class="folder-manage-button" id="folderManageButton" onclick="toggleFolderInput1()">폴더 관리 하기</button>
    </div>
</body>
</html>

