<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<div class="folder-container">
    <div class="folder-input-container" id="folderInputContainer">
        <img src="img/folder.png" alt="Folder Icon">
        <input type="text" id="folderNameInput" placeholder="폴더명을 입력하세요.">
        <button onclick="addFolder()">
            <img src="img/plus.png">
        </button>
    </div> 	
    <button class="folder-manage-button" id="folderManageButton"  onclick="toggleFolderInput()">폴더 관리 하기</button>
</div>

<script>
    var userId = '1111'; // 실제로는 세션에서 사용자 ID를 가져와야 합니다.

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
                button.style.display = 'inline-block';
            });
        }
    }

    function addFolder() {
        var folderNameInput = document.getElementById('folderNameInput');
        var folderName = folderNameInput.value.trim();

        if (folderName !== '') {
            var xhr = new XMLHttpRequest();
            xhr.open('POST', 'bFolderAddProc.jsp', true);
            xhr.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');

            xhr.onreadystatechange = function() {
                if (xhr.readyState === 4 && xhr.status === 200) {
                    var responseText = xhr.responseText.trim();
                    if (responseText.startsWith('success')) { // 응답이 'success'로 시작하면 추가 성공
                        var folderNum = responseText.split(',')[1]; // 폴더 번호 추출
                        alert('폴더가 추가되었습니다.');
                        addFolderToDOM(folderName, folderNum); // 폴더를 DOM에 추가
                        folderNameInput.value = ''; // 입력 필드 초기화
                        inputContainer.style.display = 'none'; // 폴더 추가 후 입력 영역 숨김
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

        // 새로운 폴더 요소 생성
        var folderItem = document.createElement('div');
        folderItem.classList.add('folder-item');

        var folderIcon = document.createElement('img');
        folderIcon.src = 'img/folder.png';
        folderIcon.alt = 'Folder Icon';

        var folderNameSpan = document.createElement('span');
        folderNameSpan.textContent = folderName;

        // 삭제 버튼 생성
        var deleteButton = document.createElement('img');
        deleteButton.src = 'img/trashcan.png';
        deleteButton.alt = 'Delete';
        deleteButton.classList.add('delete-button');
        deleteButton.onclick = function() {
            deleteFolder(folderNum, folderItem); // 폴더 삭제 함수 호출
        };

        // 폴더 요소를 구성
        folderItem.appendChild(folderIcon);
        folderItem.appendChild(folderNameSpan);
        folderItem.appendChild(deleteButton);

        // 폴더 컨테이너에 새 폴더 추가
        folderContainer.appendChild(folderItem);

        // 추가된 폴더 위치 업데이트
        updateFolderPositions();
    }


    function loadFolders() {
        var xhr = new XMLHttpRequest();
        xhr.open('GET', 'bFolderListProc.jsp?user_id=' + encodeURIComponent(userId), true);
        xhr.onreadystatechange = function() {
            if (xhr.readyState === 4 && xhr.status === 200) {
                var folderContainer = document.querySelector('.folder-container');
                var folderInputContainer = document.getElementById('folderInputContainer');
                var folderManageButton = document.getElementById('folderManageButton');

                // 폴더 아이템들을 모두 제거
                folderContainer.innerHTML = ''; 

                // 폴더 입력 컨테이너와 폴더 관리 버튼을 다시 추가하여 유지
                folderContainer.appendChild(folderInputContainer);
                folderContainer.appendChild(folderManageButton);

                var folderList = JSON.parse(xhr.responseText);
                folderList.forEach(function(folder) {
                    var folderItem = document.createElement('div');
                    folderItem.classList.add('folder-item');

                    var folderIcon = document.createElement('img');
                    folderIcon.src = 'img/folder.png';

                    var folderNameSpan = document.createElement('span');
                    folderNameSpan.textContent = folder.folder_name;

                    var deleteButton = document.createElement('img');
                    deleteButton.src = 'img/trashcan.png';
                    deleteButton.classList.add('delete-button');
                    deleteButton.onclick = function() {
                        deleteFolder(folder.folder_num, folderItem); // 폴더 삭제 함수 호출
                    };

                    folderItem.appendChild(folderIcon);
                    folderItem.appendChild(folderNameSpan);
                    folderItem.appendChild(deleteButton);

                    folderContainer.appendChild(folderItem);
                });

                updateFolderPositions(); // 폴더 위치 업데이트
            }
        };
        xhr.send();
    }


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

    // 폴더 삭제 함수
    function deleteFolder(folderNum, folderItem) {
        var xhr = new XMLHttpRequest();
        xhr.open('POST', 'bFolderDelProc.jsp', true);
        xhr.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');

        xhr.onreadystatechange = function() {
            if (xhr.readyState === 4 && xhr.status === 200) {
                var responseText = xhr.responseText.trim();
                if (responseText === 'success') {
                    alert('폴더가 삭제되었습니다.');
                    folderItem.remove(); // 폴더 항목을 DOM에서 제거
                    updateFolderPositions(); // 폴더 위치 업데이트
                } else if (responseText === 'fail') {
                    alert('폴더 삭제에 실패했습니다. 다시 시도해 주세요.');
                } else if (responseText === 'invalid') {
                    alert('유효하지 않은 폴더 번호입니다.');
                } else {
                    alert('오류가 발생했습니다.');
                }
            }
        };

        var data = 'folderNum=' + encodeURIComponent(folderNum);
        xhr.send(data);
    }



    // 페이지 로드 시 폴더 목록을 불러옴
    document.addEventListener('DOMContentLoaded', function() {
        loadFolders();
    });
</script>