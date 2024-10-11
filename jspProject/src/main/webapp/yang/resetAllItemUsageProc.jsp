
<%@ page import="music.MusicBean"%>
<%@ page import="music.MusicMgr"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    String user_id = request.getParameter("user_id");
    MusicMgr mgr = new MusicMgr();  // MusicMgr 객체 생성
    mgr.resetAllItemUsage(user_id);  // 해당 사용자의 item_using을 모두 0으로 설정하는 메소드 호출
    out.print("모든 아이템 사용 상태가 초기화되었습니다.");
%>
