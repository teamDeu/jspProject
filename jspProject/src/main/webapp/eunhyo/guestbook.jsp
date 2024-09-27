<%@page import="guestbook.GuestbookMgr"%>
<%@page import="guestbook.GuestbookBean"%>
<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html; charset=UTF-8"%>

<jsp:useBean id="mgr" class="guestbook.GuestbookMgr" />
<%
	String cPath = request.getContextPath();

    String ownerId = request.getParameter("ownerId");
    ArrayList<GuestbookBean> entries = mgr.getGuestbookEntries(ownerId);
%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>Guestbook</title>
     <script>
	  // AJAX를 이용한 방명록 작성 함수
	     function addGuestbookEntry() {
	         var content = document.getElementById("guestbookContent").value;
	         var ownerId = "<%= ownerId %>";
	         var xhr = new XMLHttpRequest();
	         var cPath = "<%= cPath %>";
	
	         xhr.open("POST", cPath + "/eunhyo/guestbookadd.jsp", true);
	         xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
	         xhr.onreadystatechange = function() {
	             if (xhr.readyState === 4 && xhr.status === 200) {
	                 // 작성 성공 시 목록 업데이트
	                 alert("방명록이 작성되었습니다.");
	                 // 새로 작성된 방명록을 페이지에 추가
	                 var response = JSON.parse(xhr.responseText);
	                 appendGuestbookEntry(response.guestbookNum, response.writerId, response.content, response.writtenAt);
	                 // 입력 필드 비우기
	                 document.getElementById("guestbookContent").value = '';
	             }
	         };
	         xhr.send("content=" + encodeURIComponent(content) + "&ownerId=" + encodeURIComponent(ownerId));
	     }
	  
	  // 새 방명록 항목을 페이지에 추가하는 함수
	        function appendGuestbookEntry(guestbookNum, writerId, content, writtenAt) {
	            var ul = document.getElementById("guestbookList");
	            var li = document.createElement("li");
	            li.id = "entry-" + guestbookNum;

	            li.innerHTML = "<p><b>작성자:</b> " + writerId + "</p>" +
	                "<p><b>내용:</b> " + content + "</p>" +
	                "<p><b>작성일:</b> " + writtenAt + "</p>" +
	                "<button onclick='deleteGuestbookEntry(" + guestbookNum + ")'>삭제</button>";

	            ul.prepend(li); // 새로운 항목을 목록의 맨 위에 추가
	        }
	  
        // AJAX를 이용한 방명록 삭제 함수
        function deleteGuestbookEntry(guestbookNum) {
            if (confirm("정말 삭제하시겠습니까?")) {
                var xhr = new XMLHttpRequest();
                var cPath = "<%= cPath %>";
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
    <h2>방명록</h2>
    <form action="<%=cPath%>/eunhyo/guestbookadd.jsp" method="post">
	    <textarea name="content" rows="5" cols="40" placeholder="방명록 내용을 입력하세요"></textarea><br>
	    <input type="hidden" name="ownerId" value="<%= ownerId %>">
	    <input type="submit" value="작성">
	</form>
    
    <h3>글 목록</h3>
    <ul>
     <% for (GuestbookBean entry : entries) { %>
        <li id="entry-<%= entry.getGuestbookNum() %>">
            <p><b>작성자:</b> <%= entry.getWriterId() %></p>
            <p><b>내용:</b> <%= entry.getGuestbookContent() %></p>
            <p><b>작성일:</b> <%= entry.getWrittenAt() %></p>
            <button onclick="deleteGuestbookEntry(<%= entry.getGuestbookNum() %>)">삭제</button>
        </li>
    <% } %>
    </ul>
</body>
</html>
