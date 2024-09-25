<%@page import="friend.FriendRequestBean"%>
<%@page import="friend.FriendInfoBean"%>
<%@page import="java.util.Vector"%>
<%@page import="pjh.MemberBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<jsp:useBean id="fMgr" class="friend.FriendMgr" />
<jsp:useBean id="uMgr" class="pjh.MemberMgr" />
<jsp:useBean id="iMgr" class="miniroom.ItemMgr"></jsp:useBean>
<%
String connect_id = (String) session.getAttribute("idKey");
String user_id = request.getParameter("url");
MemberBean user = uMgr.getMember(user_id);

boolean isUserHome = false;
if (connect_id.equals(user_id))
	isUserHome = true;

Vector<FriendInfoBean> fInfoList = fMgr.getFriendList(connect_id);
Vector<FriendRequestBean> fRequestList = fMgr.getFriendRequest(connect_id);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
.main_profile_div {
	display: flex;
	width: 100%;
	flex-direction: column;
	justify-content: center;
	align-items: center;
	padding: 20px;
	box-sizing: border-box;
}

.main_profile_img_box {
	widht: 100%;
	display: flex;
	justify-content: center;
}

.main_profile_img {
	width: 100%;
	object-fit: cover;
	margin: auto;
}

.main_profile_status {
	width: 100%;
	padding: 5px 20px;
	font-size: 18px;
	border-radius: 10px;
	margin-bottom: 5px;
}

.main_profile_main {
	align-items: center;
	padding: 5px 15px;
	background-color: #F7F7F7;
	border: 1px solid #BAB9AA;
	border-radius: 10px;
	width: 100%;
	box-sizing: border-box;
}

.main_profile_comment {
	display: flex;
	position: relative;
	height: 100px;
}

.main_profile_alram {
	position: absolute;
	background: none;
	border: none;
	right: 0px;
}

.main_profile_main_bottom {
	display: flex;
	justify-content: space-between;
}

.main_profile_music {
	width: 100%;
	height: 75px;
	background-color: #707070;
	margin-bottom: 5px;
}

.main_profile_friends_main_div {
	width: 100%;
	padding: 15px;
	box-sizing: border-box;
	background-color: #F7F7F7;
	border: 1px solid #BAB9AA;
	border-radius: 10px;
}

.main_profile_friends_search_div {
	width: 100%;
	display: flex;
	justify-content: space-between;
	margin-bottom: 10px;
}

.main_profile_friends_search_div input {
	padding: 4px 8px;
	width: 75%;
	border: 1px solid #DCDCDC;
	box-sizing: border-box;
	border-radius: 10px;
}

.main_profile_friends_search_div button {
	padding: 4px 15px;
	background-color: #FFFFFF;
	border: 1px solid #DCDCDC;
	box-sizing: border-box;
	border-radius: 10px;
}

.main_profile_friends_list_div {
	position: relative;
	background-color: #FFFFFF;
	border: 1px solid #DCDCDC;
	border-radius: 10px;
	padding: 10px;
}

.main_profile_friends_list {
	display: flex;
	align-items: center;
	justify-content: space-around;
	gap: 8px;
	width: 100%;
}

.main_profile_friends_div {
	width: 25%;
	height: 100%;
	display: flex;
	flex-direction: column;
	align-items: center;
	justify-content: space-between;
}

.main_profile_friends {
	width: 100%;
	object-fit: cover;
}
.
.main_profile_friends_list_friendtype_btns {
	position: relative;
	display: flex;
	gap: 2px;
	left: 5px;
}

.main_profile_friendtype_btn {
	border-top-left-radius: 10px;
	border-top-right-radius: 10px;
	border: none;
	padding: 0px 10px;
	border-bottom: none;
	font-size: 18px;
	display: flex;
}
.main_profile_frinds_button_div{
	
}
.main_profile_friendtype_btn:hover{
	background-color: #C0E5AF;
}

.main_profile_alram_img {
	width: 100%;
	object-fit: cover;
}

.main_profile_setting_button {
	display: flex;
	align-items: center;
	background: none;
	border: none;
	gap: 5px;
	font-size: 18px;
}

.main_profile_setting_button_img {
	width: 10px;
}

.main_profile_username {
	font-size: 18px;
}

.main_profile_frinds_list_div_header {
	display: flex;
	gap: 3px;
	justify-content: space-between;
}
</style>
</head>
<body>
	<div class="main_profile_div" onload="onLoadMainProfile()">
		<select class="main_profile_status" <%if (!isUserHome) {%> disabled
			<%}%>>
			<option>Happy 😃</option>
			<option>Sad 😥</option>
			<option>Exciting 😝</option>
		</select>
		<div class="main_profile_main">
			<div class="main_profile_img_box">
				<img class="main_profile_img" src="./img/character1.png">
			</div>
			<div class="main_profile_comment">
				<span style="font-size: 22px">후비적 후비적</span>
				<button class="main_profile_alram">
					<img class="main_profile_alram_img" src="./img/alram.png">
				</button>
			</div>
			<div class="main_profile_main_bottom">
				<%
				if (isUserHome) {
				%>
				<button class="main_profile_setting_button">
					<img class="main_profile_setting_button_img"
						src="./img/profileSetting.png">프로필 설정
				</button>
				<%
				}
				%>
				<span class="main_profile_username"><%=user.getUser_name()%></span>
			</div>
		</div>
		<hr width="100%" color="#BAB9AA" style="margin: 10px 0px">
		<div class="main_profile_music">music</div>
		<div class="main_profile_friends_main_div">
			<div class="main_profile_friends_search_div">
				<input type="text" placeholder="닉네임을 입력해주세요.">
				<button>검색</button>
			</div>
			<div class="main_profile_friends_list_friendtype_btns">
				<button style = "background-color : #C0E5AF" class ="main_profile_friendtype_btn" onclick = "changeFriendType(event,1)">일촌</button>
				<button class ="main_profile_friendtype_btn" onclick = "changeFriendType(event,2)">이촌</button>
			</div>
			<div class="main_profile_friends_list_div">

				<div class="main_profile_frinds_list_div_header">
					<span><%=fInfoList.size()%>명</span>---------------------
					<div class="main_profile_frinds_button_div">
						<button onclick ="clickFriendListPrev()">
							<img src="./img/left2.png">
						</button>
						<button onclick ="clickFriendListNext()">
							<img src="./img/right2.png">
						</button>
					</div>
				</div>
				<div class="main_profile_friends_list">
					<%
					for (int i = 0; i < fInfoList.size(); i++) {
						FriendInfoBean fInfoBean = fInfoList.get(i);
						String friendId = fInfoBean.getUser_id1();
						if (friendId.equals(user_id)) {
							friendId = fInfoBean.getUser_id2();
						}
						MemberBean bean = uMgr.getMember(friendId);
						String image = iMgr.getUsingCharacter(friendId).getItem_path();
						int type = fInfoBean.getFriend_type();
					%>
					<jsp:include page="friendComponent.jsp">
						<jsp:param value="<%=image%>" name="profileImg" />
						<jsp:param value="<%=bean.getUser_name()%>" name="profileName" />
						<jsp:param value="<%=type %>" name = "type"/>
					</jsp:include>
					<%
					}
					%>
				</div>
			</div>
		</div>
	</div>
	<script>
	const friend_itemsPerPage = 4; // 페이지당 8개 아이템
	let friend_currentPage = 1; // 현재 페이지
	let friend_items_first = []; // 모든 아이템을 담을 배열
	let friend_items_second = [];
	let friend_items = [];
	
	function clickFriendListNext(){
		if(friend_items.length > friend_currentPage * friend_itemsPerPage)
		friend_changePage(friend_currentPage+1)
	}
	
	function clickFriendListPrev(){
		if(friend_currentPage != 1){
			friend_changePage(friend_currentPage-1)
		}
	}
	// 페이지를 바꾸는 함수
	function friend_changePage(page) {
	    friend_currentPage = page;
	    friend_displayItems();
	}
	function changeFriendType(event,friendType){
		Array.from(document.querySelectorAll(".main_profile_friendtype_btn")).forEach((btn) => btn.style.backgroundColor = "#DCDCDC");
		event.target.style.backgroundColor = "#C0E5AF";
		if(friendType == 1){
			friend_items = friend_items_first;
		}
		else if(friendType == 2){
			friend_items = friend_items_second;
		}
		friend_currentPage = 1;
		friend_displayItems();
	}
	// 아이템을 보여주는 함수
	function friend_displayItems() {
		const start = (friend_currentPage - 1) * friend_itemsPerPage;
		const end = start + friend_itemsPerPage;
		const visibleItems = friend_items.slice(start, end);
		const itemsContainer = document.querySelector('.main_profile_friends_list');
		itemsContainer.innerHTML = ''; // 기존 아이템 제거
		visibleItems.forEach(item => {
			itemsContainer.appendChild(item);
		});
	}
	document.addEventListener('DOMContentLoaded', function () {
		friend_items_first = Array.from(document.querySelectorAll('.friends_type_first'));
		friend_items_second = Array.from(document.querySelectorAll('.friends_type_second'));
		friend_items = friend_items_first;
		friend_displayItems();
	})
	</script>
</body>
</html>