<%@page import="friend.FriendInfoBean"%>
<%@page import="java.util.Vector"%>
<%@page import="miniroom.UtilMgr"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="board.BoardWriteBean" %>
<%@ page import="board.BoardWriteMgr" %>
<jsp:useBean id="mgr" class="board.BoardWriteMgr" />
<jsp:useBean id="fmgr" class="friend.FriendMgr" />
<jsp:useBean id="bFmgr" class="board.BoardFolderMgr"/>
<jsp:useBean id="Bean" class="board.BoardWriteBean" />
<%

	//현재 로그인한 사용자 ID 가져오기
	String userId = (String) session.getAttribute("idKey");
    String board_id = request.getParameter("board_id");
	String type = request.getParameter("type");
	
	
	BoardWriteBean latestBoard = null;
	if(type.equals("latest")){
		latestBoard = mgr.getLatestBoard(board_id);
	}
	else if(type.equals("get")){
		int board_num = UtilMgr.parseInt(request, "board_num");
		latestBoard = mgr.getBoard(board_num);	
	}

	

	// 친구 관계 및 게시물 보기 권한 확인
    boolean canView = false;
    if (latestBoard != null) {
        // 게시글 작성자는 항상 자신의 게시글을 볼 수 있도록 함
        if (userId.equals(latestBoard.getBoard_id())) {
            canView = true;
        } 
        // 게시글이 공개된 상태이거나 친구 관계에 따라 접근 허용 여부 결정
        else if (latestBoard.getBoard_visibility() == 0) {
            canView = true; // 공개 게시물
        } else if (latestBoard.getBoard_visibility() == 1) {
            boolean friendStatus = fmgr.isFriend(userId, latestBoard.getBoard_id());
            if (friendStatus) {
                // 친구 관계 확인 후 friend_type이 1인지 추가 확인
                Vector<FriendInfoBean> friendList = fmgr.getFriendList(userId);
                for (FriendInfoBean friend : friendList) {
                	if ((friend.getUser_id1().equals(userId) && friend.getUser_id2().equals(latestBoard.getBoard_id()) && friend.getFriend_type() == 1) || 
                       (friend.getUser_id2().equals(userId) && friend.getUser_id1().equals(latestBoard.getBoard_id()) && friend.getFriend_type() == 1)) {
                       canView = true;
                       break;
                   }
                }
            }
        }
    }

%>
<!-- 제목과 작성일을 상단에 배치하고 삭제 버튼 추가 -->
    <input type="hidden" id="answerTypeValue" value="<%= latestBoard.getBoard_answertype() %>">
<% 

if (latestBoard != null && canView) { 
%>
    
    <div class="bwrite-header" style="display: flex; align-items: center; width: 100%;">
    	<input type="hidden" id = "latestBoard_folderName" value ="<%=bFmgr.getFolderInfo(latestBoard.getBoard_folder()).getFolder_name()%>">
        <h3><%= latestBoard.getBoard_title() %></h3>
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
            <img alt="" src="<%=latestBoard.getBoard_image()%>"   style="width: 300px; height: 200px; border: 1px solid #CCC; padding: 5px;">
        </div>
    <% } %>
    <!-- 내용 부분 -->
    <div id=<%=latestBoard.getBoard_num()%> class="bwrite-content">
        <%= latestBoard.getBoard_content() %>
    </div>

<% } else if (latestBoard != null && !canView) { %>
    <!-- 권한이 없을 경우 -->
    <p>이 게시글을 볼 수 있는 권한이 없습니다.</p>
<% } else { %>
    <p>작성한 게시글이 없습니다.</p>
<% } %>




