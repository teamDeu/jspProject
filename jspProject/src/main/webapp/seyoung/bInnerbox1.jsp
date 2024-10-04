<%@page import="board.BoardFolderMgr"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	BoardFolderMgr mgr = new BoardFolderMgr();
	int latestNum = mgr.getLatestBoardFolder().getFolder_num();
	String id = (String)session.getAttribute("idKey");
	
%>
<!-- bInnerbox1.jsp -->
<div class="folder-container">
    <div class="folder-input-container" id="folderInputContainer">
        <img src="../seyoung/img/folder.png" alt="Folder Icon">
        <input type="text" id="folderNameInput" placeholder="폴더명을 입력하세요.">
        <button onclick="addFolder()">
            <img src="../seyoung/img/plus.png">
        </button>
    </div>     
    <button class="folder-manage-button" id="folderManageButton" onclick="toggleFolderInput()">폴더 관리 하기</button>
</div>

<script>
    var userId = '<%=id%>'; // 실제로는 세션에서 사용자 ID를 가져와야 합니다.
    var selectedFolderItem = null; // 현재 선택된 폴더를 저장할 변수
	var latestNum = <%=latestNum%>;
    function toggleFolderInput() {
        var inputContainer = document.getElementById('folderInputContainer');
        var deleteButtons = document.querySelectorAll('.delete-button'); // 모든 삭제 버튼을 가져옴

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

    // 폴더 추가 기능
	function addFolder() {
	    var folderNameInput = document.getElementById('folderNameInput');
	    var folderName = folderNameInput.value.trim();
	
	    if (folderName !== '') {
	        var xhr = new XMLHttpRequest();
	        xhr.open('POST', '../seyoung/bFolderAddProc.jsp', true);
	        xhr.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
	
	        xhr.onreadystatechange = function() {
	            if (xhr.readyState === 4 && xhr.status === 200) {
	                var responseText = xhr.responseText.trim();
	                if (responseText.startsWith('success')) { // 응답이 'success'로 시작하면 추가 성공
	                    var folderNum = responseText.split(',')[1]; // 폴더 번호 추출
	                    alert('폴더가 추가되었습니다.');
	                    addFolderToDOM(folderName, folderNum); // 폴더를 DOM에 추가
	                    folderNameInput.value = ''; // 입력 필드 초기화
	                    // inputContainer.style.display = 'none'; // 폴더 추가 후 입력 영역을 숨기지 않음
	                } else {
	                    alert('폴더 추가에 실패했습니다. 다시 시도해 주세요.');
	                }
	            }
	        };
	
	        var data = 'folderName=' + encodeURIComponent(folderName) + '&user_id=' + encodeURIComponent(userId);
	        xhr.send(data);
	    } else {
	        alert('폴더 이름을 입력해 주세요.');
	    }
	}


    // 폴더를 DOM에 추가
    function addFolderToDOM(folderName, folderNum) {
	    var folderContainer = document.querySelector('.folder-container');
	    var folderItem = document.createElement('div');
	    folderItem.classList.add('folder-item');
	    
	    // 폴더 번호를 데이터 속성에 저장
	    folderItem.setAttribute('data-folder-num', folderNum);
	
	    var folderIcon = document.createElement('img');
	    folderIcon.src = '../seyoung/img/folder.png'; // 기본 아이콘 설정
	    folderIcon.alt = 'Folder Icon';
	
	    var folderNameSpan = document.createElement('span');
	    folderNameSpan.textContent = folderName;
	
	    var deleteButton = document.createElement('img');
	    deleteButton.src = '../seyoung/img/bin.png';
	    deleteButton.classList.add('delete-button');
	    deleteButton.style.display = 'flex';
	    deleteButton.onclick = function(event) {
	        event.stopPropagation(); // 폴더 선택 이벤트와 충돌 방지
	        deleteFolder(folderNum, folderItem); // 폴더 번호와 폴더 항목 전달
	    };
	
	    folderItem.appendChild(folderIcon);
	    folderItem.appendChild(folderNameSpan);
	    folderItem.appendChild(deleteButton);
	    folderItem.onclick = function() {
	        selectFolder(folderItem); // 폴더 선택 시 selectFolder 함수 호출
	    };
	
	    folderContainer.appendChild(folderItem);
	    updateFolderPositions();
	    selectFolder(folderItem); // 추가된 폴더를 자동으로 선택
	}



    

    function selectFolder(folderItem) {
        var folderIcon = folderItem.querySelector('img');
        var folderNum = folderItem.getAttribute('data-folder-num');
        // 폴더 번호가 유효하지 않을 경우 처리
        if (!folderNum || isNaN(folderNum)) {
            console.error("폴더 번호가 유효하지 않습니다.");
            return;
        }

        // 선택되지 않은 상태일 때 (img/folder.png)
        if (folderIcon.src.includes('folder.png')) {
            if (selectedFolderItem) {
                // 이전에 선택된 폴더가 있으면 아이콘과 스타일 원래대로
                selectedFolderItem.querySelector('img').src = '../seyoung/img/folder.png';
                selectedFolderItem.querySelector('span').style.fontWeight = 'normal';
            }

            // 현재 폴더를 선택된 상태로 변경
            folderIcon.src = '../seyoung/img/folder2.png'; // 아이콘 변경
            folderItem.querySelector('span').style.fontWeight = 'bold'; // 글자 굵기 변경
            selectedFolderItem = folderItem; // 현재 선택된 폴더 갱신
            
			clickOpenBox('boardList');
			loadBoardList(folderNum);
			
			document.getElementById("selectedFolderNum").value = folderNum;
			
			//document.getElementById("board-folder").value = selectedFolderItem;
            // AJAX 요청을 통해 서버에서 폴더 정보 가져오기
            var xhr = new XMLHttpRequest();
            xhr.open('GET', '../seyoung/bgetFolderProc.jsp?folderNum=' + encodeURIComponent(folderNum), true);
            xhr.onreadystatechange = function() {
                if (xhr.readyState === 4 && xhr.status === 200) {
                    console.log('선택된 폴더 정보:', xhr.responseText);
                }
            };
            xhr.send(); // 요청 전송

        } else if (folderIcon.src.includes('folder2.png')) {
            // 선택된 상태일 때 다시 클릭하면 선택 해제
            folderIcon.src = '../seyoung/img/folder.png'; // 아이콘 원래대로
            folderItem.querySelector('span').style.fontWeight = 'normal'; // 글자 굵기 원래대로
            selectedFolderItem = null; // 선택 해제
            clickOpenBox('board');
        }
    }

    // 폴더 목록 로드
	function loadFolders() {
	    var xhr = new XMLHttpRequest();
	    xhr.open('GET', '../seyoung/bFolderListProc.jsp?user_id=' + encodeURIComponent(userId), true);
	    xhr.onreadystatechange = function() {
	        if (xhr.readyState === 4 && xhr.status === 200) {
	            var folderContainer = document.querySelector('.folder-container');
	            var folderInputContainer = document.getElementById('folderInputContainer');
	            var folderManageButton = document.getElementById('folderManageButton');
	
	            folderContainer.innerHTML = ''; 
	            folderContainer.appendChild(folderInputContainer);
	            folderContainer.appendChild(folderManageButton);
	
	            var folderList = JSON.parse(xhr.responseText);
	            
	            // 폴더 목록이 비어있지 않은 경우에만 첫 번째 폴더 선택
	            if (folderList.length > 0) {
	                folderList.forEach(function(folder, index) {
	                    var folderItem = document.createElement('div');
	                    folderItem.classList.add('folder-item');
	                    
	                    // data-folder-num 속성을 폴더 번호로 설정
	                    folderItem.setAttribute('data-folder-num', folder.folder_num); 
	
	                    var folderIcon = document.createElement('img');
	                    folderIcon.src = '../seyoung/img/folder.png'; // 초기 아이콘은 folder.png로 설정
	                    folderIcon.alt = 'Folder Icon';
	
	                    var folderNameSpan = document.createElement('span');
	                    folderNameSpan.textContent = folder.folder_name;
	
	                    var deleteButton = document.createElement('img');
	                    deleteButton.src = '../seyoung/img/bin.png';
	                    deleteButton.classList.add('delete-button');
	                    deleteButton.style.display = 'none';
	                    deleteButton.onclick = function() {
	                        deleteFolder(folder.folder_num, folderItem); // 폴더 번호와 폴더 항목 전달
	                    };
	
	                    folderItem.appendChild(folderIcon);
	                    folderItem.appendChild(folderNameSpan);
	                    folderItem.appendChild(deleteButton);
	
	                    folderItem.onclick = function() {
	                        selectFolder(folderItem); // 폴더 선택 시 selectFolder 함수 호출
	                    };
	
	                    folderContainer.appendChild(folderItem);
	
	                    // 첫 번째 폴더를 자동으로 선택
	                });
	
	                updateFolderPositions(); 
	            }
	        }
	    };
	    xhr.send();
	}

    // 폴더 삭제 함수
    function deleteFolder(folderNum, folderItem) {
	    if (!folderNum || isNaN(folderNum)) {
	        alert('유효하지 않은 폴더 번호입니다.');
	        return;
	    }
	
	    var xhr = new XMLHttpRequest();
	    xhr.open('POST', '../seyoung/bFolderDelProc.jsp', true);
	    xhr.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
	
	    xhr.onreadystatechange = function() {
	        if (xhr.readyState === 4 && xhr.status === 200) {
	            var responseText = xhr.responseText.trim();
	            if (responseText === 'success') {
	                alert('폴더가 삭제되었습니다.');
	                folderItem.remove(); // 폴더 항목을 DOM에서 제거
	                updateFolderPositions(); // 폴더 위치 업데이트
	                // 폴더가 삭제된 후 첫 번째 폴더를 자동으로 선택
	                var remainingFolders = document.querySelectorAll('.folder-item');
	                if (remainingFolders.length > 0) {
	                    selectFolder(remainingFolders[0]);
	                } else {
	                    selectedFolderItem = null; // 남은 폴더가 없을 경우 선택된 폴더 초기화
	                    document.getElementById('board-folder').value = ''; // hidden input 초기화
	                }
	            } else if (responseText === 'fail') {
	                alert('폴더 삭제에 실패했습니다. 다시 시도해 주세요.');
	            } else if (responseText === 'invalid') {
	                alert('유효하지 않은 폴더 번호입니다.');
	            } else {
	                alert('오류가 발생했습니다.');
	            }
	        }
	    };
	
	    // 폴더 번호를 서버에 전달하여 삭제 요청
	    var data = 'folderNum=' + encodeURIComponent(folderNum);
	    xhr.send(data);
	}

    // 폴더 위치를 업데이트하는 함수
    function updateFolderPositions() {
        var folderContainer = document.querySelector('.folder-container');
        var folderItems = folderContainer.querySelectorAll('.folder-item');
        var baseTop = 13;
        var folderHeight = 27;
        var folderGap = 7;
        var newLeft = 20;

        folderItems.forEach(function(folderItem, index) {
            var newTop = baseTop + index * (folderHeight + folderGap);
            folderItem.style.position = 'absolute';
            folderItem.style.top = newTop + 'px';
            folderItem.style.left = newLeft + 'px';
        });
    }

    // 페이지 로드 시 폴더 목록을 불러옴
    document.addEventListener('DOMContentLoaded', function() {
    	loadFolders(); // 페이지 로드 시 폴더 목록 불러오기
	});
</script>
