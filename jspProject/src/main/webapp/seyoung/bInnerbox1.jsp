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
    <button class="folder-manage-button" onclick="toggleFolderInput()">폴더 관리 하기</button>
</div>


<script>
	function toggleFolderInput() {
	    var inputContainer = document.getElementById('folderInputContainer');
	    var deleteButtons = document.querySelectorAll('.delete-button');
	
	    if (inputContainer.style.display === 'flex') {
	        inputContainer.style.display = 'none';
	        
	        // 삭제 버튼 숨기기
	        deleteButtons.forEach(function(button) {
	            button.style.display = 'none';
	        });
	    } else {
	        inputContainer.style.display = 'flex';
	        
	        // 삭제 버튼 보이기
	        deleteButtons.forEach(function(button) {
	            button.style.display = 'inline-block';
	        });
	    }
	}
	
	
	function addFolder() {
	    var folderNameInput = document.getElementById('folderNameInput');
	    var folderName = folderNameInput.value.trim();
	
	    if (folderName !== '') {
	        var folderContainer = document.querySelector('.folder-container');
	
	        // 기존 폴더 아이템의 수를 계산하여 새로운 폴더의 top 값을 결정
	        var folderItems = folderContainer.querySelectorAll('.folder-item');
	        var baseTop = 13; // 첫 번째 폴더 아이템의 기본 top 값 (상단에서 10px 아래)
	        var folderHeight = 27; // 폴더 아이템의 높이
	        var folderGap = 7; // 폴더 아이템 간의 간격
	        var newTop = baseTop + folderItems.length * (folderHeight + folderGap); // 새로운 폴더의 top 값
	
	        // 새로운 폴더 아이템 생성
	        var folderItem = document.createElement('div');
	        folderItem.classList.add('folder-item');
	
	        var folderIcon = document.createElement('img');
	        folderIcon.src = 'img/folder.png';
	        folderIcon.alt = 'Folder Icon';
	
	        var folderNameSpan = document.createElement('span');
	        folderNameSpan.textContent = folderName;
	
	        // 삭제 버튼 생성
	        var deleteButton = document.createElement('img');
	        deleteButton.src = 'img/trashcan.png'; // 쓰레기통 이미지 경로 설정
	        deleteButton.alt = 'Delete';
	        deleteButton.classList.add('delete-button');
	        deleteButton.onclick = function() {
	            folderItem.remove(); // 폴더 항목 삭제
	            updateFolderPositions(); // 폴더 위치 재조정
	        };
	
	        // 폴더 아이템에 요소 추가
	        folderItem.appendChild(folderIcon);
	        folderItem.appendChild(folderNameSpan);
	        folderItem.appendChild(deleteButton);
	
	        // 폴더 아이템의 위치를 컨테이너의 (newLeft, newTop)으로 설정
	        var newLeft = 20; // 폴더 아이템을 오른쪽으로 20px 이동
	        folderItem.style.position = 'absolute'; // 절대 위치 지정
	        folderItem.style.top = newTop + 'px'; // 위쪽 위치
	        folderItem.style.left = newLeft + 'px'; // 왼쪽 위치 (오른쪽으로 이동)
	
	        // 폴더 아이템을 컨테이너에 추가
	        folderContainer.appendChild(folderItem);
	
	        // 입력 필드 초기화
	        folderNameInput.value = '';
	    }
	}
	
	
	function updateFolderPositions() {
	    var folderContainer = document.querySelector('.folder-container');
	    var folderItems = folderContainer.querySelectorAll('.folder-item');
	    var baseTop = 13; // 첫 번째 폴더 아이템의 기본 top 값 (상단에서 10px 아래)
	    var folderHeight = 27; // 폴더 아이템의 높이
	    var folderGap = 7; // 폴더 아이템 간의 간격
	    var newLeft = 20; // 폴더 아이템을 오른쪽으로 20px 이동
	    
	    folderItems.forEach(function(folderItem, index) {
	        var newTop = baseTop + index * (folderHeight + folderGap); // 새로운 top 계산
	        folderItem.style.top = newTop + 'px';
	        folderItem.style.left = newLeft + 'px'; // 위치 조정
	    });
	}	


</script>