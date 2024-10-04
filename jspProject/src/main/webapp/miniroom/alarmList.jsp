
<%@page import="guestbook.GuestbookprofileBean"%>
<%@page import="guestbook.GuestbookprofileMgr"%>
<%@page import="guestbook.GuestbookBean"%>
<%@page import="alarm.AlarmBean"%>
<%@page import="miniroom.ItemMgr"%>
<%@page import="pjh.MemberBean"%>
<%@page import="friend.FriendRequestBean"%>
<%@page import="java.util.Vector"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<jsp:useBean id="fMgr" class="friend.FriendMgr" />
<jsp:useBean id="uMgr" class="pjh.MemberMgr" />
<jsp:useBean id="aMgr" class="alarm.AlarmMgr" />
<jsp:useBean id="gMgr" class="guestbook.GuestbookMgr" />
<%
String id = (String) session.getAttribute("idKey");
String url = request.getParameter("url");
Vector<AlarmBean> vlist = aMgr.getAllAlarm(id);
ItemMgr iMgr = new ItemMgr();
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
	display: flex;
	flex-direction: column;
	background-color: rgba(255, 255, 255, 0.5);
	padding: 20px;
	width: 100%;
}

.alarmlist_main_div_header {
	position: relative;
	display: flex;
	align-items: center;
	gap: 20px;
	font-size: 28px;
}

.alarmlist_main_div_list {
	background-color: none;
	list-style: none;
	height: 140px;
	padding: 10px;
	display: flex;
	flex-direction: column;
	border: 1px solid #858585;
	border-radius: 10px;
}

.alarmlist_main_div_item {
	display: flex;
	justify-content: space-between;
	font-size: 20px;
	cursor : pointer;
}

.alarmlist_main_div_item_title {
	width: 70%;
}

.alarmlist_main_div_item_separator {
	height: 1px;
	display: flex;
	margin: 5px 0px;
}

.alarmlist_main_div_item_separator_img {
	width: 100%;
	object-fit: cover;
}

.alarm_pagination {
	display: flex;
	justify-content: space-around;
	align-items: center;
	background-color: #C0E5AF;
	border-radius: 30px;
	align-self: center;
}

.alarm_pagination span {
	padding: 10px;
	cursor: pointer;
}

.alarm_pagination span.active {
	color: red;
}

.alarmlist_main_div_item_read {
	color: rgba(0, 0, 0, 0.2);
}

.alarmlist_main_div_deleteAllBtn {
	position: absolute;
	font-size: 20px;
	right: 5px;
	color: #FFB2B2;
	cursor: pointer;
}

.alarmlist_main_div_deleteAllBtn:hover {
	color: #DD9090;
}
</style>

</head>
<body>
	<div class="alarmlist_top_div" style="display: none">
		<div class="alarmlist_main_div">
			<div class="alarmlist_main_div_header">
				<div>
					<img src="./img/alram.png">
				</div>
				<span>알림목록</span>
				<div onclick="clickAlarmlist_main_div_deleteAllBtn()"
					class="alarmlist_main_div_deleteAllBtn">읽은 알림 모두 삭제</div>
			</div>
			<%if (vlist.size() > 0){ %>
			<ul class="alarmlist_main_div_list">
				<%
				for (int i = 0; i < vlist.size(); i++) {
					AlarmBean alarmBean = vlist.get(i);
					String alarmType = alarmBean.getAlarm_type();
					int alarmContentNum = alarmBean.getAlarm_content_num();
					String alarmAt = alarmBean.getAlarm_at();
					String alarmUser_id = alarmBean.getAlarm_user_id();
					int alarmNum = alarmBean.getAlarm_num();
					boolean alarmRead = alarmBean.isAlarm_read();
					GuestbookBean gBean = null;
					FriendRequestBean fBean = null;
					MemberBean fUser = null;
					GuestbookprofileMgr gpMgr = new GuestbookprofileMgr();

					if (alarmType.equals("친구요청")) {
						fBean = fMgr.getFriendRequestItem(alarmContentNum);
						fUser = uMgr.getMember(fBean.getRequest_senduserid());
						GuestbookprofileBean gpBean = gpMgr.getProfileByUserId(fUser.getUser_id());
				%>
				<li id="<%=alarmNum%>" class="alarmlist_main_div_item"><input
					type="hidden" name="character"
					value="<%=iMgr.getUsingCharacter(fBean.getRequest_senduserid()).getItem_path()%>">
					<input type="hidden" name="name"
					value="<%=fUser.getUser_name()%>"> <input type="hidden"
					name="type" value="<%=fBean.getRequest_type()%>"> <input
					type="hidden" name="comment"
					value="<%=fBean.getRequest_comment()%>"> <input
					type="hidden" name="num" value="<%=fBean.getRequest_num()%>">
					<input type="hidden" name="request_senduserid"
					value="<%=fBean.getRequest_senduserid()%>"> <span
					class="alarmlist_main_div_item_readbool <%if (alarmRead) {%>alarmlist_main_div_item_read<%}%>">읽음</span>
					<span onclick="clickAlarmItem(event)"
					class="alarmlist_main_div_item_title"><%=gpBean.getProfileName()%>님이
						<%=fBean.getRequest_type() == 1 ? "일촌" : "이촌"%> 요청을 보냈습니다.</span> <span
					class="alarmlist_main_div_item_requestAt"><%=alarmAt%></span>
				</li>
				<%
				} else if (alarmType.equals("방명록")) {
				gBean = gMgr.getGuestbookEntry(alarmContentNum);
				
				GuestbookprofileBean gpBean = gpMgr.getProfileByUserId(gBean.getWriterId());
				%>
				<li id="<%=alarmNum%>" class="alarmlist_main_div_item"><span
					class="alarmlist_main_div_item_readbool <%if (alarmRead) {%>alarmlist_main_div_item_read<%}%>">읽음</span>
					<span onclick="clickAlarmGuestbook(event)"
					class="alarmlist_main_div_item_title"><%=gpBean.getProfileName()%>님이
						방명록을 작성하였습니다.</span> <span class="alarmlist_main_div_item_requestAt"><%=alarmAt%></span>
				</li>
				<%
				}
				} // for (alarmList)
				%>

			</ul>
			<%} else{ // if vlist.size() > 0%>
			<h2 style = "text-align :center">새로운 알림이 없습니다.</h2>
			<%} %>
			<div class="alarm_pagination"></div>
		</div>
	</div>
	<script>
const alarm_itemsPerPage = 4; // 페이지당 8개 아이템
let alarm_currentPage = 1; // 현재 페이지
let alarm_items = []; // 모든 아이템을 담을 배열

function clickAlarmlist_main_div_deleteAllBtn(){
	alarm_items = alarm_items.filter((e) => e.querySelector(".alarmlist_main_div_item_read") == null);
	displayalarm_items();
    alarm_updatePagination();
    
 
    var xhr = new XMLHttpRequest();
    xhr.open("GET", "../miniroom/alarmProc.jsp?type=deleteAll", true); // Alarm 갱신Proc
    xhr.onreadystatechange = function () {
        if (xhr.readyState === 4 && xhr.status === 200) {
        }
    };
    xhr.send();
}
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
    if(alarm_items.filter((e) => e.querySelector(".alarmlist_main_div_item_read") == null).length){
    	document.querySelector(".main_profile_alarm_isalarm").style.display = "block";
    }
    else{
    	
    	document.querySelector(".main_profile_alarm_isalarm").style.display = "none";
    }
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
function openRequestModalReceive(character,name,type,comment,num,id){
    let fr_modal = document.getElementById("friend_request_modal_receive");
	
    // 값을 가져와서 modal에 설정
    fr_modal.querySelector(".request_user_name_font").innerText = name
    fr_modal.querySelector(".request_type_span").innerText = type == 1 ? "일촌" : "이촌";
    fr_modal.querySelector(".request_comment").value = comment;
    fr_modal.querySelector(".request_num").value = num;
    fr_modal.querySelector(".request_profile_img").src = character;
    fr_modal.querySelector(".request_senduserid").value = id;
 	// 모달을 표시
    fr_modal.style.display = "flex";
}
function clickAlarmItem(event){
	 // fr_form은 <li> 요소
    let fr_form = event.target.parentElement;
    // <input> 요소를 선택
    let nameInput = fr_form.querySelector('input[name="name"]');
    let typeInput = fr_form.querySelector('input[name="type"]');
    let commentInput = fr_form.querySelector('input[name="comment"]');
    let numInput = fr_form.querySelector('input[name="num"]');
    let characterInput = fr_form.querySelector('input[name="character"]');
    let idInput = fr_form.querySelector('input[name="request_senduserid"]')
	if(commentInput.value =="null"){
		commentInput.value ="";
	}
	
    // 값을 가져와서 modal에 설정
    openRequestModalReceive(characterInput.value,nameInput.value,typeInput.value,commentInput.value,numInput.value,idInput.value);
    fr_form.querySelector(".alarmlist_main_div_item_readbool").classList.add("alarmlist_main_div_item_read");
    //alarm_items = alarm_items.filter((e) => e.querySelector('input[name="num"]').value != numInput.value);
    console.log(alarm_items);
    
    
    displayalarm_items();
    alarm_updatePagination();
    
    var xhr = new XMLHttpRequest();
    xhr.open("GET", "../miniroom/alarmProc.jsp?type=read&num="+fr_form.id, true); // Alarm 갱신Proc
    xhr.onreadystatechange = function () {
        if (xhr.readyState === 4 && xhr.status === 200) {
        }
    };
    xhr.send();
    
}
function clickAlarmGuestbook(event){
	clickOpenBox('guestbook');
	let fr_form = event.target.parentElement;
	var xhr = new XMLHttpRequest();
    xhr.open("GET", "../miniroom/alarmProc.jsp?type=read&num="+fr_form.id, true); // Alarm 갱신Proc
    xhr.onreadystatechange = function () {
        if (xhr.readyState === 4 && xhr.status === 200) {
        }
    };
    xhr.send();
    fr_form.querySelector(".alarmlist_main_div_item_readbool").classList.add("alarmlist_main_div_item_read");
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