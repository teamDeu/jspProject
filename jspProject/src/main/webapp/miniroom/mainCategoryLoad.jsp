<%@page import="Category.CategoryMgr"%>
<%@page import="Category.CategoryBean"%>
<%@page import="java.util.List"%>
<%@page import="java.util.HashMap"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:useBean id="iMgr" class ="miniroom.ItemMgr"/>
<jsp:useBean id="mMgr" class ="pjh.MemberMgr"/>
<jsp:useBean id="fMgr" class ="friend.FriendMgr"/>
<jsp:useBean id="profileMgr" class ="guestbook.GuestbookprofileMgr"/>
<%
	CategoryMgr categoryMgr = new CategoryMgr();
	String id = (String)session.getAttribute("idKey");
	String pageOwnerId = request.getParameter("url");
	List<CategoryBean> categoryList = categoryMgr.getAllCategoriesByUserId(pageOwnerId);
	HashMap<String,String> categoryType = new HashMap<String,String>();
	categoryType.put("홈","chatBox");
	categoryType.put("프로필","profile");
	categoryType.put("미니룸","inner-box-2-miniroom");
	categoryType.put("방명록","guestbook");
	categoryType.put("게시판","board");
	categoryType.put("음악","music");
	categoryType.put("상점","store");
	categoryType.put("게임","game");
	String firstCategory = null;
	boolean isFriend = fMgr.isRealFriend(id, pageOwnerId);
	for(int i = 0 ; i < categoryList.size() ; i ++){ 
	CategoryBean cBean = categoryList.get(i);
	if(i == 0){
		firstCategory = categoryType.get(cBean.getCategoryType());
		
	}
%>
<%if((fMgr.isRealFriend(pageOwnerId, id) && cBean.getCategorySecret() == 1)|| cBean.getCategorySecret() == 0 || id.equals(pageOwnerId)) {
         	if(!cBean.getCategoryType().equals("미니룸") || id.equals(pageOwnerId)){%>
            <button <%if(i == 0){ %>style = "background-color :#F7F7F7" <%} %> onclick = "javascript:clickOpenBox('<%=categoryType.get(cBean.getCategoryType()) %>')" class="custom-button" id ="custom-button-<%=categoryType.get(cBean.getCategoryType())%>"><%=cBean.getCategoryName()%></button>
<%}}} %>