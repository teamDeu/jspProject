<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
	.user_search_output_section{
		display:flex;
		flex-direction : column;
	}
	.user_search_output_items{
		display:flex;
		align-items:center;
		gap : 10px;
	}
	.user_search_output_info_div{
		display:flex;
		align-items:center;
	}
	.user_search_output_info_profile_img_box{
		width: 60px;
	}
	.user_search_output_info_profile_img{
		width:100%;
		object-fit : contain;
	}
</style>
</head>

<div class ="user_search_div">
	<div class ="user_search_input_section">
		<input class ="user_search_input_section_input" type ="text" placeholder = "이름이나 아이디를 검색하세요" name ="user_search_name">
		<input class ="user_search_input_section_button" type ="button" value ="검색하기">
	</div>
	<div class ="user_search_output_section">
		<div class ="user_search_output_items">
			<div class ="user_search_output_info_div">
				<div class ="user_search_output_info_profile_img_box">
					<img class ="user_search_output_info_profile_img" src = "./img/character1.png">
				</div>
				<div class ="user_search_output_info_profile_text">
					als981209(KIDALI) 김민석
				</div>
			</div>
			<div class ="user_search_output_function_div">
				<button>친구요청</button>
				<button>미니룸 가기</button>
			</div>
		</div>
		<div class ="user_search_output_items">
			<div class ="user_search_output_info_div">
				<div class ="user_search_output_info_profile_img_box">
					<img class ="user_search_output_info_profile_img" src = "./img/character1.png">
				</div>
				<div class ="user_search_output_info_profile_text">
					als981209(KIDALI) 김민석
				</div>
			</div>
			<div class ="user_search_output_function_div">
				<button>친구요청</button>
				<button>미니룸 가기</button>
			</div>
		</div>
		<div class ="user_search_output_items">
			<div class ="user_search_output_info_div">
				<div class ="user_search_output_info_profile_img_box">
					<img class ="user_search_output_info_profile_img" src = "./img/character1.png">
				</div>
				<div class ="user_search_output_info_profile_text">
					als981209(KIDALI) 김민석
				</div>
			</div>
			<div class ="user_search_output_function_div">
				<button>친구요청</button>
				<button>미니룸 가기</button>
			</div>
		</div>
		<div class ="user_search_output_items">
			<div class ="user_search_output_info_div">
				<div class ="user_search_output_info_profile_img_box">
					<img class ="user_search_output_info_profile_img" src = "./img/character1.png">
				</div>
				<div class ="user_search_output_info_profile_text">
					als981209(KIDALI) 김민석
				</div>
			</div>
			<div class ="user_search_output_function_div">
				<button>친구요청</button>
				<button>미니룸 가기</button>
			</div>
		</div>
		<div class ="user_search_output_items">
			<div class ="user_search_output_info_div">
				<div class ="user_search_output_info_profile_img_box">
					<img class ="user_search_output_info_profile_img" src = "./img/character1.png">
				</div>
				<div class ="user_search_output_info_profile_text">
					als981209(KIDALI) 김민석
				</div>
			</div>
			<div class ="user_search_output_function_div">
				<button>친구요청</button>
				<button>미니룸 가기</button>
			</div>
		</div>
	</div>
</div>
</html>