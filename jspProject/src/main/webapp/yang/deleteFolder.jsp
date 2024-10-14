<%@ page import="music.MusicMgr" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%

	request.setCharacterEncoding("UTF-8");
    String userId = request.getParameter("userId");
    String playlist = request.getParameter("playlist");

    if (userId != null && playlist != null) {
        MusicMgr mgr = new MusicMgr();
        boolean result = mgr.deleteFolder(userId, playlist); // MusicMgr의 deleteFolder 메소드 호출

        if (result) {
            out.print("success");
        } else {
            out.print("failure");
        }
    } else {
        out.print("failure"); // userId 또는 playlist 값이 없으면 실패
    }
%>
