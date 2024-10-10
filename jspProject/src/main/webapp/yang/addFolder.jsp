<%@ page import="music.MusicBean"%>
<%@ page import="music.MusicMgr"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
    String folderName = request.getParameter("folderName");
    String userId = request.getParameter("userId");

    if (folderName != null && userId != null) {
        MusicMgr mgr = new MusicMgr();
        MusicBean folder = new MusicBean();
        folder.setUser_id(userId);
        folder.setPlaylist(folderName);

        // 폴더를 추가하는 메소드 호출
        boolean result = mgr.addFolder(folder);

        if (result) {
            out.print("success"); // 성공 메시지
        } else {
            out.print("failure"); // 실패 메시지
        }
    } else {
        out.print("failure"); // 폴더명이나 사용자 ID가 null인 경우
    }
%>

