<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="guestbook.GuestbookMgr, guestbook.GuestbookBean, java.util.List" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>CloverStory</title>
<!-- Linking the CSS file -->
<link rel="stylesheet" type="text/css" href="css/style.css">
<link rel="stylesheet" type="text/css" href="css/guestbook.css">
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
                <!-- 이미지 박스 -->
                <div class="image-box">
                    <img src="img/img1.png" alt="Image between boxes 1" class="between-image">
                    <img src="img/img1.png" alt="Image between boxes 2" class="between-image">
                </div>
                <div align="center" class="inner-box-2">
                    <h1 class="guestbook-title">방명록</h1>
                    <div class="guestbook-line"></div>

                    <!-- 방명록 작성 폼 -->
                    <div class="guestbook-form">
                        <form method="POST" action="guestbook.jsp">
                            <input type="text" name="guestbookContent" id="guestbook-input" class="guestbook-input" placeholder="일촌에게 방문 기록을 남겨보세요~ !" required />
                            <label for="private">
                                <input type="checkbox" name="guestbookSecret" id="private" value="Y"> 비밀글
                            </label>
                            <input type="submit" id="submit-button" class="submit-button" value="등록" />
                        </form>
                    </div>

                    <!-- 방명록 항목들이 나타나는 네모 상자 -->
                    <div class="entry-container">
                        <div class="guestbook-entries">
                            <%
                                // owner_id와 writer_id를 임의로 설정
                                String ownerId = "aaa"; // 방명록 주인의 ID 설정
                                int itemsPerPage = 3; // 페이지당 항목 수
                                int currentPage = request.getParameter("page") != null ? Integer.parseInt(request.getParameter("page")) : 1;
                                int totalEntries = 0;

                                // GuestbookMgr 객체 생성
                                GuestbookMgr guestbookMgr = new GuestbookMgr();

                                // DB에서 방명록 목록 가져오기
                                List<GuestbookBean> guestbookList = guestbookMgr.getGuestbookEntries(ownerId);
                                totalEntries = guestbookList.size(); // 전체 방명록 수

                                if (guestbookList != null && !guestbookList.isEmpty()) {
                                    int startIndex = (currentPage - 1) * itemsPerPage;
                                    int endIndex = Math.min(startIndex + itemsPerPage, guestbookList.size());
                                    for (int i = startIndex; i < endIndex; i++) {
                                        GuestbookBean entry = guestbookList.get(i);
                                        int guestbookNum = entry.getGuestbookNum(); // 방명록 번호
                                        String content = entry.getGuestbookContent(); // 방명록 내용
                                        String writer = entry.getWriterId(); // 작성자
                                        String guestbookSecret = entry.getGuestbookSecret(); // 비밀글 여부
                            %>
                            <div class="guestbook-entry" data-secret="<%= guestbookSecret %>">
                              
                                <!-- 작성자 정보 및 내용 출력 -->
                                <span class="profile-name"><%= writer %></span>
                              	<div class="guestbook-line2"></div>
                                <p class="guestbook-content"><%= content %></p>

                                <!-- 삭제 아이콘 -->
                                <img src="img/bin.png" class="delete-icon" 
                                     onclick="deleteEntry(this.parentElement, <%= guestbookNum %>, <%= guestbookList.indexOf(entry) %>)">

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
                            int maxPageButtons = 5; // 한 번에 표시할 페이지 수
                            int pageGroup = (int) Math.ceil((double) currentPage / maxPageButtons);
                            int startPage = (pageGroup - 1) * maxPageButtons + 1;
                            int endPage = Math.min(startPage + maxPageButtons - 1, totalPages);

                            // 이전 페이지 그룹 버튼
                            if (startPage > 1) {
                        %>
                        <a href="guestbook.jsp?page=<%= Math.max(startPage - maxPageButtons, 1) %>" class="page-button">이전</a>
                        <%
                            }

                            // 현재 페이지 그룹의 페이지 번호 표시
                            for (int i = startPage; i <= endPage; i++) {
                        %>
                        <a href="guestbook.jsp?page=<%= i %>" class="page-button <%= i == currentPage ? "active" : "" %>"><%= i %></a>
                        <%
                            }

                            // 다음 페이지 그룹 버튼
                            if (endPage < totalPages) {
                        %>
                        <a href="guestbook.jsp?page=<%= endPage + 1 %>" class="page-button">다음</a>
                        <%
                            }
                        %>
                    </div>

                </div>
            </div>

            <!-- 버튼 -->
            <div class="button-container">
                <button class="custom-button">홈</button>
                <button class="custom-button">프로필</button>
                <button class="custom-button">미니룸</button>
                <button class="custom-button">게시판</button>
                <button class="custom-button" style="background-color: #F7F7F7; font-weight: 600;">방명록</button>
                <button class="custom-button">상점</button>
                <button class="custom-button">게임</button>
                <button class="custom-button">음악</button>
            </div>
        </div>
    </div>

<%
    // 방명록 작성 처리
    if (request.getMethod().equalsIgnoreCase("POST")) {
        String guestbookSecret = request.getParameter("guestbookSecret") != null ? "Y" : "N";
        String guestbookContent = request.getParameter("guestbookContent").trim();
        // ownerId 및 writerId는 이미 선언된 변수이므로 재사용
        String writerId = "bbb"; // 작성자 ID 임의로 설정

        // DB에 방명록 저장
        boolean success = guestbookMgr.writeGuestbook(guestbookSecret, ownerId, writerId, guestbookContent);

        if (success) {
            out.println("<p>방명록이 성공적으로 등록되었습니다.</p>");
            response.sendRedirect("guestbook.jsp?page=" + currentPage); // 방명록이 등록되면 페이지를 새로고침하여 목록을 업데이트
        } else {
            out.println("<p>방명록 등록에 실패했습니다.</p>");
        }
    }
%>

    <!-- 자바스크립트 코드 -->
    <script>
	 // 방명록 항목들에 대해 비밀글 여부를 확인하고, 아이콘을 추가하는 함수
	    document.querySelectorAll('.guestbook-entry').forEach(function(entry) {
	        var isSecret = entry.getAttribute('data-secret') === 'Y'; // 'Y'가 비밀글을 의미
	
	        if (isSecret) {
	            // 비밀글일 경우 secret.png 아이콘 추가
	            var secretIcon = document.createElement('img');
	            secretIcon.src = '<%= request.getContextPath() %>/eunhyo/img/secret.png'; // '/' 추가
	            secretIcon.className = 'secret-icon'; // 아이콘 클래스 설정
	            entry.appendChild(secretIcon); // entry div에 아이콘 추가
	        }
	    });
        function deleteEntry(entryElement, guestbookNum, index) {
            const confirmDelete = confirm("삭제하시겠습니까?");
            if (confirmDelete) {
                // AJAX 요청을 통해 서버에 삭제 요청을 보냄
                var xhr = new XMLHttpRequest();
                xhr.open("POST", "<%=request.getContextPath()%>/eunhyo/deleteguestbook.jsp", true);

                xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");

                xhr.onload = function () {
                    if (xhr.status === 200 && xhr.responseText.trim() === "success") {
                        entryElement.remove(); // 화면에서 해당 항목 제거
                        
                        // 현재 페이지 항목이 없으면 이전 페이지로 이동
                        var remainingEntries = document.querySelectorAll('.guestbook-entry').length;
                        if (remainingEntries === 0 && <%= totalEntries %> > 1) {
                            if (currentPage > 1) {
                                // 이전 페이지로 이동
                                window.location.href = "guestbook.jsp?page=" + (currentPage - 1);
                            } else {
                                // 1페이지가 남아있는 상태라면 페이지 새로고침
                                location.reload();
                            }
                        } else {
                            location.reload(); // 항목 삭제 후 페이지 새로고침
                        }
                    } else {
                        alert('삭제에 실패했습니다. 서버 응답: ' + xhr.responseText); 
                    }
                };

                var params = "guestbook_num=" + encodeURIComponent(guestbookNum);
                xhr.send(params); 
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
