<%@page import="guestbook.GuestbookprofileBean"%>
<%@page import="guestbook.GuestbookprofileMgr"%>
<%@page import="miniroom.ItemMgr"%>
<%@page import="friend.UserSearchBean"%>
<%@page import="java.util.Vector"%>
<%@page import="friend.FriendMgr"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String connectId = (String)session.getAttribute("idKey");
	String user_search_name = request.getParameter("user_search_name");
	FriendMgr fMgr = new FriendMgr();
	Vector<UserSearchBean> vlist = fMgr.searchUser(user_search_name);
	GuestbookprofileMgr gMgr = new GuestbookprofileMgr();
	ItemMgr iMgr = new ItemMgr();
%>
<%
if(vlist.size() > 0){
	for (int i = 0 ; i < vlist.size() ; i ++){ 
		UserSearchBean userBean = vlist.get(i);
		String user_id = userBean.getUser_id();
		String user_name = userBean.getUser_name();
		String profile_name = userBean.getProfile_name();
		String user_character = iMgr.getUsingCharacter(user_id).getItem_path();
		GuestbookprofileBean profileBean = gMgr.getProfileByUserId(userBean.getUser_id());
		String profile_img = profileBean.getProfilePicture();
%>
<div class="user_search_output_items">
			<div class="user_search_output_info_div">
				<div class="user_search_output_info_profile_img_box">
					<img class="user_search_output_info_profile_img"
						src="<%=profile_img%>">
				</div>
				<div class="user_search_output_info_profile_text">
					<%=user_id %>(<%=profile_name %>) <%=user_name %></div>
			</div>
			<div class="user_search_output_function_div">
				<%if(fMgr.isFriend(connectId,user_id)){ %>
				<button disabled>친구사이</button>
			<%}else{ %>
			<button onclick="onclickAddFriend('<%=connectId%>','<%=user_id%>','<%=user_character%>','<%=user_name%>')">친구추가</button>
			<%} %>
			<button onclick="onclickGoHomePage('<%=user_id%>')">미니룸 구경가기</button>
			</div>
</div>
<%}}else{%>
	<h3 align = center >검색결과가 존재하지않습니다.</h3>
<%}%>