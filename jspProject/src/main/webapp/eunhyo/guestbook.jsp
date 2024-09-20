<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>CloverStory</title>
<!-- Linking the CSS file -->
<link rel="stylesheet" type="text/css" href="css/style.css">
<link rel="stylesheet" type="text/css" href="css/guestbook.css">
</head>

<body>
	<div class="container">
		<div class="header">
			<img src="img/logo2.png" alt="CloverStory Logo2" class="logo2">
			<div class="settings">
			<span></span>
				<a href="#">설정</a> <a href="#">로그아웃</a>
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
				<div align = "center" class="inner-box-2">
					<h1 class="guestbook-title">방명록</h1>
					<div class="guestbook-line"></div> <!-- 실선 -->
			
					    <!-- 방명록 작성 폼 -->
				    <div class="guestbook-form">
				        <input type="text" id="guestbook-input" class="guestbook-input" placeholder="일촌에게 방명록 기록을 남겨보세요~ !" />
				        <label for="private"><input type="checkbox" id="private" /> 비밀글</label>
				        <button id="submit-button" class="submit-button">등록</button>
				    </div>

				    <!-- 방명록 항목들이 추가되는 영역 -->
				    <div class="guestbook-entries"></div>

				</div>
			</div>
			<!-- 버튼 -->
			<div class="button-container">
				<button class="custom-button">홈</button>
				<button class="custom-button">프로필</button>
				<button class="custom-button">미니룸</button>
				<button class="custom-button">게시판</button>
				<button class="custom-button" style="background-color: #F7F7F7; font-weight: 600;" >방명록</button>
				<button class="custom-button">상점</button>
				<button class="custom-button">게임</button>
				<button class="custom-button">음악</button>
			</div>

		</div>
	</div>

	<!-- 자바스크립트 코드 -->
	<script>
	    // 등록 버튼 클릭 시 동작하는 함수
	    document.getElementById('submit-button').addEventListener('click', function() {
	        var inputField = document.getElementById('guestbook-input');
	        var content = inputField.value.trim();
	
	        // 입력 필드에 내용이 있는 경우에만 방명록 추가
	        if (content) {
	            // 새로운 방명록 항목 생성
	            var newEntry = document.createElement('div');
	            newEntry.className = 'guestbook-entry';
	            
	            // 방명록 내용 추가
	            var entryContent = document.createElement('p');
	            entryContent.className = 'guestbook-content';
	            entryContent.textContent = content;
	            
	            newEntry.appendChild(entryContent);
	            
	            // 방명록 글 목록의 맨 위에 새 항목 추가
	            var entriesContainer = document.querySelector('.guestbook-entries');
	            entriesContainer.insertBefore(newEntry, entriesContainer.firstChild);
	
	            // 입력 필드 초기화
	            inputField.value = '';
	        } else {
	            alert('내용을 입력하세요.');
	        }
	    });
	</script>


</body>
</html>
