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
	background-color : white;
	position:relative;
	border-radius : 10px;
}

.user_search_div *{
	font-size: 24px;
}

.user_search_input_section {
	border-bottom: 1px solid rgba(0, 0, 0, 0.2);
	padding-bottom: 10px;
}

.user_search_input_section_input {
	font-size : 18px;
	padding: 5px;
	width: 80%;
	box-sizing: border-box;
}

.user_search_input_section_button {
	font-size : 18px;
	padding: 5px 10px;
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
	height:60px;
}

.user_search_output_info_profile_img {
	width: 100%;
	height:100%;
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
.user_search_close_btn{
	position:absolute;
	cursor : pointer;
	padding : 5px 10px;
	background:none;
	font-size : 16px;
	border:none;
	right:5px;
	top:5px;
}
</style>
<script>
	function clickUserSearch(){
		const user_search_name = document.querySelector(".user_search_input_section_input").value;
		var xhr = new XMLHttpRequest();
        xhr.open('GET', '../miniroom/userSearchProc.jsp?user_search_name=' + encodeURIComponent(user_search_name), true);
        xhr.onreadystatechange = function() {
            if (xhr.readyState === 4 && xhr.status === 200) {
                // 받은 응답을 board-list-body에 넣어 게시물 목록 갱신
                document.querySelector('.user_search_output_section').innerHTML = xhr.responseText;
            }
        };
        xhr.send(); // 목록 로드 요청
	}
	function closeUserSearch(){
		document.getElementById("user_search_modal").style.display = "none";
	}
	
	const user_search_input_section_input = document.querySelector(".user_search_input_section_input");
</script>
</head>

<div class="user_search_div">
	<div class="user_search_input_section">
		<input class="user_search_input_section_input" type="text"
			placeholder="이름이나 아이디,닉네임을 검색하세요" name="user_search_name"> <input
			class="user_search_input_section_button" type="button" onclick ="clickUserSearch()" value="검색하기">
		<button class ="user_search_close_btn" onclick ="closeUserSearch()">X</button>
	</div>
	<div class="user_search_output_section">
		<h3 align = "center">이름이나 아이디,닉네임을 검색하세요</h3>
	</div>
</div>
</html>