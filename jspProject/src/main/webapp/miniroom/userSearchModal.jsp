<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
.user_search_div {
	width: 550px;
	border: 1px solid black;
	padding: 20px;
	box-sizing: border-box;
}

.user_search_input_section {
	border-bottom: 1px solid rgba(0, 0, 0, 0.2);
	padding-bottom: 10px;
}

.user_search_input_section_input {
	padding: 5px;
	font-size: 12px;
	width: 80%;
	box-sizing: border-box;
}

.user_search_input_section_button {
	padding: 5px 10px;
	font-size: 12px;
	box-sizing: border-box;
}

.user_search_output_section {
	display: flex;
	flex-direction: column;
	height: 350px;
	overflow-y: scroll;
	-ms-overflow-style: none;
}

.user_search_output_section::-webkit-scrollbar {
	display: none;
}

.user_search_output_items {
	display: flex;
	align-items: center;
	gap: 10px;
	position: relative;
}

.user_search_output_info_div {
	display: flex;
	align-items: center;
}

.user_search_output_info_profile_img_box {
	width: 60px;
}

.user_search_output_info_profile_img {
	width: 100%;
	object-fit: contain;
}

.user_search_output_function_div {
	position: absolute;
	right: 0px;
}

.user_search_output_function_div button {
	padding: 2px 10px;
	border: 1px solid #DCDCDC;
	background-color: #FFFFFF;
	font-size: 16px;
	border-radius: 10px;
}
</style>
</head>

<div class="user_search_div">
	<div class="user_search_input_section">
		<input class="user_search_input_section_input" type="text"
			placeholder="이름이나 아이디를 검색하세요" name="user_search_name"> <input
			class="user_search_input_section_button" type="button" value="검색하기">
	</div>
	<div class="user_search_output_section">
		<div class="user_search_output_items">
			<div class="user_search_output_info_div">
				<div class="user_search_output_info_profile_img_box">
					<img class="user_search_output_info_profile_img"
						src="./img/character1.png">
				</div>
				<div class="user_search_output_info_profile_text">
					als981209(KIDALI) 김민석</div>
			</div>
			<div class="user_search_output_function_div">
				<button>친구요청</button>
				<button>미니룸 가기</button>
			</div>
		</div>
		<div class="user_search_output_items">
			<div class="user_search_output_info_div">
				<div class="user_search_output_info_profile_img_box">
					<img class="user_search_output_info_profile_img"
						src="./img/character1.png">
				</div>
				<div class="user_search_output_info_profile_text">als(KIDALI)
					김민석</div>
			</div>
			<div class="user_search_output_function_div">
				<button>친구요청</button>
				<button>미니룸 가기</button>
			</div>
		</div>
		<div class="user_search_output_items">
			<div class="user_search_output_info_div">
				<div class="user_search_output_info_profile_img_box">
					<img class="user_search_output_info_profile_img"
						src="./img/character1.png">
				</div>
				<div class="user_search_output_info_profile_text">
					als981209sdgasd(KIDALI) 김민석</div>
			</div>
			<div class="user_search_output_function_div">
				<button>친구요청</button>
				<button>미니룸 가기</button>
			</div>
		</div>
		<div class="user_search_output_items">
			<div class="user_search_output_info_div">
				<div class="user_search_output_info_profile_img_box">
					<img class="user_search_output_info_profile_img"
						src="./img/character1.png">
				</div>
				<div class="user_search_output_info_profile_text">
					a209(KIDALI) 김민석</div>
			</div>
			<div class="user_search_output_function_div">
				<button>친구요청</button>
				<button>미니룸 가기</button>
			</div>
		</div>
		<div class="user_search_output_items">
			<div class="user_search_output_info_div">
				<div class="user_search_output_info_profile_img_box">
					<img class="user_search_output_info_profile_img"
						src="./img/character1.png">
				</div>
				<div class="user_search_output_info_profile_text">
					als981209(ALI) 김민석</div>
			</div>
			<div class="user_search_output_function_div">
				<button>친구요청</button>
				<button>미니룸 가기</button>
			</div>
		</div>
	</div>
</div>
</html>