<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
	.main_profile_div{
		display:flex;
		width :100%;
		flex-direction : column;
		justify-content :center;
		align-items : center;
	}
	.main_profile_img{
		width : 100%;
		object-fit : cover;
	}
</style>
</head>
<body>
 	<div class ="main_profile_div">
 		<select>
 			<option>HAPPY</option>
 			<option>CRY</option>
 			<option>EXCITING</option>
 		</select>
 		<div>
 			<img class ="main_profile_img" src = "./img/character1.png">
 			<div>
 			<span>후비적 후비적</span>
 			<button>알람</button>
 			</div>
 			<div>
 				<button>프로필 설정</button>
 				<span>홍길동</span>
 			</div>
 		</div>
 		<div>
 			music
 		</div>
 		<div>
 			친구목록
 		</div>
 	</div>
</body>
</html>