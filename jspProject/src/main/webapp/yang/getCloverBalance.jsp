<%@ page import="java.sql.*, pjh.MemberMgr, pjh.DBConnectionMgr"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:useBean id="mgr" class="pjh.MemberMgr" />
<%
    String user_id = request.getParameter("userId"); // 요청으로부터 user_id를 가져옴
    int cloverAmount = 0;
    
    if (user_id != null) {
        try {
            // 클로버 잔액을 조회하는 로직 (MemberMgr 클래스에서 클로버 잔액 가져옴)
            cloverAmount = mgr.getCloverBalance(user_id); // 클로버 잔액을 DB에서 가져옴
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    
    // 클로버 잔액을 응답으로 반환
    out.print(cloverAmount);
%>
