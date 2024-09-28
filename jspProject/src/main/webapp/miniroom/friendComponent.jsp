<%@page import="friend.UtilMgr"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String profileImg = request.getParameter("profileImg");
	String profileName = request.getParameter("profileName");
	String profileId = request.getParameter("profileId");
	String type = null;
	if(UtilMgr.parseInt(request, "type") == 2){
		type = "friends_type_second";
	}
	else{
		type = "friends_type_first";
	}
%>
<script>
	function onclickMainProfileFriendsDiv(event){
		let profileFunctionMain = event.querySelector(".profile_function_div_main")
		console.log(profileFunctionMain);
		if(profileFunctionMain.style.display == "none"){
			profileFunctionMain.style.display = "flex";
		}
		else{
			profileFunctionMain.style.display = "none";
		}
	}
</script>
<div onclick = "onclickMainProfileFriendsDiv(this)" class ="main_profile_friends_div <%=type%>">
	<div>
		<jsp:include page="profileFunctionDiv.jsp">
			<jsp:param value="<%=profileId%>" name="profileId"/>
		</jsp:include>
	</div>
	<img class ="main_profile_friends" src="<%=profileImg%>"> <span class ="main_profile_friends_name"><%=profileName%></span>
</div>
</body>
