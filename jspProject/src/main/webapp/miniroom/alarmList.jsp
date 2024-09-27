<%@page import="pjh.MemberBean"%>
<%@page import="friend.FriendRequestBean"%>
<%@page import="java.util.Vector"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:useBean id="fMgr" class ="friend.FriendMgr"/>
<jsp:useBean id="uMgr" class ="pjh.MemberMgr"/>
<%
	String id = (String)session.getAttribute("id");
	String url = request.getParameter("url");
	Vector<FriendRequestBean> vlist = fMgr.getFriendRequest(url);
%>
<head>
	<style>
.alarmlist_top_div {
	position: absolute;
	background-color: #F8F6E3;
	right: 0px;
	z-index: 10;
	width: 500px;
	padding: 25px;
}

.alarmlist_main_div {
	display:flex;
	flex-direction : column;
	background-color: rgba(255, 255, 255, 0.5);
	padding: 20px;
	width:100%;
}

.alarmlist_main_div_header {
	display: flex;
	gap : 20px;
	font-size: 28px;
}

.alarmlist_main_div_list {
	background-color: none;
	list-style: none;
	height : 140px;
	padding: 10px;
	display: flex;
	flex-direction: column;
	border: 1px solid #858585;
	border-radius: 10px;
}

.alarmlist_main_div_item {
	display: flex;
	justify-content: space-between;
	font-size : 20px;
}

.alarmlist_main_div_item_title {
	width: 70%;
}

.alarmlist_main_div_item_separator{
	height : 1px;
	display:flex;
	margin : 5px 0px;
}
.alarmlist_main_div_item_separator_img{
	width:100%;
	object-fit:cover;
}

.alarm_pagination {
	display: flex;
	justify-content: space-around;
	align-items:center;
	background-color : #C0E5AF;
	border-radius : 30px;
	align-self:center;
}

.alarm_pagination span {
	padding : 10px;
	cursor: pointer;
}

.alarm_pagination span.active {
	color: red;
}
</style>

</head>
<body>
<div class ="alarmlist_top_div" style ="display:none">
	<div class ="alarmlist_main_div">
		<div class ="alarmlist_main_div_header">
		<div><img src ="./img/alram.png"></div> <span>알림목록</span>
		</div>
		<ul class ="alarmlist_main_div_list">
			<%for(int i = 0 ; i < vlist.size() ; i ++){ 
				FriendRequestBean bean = vlist.get(i);
				MemberBean user = uMgr.getMember(bean.getRequest_senduserid());
				%>
				<li class ="alarmlist_main_div_item">
					<input type = "hidden" name = "name" value ="<%=user.getUser_name()%>">
					<input type = "hidden" name = "type" value ="<%=bean.getRequest_type()%>">
					<input type = "hidden" name = "comment" value ="<%=bean.getRequest_comment() %>">
					<input type = "hidden" name = "num" value ="<%=bean.getRequest_num() %>">
					<span class ="alarmlist_main_div_item_readbool">읽음</span>
					<span onclick = "clickAlarmItem(event)" class ="alarmlist_main_div_item_title"><%=user.getUser_name() %>님이 <%=bean.getRequest_type()== 1 ? "일촌" : "이촌" %> 요청을 보냈습니다.</span>
					<span class ="alarmlist_main_div_item_requestAt"><%=bean.getRequest_at() %></span>
				</li>
			<%} %>
				
		</ul>
		<div class="alarm_pagination">
		</div>
	</div>
</div>
<script>
const alarm_itemsPerPage = 4; // 페이지당 8개 아이템
let alarm_currentPage = 1; // 현재 페이지
let alarm_items = []; // 모든 아이템을 담을 배열

// 페이지를 바꾸는 함수
function alarm_changePage(page) {
    alarm_currentPage = page;
    displayalarm_items();
    alarm_updatePagination();
}

// 아이템을 보여주는 함수
function displayalarm_items() {
    const start = (alarm_currentPage - 1) * alarm_itemsPerPage;
    const end = start + alarm_itemsPerPage;
    const visiblealarm_items = alarm_items.slice(start, end);

    const alarm_itemsContainer = document.querySelector(".alarmlist_main_div_list");
    alarm_itemsContainer.innerHTML = ''; // 기존 아이템 제거
	
    
    visiblealarm_items.forEach(item => {
        alarm_itemsContainer.appendChild(item);
        const separatorDiv = document.createElement("div");
        const separatorImg = document.createElement("img");
        separatorDiv.classList.add("alarmlist_main_div_item_separator");
        separatorImg.classList.add("alarmlist_main_div_item_separator_img");
        separatorImg.src ="./img/separatorLine.png";
        separatorDiv.appendChild(separatorImg);
        alarm_itemsContainer.appendChild(separatorDiv);
    });
}

// 페이지네이션 업데이트 함수
function alarm_updatePagination() {
    const totalPages = Math.ceil(alarm_items.length / alarm_itemsPerPage);
    const paginationContainer = document.querySelector('.alarm_pagination');
    paginationContainer.innerHTML = ''; // 기존 페이지네이션 제거

    for (let i = 1; i <= totalPages; i++) {
        const pageSpan = document.createElement('span');
        const separatorSpan = document.createElement('div');
        pageSpan.textContent = i;
        pageSpan.classList.toggle('active', i === alarm_currentPage);
        pageSpan.onclick = () => alarm_changePage(i);
        separatorSpan.textContent = "ㅣ";
        separatorSpan.style.color = "#BAB9AA";
        paginationContainer.appendChild(pageSpan);
        if(i != totalPages){
        	paginationContainer.appendChild(separatorSpan);
        }
        
        
        
    }
}

function clickAlarmItem(event){
	 // fr_form은 <li> 요소
    let fr_form = event.target.parentElement;
    let fr_modal = document.getElementById("friend_request_modal_receive");
    // <input> 요소를 선택
    let nameInput = fr_form.querySelector('input[name="name"]');
    let typeInput = fr_form.querySelector('input[name="type"]');
    let commentInput = fr_form.querySelector('input[name="comment"]');
    let numInput = fr_form.querySelector('input[name="num"]');
	if(commentInput.value =="null"){
		commentInput.value ="";
	}
	
    // 값을 가져와서 modal에 설정
    fr_modal.querySelector(".request_user_name_font").innerText = nameInput.value;
    fr_modal.querySelector(".request_type_span").innerText = typeInput.value == 1 ? "일촌" : "이촌";
    fr_modal.querySelector(".request_comment").value = commentInput.value;
    fr_modal.querySelector(".request_num").value = numInput.value;
    
    fr_form.querySelector(".alarmlist_main_div_item_readbool").style.color = "rgba(0,0,0,0.2)"
    
    //alarm_items = alarm_items.filter((e) => e.querySelector('input[name="num"]').value != numInput.value);
    console.log(alarm_items);
    
    
    displayalarm_items();
    alarm_updatePagination();
    // 모달을 표시
    fr_modal.style.display = "flex";
}

// 페이지가 로드될 때 초기화
document.addEventListener('DOMContentLoaded', function () {
	const alarm_itemsContainer = document.querySelector(".alarmlist_main_div_list")
	alarm_items = Array.from(alarm_itemsContainer.children); // 모든 아이템을 배열로 저장
	displayalarm_items();
	alarm_updatePagination();
});
</script>
</body>