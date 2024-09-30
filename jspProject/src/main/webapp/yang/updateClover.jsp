<%@page import="pjh.MemberMgr"%>
<%@page import="java.io.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<jsp:useBean id="mgr" class="pjh.MemberMgr" />
<%
String userId = request.getParameter("userId");
int cloverAmount = Integer.parseInt(request.getParameter("cloverAmount"));
boolean updateSuccess = false;

try {
    // 클로버 잔액 업데이트
    updateSuccess = mgr.updateCloverBalance(userId, cloverAmount);
} catch (Exception e) {
    e.printStackTrace();
}

int newCloverAmount = 0;
if (updateSuccess) {
    try {
        // 업데이트 후 새로운 클로버 잔액을 가져옴
        newCloverAmount = mgr.getCloverBalance(userId);
    } catch (Exception e) {
        e.printStackTrace();
    }
}

response.setContentType("text/plain");
response.getWriter().write(String.valueOf(newCloverAmount));  // 새로운 클로버 잔액 반환
%>
