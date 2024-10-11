<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="pjh.MemberMgr"%>
<%@page import="pjh.MemberBean"%>
<%
    String id = (String)session.getAttribute("idKey");
    if(id != null) {
        MemberMgr memberMgr = new MemberMgr();
        MemberBean user = memberMgr.getMember(id);
        int cloverBalance = user.getUser_clover();
        out.print(cloverBalance); // 클로버 잔액을 클라이언트로 전달
    }
%>
