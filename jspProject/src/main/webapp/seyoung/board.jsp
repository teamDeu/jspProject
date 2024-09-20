<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>CloverStory</title>
<!-- Linking the CSS file -->
<link rel="stylesheet" type="text/css" href="css/style.css">
<link rel="stylesheet" type="text/css" href="css/board.css">
<style>
.board-recentpost {
    color: black; 
    text-align: center; 
    font-size: 24px; 
    font-weight: 300; 
    position: absolute; 
    top: 15px; 
    left: 100px;
    display: inline-block; 
}

.board-content {
    display: flex;
    flex-direction: column;
    align-items: center;
    padding: 10px;
    margin-top: 10px;
    position: relative; /* absolute를 relative로 변경 */
    top: 0px; /* 위치를 조정하여 레이아웃 개선 */
	width: calc(100% - 100px); /* 너비 조정 */
	border: 1px solid #BAB9AA;
	padding: 20px; /* 내부 여백 */
    background-color: #F7F7F7; /* 배경 색상 */
    margin: 20px auto; /* 위아래 간격 및 중앙 정렬 */
    height: 350px; /* 내용에 맞게 높이 자동 조정 */
}


.b-title {
	display: flex;
    justify-content: space-between;
    align-items: center;
    width: 100%;
    border-bottom: 1px solid #000;
    padding-bottom: 5px;
    margin-bottom: 15px;.
	border-bottom: 1px dashed #BAB9AA;
    padding-bottom: 10px;
    margin-bottom: 20px;./
    font-size: 16px;
    color: #333333;
    display: flex;
    justify-content: space-between;
    align-items: center;
    width: calc(100% - 60px); /* b-title의 너비를 조정하여 board-content와 맞춤 */
    margin: 20px auto; /* 중앙 정렬 */
}

.b-header .title {
    font-weight: bold;
}

.b-header .date,
.b-header .edit {
    font-size: 14px;
    color: #666666;
}

.board-content .post-image {
    max-width: 100%;
    border-radius: 5px;
    margin-bottom: 10px;
}


</style>

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
				
					<h1 class="board-title">게시판</h1>
					<h2 class="board-recentpost"> | 최근게시물</h2>
					
					<div class="board-header"></div>
					
					<div class="b-title">
						<span class="title">게시판 제목</span>
						<span class="date">2024-09-20</span>
						<span class="edit">수정 | 삭제</span>

					</div>
					
					<div class="board-content">
						<img src="img/logo1.png" alt="게시물 이미지" class="post-image">
						<p class="content-text">
							사이하트 다시 오픈한다는데 이 기가새들이 게시물 쓸 수 있는 토토코쿠폰 준다는 건 정말이냐 ㅇㅇ나 이거 암튼
							개새라고 다이 갑자 선물 부모와 우선 주부당. 개새라고 많이 많이 들었소
						</p>
					</div>
												
				</div>
			</div>
			<!-- 버튼 -->
			<div class="button-container">
				<button class="custom-button">홈</button>
				<button class="custom-button">프로필</button>
				<button class="custom-button">미니룸</button>
				<button class="custom-button" style="background-color: #F7F7F7; font-weight: 600;" >게시판</button>
				<button class="custom-button">방명록</button>
				<button class="custom-button">상점</button>
				<button class="custom-button">게임</button>
				<button class="custom-button">음악</button>
			</div>



		</div>
	</div>
</body>
</html>
