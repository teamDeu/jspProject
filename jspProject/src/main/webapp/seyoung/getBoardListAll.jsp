<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.sql.Timestamp"%>
<%@page import="board.BoardWriteMgr"%>
<%@page import="board.BoardWriteBean"%>
<%@page import="java.util.Vector"%>
<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:useBean id="mgr" class="board.BoardWriteMgr" />

<%

	String board_id = request.getParameter("board_id");
	String UserId = (String) session.getAttribute("idKey"); // 현재 로그인한 사용자 ID
	
	int currentPage = 1; // 기본값은 1페이지
	int entriesPerPage = 12; // 한 페이지당 12개의 게시글
	int totalPages = mgr.getTotalPages(board_id); // 총 페이지 수 계산
	if (request.getParameter("page") != null) {
	    currentPage = Integer.parseInt(request.getParameter("page"));
	}

	int startIndex = (currentPage - 1) * entriesPerPage;

    // 모든 게시글을 불러오기
    Vector<BoardWriteBean> boardListAll = mgr.getBoardListByUser(board_id, startIndex, entriesPerPage); 
%>

<% 
    if (boardListAll.size() > 0) {
        for (BoardWriteBean board : boardListAll) { 
        	String formattedDate = "";
            try {
                Timestamp timestamp = Timestamp.valueOf(board.getBoard_at());
                SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
                formattedDate = sdf.format(timestamp);
            } catch (Exception e) {
                formattedDate = board.getBoard_at(); // 이미 String이라면 그대로 사용
            }
%>
        <tr>
            <td><input type="checkbox" name="boardNum" value="<%= board.getBoard_num() %>"></td>
            <td> <span onclick="clickBoard_boardNum('<%= board.getBoard_num() %>')"><%= board.getBoard_title() %></span></td>
            <td><%= board.getBoard_id() %></td>
            <td><%= formattedDate %></td>
            <td><%= board.getBoard_views() %></td>
            
        </tr>
<% 
        }
    } else { 
%> 
    <tr>
            <td colspan="5" style="text-align: center;">등록된 게시물이 없습니다.</td>
    </tr>
<% } %>
<input type ="hidden" id ="boardList_totalPages" name ="boardList_totalPages" value =<%=totalPages %>>
<script>
    // 조회수 증가와 게시글 보기로 이동하는 함수
    function clickBoard_boardNum(boardNum) {
        var xhr = new XMLHttpRequest();
        xhr.open("POST", "../seyoung/increaseBoardViews.jsp", true); // 조회수 증가 JSP 파일 호출
        xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");

        xhr.onreadystatechange = function () {
            if (xhr.readyState === 4 && xhr.status === 200) {
                // 조회수 업데이트
                var response = xhr.responseText.trim();
                document.getElementById("views-" + boardNum).innerText = response; // 조회수 업데이트
                
                
            }
        };

        // 조회수 증가 요청을 서버로 전송
        xhr.send("boardNum=" + encodeURIComponent(boardNum));
    }
</script>