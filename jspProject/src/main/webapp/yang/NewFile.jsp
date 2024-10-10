<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="music.MusicMgr"%>
<%
    MusicMgr mgr = new MusicMgr();
    
    // 테스트로 "지플리" 플레이리스트에 "에픽하이-우산"을 "2222" 유저 아이디로 추가
    String playlist = "지플리";
    String item_name = "에픽하이-우산";
    String user_id = "2222";

    try {
        mgr.addMusicToPlaylist(playlist, item_name, user_id);
        out.println("음악이 성공적으로 플레이리스트에 추가되었습니다.");
    } catch (Exception e) {
        e.printStackTrace();
        out.println("음악 추가에 실패했습니다.");
    }
%>
