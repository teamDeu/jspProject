<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Clover Story</title>
<link rel="stylesheet" type="text/css" href="css/style.css">
<link rel="stylesheet" type="text/css" href="css/boardList.css">
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
					<form action="boardProcess.jsp" method="post">
					<h1 class="board-title">게시판</h1>
					<!-- 삭제, 작성 버튼 -->
					<div class="button-group">
					    <button type="button" class="delete-button">삭제</button>
					    <a href="boardWrite.jsp">
					   	 <button type="button" class="write-button">작성</button>
					   	</a>
					</div>

						<div class="boardlist-line"></div>
						<div class="board-box">
							<table class="board-table">
							    <thead>
							        <tr>
							        	
							            <th class="checkbox-cell"><input type="checkbox"></th>
							            <th>제목</th>
							            <th>작성자</th>
							            <th>작성일</th>
							            <th>조회</th>
							        </tr>
							    </thead>
							    <tbody>
							    </tbody>
							</table>
						</div>

					</form>							
				</div>
			</div>
			<!-- 버튼 -->
			<div class="button-container">
				<button class="custom-button">홈</button>
				<button class="custom-button">프로필</button>
				<button class="custom-button">미니룸</button>
				<button class="custom-button" style="background-color: #F7F7F7; font-weight: 600;" >게시판</button>
				<a href="guestbook.jsp"><button class="custom-button">방명록</button></a>
				<button class="custom-button">상점</button>
				<button class="custom-button">게임</button>
				<button class="custom-button">음악</button>
			</div>



		</div>
	</div>

</body>
</html>