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
	<%if(latestBoard != null){%>
		<input type="hidden" id="answerTypeValue" value="<%= latestBoard.getBoard_answertype() %>">
	<%} %>
    
<% 

if (latestBoard != null && canView) { 
%>
    
    <div class="bwrite-header" id="bwriteHeader_<%= latestBoard.getBoard_num() %>" style="display: flex; align-items: center; width: 100%;">
    	<input type="hidden" id="latestBoard_folderName" value="<%=bFmgr.getFolderInfo(latestBoard.getBoard_folder()).getFolder_name()%>">
        <h3 id="boardTitle_<%= latestBoard.getBoard_num() %>"><%= latestBoard.getBoard_title() %></h3>
        <div style="flex-grow: 1; border-bottom: 1px dotted #BAB9AA; margin: 0 10px;"></div>
        <div>
            
             <span id="boardAt"><%= latestBoard.getBoard_at().substring(0, 10) %></span>

            <% if (userId != null && userId.equals(latestBoard.getBoard_id())) { %>
            	<button class="latestEdit-btn" onclick="beditlatestPost(<%= latestBoard.getBoard_num() %>)">수정</button>	
                <button class="latestDel-btn" onclick="bdellatestPost(<%= latestBoard.getBoard_num() %>)">삭제</button>
            <% } %>
        </div>
    </div>
	<%
	    // 게시물 작성일과 수정일을 각각 가져오기
	    String boardAt = latestBoard.getBoard_at() != null ? latestBoard.getBoard_at().substring(0, 10) : "";
	    String boardUpdatedAt = latestBoard.getBoard_updated_at() != null ? latestBoard.getBoard_updated_at().substring(0, 10) : "";;  // 수정된 날짜
	    

	    System.out.println("boardUpdatedAt: " + boardUpdatedAt);  // 콘솔에 출력하여 디버깅
	    System.out.println("boardAt: " + boardAt);  // 콘솔에 출력하여 디버깅
	
	    // 수정된 게시물인 경우 수정된 날짜를 올바르게 표시
	    if (!boardUpdatedAt.isEmpty()) {
	        
	%>
	        <div class="modified-info" id="modifiedInfo_<%= latestBoard.getBoard_num() %>" style="margin-top: 5px; color: gray;">
	            <p>수정된 게시물 (수정 날짜: <%= boardUpdatedAt %>)</p>
	        </div>
	<%
	    }
	%>
	

    <!-- 이미지가 있을 경우 표시 -->
    <% if (latestBoard.getBoard_image() != null && !latestBoard.getBoard_image().isEmpty()) { %>
        <div style="text-align: center; margin-top: 10px;" id="boardImageContainer_<%= latestBoard.getBoard_num() %>">
            <img id="boardImage_<%= latestBoard.getBoard_num() %>" src="<%=latestBoard.getBoard_image()%>" style="width: 300px; height: 200px; border: 1px solid #CCC; padding: 5px;">
        </div>
    <% } %>
    
    
    <!-- 내용 부분 -->
    <div id="<%= latestBoard.getBoard_num() %>" class="bwrite-content">
        <%= latestBoard.getBoard_content() %>
    </div>

    <!-- 수정 폼 추가 -->
    <form id="editForm_<%= latestBoard.getBoard_num() %>" style="display: none; margin-top: 0px;" enctype="multipart/form-data" method="post">
        <input type="hidden" name="board_num" id="editBoardNum_<%= latestBoard.getBoard_num() %>">
         
        <div class="bwrite-header2" style="display: flex; align-items: center; width: 100%;">
            <!-- 제목 필드 -->
            <input type="text" name="board_title" id="editBoardTitle_<%= latestBoard.getBoard_num() %>" value="<%= latestBoard != null ? latestBoard.getBoard_title() : "" %>" >
            
            <!-- dotted line -->
            <div style="flex-grow: 1; border-bottom: 1px dotted #BAB9AA; margin: 0 10px;"></div>
            
            <!-- 버튼 -->
            <button class="submitbtn" type="button" onclick="submitEdit(<%= latestBoard.getBoard_num() %>)" >저장</button>
            <button class="canclebtn" type="button" onclick="cancelEdit(<%= latestBoard.getBoard_num() %>)" >취소</button>
        </div>
        
        
        
        <textarea name="board_content" id="editBoardContent_<%= latestBoard.getBoard_num() %>" rows="8" cols="130" 
        style="width: 100%; font-size: 20px; margin-top: 22px; margin-left: 8px; border: none; background-color: #f7f7f7;"><%= latestBoard != null ? latestBoard.getBoard_content() : "" %></textarea><br>

        <!-- 이미지 수정 부분 -->	    
	    <input type="file" name="board_image" id="editBoardImage_<%= latestBoard.getBoard_num() %>" style="display: none;" onchange="updateImageName(<%= latestBoard.getBoard_num() %>)">
	    <label for="editBoardImage_<%= latestBoard.getBoard_num() %>" style="cursor: pointer; display: inline-block; border: 1px solid #CCC; padding: 5px; text-align: center; width: 120px; margin-left: 10px;">
		    <img id="editBoardImagePreview_<%= latestBoard.getBoard_num() %>" src="../seyoung/img/photo-icon.png" style="width: 24px; height: 24px; vertical-align: middle;">
		    <span  style="vertical-align: middle;">사진</span>
		</label>

		<span id="imageName_<%= latestBoard.getBoard_num() %>">
			<% if (latestBoard.getBoard_image() != null && !latestBoard.getBoard_image().isEmpty()) { %>
		        <%= latestBoard.getBoard_image().substring(latestBoard.getBoard_image().lastIndexOf("/") + 1) %> <!-- 이미지 파일명만 표시 -->
		    <% } %>
		</span>     
    </form>

<% } else if (latestBoard != null && !canView) { %>
    <p>이 게시글을 볼 수 있는 권한이 없습니다.</p>
<% } else { %>
    <p>작성한 게시글이 없습니다.</p>
<% } %>

