<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="board.BoardWriteBean" %>
<%@ page import="board.BoardWriteMgr" %>
<jsp:useBean id="mgr" class="board.BoardWriteMgr" />
<jsp:useBean id="Bean" class="board.BoardWriteBean" />
<%

	//현재 로그인한 사용자 ID 가져오기
	String userId = (String) session.getAttribute("idKey");

    // 최신 게시글 불러오기
    BoardWriteBean latestBoard = mgr.getLatestBoard();
%>

<%if (latestBoard != null && userId != null && userId.equals(latestBoard.getBoard_id())) { %>
    <!-- 제목과 작성일을 상단에 배치하고 삭제 버튼 추가 -->
    <div class="bwrite-header" style="display: flex; align-items: center; width: 100%;">
        <h3 ><%= latestBoard.getBoard_title() %></h3>
        <div style="flex-grow: 1; border-bottom: 1px dotted #BAB9AA; margin: 0 10px;"></div>
        <div>
            <span><%= latestBoard.getBoard_at().substring(0, 10) %></span>
            <% if (userId != null && userId.equals(latestBoard.getBoard_id())) { %>
                <button class="latestDel-btn" onclick="bdellatestPost(<%= latestBoard.getBoard_num() %>)">삭제</button>
            <% } %>
        </div>
    </div>

    <!-- 이미지가 있을 경우 표시 -->
    <% if (latestBoard.getBoard_image() != null && !latestBoard.getBoard_image().isEmpty()) { %>
        <div style="text-align: center; margin-top: 10px;">
            <img src="<%=Bean.getBoard_image()%>"   style="width: 300px; height: 200px; border: 1px solid #CCC; padding: 5px;">
        </div>
    <% } %>
    <!-- 내용 부분 -->
    <div id=<%=latestBoard.getBoard_num()%> class="bwrite-content">
        <%= latestBoard.getBoard_content() %>
    </div>
<% } else { %>
    <p>작성한 게시글이 없습니다.</p>
<% } %>