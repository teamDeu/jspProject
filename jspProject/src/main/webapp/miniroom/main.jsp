<%@page import="pjh.MemberMgr"%>
<%@page import="pjh.MemberBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<jsp:useBean id="iMgr" class ="miniroom.ItemMgr"/>
<jsp:useBean id="mMgr" class ="pjh.MemberMgr"/>
<jsp:useBean id="fMgr" class ="friend.FriendMgr"/>
<%
   // 세션에서 idKey 가져오기
   String id = (String)session.getAttribute("idKey");
   if(id == null){
      response.sendRedirect("../pjh/login.jsp");
      return;
   }

// 페이지 소유자의 ID 가져오기
   String pageOwnerId = request.getParameter("url");

   // 만약 url 파라미터가 없으면 페이지 소유자는 방문자(id)
   if(pageOwnerId == null || pageOwnerId.trim().isEmpty()) {
      pageOwnerId = id;
   }


   // 캐릭터 및 배경 이미지 설정
   String character = iMgr.getUsingCharacter(id).getItem_path();
   String url = request.getParameter("url");
   if(url == null){
      url = id;
   }
   String background = iMgr.getUsingBackground(url).getItem_path();
   if(background == null){
      background = "./img/backgroundImg.png";
   }

   // 사용자 정보 가져오기
   MemberBean userBean = mMgr.getMember(id);
// MemberMgr 객체 초기화
   MemberMgr memberMgr = new MemberMgr();

   // 쿠키에서 마지막 방문 시간 확인
   String lastVisit = null;
   javax.servlet.http.Cookie[] cookies = request.getCookies();
   if (cookies != null) {
       for (javax.servlet.http.Cookie cookie : cookies) {
           if (cookie.getName().equals("lastVisit")) {
               lastVisit = cookie.getValue();
           }
       }
   }

   long currentTime = System.currentTimeMillis();
   boolean shouldUpdateVisitorCount = false;

   if (lastVisit == null || (currentTime - Long.parseLong(lastVisit)) > 10000) { // 10초 이상 경과 시
       // 방문자 수 업데이트
       memberMgr.updateVisitorCount();
       shouldUpdateVisitorCount = true;

       // 마지막 방문 시간을 현재 시간으로 쿠키에 저장
       javax.servlet.http.Cookie visitCookie = new javax.servlet.http.Cookie("lastVisit", Long.toString(currentTime));
       visitCookie.setMaxAge(60 * 60 * 24); // 쿠키 유효 기간을 하루로 설정
       response.addCookie(visitCookie);
   }

   // 오늘의 방문자 수 및 전체 방문자 수 가져오기
   int todayVisitorCount = memberMgr.getTodayVisitorCount();
   int totalVisitorCount = memberMgr.getTotalVisitorCount();
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>CloverStory</title>
<!-- Linking the CSS file -->
<link rel="stylesheet" type="text/css" href="./css/style.css">
<style>

@font-face {
    font-family: 'NanumTobak';
    src: url('../나눔손글씨 또박또박.TTF') format('truetype');
}

* {
    font-family: 'NanumTobak', sans-serif;
}
.profile_function_div {
	display: flex;
	z-index:3;
	flex-direction: column;
	position: absolute;
	width: 120px;
	padding: 10px;
	gap: 10px;
	border-radius: 10px;
	box-sizing: border-box;
	background-color: #FFFEF3;
	left:0px;
	top: -120px;
	border: 2px solid #BAB9AA;
}

.profile_function_div button {
	padding: 2px 10px;
	border: 1px solid #DCDCDC;
	background-color: #FFFFFF;
	font-size: 16px;
	border-radius: 10px;
}

.profile_function_div span {
	align-self: center;
	font-size: 20px;
}
.miniroom_information {
   display: none;
   flex-direction: column;
   position: absolute;
   width: 120px;
   padding : 10px;
   gap:10px;
   border-radius : 10px;
   box-sizing:border-box;
   background-color:#FFFEF3;
   top: -100px;
   border: 2px solid #BAB9AA;
}
.miniroom_information button{
   padding : 2px 10px;
   border : 1px solid #DCDCDC;
   background-color : #FFFFFF;
   font-size : 16px;
   border-radius : 10px;
}
.miniroom_information span{
   align-self:center;
   font-size : 20px;
}
.friend_request_modal{
   position:absolute;
   width : 100%;
   height : 100%;
   display:flex;
   align-items : center;
   justify-content : center;
   z-index : 11;
}
.main_profile_alarm_isalarm{
	
	background-color : red;
	position:absolute;
	display:none;
	width : 5px;
	height : 5px;
	right:0px;
	top:0px;
	border-radius : 10px;
}
.visitor-stats {
        position: absolute;
        top: 10px;
        left: 10px;
        text-align: left;
        font-size: 16px;
        font-weight: bold;
        display: flex;
        gap: 20px; /* TODAY와 TOTAL 간의 간격을 조정 */
    }

    .visitor-stats .today {
        color: #FF6347; /* 오늘 방문자수는 눈에 띄게 빨간색 */
    }

    .visitor-stats .total {
        color: #4682B4; /* 총 방문자수는 파란색 */
    }
</style>
<script>
function loadContent(url) {
    var xhr = new XMLHttpRequest();
    xhr.onreadystatechange = function() {
        if (xhr.readyState == 4 && xhr.status == 200) {
            document.getElementById("anotherBox").innerHTML = xhr.responseText;
        }
    };
    xhr.open("GET", url, true);
    xhr.send(); 
}

function clickOpenBox(id){
   openBox = document.getElementById(id);
   anotherBox = document.querySelectorAll(".inner-box-2");
   for(i = 0 ; i < anotherBox.length ; i++){
      anotherBox[i].style.display ="none";
   }
   openBox.style.display = "flex";
   
   if(id.includes("board")){
	   document.getElementById("boardInnerBox").style.display = "block";
	   document.getElementById("normalInnerBox").style.display = "none";
   }
   else{
	   document.getElementById("boardInnerBox").style.display = "none";
	   document.getElementById("normalInnerBox").style.display = "block";
   }
}
function clickUser(event){
   console.log(event);
}
function clickAlarm(){
   alarmDiv = document.querySelector(".alarmlist_top_div");
   if(alarmDiv.style.display == "none"){
      alarmDiv.style.display = "flex"
   }
   else{
      alarmDiv.style.display = "none"
   }
}
</script>
<!-- 웹소켓통신 자바스크립트 -->

<script type="text/javascript">
        var ws;
        var sayBoxId = 0; // 지역 변수로 선언
        var chatBoxId = 0;
        let userNum = 0;
        var localId = "<%=userBean.getUser_id()%>";
        var localCharacter = "<%=character%>"
        var url = "<%=url%>";
        var localName = "<%=userBean.getUser_name()%>";
        var dataSeparator = "㉠"
        var messageSeparator = "㉡";
        var timeNameText = "";
        function connect() {
            ws = new WebSocket("ws://" + location.host + "<%=request.getContextPath()%>/chat");
            ws.onopen = function() {
                document.getElementById("status").textContent = "서버와 연결됨";
                if(localId == "null") localId = "비회원";
                if(localCharacter == "null") localCharacter = "character1.png"
                message = "connect"+ dataSeparator + localId + dataSeparator + localCharacter +dataSeparator + url +dataSeparator + localName;
                ws.send(message);
            };
            ws.onmessage = function(event) {
                 rawdata = event.data.split(dataSeparator);
                 command = rawdata[0];
                 data = rawdata[1];
                 if(command == ("sendMessage")){
                    comment = data.split(messageSeparator)[1];
                    user = data.split(messageSeparator)[0];
                    name = data.split(messageSeparator)[2];
                 if(comment == "") return;
                  printSayBox(user);
                  printChatBox(user,comment,"chat",name);
                 }
                 else if(command == ("init")){
                    userNum ++;
                    character = rawdata[2];
                    name = rawdata[3];
                    printUser(data,character,name);
                    
                 }
                 else if(command == ("connect")){
                    // create a new div element
                    userNum ++;
                    character = rawdata[2];
                    name = rawdata[4];
                  printUser(data,character,name);
                  printChatBox(data,name+"님이 입장하셨습니다.","notice",name);
                    
                 }
                 else if(command == ("disconnect")){
                   data = rawdata[1];
                   name = rawdata[2];
                    printChatBox(data,name+"님이 퇴장하셨습니다.","notice",name);
                    user = document.getElementById(data);
                    user.remove();
                    userNum --;
                 }
                 else if(command == ("sendFriendRequest")){
                	 sendUserName = rawdata[1];
                	 sendUserCharacter = rawdata[2];
                	 receiveId = rawdata[3];
                	 requestType = rawdata[4];
                	 comment = rawdata[5];
                	 sendUserId = rawdata[6];
                	 if(localId == receiveId){
                		 openRequestModalReceive(sendUserCharacter,sendUserName,requestType,comment,"",sendUserId);
                	 }
                 }
                 else if(command == ("submitFriendRequest")){
                	 flag = false;
                	 userId = rawdata[1];
                	 userName = rawdata[2];
                	 userCharacter = rawdata[3];
                	 requestType = rawdata[4];
                	 flag = isFriend(localId,userId);
                	 
                	 const createProfileDiv = (userName, userId, userCharacter, localId, flag) => {
                		 const profileDiv = 
                			    '<div onclick="onclickMainProfileFriendsDiv(this)" class="main_profile_friends_div friends_type_first">' +
                			        '<div class="profile_function_div_main" style="display: none;">' +
                			            '<div class="profile_function_div">' +
                			                '<span>' + userName + '</span>' +
                			                (flag ? 
                			                    '<button onclick="onclickDeleteFriend(\'' + localId + '\', \'' + userId + '\', \'' + userName + '\')">친구삭제</button>' :
                			                    '<button onclick="onclickAddFriend(\'' + localId + '\', \'' + userId + '\', \'' + userCharacter + '\', \'' + userName + '\')">친구추가</button>'
                			                ) +
                			                '<button onclick="onclickGoHomePage(\'' + userId + '\')">미니룸 구경가기</button>' +
                			            '</div>' +
                			        '</div>' +
                			        '<img class="main_profile_friends" src="' + userCharacter + '">' +
                			        '<span class="main_profile_friends_name">' + userName + '</span>' +
                			    '</div>';
                		    // 임시 div 생성
                		    const tempDiv = document.createElement('div');
                		    tempDiv.innerHTML = profileDiv;

                		    // 첫 번째 자식 요소를 반환
                		    return tempDiv.firstChild;
                		};
                	const profileDiv = createProfileDiv(userName,userId,userCharacter,localId,flag);
                	
                	 if(requestType == "일촌"){
              			friend_items_first.push(profileDiv)
              			changeFriendType(1);
              		}
              		else if(requestType == "이촌"){
              			friend_items_second.push(profileDiv)
              			changeFriendType(2);
              		}
                 }
            };
            ws.onclose = function() {
                document.getElementById("status").textContent = "서버 연결 끊김";
            };
        }
        function gamemainshow() {
	        document.getElementById("main").style.display = "block";
	        document.getElementById("game1-container").style.display = "none";
	        document.getElementById("game2-container").style.display = "none";        
	    }
        function sendFriendRequest(receiveId , request_type,comment){
        	var message = "sendFriendRequest" + dataSeparator + localName +
        	dataSeparator + localCharacter + dataSeparator + receiveId + 
        	dataSeparator + request_type + dataSeparator + comment +
        	dataSeparator + localId;
        	ws.send(message);
        }
        function submitFriendRequest(username,userid,usercharacter,requestType){
        	var message = "submitFriendRequest" + dataSeparator + username + dataSeparator + userid + dataSeparator + usercharacter + dataSeparator + requestType;
        	ws.send(message);
        }
        function sendMessage() {
            var message = "sendMessage" + dataSeparator +  localId + messageSeparator + document.getElementById("messageInput").value + messageSeparator + '<%=userBean.getUser_name()%>';
            if (message.trim() !== "") {
                ws.send(message);
                document.getElementById("messageInput").value = '';
            }
        }
        
        function printUser(id,character,name){
           newDiv = document.createElement("div");
           newImg = document.createElement("img");
           newImg.classList.add("userCharacter");
           newImg.src =character;
           nowvisit = document.getElementById("nowvisit");
           nowvisit.innerText = "Now " + userNum; 
            // and give it some content
            // add the text node to the newly created div
          newDiv.id = id;
          newContent = document.createTextNode(name);
          newDiv.appendChild(newContent);
          newDiv.appendChild(newImg);
          newDiv.classList.add("user");
          
          informationDiv = document.createElement("div");
          informationDiv.classList.add("miniroom_information");
          userNameSpan = document.createElement("span");
          addFriendBtn = document.createElement("button");
          goHomepageBtn = document.createElement("button");
          addFriendBtn.innerText = "친구추가";
          goHomepageBtn.innerText = "미니룸 구경가기";
          userNameSpan.innerText = name;
          informationDiv.appendChild(userNameSpan);
          informationDiv.appendChild(addFriendBtn);
          informationDiv.appendChild(goHomepageBtn);
          newDiv.onclick = (function(informationDiv) {
              return function() {
                  console.log(informationDiv.style.display);
                  if (informationDiv.style.display == "none" || informationDiv.style.display == "") {
                      informationDiv.style.display = "flex";
                  } else {
                      informationDiv.style.display = "none";
                  }
              };
          })(informationDiv);
          addFriendBtn.onclick = (function(requestSendUser, requestReciveUser,character,name) {
               return function() {
                   fr_modal = document.getElementById("friend_request_modal_send");
                   fr_form = document.friend_request_form_send;
                   fr_form.request_senduserid.value = requestSendUser;
                   fr_form.request_receiveuserid.value = requestReciveUser;
                   fr_modal.style.display = "flex";
                   fr_modal.querySelector(".request_comment").value = "";
                   fr_modal.querySelector(".request_user_name_font").innerText = name;
                   fr_modal.querySelector(".request_profile_img").src = character;
               };
           })(localId, id,character,name);
          goHomepageBtn.onclick = (function(id) {
              return function() {
                 console.log(id);
                 location.href = "http://"+location.host+"/jspProject/miniroom/main.jsp?url=" + id;   
              };
          })(id);
          newDiv.appendChild(informationDiv);
            // add the newly created element and its content into the DOM
            if(miniroom){
               miniroom.appendChild(newDiv);
            }
            else{
               alert("찾을수없음");
            }
        }
        
        function printSayBox(id) {
            
            miniroom = document.getElementById("miniroom");
            sayBoxId = "sayBoxId" + id;
            console.log(sayBoxId);
            if(document.getElementById(sayBoxId))
            {
            	document.getElementById(sayBoxId).remove();
            }
            newDiv = document.createElement("div");
            newContent = document.createTextNode(comment);
            newDiv.appendChild(newContent);
            userDiv = document.getElementById(id);
            userRect = userDiv.getBoundingClientRect();
            newDiv.classList.add("sayBox");
            newDiv.id = sayBoxId;
            userDiv.appendChild(newDiv);
            newDiv.style.top = -newDiv.offsetHeight + "px";
        }
        
        function printChatBox(id,comment,type,name){
           
           chatArea2 = document.getElementById("chatArea2");
           chatBoxDiv = document.createElement("div");
           newContent = document.createTextNode(comment);
           chatDiv = document.createElement("div");
           chatDiv.appendChild(newContent);
           chatBoxDiv.appendChild(chatDiv);
           
           if(id == localId){
              chatDiv.classList.add("myChat");
              chatBoxDiv.classList.add("myChatBox");
           }
           
           else{
              chatDiv.classList.add("otherChat");
              chatBoxDiv.classList.add("otherChatBox");
           }

           chatDiv.classList.add(type);
           userNameDiv = document.createElement("div");
           let today = new Date();
           let year = today.getFullYear();
           let month = String(today.getMonth() + 1).padStart(2, '0'); // 2자리로 포맷
           let day = String(today.getDate()).padStart(2, '0'); // 2자리로 포맷
           let hours = String(today.getHours()).padStart(2, '0'); // 2자리로 포맷
           let minutes = String(today.getMinutes()).padStart(2, '0'); // 2자리로 포맷

          let timeText = year + '.' + month + '.' + day + ' ' + hours + ':' + minutes;
          let newTimeNameText = timeText + "  " + name;
          timeTextClass = name+year+month+day+hours+minutes;
          
          if(document.querySelectorAll("."+timeTextClass)){
        	  Array.from(document.querySelectorAll("."+timeTextClass)).forEach((e) => e.remove());
          }
          timeNameText = newTimeNameText;
          userNameContent = document.createTextNode(timeNameText);
          userNameDiv.classList.add(timeTextClass);
          userNameDiv.appendChild(userNameContent);
          userNameDiv.classList.add("chatName");
          chatBoxDiv.appendChild(userNameDiv);
          //
           chatBoxDiv.classList.add("chatBox");
           chatArea2.appendChild(chatBoxDiv);
           chatArea2.scrollTop = chatArea2.scrollHeight;
        }
        
        
        
        function disconnect(){
           var message = "disconnect"+ dataSeparator + localId + dataSeparator + localName;
           ws.send(message);
           ws.close();
        }
          window.addEventListener("beforeunload",disconnect);
        
        function logout() {
            if (confirm('정말로 로그아웃 하시겠습니까?')) {
                window.location.href = 'logout.jsp';
            }
        }
    </script>

</head>
<body>

   <div class="container">
      <div class="header">
         <img src="img/logo2.png" alt="CloverStory Logo2" class="logo2">
         <div class="settings">
            <span></span> <a href="#">설정</a> <a href="../pjh/logout.jsp">로그아웃</a>
         </div>
      </div>
      <!-- 큰 점선 테두리 상자 -->
      <div class="dashed-box">
         <!-- 테두리 없는 상자 -->
         <div class="solid-box">
         <!-- 방문자 수 표시 -->
            <div class="visitor-stats">
        <div class="today">
            TODAY: <%= todayVisitorCount %>
        </div>
        <div class="total">
            TOTAL: <%= totalVisitorCount %>
        </div>
    </div>

            <div class ="main_profile_alram">
            <img class="main_profile_alram_img" onclick ="clickAlarm()" src="./img/alram.png">
            <div class ="main_profile_alarm_isalarm"></div>
            <jsp:include page="alarmList.jsp">
               <jsp:param value="<%=url %>" name="url"/>
            </jsp:include>
            </div>
            
            <div id = "normalInnerBox" class="inner-box-1">
               <jsp:include page="profile.jsp">
                  <jsp:param value='<%=url %>' name="url"/>
               </jsp:include>
            </div>
            <div id = "boardInnerBox" class="inner-box-1" style = "display :none">
               <jsp:include page="../seyoung/bInnerbox1.jsp"></jsp:include>
            </div>
            <!-- 이미지가 박스 -->
            <div class="image-box">
               <img src="img/img1.png" alt="Image between boxes 1"
                  class="between-image"> <img src="img/img1.png"
                  alt="Image between boxes 2" class="between-image">
            </div>
            <div id="chatBox" class="inner-box-2">
               <jsp:include page="chat.jsp">
                  <jsp:param value="<%=background%>" name="backgroundImg"/>
               </jsp:include>
            </div>
            <div id="profile" class="inner-box-2" style="display: none">
            </div>
            <div id="Box_miniroom_design" class ="inner-box-2" style="display: none" >
               <jsp:include page="miniDesign.jsp"></jsp:include>
            </div>
            <div id="game" class ="inner-box-2" style="display: none" >
               <jsp:include page="../yang/game.jsp"></jsp:include>
            </div>
	         <div id="store" class="inner-box-2" style="display: none">
	            <jsp:include page="../pjh/storeDesign.jsp"></jsp:include>
	         </div>
	         <div id="guestbook" class="inner-box-2" style="display: none">
               <jsp:include page="../eunhyo/guestbook.jsp">
                <jsp:param name="ownerId" value="<%= url %>"/>
                </jsp:include>
	         </div> 
	         <div id="board" class="inner-box-2" style="display: none">
	         	<jsp:include page ="../seyoung/board.jsp"></jsp:include>
	         </div>
	         <div id="boardList" class ="inner-box-2" style="display:none">
	         	<jsp:include page ="../seyoung/boardList.jsp"></jsp:include>
	         </div>
	         <div id="boardWrite" class ="inner-box-2" style="display:none">
	         	<jsp:include page ="../seyoung/boardWrite.jsp"></jsp:include>
	         </div>
	         <div id="music" class="inner-box-2" style="display: none">
	         </div>
         </div>
         <!-- 버튼 -->
         <div class="button-container">
            <button onclick="javascript:clickOpenBox('chatBox')" class="custom-button">홈</button>
            <button onclick="javascript:clickOpenBox('profile')" class="custom-button">프로필</button>
            <%if(url.equals(id)){ %>
            <button onclick="javascript:clickOpenBox('Box_miniroom_design')" class="custom-button">미니룸</button>
            <%} %>
            <button onclick = "javascript:clickOpenBox('board')" class="custom-button">게시판</button>
            <button onclick = "javascript:clickOpenBox('guestbook')" class="custom-button">방명록</button>
            <button onclick = "javascript:clickOpenBox('store')" class="custom-button">상점</button>
            <button onclick = "javascript:clickOpenBox('game'); gamemainshow();" class="custom-button">게임</button>
            <button onclick = "javascript:clickOpenBox('music')" class="custom-button">음악</button>
         </div>
  

      </div>
   </div>
   <div id = "friend_request_modal_send" class ="friend_request_modal" style = "display:none">
         <jsp:include page="friendRequestSend.jsp"></jsp:include>
   </div>
   
   <div id = "friend_request_modal_receive" class ="friend_request_modal" style = "display:none">
         <jsp:include page="friendRequestReceive.jsp"></jsp:include>
   </div>
   
</body>
</html>