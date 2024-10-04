<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="mypage.MypageMgr, mypage.MypageBean" %>

<%
    String userId = (String) session.getAttribute("userId");
    MypageMgr mgr = new MypageMgr();
    MypageBean bean = mgr.getUserInfo(userId);
%>

<% if (bean != null) { %>
    <!-- 아이디도 input 요소로 표시하여 다른 필드와 동일한 디자인 적용 -->
    아이디: <input type="text" name="userIdDisplay" value="<%= bean.getUserId() %>" readonly><br>
    
    <!-- 수정 가능한 다른 정보 -->
    이름: <input type="text" name="userName" value="<%= bean.getUserName() %>" readonly><br>
    이메일: <input type="email" name="userEmail" value="<%= bean.getUserEmail() %>" readonly><br>
    생일: <input type="date" name="userBirth" value="<%= bean.getUserBirth() %>" readonly><br>
    전화번호: <input type="text" name="userPhone" value="<%= bean.getUserPhone() %>" readonly><br>
    
    <!-- hidden 필드로 userId를 수정 불가능하게 전송 -->
    <input type="hidden" name="userId" value="<%= bean.getUserId() %>">
<% } else { %>
    <p>사용자 정보를 찾을 수 없습니다.</p>
<% } %>
