<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%> 
<%@page import="board.BoardFolderBean"%>
<%@page import="board.BoardFolderMgr"%>  
<jsp:useBean id="mgr" class ="board.BoardFolderMgr"/>
<jsp:useBean id="bean" class ="board.BoardFolderBean"/>    

<%
    // 폴더 추가 결과 메시지
    String result = "fail";

    // 폴더명과 사용자 ID를 파라미터로 받음
    String folderName = request.getParameter("folderName");
    String userId = request.getParameter("user_id");

    // 파라미터 유효성 검사
    if (folderName != null && !folderName.trim().isEmpty() && userId != null) {
        BoardFolderMgr folderMgr = new BoardFolderMgr();
        BoardFolderBean folderBean = new BoardFolderBean();
        
        folderBean.setUser_id(userId);
        folderBean.setFolder_name(folderName.trim());
        
        // 폴더 추가
        if (folderMgr.addFolder(folderBean)) {
            result = "success";
        }
    }

    // 결과 반환
    out.print(result);
%>
