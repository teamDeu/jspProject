<%@page import="guestbook.GuestbookprofileBean"%>
<%@page import="java.util.TimeZone"%>
<%@page import="guestbook.GuestbookMgr"%>
<%@page import="guestbook.GuestbookBean"%>
<%@page import="guestbook.GuestbookanswerMgr"%>
<%@page import="guestbook.GuestbookanswerBean"%>
<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html; charset=UTF-8"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>


<jsp:useBean id="mgr" class="guestbook.GuestbookMgr" />
<jsp:useBean id="profileMgr" class="guestbook.GuestbookprofileMgr" />
<%
TimeZone seoulTimeZone = TimeZone.getTimeZone("Asia/Seoul");
TimeZone.setDefault(seoulTimeZone);
%>
<%
String cPath = request.getContextPath();

String ownerId = request.getParameter("ownerId");
ArrayList<GuestbookBean> entries = mgr.getGuestbookEntries(ownerId);

// 날짜 형식 정의 (년-월-일 시:분) 및 시간대 설정
SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss"); 
dateFormat.setTimeZone(seoulTimeZone);
%>
<%
String sessionUserId = (String) session.getAttribute("idKey"); // 현재 로그인한 사용자 ID
%>


<!DOCTYPE html>
<html lang="ko">
<head>
<!-- 캐시 방지 메타 태그 추가 -->
<meta http-equiv="Cache-Control"
	content="no-cache, no-store, must-revalidate" />
<meta http-equiv="Pragma" content="no-cache" />
<meta http-equiv="Expires" content="0" />
<style>
/*방명록 텍스트 스타일*/
.guestbook-title {
	color: #80A46F;
	text-align: center;
	font-size: 36px;
	font-weight: 600;
	position: absolute;
	top: 0px;
	left: 30px;
}
/* 실선 스타일 */
.guestbook-line {
	border-bottom: 2px solid #BAB9AA; /* 실선 색상 및 두께 */
	width: 95%; /* 실선의 너비 */
	position: absolute;
	top: 80px;
	left: 25px;
}
/* 작성 폼 스타일 */
.guestbook-form {
	display: flex;
	align-items: center;
	position: absolute;
	left: 30px;
	bottom: 30px;
	width: 90%;
	justify-content: space-between;
	background-color: #F2F2F2;
	padding: 10px;
	border: 1px solid #e0e0d1;
	border-radius: 5px;
	margin-bottom: -20px;
}
/* textarea 스타일 */
#guestbookContent {
	height: 20px;
	width: 660px;
	flex: 1;
	padding: 8px;
	border: 1px solid #DCDCDC;
	border-radius: 5px;
	color: #000000;
	background-color: #FFFFFF;
	font-family: 'NanumTobak', sans-serif;
	font-size: 20px;
}
/* submit 버튼 스타일 */
#submitButton {
	display: flex;
	background-color: #FFFFFF;
	color: #666;
	border: 1px solid #DCDCDC;
	border-radius: 10px;
	padding: 5px 10px;
	margin-left: 10px;
	cursor: pointer;
	font-size: 20px;
	position: absolute;
	right: 10px;
	bottom: 15px;
}
/* 방명록 전체 container */
.entry-container {
	width: 100%;
	height: 560px;
	margin-top: 90px;
	background-color: #F7F7F7;
}
/* 리스트 스타일 제거 */
#guestbookList {
	list-style-type: none; /* 동그라미 모양 제거 */
	padding: 0; /* 리스트의 기본 패딩 제거 */
	margin: 0px; /* 리스트의 기본 마진 제거 */
}

#guestbookList li {
	margin-bottom: 20px; /* 리스트 항목 간 간격 */
	padding: 10px; /* 클릭 가능한 영역 확보 */
	background-color: #FFFFFF;
	border: 1px solid #DCDCDC;
	border-radius: 8px;
	position: relative; /* 자식 요소 위치 조정 */
	font-size: 21.5px;
	margin-left: 20px;
	width: 820px;
	height: 130px;
	margin-left: 25px;
}

/* 삭제 이미지 스타일 */
.delete-icon {
	width: 13px;
	height: 15px;
	position: absolute;
	top: 20px;
	right: 20px;
	cursor: pointer;
}

.author-container {
	display: inline-block; /* 컨테이너가 텍스트와 밑줄을 함께 감싸도록 함 */
	position: relative; /* 밑줄 위치를 조절하기 위해 설정 */
	margin-left: 0px; /* 텍스트를 왼쪽에 여백 주기 */
}

.author {
	margin-left: 35px;
	margin-top: 0px;
	font-size: 25px;
	font-weight: bold;
}

.author-underline {
	height: 1px; /* 밑줄의 두께 */
	width: 820px; /* 밑줄의 길이 */
	background-color: #ccc; /* 밑줄 색상 */
	margin-top: -15px;
}

.content {
	margin-left: 5px;
	margin-top: 0px;
	font-size: 25px;
}

.date {
	margin-left: 630px;
	margin-top: -88px;
	font-size: 20px;
}

/* li에 적용될 기본 스타일 */
.guestbook-entry {
	margin-bottom: 20px;
	padding: 10px;
	background-color: #FFFFFF;
	border: 1px solid #DCDCDC;
	border-radius: 8px;
	position: relative;
	font-size: 21.5px;
}

/* 비밀글 체크박스 스타일 */
#secretCheckbox {
	margin-right: 13px;
	position: absolute;
	right: 90px;
	top: 20px;
}

label[for="secretCheckbox"] {
	margin-right: 5px;
	font-size: 22px;
	position: absolute;
	right: 60px;
	top: 15px;
	color: #666;
}

/* 비밀글 아이콘 스타일 */
.secret-icon {
	width: 12px;
	height: 15px;
	position: absolute;
	top: 20px;
	right: 50px;
}
/* 비밀글 안내 컨테이너 스타일 */
.secret-container {
    display: flex; /* 이미지와 텍스트를 가로로 나란히 배치 */
    align-items: center; /* 이미지와 텍스트를 수직으로 중앙 정렬 */
    justify-content: center; /* 컨테이너 중앙에 배치 */
    position: absolute;
    top: 50%; /* 수직 중앙 정렬 */
    left: 50%; /* 수평 중앙 정렬 */
    transform: translate(-50%, -50%); /* 정확한 중앙으로 이동 */
}

/* 비밀글 안내 이미지 스타일 */
.secret-image {
    width: 15px; /* 이미지 크기 */
    height: auto;
    margin-right: 10px; /* 이미지와 텍스트 사이 간격 */
}

/* 비밀글 안내 텍스트 스타일 */
.secret-text {
    font-size: 22px; /* 텍스트 크기 */
    color: #000000; /* 텍스트 색상 */
    margin: 0;
}
/* 프로필 사진 스타일 */
.profile-image {
    width: 30px; /* 프로필 사진 크기 */
    height: 30px;
    border-radius: 50%; /* 원형으로 만들기 */
    margin-right: 10px; /* 사진과 텍스트 사이 간격 */
    vertical-align: middle; /* 텍스트와 수직 중앙 정렬 */
    position: absolute;
    top:0px;
    
}


</style>
<meta charset="UTF-8">
<title>Guestbook</title>
<script>
     // AJAX를 이용한 방명록 작성 함수
        // 방명록 작성 함수 (AJAX 사용)
   function addGuestbookEntry() {
    var content = document.getElementById("guestbookContent").value;
    var ownerId = "<%=ownerId%>";
    var isSecret = document.getElementById("secretCheckbox").checked ? 1 : 0; // 체크박스 상태 (0 또는 1)
    var xhr = new XMLHttpRequest();
    var cPath = "<%=cPath%>";

    xhr.open("POST", cPath + "/eunhyo/guestbookadd.jsp", true);
    xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
    xhr.onreadystatechange = function() {
        if (xhr.readyState === 4 && xhr.status === 200) {
            // JSON 응답을 처리하여 방명록에 추가
            try {
                var response = JSON.parse(xhr.responseText);

                // guestbookNum이 0이 아니면 성공으로 처리
                if (response.guestbookNum !== 0) {
                    alert("방명록이 작성되었습니다.");
                    appendGuestbookEntry(
                        response.guestbookNum, 
                        response.writerId, 
                        response.content, 
                        response.writtenAt, 
                        isSecret // 비밀글 여부 전달
                    );
                    // 입력 필드 비우기
                    document.getElementById("guestbookContent").value = '';
                    document.getElementById("secretCheckbox").checked = false; // 체크박스 초기화
                } else {
                    alert("방명록 작성에 실패하였습니다.");
                }
            } catch (e) {
                console.error("응답 처리 중 오류 발생:", e);
                alert("응답 처리 중 오류가 발생하였습니다.");
            }
        }
    };
    xhr.send("content=" + encodeURIComponent(content) + "&ownerId=" + encodeURIComponent(ownerId) + "&secret=" + isSecret);
}



     
     // 새 방명록 항목을 페이지에 추가하는 함수
function appendGuestbookEntry(guestbookNum, writerId, content, writtenAt, isSecret) {
    var ul = document.getElementById("guestbookList");
    if (!ul) {
        console.error("guestbookList가 존재하지 않습니다.");
        return;
    }

    // `li` 요소를 생성하고 스타일 클래스를 추가
    var li = document.createElement("li");
    li.id = "entry-" + guestbookNum;
    li.classList.add('guestbook-entry');

    // 작성자 컨테이너 생성
    var authorContainer = document.createElement("div");
    authorContainer.classList.add('author-container');
    
    // 작성자 텍스트 생성
    var author = document.createElement("p");
    author.classList.add('author');
    author.textContent = writerId;

    // 작성자 밑줄 생성
    var underline = document.createElement("div");
    underline.classList.add('author-underline');

    // 컨텐츠 텍스트 생성
    var contentElem = document.createElement("p");
    contentElem.classList.add('content');
    contentElem.textContent = content;

    // 날짜 텍스트 생성
    var dateElem = document.createElement("p");
    dateElem.classList.add('date');
    dateElem.textContent = writtenAt;

    // 삭제 아이콘 생성
    var deleteIcon = document.createElement("img");
    deleteIcon.src = 'img/bin.png';
    deleteIcon.classList.add('delete-icon');
    deleteIcon.onclick = function() {
        deleteGuestbookEntry(guestbookNum);
    };
    
 	// 비밀글 아이콘 생성 및 추가
    if (isSecret) {
        var secretIcon = document.createElement("img");
        secretIcon.src = 'img/secret.png';
        secretIcon.classList.add('secret-icon');
        li.appendChild(secretIcon);
    }

    // `li` 요소에 모든 생성한 요소 추가
    authorContainer.appendChild(author);
    authorContainer.appendChild(underline);
    li.appendChild(authorContainer);
    li.appendChild(contentElem);
    li.appendChild(dateElem);
    li.appendChild(deleteIcon);

    ul.prepend(li); // 새 항목을 목록의 맨 위에 추가
}


     
        // AJAX를 이용한 방명록 삭제 함수
        function deleteGuestbookEntry(guestbookNum) {
            if (confirm("정말 삭제하시겠습니까?")) {
                var xhr = new XMLHttpRequest();
                var cPath = "<%=cPath%>";
                xhr.open("POST", cPath + "/eunhyo/deleteguestbook.jsp", true);
                xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
                xhr.onreadystatechange = function() {
                    if (xhr.readyState === 4 && xhr.status === 200) {
                        // 삭제 성공 시 해당 목록 삭제
                        alert("방명록이 삭제되었습니다.");
                        document.getElementById("entry-" + guestbookNum).remove();
                    }
                };
                xhr.send("guestbookNum=" + guestbookNum);
            }
        }
    </script>
</head>
<body>
	<h1 class="guestbook-title">방명록</h1>
	<div class="guestbook-line"></div>

	<div class="entry-container">
		<ul id="guestbookList">
			<% for (GuestbookBean entry : entries) { 
				// 작성자의 프로필 정보를 가져옴
				GuestbookprofileBean profile = profileMgr.getProfileByUserId(entry.getWriterId());
			%>
            <li id="entry-<%=entry.getGuestbookNum()%>">
                <!-- 비밀글 처리 로직 -->
                <% if ("1".equals(entry.getGuestbookSecret()) && sessionUserId != null 
                        && !(sessionUserId.equals(entry.getWriterId()) || sessionUserId.equals(ownerId))) { %>
                    <!-- 비밀글이며 작성자 또는 방명록 주인이 아닌 경우 -->
                    <div class="secret-container">
                        <img src="img/secret.png" class="secret-image">
                        <p class="secret-text">비밀글입니다.</p>
                    </div>
                <% } else { %>
                    <!-- 작성자의 프로필 사진과 이름, 날짜를 표시 -->
                    <div class="author-container">
					    <% if (profile != null) { %>
					        <!-- 프로필 사진 -->
					        <img src="<%=profile.getProfilePicture()%>" alt="프로필 사진" class="profile-image">
					        <!-- 프로필 이름과 작성자 아이디 -->
					        <p class="author"><%=profile.getProfileName()%> (<%=entry.getWriterId()%>)</p>
					    <% } else { %>
					        <!-- 프로필이 null인 경우 작성자 아이디만 표시 -->
					        <p class="author"><%=entry.getWriterId()%></p>
					    <% } %>
					    <div class="author-underline"></div>
					</div>


                    
                    <!-- 비밀글이 아니거나, 작성자 또는 방명록 주인인 경우 내용 표시 -->
                    <p class="content"><%=entry.getGuestbookContent()%></p>
                    <p class="date"><%=entry.getWrittenAt() != null ? dateFormat.format(entry.getWrittenAt()) : ""%></p>

                    <!-- 비밀글이면 방명록 주인 또는 작성자에게만 secret.png 아이콘 표시 -->
                    <% if ("1".equals(entry.getGuestbookSecret()) && sessionUserId != null 
                            && (sessionUserId.equals(entry.getWriterId()) || sessionUserId.equals(ownerId))) { %>
                        <img src="img/secret.png" class="secret-icon" alt="비밀글">
                    <% } %>

                    <!-- 로그인한 사용자가 방명록 주인 또는 작성자일 경우에만 휴지통 아이콘 표시 -->
                    <% if (sessionUserId != null && (sessionUserId.equals(entry.getWriterId()) || sessionUserId.equals(ownerId))) { %>
                        <img src="img/bin.png" class="delete-icon"
                        onclick="deleteGuestbookEntry(<%=entry.getGuestbookNum()%>)"
                        alt="삭제">
                    <% } %>
                <% } %>
            </li>
        <% } %>
    </ul>
</div>
	<div class="guestbook-form">
		<form id="guestbookForm" onsubmit="addGuestbookEntry(); return false;">
			<label for="secretCheckbox">비밀글</label> <input type="checkbox"
				id="secretCheckbox" name="secretCheckbox">
			<textarea id="guestbookContent" rows="5" placeholder="방명록 내용을 입력하세요"></textarea>
			<br> <input type="hidden" name="ownerId" value="<%=ownerId%>">
			<input type="submit" id="submitButton" value="등록">

		</form>
	</div>
</body>
</html>

