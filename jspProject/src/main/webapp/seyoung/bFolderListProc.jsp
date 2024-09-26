<%@page import="java.util.Vector"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="board.BoardFolderBean"%>
<%@page import="board.BoardFolderMgr"%>  
<jsp:useBean id="mgr" class ="board.BoardFolderMgr"/>
<jsp:useBean id="bean" class ="board.BoardFolderBean"/>   


<%
    // 클라이언트에서 전달된 user_id 파라미터를 가져옴
    String user_id = request.getParameter("user_id");

    // user_id가 null이 아니고 비어있지 않을 때만 처리
    if (user_id != null && !user_id.trim().isEmpty()) {
        BoardFolderMgr folderMgr = new BoardFolderMgr(); // BoardFolderMgr 인스턴스 생성
        Vector<BoardFolderBean> folderList = folderMgr.getFolderList(user_id); // user_id에 해당하는 폴더 목록 가져오기

        // 폴더 목록을 JSON 형식으로 변환하여 반환
        StringBuilder json = new StringBuilder("[");
        for (int i = 0; i < folderList.size(); i++) {
            BoardFolderBean folder = folderList.get(i);
            json.append("{")
                .append("\"folder_num\":").append(folder.getFolder_num()).append(",")
                .append("\"folder_name\":\"").append(folder.getFolder_name()).append("\"")
                .append("}");
            if (i < folderList.size() - 1) {
                json.append(","); // 마지막 요소 뒤에는 쉼표를 추가하지 않음
            }
        }
        json.append("]");

        out.print(json.toString()); // JSON 문자열을 출력
    } else {
        out.print("[]"); // user_id가 없으면 빈 배열 반환
    }
%>