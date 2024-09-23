<%@page import="pjh.MemberBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<jsp:useBean id="iMgr" class ="miniroom.ItemMgr"/>
<jsp:useBean id="mMgr" class ="pjh.MemberMgr"/>
<%
	String id = (String)session.getAttribute("idKey");
	String character = iMgr.getUsingCharacter(id).getItem_path();
	String url = request.getParameter("url");
	if(url == null){
		url = id;
	}
	String background = iMgr.getUsingBackground(url).getItem_path();
	if(background == null){
		background = "./img/backgroundImg.png";
	}
	System.out.println(background);
	MemberBean userBean = mMgr.getMember(id);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>CloverStory</title>
<!-- Linking the CSS file -->
<link rel="stylesheet" type="text/css" href="css/style.css">
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
}

</script>
<!-- 웹소켓통신 자바스크립트 -->
<script type="text/javascript">
        var ws;
        var sayBoxId = 0;
        let userNum = 0;
        var localId = "<%=userBean.getUser_name()%>";
        var character = "<%=character%>"
        var url = "<%=url%>";
        console.log(character);
        console.log('<%=background%>');
        function connect() {
            ws = new WebSocket("ws://" + location.host + "<%=request.getContextPath()%>/chat");
            ws.onopen = function() {
                document.getElementById("status").textContent = "서버와 연결됨";
                if(localId == "null") localId = "비회원";
                if(character == "null") character = "character1.png"
                message = "connect;"+ localId +";" + character +";" + url
                ws.send(message);
            };

            ws.onmessage = function(event) {
                 rawdata = event.data.split(";");
                 command = rawdata[0];
                 data = rawdata[1];
                 
                 if(command == ("sendMessage")){
                    comment = data.split(":")[1];
                    user = data.split(":")[0];
                    if(comment == "") return;
                    printSayBox(user);
                  printChatBox(user,comment,"chat");
                    
                 }
                 else if(command == ("init")){
                    userNum ++;
                    printUser(data,rawdata[2]);
                    
                 }
                 else if(command == ("connect")){
                    // create a new div element
                    userNum ++;
                  printUser(data,rawdata[2]);
                  printChatBox(data,data+"님이 입장하셨습니다.","notice");
                    
                 }
                 else if(command == ("disconnect")){
                    printChatBox(data,data+"님이 퇴장하셨습니다.","notice");
                    user = document.getElementById(data);
                    user.remove();
                    userNum --;
                 }
            };
            ws.onclose = function() {
                document.getElementById("status").textContent = "서버 연결 끊김";
            };
        }
        function sendMessage() {
            var message = "sendMessage;" + localId + ":" + document.getElementById("messageInput").value;
            if (message.trim() !== "") {
                ws.send(message);
                document.getElementById("messageInput").value = '';
                
            }
        }
        
        function printUser(id,character){
           newDiv = document.createElement("div");
           newImg = document.createElement("img");
           newImg.classList.add("userCharacter");
           newImg.src =character;
           nowvisit = document.getElementById("nowvisit");
           nowvisit.innerText = "Now " + userNum; 
            // and give it some content
            // add the text node to the newly created div
            newDiv.id = id;
            newContent = document.createTextNode(id);
            newDiv.appendChild(newContent);
            newDiv.appendChild(newImg);
            newDiv.classList.add("user");
            // add the newly created element and its content into the DOM
            if(miniroom){
               miniroom.appendChild(newDiv);
            }
            else{
               alert("찾을수없음");
            }
        }
        
        function printSayBox(id){
            miniroom = document.getElementById("miniroom");
            newDiv = document.createElement("div");
            newContent = document.createTextNode(comment);
            newDiv.appendChild(newContent);
            userDiv = document.getElementById(id);
            userRect = userDiv.getBoundingClientRect();
            newDiv.classList.add("sayBox");
            newDiv.id = sayBoxId;
            userDiv.appendChild(newDiv);
            newDiv.style.top = -newDiv.offsetHeight+"px";
            newDiv.style.left = 0 +"px";
              sleep(5000).then(() => document.getElementById(sayBoxId).remove());
        }
        
        function printChatBox(id,comment,type){
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
          userNameContent = document.createTextNode(today.toLocaleString() + "  " + id);
          
          userNameDiv.appendChild(userNameContent);
          userNameDiv.classList.add("chatName");
          chatBoxDiv.appendChild(userNameDiv);
          //
           chatBoxDiv.classList.add("chatBox");
           chatArea2.appendChild(chatBoxDiv);
           chatArea2.scrollTop = chatArea2.scrollHeight;
        }
        function sleep(ms) {
             return new Promise((r) => setTimeout(r, ms));
           }
        
        function disconnect(){
           var message = "disconnect;" + localId;
           location.href ="index.jsp";
           ws.send(message);
           ws.close();
        }
          window.addEventListener("beforeunload",disconnect);
    </script>

</head>
<body>

   <div class="container">
      <div class="header">
         <img src="img/logo2.png" alt="CloverStory Logo2" class="logo2">
         <div class="settings">
            <span></span> <a href="#">설정</a> <a href="#">로그아웃</a>
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
                  class="between-image"> <img src="img/img1.png"-
                  alt="Image between boxes 2" class="between-image">
            </div>
            <div id="chatBox" class="inner-box-2">
               <jsp:include page="chat.jsp">
                  <jsp:param value="<%=background%>" name="backgroundImg"/>
               </jsp:include>
            </div>
            <div id="anotherBox" class="inner-box-2" style="display: none">
            </div>
            <div id="Box_miniroom_design" class ="inner-box-2" style="display: none" >
               <jsp:include page="miniDesign.jsp"></jsp:include>
            </div>
            <div id="game" class ="inner-box-2" style="display: none" >
            	<jsp:include page="../yang/game.jsp"></jsp:include>
            </div>
			<div id="store" class="inner-box-2" style="display: none">
				<jsp:include page="storeDesign.jsp"></jsp:include>
			</div>            
         </div>
         <!-- 버튼 -->
         <div class="button-container">
            <button onclick="javascript:clickOpenBox('chatBox')" class="custom-button">홈</button>
            <button class="custom-button">프로필</button>
            <button onclick="javascript:clickOpenBox('Box_miniroom_design')" class="custom-button">미니룸</button>
            <button class="custom-button">게시판</button>
            <button class="custom-button">방명록</button>
            <button onclick = "javascript:clickOpenBox('store')" class="custom-button">상점</button>
            <button onclick = "javascript:clickOpenBox('game')" class="custom-button">게임</button>
            <button class="custom-button">음악</button>
         </div>

  

      </div>
   </div>
</body>
</html>