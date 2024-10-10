<%@ page import="java.util.Vector" %>
<%@ page import="music.MusicMgr" %>
<%@ page import="music.MusicBean" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


<%
    String playlist = request.getParameter("playlist");
    String item_name = request.getParameter("item_name");
    String user_id = request.getParameter("user_id");

    if (playlist != null && item_name != null && user_id != null) {
        MusicMgr mgr = new MusicMgr();
        try {
            // 해당 플레이리스트의 음악 목록 가져오기
            Vector<MusicBean> musicList = mgr.getMusicListByPlaylist(user_id, playlist);
            boolean isDuplicate = false;

            // 중복 검사: 플레이리스트의 각 음악과 새로 추가할 item_name을 비교
            for (MusicBean music : musicList) {
                if (music.getItem_name().equals(item_name)) {
                    isDuplicate = true;
                    break;
                }
            }

            if (isDuplicate) {
                out.print("'"+playlist+"'에 이미 존재하는 노래입니다.");
            } else {
                // 중복되지 않은 경우에만 음악 추가
                mgr.addMusicToPlaylist(playlist, item_name, user_id);
                out.print("'"+playlist+"'에 '"+item_name+"'이 성공적으로 플레이리스트에 추가되었습니다.");
            }
        } catch (Exception e) {
            e.printStackTrace();
            out.print("음악 추가에 실패했습니다.");
        }
    } else {
        out.print("필요한 정보가 부족합니다.");
    }
%>
