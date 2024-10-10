<%@ page import="java.sql.*, music.MusicMgr" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    String user_id = request.getParameter("user_id");
    String item_name = request.getParameter("item_name");

    // MusicMgr 인스턴스 생성
    MusicMgr mgr = new MusicMgr();

    try {
        // user_id와 item_name을 사용하여 음악 삭제 메소드 호출
        mgr.deleteMusicByUserIdAndItemName(user_id, item_name);
    } catch (Exception e) {
        out.print("삭제 중 오류가 발생했습니다.");
        e.printStackTrace();
    }
%>
