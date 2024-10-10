<%@ page import="java.sql.*, music.MusicMgr" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    String user_id = request.getParameter("user_id");
    String item_name = request.getParameter("item_name");
    String playlist = request.getParameter("playlist");

    // MusicMgr 인스턴스 생성
    MusicMgr mgr = new MusicMgr();

    try {
        mgr.deleteMusicFromPlaylist(user_id, item_name, playlist);
    } catch (Exception e) {
        out.print("삭제 중 오류가 발생했습니다.");
        e.printStackTrace();
    }
%>
