<%@page import="pjh.MemberBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page
	import="guestbook.GuestbookMgr, guestbook.GuestbookBean, java.util.List"%>
<head>
<style type="text/css">
@font-face {
	font-family: 'NanumTobak';
	src: url('../나눔손글씨 또박또박.TTF') format('truetype');
}

/* inner-box-2의 방명록 텍스트 스타일 */
.guestbook-title {
	color: #80A46F;
	text-align: center;
	font-size: 36px;
	font-weight: 600;
	position: absolute;
	top: 0px;
	left: 30px;
}

/* inner-box-2의 내용이 가운데 정렬 */
.inner-box-2 {
	display: flex;
	justify-content: center;
	align-items: center;
}

/* 실선 스타일 */
.guestbook-line {
	border-bottom: 2px solid #BAB9AA; /* 실선 색상 및 두께 */
	width: 95%; /* 실선의 너비 */
	position: absolute;
	top: 80px;
	left: 25px;
}

.guestbook-line2 {
	border-bottom: 1px solid #BAB9AA; /* 실선 색상 및 두께 */
	width: 95%; /* 실선의 너비 */
	position: absolute;
	top: 35px;
	left: 20px;
}
/* 방명록 작성 폼 스타일 */
.guestbook-form {
	display: flex;
	align-items: center;
	position: absolute;
	bottom: 30px;
	width: 90%;
	justify-content: space-between;
	background-color: #F2F2F2;
	padding: 10px;
	border: 1px solid #e0e0d1;
	border-radius: 5px;
	margin-bottom: -20px;
}

.guestbook-input {
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

#private {
	margin-left: 10px;
	vertical-align: middle;
}

/* 체크박스 옆 텍스트(라벨)의 폰트 크기를 조정 */
label[for="private"] {
	font-size: 20px;
	vertical-align: middle;
}

.submit-button {
	background-color: #FFFFFF;
	color: #666;
	border: 1px solid #DCDCDC;
	border-radius: 10px;
	padding: 5px 10px;
	margin-left: 10px;
	cursor: pointer;
	font-family: 'NanumTobak', sans-serif;
	font-size: 20px;
}

/* 방명록 전체 container */
.entry-container {
	width: 100%;
	height: 570px;
	margin-top: -10px;
	background-color: #F7F7F7;
}

.guestbook-entry {
	background-color: #FFFFFF;
	border: 1px solid #DCDCDC;
	padding: 10px;
	margin-bottom: 50px;
	border-radius: 5px;
	height: 120px;
	width: 800px;
	position: relative;
	margin-left: 35px;
}

/* 방명록 내용을 담는 컨테이너 */
.guestbook-content-container {
	width: 95%;
	max-height: 50px; /* 최대 높이 설정 */
	background-color: #FFFFFF;
	border-top: 1px solid #DCDCDC;
	margin-bottom: 10px;
	overflow-y: auto; /* 세로 스크롤 */
	overflow-x: hidden; /* 가로 스크롤 숨기기 */
}

/* 방명록 내용의 위치와 스타일 */
.guestbook-content {
	font-family: 'NanumTobak', sans-serif;
	font-size: 21.5px;
	color: #333;
	text-align: left;
	padding: 0;
	margin: 1px 0 0 20px;
	overflow-y: auto;
}

/* 답글 입력 폼 */
.reply-form {
	position: absolute;
	width: 100%;
	height: 30px;
	display: flex;
	justify-content: space-between;
	margin-top: 90px;
	margin-left: -10px;
}

.reply-input {
	flex: 1;
	padding: 8px;
	border: 1px solid #DCDCDC;
	border-radius: 5px;
	font-family: 'NanumTobak', sans-serif;
	font-size: 20px;
	margin-right: 5px;
}

.reply-button {
	background-color: #FFFFFF;
	color: #666;
	border: 1px solid #DCDCDC;
	border-radius: 5px;
	padding: 5px 10px;
	cursor: pointer;
	font-family: 'NanumTobak', sans-serif;
	font-size: 16px;
}

/* 답글 표시 */
.reply-container {
	margin-top: 10px;
	margin-left: 15px;
	background-color: #FFFFFF;
	width: 95%;
	height: 50px; /* 답글 컨테이너의 최대 높이 설정 */
	overflow-y: auto; /* 높이를 넘을 경우 스크롤 표시 */
}

.reply-content {
	margin-top: 5px;
	font-size: 18px;
	color: #555;
	font-family: 'NanumTobak', sans-serif;
	text-align: left;
	padding: 0;
	margin: 0 0 0 10px;
}

/* 페이지 버튼 */
.pagination-container {
	position: absolute;
	bottom: 50px;
	display: flex;
	justify-content: center;
	margin-bottom: 20px;
}

.page-button {
	border-radius: 5px;
	background-color: white;
	border: 1px solid #DCDCDC;
	padding: 5px 10px;
	margin: 5px;
	cursor: pointer;
	font-family: 'NanumTobak', sans-serif;
	font-size: 20px;
	width: 20px;
	height: 20px;
	text-align: center;
	line-height: 20px;
	padding: 0;
}

.page-button.active {
	background-color: white;
	color: #80A46F;
	font-weight: bold;
}

/* 이전, 다음 버튼 스타일 */
.nav-button {
	border-radius: 5px;
	background-color: #f0f0f0;
	border: 1px solid #DCDCDC;
	padding: 5px 10px;
	margin: 5px;
	cursor: pointer;
	font-family: 'NanumTobak', sans-serif;
	font-size: 15px;
	width: 50px;
	height: 20px;
	text-align: center;
	line-height: 20px;
	padding: 0;
}

/* 버튼 hover 스타일 (마우스를 올렸을 때) */
.nav-button:hover {
	background-color: #ddd;
	color: #000;
}

/* 방명록 항목 프로필 섹션 */
.profile-section {
	display: flex;
	align-items: center;
	margin-bottom: 10px;
}

.profile-image {
	width: 30px;
	height: 30px;
	border-radius: 50%;
	margin-right: 10px;
}

.profile-name {
	margin-top: -5px;
	margin-left: 40px;
	font-weight: bold;
	font-size: 20px;
	color: #333;
}

.profile-time {
	font-size: 14px;
	color: #888;
	margin-left: 10px;
}

/* 비밀글 아이콘 */
.secret-icon {
	width: 12px;
	height: 15px;
	position: absolute;
	top: 20px;
	right: 70px;
}

/* 휴지통 아이콘*/
.delete-icon {
	width: 13px;
	height: 15px;
	position: absolute;
	top: 15px;
	right: 30px;
	cursor: pointer;
}
</style>
</head>
<body>
	
	<%
	MemberBean loggedInUserBean = (MemberBean) session.getAttribute("loggedInUser"); // 현재 로그인한 사용자 정보를 가져옴
	String loggedInUserId = loggedInUserBean != null ? loggedInUserBean.getUser_id() : null; // 사용자 ID 추출
	String ownerId = request.getParameter("ownerId") != null ? request.getParameter("ownerId") : loggedInUserId; // 미니홈피 주인 ID 가져오기

	int itemsPerPage = 3; // 페이지당 항목 수
	int currentPage = request.getParameter("page") != null ? Integer.parseInt(request.getParameter("page")) : 1;
	int totalEntries = 0;

	GuestbookMgr guestbookMgr = new GuestbookMgr();

	// 방명록 항목 조회 (ownerId로 필터링)
	List<GuestbookBean> guestbookList = guestbookMgr.getGuestbookEntriesByOwner(ownerId);
	totalEntries = guestbookList.size();
	%>
	<h1 class="guestbook-title">방명록</h1>
	<div class="guestbook-line"></div>
	<!-- 방명록 작성 폼 (로그인한 사용자만 작성 가능) -->
	<div class="guestbook-form">
		<form id="guestbookForm">
		    <input type="text" name="guestbookContent" id="guestbook-input" class="guestbook-input" placeholder="일촌에게 방문 기록을 남겨보세요~ !" required />
		    <label for="private">
		        <input type="checkbox" name="guestbookSecret" id="private" value="Y"> 비밀글
		    </label>
		    <button type="button" id="submit-button" class="submit-button">등록</button>
		</form>

	</div>


	<!-- 방명록 목록 표시 -->
	<div class="entry-container">
		<div class="guestbook-entries">
			<%
			if (guestbookList != null && !guestbookList.isEmpty()) {
				int startIndex = (currentPage - 1) * itemsPerPage;
				int endIndex = Math.min(startIndex + itemsPerPage, guestbookList.size());
				for (int i = startIndex; i < endIndex; i++) {
					GuestbookBean entry = guestbookList.get(i);
					int guestbookNum = entry.getGuestbookNum();
					String content = entry.getGuestbookContent();
					String writer = entry.getWriterId();
					String guestbookSecret = entry.getGuestbookSecret();
			%>
			<div class="guestbook-entry" data-secret="<%=guestbookSecret%>">
				<!-- 작성자 정보 및 내용 출력 -->
				<span class="profile-name"><%=writer%></span>
				<div class="guestbook-line2"></div>
				<p class="guestbook-content"><%=content%></p>

				<!-- 삭제 아이콘 (로그인한 사용자만 삭제 가능) -->
				<%
				if (writer.equals(loggedInUserId)) {
				%>
				<img src="img/bin.png" class="delete-icon"
					onclick="deleteEntry(this.parentElement, <%=guestbookNum%>)">
				<%
				}
				%>

				<!-- 답글 입력 폼 -->
				<div class="reply-form">
					<input type="text" class="reply-input" placeholder="답글을 입력하세요" />
					<button class="reply-button" onclick="addReply(this)">답글</button>
				</div>
				<!-- 답글이 추가될 영역 -->
				<div class="reply-container"></div>
			</div>
			<%
			}
			} else {
			%>
			<p>방명록 항목이 없습니다.</p>
			<%
			}
			%>
		</div>
	</div>

	<!-- 페이지네이션 영역 -->
	<div class="pagination-container">
		<%
		int totalPages = (int) Math.ceil(totalEntries / (double) itemsPerPage);
		int maxPageButtons = 5;
		int pageGroup = (int) Math.ceil((double) currentPage / maxPageButtons);
		int startPage = (pageGroup - 1) * maxPageButtons + 1;
		int endPage = Math.min(startPage + maxPageButtons - 1, totalPages);

		// 이전 페이지 그룹 버튼
		if (startPage > 1) {
		%>
		<a
			href="guestbook.jsp?page=<%=Math.max(startPage - maxPageButtons, 1)%>"
			class="page-button">이전</a>
		<%
		}

		// 현재 페이지 그룹의 페이지 번호 표시
		for (int i = startPage; i <= endPage; i++) {
		%>
		<a href="guestbook.jsp?page=<%=i%>"
			class="page-button <%=i == currentPage ? "active" : ""%>"><%=i%></a>
		<%
		}

		// 다음 페이지 그룹 버튼
		if (endPage < totalPages) {
		%>
		<a href="guestbook.jsp?page=<%=endPage + 1%>" class="page-button">다음</a>
		<%
		}
		%>
	</div>

	<!-- 자바스크립트 코드 -->
	<script>
    // 비밀글 여부를 확인하고 아이콘을 추가하는 함수
    document.querySelectorAll('.guestbook-entry').forEach(function(entry) {
        var isSecret = entry.getAttribute('data-secret') === 'Y'; // 'Y'가 비밀글을 의미

        if (isSecret) {
            // 비밀글일 경우 secret.png 아이콘 추가
            var secretIcon = document.createElement('img');
            secretIcon.src = '<%=request.getContextPath()%>/eunhyo/img/secret.png'; // '/' 추가
            secretIcon.className = 'secret-icon'; // 아이콘 클래스 설정
            entry.appendChild(secretIcon); // entry div에 아이콘 추가
        }
    });

    // 방명록 항목을 삭제하는 함수
function deleteEntry(entryElement, guestbookNum) {
    const confirmDelete = confirm("삭제하시겠습니까?");
    if (confirmDelete) {
        // AJAX 요청을 통해 서버에 삭제 요청을 보냄
        var xhr = new XMLHttpRequest();
        xhr.open("POST", "<%=request.getContextPath()%>/eunhyo/deleteguestbook.jsp", true);
        xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");

        xhr.onload = function() {
            console.log("Server response:", xhr.responseText); // 서버 응답 확인

            if (xhr.status === 200) {
                var response = xhr.responseText.trim();
                if (response === 'success') {
                    // 삭제 성공 시 해당 항목을 DOM에서 제거
                    entryElement.remove();
                    alert('방명록이 삭제되었습니다.');
                } else {
                    alert('방명록 삭제에 실패했습니다.');
                }
            } else {
                alert('서버 오류로 삭제에 실패했습니다.');
            }
        };

        var params = "guestbook_num=" + encodeURIComponent(guestbookNum);
        console.log("Deleting guestbookNum:", guestbookNum);
        xhr.send(params); 
    }
}


//방명록 항목을 등록하는 함수 (AJAX로 등록 후 바로 페이지에 추가)
document.getElementById('submit-button').addEventListener('click', function submitGuestbookEntry(event) {
    event.preventDefault(); // 폼의 기본 전송을 막음

    var guestbookContent = document.getElementById('guestbook-input').value.trim();
    var guestbookSecret = document.getElementById('private').checked ? 'Y' : 'N'; // 체크박스 상태 확인
    var ownerId = "<%= ownerId %>";
    
    if (guestbookContent) {
        // AJAX 요청 설정
        var xhr = new XMLHttpRequest();

        xhr.open("POST", "<%=request.getContextPath()%>/eunhyo/guestbookAdd.jsp", true);


        xhr.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');

        xhr.onload = function() {
            console.log("Server response:", xhr.responseText.trim()); // 서버 응답 확인

            if (xhr.status === 200) {
                var response = xhr.responseText.trim();
                if (response === 'success') {
                    // 새로운 방명록 항목을 페이지에 추가
                    addGuestbookEntry(guestbookContent, '<%= loggedInUserId %>', guestbookSecret);
                    document.getElementById('guestbook-input').value = ''; // 입력 필드 초기화
                    document.getElementById('private').checked = false; // 체크박스 초기화
                    // UI로 충분히 표시되므로 alert를 지양합니다.
                } else {
                    alert('방명록 등록에 실패했습니다. 서버 응답: ' + response);
                }
            } else {
                alert('서버 오류로 등록에 실패했습니다.');
            }
        };

        // 오류 발생 시 처리
        xhr.onerror = function() {
            alert('네트워크 오류로 등록에 실패했습니다.');
        };

        // 요청에 전송할 데이터 구성 (URL-encoded)
        var params = 'guestbookContent=' + encodeURIComponent(guestbookContent) +
				        '&guestbookSecret=' + encodeURIComponent(guestbookSecret) +
				        '&ownerId=' + encodeURIComponent(ownerId); // ownerId 추가
xhr.send(params);
    } else {
        alert('내용을 입력해주세요.');
    }
});





    // 새로운 방명록 항목을 추가하는 함수
    function addGuestbookEntry(content, writer, secret) {
    var entryContainer = document.querySelector('.entry-container .guestbook-entries');

    // 새로운 방명록 항목 생성
    var newEntry = document.createElement('div');
    newEntry.className = 'guestbook-entry';
    newEntry.dataset.secret = secret;

    // 작성자 및 내용 설정
    newEntry.innerHTML = `
	    <span class="profile-name">${writer}</span>
	    <div class="guestbook-line2"></div>
	    <p class="guestbook-content">${content}</p>
	`;


    // 항목을 entryContainer의 가장 위에 추가
    entryContainer.prepend(newEntry);

    // 비밀글일 경우 아이콘 추가
    if (secret === 'Y') {
        var secretIcon = document.createElement('img');
        secretIcon.src = '<%=request.getContextPath()%>/eunhyo/img/secret.png';
        secretIcon.className = 'secret-icon';
        newEntry.appendChild(secretIcon);
    }
}


    function addReply(button) {
        var replyContainer = button.closest('.guestbook-entry').querySelector('.reply-container');
        var replyInput = button.closest('.reply-form').querySelector('.reply-input');
        var replyText = replyInput.value.trim();

        if (replyText.length > 0) {
            var replyElement = document.createElement('p');
            replyElement.className = 'reply-content';
            replyElement.textContent = '└ 답글: ' + replyText;

            replyContainer.appendChild(replyElement);
            replyInput.value = '';
        } else {
            alert('답글을 입력하세요.');
        }
    }
</script>


</body>
</html>