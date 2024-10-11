
<%@ page import="music.MusicBean"%>
<%@ page import="music.MusicMgr"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    String user_id = request.getParameter("user_id");
    String item_path = request.getParameter("item_path");
    MusicMgr mgr = new MusicMgr();  // MusicMgr 객체 생성
    mgr.updateSingleItemUsage(user_id, item_path);  // 해당 노래의 item_using을 1로 설정하는 메소드 호출
    out.print("아이템이 업데이트되었습니다.");
%>
