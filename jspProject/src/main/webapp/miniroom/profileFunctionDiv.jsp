<%@page import="guestbook.GuestbookprofileBean"%>
<%@page import="friend.FriendMgr"%>
<%@page import="miniroom.ItemMgr"%>
<%@page import="pjh.MemberBean"%>
<%@page import="pjh.MemberMgr"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<jsp:useBean id="profileMgr" class ="guestbook.GuestbookprofileMgr"/>
<%
	String connectId = (String) session.getAttribute("idKey");
	if (connectId == null) {
		response.sendRedirect("../pjh/login.jsp");
		return;
	}
	String type = request.getParameter("type");
	MemberMgr mgr = new MemberMgr();
	ItemMgr imgr = new ItemMgr();
	FriendMgr fmgr = new FriendMgr();
	String profileId = request.getParameter("profileId");
	MemberBean user = mgr.getMember(profileId);
	String name = user.getUser_name();
	String userId = user.getUser_id();
	String userCharacter = imgr.getUsingCharacter(userId).getItem_path();
	GuestbookprofileBean profileBean = profileMgr.getProfileByUserId(userId);
	name = profileBean.getProfileName();
%>
<!DOCTYPE html>
<html>
<head>
<script>

	</script>
<style>
.profile_function_div_main{
	display:none;
}	
</style>
</head>
<div class="profile_function_div_main" style ="display : none">
	<div class="profile_function_div <%if(type != null) {%>profile_function_div_<%=type%><%}%>">
		<span><%=name%></span>
		<%if(fmgr.isFriend(connectId,userId)){ %>
			<button onclick = "onclickDeleteFriend('<%=connectId %>','<%=userId%>','<%=name%>')">친구삭제</button>
		<%}else{ %>
		<button onclick="onclickAddFriend('<%=connectId%>','<%=userId%>','<%=userCharacter%>','<%=name%>')">친구추가</button>
		<%} %>
		<button onclick="onclickGoHomePage('<%=userId%>')">미니룸 구경가기</button>
	</div>
</div>
</html>