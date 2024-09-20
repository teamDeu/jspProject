<%@ page contentType="text/html; charset=UTF-8"%>
<%
		
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>CloverStory</title>
<!-- Linking the CSS file -->
<link rel="stylesheet" type="text/css" href="css/style.css">
</head>
<body>
	<div class="container">
		<div class="header">
			<img src="img/c_logo.png" alt="CloverStory Logo" class="logo">
			<div class="settings">
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
				<div class="inner-box-2"></div>
			</div>
			<!-- 버튼 -->
			<div class="button-container">
				<button class="custom-button">홈</button>
				<button class="custom-button">프로필</button>
				<button class="custom-button">미니룸</button>
				<button class="custom-button">게시판</button>
				<button class="custom-button">방명록</button>
				<button class="custom-button">상점</button>
				<button class="custom-button">게임</button>
				<button class="custom-button">음악</button>
			</div>



		</div>
	</div>
</body>
</html>